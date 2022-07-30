Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421BC19F2B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiG3Au5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiG3Aux (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EE73928
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142252; x=1690678252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isHZ1reQm3CO7f0EcBs3mIfRohOyFWFoL/BZJWwmvDc=;
  b=fK07ms9L+OI8fIEWJ8wJNzsd8KXmz+waA7MMQ86EapNKvmkl2Ou3fdO7
   gyIHUscv3THP0lasTPAqw5SFGEYIzI2tP12scSqaBsE+jBV6bg8BYICgQ
   4cLpmF/L45NbFH3vdQ2HaY41vK39/mslpLWolWDhiWuuVWNmkhkBvMXF3
   NesFUhpxTeQVAnC7V7KUmCLfTzYYPRVLlxanucLdTOWfqxGYrLY6FRGxG
   g7Ncrd6ppYScjBbZOAnok4EV0W80kYY1FiZtZII9l9VccThLT+WusanSE
   gLMbwMX59dcZGewaOuFDms6xaCwb6RgYmkHSifg4cYkNlI5/yFNqkNuYe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644793"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458118"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 05/10] Bluetooth: Convert Interleave Scanning timeout to hci_sync
Date:   Fri, 29 Jul 2022 17:50:33 -0700
Message-Id: <20220730005038.894650-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The interleave sacanning timer was running using the deprecated hci_request
method instead of the new hci_sync methodology.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_request.c | 472 ------------------------------------
 net/bluetooth/hci_request.h |  12 -
 net/bluetooth/hci_sync.c    |  65 ++++-
 3 files changed, 60 insertions(+), 489 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d14e50951aec..fe70be6e1981 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -306,58 +306,6 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
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
 void __hci_req_update_name(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -429,278 +377,6 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 	}
 }
 
-static void del_from_accept_list(struct hci_request *req, bdaddr_t *bdaddr,
-				 u8 bdaddr_type)
-{
-	struct hci_cp_le_del_from_accept_list cp;
-
-	cp.bdaddr_type = bdaddr_type;
-	bacpy(&cp.bdaddr, bdaddr);
-
-	bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from accept list", &cp.bdaddr,
-		   cp.bdaddr_type);
-	hci_req_add(req, HCI_OP_LE_DEL_FROM_ACCEPT_LIST, sizeof(cp), &cp);
-
-	if (use_ll_privacy(req->hdev)) {
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
-/* Adds connection to accept list if needed. On error, returns -1. */
-static int add_to_accept_list(struct hci_request *req,
-			      struct hci_conn_params *params, u8 *num_entries,
-			      bool allow_rpa)
-{
-	struct hci_cp_le_add_to_accept_list cp;
-	struct hci_dev *hdev = req->hdev;
-
-	/* Already in accept list */
-	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
-				   params->addr_type))
-		return 0;
-
-	/* Select filter policy to accept all advertising */
-	if (*num_entries >= hdev->le_accept_list_size)
-		return -1;
-
-	/* Accept list can not be used with RPAs */
-	if (!allow_rpa &&
-	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
-		return -1;
-	}
-
-	/* During suspend, only wakeable devices can be in accept list */
-	if (hdev->suspended &&
-	    !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-		return 0;
-
-	*num_entries += 1;
-	cp.bdaddr_type = params->addr_type;
-	bacpy(&cp.bdaddr, &params->addr);
-
-	bt_dev_dbg(hdev, "Add %pMR (0x%x) to accept list", &cp.bdaddr,
-		   cp.bdaddr_type);
-	hci_req_add(req, HCI_OP_LE_ADD_TO_ACCEPT_LIST, sizeof(cp), &cp);
-
-	if (use_ll_privacy(hdev)) {
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
-static u8 update_accept_list(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_conn_params *params;
-	struct bdaddr_list *b;
-	u8 num_entries = 0;
-	bool pend_conn, pend_report;
-	/* We allow usage of accept list even with RPAs in suspend. In the worst
-	 * case, we won't be able to wake from devices that use the privacy1.2
-	 * features. Additionally, once we support privacy1.2 and IRK
-	 * offloading, we can update this to also check for those conditions.
-	 */
-	bool allow_rpa = hdev->suspended;
-
-	if (use_ll_privacy(hdev))
-		allow_rpa = true;
-
-	/* Go through the current accept list programmed into the
-	 * controller one by one and check if that address is still
-	 * in the list of pending connections or list of devices to
-	 * report. If not present in either list, then queue the
-	 * command to remove it from the controller.
-	 */
-	list_for_each_entry(b, &hdev->le_accept_list, list) {
-		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-						      &b->bdaddr,
-						      b->bdaddr_type);
-		pend_report = hci_pend_le_action_lookup(&hdev->pend_le_reports,
-							&b->bdaddr,
-							b->bdaddr_type);
-
-		/* If the device is not likely to connect or report,
-		 * remove it from the accept list.
-		 */
-		if (!pend_conn && !pend_report) {
-			del_from_accept_list(req, &b->bdaddr, b->bdaddr_type);
-			continue;
-		}
-
-		/* Accept list can not be used with RPAs */
-		if (!allow_rpa &&
-		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
-			return 0x00;
-		}
-
-		num_entries++;
-	}
-
-	/* Since all no longer valid accept list entries have been
-	 * removed, walk through the list of pending connections
-	 * and ensure that any new device gets programmed into
-	 * the controller.
-	 *
-	 * If the list of the devices is larger than the list of
-	 * available accept list entries in the controller, then
-	 * just abort and return filer policy value to not use the
-	 * accept list.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
-		if (add_to_accept_list(req, params, &num_entries, allow_rpa))
-			return 0x00;
-	}
-
-	/* After adding all new pending connections, walk through
-	 * the list of pending reports and also add these to the
-	 * accept list if there is still space. Abort if space runs out.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
-		if (add_to_accept_list(req, params, &num_entries, allow_rpa))
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
-	/* Select filter policy to use accept list */
-	return 0x01;
-}
-
-static bool scan_use_rpa(struct hci_dev *hdev)
-{
-	return hci_dev_test_flag(hdev, HCI_PRIVACY);
-}
-
-static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy,
-			       bool filter_dup, bool addr_resolv)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	if (hdev->scanning_paused) {
-		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-		return;
-	}
-
-	if (use_ll_privacy(hdev) && addr_resolv) {
-		u8 enable = 0x01;
-
-		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
-	}
-
-	/* Use ext scanning if set ext scan param and ext scan enable is
-	 * supported
-	 */
-	if (use_ext_scan(hdev)) {
-		struct hci_cp_le_set_ext_scan_params *ext_param_cp;
-		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
-		struct hci_cp_le_scan_phy_params *phy_params;
-		u8 data[sizeof(*ext_param_cp) + sizeof(*phy_params) * 2];
-		u32 plen;
-
-		ext_param_cp = (void *)data;
-		phy_params = (void *)ext_param_cp->data;
-
-		memset(ext_param_cp, 0, sizeof(*ext_param_cp));
-		ext_param_cp->own_addr_type = own_addr_type;
-		ext_param_cp->filter_policy = filter_policy;
-
-		plen = sizeof(*ext_param_cp);
-
-		if (scan_1m(hdev) || scan_2m(hdev)) {
-			ext_param_cp->scanning_phys |= LE_SCAN_PHY_1M;
-
-			memset(phy_params, 0, sizeof(*phy_params));
-			phy_params->type = type;
-			phy_params->interval = cpu_to_le16(interval);
-			phy_params->window = cpu_to_le16(window);
-
-			plen += sizeof(*phy_params);
-			phy_params++;
-		}
-
-		if (scan_coded(hdev)) {
-			ext_param_cp->scanning_phys |= LE_SCAN_PHY_CODED;
-
-			memset(phy_params, 0, sizeof(*phy_params));
-			phy_params->type = type;
-			phy_params->interval = cpu_to_le16(interval);
-			phy_params->window = cpu_to_le16(window);
-
-			plen += sizeof(*phy_params);
-			phy_params++;
-		}
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
-			    plen, ext_param_cp);
-
-		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
-		ext_enable_cp.enable = LE_SCAN_ENABLE;
-		ext_enable_cp.filter_dup = filter_dup;
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
-			    sizeof(ext_enable_cp), &ext_enable_cp);
-	} else {
-		struct hci_cp_le_set_scan_param param_cp;
-		struct hci_cp_le_set_scan_enable enable_cp;
-
-		memset(&param_cp, 0, sizeof(param_cp));
-		param_cp.type = type;
-		param_cp.interval = cpu_to_le16(interval);
-		param_cp.window = cpu_to_le16(window);
-		param_cp.own_address_type = own_addr_type;
-		param_cp.filter_policy = filter_policy;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-			    &param_cp);
-
-		memset(&enable_cp, 0, sizeof(enable_cp));
-		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = filter_dup;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-			    &enable_cp);
-	}
-}
-
 /* Returns true if an le connection is in the scanning state */
 static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
 {
@@ -722,95 +398,6 @@ static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
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
-	/* Default is to enable duplicates filter */
-	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
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
-	/* Adding or removing entries from the accept list must
-	 * happen before enabling scanning. The controller does
-	 * not allow accept list modification while scanning.
-	 */
-	filter_policy = update_accept_list(req);
-
-	/* When the controller is using random resolvable addresses and
-	 * with that having LE privacy enabled, then controllers with
-	 * Extended Scanner Filter Policies support can now enable support
-	 * for handling directed advertising.
-	 *
-	 * So instead of using filter polices 0x00 (no accept list)
-	 * and 0x01 (accept list enabled) use the new filter policies
-	 * 0x02 (no accept list) and 0x03 (accept list enabled).
-	 */
-	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
-	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
-		filter_policy |= 0x02;
-
-	if (hdev->suspended) {
-		window = hdev->le_scan_window_suspend;
-		interval = hdev->le_scan_int_suspend;
-	} else if (hci_is_le_conn_scanning(hdev)) {
-		window = hdev->le_scan_window_connect;
-		interval = hdev->le_scan_int_connect;
-	} else if (hci_is_adv_monitoring(hdev)) {
-		window = hdev->le_scan_window_adv_monitor;
-		interval = hdev->le_scan_int_adv_monitor;
-
-		/* Disable duplicates filter when scanning for advertisement
-		 * monitor for the following reasons.
-		 *
-		 * For HW pattern filtering (ex. MSFT), Realtek and Qualcomm
-		 * controllers ignore RSSI_Sampling_Period when the duplicates
-		 * filter is enabled.
-		 *
-		 * For SW pattern filtering, when we're not doing interleaved
-		 * scanning, it is necessary to disable duplicates filter,
-		 * otherwise hosts can only receive one advertisement and it's
-		 * impossible to know if a peer is still in range.
-		 */
-		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
-	} else {
-		window = hdev->le_scan_window;
-		interval = hdev->le_scan_interval;
-	}
-
-	bt_dev_dbg(hdev, "LE passive scan with accept list = %d",
-		   filter_policy);
-	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy, filter_dup,
-			   addr_resolv);
-}
-
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
@@ -1171,62 +758,6 @@ static void adv_timeout_expire(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static int hci_req_add_le_interleaved_scan(struct hci_request *req,
-					   unsigned long opt)
-{
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
-}
-
-static void interleave_scan_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    interleave_scan.work);
-	u8 status;
-	unsigned long timeout;
-
-	if (hdev->interleave_scan_state == INTERLEAVE_SCAN_ALLOWLIST) {
-		timeout = msecs_to_jiffies(hdev->advmon_allowlist_duration);
-	} else if (hdev->interleave_scan_state == INTERLEAVE_SCAN_NO_FILTER) {
-		timeout = msecs_to_jiffies(hdev->advmon_no_filter_duration);
-	} else {
-		bt_dev_err(hdev, "unexpected error");
-		return;
-	}
-
-	hci_req_sync(hdev, hci_req_add_le_interleaved_scan, 0,
-		     HCI_CMD_TIMEOUT, &status);
-
-	/* Don't continue interleaving if it was canceled */
-	if (is_interleave_scanning(hdev))
-		queue_delayed_work(hdev->req_workqueue,
-				   &hdev->interleave_scan, timeout);
-}
-
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr)
@@ -1978,7 +1509,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
-	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
 }
 
 void hci_request_cancel_all(struct hci_dev *hdev)
@@ -1989,6 +1519,4 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 		cancel_delayed_work_sync(&hdev->adv_instance_expire);
 		hdev->adv_instance_timeout = 0;
 	}
-
-	cancel_interleave_scan(hdev);
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 41e0b84f2042..093ad8ec469d 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -73,9 +73,6 @@ void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
 
 void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
-void hci_req_add_le_passive_scan(struct hci_request *req);
-
-void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
 void hci_req_disable_address_resolution(struct hci_dev *hdev);
 void hci_req_reenable_advertising(struct hci_dev *hdev);
@@ -83,9 +80,6 @@ void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
 int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
-int hci_req_start_per_adv(struct hci_dev *hdev, u8 instance, u32 flags,
-			  u16 min_interval, u16 max_interval,
-			  u16 sync_interval);
 void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
@@ -95,14 +89,8 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 				bool force);
 
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
-int __hci_req_setup_per_adv_instance(struct hci_request *req, u8 instance,
-				     u16 min_interval, u16 max_interval);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
-int __hci_req_start_per_adv(struct hci_request *req, u8 instance, u32 flags,
-			    u16 min_interval, u16 max_interval,
-			    u16 sync_interval);
 int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
-int __hci_req_enable_per_advertising(struct hci_request *req, u8 instance);
 int __hci_req_disable_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_remove_ext_adv_instance(struct hci_request *req, u8 instance);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 19d57ec0feb8..bf4a87c51548 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -465,6 +465,64 @@ static void le_scan_restart(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static bool is_interleave_scanning(struct hci_dev *hdev)
+{
+	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
+}
+
+static int hci_passive_scan_sync(struct hci_dev *hdev);
+static int add_le_interleaved_scan_sync(struct hci_dev *hdev, void *data)
+{
+	int ret = 0;
+	unsigned long timeout;
+
+	if (hdev->interleave_scan_state == INTERLEAVE_SCAN_ALLOWLIST) {
+		timeout = msecs_to_jiffies(hdev->advmon_allowlist_duration);
+	} else if (hdev->interleave_scan_state == INTERLEAVE_SCAN_NO_FILTER) {
+		timeout = msecs_to_jiffies(hdev->advmon_no_filter_duration);
+	} else {
+		bt_dev_err(hdev, "unexpected error");
+		return -1;
+	}
+
+	hci_passive_scan_sync(hdev);
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
+		ret = -1;
+	}
+
+	/* Don't continue interleaving if it was canceled */
+	if (is_interleave_scanning(hdev))
+		queue_delayed_work(hdev->req_workqueue,
+				   &hdev->interleave_scan, timeout);
+
+	return ret;
+}
+
+static void interleave_scan(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    interleave_scan.work);
+
+	if (hdev->interleave_scan_state != INTERLEAVE_SCAN_ALLOWLIST &&
+	    hdev->interleave_scan_state != INTERLEAVE_SCAN_NO_FILTER) {
+		bt_dev_err(hdev, "unexpected error");
+		return;
+	}
+
+	hci_cmd_sync_queue(hdev, add_le_interleaved_scan_sync, NULL, NULL);
+}
+
 void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
@@ -474,6 +532,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
+	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan);
 }
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
@@ -1860,11 +1919,6 @@ static void hci_start_interleave_scan(struct hci_dev *hdev)
 			   &hdev->interleave_scan, 0);
 }
 
-static bool is_interleave_scanning(struct hci_dev *hdev)
-{
-	return hdev->interleave_scan_state != INTERLEAVE_SCAN_NONE;
-}
-
 static void cancel_interleave_scan(struct hci_dev *hdev)
 {
 	bt_dev_dbg(hdev, "cancelling interleave scan");
@@ -4563,6 +4617,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
 	cancel_delayed_work(&hdev->le_scan_restart);
+	cancel_interleave_scan(hdev);
 
 	hci_request_cancel_all(hdev);
 
-- 
2.37.1

