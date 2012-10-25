Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 10/11] Bluetooth: Add put(hcon) when deleting hchan
Date: Thu, 25 Oct 2012 15:20:51 +0300
Message-Id: <1351167652-12346-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index dc331ce..25bfce0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -980,6 +980,8 @@ void hci_chan_del(struct hci_chan *chan)
 
 	synchronize_rcu();
 
+	hci_conn_put(conn);
+
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
 }
-- 
1.7.9.5

