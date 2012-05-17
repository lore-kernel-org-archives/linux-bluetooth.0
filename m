Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org
Subject: [PATCH 1/2] Bluetooth: Fix early return from l2cap_chan_del
Date: Thu, 17 May 2012 16:20:13 -0700
Message-Id: <1337296814-3763-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
References: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a regression from commit
2ead70b8390d199ca04cd35311b51f5f3676079e that is present in all
kernels starting at v3.0.

When L2CAP information was moved to struct l2cap_chan, a check was
added to l2cap_chan_del to avoid certain cleanup operations when ERTM
or streaming mode had not yet been initialized.  The logic in the
check did not take in to account that chan->conf_state is set to 0 in
l2cap_chan_ready, so l2cap_chan_del failed to cancel timers and leaked
memory any time the ERTM queues or lists were not empty.

This change makes sure that l2cap_chan_del only returns early if
ERTM initialization was not performed.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1c7d1cd..452fcc4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -597,6 +597,7 @@ enum {
 	CONF_EWS_RECV,
 	CONF_LOC_CONF_PEND,
 	CONF_REM_CONF_PEND,
+	CONF_NOT_COMPLETE,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 24f144b..36edd42 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -391,6 +391,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 	chan->state = BT_OPEN;
 
 	atomic_set(&chan->refcnt, 1);
+	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
 	BT_DBG("chan %p", chan);
 
@@ -509,8 +510,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	release_sock(sk);
 
-	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
-			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
+	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
 	skb_queue_purge(&chan->tx_q);
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
