Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Oct 2012 13:12:34 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 3/6] Bluetooth: AMP: Add handle to hci_chan structure
Message-ID: <20121010101232.GD7620@aemeltch-MOBL1>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349707932-10006-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349793991.27233.91.camel@aeonflux>
 <20121010083438.GB7620@aemeltch-MOBL1>
 <1349863676.27233.120.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349863676.27233.120.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 10, 2012 at 12:07:56PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > -
> > > > +struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle);
> > > > +struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev,
> > > > +					    __u16 handle);
> > > 
> > > this naming is pretty bad. I have no idea what one function does
> > > different compared to the other. Especially since none of them take a
> > > hci_chan as argument, but start with that prefix.
> > > 
> > > Would be the naming hci_conn_lookup_chan be a lot clearer? Or maybe
> > > hci_chan_lookup_from_dev or similar.
> > 
> > So are names like:
> > 
> > hci_conn_lookup_hchan_by_handle
> 
> since this one is only internal, you better have a shortcut version as
> just a static helper inside that code.

OK, will name this like __hci_chan_lookup_handle

> 
> > hci_conn_lookup_hchan_from_hdev
> 
> If we follow our naming convention then hci_chan_lookup_from_dev would
> come closest. However since you only need one of these, then
> hci_chan_lookup_handle would be fine and in sync with how we named
> everything else.

then this would be:

hci_chan_lookup_handle

Best regards 
Andrei Emeltchenko 
