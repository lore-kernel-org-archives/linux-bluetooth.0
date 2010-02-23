Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Feb 2010 10:48:10 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHes] osso-gwobex patches for review
Message-ID: <20100223134810.GA6157@jh-x301>
References: <1266762470.25029.2195.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266762470.25029.2195.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Feb 21, 2010, Bastien Nocera wrote:
> The first patch fixes a few typos.

Yep, looks good and I've pushed it upstream.

> The second one requires the openobex patches I posted to the list, but
> should fail gracefully if the support does not exist.

This patch has some issues:

> +    /* Setup low-level USB */
> +    if (!gw_obex_transport_setup_usb(&handle)) {
> +        debug("gw_obex_transport_setup_usb() failed, no USB support?\n");
> +        return NULL;
> +    }

You forget to set *error before returning NULL here.

> +    /* Do the transport connection */
> +    if (OBEX_InterfaceConnect(handle, iface) < 0) {
> +        debug("Could not connect to USB device '%s'\n", dev);
> +        if (error)
> +            *error = GW_OBEX_ERROR_NO_SERVICE;
> +        return NULL;
> +    }

This looks like a memory leak since you don't do the same cleanup of ctx->mutex
and ctx as you do in the other failure cases. Maybe the function could use a
"fail" label where you jump to for cleanup tasks?

Besides those issues the patch seems ok'ish.

Johan
