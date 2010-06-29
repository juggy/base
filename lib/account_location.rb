module AccountLocation
  def self.included(controller)
    controller.helper_method(:account_domain, :account_subdomain, :account_host, :account_url)
  end
 
  protected
    def default_account_subdomain
      @account.subdomain if @account && @account.respond_to?(:subdomain)
    end
  
    def account_url(account_subdomain = default_account_subdomain, use_ssl = request.ssl?)
      (use_ssl ? "https://" : "http://") + account_host(account_subdomain)
    end
 
    def account_host(account_subdomain = default_account_subdomain)
      account_host = ""
      account_host << account_subdomain + "."
      account_host << account_domain
    end
 
    def account_domain
      account_domain = ""
      account_domain << request.subdomains[1..-1].join(".") + "." if request.subdomains.size > 1
      account_domain << request.domain + request.port_string
    end
    
    def account_subdomain
      request.subdomains.first
    end
end