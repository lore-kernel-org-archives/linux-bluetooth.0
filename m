Return-Path: <cyrus@holtmann.org>
Message-ID: <1349863676.27233.120.camel@aeonflux>
Subject: Re: [RFCv1 3/6] Bluetooth: AMP: Add handle to hci_chan structure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 12:07:56 +0200
In-Reply-To: <20121010083438.GB7620@aemeltch-MOBL1>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349707932-10006-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349793991.27233.91.camel@aeonflux> <20121010083438.GB7620@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > -
> > > +struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle);
> > > +struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev,
> > > +					    __u16 handle);
> > 
> > this naming is pretty bad. I have no idea what one function does
> > different compared to the other. Especially since none of them take a
> > hci_chan as argument, but start with that prefix.
> > 
> > Would be the naming hci_conn_lookup_chan be a lot clearer? Or maybe
> > hci_chan_lookup_from_dev or similar.
> 
> So are names like:
> 
> hci_conn_lookup_hchan_by_handle

since this one is only internal, you better have a shortcut version as
just a static helper inside that code.

> hci_conn_lookup_hchan_from_hdev

If we follow our naming convention then hci_chan_lookup_from_dev would
come closest. However since you only need one of these, then
hci_chan_lookup_handle would be fine and in sync with how we named
everything else.

I rather not have the prefixing h everywhere that we use in variable
names. That should be really only for variable names.

Regards

Marcel


