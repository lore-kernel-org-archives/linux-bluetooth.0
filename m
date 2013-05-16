Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 4/8] Bluetooth: Constants and macro declaration for SCO airmode
Date: Thu, 16 May 2013 19:34:01 +0200
Message-Id: <1368725646-4593-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchs define constants and macro for extracting SCO airmode from SCO
voice setting. It refers to Bluetooth Core V4.0 specification, Part E, Chap
6.12 which describe SCO voice setting format.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e9cf9fa..a6fd544 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1214,4 +1214,9 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
+#define SCO_AIRMODE_MASK       0x0003
+#define SCO_AIRMODE_CVSD       0x0000
+#define SCO_AIRMODE_TRANSP     0x0003
+#define hci_sco_airmode(setting) ((setting) & SCO_AIRMODE_MASK)
+
 #endif /* __HCI_CORE_H */
-- 
1.7.9.5

