Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F56C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbhLAS6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352051AbhLAS6i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FDC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g18so25488751pfk.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rAgw96mWSTxvK0gyqEQQZc+al2NNhHRrOI3U1Yiwed8=;
        b=ce8pkQgzsdEO9/vWEXlhv9eHi5h660Z8rE6zK3sW75qYO67naSNLC+xlyW5bQVmBwS
         2W/8qFUjI8MAQcUzwDtio2IkQOljOf0Q97cmcNFzowCx8QZ75dWXghJY5G0U9YgE40JH
         bfKagm+K9HoLNOArnKwgU9bP48k1x4lfVO1QqCD9wO+8CuIzmEcFkdOw+uOZRsBmndwW
         5Vh+HJU4dgxdtlz9ZZDRo/BClanzh/RLlTZegqzqgReh2e9tTmTtYxkk95xmcktpPbTI
         L9UB/9UmwwC3xIPGQfZgYFyNwc8VkwCXne7ukbfL8ItIA7oqNcHsaXI+QHbmgcTCRkRy
         +D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAgw96mWSTxvK0gyqEQQZc+al2NNhHRrOI3U1Yiwed8=;
        b=xp4TSxs2aQNpSQf39v378lmwno8tD3tAIkIkV02ZxlUweXJgfgWmAkd29uGO3HCfEB
         ZfVSBVcHSIuh50lvswE0uHvlV72xe250CYUUHMcIyMOEVk9vsp9QSlf4cud7nZ7xEZ3t
         SSKJBgQF2mjryqzqpZ4vzkhN1yZgTMzo5tyEN9Yjv8eqU5R71t0B97a4YciSg+MxwQko
         S4++wqYmTBCaGGOeTmS/Q0TeAE2Ug271Uawzr0PP/c7cFPEd13l9krCUWgPgG9pzvhL1
         3ceQnR2e5L4rkiZf5i2yA7VnXAto0l9pV2aXVVbjoCyPTmRe4VOE1FocaRiF1Gtk36Ba
         hPDw==
X-Gm-Message-State: AOAM531/on8rgpCUVSxLGFrKwofaj1g0ezRTziAXbiybEqRkRieiHMsu
        mI3E+0D+LOtTJ/Edzetq4AgLLpke4kg=
X-Google-Smtp-Source: ABdhPJwgaJH68cBJLg/SUfPZXv1mQ2ajsQzyATk94Ztr/ajQRf4OgstEMfKYUogoA3evaxldECKMAA==
X-Received: by 2002:a05:6a00:986:b0:4a2:c1fa:8899 with SMTP id u6-20020a056a00098600b004a2c1fa8899mr8127115pfg.61.1638384915506;
        Wed, 01 Dec 2021 10:55:15 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/15] Bluetooth: HCI: Use skb_pull_data to parse LE Ext Advertising Report event
Date:   Wed,  1 Dec 2021 10:55:01 -0800
Message-Id: <20211201185506.1421186-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the LE Extended Advertising Report
events received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 17 +++++++++++------
 net/bluetooth/hci_event.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c005b1ccdbc5..d3f2da9b2ac2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2517,8 +2517,8 @@ struct hci_ev_le_phy_update_complete {
 } __packed;
 
 #define HCI_EV_LE_EXT_ADV_REPORT    0x0d
-struct hci_ev_le_ext_adv_report {
-	__le16 	 evt_type;
+struct hci_ev_le_ext_adv_info {
+	__le16   type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 primary_phy;
@@ -2526,11 +2526,16 @@ struct hci_ev_le_ext_adv_report {
 	__u8	 sid;
 	__u8	 tx_power;
 	__s8	 rssi;
-	__le16 	 interval;
-	__u8  	 direct_addr_type;
+	__le16   interval;
+	__u8     direct_addr_type;
 	bdaddr_t direct_addr;
-	__u8  	 length;
-	__u8	 data[];
+	__u8     length;
+	__u8     data[];
+} __packed;
+
+struct hci_ev_le_ext_adv_report {
+	__u8     num;
+	struct hci_ev_le_ext_adv_info info[];
 } __packed;
 
 #define HCI_EV_LE_ENHANCED_CONN_COMPLETE    0x0a
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 42ffd5df6d4b..23cfcb1c0ca3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6649,26 +6649,40 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 
 static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_ext_adv_report *ev;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
+	if (!ev->num)
+		return;
 
 	hci_dev_lock(hdev);
 
-	while (num_reports--) {
-		struct hci_ev_le_ext_adv_report *ev = ptr;
+	while (ev->num--) {
+		struct hci_ev_le_ext_adv_info *info;
 		u8 legacy_evt_type;
 		u16 evt_type;
 
-		evt_type = __le16_to_cpu(ev->evt_type);
+		info = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
+					  sizeof(*info));
+		if (!info)
+			break;
+
+		if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_EXT_ADV_REPORT,
+					info->length))
+			break;
+
+		evt_type = __le16_to_cpu(info->type);
 		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
-			process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, ev->rssi,
-					   ev->data, ev->length,
+			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
+					   info->bdaddr_type, NULL, 0,
+					   info->rssi, info->data, info->length,
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
 		}
-
-		ptr += sizeof(*ev) + ev->length;
 	}
 
 	hci_dev_unlock(hdev);
@@ -7019,7 +7033,7 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 {
 	struct hci_ev_le_advertising_info *adv;
 	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_report *ext_adv;
+	struct hci_ev_le_ext_adv_info *ext_adv;
 	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
 	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
 
-- 
2.33.1

