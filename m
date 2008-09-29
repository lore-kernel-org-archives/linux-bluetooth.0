Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome: how to turn adapter off?
From: Bastien Nocera <hadess@hadess.net>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <48E1004F.20605@suse.de>
References: <48E0FB63.4000601@suse.de>
	 <1222704357.3311.87.camel@cookie.hadess.net>  <48E1004F.20605@suse.de>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 21:39:56 +0100
Message-Id: <1222720796.3311.101.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-09-29 at 18:20 +0200, Stefan Seyfried wrote:
<snip>
> Ok, so I remembered wrong ;-) How about adding a "disable this adapter"
> option? Would a patch that implements this be welcome?

I'd like a patch implementing HAL killswitching. DannyK can explain to
you how that's supposed to work.

I saw this as a single toggle menu item in the right-click, allowing you
to enable/disable the main Bluetooth adapter on laptops. If there's a
killswitch present, and there's 0 or 1 adapter (and the adapter matches
the expected device) then the Bluetooth icon would shown grayed out.

This would probably also require more work like this:
      <match key="@info.parent:system.product" contains="VGN-S1XP">
        <merge key="killswitch.expected_usb_vendor_id"
type="int">0x44e</merge>
        <merge key="killswitch.expected_usb_product_id"
type="int">0x3007</merge>
      </match>

To make sure the killswitch controls (or tries to control) the correct
adapter.

Cheers

