Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] drivers:bluetooth: TI_ST bluetooth driver
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: pavan_savoy@ti.com, linux-bluetooth@vger.kernel.org,
	greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20101007184534.GB13602@vigoh>
References: <1286477237-7526-1-git-send-email-pavan_savoy@ti.com>
	 <1286477237-7526-2-git-send-email-pavan_savoy@ti.com>
	 <20101007184534.GB13602@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 10:37:42 +0200
Message-ID: <1286527062.6145.182.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Change the commit subject to "Bluetooth: TI_ST bluetooth driver" 
> 
> * pavan_savoy@ti.com <pavan_savoy@ti.com> [2010-10-07 14:47:16 -0400]:
> 
> > From: Pavan Savoy <pavan_savoy@ti.com>
> > 
> > This is the bluetooth protocol driver for the TI WiLink7 chipsets.
> > Texas Instrument's WiLink chipsets combine wireless technologies
> > like BT, FM, GPS and WLAN onto a single chip.
> > 
> > This Bluetooth driver works on top of the TI_ST shared transport
> > line discipline driver which also allows other drivers like
> > FM V4L2 and GPS character driver to make use of the same UART interface.
> > 
> > Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
> > ---
> >  drivers/bluetooth/bt_ti.c |  489 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 489 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/bluetooth/bt_ti.c
> 
> We don't have filename with bt_.. in drivers/bluetooth/. Maybe ti_st.c
> should be a better name, or something like that.

actually we have the bt prefix for company generic ones where they
didn't wanna use the hardware name.

So I prefer to use the hardware for a driver since it is much more clear
that way. You acronym naming here is bad. It is confusing like hell.

What about just calling this btwilink.c or something. I just spinning
ideas here.

Regards

Marcel


