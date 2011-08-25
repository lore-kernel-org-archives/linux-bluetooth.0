Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 10/13] Bluetooth: Fix setting the connection sec_level when encryption fails
Date: Thu, 25 Aug 2011 20:02:36 -0300
Message-Id: <1314313359-12652-11-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

If the encryption changed event indicates that happened an error we
should not set the security level of the connection.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7aa02e2..b6f1865 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -797,7 +797,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
-	if (conn->pending_sec_level > conn->sec_level)
+	if (!status && conn->pending_sec_level > conn->sec_level)
 		conn->sec_level = conn->pending_sec_level;
 
 	hci_proto_encrypt_cfm(conn, status, encrypt);
-- 
1.7.6

