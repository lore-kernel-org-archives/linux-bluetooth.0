Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C734C5517A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D78D22460
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 00:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBq7fLKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756242AbgJXAWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756220AbgJXAWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 20:22:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C49C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:22:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so1881804plx.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KZCYxjRbYw95khCwcdrjK4U98Qheis9asdJR+uxgLc=;
        b=GBq7fLKOGhx1OuO8XOQ3N2ENyZx6LOB9P5vl35vpIWED1kbRIYHGILk6gD8kliWgJt
         arn3MW/XgR5vmhEwC7FVl3BfP9gwwHY4RG6zZm4o1jFM9Q7x3RkYEKWLGUwx102OmBfD
         AjD+I0L4hQnL7hqP0uN1IfPAxaUVe24wOF204C8xQ9ATj1HkioSV/Dn+WD4ZXTfy36HE
         VBJ1RJHNQjtxUzotdu2Y2PRBOqRgb+y8mXYuInQFU/iFqTJqdUzK91/5lUZv0epTZsM5
         hdN7WFiugRVfe9MKWwEQJRKaDrCMDz7tH/WHSviw3zcZ74ScP/6SbpAYsdYxKAa2M4Hl
         vuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KZCYxjRbYw95khCwcdrjK4U98Qheis9asdJR+uxgLc=;
        b=JWkc3n2W+J5+OCtWo15Iro+jsiZkAWabvb/EecPokF9JlmuxDSB0HXciuQADV2vjfT
         A3q0oJiowgmQoIaAcylwW7MlFlsOzTh1azBNbRD+llkFNgegKGD0kI8PZhMvfnGH1/bD
         H7EjUeEYl5LJ9wIWerRl2dnwqGKrqiYwaXM7PosaS7uiArBwQ8LNLkIpZCXRvZd5jm7N
         7uFyP6tJ8rzsTkJHTmpQsjGRUx3zokcAPzuQiThtFgDaLd10BaZ5egzpWsRfEO+7uixM
         Rf7wcxoCv+wHmXd3G1PnXfwR0kvBzyaBIys9GO0fXHVSTEXbQSOs2RjpsG+FUoBBskqZ
         VmFA==
X-Gm-Message-State: AOAM533ixumjmRkjiGkvc14mARmeMT091hKspCBw8vtYyXpInex5cRuV
        ApFFbIqPV+l4zRFxzja2Mwh44NE/epATHA==
X-Google-Smtp-Source: ABdhPJxQa6jVjjQ2eZgg3r3iid1ZWSv2E3u9B2lsehgYSUgVBH3GYhcpYLpvBr4rIN5eKf+mH30o7w==
X-Received: by 2002:a17:90a:2bc9:: with SMTP id n9mr5594291pje.219.1603498973440;
        Fri, 23 Oct 2020 17:22:53 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q8sm3195099pfl.100.2020.10.23.17.22.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 17:22:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Fix not checking advertisement bondaries
Date:   Fri, 23 Oct 2020 17:22:50 -0700
Message-Id: <20201024002251.1389267-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c | 73 ++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4c3703f2e94..6925c090a9e0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5599,24 +5599,41 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
+		rssi = skb->data[0];
+		skb_pull(skb, sizeof(rssi));
+
+		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
+				   ev->bdaddr_type, NULL, 0, rssi,
+				   ev->data, ev->length, false);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5669,15 +5686,31 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
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
@@ -5687,7 +5720,6 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
 		}
 
-		ptr += sizeof(*ev) + ev->length;
 	}
 
 	hci_dev_unlock(hdev);
@@ -5873,19 +5905,26 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
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

