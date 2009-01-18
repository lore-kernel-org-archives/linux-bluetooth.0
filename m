Return-Path: <cyrus@holtmann.org>
Reply-To: <hoene@uni-tuebingen.de>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <016701c97976$e75578d0$b6006a70$@de> <1232291106.5095.6.camel@californication>
In-Reply-To: <1232291106.5095.6.camel@californication>
Subject: RE: Questions on connecting BlueZ/SBC with Ekiga
Date: Sun, 18 Jan 2009 16:19:41 +0100
Message-ID: <017201c97980$32f7b880$98e72980$@hoene@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> > Due to legal reason we must use the BlueZ and are not allowed to include
SBC
> > into Ekiga.
> 
> What kind of legal reasons are you talking about here. The SBC
> implementation is released under LGPL. Worst case issue here is that you
> actually build an independent library out of it and just link it
> dynamically. We were planning to do so anyway, but currently that is not
> really sufficient for us. It would just create a maintenance overhead.

The SBC is covered by patents owned by Frans and Philips. Philips has made a
legal agreement with Bluetooth SIG allowing SBC to be used in any Bluetooth
device. Any other usages require permission from Philips.

Last year, a Philips' lawyer called me asking me to license SBC if it is
added to Ekiga. I told them that I do not have money and asked finding
another solution. However, until now Philips did not made a decision on how
to process on this issues. I am awaiting it. Luckily, I am not yet sued ;-)

Greetings

Christian
