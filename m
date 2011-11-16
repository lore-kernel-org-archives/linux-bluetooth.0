Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 12:04:40 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 1/5] Bluetooth: Define AMP controller statuses
Message-ID: <20111116100438.GI30662@aemeltch-MOBL1>
References: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321366547-29462-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321422613.15441.513.camel@aeonflux>
 <20111116090325.GF30662@aemeltch-MOBL1>
 <1321434990.15441.526.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321434990.15441.526.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 16, 2011 at 06:16:27PM +0900, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > AMP status codes copied from Bluez patch sent by Peter Krystad
> > > > <pkrystad@codeaurora.org>.
> > > > 
> > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > ---
> > > >  include/net/bluetooth/hci.h |    9 +++++++++
> > > >  1 files changed, 9 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > > index 139ce2a..e79ed67 100644
> > > > --- a/include/net/bluetooth/hci.h
> > > > +++ b/include/net/bluetooth/hci.h
> > > > @@ -56,6 +56,15 @@
> > > >  #define HCI_BREDR	0x00
> > > >  #define HCI_AMP		0x01
> > > >  
> > > > +/* AMP controller status */
> > > > +#define AMP_CTRL_POWERED_DOWN			0x00
> > > > +#define AMP_CTRL_BLUETOOTH_ONLY			0x01
> > > > +#define AMP_CTRL_NO_CAPACITY			0x02
> > > > +#define AMP_CTRL_LOW_CAPACITY			0x03
> > > > +#define AMP_CTRL_MEDIUM_CAPACITY		0x04
> > > > +#define AMP_CTRL_HIGH_CAPACITY			0x05
> > > > +#define AMP_CTRL_FULL_CAPACITY			0x06
> > > > +
> > > 
> > > is hci.h really the right place for these? It is not HCI specific
> > > per-se. It is A2MP detail. And as mentioned earlier, I do not believe we
> > > should do it like this.
> > 
> > I believe that it is HCI device specific since hci_dev structure is
> > accountable for BR/EDR and AMP controllers and we currently keep
> > controller-specific information in hci_dev.
> > 
> > Those defines indicate AMP controller status like powered or not.
> > 
> > What would be the better place?
> > 
> > include/net/bluetooth/hci_core.h
> > include/net/bluetooth/amp.h
> > include/net/bluetooth/a2mp.h
> > 
> > 
> > > I think we need to expose some sort of functionality that lets the AMP
> > > drivers handle this dynamically.
> > 
> > This status and other AMP parameters would be normally returned when
> > "read local amp info" HCI command.
> 
> if these information come from the AMP controller, then this is clearly
> an A2MP specific detail. There is no point in storing them in hci_dev at
> all.

I thought that A2MP specific details are details related to A2MP
connection. Information about status of AMP controller does not depend on
A2MP connection.

> I think these definition can stay local in net/bluetooth/a2mp.c for now.

maybe a2mp.h then? As we use existing HCI command infrastructure to handle
AMP specific HCI commands we might need to source the header.

Best regards 
Andrei Emeltchenko 
