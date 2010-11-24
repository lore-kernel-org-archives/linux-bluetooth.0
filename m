Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 11:47:18 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 12/20] Bluetooth: fix receiving L2CAP packets over LE
Message-ID: <20101124144718.GA16200@eris.indt.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
 <1290524796-32246-13-git-send-email-vinicius.gomes@openbossa.org>
 <20101124053202.GH874@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101124053202.GH874@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On 07:32 Wed 24 Nov, Ville Tervo wrote:
> Hi,
> 
> 
> On Tue, Nov 23, 2010 at 12:06:28PM -0300, ext Vinicius Costa Gomes wrote:
> > As L2CAP packets coming over LE don't have any more encapsulation,
> > other than L2CAP, we are able to process them as soon as they arrive.
> > 
> 
> I thought this patch was only fixing symphoms of broken controller? LE frames
> should have same continuation bits as ACL. See Vol 2 Part E 5.4.2.

You are right. Broken controller. A better behaved one has the right flags.

Will drop this patch.

> 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/l2cap.c |   17 +++++++++++++++--
> >  1 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index e481d6b..0d168aa 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -4798,17 +4798,30 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> >  static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >  {
> >  	struct l2cap_conn *conn = hcon->l2cap_data;
> > +	struct l2cap_hdr *hdr;
> > +	int len;
> >  
> >  	if (!conn && !(conn = l2cap_conn_add(hcon, 0)))
> >  		goto drop;
> >  
> >  	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
> >  
> > +	if (hcon->type == LE_LINK) {
> > +		hdr = (struct l2cap_hdr *) skb->data;
> > +		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
> > +
> > +		if (len == skb->len) {
> > +			/* Complete frame received */
> > +			l2cap_recv_frame(conn, skb);
> > +			return 0;
> > +		}
> > +
> > +		goto drop;
> > +	}
> > +
> >  	if (flags & ACL_START) {
> > -		struct l2cap_hdr *hdr;
> >  		struct sock *sk;
> >  		u16 cid;
> > -		int len;
> >  
> >  		if (conn->rx_len) {
> >  			BT_ERR("Unexpected start frame (len %d)", skb->len);
> > -- 
> > 1.7.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
