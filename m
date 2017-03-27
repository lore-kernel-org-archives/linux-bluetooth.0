Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [EXT] Re: Unexpected SMP Command 0x17
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3fa5cd6f9317401fbf4da0b5236c1ff1@SC-EXCH02.marvell.com>
Date: Mon, 27 Mar 2017 16:55:05 +0200
Cc: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>
Message-Id: <AC5A66AA-49F3-4F10-8D7A-EDDEC395A4FE@holtmann.org>
References: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com>
 <6C7A2FEB-859E-4161-8EED-2C90A0960F0A@holtmann.org>
 <3fa5cd6f9317401fbf4da0b5236c1ff1@SC-EXCH02.marvell.com>
To: Avinash Kadam <avinashk@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Avinash,

please also refrain from top posting.

> Yes, for secure connection the LTK is generated locally. 
> But issue here is observed that after Pairing is complete the key distribution is not completed from Master. 
> 
> i.e. After Slave sends the  "Signature key:" but Master doesn't share any key.  Attached logs.

I get that and that is clear from the logs. Something is stalling here and because of that, you run into the 30 seconds SMP timeout. We just need to know if the 4.9 kernel is doing this correctly. If so, then you can bi-sect that patch that fixes. Without proof that 4.9 is also broken, nobody will even bother to chase this down.

Regards

Marcel

