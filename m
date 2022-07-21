Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C648C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiGUXWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiGUXWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:22:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF88E4EC
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658445760; x=1689981760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3nokhxK54zMwMFCvT8q+KVyKHe8NN9bs9GkxoAnPx5U=;
  b=c7k5lTsYZFn/wL9q4iUD+mbXmuw4PzXE93Ihovg3AvhmWyD1x8JowB52
   tN2TxzWaSJd2kaSBml7j3yZv3r771NSwrTHqtB9EsT0a5VN0wsXj15+bD
   EvbPSwTOSlXobpzIpCYQhafHlxC2dx2djJwk+r3wA+aFvPE0JIeeWncnx
   IgNpx1Hxx7OryD+xn2gsi77F94seO5h2UDgwZfUG4UNq3vOVxz2p1lZ0E
   HJx3I/BnEvny8ds1v+l1IRycGq3cLEADPb6WO8kGjFSM3UfkE9Ae5RlI6
   6ZAjhOk+QwNa5Skwk1iMua23E20Gqncv9al8g0l/hpM8DUI8JUNOT2v0z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312912919"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312912919"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631363088"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:39 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 1/3] Bluetooth: Remove dead code from hci_request.c
Date:   Thu, 21 Jul 2022 16:22:23 -0700
Message-Id: <20220721232225.624426-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721232225.624426-1-brian.gix@intel.com>
References: <20220721232225.624426-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The discov_update work queue is no longer used as a result
of the hci_sync rework.

The __hci_req_hci_power_on() function is no longer referenced in the
code as a result of the hci_sync rework.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 -
 net/bluetooth/hci_request.c      | 287 -------------------------------
 net/bluetooth/hci_request.h      |   2 -
 3 files changed, 290 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 15237ee5f761..bf6aa6f39632 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -520,7 +520,6 @@ struct hci_dev {
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
 
-	struct work_struct	discov_update;
 	struct work_struct	scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 635cc5fb451e..9340fdbff679 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2227,146 +2227,6 @@ static void le_scan_restart_work(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
-static int active_scan(struct hci_request *req, unsigned long opt)
-{
-	uint16_t interval = opt;
-	struct hci_dev *hdev = req->hdev;
-	u8 own_addr_type;
-	/* Accept list is not used for discovery */
-	u8 filter_policy = 0x00;
-	/* Default is to enable duplicates filter */
-	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-	/* Discovery doesn't require controller address resolution */
-	bool addr_resolv = false;
-	int err;
-
-	bt_dev_dbg(hdev, "");
-
-	/* If controller is scanning, it means the background scanning is
-	 * running. Thus, we should temporarily stop it in order to set the
-	 * discovery scanning parameters.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_req_add_le_scan_disable(req, false);
-		cancel_interleave_scan(hdev);
-	}
-
-	/* All active scans will be done with either a resolvable private
-	 * address (when privacy feature has been enabled) or non-resolvable
-	 * private address.
-	 */
-	err = hci_update_random_address(req, true, scan_use_rpa(hdev),
-					&own_addr_type);
-	if (err < 0)
-		own_addr_type = ADDR_LE_DEV_PUBLIC;
-
-	hci_dev_lock(hdev);
-	if (hci_is_adv_monitoring(hdev)) {
-		/* Duplicate filter should be disabled when some advertisement
-		 * monitor is activated, otherwise AdvMon can only receive one
-		 * advertisement for one peer(*) during active scanning, and
-		 * might report loss to these peers.
-		 *
-		 * Note that different controllers have different meanings of
-		 * |duplicate|. Some of them consider packets with the same
-		 * address as duplicate, and others consider packets with the
-		 * same address and the same RSSI as duplicate. Although in the
-		 * latter case we don't need to disable duplicate filter, but
-		 * it is common to have active scanning for a short period of
-		 * time, the power impact should be neglectable.
-		 */
-		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
-	}
-	hci_dev_unlock(hdev);
-
-	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
-			   hdev->le_scan_window_discovery, own_addr_type,
-			   filter_policy, filter_dup, addr_resolv);
-	return 0;
-}
-
-static int interleaved_discov(struct hci_request *req, unsigned long opt)
-{
-	int err;
-
-	bt_dev_dbg(req->hdev, "");
-
-	err = active_scan(req, opt);
-	if (err)
-		return err;
-
-	return bredr_inquiry(req, DISCOV_BREDR_INQUIRY_LEN);
-}
-
-static void start_discovery(struct hci_dev *hdev, u8 *status)
-{
-	unsigned long timeout;
-
-	bt_dev_dbg(hdev, "type %u", hdev->discovery.type);
-
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_BREDR:
-		if (!hci_dev_test_flag(hdev, HCI_INQUIRY))
-			hci_req_sync(hdev, bredr_inquiry,
-				     DISCOV_BREDR_INQUIRY_LEN, HCI_CMD_TIMEOUT,
-				     status);
-		return;
-	case DISCOV_TYPE_INTERLEAVED:
-		/* When running simultaneous discovery, the LE scanning time
-		 * should occupy the whole discovery time sine BR/EDR inquiry
-		 * and LE scanning are scheduled by the controller.
-		 *
-		 * For interleaving discovery in comparison, BR/EDR inquiry
-		 * and LE scanning are done sequentially with separate
-		 * timeouts.
-		 */
-		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
-			     &hdev->quirks)) {
-			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-			/* During simultaneous discovery, we double LE scan
-			 * interval. We must leave some time for the controller
-			 * to do BR/EDR inquiry.
-			 */
-			hci_req_sync(hdev, interleaved_discov,
-				     hdev->le_scan_int_discovery * 2, HCI_CMD_TIMEOUT,
-				     status);
-			break;
-		}
-
-		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
-		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
-			     HCI_CMD_TIMEOUT, status);
-		break;
-	case DISCOV_TYPE_LE:
-		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
-			     HCI_CMD_TIMEOUT, status);
-		break;
-	default:
-		*status = HCI_ERROR_UNSPECIFIED;
-		return;
-	}
-
-	if (*status)
-		return;
-
-	bt_dev_dbg(hdev, "timeout %u ms", jiffies_to_msecs(timeout));
-
-	/* When service discovery is used and the controller has a
-	 * strict duplicate filter, it is important to remember the
-	 * start and duration of the scan. This is required for
-	 * restarting scanning during the discovery phase.
-	 */
-	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
-		     hdev->discovery.result_filtering) {
-		hdev->discovery.scan_start = jiffies;
-		hdev->discovery.scan_duration = timeout;
-	}
-
-	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_disable,
-			   timeout);
-}
-
 bool hci_req_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -2462,42 +2322,6 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
 	return err;
 }
 
-static int stop_discovery(struct hci_request *req, unsigned long opt)
-{
-	hci_dev_lock(req->hdev);
-	hci_req_stop_discovery(req);
-	hci_dev_unlock(req->hdev);
-
-	return 0;
-}
-
-static void discov_update(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    discov_update);
-	u8 status = 0;
-
-	switch (hdev->discovery.state) {
-	case DISCOVERY_STARTING:
-		start_discovery(hdev, &status);
-		mgmt_start_discovery_complete(hdev, status);
-		if (status)
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		else
-			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-		break;
-	case DISCOVERY_STOPPING:
-		hci_req_sync(hdev, stop_discovery, 0, HCI_CMD_TIMEOUT, &status);
-		mgmt_stop_discovery_complete(hdev, status);
-		if (!status)
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		break;
-	case DISCOVERY_STOPPED:
-	default:
-		return;
-	}
-}
-
 static void discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -2522,118 +2346,8 @@ static void discov_off(struct work_struct *work)
 	mgmt_new_settings(hdev);
 }
 
-static int powered_update_hci(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 link_sec;
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
-	    !lmp_host_ssp_capable(hdev)) {
-		u8 mode = 0x01;
-
-		hci_req_add(req, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
-
-		if (bredr_sc_enabled(hdev) && !lmp_host_sc_capable(hdev)) {
-			u8 support = 0x01;
-
-			hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
-				    sizeof(support), &support);
-		}
-	}
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
-	    lmp_bredr_capable(hdev)) {
-		struct hci_cp_write_le_host_supported cp;
-
-		cp.le = 0x01;
-		cp.simul = 0x00;
-
-		/* Check first if we already have the right
-		 * host state (host features set)
-		 */
-		if (cp.le != lmp_host_le_capable(hdev) ||
-		    cp.simul != lmp_host_le_br_capable(hdev))
-			hci_req_add(req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
-				    sizeof(cp), &cp);
-	}
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
-		/* Make sure the controller has a good default for
-		 * advertising data. This also applies to the case
-		 * where BR/EDR was toggled during the AUTO_OFF phase.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		    list_empty(&hdev->adv_instances)) {
-			int err;
-
-			if (ext_adv_capable(hdev)) {
-				err = __hci_req_setup_ext_adv_instance(req,
-								       0x00);
-				if (!err)
-					__hci_req_update_scan_rsp_data(req,
-								       0x00);
-			} else {
-				err = 0;
-				__hci_req_update_adv_data(req, 0x00);
-				__hci_req_update_scan_rsp_data(req, 0x00);
-			}
-
-			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-				if (!ext_adv_capable(hdev))
-					__hci_req_enable_advertising(req);
-				else if (!err)
-					__hci_req_enable_ext_advertising(req,
-									 0x00);
-			}
-		} else if (!list_empty(&hdev->adv_instances)) {
-			struct adv_info *adv_instance;
-
-			adv_instance = list_first_entry(&hdev->adv_instances,
-							struct adv_info, list);
-			__hci_req_schedule_adv_instance(req,
-							adv_instance->instance,
-							true);
-		}
-	}
-
-	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
-	if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
-		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE,
-			    sizeof(link_sec), &link_sec);
-
-	if (lmp_bredr_capable(hdev)) {
-		if (hci_dev_test_flag(hdev, HCI_FAST_CONNECTABLE))
-			__hci_req_write_fast_connectable(req, true);
-		else
-			__hci_req_write_fast_connectable(req, false);
-		__hci_req_update_scan(req);
-		__hci_req_update_class(req);
-		__hci_req_update_name(req);
-		__hci_req_update_eir(req);
-	}
-
-	hci_dev_unlock(hdev);
-	return 0;
-}
-
-int __hci_req_hci_power_on(struct hci_dev *hdev)
-{
-	/* Register the available SMP channels (BR/EDR and LE) only when
-	 * successfully powering on the controller. This late
-	 * registration is required so that LE SMP can clearly decide if
-	 * the public address or static address is used.
-	 */
-	smp_register(hdev);
-
-	return __hci_req_sync(hdev, powered_update_hci, 0, HCI_CMD_TIMEOUT,
-			      NULL);
-}
-
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_WORK(&hdev->discov_update, discov_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
@@ -2646,7 +2360,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->scan_update);
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 7f8df258e295..2b2fba278510 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -68,8 +68,6 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
-int __hci_req_hci_power_on(struct hci_dev *hdev);
-
 void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
 void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
-- 
2.36.1

