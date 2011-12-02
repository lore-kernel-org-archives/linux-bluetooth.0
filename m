Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 14:25:57 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 5/8] Bluetooth: Add HCI Read Data Block Size function
Message-ID: <20111202122555.GD12339@aemeltch-MOBL1>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322743335-8671-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322745223.26198.35.camel@aeonflux>
 <20111201133731.GF2216@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111201133731.GF2216@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 01, 2011 at 03:37:33PM +0200, Emeltchenko Andrei wrote:
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > index a7fd63a..869ab72 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -172,6 +172,8 @@ struct hci_dev {
> > >  
> > >  	__u8		flow_ctl_mode;
> > >  
> > > +	__u16		block_len;
> > > +

What do you think about following:

<------8<----------------------------------------
|  diff --git a/include/net/bluetooth/hci_core.h
|  b/include/net/bluetooth/hci_core.h
|  index 44f130f..5a4e85c 100644
|  @@ -188,6 +188,11 @@ struct hci_dev {
|          unsigned int    sco_pkts;
|          unsigned int    le_pkts;
|
|  +       __u16           block_len;
|  +       __u16           block_mtu;
|  +       __u16           num_blocks;
|  +       __u16           block_cnt;
|  +
|          unsigned long   acl_last_tx;
|          unsigned long   sco_last_tx;
|          unsigned long   le_last_tx;
|
<------8<----------------------------------------

> > >  	unsigned int	auto_accept_delay;
> > >  
> > >  	unsigned long	quirks;
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index efad012..a646310 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -774,6 +774,33 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
> > >  	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
> > >  }
> > >  
> > > +static void hci_cc_read_data_block_size(struct hci_dev *hdev,
> > > +							struct sk_buff *skb)
> > > +{
> > > +	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
> > > +
> > > +	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> > > +
> > > +	if (rp->status)
> > > +		return;
> > > +
> > > +	if (hdev->flow_ctl_mode == HCI_FLOW_CTL_MODE_BLOCK_BASED) {
> > > +		hdev->acl_mtu  = __le16_to_cpu(rp->max_acl_len);
> > > +		hdev->sco_mtu = 0;
> > > +		hdev->block_len = __le16_to_cpu(rp->block_len);
> > > +		/* acl_pkts indicates the number of blocks */
> > > +		hdev->acl_pkts = __le16_to_cpu(rp->num_blocks);
> > > +		hdev->sco_pkts = 0;
> > > +		hdev->acl_cnt = hdev->acl_pkts;
> > > +		hdev->sco_cnt = 0;
> > > +	}
> > 
> > I am still not convinced that overloading the variables is a good idea.
> > And so far nobody has me convinced that this is the best way.
> 
> I think that we can use different variables like block_cnt and acl_blocks,
> then function split as you mentioned in other comment does make sense.

then here comes:

<------8<--------------------------------------------------------------
|  +       if (hdev->flow_ctl_mode == HCI_FLOW_CTL_MODE_BLOCK_BASED) {
|  +               hdev->block_mtu = __le16_to_cpu(rp->max_acl_len);
|  +               hdev->block_len = __le16_to_cpu(rp->block_len);
|  +               hdev->num_blocks = __le16_to_cpu(rp->num_blocks);
|  +
|  +               hdev->block_cnt = hdev->num_blocks;
|  +       }
<------8<--------------------------------------------------------------

Best regards 
Andrei Emeltchenko 
