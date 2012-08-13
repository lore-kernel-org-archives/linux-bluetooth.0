Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 03/20] Bluetooth: AMP: Use HCI callback for Read AMP Info
Date: Mon, 13 Aug 2012 16:50:21 +0300
Message-Id: <1344865838-9165-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Get Info Request execute Read Local AMP Info HCI
command to AMP controller with callback to be executed upon receiving
command complete event. Callback will handle A2MP Get Info Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    1 +
 include/net/bluetooth/amp.h  |   19 +++++++++++++
 net/bluetooth/Makefile       |    2 +-
 net/bluetooth/a2mp.c         |   28 +++++++++---------
 net/bluetooth/amp.c          |   64 ++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c    |    6 +++-
 6 files changed, 104 insertions(+), 16 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/amp.c

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6a76e0a..ec77ddc 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -122,5 +122,6 @@ void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
new file mode 100644
index 0000000..ec7bea7
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
+void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
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
index 3d872db..3580f3d 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
@@ -37,8 +38,7 @@ static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 	return cmd;
 }
 
-static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
-		      void *data)
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 {
 	struct l2cap_chan *chan = mgr->a2mp_chan;
 	struct a2mp_cmd *cmd;
@@ -189,24 +189,24 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	BT_DBG("id %d", req->id);
 
-	rsp.id = req->id;
-	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
-
 	hdev = hci_dev_get(req->id);
-	if (hdev && hdev->amp_type != HCI_BREDR) {
-		rsp.status = 0;
-		rsp.total_bw = cpu_to_le32(hdev->amp_total_bw);
-		rsp.max_bw = cpu_to_le32(hdev->amp_max_bw);
-		rsp.min_latency = cpu_to_le32(hdev->amp_min_latency);
-		rsp.pal_cap = cpu_to_le16(hdev->amp_pal_cap);
-		rsp.assoc_size = cpu_to_le16(hdev->amp_assoc_size);
-	}
+	if (!hdev)
+		goto send_err;
 
-	if (hdev)
+	if (hdev->dev_type != HCI_BREDR) {
+		amp_read_loc_info(hdev, mgr);
+		goto done;
+	} else {
 		hci_dev_put(hdev);
+	}
+
+send_err:
+	rsp.id = req->id;
+	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 
 	a2mp_send(mgr, A2MP_GETINFO_RSP, hdr->ident, sizeof(rsp), &rsp);
 
+done:
 	skb_pull(skb, sizeof(*req));
 	return 0;
 }
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
new file mode 100644
index 0000000..f26a014
--- /dev/null
+++ b/net/bluetooth/amp.c
@@ -0,0 +1,64 @@
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
+static void amp_read_loc_info_complete_cb(struct hci_dev *hdev,
+					  struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct a2mp_info_rsp rsp;
+
+	BT_DBG("%s cmd %p mgr %p", hdev->name, cmd, cmd->opt);
+
+	rsp.id = hdev->id;
+	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+
+	if (hdev->amp_type != HCI_BREDR) {
+		rsp.status = 0;
+		rsp.total_bw = cpu_to_le32(hdev->amp_total_bw);
+		rsp.max_bw = cpu_to_le32(hdev->amp_max_bw);
+		rsp.min_latency = cpu_to_le32(hdev->amp_min_latency);
+		rsp.pal_cap = cpu_to_le16(hdev->amp_pal_cap);
+		rsp.assoc_size = cpu_to_le16(hdev->amp_assoc_size);
+	}
+
+	a2mp_send(mgr, A2MP_GETINFO_RSP, mgr->ident, sizeof(rsp), &rsp);
+}
+
+static void cb_destructor(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+
+	BT_DBG("Destructor cmd %p mgr %p", cmd, mgr);
+
+	hci_dev_put(hdev);
+	amp_mgr_put(mgr);
+	kfree(cmd);
+}
+
+void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	BT_DBG("%s mgr %p", hdev->name, mgr);
+
+	amp_mgr_get(mgr);
+
+	hci_callback_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL,
+			      amp_read_loc_info_complete_cb, mgr,
+			      cb_destructor, GFP_KERNEL);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f3a4568..0468ab0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -29,6 +29,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
 
 /* Handle HCI Event packets */
 
@@ -845,7 +846,7 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto process_cb;
 
 	hdev->amp_status = rp->amp_status;
 	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
@@ -859,6 +860,9 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
+
+process_cb:
+	hci_callback_process(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
 }
 
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
-- 
1.7.9.5

