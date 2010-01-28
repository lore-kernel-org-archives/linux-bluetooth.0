Return-Path: <cyrus@holtmann.org>
From: "Gunn, Brian" <bgunn@solekai.com>
To: Bastien Nocera <hadess@hadess.net>
CC: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ
 development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>,
	Jiri Kosina <jikos@jikos.cz>
Date: Thu, 28 Jan 2010 14:33:04 -0800
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 <1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
 <1264037759.1735.5008.camel@localhost.localdomain>
In-Reply-To: <1264037759.1735.5008.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> > I just tested this patch with my device and it does work.  I had to
> > slightly alter the data I send (had to add 0xA2 to the front of it),
> > but then it does work.
>
> I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?

Actually for my application it doesn't.  I use HIDP_TRANS_DATA | HIDP_DATA_=
RTYPE_OUTPUT.

Perhaps allowing the user the choice of what do to here is more flexible.

Brian
