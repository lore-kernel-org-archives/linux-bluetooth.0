Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: making enable_hs independent from L2CAP
Date: Fri, 18 Nov 2011 13:35:42 +0200
Message-Id: <1321616142-19038-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes bluetooth compiling when CONFIG_BT_L2CAP is not enabled

net/built-in.o: In function `hci_dev_open':
(.text+0xdce9a): undefined reference to `enable_hs'

Reported-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c   |    5 +++++
 net/bluetooth/l2cap_core.c |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2a0c8cf..9218888 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -54,6 +54,8 @@
 
 #define AUTO_OFF_TIMEOUT 2000
 
+int enable_hs;
+
 static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
@@ -2601,3 +2603,6 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
+
+module_param(enable_hs, bool, 0644);
+MODULE_PARM_DESC(enable_hs, "Enable High Speed");
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d63e670..bdbf919 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -57,7 +57,6 @@
 #include <net/bluetooth/smp.h>
 
 int disable_ertm;
-int enable_hs;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
@@ -4774,6 +4773,3 @@ void l2cap_exit(void)
 
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
-
-module_param(enable_hs, bool, 0644);
-MODULE_PARM_DESC(enable_hs, "Enable High Speed");
-- 
1.7.4.1

