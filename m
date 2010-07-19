Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: use __packed in drivers/bluetooth
Date: Mon, 19 Jul 2010 13:54:05 -0300
Message-Id: <1279558445-9910-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Use the __packed annotation instead of the __attribute__((packed)).

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/bpa10x.c     |    2 +-
 drivers/bluetooth/btmrvl_drv.h |    4 ++--
 drivers/bluetooth/dtl1_cs.c    |    2 +-
 drivers/bluetooth/hci_ll.c     |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index d945cd1..751b338 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -62,7 +62,7 @@ struct hci_vendor_hdr {
 	__u8    type;
 	__le16  snum;
 	__le16  dlen;
-} __attribute__ ((packed));
+} __packed;
 
 static int bpa10x_recv(struct hci_dev *hdev, int queue, void *buf, int count)
 {
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 872cb6c..90bda50 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -119,13 +119,13 @@ struct btmrvl_cmd {
 	__le16 ocf_ogf;
 	u8 length;
 	u8 data[4];
-} __attribute__ ((packed));
+} __packed;
 
 struct btmrvl_event {
 	u8 ec;		/* event counter */
 	u8 length;
 	u8 data[4];
-} __attribute__ ((packed));
+} __packed;
 
 /* Prototype of global function */
 
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index ef044d5..cbe9e44 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -104,7 +104,7 @@ typedef struct {
 	u8 type;
 	u8 zero;
 	u16 len;
-} __attribute__ ((packed)) nsh_t;	/* Nokia Specific Header */
+} __packed nsh_t;	/* Nokia Specific Header */
 
 #define NSHL  4				/* Nokia Specific Header Length */
 
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index fb8445c..5744aba 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -74,7 +74,7 @@ enum hcill_states_e {
 
 struct hcill_cmd {
 	u8 cmd;
-} __attribute__((packed));
+} __packed;
 
 struct ll_struct {
 	unsigned long rx_state;
-- 
1.7.1.1
