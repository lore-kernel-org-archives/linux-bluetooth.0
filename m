Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
	"'Emeltchenko Andrei'" <Andrei.Emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>	 <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>	 <1321480186.15441.554.camel@aeonflux> <20111117132047.GH415@aemeltch-MOBL1> <1321544714.15441.568.camel@aeonflux>
In-Reply-To: <1321544714.15441.568.camel@aeonflux>
Subject: RE: [RFC 3/3] Bluetooth: Add AMP initialization
Date: Thu, 17 Nov 2011 10:17:24 -0800
Message-ID: <005d01cca555$280fa960$782efc20$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei & Marcel,

> Hi Andrei,
> 
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index d1eef7c..290acb2 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -219,40 +219,56 @@ static void hci_init_req(struct hci_dev *hdev,
> unsigned long opt)
> > > >  			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> > > >  	}
> > > >
> > > > -	/* Read Local Supported Features */
> > > > -	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> > > > -
> > > >  	/* Read Local Version */
> > > >  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> > > >
> > > >  	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> > > >  	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> > > >
> > > > -	/* Read BD Address */
> > > > -	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> > > > +	switch (hdev->dev_type) {
> > > > +	case HCI_BREDR:
> > >
> > > stop right here and first split this out into proper helper functions.
> > > Making this part longer and more convoluted is not going to work well in
> > > the long run.
> >
> > Would following functions work:
> >
> > __hci_common_init
> > __hci_bredr_init
> > __hci_amp_init
> 
> I would not bother with common init. I think there is nothing really
> common between AMP and BR/EDR/LE controllers.

The commands quoted above are the common part of init between BR-EDR and AMP, plus 
there will be a few additional common commands when block-based flow control is added.
Makes sense to me to split the controller-specific sequences into two helper funcs 
called at this switch statement.

> So just split it into bredr_init and amp_init.
> 
> > > > -	if (test_bit(HCI_INIT, &hdev->flags))
> > > > +	if (hdev->dev_type == HCI_BREDR && test_bit(HCI_INIT, &hdev-
> >flags))
> > > >  		hci_setup(hdev);
> > > >  }
> > > This is ugly. Why don't we set HCI_INIT for AMP controllers as well?
> >
> > The purpose of the hunk is to avoid hci_setup for other controllers than
> > BR/EDR. Maybe later on we will come up with something like amp_setup for
> > AMP controllers.
> >
> > Maybe I have to create special patch for it?
> 
> I like to not see a temporary hack and just init the AMP controller.
> This needs to be done anyway. So lets just do it.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,

Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


