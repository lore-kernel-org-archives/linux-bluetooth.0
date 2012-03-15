Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Mike <puffy.taco@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date: Thu, 15 Mar 2012 15:55:11 +0100
Subject: RE: [Patch Bluez] HFP gateway: fix failure on very first GSM
 connection
Message-ID: <66BD268F973E3544A665E5F503FB38B71AE959AD7D@DC01.bmw-carit.intra>
References: <1314266945-6149-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAB7rCTjkNfB58E1OrOpS4AKzEF=5HZqd3-6fj2SCzkx7vgKjXA@mail.gmail.com>
 <20120315101625.GB1343@x220.vexbr.com.br>
In-Reply-To: <20120315101625.GB1343@x220.vexbr.com.br>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> >
> > Any reason this patch was not picked up?
> 
> Human error (me forgetting about it). The patch has been applied now
> (after fixing up the commit message), however it doesn't seem like too
> many people have missed this since the patch has been lying around for
> about half a year.
> 
> Johan

Actually this patch solves the underlying issue I was trying to solve in my recent series "audio: enabling both Headset and Gateway", which had no feedback.

So it's not necessary anymore, but I still wonder if device_remove_drivers is doing the proper thing when unloads drivers entirely just because one of its profiles has been removed (see "[PATCH v0 2/3] Add device driver support for partial unloading"). 

Cheers,
Mikel
