Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] hciattach application support for Atheros AR300x
 Bluetooth Chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <4BF613AF.2080303@atheros.com>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
	 <1273672059.32536.14.camel@atheros013-desktop>
	 <1274371256.27220.15.camel@localhost.localdomain>
	 <4BF613AF.2080303@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 May 2010 09:34:53 +0200
Message-ID: <1274427293.27220.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> >> Implements support for Atheros AR300x Bluetooth chip in hciattach. 
> >> Adds feature to bring up AR300x Bluetooth chip
> >> with and without enhanced power management enabled.
> >>
> >> Signed-off-by: Suraj <suraj@Atheros.com>
> > 
> > not SOBs for BlueZ userspace. That is kernel only.
> > 
> >> ---
> >>  Makefile.tools         |    1 +
> >>  tools/hciattach.8      |    6 +
> >>  tools/hciattach.c      |  111 +++++
> >>  tools/hciattach.h      |    3 +
> >>  tools/hciattach_ar3k.c | 1223 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 1344 insertions(+), 0 deletions(-)
> >>  create mode 100755 tools/hciattach_ar3k.c
> > 
> > While hciattach is kinda the bad sheep inside BlueZ, I will enforce the
> > general coding style for it for all new contributions. So could you
> > please fix that one first. Otherwise it makes no sense for me to go
> > through such a big patch if I have to complain about the coding style
> > breakage for every second line. A general rule is if it fails
> > check-patch.pl from the kernel, then you are doing something wrong.
>
> I had verified this patch using checkpatch and it did not complain. I 
> had also verified it manually according to the comments others have 
> given previously for different patches.
> 
> If you still see issues, then we can add that check too to checkpatch if 
> possible.

then maybe checkpatch.pl is not good enough for this. I see way too many
empty lines, weird if breakages, and many more. So as I said, this needs
cleanup first.

Regards

Marcel


