Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Move a2mp.h header file into net/bluetooth/
Date: Thu, 10 Oct 2013 12:56:15 -0700
Message-Id: <1381434976-36296-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The a2mp.h header file is only used internally by the bluetooth.ko
module and is not a public API. So make it local to the core
Bluetooth module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/a2mp.h | 150 -------------------------------------------
 net/bluetooth/a2mp.c         |   2 +-
 net/bluetooth/a2mp.h         | 150 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/amp.c          |   2 +-
 net/bluetooth/hci_conn.c     |   3 +-
 net/bluetooth/hci_event.c    |   2 +-
 net/bluetooth/l2cap_core.c   |   2 +-
 7 files changed, 156 insertions(+), 155 deletions(-)
 delete mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.h

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
deleted file mode 100644
index 487b54c..0000000
--- a/include/net/bluetooth/a2mp.h
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
-   Copyright (c) 2010,2011 Code Aurora Forum.  All rights reserved.
-   Copyright (c) 2011,2012 Intel Corp.
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 and
-   only version 2 as published by the Free Software Foundation.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-*/
-
-#ifndef __A2MP_H
-#define __A2MP_H
-
-#include <net/bluetooth/l2cap.h>
-
-#define A2MP_FEAT_EXT	0x8000
-
-enum amp_mgr_state {
-	READ_LOC_AMP_INFO,
-	READ_LOC_AMP_ASSOC,
-	READ_LOC_AMP_ASSOC_FINAL,
-	WRITE_REMOTE_AMP_ASSOC,
-};
-
-struct amp_mgr {
-	struct list_head	list;
-	struct l2cap_conn	*l2cap_conn;
-	struct l2cap_chan	*a2mp_chan;
-	struct l2cap_chan	*bredr_chan;
-	struct kref		kref;
-	__u8			ident;
-	__u8			handle;
-	unsigned long		state;
-	unsigned long		flags;
-
-	struct list_head	amp_ctrls;
-	struct mutex		amp_ctrls_lock;
-};
-
-struct a2mp_cmd {
-	__u8	code;
-	__u8	ident;
-	__le16	len;
-	__u8	data[0];
-} __packed;
-
-/* A2MP command codes */
-#define A2MP_COMMAND_REJ         0x01
-struct a2mp_cmd_rej {
-	__le16	reason;
-	__u8	data[0];
-} __packed;
-
-#define A2MP_DISCOVER_REQ        0x02
-struct a2mp_discov_req {
-	__le16	mtu;
-	__le16	ext_feat;
-} __packed;
-
-struct a2mp_cl {
-	__u8	id;
-	__u8	type;
-	__u8	status;
-} __packed;
-
-#define A2MP_DISCOVER_RSP        0x03
-struct a2mp_discov_rsp {
-	__le16     mtu;
-	__le16     ext_feat;
-	struct a2mp_cl cl[0];
-} __packed;
-
-#define A2MP_CHANGE_NOTIFY       0x04
-#define A2MP_CHANGE_RSP          0x05
-
-#define A2MP_GETINFO_REQ         0x06
-struct a2mp_info_req {
-	__u8       id;
-} __packed;
-
-#define A2MP_GETINFO_RSP         0x07
-struct a2mp_info_rsp {
-	__u8	id;
-	__u8	status;
-	__le32	total_bw;
-	__le32	max_bw;
-	__le32	min_latency;
-	__le16	pal_cap;
-	__le16	assoc_size;
-} __packed;
-
-#define A2MP_GETAMPASSOC_REQ     0x08
-struct a2mp_amp_assoc_req {
-	__u8	id;
-} __packed;
-
-#define A2MP_GETAMPASSOC_RSP     0x09
-struct a2mp_amp_assoc_rsp {
-	__u8	id;
-	__u8	status;
-	__u8	amp_assoc[0];
-} __packed;
-
-#define A2MP_CREATEPHYSLINK_REQ  0x0A
-#define A2MP_DISCONNPHYSLINK_REQ 0x0C
-struct a2mp_physlink_req {
-	__u8	local_id;
-	__u8	remote_id;
-	__u8	amp_assoc[0];
-} __packed;
-
-#define A2MP_CREATEPHYSLINK_RSP  0x0B
-#define A2MP_DISCONNPHYSLINK_RSP 0x0D
-struct a2mp_physlink_rsp {
-	__u8	local_id;
-	__u8	remote_id;
-	__u8	status;
-} __packed;
-
-/* A2MP response status */
-#define A2MP_STATUS_SUCCESS			0x00
-#define A2MP_STATUS_INVALID_CTRL_ID		0x01
-#define A2MP_STATUS_UNABLE_START_LINK_CREATION	0x02
-#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS	0x02
-#define A2MP_STATUS_COLLISION_OCCURED		0x03
-#define A2MP_STATUS_DISCONN_REQ_RECVD		0x04
-#define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
-#define A2MP_STATUS_SECURITY_VIOLATION		0x06
-
-extern struct list_head amp_mgr_list;
-extern struct mutex amp_mgr_list_lock;
-
-struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
-int amp_mgr_put(struct amp_mgr *mgr);
-u8 __next_ident(struct amp_mgr *mgr);
-struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
-				       struct sk_buff *skb);
-struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
-void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
-void a2mp_discover_amp(struct l2cap_chan *chan);
-void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
-void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
-void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
-void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status);
-
-#endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 9ae32ce..7e25be3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -15,8 +15,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
-#include <net/bluetooth/a2mp.h>
 
+#include "a2mp.h"
 #include "amp.h"
 
 /* Global AMP Manager list */
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
new file mode 100644
index 0000000..487b54c
--- /dev/null
+++ b/net/bluetooth/a2mp.h
@@ -0,0 +1,150 @@
+/*
+   Copyright (c) 2010,2011 Code Aurora Forum.  All rights reserved.
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
+#ifndef __A2MP_H
+#define __A2MP_H
+
+#include <net/bluetooth/l2cap.h>
+
+#define A2MP_FEAT_EXT	0x8000
+
+enum amp_mgr_state {
+	READ_LOC_AMP_INFO,
+	READ_LOC_AMP_ASSOC,
+	READ_LOC_AMP_ASSOC_FINAL,
+	WRITE_REMOTE_AMP_ASSOC,
+};
+
+struct amp_mgr {
+	struct list_head	list;
+	struct l2cap_conn	*l2cap_conn;
+	struct l2cap_chan	*a2mp_chan;
+	struct l2cap_chan	*bredr_chan;
+	struct kref		kref;
+	__u8			ident;
+	__u8			handle;
+	unsigned long		state;
+	unsigned long		flags;
+
+	struct list_head	amp_ctrls;
+	struct mutex		amp_ctrls_lock;
+};
+
+struct a2mp_cmd {
+	__u8	code;
+	__u8	ident;
+	__le16	len;
+	__u8	data[0];
+} __packed;
+
+/* A2MP command codes */
+#define A2MP_COMMAND_REJ         0x01
+struct a2mp_cmd_rej {
+	__le16	reason;
+	__u8	data[0];
+} __packed;
+
+#define A2MP_DISCOVER_REQ        0x02
+struct a2mp_discov_req {
+	__le16	mtu;
+	__le16	ext_feat;
+} __packed;
+
+struct a2mp_cl {
+	__u8	id;
+	__u8	type;
+	__u8	status;
+} __packed;
+
+#define A2MP_DISCOVER_RSP        0x03
+struct a2mp_discov_rsp {
+	__le16     mtu;
+	__le16     ext_feat;
+	struct a2mp_cl cl[0];
+} __packed;
+
+#define A2MP_CHANGE_NOTIFY       0x04
+#define A2MP_CHANGE_RSP          0x05
+
+#define A2MP_GETINFO_REQ         0x06
+struct a2mp_info_req {
+	__u8       id;
+} __packed;
+
+#define A2MP_GETINFO_RSP         0x07
+struct a2mp_info_rsp {
+	__u8	id;
+	__u8	status;
+	__le32	total_bw;
+	__le32	max_bw;
+	__le32	min_latency;
+	__le16	pal_cap;
+	__le16	assoc_size;
+} __packed;
+
+#define A2MP_GETAMPASSOC_REQ     0x08
+struct a2mp_amp_assoc_req {
+	__u8	id;
+} __packed;
+
+#define A2MP_GETAMPASSOC_RSP     0x09
+struct a2mp_amp_assoc_rsp {
+	__u8	id;
+	__u8	status;
+	__u8	amp_assoc[0];
+} __packed;
+
+#define A2MP_CREATEPHYSLINK_REQ  0x0A
+#define A2MP_DISCONNPHYSLINK_REQ 0x0C
+struct a2mp_physlink_req {
+	__u8	local_id;
+	__u8	remote_id;
+	__u8	amp_assoc[0];
+} __packed;
+
+#define A2MP_CREATEPHYSLINK_RSP  0x0B
+#define A2MP_DISCONNPHYSLINK_RSP 0x0D
+struct a2mp_physlink_rsp {
+	__u8	local_id;
+	__u8	remote_id;
+	__u8	status;
+} __packed;
+
+/* A2MP response status */
+#define A2MP_STATUS_SUCCESS			0x00
+#define A2MP_STATUS_INVALID_CTRL_ID		0x01
+#define A2MP_STATUS_UNABLE_START_LINK_CREATION	0x02
+#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS	0x02
+#define A2MP_STATUS_COLLISION_OCCURED		0x03
+#define A2MP_STATUS_DISCONN_REQ_RECVD		0x04
+#define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
+#define A2MP_STATUS_SECURITY_VIOLATION		0x06
+
+extern struct list_head amp_mgr_list;
+extern struct mutex amp_mgr_list_lock;
+
+struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
+int amp_mgr_put(struct amp_mgr *mgr);
+u8 __next_ident(struct amp_mgr *mgr);
+struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
+				       struct sk_buff *skb);
+struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+void a2mp_discover_amp(struct l2cap_chan *chan);
+void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
+void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
+void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
+void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status);
+
+#endif /* __A2MP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index b7b8f4e..5497ed3 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -14,9 +14,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_core.h>
-#include <net/bluetooth/a2mp.h>
 #include <crypto/hash.h>
 
+#include "a2mp.h"
 #include "amp.h"
 
 /* Remote AMP Controllers interface */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dedd1ea..8141c8d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -28,9 +28,10 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
-#include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/smp.h>
 
+#include "a2mp.h"
+
 struct sco_param {
 	u16 pkt_type;
 	u16 max_latency;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 67316b3..bbe2d29 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -29,8 +29,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
-#include <net/bluetooth/a2mp.h>
 
+#include "a2mp.h"
 #include "amp.h"
 
 /* Handle HCI Event packets */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09f6f61..947e186 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -37,8 +37,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
-#include <net/bluetooth/a2mp.h>
 
+#include "a2mp.h"
 #include "amp.h"
 
 bool disable_ertm;
-- 
1.8.3.1

