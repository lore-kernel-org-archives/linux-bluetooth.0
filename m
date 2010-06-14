Return-Path: <cyrus@holtmann.org>
From: "Counihan, Tom" <tom.counihan@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 14 Jun 2010 14:21:55 +0100
Subject: RE: Proposed MAP client D-Bus API (was: Proposed MAP API)
Message-ID: <B09AD526409DF14F8DA79CC5429052C28F7AAD48@irsmsx505.ger.corp.intel.com>
References: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
 <20100614091849.GA20885@jh-x301>
In-Reply-To: <20100614091849.GA20885@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Many thanks for the prompt response Johan,


>It'd have been good to clearly state that you're only talking about the
>client side of MAP (it became clear to me only after noticing that
>you've got org.openobex.client in the D-Bus API). The server side would
>e.g. be implemented through an obexd plugin.

Duly noted, apologies for any confusion. Note, I'm interested in bringing both sides of this interface up, the original was a modest attempt at kick starting myself on this profile.

>Are you sure you want to use D-Bus for this? I suspect the required
>bandwidth will be too high to be efficiently handled using D-Bus.
>Wouldn't a MAP specific library on top of OpenOBEX make more sense?

Not sure at all really. I had my suspicion, but wanted to start somewhere. 
What you suggest makes perfect sense really - back to the drawing board for me :$ - just need to figure out a logical home for this.

On an aside, could the same comment be made regarding PBAP re contact pictures?

Warm Regards
Tom.
--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


