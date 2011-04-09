Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Apr 2011 10:35:53 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix setting of mode after discovery times out.
Message-ID: <20110409173553.GC26311@jh-x301>
References: <1302050692-24497-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302050692-24497-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Tue, Apr 05, 2011, Jaikumar Ganesh wrote:
> diff --git a/src/adapter.c b/src/adapter.c
> index c400bfd..014cc0c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -156,6 +156,8 @@ struct btd_adapter {
>  
>  static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
>  					guint interval);
> +static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
> +				gboolean discoverable, void *data);
>  
>  static int found_device_cmp(const struct remote_dev_info *d1,
>  			const struct remote_dev_info *d2)
> @@ -374,7 +376,7 @@ static gboolean discov_timeout_handler(gpointer user_data)
>  
>  	adapter->discov_timeout_id = 0;
>  
> -	adapter_ops->set_discoverable(adapter->dev_id, FALSE);
> +	set_discoverable(NULL, NULL, FALSE, user_data);
>  
>  	return FALSE;

I don't think it's appropriate to reuse set_discoverable here since it's
a D-Bus method callback. It can e.g. result in passing the DBusMessage
parameter to btd_error_failed which might cause a crash with a NULL
pointer. I think duplicating some code from set_discoverable would make
more sense, either within discov_timeout_handler or as a separate static
function.

Johan
