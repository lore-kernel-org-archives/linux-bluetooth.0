Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 12/34] Bluetooth: Add state_change for A2MP channel
Date: Thu, 19 Jan 2012 11:20:01 +0200
Message-Id: <1326964823-26747-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove AMP Manager when A2MP channel closed.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 3e306dc..6520b65 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,24 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+static void a2mp_chan_state_change_cb(void *data, int state)
+{
+	struct l2cap_chan *chan = data;
+	struct amp_mgr *mgr;
+
+	BT_DBG("chan %p state %d", chan, state);
+
+	chan->state = state;
+
+	switch (state) {
+	case BT_CLOSED:
+		mgr = chan->data;
+		if (mgr)
+			amp_mgr_put(mgr);
+		break;
+	}
+}
+
 static void a2mp_chan_close_cb(void *data)
 {
 	struct amp_mgr *mgr = data;
@@ -26,6 +44,7 @@ static void a2mp_chan_close_cb(void *data)
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
 	.close		= a2mp_chan_close_cb,
+	.state_change	= a2mp_chan_state_change_cb,
 };
 
 static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
@@ -68,6 +87,8 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
 	chan->remote_mps = chan->omtu;
 	chan->mps = chan->omtu;
 
+	chan->ops->state_change(chan, BT_CONNECTED);
+
 	return chan;
 }
 
-- 
1.7.4.1

