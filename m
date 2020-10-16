Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4DD21556
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 18:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUBcPTrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391265AbgJPSKA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391261AbgJPSKA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 14:10:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EEC061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 11:10:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so1950602pfk.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gv1KGJW0XMD8zqF8zr4acF3k7z52CKNhz1VVr8GPxjA=;
        b=HUBcPTrdt4jW6nKhWD6i1AdPCQAd5eu8NS7CKfdiKv/N6jsQwbBLm51fbAxWCVeqFs
         ukZjcHGEUqOcJfFn0/v55dAiURjK1t4O8gTj+vP3wD9YqXRCMLd/jRf6yAKeUYpA724O
         nxZ647RYU42TmdfCSJHTCf9gsfuRDVmvAfXD6Gt11o34TLCQU3HI7UsoUZb1yImQ5/Ki
         t7YRrF4yFB6YZf5vJphm1TTkK8UqZbhNX+agW8u5Wl4mJr7DN9ZxIQoOs+IEdCPC/cuv
         PYB5cqZnqO6l2kKYsXBwTZoYIw3gScFybxvAPFFLObmtbNbYnyo7gFGZlly9DzO8Izr4
         HJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gv1KGJW0XMD8zqF8zr4acF3k7z52CKNhz1VVr8GPxjA=;
        b=DIakHIcUdzmYnM/8S0EFNt9g+RgELZbP74HCEG+rdg9ldMXco0zCHBZpYa5N9bXUXH
         AObGWNF7c/3sbg4hzhuiSx5+4zz1L5BGcYWiVVCoWviTt520D1VR4EerZfb90BYser+9
         jnd59YHBMC9PSAl92jXkx9vgcVuDRtXLHxGvsk/tAiZD+EUy8s3wM0PHnghM2a5+QOw+
         8XyJ5EaXJ7OkmMU9zqFbcm4smo/gNJfiB6nufIszsnk4wOMFhZxqphFLxLgBud5wFEie
         tL9/8jMZEKiao94vpECwHw3jH2g1jsOH+65dM1CjD9anOzzqH6usbWhkrQkH/1Vhvzin
         /IHw==
X-Gm-Message-State: AOAM531DTSTgYJipWh3a7Cn+6Jo4In47Y/0qJOb121TtSvPoSbQhMjnR
        vYAnzQ7A3v/UZkoJeEcgIzYAxJ8JudgV0g==
X-Google-Smtp-Source: ABdhPJyy8UxGxt/IF5sINmF8CpDDcczqe7RdH8ced5GCuq48SVAzTEr7LF+SAlX7S8tfa+HqU4ClFg==
X-Received: by 2002:a05:6a00:7d6:b029:152:3ccb:bc9e with SMTP id n22-20020a056a0007d6b02901523ccbbc9emr4955400pfu.57.1602871799226;
        Fri, 16 Oct 2020 11:09:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y14sm3538573pfe.107.2020.10.16.11.09.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:09:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix not checking advertisement bondaries
Date:   Fri, 16 Oct 2020 11:09:55 -0700
Message-Id: <20201016180956.707681-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving advertisements check if the length is actually within
the skb, this also make use of skb_pull to advance on the skb->data
instead of a custom ptr that way skb->len shall always indicates how
much data is remaining and can be used to perform checks if there is
enough data to parse.

Fixes: a2ec905d1e160a33b2e210e45ad30445ef26ce0e ("Bluetooth: fix kernel oops in store_pending_adv_report")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 72 ++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4c3703f2e94..ae31d227730b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5599,24 +5599,40 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
 
 	hci_dev_lock(hdev);
 
+	skb_pull(skb, sizeof(num_reports));
+
 	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
+		struct hci_ev_le_advertising_info *ev;
 		s8 rssi;
 
-		if (ev->length <= HCI_MAX_AD_LENGTH) {
-			rssi = ev->data[ev->length];
-			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, rssi,
-					   ev->data, ev->length, false);
-		} else {
-			bt_dev_err(hdev, "Dropping invalid advertising data");
+		if (skb->len < sizeof(*ev)) {
+			bt_dev_err(hdev, "Malformed advertising report");
+			break;
+		}
+
+		ev = (void *) skb->data;
+		skb_pull(skb, sizeof(*ev));
+
+		if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
+			bt_dev_err(hdev, "Malformed advertising data");
+			break;
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		skb_pull(skb, ev->length);
+
+		if (skb->len < sizeof(rssi)) {
+			bt_dev_err(hdev, "Malformed advertising rssi");
+			break;
+		}
+
+		rssi = get_unaligned(skb->data);
+
+		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
+				   ev->bdaddr_type, NULL, 0, rssi,
+				   ev->data, ev->length, false);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5669,15 +5685,31 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
 static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
 
 	hci_dev_lock(hdev);
 
+	skb_pull(skb, sizeof(num_reports));
+
 	while (num_reports--) {
-		struct hci_ev_le_ext_adv_report *ev = ptr;
+		struct hci_ev_le_ext_adv_report *ev;
 		u8 legacy_evt_type;
 		u16 evt_type;
 
+		if (skb->len < sizeof(*ev)) {
+			bt_dev_err(hdev, "Malformed ext advertising report");
+			break;
+		}
+
+		ev = (void *) skb->data;
+		skb_pull(skb, sizeof(*ev));
+
+		if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
+			bt_dev_err(hdev, "Malformed ext advertising data");
+			break;
+		}
+
+		skb_pull(skb, ev->length);
+
 		evt_type = __le16_to_cpu(ev->evt_type);
 		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
@@ -5687,7 +5719,6 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
 		}
 
-		ptr += sizeof(*ev) + ev->length;
 	}
 
 	hci_dev_unlock(hdev);
@@ -5873,19 +5904,26 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
 
 	hci_dev_lock(hdev);
 
+	skb_pull(skb, sizeof(num_reports));
+
 	while (num_reports--) {
-		struct hci_ev_le_direct_adv_info *ev = ptr;
+		struct hci_ev_le_direct_adv_info *ev;
+
+		if (skb->len < sizeof(*ev)) {
+			bt_dev_err(hdev, "Malformed direct advertising");
+			break;
+		}
+
+		ev = (void *) skb->data;
+		skb_pull(skb, sizeof(*ev));
 
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, &ev->direct_addr,
 				   ev->direct_addr_type, ev->rssi, NULL, 0,
 				   false);
-
-		ptr += sizeof(*ev);
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.26.2

