Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 15:20:49 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
Message-ID: <20111117132047.GH415@aemeltch-MOBL1>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321480186.15441.554.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321480186.15441.554.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 17, 2011 at 06:49:44AM +0900, Marcel Holtmann wrote:
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index d1eef7c..290acb2 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -219,40 +219,56 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> >  			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> >  	}
> >  
> > -	/* Read Local Supported Features */
> > -	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> > -
> >  	/* Read Local Version */
> >  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> >  
> >  	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> >  	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> >  
> > -	/* Read BD Address */
> > -	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> > +	switch (hdev->dev_type) {
> > +	case HCI_BREDR:
> 
> stop right here and first split this out into proper helper functions.
> Making this part longer and more convoluted is not going to work well in
> the long run.

Would following functions work:

__hci_common_init
__hci_bredr_init
__hci_amp_init

> > -	if (test_bit(HCI_INIT, &hdev->flags))
> > +	if (hdev->dev_type == HCI_BREDR && test_bit(HCI_INIT, &hdev->flags))
> >  		hci_setup(hdev);
> >  }
> This is ugly. Why don't we set HCI_INIT for AMP controllers as well?

The purpose of the hunk is to avoid hci_setup for other controllers than
BR/EDR. Maybe later on we will come up with something like amp_setup for
AMP controllers.

Maybe I have to create special patch for it?

Best regards 
Andrei Emeltchenko 
