Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB96C19F2C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiG3Au7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbiG3Auz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5F73906
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142253; x=1690678253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNtoW9ZXsXGaJksTurDE47Kfh6sJFqHywSG5yzCq46g=;
  b=PE5/MWT3kuxVy9Yko9P0OM07gv/wjD54zU/E8P/JJzx+l+Ao5hOq/PGY
   Fjg2LQY+SNwbraueK6NWxkOUJjKnDPYcusiccN2+MAC3eps43IDkvDFW9
   XXXEAGXv4trPdajYl6d05+jGdg9eGC9ftMXuIGMN40rCirbgS6boS8oJn
   50HwXLydFAZExbnS3sRGE6d/N/FzYiK0j8TgD6v+BFUbn10gZqyCH1/Bv
   yYsZjx42Q52TKztRsamR5dra3fDqF9jqdPmPdlEzxc/CIm2g5Tuno+/Ut
   97nFmAnQi+fePBmmz9Iw2aztW7x27HsfBPDxyh8DuQxStQSSBoS9+a49y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644796"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644796"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458127"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 07/10] Bluetooth: Delete unreference hci_request code
Date:   Fri, 29 Jul 2022 17:50:35 -0700
Message-Id: <20220730005038.894650-8-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch deletes a whole bunch of code no longer reached because the
functionality was recoded using hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_request.c | 902 +-----------------------------------
 net/bluetooth/hci_request.h |  29 --
 2 files changed, 2 insertions(+), 929 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9b9013c93f5b..458f21d4e0b2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -273,336 +273,6 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
 
-void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_page_scan_activity acp;
-	u8 type;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		return;
-
-	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return;
-
-	if (enable) {
-		type = PAGE_SCAN_TYPE_INTERLACED;
-
-		/* 160 msec page scan interval */
-		acp.interval = cpu_to_le16(0x0100);
-	} else {
-		type = hdev->def_page_scan_type;
-		acp.interval = cpu_to_le16(hdev->def_page_scan_int);
-	}
-
-	acp.window = cpu_to_le16(hdev->def_page_scan_window);
-
-	if (__cpu_to_le16(hdev->page_scan_interval) != acp.interval ||
-	    __cpu_to_le16(hdev->page_scan_window) != acp.window)
-		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
-			    sizeof(acp), &acp);
-
-	if (hdev->page_scan_type != type)
-		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
-}
-
-void __hci_req_update_name(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_local_name cp;
-
-	memcpy(cp.name, hdev->dev_name, sizeof(cp.name));
-
-	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
-}
-
-void __hci_req_update_eir(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_eir cp;
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (!lmp_ext_inq_capable(hdev))
-		return;
-
-	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	eir_create(hdev, cp.data);
-
-	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
-		return;
-
-	memcpy(hdev->eir, cp.data, sizeof(cp.data));
-
-	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-}
-
-void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	if (hdev->scanning_paused) {
-		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-		return;
-	}
-
-	if (use_ext_scan(hdev)) {
-		struct hci_cp_le_set_ext_scan_enable cp;
-
-		memset(&cp, 0, sizeof(cp));
-		cp.enable = LE_SCAN_DISABLE;
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE, sizeof(cp),
-			    &cp);
-	} else {
-		struct hci_cp_le_set_scan_enable cp;
-
-		memset(&cp, 0, sizeof(cp));
-		cp.enable = LE_SCAN_DISABLE;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
-
-	/* Disable address resolution */
-	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
-		__u8 enable = 0x00;
-
-		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
-	}
-}
-
-/* Returns true if an le connection is in the scanning state */
-static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == LE_LINK && c->state == BT_CONNECT &&
-		    test_bit(HCI_CONN_SCANNING, &c->flags)) {
-			rcu_read_unlock();
-			return true;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return false;
-}
-
-static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
-{
-	return hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance);
-}
-
-void __hci_req_disable_advertising(struct hci_request *req)
-{
-	if (ext_adv_capable(req->hdev)) {
-		__hci_req_disable_ext_adv_instance(req, 0x00);
-	} else {
-		u8 enable = 0x00;
-
-		hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-	}
-}
-
-static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
-{
-	/* If privacy is not enabled don't use RPA */
-	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
-		return false;
-
-	/* If basic privacy mode is enabled use RPA */
-	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
-		return true;
-
-	/* If limited privacy mode is enabled don't use RPA if we're
-	 * both discoverable and bondable.
-	 */
-	if ((flags & MGMT_ADV_FLAG_DISCOV) &&
-	    hci_dev_test_flag(hdev, HCI_BONDABLE))
-		return false;
-
-	/* We're neither bondable nor discoverable in the limited
-	 * privacy mode, therefore use RPA.
-	 */
-	return true;
-}
-
-static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
-{
-	/* If there is no connection we are OK to advertise. */
-	if (hci_conn_num(hdev, LE_LINK) == 0)
-		return true;
-
-	/* Check le_states if there is any connection in peripheral role. */
-	if (hdev->conn_hash.le_num_peripheral > 0) {
-		/* Peripheral connection state and non connectable mode bit 20.
-		 */
-		if (!connectable && !(hdev->le_states[2] & 0x10))
-			return false;
-
-		/* Peripheral connection state and connectable mode bit 38
-		 * and scannable bit 21.
-		 */
-		if (connectable && (!(hdev->le_states[4] & 0x40) ||
-				    !(hdev->le_states[2] & 0x20)))
-			return false;
-	}
-
-	/* Check le_states if there is any connection in central role. */
-	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_peripheral) {
-		/* Central connection state and non connectable mode bit 18. */
-		if (!connectable && !(hdev->le_states[2] & 0x02))
-			return false;
-
-		/* Central connection state and connectable mode bit 35 and
-		 * scannable 19.
-		 */
-		if (connectable && (!(hdev->le_states[4] & 0x08) ||
-				    !(hdev->le_states[2] & 0x08)))
-			return false;
-	}
-
-	return true;
-}
-
-void __hci_req_enable_advertising(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv;
-	struct hci_cp_le_set_adv_param cp;
-	u8 own_addr_type, enable = 0x01;
-	bool connectable;
-	u16 adv_min_interval, adv_max_interval;
-	u32 flags;
-
-	flags = hci_adv_instance_flags(hdev, hdev->cur_adv_instance);
-	adv = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
-
-	/* If the "connectable" instance flag was not set, then choose between
-	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
-	 */
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
-		      mgmt_get_connectable(hdev);
-
-	if (!is_advertising_allowed(hdev, connectable))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		__hci_req_disable_advertising(req);
-
-	/* Clear the HCI_LE_ADV bit temporarily so that the
-	 * hci_update_random_address knows that it's safe to go ahead
-	 * and write a new random address. The flag will be set back on
-	 * as soon as the SET_ADV_ENABLE HCI command completes.
-	 */
-	hci_dev_clear_flag(hdev, HCI_LE_ADV);
-
-	/* Set require_privacy to true only when non-connectable
-	 * advertising is used. In that case it is fine to use a
-	 * non-resolvable private address.
-	 */
-	if (hci_update_random_address(req, !connectable,
-				      adv_use_rpa(hdev, flags),
-				      &own_addr_type) < 0)
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	if (adv) {
-		adv_min_interval = adv->min_interval;
-		adv_max_interval = adv->max_interval;
-	} else {
-		adv_min_interval = hdev->le_adv_min_interval;
-		adv_max_interval = hdev->le_adv_max_interval;
-	}
-
-	if (connectable) {
-		cp.type = LE_ADV_IND;
-	} else {
-		if (adv_cur_instance_is_scannable(hdev))
-			cp.type = LE_ADV_SCAN_IND;
-		else
-			cp.type = LE_ADV_NONCONN_IND;
-
-		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
-		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
-			adv_min_interval = DISCOV_LE_FAST_ADV_INT_MIN;
-			adv_max_interval = DISCOV_LE_FAST_ADV_INT_MAX;
-		}
-	}
-
-	cp.min_interval = cpu_to_le16(adv_min_interval);
-	cp.max_interval = cpu_to_le16(adv_max_interval);
-	cp.own_address_type = own_addr_type;
-	cp.channel_map = hdev->le_adv_channel_map;
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-
-	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-}
-
-void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 len;
-
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	if (ext_adv_capable(hdev)) {
-		struct {
-			struct hci_cp_le_set_ext_scan_rsp_data cp;
-			u8 data[HCI_MAX_EXT_AD_LENGTH];
-		} pdu;
-
-		memset(&pdu, 0, sizeof(pdu));
-
-		len = eir_create_scan_rsp(hdev, instance, pdu.data);
-
-		if (hdev->scan_rsp_data_len == len &&
-		    !memcmp(pdu.data, hdev->scan_rsp_data, len))
-			return;
-
-		memcpy(hdev->scan_rsp_data, pdu.data, len);
-		hdev->scan_rsp_data_len = len;
-
-		pdu.cp.handle = instance;
-		pdu.cp.length = len;
-		pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-		pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
-			    sizeof(pdu.cp) + len, &pdu.cp);
-	} else {
-		struct hci_cp_le_set_scan_rsp_data cp;
-
-		memset(&cp, 0, sizeof(cp));
-
-		len = eir_create_scan_rsp(hdev, instance, cp.data);
-
-		if (hdev->scan_rsp_data_len == len &&
-		    !memcmp(cp.data, hdev->scan_rsp_data, len))
-			return;
-
-		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
-		hdev->scan_rsp_data_len = len;
-
-		cp.length = len;
-
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
-	}
-}
-
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -667,58 +337,6 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_req_run(&req, NULL);
 }
 
-static void enable_addr_resolution_complete(struct hci_dev *hdev, u8 status,
-					    u16 opcode)
-{
-	BT_DBG("%s status %u", hdev->name, status);
-}
-
-void hci_req_disable_address_resolution(struct hci_dev *hdev)
-{
-	struct hci_request req;
-	__u8 enable = 0x00;
-
-	if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
-		return;
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add(&req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
-
-	hci_req_run(&req, enable_addr_resolution_complete);
-}
-
-static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
-{
-	bt_dev_dbg(hdev, "status %u", status);
-}
-
-void hci_req_reenable_advertising(struct hci_dev *hdev)
-{
-	struct hci_request req;
-
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
-	    list_empty(&hdev->adv_instances))
-		return;
-
-	hci_req_init(&req, hdev);
-
-	if (hdev->cur_adv_instance) {
-		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
-						true);
-	} else {
-		if (ext_adv_capable(hdev)) {
-			__hci_req_start_ext_adv(&req, 0x00);
-		} else {
-			__hci_req_update_adv_data(&req, 0x00);
-			__hci_req_update_scan_rsp_data(&req, 0x00);
-			__hci_req_enable_advertising(&req);
-		}
-	}
-
-	hci_req_run(&req, adv_enable_complete);
-}
-
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr)
@@ -792,524 +410,8 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 	return 0;
 }
 
-void __hci_req_clear_ext_adv_sets(struct hci_request *req)
-{
-	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
-}
-
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
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev)) {
-		bt_dev_dbg(hdev, "Deferring random address update");
-		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
-		return;
-	}
-
-	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
-}
-
-int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
-{
-	struct hci_cp_le_set_ext_adv_params cp;
-	struct hci_dev *hdev = req->hdev;
-	bool connectable;
-	u32 flags;
-	bdaddr_t random_addr;
-	u8 own_addr_type;
-	int err;
-	struct adv_info *adv;
-	bool secondary_adv, require_privacy;
-
-	if (instance > 0) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv)
-			return -EINVAL;
-	} else {
-		adv = NULL;
-	}
-
-	flags = hci_adv_instance_flags(hdev, instance);
-
-	/* If the "connectable" instance flag was not set, then choose between
-	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
-	 */
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
-		      mgmt_get_connectable(hdev);
-
-	if (!is_advertising_allowed(hdev, connectable))
-		return -EPERM;
-
-	/* Set require_privacy to true only when non-connectable
-	 * advertising is used. In that case it is fine to use a
-	 * non-resolvable private address.
-	 */
-	require_privacy = !connectable;
-
-	/* Don't require privacy for periodic adv? */
-	if (adv && adv->periodic)
-		require_privacy = false;
-
-	err = hci_get_random_address(hdev, require_privacy,
-				     adv_use_rpa(hdev, flags), adv,
-				     &own_addr_type, &random_addr);
-	if (err < 0)
-		return err;
-
-	memset(&cp, 0, sizeof(cp));
-
-	if (adv) {
-		hci_cpu_to_le24(adv->min_interval, cp.min_interval);
-		hci_cpu_to_le24(adv->max_interval, cp.max_interval);
-		cp.tx_power = adv->tx_power;
-	} else {
-		hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
-		hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
-		cp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
-	}
-
-	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
-
-	if (connectable) {
-		if (secondary_adv)
-			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
-		else
-			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	} else if (hci_adv_instance_is_scannable(hdev, instance) ||
-		   (flags & MGMT_ADV_PARAM_SCAN_RSP)) {
-		if (secondary_adv)
-			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
-		else
-			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
-	} else {
-		/* Secondary and periodic cannot use legacy PDUs */
-		if (secondary_adv || (adv && adv->periodic))
-			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_NON_CONN_IND);
-		else
-			cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
-	}
-
-	cp.own_addr_type = own_addr_type;
-	cp.channel_map = hdev->le_adv_channel_map;
-	cp.handle = instance;
-
-	if (flags & MGMT_ADV_FLAG_SEC_2M) {
-		cp.primary_phy = HCI_ADV_PHY_1M;
-		cp.secondary_phy = HCI_ADV_PHY_2M;
-	} else if (flags & MGMT_ADV_FLAG_SEC_CODED) {
-		cp.primary_phy = HCI_ADV_PHY_CODED;
-		cp.secondary_phy = HCI_ADV_PHY_CODED;
-	} else {
-		/* In all other cases use 1M */
-		cp.primary_phy = HCI_ADV_PHY_1M;
-		cp.secondary_phy = HCI_ADV_PHY_1M;
-	}
-
-	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
-
-	if ((own_addr_type == ADDR_LE_DEV_RANDOM ||
-	     own_addr_type == ADDR_LE_DEV_RANDOM_RESOLVED) &&
-	    bacmp(&random_addr, BDADDR_ANY)) {
-		struct hci_cp_le_set_adv_set_rand_addr cp;
-
-		/* Check if random address need to be updated */
-		if (adv) {
-			if (!bacmp(&random_addr, &adv->random_addr))
-				return 0;
-		} else {
-			if (!bacmp(&random_addr, &hdev->random_addr))
-				return 0;
-			/* Instance 0x00 doesn't have an adv_info, instead it
-			 * uses hdev->random_addr to track its address so
-			 * whenever it needs to be updated this also set the
-			 * random address since hdev->random_addr is shared with
-			 * scan state machine.
-			 */
-			set_random_addr(req, &random_addr);
-		}
-
-		memset(&cp, 0, sizeof(cp));
-
-		cp.handle = instance;
-		bacpy(&cp.bdaddr, &random_addr);
-
-		hci_req_add(req,
-			    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
-			    sizeof(cp), &cp);
-	}
-
-	return 0;
-}
-
-int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_ext_adv_enable *cp;
-	struct hci_cp_ext_adv_set *adv_set;
-	u8 data[sizeof(*cp) + sizeof(*adv_set) * 1];
-	struct adv_info *adv_instance;
-
-	if (instance > 0) {
-		adv_instance = hci_find_adv_instance(hdev, instance);
-		if (!adv_instance)
-			return -EINVAL;
-	} else {
-		adv_instance = NULL;
-	}
-
-	cp = (void *) data;
-	adv_set = (void *) cp->data;
-
-	memset(cp, 0, sizeof(*cp));
-
-	cp->enable = 0x01;
-	cp->num_of_sets = 0x01;
-
-	memset(adv_set, 0, sizeof(*adv_set));
-
-	adv_set->handle = instance;
-
-	/* Set duration per instance since controller is responsible for
-	 * scheduling it.
-	 */
-	if (adv_instance && adv_instance->duration) {
-		u16 duration = adv_instance->timeout * MSEC_PER_SEC;
-
-		/* Time = N * 10 ms */
-		adv_set->duration = cpu_to_le16(duration / 10);
-	}
-
-	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE,
-		    sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets,
-		    data);
-
-	return 0;
-}
-
-int __hci_req_disable_ext_adv_instance(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_ext_adv_enable *cp;
-	struct hci_cp_ext_adv_set *adv_set;
-	u8 data[sizeof(*cp) + sizeof(*adv_set) * 1];
-	u8 req_size;
-
-	/* If request specifies an instance that doesn't exist, fail */
-	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
-		return -EINVAL;
-
-	memset(data, 0, sizeof(data));
-
-	cp = (void *)data;
-	adv_set = (void *)cp->data;
-
-	/* Instance 0x00 indicates all advertising instances will be disabled */
-	cp->num_of_sets = !!instance;
-	cp->enable = 0x00;
-
-	adv_set->handle = instance;
-
-	req_size = sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets;
-	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, req_size, data);
-
-	return 0;
-}
-
-int __hci_req_remove_ext_adv_instance(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	/* If request specifies an instance that doesn't exist, fail */
-	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
-		return -EINVAL;
-
-	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(instance), &instance);
-
-	return 0;
-}
-
-int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv_instance = hci_find_adv_instance(hdev, instance);
-	int err;
-
-	/* If instance isn't pending, the chip knows about it, and it's safe to
-	 * disable
-	 */
-	if (adv_instance && !adv_instance->pending)
-		__hci_req_disable_ext_adv_instance(req, instance);
-
-	err = __hci_req_setup_ext_adv_instance(req, instance);
-	if (err < 0)
-		return err;
-
-	__hci_req_update_scan_rsp_data(req, instance);
-	__hci_req_enable_ext_advertising(req, instance);
-
-	return 0;
-}
-
-int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
-				    bool force)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv_instance = NULL;
-	u16 timeout;
-
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    list_empty(&hdev->adv_instances))
-		return -EPERM;
-
-	if (hdev->adv_instance_timeout)
-		return -EBUSY;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return -ENOENT;
-
-	/* A zero timeout means unlimited advertising. As long as there is
-	 * only one instance, duration should be ignored. We still set a timeout
-	 * in case further instances are being added later on.
-	 *
-	 * If the remaining lifetime of the instance is more than the duration
-	 * then the timeout corresponds to the duration, otherwise it will be
-	 * reduced to the remaining instance lifetime.
-	 */
-	if (adv_instance->timeout == 0 ||
-	    adv_instance->duration <= adv_instance->remaining_time)
-		timeout = adv_instance->duration;
-	else
-		timeout = adv_instance->remaining_time;
-
-	/* The remaining time is being reduced unless the instance is being
-	 * advertised without time limit.
-	 */
-	if (adv_instance->timeout)
-		adv_instance->remaining_time =
-				adv_instance->remaining_time - timeout;
-
-	/* Only use work for scheduling instances with legacy advertising */
-	if (!ext_adv_capable(hdev)) {
-		hdev->adv_instance_timeout = timeout;
-		queue_delayed_work(hdev->req_workqueue,
-			   &hdev->adv_instance_expire,
-			   msecs_to_jiffies(timeout * 1000));
-	}
-
-	/* If we're just re-scheduling the same instance again then do not
-	 * execute any HCI commands. This happens when a single instance is
-	 * being advertised.
-	 */
-	if (!force && hdev->cur_adv_instance == instance &&
-	    hci_dev_test_flag(hdev, HCI_LE_ADV))
-		return 0;
-
-	hdev->cur_adv_instance = instance;
-	if (ext_adv_capable(hdev)) {
-		__hci_req_start_ext_adv(req, instance);
-	} else {
-		__hci_req_update_adv_data(req, instance);
-		__hci_req_update_scan_rsp_data(req, instance);
-		__hci_req_enable_advertising(req);
-	}
-
-	return 0;
-}
-
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      bool use_rpa, u8 *own_addr_type)
-{
-	struct hci_dev *hdev = req->hdev;
-	int err;
-
-	/* If privacy is enabled use a resolvable private address. If
-	 * current RPA has expired or there is something else than
-	 * the current RPA in use, then generate a new one.
-	 */
-	if (use_rpa) {
-		/* If Controller supports LL Privacy use own address type is
-		 * 0x03
-		 */
-		if (use_ll_privacy(hdev))
-			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
-		else
-			*own_addr_type = ADDR_LE_DEV_RANDOM;
-
-		if (rpa_valid(hdev))
-			return 0;
-
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			bt_dev_err(hdev, "failed to generate new RPA");
-			return err;
-		}
-
-		set_random_addr(req, &hdev->rpa);
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
-	 *
-	 * In case BR/EDR has been disabled on a dual-mode controller
-	 * and a static address has been configured, then use that
-	 * address instead of the public BR/EDR address.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
-	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
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
-static bool disconnected_accept_list_entries(struct hci_dev *hdev)
-{
-	struct bdaddr_list *b;
-
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		struct hci_conn *conn;
-
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
-		if (!conn)
-			return true;
-
-		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
-			return true;
-	}
-
-	return false;
-}
-
-void __hci_req_update_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 scan;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		return;
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (mgmt_powering_down(hdev))
-		return;
-
-	if (hdev->scanning_paused)
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
-	    disconnected_accept_list_entries(hdev))
-		scan = SCAN_PAGE;
-	else
-		scan = SCAN_DISABLED;
-
-	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
-		scan |= SCAN_INQUIRY;
-
-	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE) &&
-	    test_bit(HCI_ISCAN, &hdev->flags) == !!(scan & SCAN_INQUIRY))
-		return;
-
-	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
-static u8 get_service_classes(struct hci_dev *hdev)
-{
-	struct bt_uuid *uuid;
-	u8 val = 0;
-
-	list_for_each_entry(uuid, &hdev->uuids, list)
-		val |= uuid->svc_hint;
-
-	return val;
-}
-
-void __hci_req_update_class(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 cod[3];
-
-	bt_dev_dbg(hdev, "");
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
-		return;
-
-	cod[0] = hdev->minor_class;
-	cod[1] = hdev->major_class;
-	cod[2] = get_service_classes(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
-		cod[1] |= 0x20;
-
-	if (memcmp(cod, hdev->dev_class, 3) == 0)
-		return;
-
-	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-}
-
-void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
-		      u8 reason)
+static void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
+			     u8 reason)
 {
 	switch (conn->state) {
 	case BT_CONNECTED:
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 30a28550d90c..8e42b892b679 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -68,40 +68,11 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
-void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
-void __hci_req_update_name(struct hci_request *req);
-void __hci_req_update_eir(struct hci_request *req);
-
-void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
-
-void hci_req_disable_address_resolution(struct hci_dev *hdev);
-void hci_req_reenable_advertising(struct hci_dev *hdev);
-void __hci_req_enable_advertising(struct hci_request *req);
-void __hci_req_disable_advertising(struct hci_request *req);
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
 int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
-void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
-int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
-				    bool force);
-int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
-int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
-int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
-int __hci_req_disable_ext_adv_instance(struct hci_request *req, u8 instance);
-int __hci_req_remove_ext_adv_instance(struct hci_request *req, u8 instance);
-void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr);
 
-void __hci_req_update_class(struct hci_request *req);
-
-/* Returns true if HCI commands were queued */
-void __hci_req_update_scan(struct hci_request *req);
-
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      bool use_rpa, u8 *own_addr_type);
-
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
-void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
-		      u8 reason);
-- 
2.37.1

