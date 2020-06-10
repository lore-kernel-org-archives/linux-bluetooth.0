Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616DD2072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPuuurF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgFJUFP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:05:14 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1EC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:13 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m23so916966vko.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dV0hAXpE/4/z6MBV8H+jd9EqcYaSlmmWsU21BlHACvU=;
        b=jPuuurF43Ku9Rke+gOv7oJfyo7p+NjD+spUmQv5O3YFm7S8Pxfy3oyiNFysdJBV5DZ
         tXGj9BraUsStJ10PX5iNyDgQUSu52mZjHgZgoMp6MCZhajAArjNwYF5Fo2m+WYC2tJfV
         TErPMJOZXCELr+EEuNVRJg/wu0K+4bF+TPLUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dV0hAXpE/4/z6MBV8H+jd9EqcYaSlmmWsU21BlHACvU=;
        b=NfC4CZpyBrKdENo1UwoeKYvIV9t/oAbyzqB9rTBg4Qj2uGPLMZs7jYzibO3b1XHQiU
         aH8lsofGWVWk7BNmT8mCpI/PpBvoreGqt4UbDt+4XS3sHXf0bau5eUDhKiiucKo8DGA8
         6DvlWtVdcJV/PaJe+41p3uuxTvE5he2oBkobyGcA2xcbaj78bwbybJfmB+u6lR52LNmD
         KpqXiOPAiUJUV2xVTtkGr0lpLGUoAUHsz024kUj3vU49vxenesjr4jAXBJD6H9Um/kHo
         q4i8ULwo7z/l2pkpcpt48niF++OYgl+TXz42cm8zx8mroShGcBWsWz8vHB7VzuSrzC5D
         q0Lg==
X-Gm-Message-State: AOAM530yadF+bO7XYRE+aez0+sNh8YDdtJXfwMEFTIcptoIWudnm8pLU
        vjtUP0hzO3XnBy20NAEw/0AogbAC5oA=
X-Google-Smtp-Source: ABdhPJzzH3JseZYFBKXV3xF2nYAOg5rhsSAhokXs0sA51pGUUiY6ghqz/Gf3qBbJbLN5ot7N4peP6A==
X-Received: by 2002:a1f:a906:: with SMTP id s6mr3673299vke.26.1591819512498;
        Wed, 10 Jun 2020 13:05:12 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q185sm107253vkq.10.2020.06.10.13.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:05:12 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2 2/3] bluetooth:centralize default value initialization.
Date:   Wed, 10 Jun 2020 20:04:53 +0000
Message-Id: <20200610200452.107406-3-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200610200452.107406-1-alainm@chromium.org>
References: <20200610200452.107406-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch centralized the initialization of default parameters.  This
is required to allow clients to more easily customize the default
system parameters.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
 net/bluetooth/hci_conn.c         | 14 ++++----------
 net/bluetooth/hci_core.c         | 14 +++++++++++++-
 net/bluetooth/hci_request.c      | 15 +++++----------
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cdd4f1db8670..0d5dbb6cb5a0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -295,6 +295,14 @@ struct hci_dev {
 	__u8		le_scan_type;
 	__u16		le_scan_interval;
 	__u16		le_scan_window;
+	__u16		le_scan_int_suspend;
+	__u16		le_scan_window_suspend;
+	__u16		le_scan_int_discovery;
+	__u16		le_scan_window_discovery;
+	__u16		le_scan_int_adv_monitor;
+	__u16		le_scan_window_adv_monitor;
+	__u16		le_scan_int_connect;
+	__u16		le_scan_window_connect;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__u16		le_conn_latency;
@@ -323,6 +331,16 @@ struct hci_dev {
 	__u16		devid_product;
 	__u16		devid_version;
 
+	__u8		def_page_scan_type;
+	__u16		def_page_scan_int;
+	__u16		def_page_scan_window;
+	__u8		def_inq_scan_type;
+	__u16		def_inq_scan_int;
+	__u16		def_inq_scan_window;
+	__u16		def_br_lsto;
+	__u16		def_page_timeout;
+	__u16		def_multi_adv_rotation_duration;
+
 	__u16		pkt_type;
 	__u16		esco_type;
 	__u16		link_policy;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 307800fd18e6..9bdffc4e79b0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -789,11 +789,8 @@ static void set_ext_conn_params(struct hci_conn *conn,
 
 	memset(p, 0, sizeof(*p));
 
-	/* Set window to be the same value as the interval to
-	 * enable continuous scanning.
-	 */
-	p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
-	p->scan_window = p->scan_interval;
+	p->scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
+	p->scan_window = cpu_to_le16(hdev->le_scan_window_connect);
 	p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
 	p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
 	p->conn_latency = cpu_to_le16(conn->le_conn_latency);
@@ -875,11 +872,8 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 
 		memset(&cp, 0, sizeof(cp));
 
-		/* Set window to be the same value as the interval to enable
-		 * continuous scanning.
-		 */
-		cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
-		cp.scan_window = cp.scan_interval;
+		cp.scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
+		cp.scan_window = cpu_to_le16(hdev->le_scan_window_connect);
 
 		bacpy(&cp.peer_addr, &conn->dst);
 		cp.peer_addr_type = conn->dst_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbe2d79f233f..122e44a82995 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2982,7 +2982,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	adv_instance->remaining_time = timeout;
 
 	if (duration == 0)
-		adv_instance->duration = HCI_DEFAULT_ADV_DURATION;
+		adv_instance->duration = hdev->def_multi_adv_rotation_duration;
 	else
 		adv_instance->duration = duration;
 
@@ -3397,6 +3397,12 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_adv_max_interval = 0x0800;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
+	hdev->le_scan_int_suspend = 0x0400;
+	hdev->le_scan_window_suspend = 0x0012;
+	hdev->le_scan_int_discovery = DISCOV_LE_SCAN_INT;
+	hdev->le_scan_window_discovery = DISCOV_LE_SCAN_WIN;
+	hdev->le_scan_int_connect = 0x0060;
+	hdev->le_scan_window_connect = 0x0060;
 	hdev->le_conn_min_interval = 0x0018;
 	hdev->le_conn_max_interval = 0x0028;
 	hdev->le_conn_latency = 0x0000;
@@ -3412,6 +3418,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
+	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
@@ -3420,6 +3427,11 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
 	hdev->min_enc_key_size = HCI_MIN_ENC_KEY_SIZE;
 
+	/* default 1.28 sec page scan */
+	hdev->def_page_scan_type = PAGE_SCAN_TYPE_STANDARD;
+	hdev->def_page_scan_int = 0x0800;
+	hdev->def_page_scan_window = 0x0012;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1acf5b8e0910..a7f572ad38ef 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -34,9 +34,6 @@
 #define HCI_REQ_PEND	  1
 #define HCI_REQ_CANCELED  2
 
-#define LE_SUSPEND_SCAN_WINDOW		0x0012
-#define LE_SUSPEND_SCAN_INTERVAL	0x0400
-
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
 	skb_queue_head_init(&req->cmd_q);
@@ -366,13 +363,11 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable)
 		/* 160 msec page scan interval */
 		acp.interval = cpu_to_le16(0x0100);
 	} else {
-		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
-
-		/* default 1.28 sec page scan */
-		acp.interval = cpu_to_le16(0x0800);
+		type = hdev->def_page_scan_type;
+		acp.interval = cpu_to_le16(hdev->def_page_scan_int);
 	}
 
-	acp.window = cpu_to_le16(0x0012);
+	acp.window = cpu_to_le16(hdev->def_page_scan_window);
 
 	if (__cpu_to_le16(hdev->page_scan_interval) != acp.interval ||
 	    __cpu_to_le16(hdev->page_scan_window) != acp.window)
@@ -927,8 +922,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		filter_policy |= 0x02;
 
 	if (hdev->suspended) {
-		window = LE_SUSPEND_SCAN_WINDOW;
-		interval = LE_SUSPEND_SCAN_INTERVAL;
+		window = hdev->le_scan_window_suspend;
+		interval = hdev->le_scan_int_suspend;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.27.0.290.gba653c62da-goog

