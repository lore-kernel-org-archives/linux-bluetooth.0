Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D5C433F2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B33C2065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIhed68W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGMGS4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgGMGS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051DC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so3867084pls.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f1oHIKp+Xl1MtDR3jCF7Dp+Qm8VEDoGCEovuZWBlKwk=;
        b=kIhed68WGVNC99IJGz/zYURc14jeots+sVpKjP9Wzfb3Hjrkj/d0txeaOuiD7a7sEM
         8zutwg/JuQuYiL/ExxO5zghiFonoiy9FxdeLtKUi46/slPx2WZGDd83daqAr8a3SALH2
         SKpJczv9d1UFjaQ3/4hpi3uT0MnBsz8f7ub1nOmYwT2bul1NVk9xloV0xVsZX0sXZfWx
         /YLrL7faNLjG49VV2I9QkNB5aGy6J5NZ9mTqj5eMQUFfwBO+onZEtFUX2+Mrp5+dnqZ1
         pKcygtPni9R1mXHz6v71de48owQWRogvrRJerEIpLY/4T7WQt5f5iGBSveuVFnqdCyWV
         66hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f1oHIKp+Xl1MtDR3jCF7Dp+Qm8VEDoGCEovuZWBlKwk=;
        b=DLyqPgO5KlUFGfj9Lc8+tDNwWIn+PrhmtsZAvETlHVgPKTh9+BepXDTUBzfXb1YEHp
         gw3ZK1wTl4gxz7oc/OFASgr3SC6BsqbOOdb2bXRN3MN+6pLcmLBTc7GWc8cdm8DC8acT
         aRmVhALNb2fL+N7Odmob4HZw8QI28uC4uwM1sJ9xGvpf5gEYnAjgjb3pUFW54Ehu3fqE
         +UX0/s8a5pQ40Odj4tSR+og85ld35VmZOSbOUFtyPUnT937lOEhq77g7iU+XnOEzCbZ6
         oPggdcoq9/BnHPu65MMimzOwARN10xwE666ADLmsWXleZuoJQfEGMyFuvhyzZkg5ED6C
         RfSg==
X-Gm-Message-State: AOAM531ozeW2DREafnv12nuotlOlD8uXVsOflc9sU9+aApE9Eb6s3Ojb
        TXXwfA84zKBHLG4CmK/yX2tWeEhRJ7TuYA==
X-Google-Smtp-Source: ABdhPJwEOJ7OadWiiCZv5/lLsdk4wDT/US4qI/Jr7EnWPHLjrPEYmgM/ezRfSh6YVl9UWGHpdG0Kkg==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr18903824pjv.58.1594621135806;
        Sun, 12 Jul 2020 23:18:55 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:55 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 8/8] Bluetooth: Enable controller RPA resolution using Experimental feature
Date:   Mon, 13 Jul 2020 11:52:13 +0530
Message-Id: <20200713062213.3692-9-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support to enable the use of RPA Address resolution
using expermental feature mgmt command.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   |  3 ++-
 net/bluetooth/hci_request.c |  6 +++--
 net/bluetooth/mgmt.c        | 52 +++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4ff2fc4498f3..cb284365b4c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -307,6 +307,7 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
+	HCI_ENABLE_RPA_RESOLUTION,
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 684c68cb5c76..c8a5e1e4dba2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5222,7 +5222,8 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
 
-	if (use_ll_privacy(hdev) &&
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		hci_req_disable_address_resolution(hdev);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c3193f7f9ff0..cb44b83539e6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -677,7 +677,8 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 	}
 
 	/* Disable address resolution */
-	if (use_ll_privacy(hdev) &&
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
@@ -870,7 +871,8 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
-	if (use_ll_privacy(hdev) && addr_resolv) {
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) && addr_resolv) {
 		u8 enable = 0x01;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c292d5de4dc3..fbe02ab5fa05 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3759,6 +3759,12 @@ static const u8 simult_central_periph_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
+/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+static const u8 rpa_resolution_uuid[16] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
@@ -3795,6 +3801,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev) {
+		if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION))
+			flags = BIT(0);
+		else
+			flags = 0;
+
+		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3895,6 +3912,41 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
+		bool val;
+		int err;
+
+		/* Parameters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		val = !!cp->param[0];
+
+		if (val)
+			hci_dev_set_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
+		else
+			hci_dev_clear_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
+
+		memcpy(rp.uuid, rpa_resolution_uuid, 16);
+		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		return err;
+	}
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
-- 
2.17.1

