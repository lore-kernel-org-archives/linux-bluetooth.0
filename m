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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75AC43470
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D9A613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbhDPVWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbhDPVVw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF78C06138E
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so11090630pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D/4MpdWKnFOZDQLn2fW54NXZewOrJFxm7ZtpnG2I7ps=;
        b=lTQFMy7f9GvXtX1jf2gHNaNbmyMhVKS0AVgOqXlsxOkeGOuD8yird2ANpjJbshpwYL
         qd6BhxWwFTEERI5YcWsZpG02BXf8lqwqx2Ft4x+3/NwlJtejNZVaRNrq+Ws6Cx6rISFF
         cUU6EQZSvozkzBgFLK1EuCjawwBwL3lyn0bqwV0xREXcvQs3x1KsoSV0nG7bkRC9MNP+
         5T6LUFmh5fMAxVhuC34hX9S0KX8Xqg1ZKL9ZoQQi2TW3UgsajMwVFnOCajUFsBkL9/CN
         5RMz9cLTtcr0T2pXVXULwPzciUcj6y2Wl0ffwctLuqkMKvfu5BKBYBjmyjD+C9N2zPOh
         EHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/4MpdWKnFOZDQLn2fW54NXZewOrJFxm7ZtpnG2I7ps=;
        b=Z43W7GOX398/GZQ56wyDJb4RPg+l2eVODWCrMOJRVDeREJlDyZKZwtlMkd0aLeHM0k
         aLWhUzuC+0Dz/1H+xc4z74TWDHYkhBtyepTeHxnTxKXRbNS8zj+iHk4tL6pTCm4kDnAP
         HU1wdgNZ7jerO+lzciG8R1LLaXPDwS0dcGUmM+7js5+Wp6wliFLMC3JyZj3v6QCcdkQw
         98KWcEta69Ezm38Z7P8+6OskfKv9POlgbZRSZbuK9H0V6gg+QYuHqTEYMlelLoWZwTbO
         e4K/Gewm2KkyBp0ihGOHSXppaoqavDU7E8JMvt/K7LW0TcFguTBq5uBv7UzX6svjxJRD
         j49A==
X-Gm-Message-State: AOAM532Jjrxlp09Ip83C7LwOcExc/HvItRqy9Wl+r3jclU8xL+AI9fOY
        brOU2ghZ3Yr6gn84nNYZflU2u5b6y3PJPg==
X-Google-Smtp-Source: ABdhPJxQoguKhQHmH/oso7rM6erxdSrvIPvACmnPPTskIKxEGPD13NrDkLDyksUlvqaBPwg7MqFGBQ==
X-Received: by 2002:a17:90a:db15:: with SMTP id g21mr11389163pjv.113.1618607913269;
        Fri, 16 Apr 2021 14:18:33 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: HCI: Use skb_pull to parse LE Extended Advertising Report event
Date:   Fri, 16 Apr 2021 14:18:22 -0700
Message-Id: <20210416211823.3776677-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416211823.3776677-1-luiz.dentz@gmail.com>
References: <20210416211823.3776677-1-luiz.dentz@gmail.com>
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
index becc6319c8c5..3fdab3fe427d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6360,26 +6360,40 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 
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
@@ -6730,7 +6744,7 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 {
 	struct hci_ev_le_advertising_info *adv;
 	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_report *ext_adv;
+	struct hci_ev_le_ext_adv_info *ext_adv;
 	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
 	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
 
-- 
2.30.2

