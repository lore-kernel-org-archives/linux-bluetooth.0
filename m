Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH bluetooth-next] Added force_acl_master param for bluetooth module
Date: Mon, 12 Sep 2011 06:32:57 +0300
Message-Id: <1315798377-3660-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

This param allows role switch request while accepting a new acl
connection. This is an enhancement to l2cap L2CAP_LM role switching
capability which allows requesting role switch without modification
to the application code. It was observed that operating as a master
of piconet (as oposed to scatternet config) is beneficial when
qos (flow_spec) guarantees are requested.

Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
---
 net/bluetooth/hci_event.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8483cab..5b39b2e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -46,6 +46,7 @@
 #include <net/bluetooth/hci_core.h>
 
 static int enable_le;
+static int force_acl_master = 0;
 
 /* Handle HCI Event packets */
 
@@ -1505,7 +1506,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
 
-			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
+			if (lmp_rswitch_capable(hdev) &&
+				((mask & HCI_LM_MASTER) || force_acl_master))
 				cp.role = 0x00; /* Become master */
 			else
 				cp.role = 0x01; /* Remain slave */
@@ -3105,3 +3107,5 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 
 module_param(enable_le, bool, 0444);
 MODULE_PARM_DESC(enable_le, "Enable LE support");
+module_param(force_acl_master, bool, 0644);
+MODULE_PARM_DESC(force_acl_master, "Always try to switch to master role on ACL link");
-- 
1.7.1

