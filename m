Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 6/7] Bluetooth: AMP: Zero amp_mgr pointer if removed
Date: Fri, 12 Oct 2012 17:10:04 +0300
Message-Id: <1350051005-6015-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe64621..eed9c8e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -439,8 +439,10 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_chan_list_flush(conn);
 
-	if (conn->amp_mgr)
-		amp_mgr_put(conn->amp_mgr);
+	if (conn->amp_mgr) {
+		if (amp_mgr_put(conn->amp_mgr))
+			conn->amp_mgr = NULL;
+	}
 
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
-- 
1.7.9.5

