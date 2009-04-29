Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Apr 2009 19:13:15 -0700
Subject: RE: BUG: sleeping function called from invalid context at
 mm/slub.c:1595 --- "hcitool cc" or "l2ping"
Message-ID: <477F20668A386D41ADCC57781B1F704301E3F5C816@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
	 <1240966565.997.65.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
 <6b53b1990904281847i5c72770dif47b67366b7b9183@mail.gmail.com>
In-Reply-To: <6b53b1990904281847i5c72770dif47b67366b7b9183@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> > Hi Marcel,
> >
> > "git log" shows the last commit was ad4751fcada51292bb2967748667b582281=
647d0.
> > Bluetooth: Fix errors and warnings in L2CAP reported by checkpatch.pl
> >
> > Is it the latest one?
>=20
> yes, but make sure that you already have this patch:
> d79c7b52d647153831c59c223a44015c2050ad67
>=20

Hi Gustavo,

This is a list of last several commits. d79c7b52d647153831c59c223a44015c205=
0ad67 is one of them.


commit ad4751fcada51292bb2967748667b582281647d0
Author: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

    Bluetooth: Fix errors and warnings in L2CAP reported by checkpatch.pl

commit 35a26a237c126d6a3acabec3b1b3b6bd3a888b26
Author: Marcel Holtmann <marcel@holtmann.org>

    Bluetooth: Remove unnecessary variable initialization

commit 140014e74f973103f567bc75fa009d07ab251d20
Author: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

    Bluetooth: Use macro for L2CAP hint mask on receiving config request

commit 0b81fdb4e9256b2f517600c9d138bae306520e8c
Author: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

    Bluetooth: Use macros for L2CAP channels identifiers

commit d79c7b52d647153831c59c223a44015c2050ad67
Author: Marcel Holtmann <marcel@holtmann.org>

    Bluetooth: Fix connection establishment with low security requirement

commit 889d94df978869cce5405040acc558a1b4a1a510
Author: Marcel Holtmann <marcel@holtmann.org>

    Bluetooth: Add different pairing timeout for Legacy Pairing



Should I try something to get more debug info?

Thanks,

Bing
