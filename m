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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51252C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECF361245
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhFVAnZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAnY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E3C061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so1193142pji.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BYctGwIA8m7dm0fPj9j+reKCPWsez0vsubk7MTn4/i8=;
        b=Wd/o7w0xJo+JsG09+Wt/q5pZo80U7Q8eWRm+zqrEt+fpScf5YgFqYRg902F4DtKhM5
         aSvCyMB/SIpp0ihAp3YpX0ZZZGqrarLLFumNMJAkDwGEqRBolDn50gWBaYVRarIk3u9S
         0Y3j22nRydfym3J8yXHINuEsIokwy8xyqN5xa7tk+/FA4gG0GgRRVQQ86Ogjkvpu5xqU
         FMs78fpLcoDFhAczpuR48/XhuWgFgdQwO0LRvM19K+j4uSG4iwnJdypnqz0WFySCPZEC
         PnmF8q5kuGnXnNUMFmGWhcRz0wOmTu9aCwoRIoHYxbimsBC2fQg50d4CV5tA6fiXYGfR
         d37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYctGwIA8m7dm0fPj9j+reKCPWsez0vsubk7MTn4/i8=;
        b=uZKljLza6+Rg9IKWPabC0hcA80onFKgGUYRkqF9XZSE+/5I01RvO6lBEX4w3EOeZ1I
         3xaBOObGpnBWBcc7ma2I8DLTj4bOc/gA9TfXaUth/wvaS20TWxQ6QQ6otI4eWpOlj2+O
         Cc79OfEK/8qE2/AKkHfxHcFZWmsyj0TEbN5jJWYd69M+ww9K7iufr6s3zKR8d7pP4C65
         Spt+rVLgraz1uNLNCqpK3AW6Cddo3EGsbuRtsQFzogRzJat3yTGItUtKhk3CLRnbAWp3
         ikC+QoSMD4FL0v9tS6JFi/YLPEmyon5HD2jljdesliL4eccXNJffX0/qUd3Vc9Cdzk8z
         HYXQ==
X-Gm-Message-State: AOAM530tjRTOT3YR8ahadMMMXFn++HFd8ZbZeuSWFsaIfqwnqD6Gr1Yw
        10hLmMS3Osl5rkCPAJgpLWOTgstYcvIWxg==
X-Google-Smtp-Source: ABdhPJwxWLwAKqXVgH7JEjdMmA+TojQkXd9x4MPNriQ9LTjrYD3RBzdA+KDxDe2y7W+n/ElOX8tUgA==
X-Received: by 2002:a17:90b:2405:: with SMTP id nr5mr777617pjb.184.1624322468462;
        Mon, 21 Jun 2021 17:41:08 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h22sm6491985pfc.21.2021.06.21.17.41.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:41:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/7] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2
Date:   Mon, 21 Jun 2021 17:41:01 -0700
Message-Id: <20210622004104.3179217-4-luiz.dentz@gmail.com>
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

Add Advertising
Remove Advertising
Add Extended Advertising Parameters
Add Extended Advertising Data

mgmt-tester -s "Add Advertising"

Test Summary
------------
Add Advertising - Failure: LE off                    Passed
Add Advertising - Invalid Params 1 (AD too long)     Passed
Add Advertising - Invalid Params 2 (Malformed len)   Passed
Add Advertising - Invalid Params 3 (Malformed len)   Passed
Add Advertising - Invalid Params 4 (Malformed len)   Passed
Add Advertising - Invalid Params 5 (AD too long)     Passed
Add Advertising - Invalid Params 6 (ScRsp too long)  Passed
Add Advertising - Invalid Params 7 (Malformed len)   Passed
Add Advertising - Invalid Params 8 (Malformed len)   Passed
Add Advertising - Invalid Params 9 (Malformed len)   Passed
Add Advertising - Invalid Params 10 (ScRsp too long) Passed
Add Advertising - Rejected (Timeout, !Powered)       Passed
Add Advertising - Success 1 (Powered, Add Adv Inst)  Passed
Add Advertising - Success 2 (!Powered, Add Adv Inst) Passed
Add Advertising - Success 3 (!Powered, Adv Enable)   Passed
Add Advertising - Success 4 (Set Adv on override)    Passed
Add Advertising - Success 5 (Set Adv off override)   Passed
Add Advertising - Success 6 (Scan Rsp Dta, Adv ok)   Passed
Add Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Passed
Add Advertising - Success 8 (Connectable Flag)       Passed
Add Advertising - Success 9 (General Discov Flag)    Passed
Add Advertising - Success 10 (Limited Discov Flag)   Passed
Add Advertising - Success 11 (Managed Flags)         Passed
Add Advertising - Success 12 (TX Power Flag)         Passed
Add Advertising - Success 13 (ADV_SCAN_IND)          Passed
Add Advertising - Success 14 (ADV_NONCONN_IND)       Passed
Add Advertising - Success 15 (ADV_IND)               Passed
Add Advertising - Success 16 (Connectable -> on)     Passed
Add Advertising - Success 17 (Connectable -> off)    Passed
Add Advertising - Success 18 (Power -> off, Remove)  Passed
Add Advertising - Success 19 (Power -> off, Keep)    Passed
Add Advertising - Success 20 (Add Adv override)      Passed
Add Advertising - Success 21 (Timeout expires)       Passed
Add Advertising - Success 22 (LE -> off, Remove)     Passed
Add Advertising - Success (Empty ScRsp)              Passed
Add Advertising - Success (ScRsp only)               Passed
Add Advertising - Invalid Params (ScRsp too long)    Passed
Add Advertising - Success (ScRsp appear)             Passed
Add Advertising - Invalid Params (ScRsp appear long) Passed
Add Advertising - Success (Appear is null)           Passed
Add Advertising - Success (Name is null)             Passed
Add Advertising - Success (Complete name)            Passed
Add Advertising - Success (Shortened name)           Passed
Add Advertising - Success (Short name)               Passed
Add Advertising - Success (Name + data)              Passed
Add Advertising - Invalid Params (Name + data)       Passed
Add Advertising - Success (Name+data+appear)         Passed
Total: 47, Passed: 47 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 2.17 seconds

mgmt-tester -s "Remove Advertising"

Test Summary
------------
Remove Advertising - Invalid Params 1                Passed
Remove Advertising - Success 1                       Passed
Remove Advertising - Success 2                       Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0585 seconds

mgmt-tester -s "Ext Adv MGMT Params"

Test Summary:
------------
Ext Adv MGMT Params - Unpowered                      Passed
Ext Adv MGMT Params - Invalid parameters             Passed
Ext Adv MGMT Params - Success                        Passed
Ext Adv MGMT Params - (5.0) Success                  Passed
Total: 4, Passed: 4 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0746 seconds

mgmt-tester -s "Ext Adv MGMT -"

Test Summary
------------
Ext Adv MGMT - Data set without Params               Passed
Ext Adv MGMT - AD Data (5.0) Invalid parameters      Passed
Ext Adv MGMT - AD Data (5.0) Success                 Passed
Ext Adv MGMT - AD Scan Response (5.0) Success        Passed
Total: 4, Passed: 4 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0805 seconds

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 763 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.h |  22 ++
 net/bluetooth/mgmt.c     | 400 ++++++++++----------
 3 files changed, 983 insertions(+), 202 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e2ddfdf7c515..052abb8ef6c2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,9 +7,11 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
 #include "hci_sync.h"
+#include "smp.h"
 #include "eir.h"
 
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
@@ -169,3 +171,764 @@ int hci_update_class_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_CLASS_OF_DEV,
 				     sizeof(cod), cod, HCI_CMD_TIMEOUT);
 }
+
+static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
+{
+	/* If there is no connection we are OK to advertise. */
+	if (hci_conn_num(hdev, LE_LINK) == 0)
+		return true;
+
+	/* Check le_states if there is any connection in peripheral role. */
+	if (hdev->conn_hash.le_num_peripheral > 0) {
+		/* Peripheral connection state and non connectable mode
+		 * bit 20.
+		 */
+		if (!connectable && !(hdev->le_states[2] & 0x10))
+			return false;
+
+		/* Peripheral connection state and connectable mode bit 38
+		 * and scannable bit 21.
+		 */
+		if (connectable && (!(hdev->le_states[4] & 0x40) ||
+				    !(hdev->le_states[2] & 0x20)))
+			return false;
+	}
+
+	/* Check le_states if there is any connection in central role. */
+	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_peripheral) {
+		/* Central connection state and non connectable mode bit 18. */
+		if (!connectable && !(hdev->le_states[2] & 0x02))
+			return false;
+
+		/* Central connection state and connectable mode bit 35 and
+		 * scannable 19.
+		 */
+		if (connectable && (!(hdev->le_states[4] & 0x08) ||
+				    !(hdev->le_states[2] & 0x08)))
+			return false;
+	}
+
+	return true;
+}
+
+static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
+{
+	/* If privacy is not enabled don't use RPA */
+	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
+		return false;
+
+	/* If basic privacy mode is enabled use RPA */
+	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
+		return true;
+
+	/* If limited privacy mode is enabled don't use RPA if we're
+	 * both discoverable and bondable.
+	 */
+	if ((flags & MGMT_ADV_FLAG_DISCOV) &&
+	    hci_dev_test_flag(hdev, HCI_BONDABLE))
+		return false;
+
+	/* We're neither bondable nor discoverable in the limited
+	 * privacy mode, therefore use RPA.
+	 */
+	return true;
+}
+
+static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
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
+		return 0;
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RANDOM_ADDR,
+				     6, rpa, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
+				   bool rpa, u8 *own_addr_type)
+{
+	int err;
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired or there is something else than
+	 * the current RPA in use, then generate a new one.
+	 */
+	if (rpa) {
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
+		err = hci_set_random_addr_sync(hdev, &hdev->rpa);
+		if (err)
+			return err;
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
+
+		return hci_set_random_addr_sync(hdev, &hdev->rpa);
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
+			return hci_set_random_addr_sync(hdev,
+							  &hdev->static_addr);
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
+
+int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_ext_adv_params cp;
+	bool connectable;
+	u32 flags;
+	bdaddr_t random_addr;
+	u8 own_addr_type;
+	int err;
+	struct adv_info *adv;
+	bool secondary_adv;
+
+	if (instance > 0) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv)
+			return -EINVAL;
+	} else {
+		adv = NULL;
+	}
+
+	/* Updating parameters of an active instance will return a
+	 * Command Disallowed error, so we must first disable the
+	 * instance if it is active.
+	 */
+	if (adv && !adv->pending) {
+		err = hci_disable_ext_adv_instance_sync(hdev, instance);
+		if (err)
+			return err;
+	}
+
+	flags = hci_adv_instance_flags(hdev, instance);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      mgmt_get_connectable(hdev);
+
+	if (!is_advertising_allowed(hdev, connectable))
+		return -EPERM;
+
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	err = hci_get_random_address(hdev, !connectable,
+				     adv_use_rpa(hdev, flags), adv,
+				     &own_addr_type, &random_addr);
+	if (err < 0)
+		return err;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (adv) {
+		hci_cpu_to_le24(adv->min_interval, cp.min_interval);
+		hci_cpu_to_le24(adv->max_interval, cp.max_interval);
+		cp.tx_power = adv->tx_power;
+	} else {
+		hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
+		hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
+		cp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
+	}
+
+	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
+
+	if (connectable) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
+	} else if (hci_adv_instance_is_scannable(hdev, instance) ||
+		   (flags & MGMT_ADV_PARAM_SCAN_RSP)) {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_SCAN_IND);
+	} else {
+		if (secondary_adv)
+			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_NON_CONN_IND);
+		else
+			cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
+	}
+
+	cp.own_addr_type = own_addr_type;
+	cp.channel_map = hdev->le_adv_channel_map;
+	cp.handle = instance;
+
+	if (flags & MGMT_ADV_FLAG_SEC_2M) {
+		cp.primary_phy = HCI_ADV_PHY_1M;
+		cp.secondary_phy = HCI_ADV_PHY_2M;
+	} else if (flags & MGMT_ADV_FLAG_SEC_CODED) {
+		cp.primary_phy = HCI_ADV_PHY_CODED;
+		cp.secondary_phy = HCI_ADV_PHY_CODED;
+	} else {
+		/* In all other cases use 1M */
+		cp.primary_phy = HCI_ADV_PHY_1M;
+		cp.secondary_phy = HCI_ADV_PHY_1M;
+	}
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+	    bacmp(&random_addr, BDADDR_ANY)) {
+		/* Check if random address need to be updated */
+		if (adv) {
+			if (!bacmp(&random_addr, &adv->random_addr))
+				return 0;
+		} else {
+			if (!bacmp(&random_addr, &hdev->random_addr))
+				return 0;
+		}
+
+		return hci_set_random_addr_sync(hdev, &random_addr);
+	}
+
+	return 0;
+}
+
+static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct {
+		struct hci_cp_le_set_ext_scan_rsp_data cp;
+		u8 data[HCI_MAX_EXT_AD_LENGTH];
+	} pdu;
+	u8 len;
+
+	memset(&pdu, 0, sizeof(pdu));
+
+	len = eir_create_scan_rsp(hdev, instance, pdu.data);
+
+	if (hdev->scan_rsp_data_len == len &&
+	    !memcmp(pdu.data, hdev->scan_rsp_data, len))
+		return 0;
+
+	memcpy(hdev->scan_rsp_data, pdu.data, len);
+	hdev->scan_rsp_data_len = len;
+
+	pdu.cp.handle = instance;
+	pdu.cp.length = len;
+	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
+				     sizeof(pdu.cp) + len, &pdu.cp,
+				     HCI_CMD_TIMEOUT);
+}
+
+static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_scan_rsp_data cp;
+	u8 len;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = eir_create_scan_rsp(hdev, instance, cp.data);
+
+	if (hdev->scan_rsp_data_len == len &&
+	    !memcmp(cp.data, hdev->scan_rsp_data, len))
+		return 0;
+
+	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+	hdev->scan_rsp_data_len = len;
+
+	cp.length = len;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_SCAN_RSP_DATA,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	if (ext_adv_capable(hdev))
+		return hci_set_ext_scan_rsp_data_sync(hdev, instance);
+
+	return __hci_set_scan_rsp_data_sync(hdev, instance);
+}
+
+int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *set;
+	u8 data[sizeof(*cp) + sizeof(*set) * 1];
+	struct adv_info *adv;
+
+	if (instance > 0) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv)
+			return -EINVAL;
+	} else {
+		adv = NULL;
+	}
+
+	cp = (void *)data;
+	set = (void *)cp->data;
+
+	memset(cp, 0, sizeof(*cp));
+
+	cp->enable = 0x01;
+	cp->num_of_sets = 0x01;
+
+	memset(set, 0, sizeof(*set));
+
+	set->handle = instance;
+
+	/* Set duration per instance since controller is responsible for
+	 * scheduling it.
+	 */
+	if (adv && adv->duration) {
+		u16 duration = adv->timeout * MSEC_PER_SEC;
+
+		/* Time = N * 10 ms */
+		set->duration = cpu_to_le16(duration / 10);
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+				     sizeof(*cp) +
+				     sizeof(*set) * cp->num_of_sets,
+				     data, HCI_CMD_TIMEOUT);
+}
+
+int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
+{
+	int err;
+
+	err = hci_setup_ext_adv_instance_sync(hdev, instance);
+	if (err)
+		return err;
+
+	err = hci_set_ext_scan_rsp_data_sync(hdev, instance);
+	if (err)
+		return err;
+
+	return hci_enable_ext_advertising_sync(hdev, instance);
+}
+
+static int hci_start_adv_sync(struct hci_dev *hdev, u8 instance)
+{
+	int err;
+
+	if (ext_adv_capable(hdev))
+		return hci_start_ext_adv_sync(hdev, instance);
+
+	err = hci_update_adv_data_sync(hdev, instance);
+	if (err)
+		return err;
+
+	err = hci_update_scan_rsp_data_sync(hdev, instance);
+	if (err)
+		return err;
+
+	return hci_enable_advertising_sync(hdev);
+}
+
+int hci_enable_advertising_sync(struct hci_dev *hdev)
+{
+	struct adv_info *adv_instance;
+	struct hci_cp_le_set_adv_param cp;
+	u8 own_addr_type, enable = 0x01;
+	bool connectable;
+	u16 adv_min_interval, adv_max_interval;
+	u32 flags;
+	u8 status;
+
+	flags = hci_adv_instance_flags(hdev, hdev->cur_adv_instance);
+	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      mgmt_get_connectable(hdev);
+
+	if (!is_advertising_allowed(hdev, connectable))
+		return -EINVAL;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		status = hci_disable_advertising_sync(hdev);
+		if (status)
+			return status;
+	}
+
+	/* Clear the HCI_LE_ADV bit temporarily so that the
+	 * hci_update_random_address knows that it's safe to go ahead
+	 * and write a new random address. The flag will be set back on
+	 * as soon as the SET_ADV_ENABLE HCI command completes.
+	 */
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
+	/* Set require_privacy to true only when non-connectable
+	 * advertising is used. In that case it is fine to use a
+	 * non-resolvable private address.
+	 */
+	status = hci_update_random_address_sync(hdev, !connectable,
+						adv_use_rpa(hdev, flags),
+						&own_addr_type);
+	if (status)
+		return status;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (adv_instance) {
+		adv_min_interval = adv_instance->min_interval;
+		adv_max_interval = adv_instance->max_interval;
+	} else {
+		adv_min_interval = hdev->le_adv_min_interval;
+		adv_max_interval = hdev->le_adv_max_interval;
+	}
+
+	if (connectable) {
+		cp.type = LE_ADV_IND;
+	} else {
+		if (hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance))
+			cp.type = LE_ADV_SCAN_IND;
+		else
+			cp.type = LE_ADV_NONCONN_IND;
+
+		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+			adv_min_interval = DISCOV_LE_FAST_ADV_INT_MIN;
+			adv_max_interval = DISCOV_LE_FAST_ADV_INT_MAX;
+		}
+	}
+
+	cp.min_interval = cpu_to_le16(adv_min_interval);
+	cp.max_interval = cpu_to_le16(adv_max_interval);
+	cp.own_address_type = own_addr_type;
+	cp.channel_map = hdev->le_adv_channel_map;
+
+	status = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
+				       sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (status)
+		return status;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+}
+
+int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+{
+	/* If request specifies an instance that doesn't exist, fail */
+	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
+		return -EINVAL;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_REMOVE_ADV_SET,
+				     sizeof(instance), &instance,
+				     HCI_CMD_TIMEOUT);
+}
+
+int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *set;
+	u8 data[sizeof(*cp) + sizeof(*set) * 1];
+	u8 size;
+
+	/* If request specifies an instance that doesn't exist, fail */
+	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
+		return -EINVAL;
+
+	memset(data, 0, sizeof(data));
+
+	cp = (void *)data;
+	set = (void *)cp->data;
+
+	/* Instance 0x00 indicates all advertising instances will be disabled */
+	cp->num_of_sets = !!instance;
+	cp->enable = 0x00;
+
+	set->handle = instance;
+
+	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+				     size, data, HCI_CMD_TIMEOUT);
+}
+
+static void cancel_adv_timeout(struct hci_dev *hdev)
+{
+	if (hdev->adv_instance_timeout) {
+		hdev->adv_instance_timeout = 0;
+		cancel_delayed_work(&hdev->adv_instance_expire);
+	}
+}
+
+static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct {
+		struct hci_cp_le_set_ext_adv_data cp;
+		u8 data[HCI_MAX_EXT_AD_LENGTH];
+	} pdu;
+	u8 len;
+
+	memset(&pdu, 0, sizeof(pdu));
+
+	len = eir_create_adv_data(hdev, instance, pdu.data);
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(pdu.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, pdu.data, len);
+	hdev->adv_data_len = len;
+
+	pdu.cp.length = len;
+	pdu.cp.handle = instance;
+	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				     sizeof(pdu.cp) + len, &pdu.cp,
+				     HCI_CMD_TIMEOUT);
+}
+
+static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = eir_create_adv_data(hdev, instance, cp.data);
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	if (ext_adv_capable(hdev))
+		return hci_set_ext_adv_data_sync(hdev, instance);
+
+	return hci_set_adv_data_sync(hdev, instance);
+}
+
+int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
+				   bool force)
+{
+	struct adv_info *adv = NULL;
+	u16 timeout;
+
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    list_empty(&hdev->adv_instances))
+		return -EPERM;
+
+	if (hdev->adv_instance_timeout)
+		return -EBUSY;
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv)
+		return -ENOENT;
+
+	/* A zero timeout means unlimited advertising. As long as there is
+	 * only one instance, duration should be ignored. We still set a timeout
+	 * in case further instances are being added later on.
+	 *
+	 * If the remaining lifetime of the instance is more than the duration
+	 * then the timeout corresponds to the duration, otherwise it will be
+	 * reduced to the remaining instance lifetime.
+	 */
+	if (adv->timeout == 0 || adv->duration <= adv->remaining_time)
+		timeout = adv->duration;
+	else
+		timeout = adv->remaining_time;
+
+	/* The remaining time is being reduced unless the instance is being
+	 * advertised without time limit.
+	 */
+	if (adv->timeout)
+		adv->remaining_time = adv->remaining_time - timeout;
+
+	/* Only use work for scheduling instances with legacy advertising */
+	if (!ext_adv_capable(hdev)) {
+		hdev->adv_instance_timeout = timeout;
+		queue_delayed_work(hdev->req_workqueue,
+				   &hdev->adv_instance_expire,
+				   msecs_to_jiffies(timeout * 1000));
+	}
+
+	/* If we're just re-scheduling the same instance again then do not
+	 * execute any HCI commands. This happens when a single instance is
+	 * being advertised.
+	 */
+	if (!force && hdev->cur_adv_instance == instance &&
+	    hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return 0;
+
+	hdev->cur_adv_instance = instance;
+
+	return hci_start_adv_sync(hdev, instance);
+}
+
+/* For a single instance:
+ * - force == true: The instance will be removed even when its remaining
+ *   lifetime is not zero.
+ * - force == false: the instance will be deactivated but kept stored unless
+ *   the remaining lifetime is zero.
+ *
+ * For instance == 0x00:
+ * - force == true: All instances will be removed regardless of their timeout
+ *   setting.
+ * - force == false: Only instances that have a timeout will be removed.
+ */
+void hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
+				 u8 instance, bool force)
+{
+	struct adv_info *adv, *n, *next = NULL;
+	int err;
+
+	/* Cancel any timeout concerning the removed instance(s). */
+	if (!instance || hdev->cur_adv_instance == instance)
+		cancel_adv_timeout(hdev);
+
+	/* Get the next instance to advertise BEFORE we remove
+	 * the current one. This can be the same instance again
+	 * if there is only one instance.
+	 */
+	if (instance && hdev->cur_adv_instance == instance)
+		next = hci_get_next_instance(hdev, instance);
+
+	if (instance == 0x00) {
+		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
+			if (!(force || adv->timeout))
+				continue;
+
+			instance = adv->instance;
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				mgmt_advertising_removed(sk, hdev, instance);
+		}
+	} else {
+		adv = hci_find_adv_instance(hdev, instance);
+
+		if (force || (adv && adv->timeout && !adv->remaining_time)) {
+			/* Don't advertise a removed instance. */
+			if (next && next->instance == instance)
+				next = NULL;
+
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				mgmt_advertising_removed(sk, hdev, instance);
+		}
+	}
+
+	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return;
+
+	if (next && !ext_adv_capable(hdev))
+		hci_schedule_adv_instance_sync(hdev, next->instance, false);
+}
+
+int hci_disable_advertising_sync(struct hci_dev *hdev)
+{
+	u8 enable = 0x00;
+
+	if (ext_adv_capable(hdev))
+		return hci_disable_ext_adv_instance_sync(hdev, 0x00);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+}
diff --git a/net/bluetooth/hci_sync.h b/net/bluetooth/hci_sync.h
index e3437150031c..5e4392a93607 100644
--- a/net/bluetooth/hci_sync.h
+++ b/net/bluetooth/hci_sync.h
@@ -7,3 +7,25 @@
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
+
+int hci_update_eir_sync(struct hci_dev *hdev);
+int hci_update_class_sync(struct hci_dev *hdev);
+
+int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
+				   bool rpa, u8 *own_addr_type);
+
+int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance);
+int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance);
+int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
+				   bool force);
+
+int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
+int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
+int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
+int hci_enable_advertising_sync(struct hci_dev *hdev);
+
+int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
+int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
+void hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
+				 u8 instance, bool force);
+int hci_disable_advertising_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d3e3cd073ed3..c9c90e3d2647 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1000,11 +1000,22 @@ static void service_cache_off(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, service_cache_sync, NULL, NULL);
 }
 
+static int rpa_expired_sync(struct hci_dev *hdev, void *data)
+{
+	/* The generation of a new RPA and programming it into the
+	 * controller happens in the hci_req_enable_advertising()
+	 * function.
+	 */
+	if (ext_adv_capable(hdev))
+		return hci_start_ext_adv_sync(hdev, hdev->cur_adv_instance);
+	else
+		return hci_enable_advertising_sync(hdev);
+}
+
 static void rpa_expired(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    rpa_expired.work);
-	struct hci_request req;
 
 	bt_dev_dbg(hdev, "");
 
@@ -1013,16 +1024,7 @@ static void rpa_expired(struct work_struct *work)
 	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
-	/* The generation of a new RPA and programming it into the
-	 * controller happens in the hci_req_enable_advertising()
-	 * function.
-	 */
-	hci_req_init(&req, hdev);
-	if (ext_adv_capable(hdev))
-		__hci_req_start_ext_adv(&req, hdev->cur_adv_instance);
-	else
-		__hci_req_enable_advertising(&req);
-	hci_req_run(&req, NULL);
+	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
@@ -7641,58 +7643,66 @@ static bool adv_busy(struct hci_dev *hdev)
 		pending_find(MGMT_OP_ADD_EXT_ADV_DATA, hdev));
 }
 
-static void add_advertising_complete(struct hci_dev *hdev, u8 status,
-				     u16 opcode)
+static void add_adv_complete(struct hci_dev *hdev, struct sock *sk, u8 instance,
+			     int err)
 {
-	struct mgmt_pending_cmd *cmd;
-	struct mgmt_cp_add_advertising *cp;
-	struct mgmt_rp_add_advertising rp;
-	struct adv_info *adv_instance, *n;
-	u8 instance;
+	struct adv_info *adv, *n;
 
-	bt_dev_dbg(hdev, "status %u", status);
+	bt_dev_dbg(hdev, "err %d", err);
 
 	hci_dev_lock(hdev);
 
-	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
-	if (!cmd)
-		cmd = pending_find(MGMT_OP_ADD_EXT_ADV_DATA, hdev);
+	list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
+		u8 instance;
 
-	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
-		if (!adv_instance->pending)
+		if (!adv->pending)
 			continue;
 
-		if (!status) {
-			adv_instance->pending = false;
+		if (!err) {
+			adv->pending = false;
 			continue;
 		}
 
-		instance = adv_instance->instance;
+		instance = adv->instance;
 
 		if (hdev->cur_adv_instance == instance)
 			cancel_adv_timeout(hdev);
 
 		hci_remove_adv_instance(hdev, instance);
-		mgmt_advertising_removed(cmd ? cmd->sk : NULL, hdev, instance);
+		mgmt_advertising_removed(sk, hdev, instance);
 	}
 
-	if (!cmd)
-		goto unlock;
+	hci_dev_unlock(hdev);
+}
+
+static void add_advertising_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_advertising *cp = cmd->param;
+	struct mgmt_rp_add_advertising rp;
+
+	memset(&rp, 0, sizeof(rp));
 
-	cp = cmd->param;
 	rp.instance = cp->instance;
 
-	if (status)
+	if (err)
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
-				mgmt_status(status));
+				mgmt_status(err));
 	else
 		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
-				  mgmt_status(status), &rp, sizeof(rp));
+				  mgmt_status(err), &rp, sizeof(rp));
 
-	mgmt_pending_remove(cmd);
+	add_adv_complete(hdev, cmd->sk, cp->instance, err);
 
-unlock:
-	hci_dev_unlock(hdev);
+	mgmt_pending_free(cmd);
+}
+
+static int add_advertising_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_advertising *cp = cmd->param;
+
+	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
 }
 
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
@@ -7708,7 +7718,6 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	struct adv_info *next_instance;
 	int err;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -7816,25 +7825,19 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	/* We're good to go, update advertising data, parameters, and start
 	 * advertising.
 	 */
-	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_ADVERTISING, hdev, data,
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_ADVERTISING, hdev, data,
 			       data_len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
-
-	err = __hci_req_schedule_adv_instance(&req, schedule_instance, true);
+	cp->instance = schedule_instance;
 
-	if (!err)
-		err = hci_req_run(&req, add_advertising_complete);
-
-	if (err < 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
-				      MGMT_STATUS_FAILED);
-		mgmt_pending_remove(cmd);
-	}
+	err = hci_cmd_sync_queue(hdev, add_advertising_sync, cmd,
+				 add_advertising_complete);
+	if (err < 0)
+		mgmt_pending_free(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -7842,30 +7845,25 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void add_ext_adv_params_complete(struct hci_dev *hdev, u8 status,
-					u16 opcode)
+static void add_ext_adv_params_complete(struct hci_dev *hdev, void *data,
+					int err)
 {
-	struct mgmt_pending_cmd *cmd;
-	struct mgmt_cp_add_ext_adv_params *cp;
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_ext_adv_params *cp = cmd->param;
 	struct mgmt_rp_add_ext_adv_params rp;
-	struct adv_info *adv_instance;
+	struct adv_info *adv;
 	u32 flags;
 
 	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
 
-	cmd = pending_find(MGMT_OP_ADD_EXT_ADV_PARAMS, hdev);
-	if (!cmd)
-		goto unlock;
-
-	cp = cmd->param;
-	adv_instance = hci_find_adv_instance(hdev, cp->instance);
-	if (!adv_instance)
+	adv = hci_find_adv_instance(hdev, cp->instance);
+	if (!adv)
 		goto unlock;
 
 	rp.instance = cp->instance;
-	rp.tx_power = adv_instance->tx_power;
+	rp.tx_power = adv->tx_power;
 
 	/* While we're at it, inform userspace of the available space for this
 	 * advertisement, given the flags that will be used.
@@ -7874,39 +7872,44 @@ static void add_ext_adv_params_complete(struct hci_dev *hdev, u8 status,
 	rp.max_adv_data_len = tlv_data_max_len(hdev, flags, true);
 	rp.max_scan_rsp_len = tlv_data_max_len(hdev, flags, false);
 
-	if (status) {
+	if (err) {
 		/* If this advertisement was previously advertising and we
 		 * failed to update it, we signal that it has been removed and
 		 * delete its structure
 		 */
-		if (!adv_instance->pending)
+		if (!adv->pending)
 			mgmt_advertising_removed(cmd->sk, hdev, cp->instance);
 
 		hci_remove_adv_instance(hdev, cp->instance);
 
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
-				mgmt_status(status));
-
+				mgmt_status(err));
 	} else {
 		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
-				  mgmt_status(status), &rp, sizeof(rp));
+				  mgmt_status(err), &rp, sizeof(rp));
 	}
 
 unlock:
 	if (cmd)
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 }
 
+static int add_ext_adv_params_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_ext_adv_params *cp = cmd->param;
+
+	return hci_setup_ext_adv_instance_sync(hdev, cp->instance);
+}
+
 static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 data_len)
 {
 	struct mgmt_cp_add_ext_adv_params *cp = data;
 	struct mgmt_rp_add_ext_adv_params rp;
 	struct mgmt_pending_cmd *cmd = NULL;
-	struct adv_info *adv_instance;
-	struct hci_request req;
 	u32 flags, min_interval, max_interval;
 	u16 timeout, duration;
 	u8 status;
@@ -7988,29 +7991,18 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 
 	/* Submit request for advertising params if ext adv available */
 	if (ext_adv_capable(hdev)) {
-		hci_req_init(&req, hdev);
-		adv_instance = hci_find_adv_instance(hdev, cp->instance);
-
-		/* Updating parameters of an active instance will return a
-		 * Command Disallowed error, so we must first disable the
-		 * instance if it is active.
-		 */
-		if (!adv_instance->pending)
-			__hci_req_disable_ext_adv_instance(&req, cp->instance);
-
-		__hci_req_setup_ext_adv_instance(&req, cp->instance);
-
-		err = hci_req_run(&req, add_ext_adv_params_complete);
-
-		if (!err)
-			cmd = mgmt_pending_add(sk, MGMT_OP_ADD_EXT_ADV_PARAMS,
-					       hdev, data, data_len);
+		cmd = mgmt_pending_new(sk, MGMT_OP_ADD_EXT_ADV_PARAMS, hdev,
+				       data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
 			hci_remove_adv_instance(hdev, cp->instance);
 			goto unlock;
 		}
 
+		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
+					 add_ext_adv_params_complete);
+		if (err < 0)
+			mgmt_pending_free(cmd);
 	} else {
 		rp.instance = cp->instance;
 		rp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
@@ -8027,6 +8019,49 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static void add_ext_adv_data_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_ext_adv_data *cp = cmd->param;
+	struct mgmt_rp_add_advertising rp;
+
+	add_adv_complete(hdev, cmd->sk, cp->instance, err);
+
+	memset(&rp, 0, sizeof(rp));
+
+	rp.instance = cp->instance;
+
+	if (err)
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+				mgmt_status(err));
+	else
+		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+				  mgmt_status(err), &rp, sizeof(rp));
+
+	mgmt_pending_free(cmd);
+}
+
+static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_ext_adv_data *cp = cmd->param;
+	int err;
+
+	if (ext_adv_capable(hdev)) {
+		err = hci_update_adv_data_sync(hdev, cp->instance);
+		if (err)
+			return err;
+
+		err = hci_update_scan_rsp_data_sync(hdev, cp->instance);
+		if (err)
+			return err;
+
+		return hci_enable_ext_advertising_sync(hdev, cp->instance);
+	}
+
+	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
+}
+
 static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 data_len)
 {
@@ -8037,7 +8072,6 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 
 	BT_DBG("%s", hdev->name);
 
@@ -8079,78 +8113,52 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 				  cp->data, cp->scan_rsp_len,
 				  cp->data + cp->adv_data_len);
 
-	/* We're good to go, update advertising data, parameters, and start
-	 * advertising.
-	 */
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add(&req, HCI_OP_READ_LOCAL_NAME, 0, NULL);
-
-	if (ext_adv_capable(hdev)) {
-		__hci_req_update_adv_data(&req, cp->instance);
-		__hci_req_update_scan_rsp_data(&req, cp->instance);
-		__hci_req_enable_ext_advertising(&req, cp->instance);
-
-	} else {
-		/* If using software rotation, determine next instance to use */
-
-		if (hdev->cur_adv_instance == cp->instance) {
-			/* If the currently advertised instance is being changed
-			 * then cancel the current advertising and schedule the
-			 * next instance. If there is only one instance then the
-			 * overridden advertising data will be visible right
-			 * away
-			 */
-			cancel_adv_timeout(hdev);
-
-			next_instance = hci_get_next_instance(hdev,
-							      cp->instance);
-			if (next_instance)
-				schedule_instance = next_instance->instance;
-		} else if (!hdev->adv_instance_timeout) {
-			/* Immediately advertise the new instance if no other
-			 * instance is currently being advertised.
-			 */
-			schedule_instance = cp->instance;
-		}
+	/* If using software rotation, determine next instance to use */
+	if (hdev->cur_adv_instance == cp->instance) {
+		/* If the currently advertised instance is being changed
+		 * then cancel the current advertising and schedule the
+		 * next instance. If there is only one instance then the
+		 * overridden advertising data will be visible right
+		 * away
+		 */
+		cancel_adv_timeout(hdev);
 
-		/* If the HCI_ADVERTISING flag is set or there is no instance to
-		 * be advertised then we have no HCI communication to make.
-		 * Simply return.
+		next_instance = hci_get_next_instance(hdev, cp->instance);
+		if (next_instance)
+			schedule_instance = next_instance->instance;
+	} else if (!hdev->adv_instance_timeout) {
+		/* Immediately advertise the new instance if no other
+		 * instance is currently being advertised.
 		 */
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		    !schedule_instance) {
-			if (adv_instance->pending) {
-				mgmt_advertising_added(sk, hdev, cp->instance);
-				adv_instance->pending = false;
-			}
-			rp.instance = cp->instance;
-			err = mgmt_cmd_complete(sk, hdev->id,
-						MGMT_OP_ADD_EXT_ADV_DATA,
-						MGMT_STATUS_SUCCESS, &rp,
-						sizeof(rp));
-			goto unlock;
-		}
+		schedule_instance = cp->instance;
+	}
 
-		err = __hci_req_schedule_adv_instance(&req, schedule_instance,
-						      true);
+	/* If the HCI_ADVERTISING flag is set or there is no instance to
+	 * be advertised then we have no HCI communication to make.
+	 * Simply return.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) || !schedule_instance) {
+		if (adv_instance->pending) {
+			mgmt_advertising_added(sk, hdev, cp->instance);
+			adv_instance->pending = false;
+		}
+		rp.instance = cp->instance;
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_EXT_ADV_DATA, hdev, data,
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_EXT_ADV_DATA, hdev, data,
 			       data_len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto clear_new_instance;
 	}
 
-	if (!err)
-		err = hci_req_run(&req, add_advertising_complete);
-
+	err = hci_cmd_sync_queue(hdev, add_ext_adv_data_sync, cmd,
+				 add_ext_adv_data_complete);
 	if (err < 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
-				      MGMT_STATUS_FAILED);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 		goto clear_new_instance;
 	}
 
@@ -8173,43 +8181,58 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static void remove_advertising_complete(struct hci_dev *hdev, u8 status,
-					u16 opcode)
+static void remove_advertising_complete(struct hci_dev *hdev, void *data,
+					int err)
 {
-	struct mgmt_pending_cmd *cmd;
-	struct mgmt_cp_remove_advertising *cp;
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_remove_advertising *cp = cmd->param;
 	struct mgmt_rp_remove_advertising rp;
 
-	bt_dev_dbg(hdev, "status %u", status);
+	bt_dev_dbg(hdev, "err %d", err);
 
-	hci_dev_lock(hdev);
+	memset(&rp, 0, sizeof(rp));
+	rp.instance = cp->instance;
 
-	/* A failure status here only means that we failed to disable
-	 * advertising. Otherwise, the advertising instance has been removed,
-	 * so report success.
-	 */
-	cmd = pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev);
-	if (!cmd)
-		goto unlock;
+	if (err)
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+				mgmt_status(err));
+	else
+		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+				  MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 
-	cp = cmd->param;
-	rp.instance = cp->instance;
+	mgmt_pending_free(cmd);
+}
 
-	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, MGMT_STATUS_SUCCESS,
-			  &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+static int remove_advertising_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_remove_advertising *cp = cmd->param;
+	int err;
 
-unlock:
-	hci_dev_unlock(hdev);
+	/* If we use extended advertising, instance is disabled and removed */
+	if (ext_adv_capable(hdev)) {
+		err = hci_disable_ext_adv_instance_sync(hdev, cp->instance);
+		if (err)
+			return err;
+
+		err = hci_remove_ext_adv_instance_sync(hdev, cp->instance);
+		if (err)
+			return err;
+	}
+
+	hci_clear_adv_instance_sync(hdev, cmd->sk, cp->instance, true);
+
+	if (list_empty(&hdev->adv_instances))
+		err = hci_disable_advertising_sync(hdev);
+
+	return err;
 }
 
 static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 data_len)
 {
 	struct mgmt_cp_remove_advertising *cp = data;
-	struct mgmt_rp_remove_advertising rp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -8244,44 +8267,17 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
-
-	/* If we use extended advertising, instance is disabled and removed */
-	if (ext_adv_capable(hdev)) {
-		__hci_req_disable_ext_adv_instance(&req, cp->instance);
-		__hci_req_remove_ext_adv_instance(&req, cp->instance);
-	}
-
-	hci_req_clear_adv_instance(hdev, sk, &req, cp->instance, true);
-
-	if (list_empty(&hdev->adv_instances))
-		__hci_req_disable_advertising(&req);
-
-	/* If no HCI commands have been collected so far or the HCI_ADVERTISING
-	 * flag is set or the device isn't powered then we have no HCI
-	 * communication to make. Simply return.
-	 */
-	if (skb_queue_empty(&req.cmd_q) ||
-	    !hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		hci_req_purge(&req);
-		rp.instance = cp->instance;
-		err = mgmt_cmd_complete(sk, hdev->id,
-					MGMT_OP_REMOVE_ADVERTISING,
-					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-		goto unlock;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_ADVERTISING, hdev, data,
+	cmd = mgmt_pending_new(sk, MGMT_OP_REMOVE_ADVERTISING, hdev, data,
 			       data_len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
-	err = hci_req_run(&req, remove_advertising_complete);
+	err = hci_cmd_sync_queue(hdev, remove_advertising_sync, cmd,
+				 remove_advertising_complete);
 	if (err < 0)
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.31.1

