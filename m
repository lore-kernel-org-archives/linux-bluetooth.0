Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Oct 2012 11:22:27 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 4/6] Bluetooth: Handle number of compl blocks for AMP_LINK
Message-ID: <20121010082225.GA7620@aemeltch-MOBL1>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349707932-10006-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349794158.27233.94.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349794158.27233.94.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 09, 2012 at 04:49:18PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Add handling blocks count for AMP link.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/hci_event.c |   12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 82e478a..c479732 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2698,13 +2698,21 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  
> >  	for (i = 0; i < ev->num_hndl; i++) {
> >  		struct hci_comp_blocks_info *info = &ev->handles[i];
> > -		struct hci_conn *conn;
> > +		struct hci_conn *conn = NULL;
> > +		struct hci_chan *chan;
> >  		__u16  handle, block_count;
> >  
> >  		handle = __le16_to_cpu(info->handle);
> >  		block_count = __le16_to_cpu(info->blocks);
> >  
> > -		conn = hci_conn_hash_lookup_handle(hdev, handle);
> > +		if (hdev->dev_type == HCI_BREDR) {
> > +			conn = hci_conn_hash_lookup_handle(hdev, handle);
> > +		} else {
> > +			chan = hci_chan_lookup_handle_all(hdev, handle);
> > +			if (chan)
> > +				conn = chan->conn;
> 
> Just in case, we better use a switch statement here.
> 
> And now coming to think about it, do we ever need the hci_chan anyway.

For AMP hchan represents logical link so it is needed.

> Then why not have a function that looks up the hci_conn.
> 
> Maybe introduce a new hci_conn_lookup_handle(hdev, handle) and it will
> do the right thing depending on what the device type is.

This looks good, will do this way.

Best regards 
Andrei Emeltchenko 
