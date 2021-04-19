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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF24C43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D104611F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhDSRNh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhDSRNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D5C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v13so4496990ple.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uWrugh5vheKKsuVq4vaSpfJrFNVqbmbNq/iszrhUEtY=;
        b=cL6a9UaoKtYUOlup00PuEyh1zFZqTDBBn+PzMtr7O1xScCUvBL9id5PfdS/n4DlkN9
         gf8pEECNzem0CXvOFLfuA75sy65w+jGsepCeZ4azf05bx9Pu0yh+uI774UiM7BVGO0Gv
         HrDNBZczWqil5sfpCOW9tCqyYQua+kkXFbyaVX7dyycURSxF1IgghsN748b5I9CeBp1I
         kPQVM0eHLZYVtWjL7K5M8PwuTgAk1uf0m3T+shwwUDT3DGWMgCuDO0CkU1BBOETtqIJN
         zebTCqf0UL9DxG75fJbOaGUkcYlFwUMbmf208J1iwV4gaLqpwJPTldULfk6nk9DvDuZ6
         LAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWrugh5vheKKsuVq4vaSpfJrFNVqbmbNq/iszrhUEtY=;
        b=a2bW6BvLtQs3ZQVnriaFzbeckRuEkti+09McouuXOqaKoeOveVw7ZS/JGD8GRcfQXj
         ENgvfmDGzGiW0VUDxlgqOxlr0LEqMO6vWP8WJZDCBjfp+ZCyunW+K5T+uzGGeWZ3PRI0
         y2MeArlm4kSO7kuWG6mq5+pPzE0f/OH0yaRYAgjgAX4su50f9nYveDYuSR4dcTdJ42mO
         +oSRoPyHrMNzJ4sKMsZ+3/BSU0zW3t8YpWolKkO7arXoh44S6fWEPc6gOZc+7sEghyM+
         /eh+lwJBdXSpeHH90VK1WcY11Q203mCivIXhC1hHPlWwJgh2wDcgaLvGnPZbSuDJTh3m
         RFyA==
X-Gm-Message-State: AOAM532SeyNTgKW8EKrEe5e0jWRq2Vjm9jlY6EBUBb6UqLSX02Gr9qNd
        FyLgCXiuegZ8oqW/QDXtX/IGZUkzNn2xxQ==
X-Google-Smtp-Source: ABdhPJxH3fQdLahJQoC0x2tY/ROIIK62bWUXKVaotWI8LihP7EdEiT1adV+u0FrwHfOHYUi0ZgalPw==
X-Received: by 2002:a17:90a:4e46:: with SMTP id t6mr106296pjl.236.1618852384911;
        Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.13.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:13:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] Bluetooth: HCI: Use skb_pull to parse LE Extended Advertising Report event
Date:   Mon, 19 Apr 2021 10:12:56 -0700
Message-Id: <20210419171257.3865181-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419171257.3865181-1-luiz.dentz@gmail.com>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull to check the LE Extended Advertising Report events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 17 +++++++++++------
 net/bluetooth/hci_event.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3ec8e07f1724..9600cc6ad952 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2399,8 +2399,8 @@ struct hci_ev_le_phy_update_complete {
 } __packed;
 
 #define HCI_EV_LE_EXT_ADV_REPORT    0x0d
-struct hci_ev_le_ext_adv_report {
-	__le16 	 evt_type;
+struct hci_ev_le_ext_adv_info {
+	__le16   type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 primary_phy;
@@ -2408,11 +2408,16 @@ struct hci_ev_le_ext_adv_report {
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
index 69a5296382ae..6aa05d7364bc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6359,26 +6359,40 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 
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
@@ -6729,7 +6743,7 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 {
 	struct hci_ev_le_advertising_info *adv;
 	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_report *ext_adv;
+	struct hci_ev_le_ext_adv_info *ext_adv;
 	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
 	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
 
-- 
2.30.2

