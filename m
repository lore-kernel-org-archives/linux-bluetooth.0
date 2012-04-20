Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 22/23] Bluetooth: AMP: Use HCI callback for Read AMP Info
Date: Fri, 20 Apr 2012 14:09:50 +0300
Message-Id: <1334920191-29308-23-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds Read Local AMP Info HCI command with callback to be executed
when receiving command complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |   19 +++++++++++++++++
 net/bluetooth/Makefile      |    2 +-
 net/bluetooth/a2mp.c        |    5 +++++
 net/bluetooth/amp.c         |   49 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |   13 ++++++++++--
 5 files changed, 85 insertions(+), 3 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/amp.c

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
new file mode 100644
index 0000000..2751bf6
--- /dev/null
+++ b/include/net/bluetooth/amp.h
@@ -0,0 +1,19 @@
+/*
+   Copyright (c) 2011,2012 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#ifndef __AMP_H
+#define __AMP_H
+
+int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+
+#endif /* __AMP_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index fa6d94a..dea6a28 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o
+	a2mp.o amp.o
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a49acb6..39a3009 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
@@ -90,6 +91,10 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 		cl[i].id = hdev->id;
 		cl[i].type = hdev->amp_type;
 		cl[i].status = hdev->amp_status;
+
+		read_unlock(&hci_dev_list_lock);
+		amp_read_loc_info(hdev, mgr);
+		read_lock(&hci_dev_list_lock);
 	}
 }
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
new file mode 100644
index 0000000..af009e0
--- /dev/null
+++ b/net/bluetooth/amp.c
@@ -0,0 +1,49 @@
+/*
+   Copyright (c) 2011,2012 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#include <linux/workqueue.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
+
+static void amp_read_loc_info_complete(struct hci_dev *hdev,
+				       struct hci_cb_cmd *cmd)
+{
+	BT_DBG("%s cmd %p mgr %p", hdev->name, cmd, cmd->opt);
+}
+
+static void cb_destructor(struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+
+	BT_DBG("Destructor cmd %p mgr %p", cmd, mgr);
+
+	amp_mgr_put(mgr);
+	kfree(cmd);
+}
+
+int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	int err = 0;
+
+	BT_DBG("%s mgr %p", hdev->name, mgr);
+
+	amp_mgr_get(mgr);
+
+	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL,
+		amp_read_loc_info_complete, mgr, cb_destructor, GFP_ATOMIC);
+
+	return err;
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a13f90..0282d78 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -43,6 +43,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
 
 /* Handle HCI Event packets */
 
@@ -848,14 +849,15 @@ static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
-		struct sk_buff *skb)
+							struct sk_buff *skb)
 {
 	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+	struct hci_cb_cmd *cmd;
 
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto send;
 
 	hdev->amp_status = rp->amp_status;
 	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
@@ -869,6 +871,13 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
+
+send:
+	cmd = hci_find_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO);
+	if (cmd) {
+		cmd->status = rp->status;
+		hci_queue_cb(hdev, cmd, hdev->workqueue);
+	}
 }
 
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
-- 
1.7.9.5

