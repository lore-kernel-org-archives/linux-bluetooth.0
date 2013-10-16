Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Ignore A2MP data on non-BR/EDR links
Date: Wed, 16 Oct 2013 11:37:00 +0300
Message-Id: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The A2MP CID is only valid for BR/EDR transports. We should ignore A2MP
data on non-BR/EDR links and refuse to create an amp_mgr object.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/a2mp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index fe32a33..efcd108 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -836,6 +836,9 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 {
 	struct amp_mgr *mgr;
 
+	if (conn->hcon->type != ACL_LINK)
+		return NULL;
+
 	mgr = amp_mgr_create(conn, false);
 	if (!mgr) {
 		BT_ERR("Could not create AMP manager");
-- 
1.8.3.1

