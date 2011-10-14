Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 13:56:03 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 11/16] Bluetooth: EWS: handling different Control fields
Message-ID: <20111014105600.GA32656@aemeltch-MOBL1>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318329476-30153-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111013194925.GB20892@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013194925.GB20892@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 13, 2011 at 04:49:25PM -0300, Gustavo Padovan wrote:
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-11 13:37:51 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > There are three different Control Field formats: the Standard Control
> > Field, the Enhanced Control Field, and the Extended Control Field.
> > Patch adds function to handle all those fields seamlessly.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |   43 +++++++++++++++++++
> >  net/bluetooth/l2cap_core.c    |   93 +++++++++++++++++++++-------------------
> >  2 files changed, 92 insertions(+), 44 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 67a2fdb..3a5f4c0 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -27,6 +27,8 @@
> >  #ifndef __L2CAP_H
> >  #define __L2CAP_H
> >  
> > +#include <asm/unaligned.h>
> > +
> >  /* L2CAP defaults */
> >  #define L2CAP_DEFAULT_MTU		672
> >  #define L2CAP_DEFAULT_MIN_MTU		48
> > @@ -643,6 +645,47 @@ static inline bool __is_ctrl_poll(struct l2cap_chan *chan, __u32 ctrl)
> >  	else
> >  		return ctrl & L2CAP_CTRL_POLL;
> >  }
> > +
> > +static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
> > +{
> > +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> > +		return get_unaligned_le32(p);
> > +	else
> > +		return get_unaligned_le16(p);
> > +}
> > +
> > +static inline __u32 __get_control_pull(struct l2cap_chan *chan,
> > +		struct sk_buff *skb, void *p)
> > +{
> > +	__u32 ctrl;
> > +
> > +	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
> > +		ctrl = get_unaligned_le32(p);
> > +		skb_pull(skb, 4);
> > +	} else {
> > +		ctrl = get_unaligned_le16(p);
> > +		skb_pull(skb, 2);
> > +	}
> 
> 
> I prefer not hide the skb_pull inside another function.

OK, I will change it to something like:

<------8<----------------------------------------------------------------
|  @@ -4005,7 +4009,8 @@ static int l2cap_ertm_data_rcv(struct sock *sk,
|  struct sk_buff *skb)
|          u16 req_seq;
|          int len, next_tx_seq_offset, req_seq_offset;
|
|  -       control = __get_control_pull(chan, skb, skb->data);
|  +       control = __get_control(chan, skb->data);
|  +       skb_pull(skb, __get_ctrl_size(chan));
|          len = skb->len;
|
|          /*
|
<------8<----------------------------------------------------------------


> > +
> > +	return ctrl;
> > +}
> > +
> > +static inline void __put_control(struct l2cap_chan *chan, __u32 control, void *p)
> > +{
> > +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> > +		return put_unaligned_le32(control, p);
> > +	else
> > +		return put_unaligned_le16(control, p);
> > +}
> > +
> > +static inline void __put_control_put(struct l2cap_chan *chan, __u32 control, void *p)
> > +{
> > +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> > +		return put_unaligned_le32(control, skb_put(p, 4));
> > +	else
> > +		return put_unaligned_le16(control, skb_put(p, 2));
> > +}
> 
> 
> get ride of this, you still can do __put_control(chan, control,
> skb_put())
the second argument in skb_put changes so I cannot use proposed way.

what about change to code below:

<------8<--------------------------------------------------------
|  @@ -1586,6 +1588,7 @@ static struct sk_buff
|  *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
|          struct sk_buff *skb;
|          int err, count, hlen;
|          struct l2cap_hdr *lh;
|  +       unsigned char *data;
|
|          BT_DBG("sk %p len %d", sk, (int)len);
|
|  @@ -1614,7 +1617,8 @@ static struct sk_buff
|  *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
|          lh->cid = cpu_to_le16(chan->dcid);
|          lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
|
|  -       __put_control_put(chan, control, skb);
|  +       data = skb_put(skb, __get_ctrl_size(chan));
|  +       __put_control(chan, control, data);
|
|          if (sdulen)
|                  put_unaligned_le16(sdulen, skb_put(skb,
|  L2CAP_SDULEN_SIZE));
|
<------8<--------------------------------------------------------

Best regards 
Andrei Emeltchenko 
