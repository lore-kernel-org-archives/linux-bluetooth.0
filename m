Return-Path: <cyrus@holtmann.org>
Message-ID: <1334748297.8818.121.camel@novo.hadess.net>
Subject: Re: [PATCH BlueZ v2 0/3] Current status of playstation-peripheral
 plugin
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Date: Wed, 18 Apr 2012 12:24:57 +0100
In-Reply-To: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-04-18 at 11:38 +0200, Antonio Ospite wrote:
> This is a short summary about Playstation peripherals and their pairing
> mechanism, to recap the current status of the playstation-peripheral plugin,
> propose a working solution and discuss possible better ones.
> 
> From now on in this message I sometime call a Playstation peripheral
> simply a "device".

Would be good to have all that information in a README, or the source,
and list which devices we're capable of handling (Sixaxis? Keypad?
Headset? Move?).

> Bastien, please check if I am forgetting anything :)
> 
> WHAT we need the plugin to do:
> 
>   - When a device is connected via USB:
>     + Fetch the (default) adapter bdaddr (from BlueZ) and store it into
>       the device
>     + Fetch the device bdaddr (from the device via USB/HID) and make the
>       device _trusted_ by the adapter (is "trusted" the correct term
>       here?

Setting it as trusted isn't the only thing you're doing. You're making
it known (meaning that you fill in details such as its SDP record,
including name), then adding it as trusted so that BlueZ doesn't ask the
user whether this device is allowed to connect.

You need a separate function to make it "known" and insert it into
BlueZ's database. _set_trusted() should be a function that takes a
single device and a value (whether to trust or untrust), that's it.

So you need to split it in 2 separate functions.

>  Or maybe this is more like a "static association"? Are the
>       term "trusted" and "associated" in bluetooth context defined
>       anywhere?)
> 
>   - When the device is connected via BT:
>     + Nothing! It should work automatically.
> 
>   - Set LEDs when possible.
<snip>

