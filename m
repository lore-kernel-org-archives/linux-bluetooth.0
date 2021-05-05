Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA18C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B2A613C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhEEVGV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 17:06:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59300 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhEEVGT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 17:06:19 -0400
Received: from fedora.. (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0EBBDCED25
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 23:13:11 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Move scanning update into synchronous function
Date:   Wed,  5 May 2021 23:05:18 +0200
Message-Id: <20210505210518.183861-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With recent specification version, the setup for LE scanning or LE
advertising started to more complex than it was with Bluetooth 4.0 which
initially introduced LE support. So historically, bringing the
controller into a link layer state (being it scanning or advertising)
was composed of two HCI commands. This meant using hci_req_sync worked
nicely.

However over time, the pattern of pushing work into a workqueue and then
utilizing hci_req_sync list of 5 or more commands became the normality.
With the usage of hci_req_sync it means that all states and error need
to be predicted ahead of time. This is no longer workable. Since the
work is already pushed into a workqueue, the usage of __hci_cmd_sync is
possible and process the HCI commands one command at a time.

The idea of this patch is to push towards usage of __hci_cmd_sync and
just process the changes to scanning and advertising one command at a
time and thus being able to fail gracefully and eventually recover.

Now the problem is that the usage of hci_req_sync is widespread and
touches pretty much everything. There is also hci_req_run that first
needed to be convert to use a workqueue and also process each command
one a time.

This patch is RFC and not yet ready to be merged, it is meant as a first
starting point to see how the current code can be converted.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Makefile      |   2 +-
 net/bluetooth/hci_le.c      | 665 ++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_le.h      |   3 +
 net/bluetooth/hci_request.c | 451 ++----------------------
 net/bluetooth/mgmt.c        |   4 +-
 5 files changed, 694 insertions(+), 431 deletions(-)
 create mode 100644 net/bluetooth/hci_le.c
 create mode 100644 net/bluetooth/hci_le.h

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index cc0995301f93..b76071e91578 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -14,7 +14,7 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	ecdh_helper.o hci_request.o mgmt_util.o mgmt_config.o
+	ecdh_helper.o hci_request.o mgmt_util.o mgmt_config.o hci_le.o
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
diff --git a/net/bluetooth/hci_le.c b/net/bluetooth/hci_le.c
new file mode 100644
index 000000000000..36f9a4d3db24
--- /dev/null
+++ b/net/bluetooth/hci_le.c
@@ -0,0 +1,665 @@
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "smp.h"
+#include "hci_le.h"
+
+static inline void __cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
+			      const void *param)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_INIT_TIMEOUT);
+	if (!IS_ERR_OR_NULL(skb))
+		kfree_skb(skb);
+}
+
+/* Returns true if an le connection is in the scanning state */
+static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == LE_LINK && c->state == BT_CONNECT &&
+		    test_bit(HCI_CONN_SCANNING, &c->flags)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return false;
+}
+
+static void set_random_addr(struct hci_dev *hdev, bdaddr_t *rpa)
+{
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
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_lookup_le_connect(hdev)) {
+		bt_dev_dbg(hdev, "Deferring random address update");
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		return;
+	}
+
+	__cmd_sync(hdev, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
+}
+
+static int update_random_address(struct hci_dev *hdev, bool require_privacy,
+				 bool use_rpa, u8 *own_addr_type)
+{
+	int err;
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired or there is something else than
+	 * the current RPA in use, then generate a new one.
+	 */
+	if (use_rpa) {
+		int to;
+
+		/* If Controller supports LL Privacy use own address type is
+		 * 0x03
+		 */
+		if (use_ll_privacy(hdev) &&
+		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
+		else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
+		    !bacmp(&hdev->random_addr, &hdev->rpa))
+			return 0;
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			bt_dev_err(hdev, "failed to generate new RPA");
+			return err;
+		}
+
+		set_random_addr(hdev, &hdev->rpa);
+
+		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
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
+		set_random_addr(hdev, &nrpa);
+		return 0;
+	}
+
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address (but skip
+	 * the HCI command if the current random address is already the
+	 * static one.
+	 *
+	 * In case BR/EDR has been disabled on a dual-mode controller
+	 * and a static address has been configured, then use that
+	 * address instead of the public BR/EDR address.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
+	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (bacmp(&hdev->static_addr, &hdev->random_addr))
+			__cmd_sync(hdev, HCI_OP_LE_SET_RANDOM_ADDR,
+					     6, &hdev->static_addr);
+		return 0;
+	}
+
+	/* Neither privacy nor static address is being used so use a
+	 * public address.
+	 */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+	return 0;
+}
+
+static void del_from_filter_allow_list(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				       u8 bdaddr_type)
+{
+	struct hci_cp_le_del_from_white_list cp;
+
+	cp.bdaddr_type = bdaddr_type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	bt_dev_dbg(hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
+		   cp.bdaddr_type);
+	__cmd_sync(hdev, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
+		struct smp_irk *irk;
+
+		irk = hci_find_irk_by_addr(hdev, bdaddr, bdaddr_type);
+		if (irk) {
+			struct hci_cp_le_del_from_resolv_list cp;
+
+			cp.bdaddr_type = bdaddr_type;
+			bacpy(&cp.bdaddr, bdaddr);
+
+			__cmd_sync(hdev, HCI_OP_LE_DEL_FROM_RESOLV_LIST, sizeof(cp), &cp);
+		}
+	}
+}
+
+/* Adds connection to filter allow list if needed. On error, returns -1. */
+static int add_to_filter_allow_list(struct hci_dev *hdev,
+				    struct hci_conn_params *params,
+				    u8 *num_entries, bool allow_rpa)
+{
+	struct hci_cp_le_add_to_white_list cp;
+
+	/* Already in white list */
+	if (hci_bdaddr_list_lookup(&hdev->le_white_list, &params->addr,
+				   params->addr_type))
+		return 0;
+
+	/* Select filter policy to accept all advertising */
+	if (*num_entries >= hdev->le_white_list_size)
+		return -1;
+
+	/* White list can not be used with RPAs */
+	if (!allow_rpa &&
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
+		return -1;
+	}
+
+	/* During suspend, only wakeable devices can be in whitelist */
+	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
+						   params->current_flags))
+		return 0;
+
+	*num_entries += 1;
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+
+	bt_dev_dbg(hdev, "Add %pMR (0x%x) to whitelist", &cp.bdaddr,
+		   cp.bdaddr_type);
+	__cmd_sync(hdev, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
+		struct smp_irk *irk;
+
+		irk = hci_find_irk_by_addr(hdev, &params->addr,
+					   params->addr_type);
+		if (irk) {
+			struct hci_cp_le_add_to_resolv_list cp;
+
+			cp.bdaddr_type = params->addr_type;
+			bacpy(&cp.bdaddr, &params->addr);
+			memcpy(cp.peer_irk, irk->val, 16);
+
+			if (hci_dev_test_flag(hdev, HCI_PRIVACY))
+				memcpy(cp.local_irk, hdev->irk, 16);
+			else
+				memset(cp.local_irk, 0, 16);
+
+			__cmd_sync(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
+		}
+	}
+
+	return 0;
+}
+
+static u8 update_filter_allow_list(struct hci_dev *hdev)
+{
+	struct hci_conn_params *params;
+	struct bdaddr_list *b;
+	u8 num_entries = 0;
+	bool pend_conn, pend_report;
+	/* We allow whitelisting even with RPAs in suspend. In the worst case,
+	 * we won't be able to wake from devices that use the privacy1.2
+	 * features. Additionally, once we support privacy1.2 and IRK
+	 * offloading, we can update this to also check for those conditions.
+	 */
+	bool allow_rpa = hdev->suspended;
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		allow_rpa = true;
+
+	bt_dev_info(hdev, "TRACE: update_white_list");
+
+	/* Go through the current white list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then queue the
+	 * command to remove it from the controller.
+	 */
+	list_for_each_entry(b, &hdev->le_white_list, list) {
+		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
+						      &b->bdaddr,
+						      b->bdaddr_type);
+		pend_report = hci_pend_le_action_lookup(&hdev->pend_le_reports,
+							&b->bdaddr,
+							b->bdaddr_type);
+
+		/* If the device is not likely to connect or report,
+		 * remove it from the whitelist.
+		 */
+		if (!pend_conn && !pend_report) {
+			del_from_filter_allow_list(hdev, &b->bdaddr, b->bdaddr_type);
+			continue;
+		}
+
+		/* White list can not be used with RPAs */
+		if (!allow_rpa &&
+		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
+			return 0x00;
+		}
+
+		num_entries++;
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
+		if (add_to_filter_allow_list(hdev, params, &num_entries, allow_rpa))
+			return 0x00;
+	}
+
+	/* After adding all new pending connections, walk through
+	 * the list of pending reports and also add these to the
+	 * white list if there is still space. Abort if space runs out.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+		if (add_to_filter_allow_list(hdev, params, &num_entries, allow_rpa))
+			return 0x00;
+	}
+
+	/* Use the allowlist unless the following conditions are all true:
+	 * - We are not currently suspending
+	 * - There are 1 or more ADV monitors registered and it's not offloaded
+	 * - Interleaved scanning is not currently using the allowlist
+	 */
+	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended &&
+	    hci_get_adv_monitor_offload_ext(hdev) == HCI_ADV_MONITOR_EXT_NONE &&
+	    hdev->interleave_scan_state != INTERLEAVE_SCAN_ALLOWLIST)
+		return 0x00;
+
+	/* Select filter policy to use white list */
+	return 0x01;
+}
+
+static void le_scan_disable(struct hci_dev *hdev, bool rpa_le_conn)
+{
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return;
+	}
+
+	if (hdev->suspended)
+		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+
+	if (use_ext_scan(hdev)) {
+		struct hci_cp_le_set_ext_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_DISABLE;
+
+		__cmd_sync(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE, sizeof(cp), &cp);
+	} else {
+		struct hci_cp_le_set_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_DISABLE;
+
+		__cmd_sync(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	}
+
+	/* Disable address resolution */
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
+		__u8 enable = 0x00;
+		__cmd_sync(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
+}
+
+static void le_scan_enable(struct hci_dev *hdev, u8 type, u16 interval,
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
+{
+	bt_dev_info(hdev, "TRACE: hci_req_start_scan");
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return;
+	}
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    addr_resolv) {
+		u8 enable = 0x01;
+		__cmd_sync(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
+
+	/* Use ext scanning if set ext scan param and ext scan enable is
+	 * supported
+	 */
+	if (use_ext_scan(hdev)) {
+		struct hci_cp_le_set_ext_scan_params *ext_param_cp;
+		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
+		struct hci_cp_le_scan_phy_params *phy_params;
+		u8 data[sizeof(*ext_param_cp) + sizeof(*phy_params) * 2];
+		u32 plen;
+
+		ext_param_cp = (void *)data;
+		phy_params = (void *)ext_param_cp->data;
+
+		memset(ext_param_cp, 0, sizeof(*ext_param_cp));
+		ext_param_cp->own_addr_type = own_addr_type;
+		ext_param_cp->filter_policy = filter_policy;
+
+		plen = sizeof(*ext_param_cp);
+
+		if (scan_1m(hdev) || scan_2m(hdev)) {
+			ext_param_cp->scanning_phys |= LE_SCAN_PHY_1M;
+
+			memset(phy_params, 0, sizeof(*phy_params));
+			phy_params->type = type;
+			phy_params->interval = cpu_to_le16(interval);
+			phy_params->window = cpu_to_le16(window);
+
+			plen += sizeof(*phy_params);
+			phy_params++;
+		}
+
+		if (scan_coded(hdev)) {
+			ext_param_cp->scanning_phys |= LE_SCAN_PHY_CODED;
+
+			memset(phy_params, 0, sizeof(*phy_params));
+			phy_params->type = type;
+			phy_params->interval = cpu_to_le16(interval);
+			phy_params->window = cpu_to_le16(window);
+
+			plen += sizeof(*phy_params);
+			phy_params++;
+		}
+
+		__cmd_sync(hdev, HCI_OP_LE_SET_EXT_SCAN_PARAMS, plen, ext_param_cp);
+
+		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
+		ext_enable_cp.enable = LE_SCAN_ENABLE;
+		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+		__cmd_sync(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE, sizeof(ext_enable_cp), &ext_enable_cp);
+	} else {
+		struct hci_cp_le_set_scan_param param_cp;
+		struct hci_cp_le_set_scan_enable enable_cp;
+
+		memset(&param_cp, 0, sizeof(param_cp));
+		param_cp.type = type;
+		param_cp.interval = cpu_to_le16(interval);
+		param_cp.window = cpu_to_le16(window);
+		param_cp.own_address_type = own_addr_type;
+		param_cp.filter_policy = filter_policy;
+		__cmd_sync(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp), &param_cp);
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_ENABLE;
+		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		__cmd_sync(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp), &enable_cp);
+	}
+}
+
+static void start_interleave_scan(struct hci_dev *hdev)
+{
+	bt_dev_info(hdev, "TRACE: start_interleave_scan");
+
+	hdev->interleave_scan_state = INTERLEAVE_SCAN_NO_FILTER;
+	queue_delayed_work(hdev->req_workqueue,
+			   &hdev->interleave_scan, 0);
+}
+
+static bool is_interleave_scanning(struct hci_dev *hdev)
+{
+	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
+}
+
+static void cancel_interleave_scan(struct hci_dev *hdev)
+{
+	bt_dev_info(hdev, "TRACE: cancel_interleave_scan");
+
+	bt_dev_dbg(hdev, "cancelling interleave scan");
+
+	cancel_delayed_work_sync(&hdev->interleave_scan);
+
+	hdev->interleave_scan_state = INTERLEAVE_SCAN_NONE;
+}
+
+/* Return true if interleave_scan wasn't started until exiting this function,
+ * otherwise, return false
+ */
+static bool __hci_update_interleaved_scan(struct hci_dev *hdev)
+{
+	/* Do interleaved scan only if all of the following are true:
+	 * - There is at least one ADV monitor
+	 * - At least one pending LE connection or one device to be scanned for
+	 * - Monitor offloading is not supported
+	 * If so, we should alternate between allowlist scan and one without
+	 * any filters to save power.
+	 */
+	bool use_interleaving = hci_is_adv_monitoring(hdev) &&
+				!(list_empty(&hdev->pend_le_conns) &&
+				  list_empty(&hdev->pend_le_reports)) &&
+				hci_get_adv_monitor_offload_ext(hdev) ==
+				    HCI_ADV_MONITOR_EXT_NONE;
+	bool is_interleaving = is_interleave_scanning(hdev);
+
+	bt_dev_info(hdev, "TRACE: __hci_update_interleaved_scan");
+
+	if (use_interleaving && !is_interleaving) {
+		start_interleave_scan(hdev);
+		bt_dev_dbg(hdev, "starting interleave scan");
+		return true;
+	}
+
+	if (!use_interleaving && is_interleaving)
+		cancel_interleave_scan(hdev);
+
+	return false;
+}
+
+static void le_scan_enable_passive(struct hci_dev *hdev)
+{
+	u8 own_addr_type;
+	u8 filter_policy;
+	u16 window, interval;
+	bool require_privacy = false;
+	bool use_rpa = hci_dev_test_flag(hdev, HCI_PRIVACY);
+	/* Background scanning should run with address resolution */
+	bool addr_resolv = true;
+
+	bt_dev_info(hdev, "TRACE: hci_req_add_le_passive_scan");
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return;
+	}
+
+	/* Set require_privacy to false since no SCAN_REQ are send
+	 * during passive scanning. Not using an non-resolvable address
+	 * here is important so that peer devices using direct
+	 * advertising with our address will be correctly reported
+	 * by the controller.
+	 */
+	if (update_random_address(hdev, require_privacy, use_rpa, &own_addr_type))
+		return;
+
+	if (hdev->enable_advmon_interleave_scan &&
+	    __hci_update_interleaved_scan(hdev))
+		return;
+
+	bt_dev_dbg(hdev, "interleave state %d", hdev->interleave_scan_state);
+	/* Adding or removing entries from the white list must
+	 * happen before enabling scanning. The controller does
+	 * not allow filter list modification while scanning.
+	 */
+	filter_policy = update_filter_allow_list(hdev);
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
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
+	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
+		filter_policy |= 0x02;
+
+	if (hdev->suspended) {
+		window = hdev->le_scan_window_suspend;
+		interval = hdev->le_scan_int_suspend;
+
+		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+	} else if (hci_is_le_conn_scanning(hdev)) {
+		window = hdev->le_scan_window_connect;
+		interval = hdev->le_scan_int_connect;
+	} else if (hci_is_adv_monitoring(hdev)) {
+		window = hdev->le_scan_window_adv_monitor;
+		interval = hdev->le_scan_int_adv_monitor;
+	} else {
+		window = hdev->le_scan_window;
+		interval = hdev->le_scan_interval;
+	}
+
+	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
+	le_scan_enable(hdev, LE_SCAN_PASSIVE, interval, window,
+		       own_addr_type, filter_policy, addr_resolv);
+}
+
+void update_background_scan(struct hci_dev *hdev)
+{
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return;
+
+	/* No point in doing scanning if LE support hasn't been enabled */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return;
+
+	/* If discovery is active don't interfere with it */
+	if (hdev->discovery.state != DISCOVERY_STOPPED)
+		return;
+
+	/* Reset RSSI and UUID filters when starting background scanning
+	 * since these filters are meant for service discovery only.
+	 *
+	 * The Start Discovery and Start Service Discovery operations
+	 * ensure to set proper values for RSSI threshold and UUID
+	 * filter list. So it is safe to just reset them here.
+	 */
+	hci_discovery_filter_clear(hdev);
+
+	/* If there is no pending LE connections or devices to be scanned
+	 * for or no advertising monitors, stop the background scan.
+	 */
+	if (list_empty(&hdev->pend_le_conns) &&
+	    list_empty(&hdev->pend_le_reports) &&
+	    !hci_is_adv_monitoring(hdev)) {
+
+		/* If controller is not scanning we are done. */
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+			return;
+
+		le_scan_disable(hdev, false);
+		bt_dev_dbg(hdev, "stopping background scanning");
+	} else {
+		/* If there is at least one pending LE connection, we should
+		 * keep the background scan running.
+		 */
+
+		/* If controller is connecting, we should not start scanning
+		 * since some controllers are not able to scan and connect at
+		 * the same time.
+		 */
+		if (hci_lookup_le_connect(hdev))
+			return;
+
+		/* If controller is currently scanning, we stop it to ensure we
+		 * don't miss any advertising (due to duplicates filter).
+		 */
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+			le_scan_disable(hdev, false);
+
+		le_scan_enable_passive(hdev);
+		bt_dev_dbg(hdev, "starting background scanning");
+	}
+}
+
+void update_interleaved_scan(struct hci_dev *hdev)
+{
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		le_scan_disable(hdev, false);
+
+	le_scan_enable_passive(hdev);
+
+	switch (hdev->interleave_scan_state) {
+	case INTERLEAVE_SCAN_ALLOWLIST:
+		bt_dev_dbg(hdev, "next state: allowlist");
+		hdev->interleave_scan_state = INTERLEAVE_SCAN_NO_FILTER;
+		break;
+	case INTERLEAVE_SCAN_NO_FILTER:
+		bt_dev_dbg(hdev, "next state: no filter");
+		hdev->interleave_scan_state = INTERLEAVE_SCAN_ALLOWLIST;
+		break;
+	case INTERLEAVE_SCAN_NONE:
+		BT_ERR("unexpected error");
+		break;
+	}
+}
+
diff --git a/net/bluetooth/hci_le.h b/net/bluetooth/hci_le.h
new file mode 100644
index 000000000000..3e7984c53dd0
--- /dev/null
+++ b/net/bluetooth/hci_le.h
@@ -0,0 +1,3 @@
+
+void update_background_scan(struct hci_dev *hdev);
+void update_interleaved_scan(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fa9125b782f8..adc3b0523e48 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -29,6 +29,7 @@
 
 #include "smp.h"
 #include "hci_request.h"
+#include "hci_le.h"
 #include "msft.h"
 
 #define HCI_REQ_DONE	  0
@@ -383,134 +384,6 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
-static void start_interleave_scan(struct hci_dev *hdev)
-{
-	hdev->interleave_scan_state = INTERLEAVE_SCAN_NO_FILTER;
-	queue_delayed_work(hdev->req_workqueue,
-			   &hdev->interleave_scan, 0);
-}
-
-static bool is_interleave_scanning(struct hci_dev *hdev)
-{
-	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
-}
-
-static void cancel_interleave_scan(struct hci_dev *hdev)
-{
-	bt_dev_dbg(hdev, "cancelling interleave scan");
-
-	cancel_delayed_work_sync(&hdev->interleave_scan);
-
-	hdev->interleave_scan_state = INTERLEAVE_SCAN_NONE;
-}
-
-/* Return true if interleave_scan wasn't started until exiting this function,
- * otherwise, return false
- */
-static bool __hci_update_interleaved_scan(struct hci_dev *hdev)
-{
-	/* Do interleaved scan only if all of the following are true:
-	 * - There is at least one ADV monitor
-	 * - At least one pending LE connection or one device to be scanned for
-	 * - Monitor offloading is not supported
-	 * If so, we should alternate between allowlist scan and one without
-	 * any filters to save power.
-	 */
-	bool use_interleaving = hci_is_adv_monitoring(hdev) &&
-				!(list_empty(&hdev->pend_le_conns) &&
-				  list_empty(&hdev->pend_le_reports)) &&
-				hci_get_adv_monitor_offload_ext(hdev) ==
-				    HCI_ADV_MONITOR_EXT_NONE;
-	bool is_interleaving = is_interleave_scanning(hdev);
-
-	if (use_interleaving && !is_interleaving) {
-		start_interleave_scan(hdev);
-		bt_dev_dbg(hdev, "starting interleave scan");
-		return true;
-	}
-
-	if (!use_interleaving && is_interleaving)
-		cancel_interleave_scan(hdev);
-
-	return false;
-}
-
-/* This function controls the background scanning based on hdev->pend_le_conns
- * list. If there are pending LE connection we start the background scanning,
- * otherwise we stop it.
- *
- * This function requires the caller holds hdev->lock.
- */
-static void __hci_update_background_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	if (!test_bit(HCI_UP, &hdev->flags) ||
-	    test_bit(HCI_INIT, &hdev->flags) ||
-	    hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
-	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
-	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return;
-
-	/* No point in doing scanning if LE support hasn't been enabled */
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	/* If discovery is active don't interfere with it */
-	if (hdev->discovery.state != DISCOVERY_STOPPED)
-		return;
-
-	/* Reset RSSI and UUID filters when starting background scanning
-	 * since these filters are meant for service discovery only.
-	 *
-	 * The Start Discovery and Start Service Discovery operations
-	 * ensure to set proper values for RSSI threshold and UUID
-	 * filter list. So it is safe to just reset them here.
-	 */
-	hci_discovery_filter_clear(hdev);
-
-	bt_dev_dbg(hdev, "ADV monitoring is %s",
-		   hci_is_adv_monitoring(hdev) ? "on" : "off");
-
-	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports) &&
-	    !hci_is_adv_monitoring(hdev)) {
-		/* If there is no pending LE connections or devices
-		 * to be scanned for or no ADV monitors, we should stop the
-		 * background scanning.
-		 */
-
-		/* If controller is not scanning we are done. */
-		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			return;
-
-		hci_req_add_le_scan_disable(req, false);
-
-		bt_dev_dbg(hdev, "stopping background scanning");
-	} else {
-		/* If there is at least one pending LE connection, we should
-		 * keep the background scan running.
-		 */
-
-		/* If controller is connecting, we should not start scanning
-		 * since some controllers are not able to scan and connect at
-		 * the same time.
-		 */
-		if (hci_lookup_le_connect(hdev))
-			return;
-
-		/* If controller is currently scanning, we stop it to ensure we
-		 * don't miss any advertising (due to duplicates filter).
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req, false);
-
-		hci_req_add_le_passive_scan(req);
-		bt_dev_dbg(hdev, "starting background scanning");
-	}
-}
-
 void __hci_req_update_name(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -745,186 +618,6 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 	}
 }
 
-static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
-				u8 bdaddr_type)
-{
-	struct hci_cp_le_del_from_white_list cp;
-
-	cp.bdaddr_type = bdaddr_type;
-	bacpy(&cp.bdaddr, bdaddr);
-
-	bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
-		   cp.bdaddr_type);
-	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
-
-	if (use_ll_privacy(req->hdev) &&
-	    hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
-		struct smp_irk *irk;
-
-		irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
-		if (irk) {
-			struct hci_cp_le_del_from_resolv_list cp;
-
-			cp.bdaddr_type = bdaddr_type;
-			bacpy(&cp.bdaddr, bdaddr);
-
-			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
-				    sizeof(cp), &cp);
-		}
-	}
-}
-
-/* Adds connection to white list if needed. On error, returns -1. */
-static int add_to_white_list(struct hci_request *req,
-			     struct hci_conn_params *params, u8 *num_entries,
-			     bool allow_rpa)
-{
-	struct hci_cp_le_add_to_white_list cp;
-	struct hci_dev *hdev = req->hdev;
-
-	/* Already in white list */
-	if (hci_bdaddr_list_lookup(&hdev->le_white_list, &params->addr,
-				   params->addr_type))
-		return 0;
-
-	/* Select filter policy to accept all advertising */
-	if (*num_entries >= hdev->le_white_list_size)
-		return -1;
-
-	/* White list can not be used with RPAs */
-	if (!allow_rpa &&
-	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
-		return -1;
-	}
-
-	/* During suspend, only wakeable devices can be in whitelist */
-	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
-						   params->current_flags))
-		return 0;
-
-	*num_entries += 1;
-	cp.bdaddr_type = params->addr_type;
-	bacpy(&cp.bdaddr, &params->addr);
-
-	bt_dev_dbg(hdev, "Add %pMR (0x%x) to whitelist", &cp.bdaddr,
-		   cp.bdaddr_type);
-	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
-
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
-		struct smp_irk *irk;
-
-		irk = hci_find_irk_by_addr(hdev, &params->addr,
-					   params->addr_type);
-		if (irk) {
-			struct hci_cp_le_add_to_resolv_list cp;
-
-			cp.bdaddr_type = params->addr_type;
-			bacpy(&cp.bdaddr, &params->addr);
-			memcpy(cp.peer_irk, irk->val, 16);
-
-			if (hci_dev_test_flag(hdev, HCI_PRIVACY))
-				memcpy(cp.local_irk, hdev->irk, 16);
-			else
-				memset(cp.local_irk, 0, 16);
-
-			hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
-				    sizeof(cp), &cp);
-		}
-	}
-
-	return 0;
-}
-
-static u8 update_white_list(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_conn_params *params;
-	struct bdaddr_list *b;
-	u8 num_entries = 0;
-	bool pend_conn, pend_report;
-	/* We allow whitelisting even with RPAs in suspend. In the worst case,
-	 * we won't be able to wake from devices that use the privacy1.2
-	 * features. Additionally, once we support privacy1.2 and IRK
-	 * offloading, we can update this to also check for those conditions.
-	 */
-	bool allow_rpa = hdev->suspended;
-
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		allow_rpa = true;
-
-	/* Go through the current white list programmed into the
-	 * controller one by one and check if that address is still
-	 * in the list of pending connections or list of devices to
-	 * report. If not present in either list, then queue the
-	 * command to remove it from the controller.
-	 */
-	list_for_each_entry(b, &hdev->le_white_list, list) {
-		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-						      &b->bdaddr,
-						      b->bdaddr_type);
-		pend_report = hci_pend_le_action_lookup(&hdev->pend_le_reports,
-							&b->bdaddr,
-							b->bdaddr_type);
-
-		/* If the device is not likely to connect or report,
-		 * remove it from the whitelist.
-		 */
-		if (!pend_conn && !pend_report) {
-			del_from_white_list(req, &b->bdaddr, b->bdaddr_type);
-			continue;
-		}
-
-		/* White list can not be used with RPAs */
-		if (!allow_rpa &&
-		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
-			return 0x00;
-		}
-
-		num_entries++;
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
-		if (add_to_white_list(req, params, &num_entries, allow_rpa))
-			return 0x00;
-	}
-
-	/* After adding all new pending connections, walk through
-	 * the list of pending reports and also add these to the
-	 * white list if there is still space. Abort if space runs out.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
-		if (add_to_white_list(req, params, &num_entries, allow_rpa))
-			return 0x00;
-	}
-
-	/* Use the allowlist unless the following conditions are all true:
-	 * - We are not currently suspending
-	 * - There are 1 or more ADV monitors registered and it's not offloaded
-	 * - Interleaved scanning is not currently using the allowlist
-	 */
-	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended &&
-	    hci_get_adv_monitor_offload_ext(hdev) == HCI_ADV_MONITOR_EXT_NONE &&
-	    hdev->interleave_scan_state != INTERLEAVE_SCAN_ALLOWLIST)
-		return 0x00;
-
-	/* Select filter policy to use white list */
-	return 0x01;
-}
-
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
@@ -1043,79 +736,6 @@ static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
 	return false;
 }
 
-/* Ensure to call hci_req_add_le_scan_disable() first to disable the
- * controller based address resolution to be able to reconfigure
- * resolving list.
- */
-void hci_req_add_le_passive_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 own_addr_type;
-	u8 filter_policy;
-	u16 window, interval;
-	/* Background scanning should run with address resolution */
-	bool addr_resolv = true;
-
-	if (hdev->scanning_paused) {
-		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-		return;
-	}
-
-	/* Set require_privacy to false since no SCAN_REQ are send
-	 * during passive scanning. Not using an non-resolvable address
-	 * here is important so that peer devices using direct
-	 * advertising with our address will be correctly reported
-	 * by the controller.
-	 */
-	if (hci_update_random_address(req, false, scan_use_rpa(hdev),
-				      &own_addr_type))
-		return;
-
-	if (hdev->enable_advmon_interleave_scan &&
-	    __hci_update_interleaved_scan(hdev))
-		return;
-
-	bt_dev_dbg(hdev, "interleave state %d", hdev->interleave_scan_state);
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
-	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
-	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
-		filter_policy |= 0x02;
-
-	if (hdev->suspended) {
-		window = hdev->le_scan_window_suspend;
-		interval = hdev->le_scan_int_suspend;
-
-		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
-	} else if (hci_is_le_conn_scanning(hdev)) {
-		window = hdev->le_scan_window_connect;
-		interval = hdev->le_scan_int_connect;
-	} else if (hci_is_adv_monitoring(hdev)) {
-		window = hdev->le_scan_window_adv_monitor;
-		interval = hdev->le_scan_int_adv_monitor;
-	} else {
-		window = hdev->le_scan_window;
-		interval = hdev->le_scan_interval;
-	}
-
-	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
-	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy, addr_resolv);
-}
-
 static bool adv_instance_is_scannable(struct hci_dev *hdev, u8 instance)
 {
 	struct adv_info *adv_instance;
@@ -1281,6 +901,15 @@ static void hci_req_add_set_adv_filter_enable(struct hci_request *req,
 		set_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks);
 }
 
+static void cancel_interleave_scan(struct hci_dev *hdev)
+{
+	bt_dev_dbg(hdev, "cancelling interleave scan");
+
+	cancel_delayed_work_sync(&hdev->interleave_scan);
+
+	hdev->interleave_scan_state = INTERLEAVE_SCAN_NONE;
+}
+
 /* Call with hci_dev_lock */
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 {
@@ -1371,7 +1000,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		/* Enable event filter for paired devices */
 		hci_req_set_event_filter(&req);
 		/* Enable passive scan at lower duty cycle */
-		__hci_update_background_scan(&req);
+		// FIXME __hci_update_background_scan(&req);
 		/* Pause scan changes again. */
 		hdev->scanning_paused = true;
 		hci_req_run(&req, suspend_req_complete);
@@ -1384,7 +1013,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		__hci_req_update_scan(&req);
 
 		/* Reset passive/background scanning to normal */
-		__hci_update_background_scan(&req);
+		// FIXME __hci_update_background_scan(&req);
 		/* Enable all of the advertisement filters */
 		hci_req_add_set_adv_filter_enable(&req, true);
 
@@ -1978,42 +1607,15 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static int hci_req_add_le_interleaved_scan(struct hci_request *req,
-					   unsigned long opt)
+static bool is_interleave_scanning(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev = req->hdev;
-	int ret = 0;
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req, false);
-	hci_req_add_le_passive_scan(req);
-
-	switch (hdev->interleave_scan_state) {
-	case INTERLEAVE_SCAN_ALLOWLIST:
-		bt_dev_dbg(hdev, "next state: allowlist");
-		hdev->interleave_scan_state = INTERLEAVE_SCAN_NO_FILTER;
-		break;
-	case INTERLEAVE_SCAN_NO_FILTER:
-		bt_dev_dbg(hdev, "next state: no filter");
-		hdev->interleave_scan_state = INTERLEAVE_SCAN_ALLOWLIST;
-		break;
-	case INTERLEAVE_SCAN_NONE:
-		BT_ERR("unexpected error");
-		ret = -1;
-	}
-
-	hci_dev_unlock(hdev);
-
-	return ret;
+	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
 }
 
 static void interleave_scan_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    interleave_scan.work);
-	u8 status;
 	unsigned long timeout;
 
 	if (hdev->interleave_scan_state == INTERLEAVE_SCAN_ALLOWLIST) {
@@ -2025,8 +1627,7 @@ static void interleave_scan_work(struct work_struct *work)
 		return;
 	}
 
-	hci_req_sync(hdev, hci_req_add_le_interleaved_scan, 0,
-		     HCI_CMD_TIMEOUT, &status);
+	update_interleaved_scan(hdev);
 
 	/* Don't continue interleaving if it was canceled */
 	if (is_interleave_scanning(hdev))
@@ -2695,8 +2296,6 @@ static int connectable_update(struct hci_request *req, unsigned long opt)
 			__hci_req_enable_advertising(req);
 	}
 
-	__hci_update_background_scan(req);
-
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -2709,6 +2308,11 @@ static void connectable_update_work(struct work_struct *work)
 	u8 status;
 
 	hci_req_sync(hdev, connectable_update, 0, HCI_CMD_TIMEOUT, &status);
+
+	hci_req_sync_lock(hdev);
+	update_background_scan(hdev);
+	hci_req_sync_unlock(hdev);
+
 	mgmt_set_connectable_complete(hdev, status);
 }
 
@@ -2918,25 +2522,16 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static int update_bg_scan(struct hci_request *req, unsigned long opt)
-{
-	hci_dev_lock(req->hdev);
-	__hci_update_background_scan(req);
-	hci_dev_unlock(req->hdev);
-	return 0;
-}
-
 static void bg_scan_update(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    bg_scan_update);
 	struct hci_conn *conn;
 	u8 status;
-	int err;
 
-	err = hci_req_sync(hdev, update_bg_scan, 0, HCI_CMD_TIMEOUT, &status);
-	if (!err)
-		return;
+	hci_req_sync_lock(hdev);
+	update_background_scan(hdev);
+	hci_req_sync_unlock(hdev);
 
 	hci_dev_lock(hdev);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b44e19c69c44..2f6dfb5dc560 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5587,8 +5587,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req, false);
-		hci_req_add_le_passive_scan(&req);
+		// FIXME hci_req_add_le_scan_disable(&req, false);
+		// FIXME hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
 	}
-- 
2.31.1

