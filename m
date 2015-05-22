Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 2/2] Bluetooth: Add option to enable/disable A2MP module
Date: Fri, 22 May 2015 13:56:05 +0800
Message-Id: <1432274165-23569-2-git-send-email-arron.wang@intel.com>
In-Reply-To: <1432274165-23569-1-git-send-email-arron.wang@intel.com>
References: <1432274165-23569-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make Bluetooth 3.0 HS feature configurable

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/Kconfig          |    5 +
 net/bluetooth/Makefile         |    3 +-
 net/bluetooth/a2mp.h           |   19 +++
 net/bluetooth/amp.h            |   11 ++
 net/bluetooth/hci_event.c      |  260 +-----------------------------------
 net/bluetooth/hci_event_a2mp.c |  283 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event_a2mp.h |   91 +++++++++++++
 7 files changed, 412 insertions(+), 260 deletions(-)
 create mode 100644 net/bluetooth/hci_event_a2mp.c
 create mode 100644 net/bluetooth/hci_event_a2mp.h

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index e7bca37..a558c66 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -27,6 +27,7 @@ menuconfig BT
 		SMP (Security Manager Protocol) on LE (Low Energy) links
 	     HCI Device drivers (Interface to the hardware)
 	     SCO Module (SCO audio links)
+	     A2MP Module (AMP Manager Protocol)
 	     RFCOMM Module (RFCOMM Protocol)  
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
@@ -53,6 +54,10 @@ config BT_SCO
 	  SCO link provides voice transport over Bluetooth.  SCO support is
 	  required for voice applications like Headset and Audio.
 
+config BT_A2MP
+	bool "Bluetooth Alternate MAC/PHY (AMP) features"
+	depends on BT_BREDR
+
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 21fe57a..a87fc90 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,9 +13,10 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
+	ecc.o hci_request.o mgmt_util.o
 
 bluetooth-$(CONFIG_BT_SCO) += sco.o
+bluetooth-$(CONFIG_BT_A2MP) += a2mp.o amp.o hci_event_a2mp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 296f665..d92577a 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -130,10 +130,29 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
 struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
+
+#if IS_ENABLED(CONFIG_BT_A2MP)
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_discover_amp(struct l2cap_chan *chan);
+#else
+static inline int amp_mgr_put(struct amp_mgr *mgr)
+{
+	return 0;
+}
+
+static inline struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
+						     struct sk_buff *skb)
+{
+	return NULL;
+}
+
+static inline void a2mp_discover_amp(struct l2cap_chan *chan)
+{
+}
+#endif
+
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
index 7ea3db7..508b06d 100644
--- a/net/bluetooth/amp.h
+++ b/net/bluetooth/amp.h
@@ -47,8 +47,19 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
+
+#if IS_ENABLED(CONFIG_BT_A2MP)
 void amp_create_logical_link(struct l2cap_chan *chan);
 void amp_disconnect_logical_link(struct hci_chan *hchan);
+#else
+static inline void amp_create_logical_link(struct l2cap_chan *chan)
+{
+}
+
+static inline void amp_disconnect_logical_link(struct hci_chan *hchan)
+{
+}
+#endif
 void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7b61be7..de913087 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -32,9 +32,8 @@
 
 #include "hci_request.h"
 #include "hci_debugfs.h"
-#include "a2mp.h"
-#include "amp.h"
 #include "smp.h"
+#include "hci_event_a2mp.h"
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
@@ -815,68 +814,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		goto a2mp_rsp;
-
-	hdev->amp_status = rp->amp_status;
-	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
-	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
-	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
-	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
-	hdev->amp_type = rp->amp_type;
-	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
-	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
-	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
-	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
-
-a2mp_rsp:
-	a2mp_send_getinfo_rsp(hdev);
-}
-
-static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
-					struct sk_buff *skb)
-{
-	struct hci_rp_read_local_amp_assoc *rp = (void *) skb->data;
-	struct amp_assoc *assoc = &hdev->loc_assoc;
-	size_t rem_len, frag_len;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		goto a2mp_rsp;
-
-	frag_len = skb->len - sizeof(*rp);
-	rem_len = __le16_to_cpu(rp->rem_len);
-
-	if (rem_len > frag_len) {
-		BT_DBG("frag_len %zu rem_len %zu", frag_len, rem_len);
-
-		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
-		assoc->offset += frag_len;
-
-		/* Read other fragments */
-		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
-
-		return;
-	}
-
-	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
-	assoc->len = assoc->offset + rem_len;
-	assoc->offset = 0;
-
-a2mp_rsp:
-	/* Send A2MP Rsp when all fragments are received */
-	a2mp_send_getampassoc_rsp(hdev, rp->status);
-	a2mp_send_create_phy_link_req(hdev, rp->status);
-}
-
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -1409,20 +1346,6 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
-					  struct sk_buff *skb)
-{
-	struct hci_rp_write_remote_amp_assoc *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x phy_handle 0x%2.2x",
-	       hdev->name, rp->status, rp->phy_handle);
-
-	if (rp->status)
-		return;
-
-	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
-}
-
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_rssi *rp = (void *) skb->data;
@@ -1944,47 +1867,6 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
-{
-	struct hci_cp_create_phy_link *cp;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHY_LINK);
-	if (!cp)
-		return;
-
-	hci_dev_lock(hdev);
-
-	if (status) {
-		struct hci_conn *hcon;
-
-		hcon = hci_conn_hash_lookup_handle(hdev, cp->phy_handle);
-		if (hcon)
-			hci_conn_del(hcon);
-	} else {
-		amp_write_remote_assoc(hdev, cp->phy_handle);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
-{
-	struct hci_cp_accept_phy_link *cp;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status)
-		return;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_PHY_LINK);
-	if (!cp)
-		return;
-
-	amp_write_remote_assoc(hdev, cp->phy_handle);
-}
-
 static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_create_conn *cp;
@@ -4313,130 +4195,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_phy_link_complete_evt(struct hci_dev *hdev,
-				      struct sk_buff *skb)
-{
-	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
-	struct hci_conn *hcon, *bredr_hcon;
-
-	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
-	       ev->status);
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon) {
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	if (ev->status) {
-		hci_conn_del(hcon);
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
-
-	hcon->state = BT_CONNECTED;
-	bacpy(&hcon->dst, &bredr_hcon->dst);
-
-	hci_conn_hold(hcon);
-	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
-	hci_conn_drop(hcon);
-
-	hci_debugfs_create_conn(hcon);
-	hci_conn_add_sysfs(hcon);
-
-	amp_physical_cfm(bredr_hcon, hcon);
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
-	struct hci_conn *hcon;
-	struct hci_chan *hchan;
-	struct amp_mgr *mgr;
-
-	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
-	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
-	       ev->status);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	/* Create AMP hchan */
-	hchan = hci_chan_create(hcon);
-	if (!hchan)
-		return;
-
-	hchan->handle = le16_to_cpu(ev->handle);
-
-	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
-
-	mgr = hcon->amp_mgr;
-	if (mgr && mgr->bredr_chan) {
-		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
-
-		l2cap_chan_lock(bredr_chan);
-
-		bredr_chan->conn->mtu = hdev->block_mtu;
-		l2cap_logical_cfm(bredr_chan, hchan, 0);
-		hci_conn_hold(hcon);
-
-		l2cap_chan_unlock(bredr_chan);
-	}
-}
-
-static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_logical_link_complete *ev = (void *) skb->data;
-	struct hci_chan *hchan;
-
-	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
-	       le16_to_cpu(ev->handle), ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hchan = hci_chan_lookup_handle(hdev, le16_to_cpu(ev->handle));
-	if (!hchan)
-		goto unlock;
-
-	amp_destroy_logical_link(hchan, ev->reason);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
-					     struct sk_buff *skb)
-{
-	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
-	struct hci_conn *hcon;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-
-	if (ev->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (hcon) {
-		hcon->state = BT_CLOSED;
-		hci_conn_del(hcon);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -5119,22 +4877,6 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_channel_selected *ev = (void *) skb->data;
-	struct hci_conn *hcon;
-
-	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
-
-	skb_pull(skb, sizeof(*ev));
-
-	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (!hcon)
-		return;
-
-	amp_read_loc_assoc_final_data(hdev, hcon);
-}
-
 static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 				 u8 event, struct sk_buff *skb)
 {
diff --git a/net/bluetooth/hci_event_a2mp.c b/net/bluetooth/hci_event_a2mp.c
new file mode 100644
index 0000000..587f9fb7
--- /dev/null
+++ b/net/bluetooth/hci_event_a2mp.c
@@ -0,0 +1,283 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+
+   Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
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
+/* Bluetooth HCI A2MP event handling. */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_debugfs.h"
+#include "a2mp.h"
+#include "amp.h"
+
+void hci_cc_read_local_amp_info(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_info *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		goto a2mp_rsp;
+
+	hdev->amp_status = rp->amp_status;
+	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
+	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
+	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
+	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
+	hdev->amp_type = rp->amp_type;
+	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
+	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
+	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
+	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
+
+a2mp_rsp:
+	a2mp_send_getinfo_rsp(hdev);
+}
+
+void hci_cc_read_local_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
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
+		BT_DBG("frag_len %zu rem_len %zu", frag_len, rem_len);
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
+	a2mp_send_create_phy_link_req(hdev, rp->status);
+}
+
+void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_write_remote_amp_assoc *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x phy_handle 0x%2.2x",
+	       hdev->name, rp->status, rp->phy_handle);
+
+	if (rp->status)
+		return;
+
+	amp_write_rem_assoc_continue(hdev, rp->phy_handle);
+}
+
+void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_create_phy_link *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHY_LINK);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		struct hci_conn *hcon;
+
+		hcon = hci_conn_hash_lookup_handle(hdev, cp->phy_handle);
+		if (hcon)
+			hci_conn_del(hcon);
+	} else {
+		amp_write_remote_assoc(hdev, cp->phy_handle);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
+void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_accept_phy_link *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_PHY_LINK);
+	if (!cp)
+		return;
+
+	amp_write_remote_assoc(hdev, cp->phy_handle);
+}
+
+void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_channel_selected *ev = (void *)skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
+
+	skb_pull(skb, sizeof(*ev));
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	amp_read_loc_assoc_final_data(hdev, hcon);
+}
+
+void hci_phy_link_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_phy_link_complete *ev = (void *)skb->data;
+	struct hci_conn *hcon, *bredr_hcon;
+
+	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
+	       ev->status);
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	if (ev->status) {
+		hci_conn_del(hcon);
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
+
+	hcon->state = BT_CONNECTED;
+	bacpy(&hcon->dst, &bredr_hcon->dst);
+
+	hci_conn_hold(hcon);
+	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
+	hci_conn_drop(hcon);
+
+	hci_debugfs_create_conn(hcon);
+	hci_conn_add_sysfs(hcon);
+
+	amp_physical_cfm(bredr_hcon, hcon);
+
+	hci_dev_unlock(hdev);
+}
+
+void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_logical_link_complete *ev = (void *)skb->data;
+	struct hci_conn *hcon;
+	struct hci_chan *hchan;
+	struct amp_mgr *mgr;
+
+	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
+	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
+	       ev->status);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	/* Create AMP hchan */
+	hchan = hci_chan_create(hcon);
+	if (!hchan)
+		return;
+
+	hchan->handle = le16_to_cpu(ev->handle);
+
+	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
+
+	mgr = hcon->amp_mgr;
+	if (mgr && mgr->bredr_chan) {
+		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
+
+		l2cap_chan_lock(bredr_chan);
+
+		bredr_chan->conn->mtu = hdev->block_mtu;
+		l2cap_logical_cfm(bredr_chan, hchan, 0);
+		hci_conn_hold(hcon);
+
+		l2cap_chan_unlock(bredr_chan);
+	}
+}
+
+void hci_disconn_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_disconn_logical_link_complete *ev = (void *)skb->data;
+	struct hci_chan *hchan;
+
+	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
+	       le16_to_cpu(ev->handle), ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hchan = hci_chan_lookup_handle(hdev, le16_to_cpu(ev->handle));
+	if (!hchan)
+		goto unlock;
+
+	amp_destroy_logical_link(hchan, ev->reason);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+void hci_disconn_phylink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_disconn_phy_link_complete *ev = (void *)skb->data;
+	struct hci_conn *hcon;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	if (ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (hcon) {
+		hcon->state = BT_CLOSED;
+		hci_conn_del(hcon);
+	}
+
+	hci_dev_unlock(hdev);
+}
diff --git a/net/bluetooth/hci_event_a2mp.h b/net/bluetooth/hci_event_a2mp.h
new file mode 100644
index 0000000..2625431
--- /dev/null
+++ b/net/bluetooth/hci_event_a2mp.h
@@ -0,0 +1,91 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+
+   Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
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
+#ifndef __HCI_EVENT_A2MP_H
+#define __HCI_EVENT_A2MP_H
+
+#if IS_ENABLED(CONFIG_BT_A2MP)
+void hci_cc_read_local_amp_info(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_cc_read_local_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_cs_create_phylink(struct hci_dev *hdev, u8 status);
+void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status);
+void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_phy_link_complete_evt(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
+				      struct sk_buff *skb);
+void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
+				      struct sk_buff *skb);
+#else
+static inline void hci_cc_read_local_amp_info(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+}
+
+static inline void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
+					       struct sk_buff *skb)
+{
+}
+
+static inline void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
+						 struct sk_buff *skb)
+{
+}
+
+static inline void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
+{
+}
+
+static inline void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
+{
+}
+
+static inline void hci_chan_selected_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+}
+
+static inline void hci_phy_link_complete_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
+{
+}
+
+static inline void hci_loglink_complete_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
+{
+}
+
+static inline void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
+						    struct sk_buff *skb)
+{
+}
+
+static inline void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
+						    struct sk_buff *skb)
+{
+}
+#endif
+
+#endif /* __HCI_EVENT_A2MP_H */
-- 
1.7.9.5

