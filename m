Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32134C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03442206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXeWewl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFKCCJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKCCJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 22:02:09 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0082C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:08 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so2483306vsm.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D01zfZvVT9ayynEW2qHT1584F41pNqtWD96+bPHij7U=;
        b=GXeWewl2azDZ8z+kw0STlBsAtwPf/RiUjdwbzbXC+mgA0FERL+2M8+V42g/sEHs7BJ
         4qIbuA2qamJpkNGHIcp2tTOxAB+8IV3bWTysMrO5zI6U7NtOW8KB21Pxd+a+L++kC/fy
         4/uoGyd4/b7VsBGehda0TbOq7UifT0i64akEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D01zfZvVT9ayynEW2qHT1584F41pNqtWD96+bPHij7U=;
        b=IxpbYfj3ENSle5ECDnPyiJzBzwGy+mlISBp4M+NEN9tqay0rkpVJ8z+8Xaxf+JAY49
         zUORrvRciHMsqo8Xk5FtonBm8zHdZfsQGgk6uMA8XJveKWCJAzoJDmeB4pM7tlm2kpFt
         teeunO3/B2BZQvIbLtRzThO2+2iJsZ0DftjkhVhwJMlSJVC6010gSG6TvPOQQKM1X9/B
         hQoeTTwSxLjfv6E64td6C3chomTQDkZm6IOzuD/Vybv/wC/Dc6z2VD1b8i5vYI9wLhS4
         TckStd4vnLU+1VqtxhVQZl6Q8voSKffugGYPUcTW0CtxPWuvEBoKZIX1Q6nnGBn5EBed
         gGcQ==
X-Gm-Message-State: AOAM5315cPdpmBo5VMiFIZuUxAUTIEK6cU+4CnUQqGZMe1eXc/muzL3G
        VCq8/JA6QWq7AbwdlyOzcY/azlxTQWk=
X-Google-Smtp-Source: ABdhPJyGhD8qdCsvqmx5mITKah21E4cx51s6j/yKU5pAhQR0YmuiBsE/wJcVO4zP8uPaK3fjQGKNbg==
X-Received: by 2002:a67:2ecc:: with SMTP id u195mr4992519vsu.32.1591840927903;
        Wed, 10 Jun 2020 19:02:07 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r17sm243197vsi.34.2020.06.10.19.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:02:07 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v3 2/3] bluetooth:centralize default value initialization.
Date:   Thu, 11 Jun 2020 02:01:56 +0000
Message-Id: <20200611020157.70230-3-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200611020157.70230-1-alainm@chromium.org>
References: <20200611020157.70230-1-alainm@chromium.org>
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

Changes in v3: None
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

