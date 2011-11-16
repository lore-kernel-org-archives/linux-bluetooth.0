Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 1/3] Bluetooth: Allow to set AMP type for virtual HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 Nov 2011 18:17:51 +0900
In-Reply-To: <20111116082209.GC30662@aemeltch-MOBL1>
References: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321267370-15727-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20111115120918.GA27081@aemeltch-MOBL1>
	 <1321405993.15441.500.camel@aeonflux>
	 <20111116082209.GC30662@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321435074.15441.527.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > Type can be changed during re-opening device /dev/vhci.
> > > > 
> > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > > > ---
> > > >  drivers/bluetooth/hci_vhci.c |    8 ++++++++
> > > >  1 files changed, 8 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > > > index 2e302a1..2ed6ab1 100644
> > > > --- a/drivers/bluetooth/hci_vhci.c
> > > > +++ b/drivers/bluetooth/hci_vhci.c
> > > > @@ -41,6 +41,8 @@
> > > >  
> > > >  #define VERSION "1.3"
> > > >  
> > > > +static bool amp;
> > > > +
> > > >  struct vhci_data {
> > > >  	struct hci_dev *hdev;
> > > >  
> > > > @@ -239,6 +241,9 @@ static int vhci_open(struct inode *inode, struct file *file)
> > > >  	hdev->bus = HCI_VIRTUAL;
> > > >  	hdev->driver_data = data;
> > > >  
> > > > +	if (amp)
> > > > +		hdev->dev_type = HCI_AMP;
> > > > +
> > > 
> > > I am thinking about changing lines above to:
> > > 
> > > -       if (amp)
> > > +       if (amp) {
> > >                 hdev->dev_type = HCI_AMP;
> > > +               hdev->amp_type = AMP_CTRL_BLUETOOTH_ONLY;
> > > +       }
> > > 
> > > to indicate that that "the AMP Controller is only used by the Bluetooth
> > > technology and will not be shared with other non-Bluetooth technologies".
> > 
> > this can not be static information at this point. It will change
> > depending on how the WiFi subsystem or WiFi drivers want it to be.
> > 
> > And lets cross the bridge when we get to it. This is too early to figure
> > out what to do here.
> 
> The code only emulates virtual HCI amp_type. The reason why I added it is
> to reply for A2MP Discover Req. If we leave field as 0 it would mean that
> that controller is powered down.
> 
> This value can be read with "read local amp info", I can implement this
> command in hciemu as other option.

as mentioned in the other reply, having it local in A2MP and have hciemu
return the current value seems the correct approach. Everything else
looks like a hack to me.

Regards

Marcel


