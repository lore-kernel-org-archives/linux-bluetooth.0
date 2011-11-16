Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] Bluetooth: Fix some checkpatch.pl errors and warnings
Date: Wed, 16 Nov 2011 09:32:21 +0100
Message-ID: <1321432342-8606-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
References: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_core.c   |    6 ++----
 net/bluetooth/l2cap_core.c |    5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb3feeb..6e4e446 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1336,14 +1336,12 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct bdaddr_list *entry;
 
-	if (bacmp(bdaddr, BDADDR_ANY) == 0) {
+	if (bacmp(bdaddr, BDADDR_ANY) == 0)
 		return hci_blacklist_clear(hdev);
-	}
 
 	entry = hci_blacklist_lookup(hdev, bdaddr);
-	if (!entry) {
+	if (!entry)
 		return -ENOENT;
-	}
 
 	list_del(&entry->list);
 	kfree(entry);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 26925a8..f79dbe8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -97,7 +97,6 @@ static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16
 			return c;
 	}
 	return NULL;
-
 }
 
 static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
@@ -1904,7 +1903,7 @@ static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
 {
 	struct l2cap_conf_efs efs;
 
-	switch(chan->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_ERTM:
 		efs.id		= chan->local_id;
 		efs.stype	= chan->local_stype;
@@ -3017,7 +3016,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
-		l2cap_state_change(chan,BT_DISCONN);
+		l2cap_state_change(chan, BT_DISCONN);
 		__clear_chan_timer(chan);
 		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		bh_unlock_sock(sk);
-- 
on behalf of ST-Ericsson

