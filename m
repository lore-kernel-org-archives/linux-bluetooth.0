Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Dec 2012 15:54:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kamil =?utf-8?B?Sm/FhGNh?= <kjonca@o2.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to pair device from CLI?
Message-ID: <20121228135423.GA14448@x220.P-661HNU-F1>
References: <871uebt47d.fsf@alfa.kjonca>
 <20121228080842.GA28814@x220.P-661HNU-F1>
 <87wqw2s3qm.fsf@alfa.kjonca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wqw2s3qm.fsf@alfa.kjonca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kamil,

> > HCI Event: IO Capability Request (0x31) plen 6
>     bdaddr D4:E8:B2:AA:15:FA
> < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
>     bdaddr D4:E8:B2:AA:15:FA capability 0x04 oob 0x00 auth 0x03
>     Capability: Reserved (OOB data not present)
>     Authentication: Dedicated Bonding (MITM Protection)

Here's the problem. The kernel is respoding with an invalid IO
capability value. The same issue was discussed here just a week ago:

http://marc.info/?l=linux-bluetooth&m=135599627517032&w=2

The quick fix is to change "KeyboardDisplay" to "DisplayYesNo" in the
simple-agent script.

Johan
