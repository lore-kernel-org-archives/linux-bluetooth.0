Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3620644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kGRjpAXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgFOO4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgFOO4k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 10:56:40 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EEAC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:56:40 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id u15so3993555vkk.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlaxTrXbGR01eYNulv9wFvTybdJtMTeD8HxeahWvWT4=;
        b=kGRjpAXMz2/s1Lp8JjeXu/TCokamDJXtReqcplCHuVOBARy8rrEGOhM0D2K2CeYtvr
         8ikQSDEjdXhK/MdnzqxV30Bi0N2eUz+58D98TG8AtHwqCRrZ1JFHCfXR7TICKNQAW6bk
         1aXDPdkLJWa2YE6OWltxYJObLPYz5ulF+d2+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlaxTrXbGR01eYNulv9wFvTybdJtMTeD8HxeahWvWT4=;
        b=GMo4EMy3WaLtm+L3DJkcoSnP481EW50lXkLh2peJT80QlO5BicqVko3X0BO43teKiJ
         jtwAn/SwiVpdajvgy+zk1dmWz9vdUDCF6BoZMgT9kn184j2RcU4CVRWMaJEBt890nUnd
         oFP1F5bTY/ZWLws+WE4/6o02eXDmDkvZFZwNVBY3+Ofv9ZfHvczmZ6mmz9cXpHBgGyWe
         5Ak6GBWGVr/QXfM7r6CV4SWp8pmTWJXN4z+GfdOLljnrDhmx06zKvR/lWmriNlTujL2P
         j7QsH1iGbZqRyqrZDASbCwVuAc61gYUQk35qq3qjxac4CgMz87HK6EWq1zNjQ6K9tbhs
         2meA==
X-Gm-Message-State: AOAM530I7qQHCWYYeg52jfuYuH6WPoi/A1yEQF9EPoIWC329fdbu3Cj2
        W6NCkJG0fh4oU8jlV3kd9F87u1VaSIQ=
X-Google-Smtp-Source: ABdhPJwECnE5+hSMrhq2teY9OSFcewQ976AoejXRXYJhkSjPPOjw8MSCPf0uCKsiuSJQsc2HHmFk5g==
X-Received: by 2002:a1f:5f88:: with SMTP id t130mr1416990vkb.70.1592232999253;
        Mon, 15 Jun 2020 07:56:39 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r134sm2336751vkd.52.2020.06.15.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:56:38 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: Adding a configurable autoconnect timeout
Date:   Mon, 15 Jun 2020 14:56:36 +0000
Message-Id: <20200615145636.260221-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a configurable LE autoconnect timeout.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/mgmt_config.c      | 13 +++++++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0d5dbb6cb5a0..f8e800479608 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -340,6 +340,7 @@ struct hci_dev {
 	__u16		def_br_lsto;
 	__u16		def_page_timeout;
 	__u16		def_multi_adv_rotation_duration;
+	__u16		def_le_autoconnect_timeout;
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f1052a7c488..73fb0843fb89 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3422,6 +3422,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
+	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfeaee347db3..beb9bb1da0ba 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5319,7 +5319,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER,
+			      hdev->def_le_autoconnect_timeout, HCI_ROLE_MASTER,
 			      direct_rpa);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f6dfbe93542c..0ff77ef05fc5 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -17,6 +17,12 @@
 	{ cpu_to_le16(hdev->_param_name_) } \
 }
 
+#define HDEV_PARAM_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
+{ \
+	{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+	{ cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) } \
+}
+
 int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 data_len)
 {
@@ -59,6 +65,8 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(0x0018, le_conn_max_interval),
 		HDEV_PARAM_U16(0x0019, le_conn_latency),
 		HDEV_PARAM_U16(0x001a, le_supv_timeout),
+		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
+						def_le_autoconnect_timeout),
 	};
 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
@@ -129,6 +137,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0018:
 		case 0x0019:
 		case 0x001a:
+		case 0x001b:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -238,6 +247,10 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0001a:
 			hdev->le_supv_timeout = TLV_GET_LE16(buffer);
 			break;
+		case 0x0001b:
+			hdev->def_le_autoconnect_timeout =
+					msecs_to_jiffies(TLV_GET_LE16(buffer));
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.27.0.290.gba653c62da-goog

