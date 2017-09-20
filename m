Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170920125445.24792-2-hadess@hadess.net>
Date: Wed, 20 Sep 2017 17:48:52 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
References: <20170920125445.24792-1-hadess@hadess.net>
 <20170920125445.24792-2-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> The hostname plugin listens to property changes from systemd-hostnamed
> but doesn't fetch initial values. This means that unless the
> PrettyHostname or StaticHostname changes, the default adapter will be
> called "BlueZ 5.XX" matching the version number.
> 
> This is the case since the hostname plugin replaced the adaptername
> plugin in 2012.
> 
> Fetch the initial values for PrettyHostname, StaticHostname and
> Chassis when the plugin is initiated, so as to make the values
> available for adapter setup.
> ---
> plugins/hostname.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/plugins/hostname.c b/plugins/hostname.c
> index f876d0afb..db9187378 100644
> --- a/plugins/hostname.c
> +++ b/plugins/hostname.c
> @@ -307,6 +307,10 @@ static int hostname_init(void)
> 		hostname_proxy = NULL;
> 		g_dbus_client_unref(hostname_client);
> 		hostname_client = NULL;
> +	} else {
> +		g_dbus_proxy_refresh_property(hostname_proxy, "PrettyHostname");
> +		g_dbus_proxy_refresh_property(hostname_proxy, "StaticHostname");
> +		g_dbus_proxy_refresh_property(hostname_proxy, "Chassis");
> 	}

I am 100% certain that I tested this since this would be a really dumb plugin otherwise. However is it possible that when calling GetManagedObjects the values are not returned correctly? Can we check that. Or does the property watch has an issue not calling the callback correctly.

Regards

Marcel

