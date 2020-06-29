Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61689C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4311E21D81
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZRC9H1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgF2SiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgF2SiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:02 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DCC030F00
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 09:11:04 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c7so4031293uap.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Kr0CfwM9aKJbWc9C5EQDAp5E5fQURuKqXKmcPgCKRE=;
        b=oZRC9H1Gd6zyRqmzg72zYw5eW3ddmJZTEDKJ5539KLntSeq9byAnfsEBOYFIEBnP9p
         L3Dza1wr8wbcFMdyZeGjdL1a+Bob1GsWt8Khjzh5XXtdWm6dczCzqULwfv2JAVkTs7IE
         IVy8mEkswZubHMbrE2Z2aWmEd3mmQIkTB1YO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Kr0CfwM9aKJbWc9C5EQDAp5E5fQURuKqXKmcPgCKRE=;
        b=N60+uALgDn1opV5T5SdU/A9pbrcG6UHosXSdUv6t9/2yjKHlZARWBa1AxT78DJczX5
         pqfy3PiwUe/rne72euhZwBROzA4fTpw9uqUnXGIwWca2kfsJc4APUl0me1uH1a/VQRYq
         U/NtE87gsJImbaHlxPjgPT0fgF+UmQ0ie9NmVnQLywhFjyObrLILBfqQS51mmZKDHnwl
         5Kk367btSJL1PpERepFcJDgk+a7EYHLURKQzm3A7WtjmvyD9bHe9iuMbOX+zpkwjL6w3
         OvgmNX/L3EpsdGr7ReGxYQ1vFFU6MXavWsiBtnwvBzmeFA9G5Dmha9MZO+ALfSi4X9Fp
         T5sA==
X-Gm-Message-State: AOAM533vbIeJlZchKbhDdpu25HFJq7lWiEt+6Y5RcM2nJLo4kx0728VZ
        I78TzYg9pCmXUbvtkAU45hvxX/jaHlY=
X-Google-Smtp-Source: ABdhPJwgQ7qilF+Kj4i8kWsPawKKAO/r/IEOnUVv0UnUnzU+k49mN7fyqdjJWMA8SBA35nkl1KMu1g==
X-Received: by 2002:ab0:7849:: with SMTP id y9mr11180790uaq.56.1593447063791;
        Mon, 29 Jun 2020 09:11:03 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 123sm5633vsu.17.2020.06.29.09.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:11:03 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3] Bluetooth: Adding a configurable autoconnect timeout
Date:   Mon, 29 Jun 2020 16:11:00 +0000
Message-Id: <20200629161100.3070288-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a configurable LE autoconnect timeout.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
 - Rebase onto master

Changes in v2:
Fixing longer than 80 char line.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/mgmt_config.c      | 13 +++++++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 836dc997ff94..34ad5b207598 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -376,6 +376,7 @@ struct hci_dev {
 	__u16		def_br_lsto;
 	__u16		def_page_timeout;
 	__u16		def_multi_adv_rotation_duration;
+	__u16		def_le_autoconnect_timeout;
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5577cf9e2c7c..1920e3c5c6f6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3569,6 +3569,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
+	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e060fc9ebb18..03a0759f2fc2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5315,7 +5315,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER,
+			      hdev->def_le_autoconnect_timeout, HCI_ROLE_MASTER,
 			      direct_rpa);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 8d01a8ff85e9..b30b571f8caf 100644
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
2.27.0.212.ge8ba1cc988-goog

