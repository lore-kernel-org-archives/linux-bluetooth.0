Return-Path: <cyrus@holtmann.org>
Message-ID: <1339146093.1817.143.camel@aeonflux>
Subject: Re: [PATCHv1 1/4] Bluetooth: Use standard HCI cmd timeout for RESET
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 18:01:33 +0900
In-Reply-To: <20120608090023.GD2730@aemeltch-MOBL1>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1339144316.1817.140.camel@aeonflux> <20120608085315.GC2730@aemeltch-MOBL1>
	 <20120608090023.GD2730@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > Remove magic and use standard HCI cmd timeout
> > > > 
> > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > ---
> > > >  net/bluetooth/hci_core.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > > 
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index a2e15436c..e5a9a09 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -783,7 +783,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> > > >  	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
> > > >  		set_bit(HCI_INIT, &hdev->flags);
> > > >  		__hci_request(hdev, hci_reset_req, 0,
> > > > -			      msecs_to_jiffies(250));
> > > > +			      msecs_to_jiffies(HCI_CMD_TIMEOUT));
> > > >  		clear_bit(HCI_INIT, &hdev->flags);
> > > >  	}
> > > 
> > > And while you are at it, can we please move over to put the
> > > msecs_to_jiffies into the #define itself. 
> > 
> > Do you mean convert those defines below?
> > 
> > /* HCI timeouts */
> > #define HCI_DISCONN_TIMEOUT	(2000)	/* 2 seconds */
> > #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
> > #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
> > #define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
> > #define HCI_ACL_TX_TIMEOUT	(45000)	/* 45 seconds */
> 
> I think I will convert them in the following patch.

yes, an additional patch is find. That is why I acked this one ;)

Regards

Marcel


