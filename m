Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: trivial: Make hci_chan_del return void
Date: Thu,  6 Sep 2012 15:05:43 +0300
Message-Id: <1346933147-11789-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Return code is not needed in hci_chan_del

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa807a3..4704ca4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -552,7 +552,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
-int hci_chan_del(struct hci_chan *chan);
+void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4dc8227..c809063 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -935,7 +935,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	return chan;
 }
 
-int hci_chan_del(struct hci_chan *chan)
+void hci_chan_del(struct hci_chan *chan)
 {
 	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
@@ -948,8 +948,6 @@ int hci_chan_del(struct hci_chan *chan)
 
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
-
-	return 0;
 }
 
 void hci_chan_list_flush(struct hci_conn *conn)
-- 
1.7.9.5

