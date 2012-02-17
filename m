Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] Bluetooth: Prefix hex numbers with object name
Date: Fri, 17 Feb 2012 11:40:57 +0200
Message-Id: <1329471657-18278-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Several hex numbers were printed without object name which
complicates debugging.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c   |    2 +-
 net/bluetooth/l2cap_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f7a090c..5c712ae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -80,7 +80,7 @@ void hci_acl_connect(struct hci_conn *conn)
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
 
-	BT_DBG("%p", conn);
+	BT_DBG("hcon %p", conn);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 88968e7..37736c6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -217,7 +217,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
 {
-	BT_DBG("%p %s -> %s", chan, state_to_string(chan->state),
+	BT_DBG("chan %p %s -> %s", chan, state_to_string(chan->state),
 						state_to_string(state));
 
 	chan->state = state;
-- 
1.7.9

