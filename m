Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 00:23:17 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 2/7] Bluetooth: Use enhanced L2CAP header structure and
 symbolic values.
Message-ID: <20100811032316.GA9130@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-3-git-send-email-mathewm@codeaurora.org>
 <20100810220712.GC3203@vigoh>
 <alpine.DEB.2.00.1008101916090.6276@linux-sea-02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1008101916090.6276@linux-sea-02>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 19:24:20 -0700]:

> 
> 
> Gustavo -
> 
> On Tue, 10 Aug 2010, Gustavo F. Padovan wrote:
> 
> >Hi Mat,
> >
> >* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:14:59 -0700]:
> >
> >>
> >>Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >>---
> >> net/bluetooth/l2cap.c |   23 +++++++++++++----------
> >> 1 files changed, 13 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> >>index 5e78c18..aa69c84 100644
> >>--- a/net/bluetooth/l2cap.c
> >>+++ b/net/bluetooth/l2cap.c
> >>@@ -1753,33 +1753,36 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
> >> {
> >> 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
> >> 	struct sk_buff *skb;
> >>-	int err, count, hlen = L2CAP_HDR_SIZE + 2;
> >>-	struct l2cap_hdr *lh;
> >>+	int err, count, hlen = L2CAP_ENHANCED_HDR_SIZE;
> >>+	struct l2cap_enhanced_hdr *lh;
> >
> >This patch shouldn't even compile. Since there no definition for
> >struct l2cap_enhanced_hdr. Anyway we should not have that struct, keep
> >the code to handle this as it is.
> >We'll have to change this code again to add the extended control bit
> >field.
> 
> Sorry about that - I did my git format-patch starting one commit too
> late.
> 
> I also have an l2cap_extended_hdr struct to add later, but it sounds
> like you don't want that one either.

Get rid of that one too. It's better do not have that extra
complication.

By the way, I think we can hide the handle of extended and enhanced
control fields inside the macros to get control bit fields. So we won't
have to care about that in the code. We still have to talk about that.

> 
> >
> >>
> >>-	BT_DBG("sk %p len %d", sk, (int)len);
> >>+	BT_DBG("sk %p, msg %p, len %d, control %x, sdulen %d",
> >>+		sk, msg, (int)len, control, (int)sdulen);
> >>
> >> 	if (!conn)
> >> 		return ERR_PTR(-ENOTCONN);
> >>
> >> 	if (sdulen)
> >>-		hlen += 2;
> >>+		hlen += L2CAP_SDULEN_SIZE;
> >
> >Separated patch to add L2CAP_SDULEN_SIZE
> 
> Ok.
> 
> >>
> >> 	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
> >>-		hlen += 2;
> >>+		hlen += L2CAP_FCS_SIZE;
> >
> >Separated patch to ad L2CAP_FCS_SIZE
> 
> Ok.  Does this need to be separate from the L2CAP_SDULEN_SIZE patch?

It depends. If we have few occurrence of that macros, they could be in
same patch.


-- 
Gustavo F. Padovan
http://padovan.org
