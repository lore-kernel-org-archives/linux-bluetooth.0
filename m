Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12703C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F4020936
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vL478tsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPUQv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgIPUQe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF9C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i199so8167138ybg.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ToSnX8V2D1upjBIlNrW3uCJ/HI8k/JL9fDv0qFjO2D8=;
        b=vL478tsYWA7BYu1aZHIUiFUWgq91HuXU6OODg57Tk1DU6ydUDA5yOGsIL9LbiP7Xr4
         xFytVQ4xxYX7vWxhaUm1pJaLRWb+2zCr3n7cUHPLdVKUPD7RlBKVnPNUbdV49+PJKOjy
         iye/rD2uBv2e6s+Yp3MM8HwaoiBdvJsx/OZawOsuDnWFMLjoObfgTWTX2k+PRCHSJ/9B
         OSKWJl0AKvVfsH+ffdJ1DmbWRG33VJS2oYrilrWSlvcgqfW516P6PDVYR6wWK6WNEu0u
         +PxLbVk38T6XTX7U/oqYolb1/H1D8/Euc6fKHvHtRjFcAo+rstDiI1MFT08KqlFZq29h
         4tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ToSnX8V2D1upjBIlNrW3uCJ/HI8k/JL9fDv0qFjO2D8=;
        b=rYZXmcqZQO0iTcs/YkUmXhAitbLqtMJoxjVXoiq3fAVCyJbKSvNxp+bOaekTgyiemX
         sAP7IuOrRWuDywvIAiLgsrUfvL1o+D/fNB+4DuYnP20iOljsu929HU+EOC13P7HW1IMH
         fhfO1smtf6iaHT0OYTqqX6E9w+BaE3yjQs5AwI3MIfiyq4RWhJU71yFftxRtK5h7PxJ3
         3a8J3xAYBvMLiUxlPIrpFBqcFLbpSxKnkvuXP0XuW6qbDsXlRbD3NghRZLT7tgfcb0mL
         mEK9eG+0dlV1SqoBX7fNxjYWpzza/TffvM5zNelf8CMjg0Ax/PLBfBZ8zGelLiavYLyJ
         3iEw==
X-Gm-Message-State: AOAM530qfnRrsgj3IBrR4/zeTTmWdis2ImO2VyPTqezqpzyQSanUUDkJ
        38daK7hFe7OAcaW5BW4+IPZ6agGsetPc0kpi8RFd7D1cIpEMOus7M3UV4NcdCetS7ak85IAlCGl
        6vXUvqs228IljaeUvr2m8hjV7G8eBnC+SzsigR5tF92VxIhEdBYrRApEppxdktxrFtTYkW/4KSW
        zYiEACzasyy6s190mT
X-Google-Smtp-Source: ABdhPJynIOAOT3cKcE9mOpi1dSkkWI0SRrZTVfjc8VgXXHGlnRPdBQ1yOcqAflqyWjz6Nx1NH+/JZna8iwQK8WOVQsyB
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6902:4d1:: with SMTP id
 v17mr35743659ybs.389.1600287375986; Wed, 16 Sep 2020 13:16:15 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:15:59 -0700
In-Reply-To: <20200916201602.1223002-1-danielwinkler@google.com>
Message-Id: <20200916131430.3.I74255537fa99ed3c0025321008b361c6ad90a431@changeid>
Mime-Version: 1.0
References: <20200916201602.1223002-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 3/6] Bluetooth: Use intervals and tx power from mgmt cmds
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch takes the min/max intervals and tx power optionally provided
in mgmt interface, stores them in the advertisement struct, and uses
them when configuring the hci requests. While tx power is not used if
extended advertising is unavailable, software rotation will use the min
and max advertising intervals specified by the client.

This change is validated manually by ensuring the min/max intervals are
propagated to the controller on both hatch (extended advertising) and
kukui (no extended advertising) chromebooks, and that tx power is
propagated correctly on hatch. These tests are performed with multiple
advertisements simultaneously.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 include/net/bluetooth/hci_core.h |  5 ++++-
 net/bluetooth/hci_core.c         |  8 +++++---
 net/bluetooth/hci_request.c      | 29 +++++++++++++++++++----------
 net/bluetooth/mgmt.c             |  8 ++++++--
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 48d144ae8b57d6..ab168f46b6d909 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -230,6 +230,8 @@ struct adv_info {
 	__u16	scan_rsp_len;
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__s8	tx_power;
+	__u32   min_interval;
+	__u32   max_interval;
 	bdaddr_t	random_addr;
 	bool 		rpa_expired;
 	struct delayed_work	rpa_expired_cb;
@@ -1292,7 +1294,8 @@ struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance);
 int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
-			 u16 timeout, u16 duration);
+			 u16 timeout, u16 duration, s8 tx_power,
+			 u32 min_interval, u32 max_interval);
 int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3f73f147826409..3a2332f4a9bba2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2951,7 +2951,8 @@ static void adv_instance_rpa_expired(struct work_struct *work)
 int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
-			 u16 timeout, u16 duration)
+			 u16 timeout, u16 duration, s8 tx_power,
+			 u32 min_interval, u32 max_interval)
 {
 	struct adv_info *adv_instance;
 
@@ -2979,6 +2980,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	adv_instance->flags = flags;
 	adv_instance->adv_data_len = adv_data_len;
 	adv_instance->scan_rsp_len = scan_rsp_len;
+	adv_instance->min_interval = min_interval;
+	adv_instance->max_interval = max_interval;
+	adv_instance->tx_power = tx_power;
 
 	if (adv_data_len)
 		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
@@ -2995,8 +2999,6 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	else
 		adv_instance->duration = duration;
 
-	adv_instance->tx_power = HCI_TX_POWER_INVALID;
-
 	INIT_DELAYED_WORK(&adv_instance->rpa_expired_cb,
 			  adv_instance_rpa_expired);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e17bc8a1c66ddd..30bf0d0e406d9a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1370,6 +1370,7 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 void __hci_req_enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
+	struct adv_info *adv_instance;
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
@@ -1377,6 +1378,7 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	u32 flags;
 
 	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
+	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
@@ -1408,11 +1410,16 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (connectable) {
-		cp.type = LE_ADV_IND;
-
+	if (adv_instance) {
+		adv_min_interval = adv_instance->min_interval;
+		adv_max_interval = adv_instance->max_interval;
+	} else {
 		adv_min_interval = hdev->le_adv_min_interval;
 		adv_max_interval = hdev->le_adv_max_interval;
+	}
+
+	if (connectable) {
+		cp.type = LE_ADV_IND;
 	} else {
 		if (get_cur_adv_instance_scan_rsp_len(hdev))
 			cp.type = LE_ADV_SCAN_IND;
@@ -1423,9 +1430,6 @@ void __hci_req_enable_advertising(struct hci_request *req)
 		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
 			adv_min_interval = DISCOV_LE_FAST_ADV_INT_MIN;
 			adv_max_interval = DISCOV_LE_FAST_ADV_INT_MAX;
-		} else {
-			adv_min_interval = hdev->le_adv_min_interval;
-			adv_max_interval = hdev->le_adv_max_interval;
 		}
 	}
 
@@ -1942,9 +1946,15 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	/* In ext adv set param interval is 3 octets */
-	hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
-	hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
+	if (adv_instance) {
+		hci_cpu_to_le24(adv_instance->min_interval, cp.min_interval);
+		hci_cpu_to_le24(adv_instance->max_interval, cp.max_interval);
+		cp.tx_power = adv_instance->tx_power;
+	} else {
+		hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
+		hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
+		cp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
+	}
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
 
@@ -1967,7 +1977,6 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-	cp.tx_power = 127;
 	cp.handle = instance;
 
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 421b6784a114f9..717c97affb1554 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7524,7 +7524,10 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 				   cp->adv_data_len, cp->data,
 				   cp->scan_rsp_len,
 				   cp->data + cp->adv_data_len,
-				   timeout, duration);
+				   timeout, duration,
+				   HCI_ADV_TX_POWER_NO_PREFERENCE,
+				   hdev->le_adv_min_interval,
+				   hdev->le_adv_max_interval);
 	if (err < 0) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_FAILED);
@@ -7722,7 +7725,8 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 
 	/* Create advertising instance with no advertising or response data */
 	err = hci_add_adv_instance(hdev, cp->instance, flags,
-				   0, NULL, 0, NULL, timeout, duration);
+				   0, NULL, 0, NULL, timeout, duration,
+				   tx_power, min_interval, max_interval);
 
 	if (err < 0) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_PARAMS,
-- 
2.28.0.618.gf4bc123cb7-goog

