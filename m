Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Add generic mgmt helper API
Date: Tue, 17 Mar 2015 13:48:48 +0200
Message-Id: <1426592930-5842-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several mgmt protocol features that will be needed by more
than just the current HCI_CHANNEL_CONTROL. These include sending generic
events as well as handling pending commands. This patch moves these
functions out from mgmt.c to a new mgmt_util.c file.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/Makefile    |   2 +-
 net/bluetooth/mgmt.c      | 197 +------------------------------------------
 net/bluetooth/mgmt_util.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt_util.h |  53 ++++++++++++
 4 files changed, 265 insertions(+), 197 deletions(-)
 create mode 100644 net/bluetooth/mgmt_util.c
 create mode 100644 net/bluetooth/mgmt_util.h

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 5d608799717e..9a8ea232d28f 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,7 +13,7 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o ecc.o hci_request.o
+	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
 
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 76e0f0300195..5124efb53de5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,6 +35,7 @@
 
 #include "hci_request.h"
 #include "smp.h"
+#include "mgmt_util.h"
 
 #define MGMT_VERSION	1
 #define MGMT_REVISION	9
@@ -141,17 +142,6 @@ static const u16 mgmt_events[] = {
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-struct mgmt_pending_cmd {
-	struct list_head list;
-	u16 opcode;
-	int index;
-	void *param;
-	size_t param_len;
-	struct sock *sk;
-	void *user_data;
-	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
-};
-
 /* HCI to MGMT error code conversion table */
 static u8 mgmt_status_table[] = {
 	MGMT_STATUS_SUCCESS,
@@ -225,37 +215,6 @@ static u8 mgmt_status(u8 hci_status)
 	return MGMT_STATUS_FAILED;
 }
 
-static int mgmt_send_event(u16 event, struct hci_dev *hdev,
-			   unsigned short channel, void *data, u16 data_len,
-			   int flag, struct sock *skip_sk)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	if (hdev)
-		hdr->index = cpu_to_le16(hdev->id);
-	else
-		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
-	hdr->len = cpu_to_le16(data_len);
-
-	if (data)
-		memcpy(skb_put(skb, data_len), data, data_len);
-
-	/* Time stamp */
-	__net_timestamp(skb);
-
-	hci_send_to_channel(channel, skb, flag, skip_sk);
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int mgmt_index_event(u16 event, struct hci_dev *hdev, void *data,
 			    u16 len, int flag)
 {
@@ -284,70 +243,6 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 			       HCI_SOCK_TRUSTED, skip_sk);
 }
 
-static int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_status *ev;
-	int err;
-
-	BT_DBG("sock %p, index %u, cmd %u, status %u", sk, index, cmd, status);
-
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
-	hdr->index = cpu_to_le16(index);
-	hdr->len = cpu_to_le16(sizeof(*ev));
-
-	ev = (void *) skb_put(skb, sizeof(*ev));
-	ev->status = status;
-	ev->opcode = cpu_to_le16(cmd);
-
-	err = sock_queue_rcv_skb(sk, skb);
-	if (err < 0)
-		kfree_skb(skb);
-
-	return err;
-}
-
-static int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
-			     void *rp, size_t rp_len)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_complete *ev;
-	int err;
-
-	BT_DBG("sock %p", sk);
-
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
-	hdr->index = cpu_to_le16(index);
-	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
-
-	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
-	ev->opcode = cpu_to_le16(cmd);
-	ev->status = status;
-
-	if (rp)
-		memcpy(ev->data, rp, rp_len);
-
-	err = sock_queue_rcv_skb(sk, skb);
-	if (err < 0)
-		kfree_skb(skb);
-
-	return err;
-}
-
 static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 data_len)
 {
@@ -882,44 +777,11 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
-static struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel,
-						  u16 opcode,
-						  struct hci_dev *hdev)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (hci_sock_get_channel(cmd->sk) != channel)
-			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
-
-	return NULL;
-}
-
 static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
 {
 	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
 }
 
-static struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
-						       u16 opcode,
-						       struct hci_dev *hdev,
-						       const void *data)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->user_data != data)
-			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
-
-	return NULL;
-}
-
 static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
 						  struct hci_dev *hdev,
 						  const void *data)
@@ -1341,63 +1203,6 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 				 sizeof(rp));
 }
 
-static void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
-{
-	sock_put(cmd->sk);
-	kfree(cmd->param);
-	kfree(cmd);
-}
-
-static struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
-						 struct hci_dev *hdev,
-						 void *data, u16 len)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (!cmd)
-		return NULL;
-
-	cmd->opcode = opcode;
-	cmd->index = hdev->id;
-
-	cmd->param = kmemdup(data, len, GFP_KERNEL);
-	if (!cmd->param) {
-		kfree(cmd);
-		return NULL;
-	}
-
-	cmd->param_len = len;
-
-	cmd->sk = sk;
-	sock_hold(sk);
-
-	list_add(&cmd->list, &hdev->mgmt_pending);
-
-	return cmd;
-}
-
-static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
-				 void (*cb)(struct mgmt_pending_cmd *cmd,
-					    void *data),
-				 void *data)
-{
-	struct mgmt_pending_cmd *cmd, *tmp;
-
-	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
-		if (opcode > 0 && cmd->opcode != opcode)
-			continue;
-
-		cb(cmd, data);
-	}
-}
-
-static void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
-{
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
-}
-
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 settings = cpu_to_le32(get_current_settings(hdev));
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
new file mode 100644
index 000000000000..8c30c7eb8bef
--- /dev/null
+++ b/net/bluetooth/mgmt_util.c
@@ -0,0 +1,210 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2015  Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
+
+#include "mgmt_util.h"
+
+int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
+		    void *data, u16 data_len, int flag, struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	if (hdev)
+		hdr->index = cpu_to_le16(hdev->id);
+	else
+		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
+	hdr->len = cpu_to_le16(data_len);
+
+	if (data)
+		memcpy(skb_put(skb, data_len), data, data_len);
+
+	/* Time stamp */
+	__net_timestamp(skb);
+
+	hci_send_to_channel(channel, skb, flag, skip_sk);
+	kfree_skb(skb);
+
+	return 0;
+}
+
+int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_status *ev;
+	int err;
+
+	BT_DBG("sock %p, index %u, cmd %u, status %u", sk, index, cmd, status);
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
+	hdr->index = cpu_to_le16(index);
+	hdr->len = cpu_to_le16(sizeof(*ev));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	ev->status = status;
+	ev->opcode = cpu_to_le16(cmd);
+
+	err = sock_queue_rcv_skb(sk, skb);
+	if (err < 0)
+		kfree_skb(skb);
+
+	return err;
+}
+
+int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
+		      void *rp, size_t rp_len)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	int err;
+
+	BT_DBG("sock %p", sk);
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->index = cpu_to_le16(index);
+	hdr->len = cpu_to_le16(sizeof(*ev) + rp_len);
+
+	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
+	ev->opcode = cpu_to_le16(cmd);
+	ev->status = status;
+
+	if (rp)
+		memcpy(ev->data, rp, rp_len);
+
+	err = sock_queue_rcv_skb(sk, skb);
+	if (err < 0)
+		kfree_skb(skb);
+
+	return err;
+}
+
+struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
+					   struct hci_dev *hdev)
+{
+	struct mgmt_pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != channel)
+			continue;
+		if (cmd->opcode == opcode)
+			return cmd;
+	}
+
+	return NULL;
+}
+
+struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
+						u16 opcode,
+						struct hci_dev *hdev,
+						const void *data)
+{
+	struct mgmt_pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->user_data != data)
+			continue;
+		if (cmd->opcode == opcode)
+			return cmd;
+	}
+
+	return NULL;
+}
+
+void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
+			  void *data)
+{
+	struct mgmt_pending_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
+		if (opcode > 0 && cmd->opcode != opcode)
+			continue;
+
+		cb(cmd, data);
+	}
+}
+
+struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+					  struct hci_dev *hdev,
+					  void *data, u16 len)
+{
+	struct mgmt_pending_cmd *cmd;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return NULL;
+
+	cmd->opcode = opcode;
+	cmd->index = hdev->id;
+
+	cmd->param = kmemdup(data, len, GFP_KERNEL);
+	if (!cmd->param) {
+		kfree(cmd);
+		return NULL;
+	}
+
+	cmd->param_len = len;
+
+	cmd->sk = sk;
+	sock_hold(sk);
+
+	list_add(&cmd->list, &hdev->mgmt_pending);
+
+	return cmd;
+}
+
+void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
+{
+	sock_put(cmd->sk);
+	kfree(cmd->param);
+	kfree(cmd);
+}
+
+void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
+{
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
new file mode 100644
index 000000000000..6559f189213c
--- /dev/null
+++ b/net/bluetooth/mgmt_util.h
@@ -0,0 +1,53 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2015  Intel Coropration
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+struct mgmt_pending_cmd {
+	struct list_head list;
+	u16 opcode;
+	int index;
+	void *param;
+	size_t param_len;
+	struct sock *sk;
+	void *user_data;
+	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
+};
+
+int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
+		    void *data, u16 data_len, int flag, struct sock *skip_sk);
+int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status);
+int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
+		      void *rp, size_t rp_len);
+
+struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
+					   struct hci_dev *hdev);
+struct mgmt_pending_cmd *mgmt_pending_find_data(unsigned short channel,
+						u16 opcode,
+						struct hci_dev *hdev,
+						const void *data);
+void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
+			  void *data);
+struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+					  struct hci_dev *hdev,
+					  void *data, u16 len);
+void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
+void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
-- 
2.1.0

