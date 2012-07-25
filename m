Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 11:49:48 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 05/20] Bluetooth: AMP: Use HCI callback to Read Loc AMP
 Assoc
Message-ID: <20120725084941.GH11981@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724205554.GD20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724205554.GD20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 24, 2012 at 05:55:54PM -0300, Gustavo Padovan wrote:
...

> > +static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
> > +					struct sk_buff *skb)
> > +{
> > +	struct hci_rp_read_local_amp_assoc *rp = (void *) skb->data;
> > +	struct amp_assoc *assoc = &hdev->loc_assoc;
> > +	size_t rem_len, frag_len;
> > +
> > +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> > +
> > +	if (rp->status)
> > +		goto process_cb;
> > +
> > +	frag_len = skb->len - sizeof(*rp);
> > +	rem_len = __le16_to_cpu(rp->rem_len);
> > +
> > +	if (rem_len > frag_len) {
> > +		BT_DBG("frag_len %d rem_len %d", frag_len, rem_len);
> > +
> > +		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
> > +		assoc->offset += frag_len;
> > +
> > +		/* Read other fragments */
> > +		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
> > +
> > +		return;
> > +	}
> > +
> > +	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
> > +	assoc->len = assoc->offset + rem_len;
> > +	assoc->offset = 0;
> > +
> > +process_cb:
> > +	/* Run callback when all fragments received */
> > +	hci_process_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, rp->status);
> 
> So, I have a question here, why are we going with this callback system here?
> This code and A2MP code runs inside the same module, so why do we need
> callbacks? 

About code running in the same module please refer to management interface
calbacks like mgmt_pending_foreach, etc

> I wonder if switch all of this to directly calls to the A2MP code,
> this simplifies things a lot.

A2MP code is running above different HCI device. The problem here is that 
if we have several AMP managers and we execute some HCI command to AMP
controller then we wouldn't know which AMP manager has initiated
connection. (Some commands though provide phy_handler and this might be
used).

If we __always__ have only one AMP Manager that would work as we can have
global pointer. Then we can always call to A2MP context which I think
shall be run in a workqueue. We can have problems here if we remove and
create AMP manager...

Best regards 
Andrei Emeltchenko 


