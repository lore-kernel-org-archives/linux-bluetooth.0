Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Oct 2012 11:30:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v8 1/8] core: Mutually exclude concurrent
 connections
Message-ID: <20121002083056.GB1969@x220>
References: <1349126651-749-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349126651-749-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 01, 2012, João Paulo Rechi Vita wrote:
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
> +	adapter->waiting_to_connect--;
> +
> +	io = device_att_connect(device);
> +	g_io_add_watch(io, G_IO_OUT | G_IO_ERR, clean_connecting_state,
> +						btd_device_ref(device));

Looks like there is some error handling missing here since
device_att_connect could return NULL;

> +		g_idle_add(connect_pending_cb,  btd_device_ref(device));

Two spaces after the comma here. What's a bit worrying also is that you
don't store the idle id, but I suppose that's safe since you ensure that
this asynchronous operation has it's own reference to the device.

Johan
