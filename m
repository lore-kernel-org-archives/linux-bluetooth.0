Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Aug 2012 10:51:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 06/14] core: mutually exclude concurrent
 connections
Message-ID: <20120817075117.GC30060@x220>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
 <1345152524-13404-7-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345152524-13404-7-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 16, 2012, João Paulo Rechi Vita wrote:
> @@ -133,8 +133,10 @@ struct btd_adapter {
> +	GSList *connecting_list;	/* Pending connects */
> +	gboolean connecting;		/* Connect active */

What's the relationship with the above two? Isn't connecting always true
when g_slist_length(connecting_list) > 0 and false when the list is
empty?

>  static gboolean connect_pending_cb(gpointer user_data)
>  {
>  	struct btd_device *device = user_data;
>  	struct btd_adapter *adapter = device_get_adapter(device);
> +	GIOChannel *io;
>  
>  	/* in the future we may want to check here if the controller supports
>  	 * scanning and connecting at the same time */
>  	if (adapter->discovering)
>  		return TRUE;
>  
> -	device_att_connect(device);
> +	if (adapter->connecting)
> +		return TRUE;
> +
> +	adapter->connecting = TRUE;
> +	io = device_att_connect(device);
> +	g_io_add_watch(io, G_IO_OUT | G_IO_ERR, clean_connecting_state,
> +						btd_device_ref(device));
>  
>  	return FALSE;
>  }

Since you're not storing "io" after the function returns you should be
doing a g_io_channel_unref() after calling g_io_add_watch(). Looking at
device_att_connect it seems like it's missing a g_io_channel_ref (either
when assigning to device->att_io or when returning from the function).

> +		adapter->connecting_list = g_slist_append(
> +					adapter->connecting_list, device);
>  

Missing btd_device_unref()?

Johan
