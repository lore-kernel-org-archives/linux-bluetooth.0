Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94852CCA485
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGUW5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiGUW5i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 18:57:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F78E1E9
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658444257; x=1689980257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pC+7N7uNNVuDO+568x3woEEyHpkBiT2leXgeP5/ujM=;
  b=kFzs77gBSlDHEZEKTTZfIzKAl2vPYObLenchNqYyZ4CHQW5m19Mn/NS3
   KbQkCOskWG/WlgIWBF+Mocw82FoWKBN4tQblEPYX53UBIXuW4Z+Bmk/kJ
   LfkAZXmSDuUGgjQCWORMO9r+3iv/BwUsbpwr0YnfVYzek0Nco4kBXEfSn
   c0KULPbWjT6JuKGJ/dQZ9dyR6hl1QwbuUfeHWfuNbwkVKYemg8NhtJZGV
   WaIIjvhnCw6Egpd9nE69dGKBP93UGNUb1gjhWUWnxKy2YygF8Sr1UhHEb
   JjiFPU4VmS2vFpwzXiQ7TeOT2nriIsXZp00TBear5iWIp4totbCSbfCG2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267586481"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267586481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548961961"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:18 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 1/3] Bluetooth: Remove dead code from hci_request.c
Date:   Thu, 21 Jul 2022 15:57:03 -0700
Message-Id: <20220721225705.602002-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721225705.602002-1-brian.gix@intel.com>
References: <20220721225705.602002-1-brian.gix@intel.com>
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
 net/bluetooth/hci_request.c      | 311 -------------------------------
 net/bluetooth/hci_request.h      |   2 -
 3 files changed, 314 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index af2f3dc18e1d..6b76d536dce0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -523,7 +523,6 @@ struct hci_dev {
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
 
-	struct work_struct	discov_update;
 	struct work_struct	scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7b56f330635e..967df3ab118f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2269,170 +2269,6 @@ static void le_scan_restart_work(struct work_struct *work)
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
-static int mesh_scan(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-	u16 window = hdev->le_scan_window;
-
-	BT_INFO("MESH-SCAN %s", hdev->name);
-
-	/* In Mesh mode we are always at least passive scanning,
-	 * with no filtering
-	 */
-
-	hci_req_start_scan(req, LE_SCAN_PASSIVE, window, window,
-			   0x00, 0x00, false, false);
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
-		if (hci_dev_test_flag(hdev, HCI_MESH)) {
-			BT_INFO("LE Discovery - (passive)");
-			hci_req_sync(hdev, mesh_scan, DISCOV_LE_SCAN_INT,
-				     HCI_CMD_TIMEOUT, status);
-		} else {
-			BT_INFO("LE Discovery - (active)");
-			hci_req_sync(hdev, active_scan,
-				     hdev->le_scan_int_discovery,
-				     HCI_CMD_TIMEOUT, status);
-		}
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
@@ -2528,42 +2364,6 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
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
@@ -2588,118 +2388,8 @@ static void discov_off(struct work_struct *work)
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
@@ -2712,7 +2402,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
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

