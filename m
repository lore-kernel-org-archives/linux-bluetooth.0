Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Jul 2010 22:52:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhenhua Zhang <zhenhua.zhang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] watch: Free service data in service_reply
Message-ID: <20100725195250.GA17003@jh-x301>
References: <1279964787-3989-1-git-send-email-zhenhua.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279964787-3989-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jul 24, 2010, Zhenhua Zhang wrote:
> Avoid the memory leak of server_data.
> ---
>  gdbus/watch.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 1d479fa..ccdbb64 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -468,8 +468,10 @@ static void service_reply(DBusPendingCall *call, void *user_data)
>  	dbus_bool_t has_owner;
>  
>  	reply = dbus_pending_call_steal_reply(call);
> -	if (reply == NULL)
> +	if (reply == NULL) {
> +		g_free(data);
>  		return;
> +	}
>  
>  	dbus_error_init(&error);
>  
> @@ -490,6 +492,7 @@ static void service_reply(DBusPendingCall *call, void *user_data)
>  
>  done:
>  	dbus_message_unref(reply);
> +	g_free(data);
>  }
>  
>  static void check_service(DBusConnection *connection, const char *name,

Thanks for the patch, but wouldnt't the following be simpler:

--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -533,7 +533,7 @@ static void check_service(DBusConnection *connection, const char *name,
 		goto done;
 	}
 
-	dbus_pending_call_set_notify(call, service_reply, data, NULL);
+	dbus_pending_call_set_notify(call, service_reply, data, g_free);
 
 	dbus_pending_call_unref(call);
 

Johan
