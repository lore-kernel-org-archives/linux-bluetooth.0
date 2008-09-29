Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome: how to turn adapter off?
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Stefan Seyfried <seife@suse.de>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1222720796.3311.101.camel@cookie.hadess.net>
References: <48E0FB63.4000601@suse.de>
	 <1222704357.3311.87.camel@cookie.hadess.net>  <48E1004F.20605@suse.de>
	 <1222720796.3311.101.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 01:44:42 +0200
Message-Id: <1222731882.1825.26.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > Ok, so I remembered wrong ;-) How about adding a "disable this adapter"
> > option? Would a patch that implements this be welcome?
> 
> I'd like a patch implementing HAL killswitching. DannyK can explain to
> you how that's supposed to work.
> 
> I saw this as a single toggle menu item in the right-click, allowing you
> to enable/disable the main Bluetooth adapter on laptops. If there's a
> killswitch present, and there's 0 or 1 adapter (and the adapter matches
> the expected device) then the Bluetooth icon would shown grayed out.
> 
> This would probably also require more work like this:
>       <match key="@info.parent:system.product" contains="VGN-S1XP">
>         <merge key="killswitch.expected_usb_vendor_id"
> type="int">0x44e</merge>
>         <merge key="killswitch.expected_usb_product_id"
> type="int">0x3007</merge>
>       </match>

can we not just reference the UDI the killswitch belongs to. The vendor
and product things can be misleading.

Regards

Marcel


