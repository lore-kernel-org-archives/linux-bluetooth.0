Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:43:13 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 19/19] Bluetooth: A2MP: Manage incoming connections
Message-ID: <20120524114311.GT24715@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1205231627370.6526@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205231627370.6526@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 23, 2012 at 04:30:39PM -0700, Mat Martineau wrote:
> >+struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
> >+				       struct sk_buff *skb)
> >+{
> >+	struct amp_mgr *mgr;
> >+
> >+	mgr = amp_mgr_create(conn);
> >+
> >+	BT_DBG("mgr: %p chan %p", mgr, mgr->a2mp_chan);
> >+
> >+	return mgr->a2mp_chan;
> 
> mgr can be NULL.

...

> >	chan = l2cap_get_chan_by_scid(conn, cid);
> >	if (!chan) {
> >-		BT_DBG("unknown cid 0x%4.4x", cid);
> >-		/* Drop packet and return */
> >-		kfree_skb(skb);
> >-		return 0;
> >+		if (cid == L2CAP_CID_A2MP) {
> >+			chan = a2mp_channel_create(conn, skb);
> 
> If amp_mgr_create returned NULL, then you would have to handle NULL
> from a2mp_channel_create too.

I've taken all comment in my v3 patch series.

Best regards 
Andrei Emeltchenko 

