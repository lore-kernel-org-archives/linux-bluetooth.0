Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Oct 2012 11:34:40 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 3/6] Bluetooth: AMP: Add handle to hci_chan structure
Message-ID: <20121010083438.GB7620@aemeltch-MOBL1>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349707932-10006-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349793991.27233.91.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349793991.27233.91.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 09, 2012 at 04:46:31PM +0200, Marcel Holtmann wrote:
...
> > -
> > +struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle);
> > +struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev,
> > +					    __u16 handle);
> 
> this naming is pretty bad. I have no idea what one function does
> different compared to the other. Especially since none of them take a
> hci_chan as argument, but start with that prefix.
> 
> Would be the naming hci_conn_lookup_chan be a lot clearer? Or maybe
> hci_chan_lookup_from_dev or similar.

So are names like:

hci_conn_lookup_hchan_by_handle
hci_conn_lookup_hchan_from_hdev

better?

...
> > +struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle)
> > +{
> > +	struct hci_chan *hchan;
> > +
> > +	list_for_each_entry(hchan, &hcon->chan_list, list) {
> > +		if (hchan->handle == handle)
> > +			return hchan;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> Since this function is unprotected, you better make this __hci_....
> 
> And on a different note. It is not used at all. So why is this public
> anyway?

I will make it static.

...
> > +	rcu_read_lock();
> > +
> > +	list_for_each_entry_rcu(hcon, &h->list, list) {
> > +		struct hci_chan *hchan;
> > +
> > +		hchan = hci_chan_lookup_handle(hcon, handle);
> > +		if (hchan) {
> > +			rcu_read_unlock();
> > +			return hchan;
> 
> Please use break here. Have a global hchan variable assigned to NULL and
> just break here.

OK.

Best regards 
Andrei Emeltchenko 
