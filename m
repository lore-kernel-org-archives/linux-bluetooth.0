Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E3C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8865A20737
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVq31Jtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgFIOEa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgFIOEX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:04:23 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8ABC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 07:04:22 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l10so9372491vsr.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eSWoC+ENIJoJDD4KPuRX2LwPpz2E7MZ+xdJMrSSPts=;
        b=FVq31JttBT0evDqGWa5Jk2doXXGb+c/GyTpjZ9q1UZBluBoZQbU+ycbEXSigMqKcOi
         QrXol5a++AoXtE07Euuk8ddPF5U1iEkOnHIQF/ICuF7iS4ubJ+IC60bSIxYzGQzYGhqD
         Z1DL6w0Nl0CGXWFmN1Uleghosn3LH3Jv1UqnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eSWoC+ENIJoJDD4KPuRX2LwPpz2E7MZ+xdJMrSSPts=;
        b=kHY1PXCCuoxvTxhnwqftI8g0g2twO//pH/5j71DCVPidR+vl0gzud3oZ1RmlOmAT/K
         Gd3o6lk0D0/bUZKHmc4OhhEaNO3eOMj5FdldBlpmD0jHQClQ/6gUuQtxOeuazjMerSYs
         Haa0iR7RMVMaFQpNlg3xj/I0Df03nEAb6fNIU/QSbYHC8USiIrDppn2I8ytzwr9J0A3i
         MNz514xDTh51zfpM0LVZdXU66/sHTRHml2Xa7ddml8QXPEKNc60yGLk8j0nnaN1F4HFf
         K86d6A9mIssU7ARdaSa0ZcbwvTYq0tr9vjMR/KlTfUlev8y815pf62nLv4vCYoYaHGaU
         Q8iQ==
X-Gm-Message-State: AOAM530/m6CRyK9CxQPD08EughDWFQE2oj4FVG8hoG/zxVgbTpwl9ZpB
        OtchIYaczgiuEKEJG66gdqoJrEricLs=
X-Google-Smtp-Source: ABdhPJzMlbJs/Ev/C5+NIOTwZveymieyXAZY3sYjRf9hn1inOFE1JpoMowSpAeMEZ9p3m8/zeOAfDQ==
X-Received: by 2002:a67:fc17:: with SMTP id o23mr3256505vsq.92.1591711461340;
        Tue, 09 Jun 2020 07:04:21 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id b7sm403849vsc.13.2020.06.09.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:04:20 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v1 2/3] bluetooth:centralize default value initialization.
Date:   Tue,  9 Jun 2020 14:03:52 +0000
Message-Id: <20200609140351.153833-3-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200609140351.153833-1-alainm@chromium.org>
References: <20200609140351.153833-1-alainm@chromium.org>
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
2.27.0.278.ge193c7cf3a9-goog

