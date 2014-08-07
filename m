Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: Refactor l2cap_connect_cfm
Date: Thu,  7 Aug 2014 10:12:27 +0300
Message-Id: <1407395551-30810-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
References: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch is a simple refactoring of l2cap_connect_cfm to allow easier
extension of the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ff66d14cfd34..304fa444efd3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7270,13 +7270,16 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	if (!status) {
-		conn = l2cap_conn_add(hcon);
-		if (conn)
-			l2cap_conn_ready(conn);
-	} else {
+	if (status) {
 		l2cap_conn_del(hcon, bt_to_errno(status));
+		return;
 	}
+
+	conn = l2cap_conn_add(hcon);
+	if (!conn)
+		return;
+
+	l2cap_conn_ready(conn);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
-- 
1.9.3

