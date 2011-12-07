Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 8/8] Bluetooth: Only increase the connection sec-level if encryption is successful
Date: Tue,  6 Dec 2011 21:48:12 -0300
Message-Id: <1323218892-15785-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some case, mainly with LE connections, it is possible to get at that
point with a failed encryption.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 96407cf..7a7eec5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -849,7 +849,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
-	if (conn->pending_sec_level > conn->sec_level)
+	if (!status && conn->pending_sec_level > conn->sec_level)
 		conn->sec_level = conn->pending_sec_level;
 
 	hci_proto_encrypt_cfm(conn, status, encrypt);
-- 
1.7.8

