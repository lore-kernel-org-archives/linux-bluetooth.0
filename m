Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] policy: Add AutoEnable config option
Date: Mon, 28 Sep 2015 20:32:36 +0200
Message-ID: <19248145.cpZjDu9CcL@ix>
In-Reply-To: <1442958169-8453-1-git-send-email-szymon.janc@gmail.com>
References: <1442958169-8453-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 22 September 2015 23:42:49 Szymon Janc wrote:
> This option is used to configure policy for auto enabling adapters when
> found. This includes adapters found on start as well as adapters that
> are plugged in later on.
> 
> This allows distributions to automatically enable adapters in race free
> manner even if no agent is provided eg. in login screen.
> ---
>  plugins/policy.c | 29 +++++++++++++++++++++++++++--
>  src/main.conf    |  5 +++++
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/policy.c b/plugins/policy.c
> index 6bb8268..218a3ed 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -80,6 +80,8 @@ static GSList *reconnects = NULL;
>  static unsigned int service_id = 0;
>  static GSList *devices = NULL;
> 
> +static bool auto_enable = false;
> +
>  struct policy_data {
>  	struct btd_device *dev;
> 
> @@ -743,6 +745,20 @@ static void conn_fail_cb(struct btd_device *dev,
> uint8_t status) reconnect_set_timer(reconnect);
>  }
> 
> +static int policy_adapter_probe(struct btd_adapter *adapter)
> +{
> +	DBG("");
> +
> +	btd_adapter_restore_powered(adapter);
> +
> +	return 0;
> +}
> +
> +static struct btd_adapter_driver policy_driver = {
> +	.name	= "policy",
> +	.probe	= policy_adapter_probe,
> +};
> +
>  static int policy_init(void)
>  {
>  	GError *gerr = NULL;
> @@ -758,7 +774,7 @@ static int policy_init(void)
>  						sizeof(*reconnect_intervals);
>  		reconnect_intervals = g_memdup(default_intervals,
>  						reconnect_intervals_len);
> -		goto add_cb;
> +		goto done;
>  	}
> 
>  	reconnect_uuids = g_key_file_get_string_list(conf, "Policy",
> @@ -788,12 +804,18 @@ static int policy_init(void)
>  						reconnect_intervals_len);
>  	}
> 
> -add_cb:
> +	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
> +									NULL);
> +
> +done:
>  	if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
>  		btd_add_disconnect_cb(disconnect_cb);
>  		btd_add_conn_fail_cb(conn_fail_cb);
>  	}
> 
> +	if (auto_enable)
> +		btd_register_adapter_driver(&policy_driver);
> +
>  	return 0;
>  }
> 
> @@ -812,6 +834,9 @@ static void policy_exit(void)
>  	g_slist_free_full(devices, policy_remove);
> 
>  	btd_service_remove_state_cb(service_id);
> +
> +	if (auto_enable)
> +		btd_unregister_adapter_driver(&policy_driver);
>  }
> 
>  BLUETOOTH_PLUGIN_DEFINE(policy, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> diff --git a/src/main.conf b/src/main.conf
> index 6780d9a..372fd8c 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -82,3 +82,8 @@
>  # If the number of attempts defined in ReconnectAttempts is bigger than the
> # set of intervals the last interval is repeated until the last attempt.
> #ReconnectIntervals=1, 2, 4, 8, 16, 32, 64
> +
> +# AutoEnable defines option to enable all controllers when they are found.
> +# This includes adapters present on start as well as adapters that are
> plugged +# in later on. Defaults to 'false'.
> +#AutoEnable=false

Applied.

-- 
pozdrawiam
Szymon Janc
