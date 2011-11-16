Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv4 1/5] Bluetooth: Define AMP controller statuses
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 Nov 2011 18:16:27 +0900
In-Reply-To: <20111116090325.GF30662@aemeltch-MOBL1>
References: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321366547-29462-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321422613.15441.513.camel@aeonflux>
	 <20111116090325.GF30662@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321434990.15441.526.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > AMP status codes copied from Bluez patch sent by Peter Krystad
> > > <pkrystad@codeaurora.org>.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  include/net/bluetooth/hci.h |    9 +++++++++
> > >  1 files changed, 9 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > index 139ce2a..e79ed67 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -56,6 +56,15 @@
> > >  #define HCI_BREDR	0x00
> > >  #define HCI_AMP		0x01
> > >  
> > > +/* AMP controller status */
> > > +#define AMP_CTRL_POWERED_DOWN			0x00
> > > +#define AMP_CTRL_BLUETOOTH_ONLY			0x01
> > > +#define AMP_CTRL_NO_CAPACITY			0x02
> > > +#define AMP_CTRL_LOW_CAPACITY			0x03
> > > +#define AMP_CTRL_MEDIUM_CAPACITY		0x04
> > > +#define AMP_CTRL_HIGH_CAPACITY			0x05
> > > +#define AMP_CTRL_FULL_CAPACITY			0x06
> > > +
> > 
> > is hci.h really the right place for these? It is not HCI specific
> > per-se. It is A2MP detail. And as mentioned earlier, I do not believe we
> > should do it like this.
> 
> I believe that it is HCI device specific since hci_dev structure is
> accountable for BR/EDR and AMP controllers and we currently keep
> controller-specific information in hci_dev.
> 
> Those defines indicate AMP controller status like powered or not.
> 
> What would be the better place?
> 
> include/net/bluetooth/hci_core.h
> include/net/bluetooth/amp.h
> include/net/bluetooth/a2mp.h
> 
> 
> > I think we need to expose some sort of functionality that lets the AMP
> > drivers handle this dynamically.
> 
> This status and other AMP parameters would be normally returned when
> "read local amp info" HCI command.

if these information come from the AMP controller, then this is clearly
an A2MP specific detail. There is no point in storing them in hci_dev at
all.

I think these definition can stay local in net/bluetooth/a2mp.c for now.

Regards

Marcel


