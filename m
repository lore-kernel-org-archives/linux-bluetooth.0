Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 8/8] Bluetooth: Add put(hcon) when deleting hchan
Date: Tue, 16 Oct 2012 18:01:10 +0300
Message-Id: <1350399670-12418-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When refcnt reaches zero disconnect timeout will run and hci_conn
will be disconnected.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe64621..6f9c2b3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -976,6 +976,8 @@ void hci_chan_del(struct hci_chan *chan)
 
 	synchronize_rcu();
 
+	hci_conn_put(conn);
+
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
 }
-- 
1.7.9.5

