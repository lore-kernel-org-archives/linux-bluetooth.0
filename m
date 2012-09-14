Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 13:29:15 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 16/17] Bluetooth: A2MP: Add fallback to normal l2cap
 init sequence
Message-ID: <20120914102913.GG7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130935110.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130935110.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 09:39:57AM -0700, Mat Martineau wrote:
> >From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> >When there is no remote AMP controller found fallback to normal
> >L2CAP sequence.
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >---
> >include/net/bluetooth/l2cap.h |    1 +
> >net/bluetooth/a2mp.c          |   28 ++++++++++++++++++++++++++++
> >net/bluetooth/l2cap_core.c    |    2 +-
> >3 files changed, 30 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >index aba830f..0967f9e 100644
> >--- a/include/net/bluetooth/l2cap.h
> >+++ b/include/net/bluetooth/l2cap.h
> >@@ -769,5 +769,6 @@ int l2cap_ertm_init(struct l2cap_chan *chan);
> >void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> >void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> >void l2cap_chan_del(struct l2cap_chan *chan, int err);
> >+void l2cap_send_conn_req(struct l2cap_chan *chan);
> >
> >#endif /* __L2CAP_H */
> >diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> >index 39e0f95..05522ea 100644
> >--- a/net/bluetooth/a2mp.c
> >+++ b/net/bluetooth/a2mp.c
> >@@ -181,6 +181,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
> >	u16 len = le16_to_cpu(hdr->len);
> >	struct a2mp_cl *cl;
> >	u16 ext_feat;
> >+	bool found = false;
> >
> >	if (len < sizeof(*rsp))
> >		return -EINVAL;
> >@@ -211,6 +212,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
> >		if (cl->id != HCI_BREDR_ID && cl->type == HCI_AMP) {
> >			struct a2mp_info_req req;
> >
> >+			found = true;
> >			req.id = cl->id;
> >			a2mp_send(mgr, A2MP_GETINFO_REQ, __next_ident(mgr),
> >				  sizeof(req), &req);
> >@@ -220,6 +222,32 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
> >		cl = (void *) skb_pull(skb, sizeof(*cl));
> >	}
> >
> >+	/* Fall back to L2CAP init sequence */
> >+	if (!found) {
> >+		struct l2cap_conn *conn = mgr->l2cap_conn;
> >+		struct l2cap_chan *chan;
> >+
> >+		mutex_lock(&conn->chan_lock);
> >+
> >+		list_for_each_entry(chan, &conn->chan_l, list) {
> >+
> >+			BT_DBG("chan %p state %s", chan,
> >+			       state_to_string(chan->state));
> >+
> >+			if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> >+				continue;
> >+
> >+			l2cap_chan_lock(chan);
> >+
> >+			if (chan->state == BT_CONNECT)
> >+				l2cap_send_conn_req(chan);
> >+
> >+			l2cap_chan_unlock(chan);
> >+		}
> >+
> >+		mutex_unlock(&conn->chan_lock);
> >+	}
> >+
> >	return 0;
> >}
> >
> >diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >index cfe047f..d2ab82c 100644
> >--- a/net/bluetooth/l2cap_core.c
> >+++ b/net/bluetooth/l2cap_core.c
> >@@ -958,7 +958,7 @@ static bool __amp_capable(struct l2cap_chan *chan)
> >		return false;
> >}
> >
> >-static void l2cap_send_conn_req(struct l2cap_chan *chan)
> >+void l2cap_send_conn_req(struct l2cap_chan *chan)
> >{
> >	struct l2cap_conn *conn = chan->conn;
> >	struct l2cap_conn_req req;
> >-- 
> >1.7.9.5
> >
> >
> 
> Here's another place where we have duplicated functionality.  This
> patch has BR/EDR fallback too:
> 
> [RFCv1 13/20] Bluetooth: Handle physical link completion
> 
> You can call l2cap_physical_cfm() with a failure result instead of
> calling l2cap_send_conn_req() directly.

I suppose there is no such function yet, otherwise this can be done.

Best regards 
Andrei Emeltchenko 

