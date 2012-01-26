Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use list _safe when deleting element
Date: Thu, 26 Jan 2012 15:10:43 +0200
Message-Id: <1327583443-14081-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes possible bug when deleting element from the list in
function hci_chan_list_flush. list_for_each_entry_rcu is used
and after deleting element from the list we also free pointer
and then list_entry_rcu is taken from freed pointer.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cdb6a3f..e74d2a7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -982,10 +982,10 @@ int hci_chan_del(struct hci_chan *chan)
 
 void hci_chan_list_flush(struct hci_conn *conn)
 {
-	struct hci_chan *chan;
+	struct hci_chan *chan, *n;
 
 	BT_DBG("conn %p", conn);
 
-	list_for_each_entry_rcu(chan, &conn->chan_list, list)
+	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
 }
-- 
1.7.4.1

