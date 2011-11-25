Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/9] Bluetooth: Add structs to implement LE scan
Date: Fri, 25 Nov 2011 20:53:41 -0300
Message-Id: <1322265226-6404-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_dev the structs needed to implement the
LE scan infra-structure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2d7514..a48c699 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -121,6 +121,13 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct le_scan_params {
+	u8 type;
+	u16 interval;
+	u16 window;
+	int timeout;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -252,6 +259,10 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
+	struct work_struct	le_scan;
+	struct le_scan_params	le_scan_params;
+	struct timer_list	le_scan_timer;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
-- 
1.7.7.1

