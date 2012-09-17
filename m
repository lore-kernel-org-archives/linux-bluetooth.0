Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 04/17] Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc
Date: Mon, 17 Sep 2012 16:24:21 +0300
Message-Id: <1347888274-30779-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Get AMP Assoc Request execute Read Local AMP Assoc
HCI command to AMP controller. If the AMP Assoc data is larger then it
can fit to HCI event only fragment is read. When all fragments are read
send A2MP Get AMP Assoc Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    2 ++
 include/net/bluetooth/amp.h      |   21 ++++++++++++++
 include/net/bluetooth/hci.h      |    2 ++
 include/net/bluetooth/hci_core.h |    8 ++++++
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |   56 ++++++++++++++++++++++++++++++++++----
 net/bluetooth/amp.c              |   45 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   41 ++++++++++++++++++++++++++++
 8 files changed, 171 insertions(+), 6 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/amp.c

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index c21268a..f9010c0 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -28,6 +28,7 @@ struct amp_mgr {
 	__u8			handle;
 	enum {
 		READ_LOC_AMP_INFO,
+		READ_LOC_AMP_ASSOC,
 	} state;
 	unsigned long		flags;
 };
@@ -132,5 +133,6 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
 void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
+void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
new file mode 100644
index 0000000..e861675
--- /dev/null
+++ b/include/net/bluetooth/amp.h
@@ -0,0 +1,21 @@
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
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+
+#endif /* __AMP_H */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 42aae18..1cb8b55 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -33,6 +33,8 @@
 #define HCI_LINK_KEY_SIZE	16
 #define HCI_AMP_LINK_KEY_SIZE	(2 * HCI_LINK_KEY_SIZE)
 
+#define HCI_MAX_AMP_ASSOC_SIZE	672
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a3337e..1174218 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -124,6 +124,12 @@ struct le_scan_params {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+struct amp_assoc {
+	__u16	len;
+	__u16	offset;
+	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -177,6 +183,8 @@ struct hci_dev {
 	__u32		amp_max_flush_to;
 	__u32		amp_be_flush_to;
 
+	struct amp_assoc	loc_assoc;
+
 	__u8		flow_ctl_mode;
 
 	unsigned int	auto_accept_delay;
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
index 0e97b3b..7140061 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* Global AMP Manager list */
 LIST_HEAD(amp_mgr_list);
@@ -218,26 +219,37 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 {
 	struct a2mp_amp_assoc_req *req = (void *) skb->data;
 	struct hci_dev *hdev;
+	struct amp_mgr *tmp;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
 
 	BT_DBG("id %d", req->id);
 
+	/* Make sure that other request is not processed */
+	tmp = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC);
+
 	hdev = hci_dev_get(req->id);
-	if (!hdev || hdev->amp_type == HCI_BREDR) {
+	if (!hdev || hdev->amp_type == HCI_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
 		rsp.id = req->id;
-		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+
+		if (tmp) {
+			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
+			amp_mgr_put(tmp);
+		} else {
+			rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
+		}
 
 		a2mp_send(mgr, A2MP_GETAMPASSOC_RSP, hdr->ident, sizeof(rsp),
 			  &rsp);
-		goto clean;
+
+		goto done;
 	}
 
-	/* Placeholder for HCI Read AMP Assoc */
+	amp_read_loc_assoc(hdev, mgr);
 
-clean:
+done:
 	if (hdev)
 		hci_dev_put(hdev);
 
@@ -624,3 +636,37 @@ void a2mp_send_getinfo_rsp(struct hci_dev *hdev)
 	a2mp_send(mgr, A2MP_GETINFO_RSP, mgr->ident, sizeof(rsp), &rsp);
 	amp_mgr_put(mgr);
 }
+
+void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
+{
+	struct amp_mgr *mgr;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+	struct a2mp_amp_assoc_rsp *rsp;
+	size_t len;
+
+	mgr = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC);
+	if (!mgr)
+		return;
+
+	BT_DBG("%s mgr %p", hdev->name, mgr);
+
+	len = sizeof(struct a2mp_amp_assoc_rsp) + loc_assoc->len;
+	rsp = kzalloc(len, GFP_KERNEL);
+	if (!rsp) {
+		amp_mgr_put(mgr);
+		return;
+	}
+
+	rsp->id = hdev->id;
+
+	if (status) {
+		rsp->status = A2MP_STATUS_INVALID_CTRL_ID;
+	} else {
+		rsp->status = A2MP_STATUS_SUCCESS;
+		memcpy(rsp->amp_assoc, loc_assoc->data, loc_assoc->len);
+	}
+
+	a2mp_send(mgr, A2MP_GETAMPASSOC_RSP, mgr->ident, len, rsp);
+	amp_mgr_put(mgr);
+	kfree(rsp);
+}
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
new file mode 100644
index 0000000..2d4e79e
--- /dev/null
+++ b/net/bluetooth/amp.c
@@ -0,0 +1,45 @@
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
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
+
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+
+	BT_DBG("%s handle %d", hdev->name, phy_handle);
+
+	cp.phy_handle = phy_handle;
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+	cp.len_so_far = cpu_to_le16(loc_assoc->offset);
+
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+}
+
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+
+	memset(&hdev->loc_assoc, 0, sizeof(struct amp_assoc));
+	memset(&cp, 0, sizeof(cp));
+
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+
+	mgr->state = READ_LOC_AMP_ASSOC;
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5ae5121..6cc44cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -31,6 +31,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* Handle HCI Event packets */
 
@@ -866,6 +867,42 @@ a2mp_rsp:
 	a2mp_send_getinfo_rsp(hdev);
 }
 
+static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *) skb->data;
+	struct amp_assoc *assoc = &hdev->loc_assoc;
+	size_t rem_len, frag_len;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		goto a2mp_rsp;
+
+	frag_len = skb->len - sizeof(*rp);
+	rem_len = __le16_to_cpu(rp->rem_len);
+
+	if (rem_len > frag_len) {
+		BT_DBG("frag_len %d rem_len %d", frag_len, rem_len);
+
+		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
+		assoc->offset += frag_len;
+
+		/* Read other fragments */
+		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
+
+		return;
+	}
+
+	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
+	assoc->len = assoc->offset + rem_len;
+	assoc->offset = 0;
+
+a2mp_rsp:
+	/* Send A2MP Rsp when all fragments are received */
+	a2mp_send_getampassoc_rsp(hdev, rp->status);
+}
+
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
@@ -2302,6 +2339,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_local_amp_info(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_AMP_ASSOC:
+		hci_cc_read_local_amp_assoc(hdev, skb);
+		break;
+
 	case HCI_OP_DELETE_STORED_LINK_KEY:
 		hci_cc_delete_stored_link_key(hdev, skb);
 		break;
-- 
1.7.9.5

