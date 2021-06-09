Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB6C48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DE8613EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFIWYj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:24:39 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33285 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhFIWYi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 18:24:38 -0400
Received: by mail-pj1-f41.google.com with SMTP id k22-20020a17090aef16b0290163512accedso4387687pjz.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sCbN30JsvEKAeJEJikYktBDosTChFLhq0Dy9usjK81c=;
        b=NzkJcvZb/4f0pT+IMz6YT+u/nHUYb+aSiXeK1RUUGmHOPcZ6muiIVPrdkVIIZMpJ/F
         2VJDUpm8xCtEAhxRe2jrhvs/nrTxRBMc/s0UDoZ1WxfNIAlHZ8ZdSw5w/oxTKIAyA4XN
         jltn5/efeBE1hn4nwloEsCi09sWY8mHrt/wktoirYLKr8wLeGGm+sfc4NWGR4fHpcJfp
         HRS6GZX3UmJsULOetdLZ3e4/fSYSpC/LdDGw1eBu7tHQSa35nvZZPa+KjB2SoOl2pDyX
         SrIyuJDWLAb5nHDY8S0hbCfBucbHCN6tBonOhSWI+jtp8QH3YoJ17Sn13bP9xjNWR0mu
         7lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCbN30JsvEKAeJEJikYktBDosTChFLhq0Dy9usjK81c=;
        b=XVgAi9HB+CTF9aLLJ5Mu6DLew0I3AHOzDp4WBEnig2LR4fU3MmjjPOl8A9m+KDPfX1
         eHe5vIGgo/DiB7CCB6BFyU0E9BRVxXpO+nHhzVJFLeHAiUnJskfVyakPzjOkxD9RqbPA
         cfjOIcwmGYLxa4JQ2XQYOutr5GtrTCZmGluQKaUXN3Q/8qNoD2rmMVTIBoeM71nG1Hcj
         19s5A9F5WQ+X2QWL0uQU+bGvpT4EapMhPO0uyxAadXSrutHD8Qd5/2BQ2R+WsmX9CrQV
         cb79hQ8agOocAE39c1MuGCX339Rjzh+TlD6cI+9E2I1CzwQDYvNmQR2gKmAwJynOceiz
         LuRg==
X-Gm-Message-State: AOAM532INMkmWAUmZ16dXqKqaNKjO7EGUFd+iCwFw+mM323tFbWijQ0l
        +vo3iPYOvkg3lMCoL77uDbV/1VMUfc4=
X-Google-Smtp-Source: ABdhPJyn9dLXc7hVk/RhEC6bWlghzc1E40kbfPQ1G0yZhz9WUsA8ZhTW62tak21T1xuNCFKuVchq2A==
X-Received: by 2002:a17:90a:7a84:: with SMTP id q4mr12619323pjf.21.1623277290655;
        Wed, 09 Jun 2021 15:21:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i16sm546233pji.30.2021.06.09.15.21.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:21:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] Bluetooth: hci_sync: Enable advertising when LL privacy is enabled
Date:   Wed,  9 Jun 2021 15:21:24 -0700
Message-Id: <20210609222124.298336-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609222124.298336-1-luiz.dentz@gmail.com>
References: <20210609222124.298336-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables advertising when LL privacy is enabled and changes the
command sequence when resolving list is updated to also account for when
advertising is enabled using the following sequence:

Disable Scanning -> (Disable Advertising) -> Disable Resolving List ->
Update Resolving List -> Enable Resolving List -> Enable Scanning ->
(Enable Advertising)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   5 +-
 net/bluetooth/hci_event.c        |  11 +---
 net/bluetooth/hci_request.c      |  26 +++-----
 net/bluetooth/hci_sync.c         | 106 +++++++++++++++++++------------
 net/bluetooth/mgmt.c             |  40 ++----------
 5 files changed, 85 insertions(+), 103 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9fb90facf3c0..733ee07841af 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1437,8 +1437,11 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
+#define ll_privacy_capable(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+
 /* Use LL Privacy based address resolution if supported */
-#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+#define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
+			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c2c047783a84..513fa3778673 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2340,8 +2340,7 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	 * address types 0x02 and 0x03 are used. These types need to be
 	 * converted back into either public address or random address type
 	 */
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
 		switch (own_address_type) {
 		case ADDR_LE_DEV_PUBLIC_RESOLVED:
 			own_address_type = ADDR_LE_DEV_PUBLIC;
@@ -5201,9 +5200,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 * address types 0x02 and 0x03 are used. These types need to be
 	 * converted back into either public address or random address type
 	 */
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
 		switch (conn->dst_type) {
 		case ADDR_LE_DEV_PUBLIC_RESOLVED:
 			conn->dst_type = ADDR_LE_DEV_PUBLIC;
@@ -5310,9 +5307,7 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
 
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		hci_req_disable_address_resolution(hdev);
 }
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7edd9ab1b611..62fdec90b7db 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -511,9 +511,7 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 	}
 
 	/* Disable address resolution */
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
@@ -532,8 +530,7 @@ static void del_from_accept_list(struct hci_request *req, bdaddr_t *bdaddr,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_DEL_FROM_ACCEPT_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(req->hdev) &&
-	    hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
+	if (use_ll_privacy(req->hdev)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
@@ -586,8 +583,7 @@ static int add_to_accept_list(struct hci_request *req,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_ADD_TO_ACCEPT_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
+	if (use_ll_privacy(hdev)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(hdev, &params->addr,
@@ -626,8 +622,7 @@ static u8 update_accept_list(struct hci_request *req)
 	 */
 	bool allow_rpa = hdev->suspended;
 
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+	if (use_ll_privacy(hdev))
 		allow_rpa = true;
 
 	/* Go through the current accept list programmed into the
@@ -716,9 +711,7 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    addr_resolv) {
+	if (use_ll_privacy(hdev) && addr_resolv) {
 		u8 enable = 0x01;
 
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
@@ -1477,8 +1470,7 @@ void hci_req_disable_address_resolution(struct hci_dev *hdev)
 	struct hci_request req;
 	__u8 enable = 0x00;
 
-	if (!use_ll_privacy(hdev) &&
-	    !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+	if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		return;
 
 	hci_req_init(&req, hdev);
@@ -1623,8 +1615,7 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev) &&
-		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		if (use_ll_privacy(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
@@ -2098,8 +2089,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev) &&
-		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		if (use_ll_privacy(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 336165e3b1a5..c1c65cba13fc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -272,8 +272,7 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev) &&
-		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+		if (use_ll_privacy(hdev))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
@@ -633,11 +632,9 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 	if (!is_advertising_allowed(hdev, connectable))
 		return -EINVAL;
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
-		status = hci_disable_advertising_sync(hdev);
-		if (status)
-			return status;
-	}
+	status = hci_disable_advertising_sync(hdev);
+	if (status)
+		return status;
 
 	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
@@ -926,6 +923,10 @@ int hci_disable_advertising_sync(struct hci_dev *hdev)
 {
 	u8 enable = 0x00;
 
+	/* If controller is not advertising we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return 0;
+
 	if (ext_adv_capable(hdev))
 		return hci_disable_ext_adv_instance_sync(hdev, 0x00);
 
@@ -964,15 +965,18 @@ static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
 static int hci_le_set_addr_resolution_enable_sync(struct hci_dev *hdev, u8 val)
 {
-	if (!use_ll_privacy(hdev) ||
-	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+	if (!use_ll_privacy(hdev))
+		return 0;
+
+	/* If controller is not/already resolving we are done. */
+	if (val == hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE,
 				     sizeof(val), &val, HCI_CMD_TIMEOUT);
 }
 
-int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
+int hci_scan_disable_sync(struct hci_dev *hdev)
 {
 	int err;
 
@@ -994,13 +998,6 @@ int hci_scan_disable_sync(struct hci_dev *hdev, bool rpa_le_conn)
 		return err;
 	}
 
-	if (rpa_le_conn) {
-		err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
-		if (err)
-			bt_dev_err(hdev, "Unable to disable LL privacy: %d",
-				   err);
-	}
-
 	return err;
 }
 
@@ -1068,8 +1065,7 @@ static int hci_le_del_resolve_list_sync(struct hci_dev *hdev,
 	struct hci_cp_le_del_from_resolv_list cp;
 	struct smp_irk *irk;
 
-	if (!use_ll_privacy(hdev) ||
-	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+	if (!use_ll_privacy(hdev))
 		return 0;
 
 	irk = hci_find_irk_by_addr(hdev, bdaddr, bdaddr_type);
@@ -1111,9 +1107,9 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 {
 	struct hci_cp_le_add_to_resolv_list cp;
 	struct smp_irk *irk;
+	int err;
 
-	if (!use_ll_privacy(hdev) ||
-	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+	if (!use_ll_privacy(hdev))
 		return 0;
 
 	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
@@ -1129,8 +1125,16 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	else
 		memset(cp.local_irk, 0, 16);
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* When a controller cannot add a device to the list because there is
+	 * no space available, it shall return the error code Memory Capacity
+	 * Exceeded (0x07).
+	 */
+	if (err == HCI_ERROR_MEMORY_EXCEEDED)
+		return 0;
+
+	return err;
 }
 
 /* Adds connection to allow list if needed.*/
@@ -1192,8 +1196,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 */
 	bool allow_rpa = hdev->suspended;
 
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
+	if (use_ll_privacy(hdev))
 		allow_rpa = true;
 
 	/* Go through the current accept list programmed into the
@@ -1382,22 +1385,25 @@ static int hci_start_scan_sync(struct hci_dev *hdev, u8 type, u16 interval,
 					   LE_SCAN_FILTER_DUP_ENABLE);
 }
 
-/* Ensure to call hci_scan_disable_sync first to disable the controller based
- * address resolution to be able to reconfigure resolving list.
- */
 int hci_passive_scan_sync(struct hci_dev *hdev)
 {
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
-	/* Background scanning should run with address resolution */
-	bool addr_resolv = true;
+	bool restart_adv = false;
+	int err;
 
 	if (hdev->scanning_paused) {
 		bt_dev_dbg(hdev, "Scanning is paused for suspend");
 		return 0;
 	}
 
+	err = hci_scan_disable_sync(hdev);
+	if (err) {
+		bt_dev_err(hdev, "disable scanning failed: %d", err);
+		return err;
+	}
+
 	/* Set require_privacy to false since no SCAN_REQ are send
 	 * during passive scanning. Not using an non-resolvable address
 	 * here is important so that peer devices using direct
@@ -1413,6 +1419,25 @@ int hci_passive_scan_sync(struct hci_dev *hdev)
 		return 0;
 
 	bt_dev_dbg(hdev, "interleave state %d", hdev->interleave_scan_state);
+
+	/* Stop advertising if resolving list can be used as controllers are
+	 * cannot accept resolving list modifications while advertising.
+	 */
+	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		err = hci_disable_advertising_sync(hdev);
+		if (err) {
+			bt_dev_err(hdev, "disable advertising failed: %d", err);
+			return err;
+		}
+		restart_adv = true;
+	}
+
+	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
+	if (err) {
+		bt_dev_err(hdev, "Unable to disable LL privacy: %d", err);
+		return err;
+	}
+
 	/* Adding or removing entries from the accept list must
 	 * happen before enabling scanning. The controller does
 	 * not allow accept list modification while scanning.
@@ -1450,8 +1475,16 @@ int hci_passive_scan_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
 
-	return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
-				   own_addr_type, filter_policy, addr_resolv);
+	/* Start scanning, it will also program allowlist and resolvinglist so
+	 * it needs to be done before restarting advertising.
+	 */
+	err = hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
+				  own_addr_type, filter_policy, true);
+	if (err || !restart_adv)
+		return err;
+
+	/* Restart advertising if it was stopped */
+	return hci_enable_advertising_sync(hdev);
 }
 
 /* This function controls the background scanning based on hdev->pend_le_conns
@@ -1500,7 +1533,7 @@ int hci_update_background_scan_sync(struct hci_dev *hdev)
 
 		bt_dev_dbg(hdev, "stopping background scanning");
 
-		err = hci_scan_disable_sync(hdev, false);
+		err = hci_scan_disable_sync(hdev);
 		if (err)
 			bt_dev_err(hdev, "stop background scanning failed: %d",
 				   err);
@@ -1516,13 +1549,6 @@ int hci_update_background_scan_sync(struct hci_dev *hdev)
 		if (hci_lookup_le_connect(hdev))
 			return 0;
 
-		err = hci_scan_disable_sync(hdev, false);
-		if (err) {
-			bt_dev_err(hdev, "stop background scanning failed: %d",
-				   err);
-			return err;
-		}
-
 		bt_dev_dbg(hdev, "start background scanning");
 
 		err = hci_passive_scan_sync(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9b89c0e7f6da..6bd2255b46b2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -840,12 +840,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 		settings |= MGMT_SETTING_STATIC_ADDRESS;
-
-		/* When the experimental feature for LL Privacy support is
-		 * enabled, then advertising is no longer supported.
-		 */
-		if (!hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-			settings |= MGMT_SETTING_ADVERTISING;
+		settings |= MGMT_SETTING_ADVERTISING;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -3835,7 +3830,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
-	if (hdev && use_ll_privacy(hdev)) {
+	if (hdev && ll_privacy_capable(hdev)) {
 		if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
 			flags = BIT(0) | BIT(1);
 		else
@@ -3911,7 +3906,8 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 		}
 #endif
 
-		if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {
+		if (hdev && ll_privacy_capable(hdev) &&
+		    !hdev_is_powered(hdev)) {
 			bool changed = hci_dev_test_flag(hdev,
 							 HCI_ENABLE_LL_PRIVACY);
 
@@ -5394,13 +5390,6 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				       status);
 
-	/* Enabling the experimental LL Privay support disables support for
-	 * advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				       MGMT_STATUS_NOT_SUPPORTED);
-
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
@@ -7491,13 +7480,6 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_ADV_FEATURES,
 				       MGMT_STATUS_REJECTED);
 
-	/* Enabling the experimental LL Privay support disables support for
-	 * advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_ADV_FEATURES,
-				       MGMT_STATUS_NOT_SUPPORTED);
-
 	hci_dev_lock(hdev);
 
 	rp_len = sizeof(*rp) + hdev->adv_instance_cnt;
@@ -7737,13 +7719,6 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       status);
 
-	/* Enabling the experimental LL Privay support disables support for
-	 * advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				       MGMT_STATUS_NOT_SUPPORTED);
-
 	if (cp->instance < 1 || cp->instance > hdev->le_num_of_adv_sets)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
@@ -8248,13 +8223,6 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	/* Enabling the experimental LL Privay support disables support for
-	 * advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				       MGMT_STATUS_NOT_SUPPORTED);
-
 	hci_dev_lock(hdev);
 
 	if (cp->instance && !hci_find_adv_instance(hdev, cp->instance)) {
-- 
2.31.1

