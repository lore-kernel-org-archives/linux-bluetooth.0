Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 4/9] Bluetooth: Constants declaration for SCO airmode
Date: Fri, 12 Jul 2013 18:05:38 +0200
Message-Id: <1373645143-7494-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchs define constants for SCO airmode from SCO voice setting. It refers
to Bluetooth Core V4.0 specification, Part E, Chap 6.12 which describe SCO
voice setting format.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 679b07f..69bdb67 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1215,4 +1215,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
+#define SCO_AIRMODE_MASK       0x0003
+#define SCO_AIRMODE_CVSD       0x0000
+#define SCO_AIRMODE_TRANSP     0x0003
+
 #endif /* __HCI_CORE_H */
-- 
1.7.9.5

