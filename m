Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 10:37:42 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 17/17] Bluetooth: A2MP: Manage incoming connections
Message-ID: <20120522073739.GA15818@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337351150-20526-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1205211530290.2239@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205211530290.2239@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, May 21, 2012 at 03:45:38PM -0700, Mat Martineau wrote:
...
> >@@ -4652,10 +4653,15 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
> >
> >	chan = l2cap_get_chan_by_scid(conn, cid);
> >	if (!chan) {
> >-		BT_DBG("unknown cid 0x%4.4x", cid);
> >-		/* Drop packet and return */
> >-		kfree_skb(skb);
> >-		return 0;
> >+		if (cid == L2CAP_CID_A2MP) {
> >+			chan = a2mp_channel_create(conn, skb);
> 
> This allocates a new AMP manager for each incoming command, doesn't
> it?  I'd expect the manager to be created once when it is first
> needed, then remain active until the ACL is closed.

No. If AMP channel exist it will be returned with l2cap_get_chan_by_scid.
Channel exist while ACL connection exist.

> >-- 
> >1.7.9.5
> 
> How do you plan to create an AMP manager if you don't get an A2MP
> command from the remote device first?

I have code which is not yet sent. Something like:

+void l2cap_discover_amp(struct l2cap_conn *conn)
+{
+	struct a2mp_discov_req req;
+	struct amp_mgr *mgr;
+
+	BT_DBG("%p", conn);
+
+	mgr = amp_mgr_lookup(conn);
+	if (!mgr) {
+		mgr = amp_mgr_create(conn);
+		if (!mgr)
+			return;
+		else
+			amp_mgr_get(mgr);
+	}
+
+	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
+	req.ext_feat = 0;
+	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
+
+	amp_mgr_put(mgr);
+}

Best regards 
Andrei Emeltchenko 

