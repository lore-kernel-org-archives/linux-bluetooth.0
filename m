Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
	"'Emeltchenko Andrei'" <Andrei.Emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>	 <1321366547-29462-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>	 <1321422613.15441.513.camel@aeonflux>	 <20111116090325.GF30662@aemeltch-MOBL1>	 <1321434990.15441.526.camel@aeonflux>	 <20111116100438.GI30662@aemeltch-MOBL1> <1321450004.15441.546.camel@aeonflux>
In-Reply-To: <1321450004.15441.546.camel@aeonflux>
Subject: RE: [PATCHv4 1/5] Bluetooth: Define AMP controller statuses
Date: Thu, 17 Nov 2011 10:01:21 -0800
Message-ID: <005a01cca552$ea65e770$bf31b650$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei and Marcel,

> > > > > > AMP status codes copied from Bluez patch sent by Peter Krystad
> > > > > > <pkrystad@codeaurora.org>.
> > > > > >
> > > > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > > > ---
> > > > > >  include/net/bluetooth/hci.h |    9 +++++++++
> > > > > >  1 files changed, 9 insertions(+), 0 deletions(-)
> > > > > >
> > > > > > diff --git a/include/net/bluetooth/hci.h
> b/include/net/bluetooth/hci.h
> > > > > > index 139ce2a..e79ed67 100644
> > > > > > --- a/include/net/bluetooth/hci.h
> > > > > > +++ b/include/net/bluetooth/hci.h
> > > > > > @@ -56,6 +56,15 @@
> > > > > >  #define HCI_BREDR	0x00
> > > > > >  #define HCI_AMP		0x01
> > > > > >
> > > > > > +/* AMP controller status */
> > > > > > +#define AMP_CTRL_POWERED_DOWN			0x00
> > > > > > +#define AMP_CTRL_BLUETOOTH_ONLY			0x01
> > > > > > +#define AMP_CTRL_NO_CAPACITY			0x02
> > > > > > +#define AMP_CTRL_LOW_CAPACITY			0x03
> > > > > > +#define AMP_CTRL_MEDIUM_CAPACITY		0x04
> > > > > > +#define AMP_CTRL_HIGH_CAPACITY			0x05
> > > > > > +#define AMP_CTRL_FULL_CAPACITY			0x06
> > > > > > +
> > > > >
> > > > > is hci.h really the right place for these? It is not HCI specific
> > > > > per-se. It is A2MP detail. And as mentioned earlier, I do not believe
> we
> > > > > should do it like this.
> > > >
> > > > I believe that it is HCI device specific since hci_dev structure is
> > > > accountable for BR/EDR and AMP controllers and we currently keep
> > > > controller-specific information in hci_dev.
> > > >
> > > > Those defines indicate AMP controller status like powered or not.
> > > >
> > > > What would be the better place?
> > > >
> > > > include/net/bluetooth/hci_core.h
> > > > include/net/bluetooth/amp.h
> > > > include/net/bluetooth/a2mp.h
> > > >
> > > >
> > > > > I think we need to expose some sort of functionality that lets the
> AMP
> > > > > drivers handle this dynamically.
> > > >
> > > > This status and other AMP parameters would be normally returned when
> > > > "read local amp info" HCI command.
> > >
> > > if these information come from the AMP controller, then this is clearly
> > > an A2MP specific detail. There is no point in storing them in hci_dev at
> > > all.
> >
> > I thought that A2MP specific details are details related to A2MP
> > connection. Information about status of AMP controller does not depend on
> > A2MP connection.
> 
> the only part using this information will be A2MP and it has to read it
> from the controller fresh almost every time. So yes, it belongs there
> and not inside HCI. At least that is how I read the AMP controller
> specification and how it is suppose to be used.

This status is updated by the controller via unsolicited AMP status event, there
is no reason to read it other than during init. I agree with Andrei that storing
it in hci_dev makes sense, as this structure represents state of a local HCI 
controller. AMP Manager data structures are all related to A2MP connections, not
devices. AMP Manager does need to know when the status changes, because it has
connections to service when this status happens.
 
> > > I think these definition can stay local in net/bluetooth/a2mp.c for now.
> >
> > maybe a2mp.h then? As we use existing HCI command infrastructure to handle
> > AMP specific HCI commands we might need to source the header.
> 
> As I said, leave it local for now. We can always move them around later.
> 
> Regards
> 
> Marcel

Regards,

Peter.


