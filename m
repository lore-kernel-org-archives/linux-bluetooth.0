Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CAC4743C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB546124B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFVAn0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAnZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDBC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so688978pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tHtANJBGHN+ELgoHgp5d8Qfi/WTRYU1jrzq2qGlUOF4=;
        b=E0pkubQmAC4bU0qG3QHqxQOWJUhxrAB/DCv8WsZV5qNr7WBFH+iL3gP23Cp5lf/LIs
         vQbBRMs5wVN+yDQ84fwk3kKDtxkH6jweup02AFA24/T+J7Iwqg50IEdAnpqIrejJoTce
         2T6N3auOIKv3JaJIAGc1hc20EaH7JZ48oA483t6BMeJMGyEMsTs/AGnVSMh/v5s7CGOt
         X9UNHYZ1hBBL9hz4mRbsoNpiirqUNAcRC5uq/x6z4Jz5paxIfbojmGHUi7a2tqCeeMwG
         LKD8MwKMndH0VIR8emyqgQxHUGZsmbAIL0uIUKKJ7BGP5Aq826WknbBc1Xn3E3Pu63lU
         Hd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHtANJBGHN+ELgoHgp5d8Qfi/WTRYU1jrzq2qGlUOF4=;
        b=MbmAKru3fq3ZYb5vW4JCcUT1FwME3J/f0CcOHxyXG2c4yrnkgQZX+w1dgzwodNef0z
         Kllv/hOVaL6Vt2JHy3WWKEQ7/yJyL936tWRjJ69LNqX2UlffYXvl03hEOJBhD/BrrsVf
         5KixNAwQFsD0qv/hZHY85tzrbgZG37CWRZevJorS5421P90fJD4jD7LT4Uon1wNPE9Hr
         K+cR7Q3bptxqJZUyCoJoeNBgWxdAKTfFzhx3vaf8nnNKy9aYXEguSgJe+U38/dnQygg4
         8aocnBAR5buKkSRp0ryyjhXaBkNmJ4hncpieW/VbDLH/kHffiAnSLlFGq0OsBq1Os9Bu
         liMQ==
X-Gm-Message-State: AOAM531nbINxoGOs7ImQhtNGB8GkCNyctLbx1PcmWfn5fcNC94u7BdwC
        9AwNTyGtOphkkN7lqANa6zU1oUAe0KOzig==
X-Google-Smtp-Source: ABdhPJyTThJOsU3Dv/g2XMjwQMN2V9KdRIVRn0ny+M73zc+5Uc5vw/jwIzzO0RoTvfSkmwlHvsgq2A==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr832512pjo.108.1624322469236;
        Mon, 21 Jun 2021 17:41:09 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h22sm6491985pfc.21.2021.06.21.17.41.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:41:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/7] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3
Date:   Mon, 21 Jun 2021 17:41:02 -0700
Message-Id: <20210622004104.3179217-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622004104.3179217-1-luiz.dentz@gmail.com>
References: <20210622004104.3179217-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of hci_cmd_sync_queue for the following MGMT commands:

    Add Device
    Remove Device

Tested with:

mgmt-tester -s "Add Device"

Test Summary
------------
Add Device - Invalid Params 1                        Passed
Add Device - Invalid Params 2                        Passed
Add Device - Invalid Params 3                        Passed
Add Device - Invalid Params 4                        Passed
Add Device - Success 1                               Passed
Add Device - Success 2                               Passed
Add Device - Success 3                               Passed
Add Device - Success 4                               Passed
Add Device - Success 5                               Passed
Add Device - Success 6 - Add to whitelist            Passed
Add Device - Success 7 - Add to resolv list          Passed
Add Device - Success 8 - Enable resolv list          Passed
Total: 12, Passed: 12 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.209 seconds

mgmt-tester -s "Remove Device"

Test Summary
------------
Remove Device - Invalid Params 1                     Passed
Remove Device - Invalid Params 2                     Passed
Remove Device - Invalid Params 3                     Passed
Remove Device - Success 1                            Passed
Remove Device - Success 2                            Passed
Remove Device - Success 3                            Passed
Remove Device - Success 4                            Passed
Remove Device - Success 5                            Passed
Remove Device - Success 6 - All Devices              Passed
Remove Device - Success 7 - Remove from whitelist    Passed
Remove Device - Success 8 - Remove from resolv list  Passed
Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 4.26 seconds

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 601 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/mgmt.c     |  19 +-
 3 files changed, 618 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 052abb8ef6c2..d173dd47dd1b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -932,3 +932,604 @@ int hci_disable_advertising_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
 }
+
+static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
+					   u8 filter_dup)
+{
+	struct hci_cp_le_set_ext_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = val;
+	cp.filter_dup = filter_dup;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
+				       u8 filter_dup)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	if (use_ext_scan(hdev))
+		return hci_le_set_ext_scan_enable_sync(hdev, val, filter_dup);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = val;
+	cp.filter_dup = filter_dup;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_set_addr_resolution_enable_sync(struct hci_dev *hdev, u8 val)
+{
+	if (!use_ll_privacy(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE,
+				     sizeof(val), &val, HCI_CMD_TIMEOUT);
+}
+
+int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
+{
+	int err;
+
+	/* If controller is not scanning we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		return 0;
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return 0;
+	}
+
+	if (hdev->suspended)
+		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+
+	err = hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
+	if (err) {
+		bt_dev_err(hdev, "Unable to disable scanning: %d", err);
+		return err;
+	}
+
+	if (rpa_le_conn) {
+		err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
+		if (err)
+			bt_dev_err(hdev, "Unable to disable LL privacy: %d",
+				   err);
+	}
+
+	return err;
+}
+
+static bool scan_use_rpa(struct hci_dev *hdev)
+{
+	return hci_dev_test_flag(hdev, HCI_PRIVACY);
+}
+
+static void hci_start_interleave_scan(struct hci_dev *hdev)
+{
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
+static bool hci_update_interleaved_scan_sync(struct hci_dev *hdev)
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
+	if (use_interleaving && !is_interleaving) {
+		hci_start_interleave_scan(hdev);
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
+/* Removes connection to resolve list if needed.*/
+static int hci_le_del_resolve_list_sync(struct hci_dev *hdev,
+					bdaddr_t *bdaddr, u8 bdaddr_type)
+{
+	struct hci_cp_le_del_from_resolv_list cp;
+	struct smp_irk *irk;
+
+	if (!use_ll_privacy(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return 0;
+
+	irk = hci_find_irk_by_addr(hdev, bdaddr, bdaddr_type);
+	if (!irk)
+		return 0;
+
+	cp.bdaddr_type = bdaddr_type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_del_accept_list_sync(struct hci_dev *hdev,
+				       bdaddr_t *bdaddr, u8 bdaddr_type)
+{
+	struct hci_cp_le_del_from_accept_list cp;
+	int err;
+
+	cp.bdaddr_type = bdaddr_type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_DEL_FROM_ACCEPT_LIST,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err) {
+		bt_dev_err(hdev, "Unable to remove from allow list: %d", err);
+		return err;
+	}
+
+	bt_dev_dbg(hdev, "Remove %pMR (0x%x) from allow list", &cp.bdaddr,
+		   cp.bdaddr_type);
+
+	return hci_le_del_resolve_list_sync(hdev, &cp.bdaddr, cp.bdaddr_type);
+}
+
+/* Adds connection to resolve list if needed.*/
+static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
+					struct hci_conn_params *params)
+{
+	struct hci_cp_le_add_to_resolv_list cp;
+	struct smp_irk *irk;
+
+	if (!use_ll_privacy(hdev) ||
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		return 0;
+
+	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
+	if (!irk)
+		return 0;
+
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+	memcpy(cp.peer_irk, irk->val, 16);
+
+	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
+		memcpy(cp.local_irk, hdev->irk, 16);
+	else
+		memset(cp.local_irk, 0, 16);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+/* Adds connection to allow list if needed.*/
+static int hci_le_add_allow_list_sync(struct hci_dev *hdev,
+				      struct hci_conn_params *params,
+				      u8 *num_entries, bool allow_rpa)
+{
+	struct hci_cp_le_add_to_accept_list cp;
+	int err;
+
+	/* Already in accept list */
+	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
+				   params->addr_type))
+		return 0;
+
+	/* Select filter policy to accept all advertising */
+	if (*num_entries >= hdev->le_accept_list_size)
+		return -ENOSPC;
+
+	/* Accept list can not be used with RPAs */
+	if (!allow_rpa &&
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
+		return -EINVAL;
+	}
+
+	/* During suspend, only wakeable devices can be in acceptlist */
+	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
+						   params->current_flags))
+		return 0;
+
+	*num_entries += 1;
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err) {
+		bt_dev_err(hdev, "Unable to add to allow list: %d", err);
+		return err;
+	}
+
+	bt_dev_dbg(hdev, "Add %pMR (0x%x) to allow list", &cp.bdaddr,
+		   cp.bdaddr_type);
+
+	return hci_le_add_resolve_list_sync(hdev, params);
+}
+
+static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
+{
+	struct hci_conn_params *params;
+	struct bdaddr_list *b, *t;
+	u8 num_entries = 0;
+	bool pend_conn, pend_report;
+	/* We allow acceptlisting even with RPAs in suspend. In the worst case,
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
+	/* Go through the current accept list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then remove it from
+	 * the controller.
+	 */
+	list_for_each_entry_safe(b, t, &hdev->le_accept_list, list) {
+		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
+						      &b->bdaddr,
+						      b->bdaddr_type);
+		pend_report = hci_pend_le_action_lookup(&hdev->pend_le_reports,
+							&b->bdaddr,
+							b->bdaddr_type);
+
+		/* If the device is not likely to connect or report,
+		 * remove it from the acceptlist.
+		 */
+		if (!pend_conn && !pend_report) {
+			hci_le_del_accept_list_sync(hdev, &b->bdaddr,
+						    b->bdaddr_type);
+			continue;
+		}
+
+		/* Accept list can not be used with RPAs */
+		if (!allow_rpa &&
+		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
+		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
+			return 0x00;
+		}
+
+		num_entries++;
+	}
+
+	/* Since all no longer valid accept list entries have been
+	 * removed, walk through the list of pending connections
+	 * and ensure that any new device gets programmed into
+	 * the controller.
+	 *
+	 * If the list of the devices is larger than the list of
+	 * available accept list entries in the controller, then
+	 * just abort and return filer policy value to not use the
+	 * accept list.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+		if (hci_le_add_allow_list_sync(hdev, params, &num_entries,
+					       allow_rpa))
+			return 0x00;
+	}
+
+	/* After adding all new pending connections, walk through
+	 * the list of pending reports and also add these to the
+	 * accept list if there is still space. Abort if space runs out.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+		if (hci_le_add_allow_list_sync(hdev, params, &num_entries,
+					       allow_rpa))
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
+	/* Select filter policy to use accept list */
+	return 0x01;
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
+static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
+					  u16 interval, u16 window,
+					  u8 own_addr_type, u8 filter_policy)
+{
+	struct hci_cp_le_set_ext_scan_params *cp;
+	struct hci_cp_le_scan_phy_params *phy;
+	u8 data[sizeof(*cp) + sizeof(*phy) * 2];
+	u8 num_phy = 0;
+
+	cp = (void *)data;
+	phy = (void *)cp->data;
+
+	memset(data, 0, sizeof(data));
+
+	cp->own_addr_type = own_addr_type;
+	cp->filter_policy = filter_policy;
+
+	if (scan_1m(hdev) || scan_2m(hdev)) {
+		cp->scanning_phys |= LE_SCAN_PHY_1M;
+
+		phy->type = type;
+		phy->interval = cpu_to_le16(interval);
+		phy->window = cpu_to_le16(window);
+
+		num_phy++;
+		phy++;
+	}
+
+	if (scan_coded(hdev)) {
+		cp->scanning_phys |= LE_SCAN_PHY_CODED;
+
+		phy->type = type;
+		phy->interval = cpu_to_le16(interval);
+		phy->window = cpu_to_le16(window);
+
+		num_phy++;
+		phy++;
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
+				     sizeof(*cp) + sizeof(*phy) * num_phy,
+				     data, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_set_scan_param_sync(struct hci_dev *hdev, u8 type,
+				      u16 interval, u16 window,
+				      u8 own_addr_type, u8 filter_policy)
+{
+	struct hci_cp_le_set_scan_param cp;
+
+	if (use_ext_scan(hdev))
+		return hci_le_set_ext_scan_param_sync(hdev, type, interval,
+						      window, own_addr_type,
+						      filter_policy);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+	cp.interval = cpu_to_le16(interval);
+	cp.window = cpu_to_le16(window);
+	cp.own_address_type = own_addr_type;
+	cp.filter_policy = filter_policy;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_SCAN_PARAM,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
+{
+	int err;
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return 0;
+	}
+
+	if (addr_resolv) {
+		err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
+		if (err)
+			return err;
+	}
+
+	err = hci_le_set_scan_param_sync(hdev, type, interval, window,
+					 own_addr_type, filter_policy);
+	if (err)
+		return err;
+
+	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
+					   LE_SCAN_FILTER_DUP_ENABLE);
+}
+
+/* Ensure to call hci_scan_disable_sync first to disable the controller based
+ * address resolution to be able to reconfigure resolving list.
+ */
+int hci_passive_scan_sync(struct hci_dev *hdev)
+{
+	u8 own_addr_type;
+	u8 filter_policy;
+	u16 window, interval;
+	/* Background scanning should run with address resolution */
+	bool addr_resolv = true;
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return 0;
+	}
+
+	/* Set require_privacy to false since no SCAN_REQ are send
+	 * during passive scanning. Not using an non-resolvable address
+	 * here is important so that peer devices using direct
+	 * advertising with our address will be correctly reported
+	 * by the controller.
+	 */
+	if (hci_update_random_address_sync(hdev, false, scan_use_rpa(hdev),
+					   &own_addr_type))
+		return 0;
+
+	if (hdev->enable_advmon_interleave_scan &&
+	    hci_update_interleaved_scan_sync(hdev))
+		return 0;
+
+	bt_dev_dbg(hdev, "interleave state %d", hdev->interleave_scan_state);
+	/* Adding or removing entries from the accept list must
+	 * happen before enabling scanning. The controller does
+	 * not allow accept list modification while scanning.
+	 */
+	filter_policy = hci_update_accept_list_sync(hdev);
+
+	/* When the controller is using random resolvable addresses and
+	 * with that having LE privacy enabled, then controllers with
+	 * Extended Scanner Filter Policies support can now enable support
+	 * for handling directed advertising.
+	 *
+	 * So instead of using filter polices 0x00 (no acceptlist)
+	 * and 0x01 (acceptlist enabled) use the new filter policies
+	 * 0x02 (no acceptlist) and 0x03 (acceptlist enabled).
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
+	bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
+
+	return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
+				   own_addr_type, filter_policy, addr_resolv);
+}
+
+/* This function controls the background scanning based on hdev->pend_le_conns
+ * list. If there are pending LE connection we start the background scanning,
+ * otherwise we stop it.
+ */
+int hci_update_background_scan_sync(struct hci_dev *hdev)
+{
+	int err;
+
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
+	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
+	/* No point in doing scanning if LE support hasn't been enabled */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	/* If discovery is active don't interfere with it */
+	if (hdev->discovery.state != DISCOVERY_STOPPED)
+		return 0;
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
+	bt_dev_dbg(hdev, "ADV monitoring is %s",
+		   hci_is_adv_monitoring(hdev) ? "on" : "off");
+
+	if (list_empty(&hdev->pend_le_conns) &&
+	    list_empty(&hdev->pend_le_reports) &&
+	    !hci_is_adv_monitoring(hdev)) {
+		/* If there is no pending LE connections or devices
+		 * to be scanned for or no ADV monitors, we should stop the
+		 * background scanning.
+		 */
+
+		bt_dev_dbg(hdev, "stopping background scanning");
+
+		err = hci_scan_disable_sync(hdev, false);
+		if (err)
+			bt_dev_err(hdev, "stop background scanning failed: %d",
+				   err);
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
+			return 0;
+
+		err = hci_scan_disable_sync(hdev, false);
+		if (err) {
+			bt_dev_err(hdev, "stop background scanning failed: %d",
+				   err);
+			return err;
+		}
+
+		bt_dev_dbg(hdev, "start background scanning");
+
+		err = hci_passive_scan_sync(hdev);
+		if (err)
+			bt_dev_err(hdev, "start background scanning failed: %d",
+				   err);
+	}
+
+	return err;
+}
diff --git a/net/bluetooth/hci_sync.h b/net/bluetooth/hci_sync.h
index 5e4392a93607..5ef02b1cb8c1 100644
--- a/net/bluetooth/hci_sync.h
+++ b/net/bluetooth/hci_sync.h
@@ -29,3 +29,5 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
 void hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
 				 u8 instance, bool force);
 int hci_disable_advertising_sync(struct hci_dev *hdev);
+
+int hci_update_background_scan_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c9c90e3d2647..9b89c0e7f6da 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6700,6 +6700,11 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
+static int add_device_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_update_background_scan_sync(hdev);
+}
+
 static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
@@ -6782,7 +6787,9 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			current_flags = params->current_flags;
 	}
 
-	hci_update_background_scan(hdev);
+	err = hci_cmd_sync_queue(hdev, add_device_sync, NULL, NULL);
+	if (err < 0)
+		goto unlock;
 
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
@@ -6809,6 +6816,11 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
+static int remove_device_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_update_background_scan_sync(hdev);
+}
+
 static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			 void *data, u16 len)
 {
@@ -6888,7 +6900,6 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
-		hci_update_background_scan(hdev);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -6925,10 +6936,10 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		bt_dev_dbg(hdev, "All LE connection parameters were removed");
-
-		hci_update_background_scan(hdev);
 	}
 
+	hci_cmd_sync_queue(hdev, remove_device_sync, NULL, NULL);
+
 complete:
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
 				MGMT_STATUS_SUCCESS, &cp->addr,
-- 
2.31.1

