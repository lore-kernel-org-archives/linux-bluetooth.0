Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Avinash Kadam <avinashk@marvell.com>, "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, "Wong, Mun choy" <mun.choy.wong@intel.com>, "Zulqarnain, Adam" <adam.zulqarnain@intel.com>
Subject: Re: [EXT] Re: Unexpected SMP Command 0x17
Date: Mon, 27 Mar 2017 17:08:17 +0200
Message-ID: <1589262.TPhyyzNXdL@ix>
In-Reply-To: <AC5A66AA-49F3-4F10-8D7A-EDDEC395A4FE@holtmann.org>
References: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com> <3fa5cd6f9317401fbf4da0b5236c1ff1@SC-EXCH02.marvell.com> <AC5A66AA-49F3-4F10-8D7A-EDDEC395A4FE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday, 27 March 2017 16:55:05 CEST Marcel Holtmann wrote:
> Hi Avinash,
> 
> please also refrain from top posting.
> 
> > Yes, for secure connection the LTK is generated locally.
> > But issue here is observed that after Pairing is complete the key
> > distribution is not completed from Master.
> > 
> > i.e. After Slave sends the  "Signature key:" but Master doesn't share any
> > key.  Attached logs.
> I get that and that is clear from the logs. Something is stalling here and
> because of that, you run into the 30 seconds SMP timeout. We just need to
> know if the 4.9 kernel is doing this correctly. If so, then you can bi-sect
> that patch that fixes. Without proof that 4.9 is also broken, nobody will
> even bother to chase this down.

I think the problem here is race between ACL data and HCI events on USB 
dongle...  We get initial slave keys but those get dropped due to encryption 
changed event not being received yet. Since keys were silently dropped we 
later on get unexpected SMP PDU and ignoring remaining keys as well which 
eventually leads to SMP timeout.

If this is USB dongle (using btusd) then only (AFAIK) solution would be to 
have a workaround for this inside chip (it would delay ACL data received right 
after encryption change giving host time to handle encpryption change event).
Bluetooth specification for USB transport is unfortunatelly kinda broken.

-- 
pozdrawiam
Szymon Janc
