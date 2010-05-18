Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5] Add support for the Atheros AR300x Bluetooth Chip
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>, <gfpadovan@gmail.com>
In-Reply-To: <1273566548.7023.2.camel@atheros013-desktop>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
	 <1272279623.11239.1.camel@atheros013-desktop>
	 <1273062798.19162.6.camel@atheros013-desktop>
	 <1273566548.7023.2.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 17:09:12 +0530
Message-ID: <1274182752.10775.2.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, 2010-05-11 at 13:59 +0530, suraj wrote:
> Hi marcel,
> 
> On Wed, 2010-05-05 at 18:03 +0530, suraj wrote:
> > Hi Marcel,
> > 
> > Can you take a look at the patch? Your review has been pending for
> > sometime.
> > 
> > On Mon, 2010-04-26 at 16:30 +0530, suraj wrote:
> > > Hi marcel,
> > > 
> > > On Thu, 2010-04-22 at 14:40 +0530, suraj wrote:
> > > > This implements the Atheros Bluetooth serial protocol to
> > > > support the AR300x Bluetooth chipsets.
> > > > The serial protocol implements enhanced power management
> > > > features for the AR300x chipsets. 
> > > > 
> > > > Reviewed-by: Luis R. Rodriguez <lrodriguez@atheros.com>
> > > > Reviewed-by: Gustavo F. Padovan <gustavo@padovan.org>
> > > > Signed-off-by: Suraj <suraj@atheros.com>
> > > > 
> > > > ---
> > > >  drivers/bluetooth/Kconfig     |   14 ++
> > > >  drivers/bluetooth/Makefile    |    1 +
> > > >  drivers/bluetooth/hci_ath.c   |  378 +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/bluetooth/hci_ldisc.c |    6 +
> > > >  drivers/bluetooth/hci_uart.h  |    8 +-
> > > >  5 files changed, 406 insertions(+), 1 deletions(-)
> > > >  create mode 100755 drivers/bluetooth/hci_ath.c
> > > > 
> > > Can you verify the patch let me know your comments? 
> > > 
> > > Regards
> > > Suraj
> > > 
> > 
> > 
> 
> your review has been pending for a long time. Please let me know what
> should be done regarding this.
> 
> Regards
> Suraj
> 
> 
This patch has been pending your approval/disapproval for so much time
that it runs the risk of being obsolete. Please do let me know if you
have any plans of doing something about it.

Regards
Suraj
