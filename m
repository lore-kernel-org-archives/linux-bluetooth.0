Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC 3/3] Bluetooth: Add AMP initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 18 Nov 2011 06:14:13 +0100
In-Reply-To: <005d01cca555$280fa960$782efc20$@org>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
		 <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
		 <1321480186.15441.554.camel@aeonflux>
	 <20111117132047.GH415@aemeltch-MOBL1> <1321544714.15441.568.camel@aeonflux>
	 <005d01cca555$280fa960$782efc20$@org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321593256.15441.575.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > > index d1eef7c..290acb2 100644
> > > > > --- a/net/bluetooth/hci_core.c
> > > > > +++ b/net/bluetooth/hci_core.c
> > > > > @@ -219,40 +219,56 @@ static void hci_init_req(struct hci_dev *hdev,
> > unsigned long opt)
> > > > >  			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> > > > >  	}
> > > > >
> > > > > -	/* Read Local Supported Features */
> > > > > -	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> > > > > -
> > > > >  	/* Read Local Version */
> > > > >  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> > > > >
> > > > >  	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> > > > >  	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> > > > >
> > > > > -	/* Read BD Address */
> > > > > -	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> > > > > +	switch (hdev->dev_type) {
> > > > > +	case HCI_BREDR:
> > > >
> > > > stop right here and first split this out into proper helper functions.
> > > > Making this part longer and more convoluted is not going to work well in
> > > > the long run.
> > >
> > > Would following functions work:
> > >
> > > __hci_common_init
> > > __hci_bredr_init
> > > __hci_amp_init
> > 
> > I would not bother with common init. I think there is nothing really
> > common between AMP and BR/EDR/LE controllers.
> 
> The commands quoted above are the common part of init between BR-EDR and AMP, plus 
> there will be a few additional common commands when block-based flow control is added.
> Makes sense to me to split the controller-specific sequences into two helper funcs 
> called at this switch statement.

with our current approach on handling this, I rather copy hci_send_cmd
than making this code more complicated.

However since we are talking about controller init. Can someone please
first propose a list of how we init AMP vs BR/EDR/LE controllers instead
of just dumping code here. I think it needs some clear strategy on how
to do it.

Regards

Marcel


