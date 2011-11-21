Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 12:22:02 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michael Schmitt <tcwardrobe@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111121102200.GF32261@aemeltch-MOBL1>
References: <4EC679A0.7050309@gmail.com>
 <20111118153652.GA3647@fusion.localdomain>
 <4EC67E88.6060202@gmail.com>
 <20111118162111.GA4680@fusion.localdomain>
 <20111121085704.GB32261@aemeltch-MOBL1>
 <1321866829.2011.5.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321866829.2011.5.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Nov 21, 2011 at 10:13:49AM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > On Fri, Nov 18, 2011, Michael Schmitt wrote:
> > > > < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> > > > > HCI Event: Command Complete (0x0e) plen 12
> > > >     Read Local Version Information (0x04|0x0001) ncmd 1
> > > >     status 0x00
> > > >     HCI Version: 1.2 (0x2) HCI Revision: 0x2006
> > > >     LMP Version: 1.2 (0x2) LMP Subversion: 0x1806
> > > >     Manufacturer: AVM Berlin (31)
> > > 
> > > Ok, so this is a 1.2 adapter.
> > > 
> > > > < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> > > > > HCI Event: Command Status (0x0f) plen 4
> > > >     Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
> > > >     Error: Unknown HCI Command
> > > 
> > > This is the reason why you're getting a timeout. Since the adapter
> > > claims to support Bluetooth version 1.2 it should also support this HCI
> > > command, so from that perspective it's not conforming to the
> > 
> > Apparently we check for "Bluetooth Core Specification 1.1" 
> > 
> > Shall we change to:
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index f0fbb02..ed55b33 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -562,7 +562,7 @@ static void hci_setup(struct hci_dev *hdev)
> >  {
> >         hci_setup_event_mask(hdev);
> >  
> > -       if (hdev->lmp_ver > 1)
> > +       if (hdev->lmp_ver > 2)
> >                 hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
> 
> 0x00 is 1.0b and 0x01 is 1.1. So you are changing the check from 1.2 to
> 2.0. The command was introduced with 1.2 actually.

Can we define in bluetooth.h something like:

#define BLUETOOTH_LMP_VER_1.1	1
#define BLUETOOTH_LMP_VER_1.2	2

> The only real change that needs to be done here is to check hci_ver
> instead of lmp_ver. This command is a HCI feature and not a LMP feature
> actually.

Maybe same define for HCI_VER ?

Best regards 
Andrei Emeltchenko 
