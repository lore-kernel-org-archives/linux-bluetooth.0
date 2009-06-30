Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 10:36:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] fix bugs in HFP HF role audio part
Message-ID: <20090630073610.GA23086@jh-x301>
References: <1246346181-25864-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246346181-25864-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

A few comments below.

On Tue, Jun 30, 2009, Forrest Zhao wrote:
> +		debug("connection with remote BT is closed\n");

The debug function/macro already takes care of the newline character when
necessary so no need to have it in the call.

>  	if (cond & (G_IO_ERR | G_IO_HUP)) {
> +		debug("sco connection is released\n");
>  		GIOChannel *chan = gw->sco;
> -		g_io_channel_unref(chan);
>  		g_io_channel_close(chan);
>  		gw->sco = NULL;

This looks like it's working around a reference counting bug somewhere
else instead of fixing it. Probably you're doing an incorrect unref
somewhere else which means that gw->sco doesn't actually have its own ref.
Please find the right place and fix it.

>  	gw->sco = g_io_channel_ref(io);
>  
> +	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +                                (GIOFunc) sco_io_cb, dev);
>  	return 0;
>  }

Based on this it looks like the unref of gw->sco when setting it back to
NULL should be perfectly possible. So either you have an incorrect unref
somewhere else or then the removal of the unref is introducing a memory
leak.

>  	if (rfcomm) {
>  		g_io_channel_close(rfcomm);
> -		g_io_channel_unref(rfcomm);
>  		gw->rfcomm = NULL;
>  	}
>  
>  	if (sco) {
>  		g_io_channel_close(sco);
> -		g_io_channel_unref(sco);
>  		gw->sco = NULL;

Again these don't look right. If you can't unref when you clear a pointer
(set it to NULL) then you're not doing the reference counting right.

>  	g_io_channel_close(gw->sco);
> -	g_io_channel_unref(gw->sco);
>  	gw->sco = NULL;

Same here.

Johan
