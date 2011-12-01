Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 14:25:46 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 5/6] Bluetooth: Add HCI Read Data Block Size function
Message-ID: <20111201122544.GC2216@aemeltch-MOBL1>
References: <1322645765-9519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322645765-9519-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322662959.26198.9.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322662959.26198.9.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 30, 2011 at 03:22:39PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Upstream Code Aurora function with minor trivial fixes.
> > Origin: git://codeaurora.org/kernel/msm.git
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      |    8 ++++++++
> >  include/net/bluetooth/hci_core.h |    2 ++
> >  net/bluetooth/hci_event.c        |   31 +++++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0290aeb..7d41bd7 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -741,6 +741,14 @@ struct hci_rp_read_bd_addr {
> >  	bdaddr_t bdaddr;
> >  } __packed;
> >  
> > +#define HCI_OP_READ_DATA_BLOCK_SIZE	0x100a
> > +struct hci_rp_read_data_block_size {
> > +	__u8     status;
> > +	__le16   max_acl_len;
> > +	__le16   block_len;
> > +	__le16   num_blocks;
> > +} __packed;
> > +
> >  #define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
> >  struct hci_cp_write_page_scan_activity {
> >  	__le16   interval;
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index a7fd63a..869ab72 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -172,6 +172,8 @@ struct hci_dev {
> >  
> >  	__u8		flow_ctl_mode;
> >  
> > +	__u16		block_len;
> > +
> >  	unsigned int	auto_accept_delay;
> >  
> >  	unsigned long	quirks;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index b743fc3..50482a6 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -774,6 +774,33 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
> >  	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
> >  }
> >  
> > +static void hci_cc_read_data_block_size(struct hci_dev *hdev,
> > +							struct sk_buff *skb)
> > +{
> > +	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
> > +
> > +	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> > +
> > +	if (rp->status)
> > +		return;
> > +
> > +	if (hdev->flow_ctl_mode == HCI_FLOW_CTL_MODE_BLOCK_BASED) {
> > +		hdev->acl_mtu  = __le16_to_cpu(rp->max_acl_len);
> > +		hdev->sco_mtu = 0;
> > +		hdev->block_len = __le16_to_cpu(rp->block_len);
> > +		/* acl_pkts indicates the number of blocks */
> > +		hdev->acl_pkts = __le16_to_cpu(rp->num_blocks);
> > +		hdev->sco_pkts = 0;
> > +		hdev->acl_cnt = hdev->acl_pkts;
> > +		hdev->sco_cnt = 0;
> > +	}
> 
> I am not sure we want to use the same fields that we use for packet
> based flow control.

I see this as a simplest way to reuse existing code.

> What happens if we switch between the modes? Do we re-read the size
> functions or how is that suppose to work out?
> 
> We could trigger the reading of the block size or packet size buffer
> information based on the success of changing the flow control mode or an
> initial reading of the flow control mode.
> 
> So the buffer command is triggered from hci_cc_read_flow_control_mode
> function and you just need to trigger the reading of flow control mode
> from the init functions.

This can be done in a separate patch.

> To this extend we might then just change the init handling anyway and
> have special HCI_INIT checks in the event callbacks that trigger the
> next command to send. Make it true asynchronous and be able to react on
> previous read information.

Maybe FLOW_CTRL_INIT ?

> Just some thoughts here. Especially we might actually wanna deal with
> AMP controller in packet based mode or BR/EDR controllers in block based
> mode. Even if that is just for testing purposes.

I think this is why we reuse existing fields.

Best regards 
Andrei Emeltchenko 
