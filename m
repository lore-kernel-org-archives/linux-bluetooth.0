Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Move amp.h header file into net/bluetooth/
Date: Thu, 10 Oct 2013 12:56:14 -0700
Message-Id: <1381434976-36296-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The amp.h header file is only used internally by the bluetooth.ko
module and is not a public API. So make it local to the core
Bluetooth module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/amp.h | 54 ---------------------------------------------
 net/bluetooth/a2mp.c        |  3 ++-
 net/bluetooth/amp.c         |  3 ++-
 net/bluetooth/amp.h         | 54 +++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |  3 ++-
 net/bluetooth/l2cap_core.c  |  3 ++-
 6 files changed, 62 insertions(+), 58 deletions(-)
 delete mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/amp.h

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
deleted file mode 100644
index 7ea3db7..0000000
--- a/include/net/bluetooth/amp.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
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
-#ifndef __AMP_H
-#define __AMP_H
-
-struct amp_ctrl {
-	struct list_head	list;
-	struct kref		kref;
-	__u8			id;
-	__u16			assoc_len_so_far;
-	__u16			assoc_rem_len;
-	__u16			assoc_len;
-	__u8			*assoc;
-};
-
-int amp_ctrl_put(struct amp_ctrl *ctrl);
-void amp_ctrl_get(struct amp_ctrl *ctrl);
-struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr, u8 id);
-struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
-void amp_ctrl_list_flush(struct amp_mgr *mgr);
-
-struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
-			     u8 remote_id, bool out);
-
-int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
-
-void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
-void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
-void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
-void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
-				   struct hci_conn *hcon);
-void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
-			struct hci_conn *hcon);
-void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
-			struct hci_conn *hcon);
-void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
-void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
-void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
-void amp_create_logical_link(struct l2cap_chan *chan);
-void amp_disconnect_logical_link(struct hci_chan *hchan);
-void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
-
-#endif /* __AMP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b38d074..9ae32ce 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,7 +16,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
+
+#include "amp.h"
 
 /* Global AMP Manager list */
 LIST_HEAD(amp_mgr_list);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index d459ed4..b7b8f4e 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -15,9 +15,10 @@
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
 #include <crypto/hash.h>
 
+#include "amp.h"
+
 /* Remote AMP Controllers interface */
 void amp_ctrl_get(struct amp_ctrl *ctrl)
 {
diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
new file mode 100644
index 0000000..7ea3db7
--- /dev/null
+++ b/net/bluetooth/amp.h
@@ -0,0 +1,54 @@
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
+struct amp_ctrl {
+	struct list_head	list;
+	struct kref		kref;
+	__u8			id;
+	__u16			assoc_len_so_far;
+	__u16			assoc_rem_len;
+	__u16			assoc_len;
+	__u8			*assoc;
+};
+
+int amp_ctrl_put(struct amp_ctrl *ctrl);
+void amp_ctrl_get(struct amp_ctrl *ctrl);
+struct amp_ctrl *amp_ctrl_add(struct amp_mgr *mgr, u8 id);
+struct amp_ctrl *amp_ctrl_lookup(struct amp_mgr *mgr, u8 id);
+void amp_ctrl_list_flush(struct amp_mgr *mgr);
+
+struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
+			     u8 remote_id, bool out);
+
+int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
+
+void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct hci_conn *hcon);
+void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon);
+void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
+			struct hci_conn *hcon);
+void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
+void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
+void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
+void amp_create_logical_link(struct l2cap_chan *chan);
+void amp_disconnect_logical_link(struct hci_chan *hchan);
+void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
+
+#endif /* __AMP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ada3bf4..67316b3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -30,7 +30,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
+
+#include "amp.h"
 
 /* Handle HCI Event packets */
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 06e7173..09f6f61 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -38,7 +38,8 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
-#include <net/bluetooth/amp.h>
+
+#include "amp.h"
 
 bool disable_ertm;
 
-- 
1.8.3.1

