Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 11:47:24 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Allow to set AMP type for virtual HCI
Message-ID: <20111114094723.GB13665@aemeltch-MOBL1>
References: <1321023735-11641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321050512.15441.399.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321050512.15441.399.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Nov 12, 2011 at 07:28:27AM +0900, Marcel Holtmann wrote:
> Hi Andre,
> 
> > Type can be changed during module loading.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  drivers/bluetooth/hci_vhci.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index 2e302a1..48f9087 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -41,6 +41,8 @@
> >  
> >  #define VERSION "1.3"
> >  
> > +static bool amp;
> > +
> >  struct vhci_data {
> >  	struct hci_dev *hdev;
> >  
> > @@ -239,6 +241,9 @@ static int vhci_open(struct inode *inode, struct file *file)
> >  	hdev->bus = HCI_VIRTUAL;
> >  	hdev->driver_data = data;
> >  
> > +	if (amp)
> > +		hdev->dev_type = HCI_AMP;
> > +
> >  	hdev->open     = vhci_open_dev;
> >  	hdev->close    = vhci_close_dev;
> >  	hdev->flush    = vhci_flush;
> > @@ -303,6 +308,9 @@ static void __exit vhci_exit(void)
> >  module_init(vhci_init);
> >  module_exit(vhci_exit);
> >  
> > +module_param(amp, bool, 0444);
> > +MODULE_PARM_DESC(amp, "AMP HCI device type");
> > +
> 
> actually you could make this 0644 so it can be changed at runtime. Then
> you just need to re-open /dev/vhci. Otherwise I am fine with this.\
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Resent patches with the proposed permissions and your ack.

Best regards 
Andrei Emeltchenko 
