Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 13:50:28 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Create empty l2cap ops function
Message-ID: <20120529165028.GE4575@joana>
References: <1338308366-11465-1-git-send-email-gustavo@padovan.org>
 <alpine.DEB.2.02.1205290926490.16153@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205290926490.16153@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-29 09:41:45 -0700]:

> 
> Gustavo -
> 
> On Tue, 29 May 2012, Gustavo Padovan wrote:
> 
> >From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> >
> >A2MP doesn't use part of the L2CAP chan ops API so we just create general
> >empty function instead of the A2MP specific one.
> >
> >Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> >---
> >include/net/bluetooth/l2cap.h |   12 ++++++++++++
> >net/bluetooth/a2mp.c          |   23 +++--------------------
> >2 files changed, 15 insertions(+), 20 deletions(-)
> >
> >diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >index a00b43e..b939e90 100644
> >--- a/include/net/bluetooth/l2cap.h
> >+++ b/include/net/bluetooth/l2cap.h
> >@@ -740,6 +740,18 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
> >	return (seq + 1) % (chan->tx_win_max + 1);
> >}
> >
> >+static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
> >+{
> >+	return NULL;
> >+}
> >+
> >+static inline void l2cap_chan_no_teardown(struct l2cap_chan *chan, int err)
> >+{
> >+}
> >+
> >+static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
> >+{
> >+}
> >
> >extern bool disable_ertm;
> >
> >diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> >index e08ca2a..ec1ef2e 100644
> >--- a/net/bluetooth/a2mp.c
> >+++ b/net/bluetooth/a2mp.c
> >@@ -440,23 +440,6 @@ static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
> >	return bt_skb_alloc(len, GFP_KERNEL);
> >}
> >
> >-static struct l2cap_chan *a2mp_chan_no_new_conn_cb(struct l2cap_chan *chan)
> >-{
> >-	BT_ERR("new_connection for chan %p not implemented", chan);
> >-
> >-	return NULL;
> >-}
> >-
> >-static void a2mp_chan_no_teardown_cb(struct l2cap_chan *chan, int err)
> >-{
> >-	BT_ERR("teardown for chan %p not implemented", chan);
> >-}
> >-
> >-static void a2mp_chan_no_ready(struct l2cap_chan *chan)
> >-{
> >-	BT_ERR("ready for chan %p not implemented", chan);
> >-}
> >-
> >static struct l2cap_ops a2mp_chan_ops = {
> >	.name = "L2CAP A2MP channel",
> >	.recv = a2mp_chan_recv_cb,
> >@@ -465,9 +448,9 @@ static struct l2cap_ops a2mp_chan_ops = {
> >	.alloc_skb = a2mp_chan_alloc_skb_cb,
> >
> >	/* Not implemented for A2MP */
> >-	.new_connection = a2mp_chan_no_new_conn_cb,
> >-	.teardown = a2mp_chan_no_teardown_cb,
> >-	.ready = a2mp_chan_no_ready,
> >+	.new_connection = l2cap_chan_no_new_connection,
> >+	.teardown = l2cap_chan_no_teardown,
> >+	.ready = l2cap_chan_no_ready,
> >};
> >
> >static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
> >-- 
> >1.7.10.2
> 
> If these pointers all need to be populated, will you also remove the
> NULL checks for the callbacks in l2cap_core.c?

Yes, one of my patchset that is on the mailing list do this.

>Maybe the callbacks
> could be validated once when the l2cap_chan is set up.

I think it's pointless, we are the only user of our API, so we can make sure
we won't have NULL pointer floating around.

	Gustavo
