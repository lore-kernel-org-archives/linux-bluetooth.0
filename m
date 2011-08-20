Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 10/11] Bluetooth: Fix setting the connection sec_level when encryption fails
Date: Fri, 19 Aug 2011 21:08:14 -0300
Message-Id: <1313798895-8705-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the encryption changed event indicates that happened an error we
should not set the security level of the connection.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ec3815a..536f87a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -782,7 +782,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
-	if (conn->pending_sec_level > conn->sec_level)
+	if (!status && conn->pending_sec_level > conn->sec_level)
 		conn->sec_level = conn->pending_sec_level;
 
 	hci_proto_encrypt_cfm(conn, status, encrypt);
-- 
1.7.6

