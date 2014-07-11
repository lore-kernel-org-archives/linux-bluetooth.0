Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Move struct hci_sec_filter next to its user
Date: Fri, 11 Jul 2014 05:36:39 +0200
Message-Id: <1405049800-40462-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is only single location using struct hci_sec_filter and with
that there is no point in putting this declaration into a global
header file. So move it right next to its user and make the code
a lot more simpler.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 9 ---------
 net/bluetooth/hci_sock.c         | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5c52a17d6326..e1930749fac7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1360,15 +1360,6 @@ struct hci_pinfo {
 	unsigned short   channel;
 };
 
-/* HCI security filter */
-#define HCI_SFLT_MAX_OGF  5
-
-struct hci_sec_filter {
-	__u32 type_mask;
-	__u32 event_mask[2];
-	__u32 ocf_mask[HCI_SFLT_MAX_OGF + 1][4];
-};
-
 /* ----- HCI requests ----- */
 #define HCI_REQ_DONE	  0
 #define HCI_REQ_PEND	  1
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c64728d571ae..7805fd1b4a78 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -41,6 +41,14 @@ static inline int hci_test_bit(int nr, void *addr)
 }
 
 /* Security filter */
+#define HCI_SFLT_MAX_OGF  5
+
+struct hci_sec_filter {
+	__u32 type_mask;
+	__u32 event_mask[2];
+	__u32 ocf_mask[HCI_SFLT_MAX_OGF + 1][4];
+};
+
 static struct hci_sec_filter hci_sec_filter = {
 	/* Packet types */
 	0x10,
-- 
1.9.3

