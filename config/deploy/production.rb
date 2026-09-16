server ENV.fetch("EC2_HOST"),
       user: "deploy",
       roles: %w[web app db],
       ssh_options: {
         keys: [
           ENV.fetch(
             "EC2_KEY",
             File.expand_path("~/.ssh/blog-app-key.pem")
           )
         ],
         auth_methods: %w[publickey],
         forward_agent: false
       }