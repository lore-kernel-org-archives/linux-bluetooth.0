Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Add extfeatures to struct hci_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 21 Jun 2011 19:16:38 -0700
In-Reply-To: <20110621205505.GA8124@dell.ger.corp.intel.com>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	 <20110621205505.GA8124@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308709001.2196.64.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > @@ -224,6 +225,11 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> >  	/* Read Local Supported Features */
> >  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> >  
> > +	/* Read Local Extended Features */
> > +	ext_cp.page = 0x01;
> > +	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(ext_cp),
> > +								&ext_cp);
> 
> Since the extended features command is only available from 1.2 onwards I
> don't think it's right to unconditionally send it in hci_init_req.
> Instead, you should probably be checking for the feature bit in the
> (non-extended) feature mask, i.e. in the command complete callback for
> HCI_Read_Local_Features and only send the command if the feature bit is
> set.

exactly and with your work on the management interface, I hope we can
get rid of hci_init_req at some point. And then do a proper async and
well defined init of the adapter. Especially with things like LE, single
mode, AMP, SSP and other factors on the init process, we need to get
this fixed once and for all.

The AMP init will look fundamentally different from the BR/EDR and init.
And so will the LE only init. And it all depends on Bluetooth adapter
version and feature bits of course.

Regards

Marcel


