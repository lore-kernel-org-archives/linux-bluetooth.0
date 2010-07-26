Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Jul 2010 12:33:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhenhua Zhang <zhenhua.zhang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] watch: Free service data in service_reply
Message-ID: <20100726093354.GA20357@jh-x301>
References: <1280106672-4796-1-git-send-email-zhenhua.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280106672-4796-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 26, 2010, Zhenhua Zhang wrote:
> Avoid the memory leak of server_data.
> ---
>  gdbus/watch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 1d479fa..29f23e2 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -533,7 +533,7 @@ static void check_service(DBusConnection *connection, const char *name,
>  		goto done;
>  	}
>  
> -	dbus_pending_call_set_notify(call, service_reply, data, NULL);
> +	dbus_pending_call_set_notify(call, service_reply, data, g_free);
>  
>  	dbus_pending_call_unref(call);

Thanks for the updated patch. It has now been pushed both to bluez and
obexd upstream trees with a fixed commit message (e.g. your summary line
was not truthful anymore since the data isn't being freed in
service_reply but by libdbus itself.

Johan
