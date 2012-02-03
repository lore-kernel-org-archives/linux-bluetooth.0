Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 6/7] Bluetooth: Clean up structures left unused
Date: Thu,  2 Feb 2012 21:08:04 -0300
Message-Id: <1328227685-27245-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the use of the new structures and lists for the SMP LTK's
we may remove some code that is now unused. No need to have extra
fields of information inside link_key now that it is only used
for Link Keys.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    4 ----
 include/net/bluetooth/hci_core.h |   16 ----------------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 83f045a..1b634e1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -270,10 +270,6 @@ enum {
 #define HCI_LK_UNAUTH_COMBINATION	0x04
 #define HCI_LK_AUTH_COMBINATION		0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
-/* The spec doesn't define types for SMP keys */
-#define HCI_LK_SMP_LTK			0x81
-#define HCI_LK_SMP_IRK			0x82
-#define HCI_LK_SMP_CSRK			0x83
 /* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
 #define HCI_SMP_STK			0x80
 #define HCI_SMP_STK_SLAVE		0x81
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6cf39d7..9ced7dc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -100,28 +100,12 @@ struct smp_ltk {
 	u8 val[16];
 } __packed;
 
-struct key_master_id {
-	__le16 ediv;
-	u8 rand[8];
-} __packed;
-
-struct link_key_data {
-	bdaddr_t bdaddr;
-	u8 type;
-	u8 val[16];
-	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
-} __packed;
-
 struct link_key {
 	struct list_head list;
 	bdaddr_t bdaddr;
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
 };
 
 struct oob_data {
-- 
1.7.8.1

