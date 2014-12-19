Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Split hci_request helpers to hci_request.[ch]
Date: Fri, 19 Dec 2014 13:40:20 +0200
Message-Id: <1418989220-4066-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com>
References: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

None of the hci_request related things in net/bluetooth/hci_core.h are
needed anywhere outside of the core bluetooth module. This patch creates
a new net/bluetooth/hci_request.c file with its corresponding h-file and
moves the functionality there from hci_core.c and hci_core.h.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  25 ---
 net/bluetooth/Makefile           |   2 +-
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/hci_core.c         | 370 +-----------------------------------
 net/bluetooth/hci_event.c        |   1 +
 net/bluetooth/hci_request.c      | 397 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |  51 +++++
 net/bluetooth/mgmt.c             |   1 +
 8 files changed, 453 insertions(+), 395 deletions(-)
 create mode 100644 net/bluetooth/hci_request.c
 create mode 100644 net/bluetooth/hci_request.h

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 664451a64d72..93066f70f8ab 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1284,31 +1284,8 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
-struct hci_request {
-	struct hci_dev		*hdev;
-	struct sk_buff_head	cmd_q;
-
-	/* If something goes wrong when building the HCI request, the error
-	 * value is stored in this field.
-	 */
-	int			err;
-};
-
-void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
-int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
-void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
-		 const void *param);
-void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
-		    const void *param, u8 event);
-void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 bool hci_req_pending(struct hci_dev *hdev);
 
-void hci_req_add_le_scan_disable(struct hci_request *req);
-void hci_req_add_le_passive_scan(struct hci_request *req);
-
-void hci_update_page_scan(struct hci_dev *hdev);
-void __hci_update_page_scan(struct hci_request *req);
-
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
@@ -1418,8 +1395,6 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 							__u8 ltk[16]);
 
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      u8 *own_addr_type);
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index a5432a6a0ae6..0a176fc9e291 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,6 +13,6 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o ecc.o
+	a2mp.o amp.o ecc.o hci_request.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe18825cc8a4..4405fb352c70 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+#include "hci_request.h"
 #include "smp.h"
 #include "a2mp.h"
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3aa9015a8858..2cfaaa6acb04 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -37,6 +37,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_request.h"
 #include "smp.h"
 
 static void hci_rx_work(struct work_struct *work);
@@ -3901,112 +3902,6 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
-static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	/* If we're advertising or initiating an LE connection we can't
-	 * go ahead and change the random address at this time. This is
-	 * because the eventual initiator address used for the
-	 * subsequently created connection will be undefined (some
-	 * controllers use the new address and others the one we had
-	 * when the operation started).
-	 *
-	 * In this kind of scenario skip the update and let the random
-	 * address be updated at the next cycle.
-	 */
-	if (test_bit(HCI_LE_ADV, &hdev->dev_flags) ||
-	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
-		BT_DBG("Deferring random address update");
-		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
-		return;
-	}
-
-	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
-}
-
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      u8 *own_addr_type)
-{
-	struct hci_dev *hdev = req->hdev;
-	int err;
-
-	/* If privacy is enabled use a resolvable private address. If
-	 * current RPA has expired or there is something else than
-	 * the current RPA in use, then generate a new one.
-	 */
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
-		int to;
-
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
-
-		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags) &&
-		    !bacmp(&hdev->random_addr, &hdev->rpa))
-			return 0;
-
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			BT_ERR("%s failed to generate new RPA", hdev->name);
-			return err;
-		}
-
-		set_random_addr(req, &hdev->rpa);
-
-		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
-		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
-
-		return 0;
-	}
-
-	/* In case of required privacy without resolvable private address,
-	 * use an non-resolvable private address. This is useful for active
-	 * scanning and non-connectable advertising.
-	 */
-	if (require_privacy) {
-		bdaddr_t nrpa;
-
-		while (true) {
-			/* The non-resolvable private address is generated
-			 * from random six bytes with the two most significant
-			 * bits cleared.
-			 */
-			get_random_bytes(&nrpa, 6);
-			nrpa.b[5] &= 0x3f;
-
-			/* The non-resolvable private address shall not be
-			 * equal to the public address.
-			 */
-			if (bacmp(&hdev->bdaddr, &nrpa))
-				break;
-		}
-
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		set_random_addr(req, &nrpa);
-		return 0;
-	}
-
-	/* If forcing static address is in use or there is no public
-	 * address use the static address as random address (but skip
-	 * the HCI command if the current random address is already the
-	 * static one.
-	 */
-	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		if (bacmp(&hdev->static_addr, &hdev->random_addr))
-			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
-				    &hdev->static_addr);
-		return 0;
-	}
-
-	/* Neither privacy nor static address is being used so use a
-	 * public address.
-	 */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
-
-	return 0;
-}
-
 /* Copy the Identity Address of the controller.
  *
  * If the controller has a public BD_ADDR, then by default use that one.
@@ -4539,76 +4434,11 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
-{
-	skb_queue_head_init(&req->cmd_q);
-	req->hdev = hdev;
-	req->err = 0;
-}
-
-int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct sk_buff *skb;
-	unsigned long flags;
-
-	BT_DBG("length %u", skb_queue_len(&req->cmd_q));
-
-	/* If an error occurred during request building, remove all HCI
-	 * commands queued on the HCI request queue.
-	 */
-	if (req->err) {
-		skb_queue_purge(&req->cmd_q);
-		return req->err;
-	}
-
-	/* Do not allow empty requests */
-	if (skb_queue_empty(&req->cmd_q))
-		return -ENODATA;
-
-	skb = skb_peek_tail(&req->cmd_q);
-	bt_cb(skb)->req.complete = complete;
-
-	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
-	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
-	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
-
-	queue_work(hdev->workqueue, &hdev->cmd_work);
-
-	return 0;
-}
-
 bool hci_req_pending(struct hci_dev *hdev)
 {
 	return (hdev->req_status == HCI_REQ_PEND);
 }
 
-static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
-				       u32 plen, const void *param)
-{
-	int len = HCI_COMMAND_HDR_SIZE + plen;
-	struct hci_command_hdr *hdr;
-	struct sk_buff *skb;
-
-	skb = bt_skb_alloc(len, GFP_ATOMIC);
-	if (!skb)
-		return NULL;
-
-	hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
-	hdr->opcode = cpu_to_le16(opcode);
-	hdr->plen   = plen;
-
-	if (plen)
-		memcpy(skb_put(skb, plen), param, plen);
-
-	BT_DBG("skb len %d", skb->len);
-
-	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-	bt_cb(skb)->opcode = opcode;
-
-	return skb;
-}
-
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
@@ -4634,43 +4464,6 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 	return 0;
 }
 
-/* Queue a command to an asynchronous HCI request */
-void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
-		    const void *param, u8 event)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct sk_buff *skb;
-
-	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
-
-	/* If an error occurred during request building, there is no point in
-	 * queueing the HCI command. We can simply return.
-	 */
-	if (req->err)
-		return;
-
-	skb = hci_prepare_cmd(hdev, opcode, plen, param);
-	if (!skb) {
-		BT_ERR("%s no memory for command (opcode 0x%4.4x)",
-		       hdev->name, opcode);
-		req->err = -ENOMEM;
-		return;
-	}
-
-	if (skb_queue_empty(&req->cmd_q))
-		bt_cb(skb)->req.start = true;
-
-	bt_cb(skb)->req.event = event;
-
-	skb_queue_tail(&req->cmd_q, skb);
-}
-
-void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
-		 const void *param)
-{
-	hci_req_add_ev(req, opcode, plen, param, 0);
-}
-
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
@@ -5519,167 +5312,6 @@ static void hci_cmd_work(struct work_struct *work)
 	}
 }
 
-void hci_req_add_le_scan_disable(struct hci_request *req)
-{
-	struct hci_cp_le_set_scan_enable cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_DISABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-}
-
-static void add_to_white_list(struct hci_request *req,
-			      struct hci_conn_params *params)
-{
-	struct hci_cp_le_add_to_white_list cp;
-
-	cp.bdaddr_type = params->addr_type;
-	bacpy(&cp.bdaddr, &params->addr);
-
-	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
-}
-
-static u8 update_white_list(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_conn_params *params;
-	struct bdaddr_list *b;
-	uint8_t white_list_entries = 0;
-
-	/* Go through the current white list programmed into the
-	 * controller one by one and check if that address is still
-	 * in the list of pending connections or list of devices to
-	 * report. If not present in either list, then queue the
-	 * command to remove it from the controller.
-	 */
-	list_for_each_entry(b, &hdev->le_white_list, list) {
-		struct hci_cp_le_del_from_white_list cp;
-
-		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					      &b->bdaddr, b->bdaddr_type) ||
-		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					      &b->bdaddr, b->bdaddr_type)) {
-			white_list_entries++;
-			continue;
-		}
-
-		cp.bdaddr_type = b->bdaddr_type;
-		bacpy(&cp.bdaddr, &b->bdaddr);
-
-		hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST,
-			    sizeof(cp), &cp);
-	}
-
-	/* Since all no longer valid white list entries have been
-	 * removed, walk through the list of pending connections
-	 * and ensure that any new device gets programmed into
-	 * the controller.
-	 *
-	 * If the list of the devices is larger than the list of
-	 * available white list entries in the controller, then
-	 * just abort and return filer policy value to not use the
-	 * white list.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
-		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
-					   &params->addr, params->addr_type))
-			continue;
-
-		if (white_list_entries >= hdev->le_white_list_size) {
-			/* Select filter policy to accept all advertising */
-			return 0x00;
-		}
-
-		if (hci_find_irk_by_addr(hdev, &params->addr,
-					 params->addr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
-		}
-
-		white_list_entries++;
-		add_to_white_list(req, params);
-	}
-
-	/* After adding all new pending connections, walk through
-	 * the list of pending reports and also add these to the
-	 * white list if there is still space.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
-		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
-					   &params->addr, params->addr_type))
-			continue;
-
-		if (white_list_entries >= hdev->le_white_list_size) {
-			/* Select filter policy to accept all advertising */
-			return 0x00;
-		}
-
-		if (hci_find_irk_by_addr(hdev, &params->addr,
-					 params->addr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
-		}
-
-		white_list_entries++;
-		add_to_white_list(req, params);
-	}
-
-	/* Select filter policy to use white list */
-	return 0x01;
-}
-
-void hci_req_add_le_passive_scan(struct hci_request *req)
-{
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
-	struct hci_dev *hdev = req->hdev;
-	u8 own_addr_type;
-	u8 filter_policy;
-
-	/* Set require_privacy to false since no SCAN_REQ are send
-	 * during passive scanning. Not using an non-resolvable address
-	 * here is important so that peer devices using direct
-	 * advertising with our address will be correctly reported
-	 * by the controller.
-	 */
-	if (hci_update_random_address(req, false, &own_addr_type))
-		return;
-
-	/* Adding or removing entries from the white list must
-	 * happen before enabling scanning. The controller does
-	 * not allow white list modification while scanning.
-	 */
-	filter_policy = update_white_list(req);
-
-	/* When the controller is using random resolvable addresses and
-	 * with that having LE privacy enabled, then controllers with
-	 * Extended Scanner Filter Policies support can now enable support
-	 * for handling directed advertising.
-	 *
-	 * So instead of using filter polices 0x00 (no whitelist)
-	 * and 0x01 (whitelist enabled) use the new filter policies
-	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
-	 */
-	if (test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
-	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
-		filter_policy |= 0x02;
-
-	memset(&param_cp, 0, sizeof(param_cp));
-	param_cp.type = LE_SCAN_PASSIVE;
-	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
-	param_cp.window = cpu_to_le16(hdev->le_scan_window);
-	param_cp.own_address_type = own_addr_type;
-	param_cp.filter_policy = filter_policy;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-		    &param_cp);
-
-	memset(&enable_cp, 0, sizeof(enable_cp));
-	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-		    &enable_cp);
-}
-
 static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 65f4ec8945a4..a412eb1e1f61 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_request.h"
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
new file mode 100644
index 000000000000..eba83a2a6556
--- /dev/null
+++ b/net/bluetooth/hci_request.c
@@ -0,0 +1,397 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2014 Intel Corporation
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
+
+#include "smp.h"
+#include "hci_request.h"
+
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
+{
+	skb_queue_head_init(&req->cmd_q);
+	req->hdev = hdev;
+	req->err = 0;
+}
+
+int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	BT_DBG("length %u", skb_queue_len(&req->cmd_q));
+
+	/* If an error occurred during request building, remove all HCI
+	 * commands queued on the HCI request queue.
+	 */
+	if (req->err) {
+		skb_queue_purge(&req->cmd_q);
+		return req->err;
+	}
+
+	/* Do not allow empty requests */
+	if (skb_queue_empty(&req->cmd_q))
+		return -ENODATA;
+
+	skb = skb_peek_tail(&req->cmd_q);
+	bt_cb(skb)->req.complete = complete;
+
+	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
+	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
+	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
+
+	queue_work(hdev->workqueue, &hdev->cmd_work);
+
+	return 0;
+}
+
+struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
+				const void *param)
+{
+	int len = HCI_COMMAND_HDR_SIZE + plen;
+	struct hci_command_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	hdr = (struct hci_command_hdr *) skb_put(skb, HCI_COMMAND_HDR_SIZE);
+	hdr->opcode = cpu_to_le16(opcode);
+	hdr->plen   = plen;
+
+	if (plen)
+		memcpy(skb_put(skb, plen), param, plen);
+
+	BT_DBG("skb len %d", skb->len);
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	bt_cb(skb)->opcode = opcode;
+
+	return skb;
+}
+
+/* Queue a command to an asynchronous HCI request */
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
+		    const void *param, u8 event)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct sk_buff *skb;
+
+	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
+
+	/* If an error occurred during request building, there is no point in
+	 * queueing the HCI command. We can simply return.
+	 */
+	if (req->err)
+		return;
+
+	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	if (!skb) {
+		BT_ERR("%s no memory for command (opcode 0x%4.4x)",
+		       hdev->name, opcode);
+		req->err = -ENOMEM;
+		return;
+	}
+
+	if (skb_queue_empty(&req->cmd_q))
+		bt_cb(skb)->req.start = true;
+
+	bt_cb(skb)->req.event = event;
+
+	skb_queue_tail(&req->cmd_q, skb);
+}
+
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
+		 const void *param)
+{
+	hci_req_add_ev(req, opcode, plen, param, 0);
+}
+
+void hci_req_add_le_scan_disable(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+static void add_to_white_list(struct hci_request *req,
+			      struct hci_conn_params *params)
+{
+	struct hci_cp_le_add_to_white_list cp;
+
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+
+	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
+}
+
+static u8 update_white_list(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn_params *params;
+	struct bdaddr_list *b;
+	uint8_t white_list_entries = 0;
+
+	/* Go through the current white list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then queue the
+	 * command to remove it from the controller.
+	 */
+	list_for_each_entry(b, &hdev->le_white_list, list) {
+		struct hci_cp_le_del_from_white_list cp;
+
+		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					      &b->bdaddr, b->bdaddr_type) ||
+		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					      &b->bdaddr, b->bdaddr_type)) {
+			white_list_entries++;
+			continue;
+		}
+
+		cp.bdaddr_type = b->bdaddr_type;
+		bacpy(&cp.bdaddr, &b->bdaddr);
+
+		hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST,
+			    sizeof(cp), &cp);
+	}
+
+	/* Since all no longer valid white list entries have been
+	 * removed, walk through the list of pending connections
+	 * and ensure that any new device gets programmed into
+	 * the controller.
+	 *
+	 * If the list of the devices is larger than the list of
+	 * available white list entries in the controller, then
+	 * just abort and return filer policy value to not use the
+	 * white list.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (white_list_entries >= hdev->le_white_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
+
+		white_list_entries++;
+		add_to_white_list(req, params);
+	}
+
+	/* After adding all new pending connections, walk through
+	 * the list of pending reports and also add these to the
+	 * white list if there is still space.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (white_list_entries >= hdev->le_white_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
+
+		white_list_entries++;
+		add_to_white_list(req, params);
+	}
+
+	/* Select filter policy to use white list */
+	return 0x01;
+}
+
+void hci_req_add_le_passive_scan(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_dev *hdev = req->hdev;
+	u8 own_addr_type;
+	u8 filter_policy;
+
+	/* Set require_privacy to false since no SCAN_REQ are send
+	 * during passive scanning. Not using an non-resolvable address
+	 * here is important so that peer devices using direct
+	 * advertising with our address will be correctly reported
+	 * by the controller.
+	 */
+	if (hci_update_random_address(req, false, &own_addr_type))
+		return;
+
+	/* Adding or removing entries from the white list must
+	 * happen before enabling scanning. The controller does
+	 * not allow white list modification while scanning.
+	 */
+	filter_policy = update_white_list(req);
+
+	/* When the controller is using random resolvable addresses and
+	 * with that having LE privacy enabled, then controllers with
+	 * Extended Scanner Filter Policies support can now enable support
+	 * for handling directed advertising.
+	 *
+	 * So instead of using filter polices 0x00 (no whitelist)
+	 * and 0x01 (whitelist enabled) use the new filter policies
+	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
+	 */
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags) &&
+	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
+		filter_policy |= 0x02;
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.type = LE_SCAN_PASSIVE;
+	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
+	param_cp.window = cpu_to_le16(hdev->le_scan_window);
+	param_cp.own_address_type = own_addr_type;
+	param_cp.filter_policy = filter_policy;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+}
+
+static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* If we're advertising or initiating an LE connection we can't
+	 * go ahead and change the random address at this time. This is
+	 * because the eventual initiator address used for the
+	 * subsequently created connection will be undefined (some
+	 * controllers use the new address and others the one we had
+	 * when the operation started).
+	 *
+	 * In this kind of scenario skip the update and let the random
+	 * address be updated at the next cycle.
+	 */
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags) ||
+	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+		BT_DBG("Deferring random address update");
+		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+		return;
+	}
+
+	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
+}
+
+int hci_update_random_address(struct hci_request *req, bool require_privacy,
+			      u8 *own_addr_type)
+{
+	struct hci_dev *hdev = req->hdev;
+	int err;
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired or there is something else than
+	 * the current RPA in use, then generate a new one.
+	 */
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+		int to;
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags) &&
+		    !bacmp(&hdev->random_addr, &hdev->rpa))
+			return 0;
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			BT_ERR("%s failed to generate new RPA", hdev->name);
+			return err;
+		}
+
+		set_random_addr(req, &hdev->rpa);
+
+		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
+
+		return 0;
+	}
+
+	/* In case of required privacy without resolvable private address,
+	 * use an non-resolvable private address. This is useful for active
+	 * scanning and non-connectable advertising.
+	 */
+	if (require_privacy) {
+		bdaddr_t nrpa;
+
+		while (true) {
+			/* The non-resolvable private address is generated
+			 * from random six bytes with the two most significant
+			 * bits cleared.
+			 */
+			get_random_bytes(&nrpa, 6);
+			nrpa.b[5] &= 0x3f;
+
+			/* The non-resolvable private address shall not be
+			 * equal to the public address.
+			 */
+			if (bacmp(&hdev->bdaddr, &nrpa))
+				break;
+		}
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		set_random_addr(req, &nrpa);
+		return 0;
+	}
+
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address (but skip
+	 * the HCI command if the current random address is already the
+	 * static one.
+	 */
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (bacmp(&hdev->static_addr, &hdev->random_addr))
+			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+				    &hdev->static_addr);
+		return 0;
+	}
+
+	/* Neither privacy nor static address is being used so use a
+	 * public address.
+	 */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
new file mode 100644
index 000000000000..1793a46fea65
--- /dev/null
+++ b/net/bluetooth/hci_request.h
@@ -0,0 +1,51 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2014 Intel Corporation
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
+struct hci_request {
+	struct hci_dev		*hdev;
+	struct sk_buff_head	cmd_q;
+
+	/* If something goes wrong when building the HCI request, the error
+	 * value is stored in this field.
+	 */
+	int			err;
+};
+
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
+int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
+void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
+		 const void *param);
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
+		    const void *param, u8 event);
+void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+
+struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
+				const void *param);
+
+void hci_req_add_le_scan_disable(struct hci_request *req);
+void hci_req_add_le_passive_scan(struct hci_request *req);
+
+void hci_update_page_scan(struct hci_dev *hdev);
+void __hci_update_page_scan(struct hci_request *req);
+
+int hci_update_random_address(struct hci_request *req, bool require_privacy,
+			      u8 *own_addr_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f86f3ec684ba..95473e966703 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
+#include "hci_request.h"
 #include "smp.h"
 
 #define MGMT_VERSION	1
-- 
2.1.0

