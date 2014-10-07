Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/3] Bluetooth: Remove redundant check on hci_conn's device class
Date: Tue,  7 Oct 2014 08:44:12 +0000
Message-Id: <1412671452-24854-4-git-send-email-fons@spotify.com>
In-Reply-To: <1412671452-24854-1-git-send-email-fons@spotify.com>
References: <1412671452-24854-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NULL-checking conn->dev_class is pointless since the variable is
defined as an array, i.e. it will always be non-NULL.

Signed-off-by: Alfonso Acosta <fons@spotify.com>
---
 net/bluetooth/mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 10caab5..3fd88b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6196,8 +6196,7 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 			eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
 						  name, name_len);
 
-		if (conn->dev_class &&
-		    memcmp(conn->dev_class, "\0\0\0", 3) != 0)
+		if (memcmp(conn->dev_class, "\0\0\0", 3) != 0)
 			eir_len = eir_append_data(ev->eir, eir_len,
 						  EIR_CLASS_OF_DEV,
 						  conn->dev_class, 3);
-- 
1.9.1

