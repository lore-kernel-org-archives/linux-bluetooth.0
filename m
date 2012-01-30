Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use GFP_KERNEL in hci_conn_add()
Date: Mon, 30 Jan 2012 09:22:09 -0300
Message-Id: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is called in process context only, so it should use
GFP_KERNEL to allocate memory.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index eae7a53..9ec7b8e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -373,7 +373,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
-	conn = kzalloc(sizeof(struct hci_conn), GFP_ATOMIC);
+	conn = kzalloc(sizeof(struct hci_conn), GFP_KERNEL);
 	if (!conn)
 		return NULL;
 
-- 
1.7.8.4

