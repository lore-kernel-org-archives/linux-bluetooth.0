Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F97C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77632224D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSKVDHeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgJSRZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 13:25:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 10:25:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so103920pll.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fov6eMvFBTzpPKVwDUsIN5W3nfPBM+wd92lRKNpimLY=;
        b=sSKVDHePjFgu9i4jc29FvUXStzBAPtchMcCE8P3KGL+OpwiN4QG8dv59YN5NIRtwP4
         QTvTiCBzRFhgZxE3Q29PxohPqYyRIbd07wsMujtlLhAaKNKvjt2nYesvI1Lhwa6eV20I
         qxPMYA5GZV3mQWraqrnwoI/uJe31m6R+gEg9CzYI6k5PwCOXeyaidPf/80T1EnU53kS9
         Tg014j/oGN7H9LH/ahTEXQ58xgp8hHzDyEU8vVkzs6ccfqv+LNSxTexvsk1mERX2G7nZ
         yv0Ejig/eudFncC9sINrstPIE8dlHuNcg9vvnze481oNWsGYgzOvP8TvdVQJK2bPUf3q
         k02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fov6eMvFBTzpPKVwDUsIN5W3nfPBM+wd92lRKNpimLY=;
        b=X7ulc+M9lenQOSH2g191NuppNVCh9hrisFY9LTKoKAQOUuQrckaRJiJs3G7Ubtp4XJ
         2m0gibPQZ4S10FdtFNHtP9pQK/REfDGwEHBo6/kOJDNoFluxxKIz2w4Sw9e1OlSFXHD5
         p+wLjkvBna7m5BNP/YU9VtmHPbW0epBDtfPEpyROXjD4sf5nuTPzAltpAlDpHwB7JIZm
         EPao7/cPgOjghFXb/C7DJLCnIplAAiamZSnXo4RKpgjwkTsjDKZ0sPqAqZhuAFq4Ehln
         8xsttf5Y+2/agehiT/Dy/JWGZRqSyLgkkN2AMT0RnI6zmds8X0aUjZoRyIm7ZfHKbjbZ
         R6aQ==
X-Gm-Message-State: AOAM533bn00N1cvYufp2QXspdiMzRI03RlOMTWNQkffRHwC1NeNY8/7b
        K2eOuowomIhMABjDJTJoRw1FDJmmmp8Obw==
X-Google-Smtp-Source: ABdhPJz5rTVA0au3OEaZWF6wu6IUkmfGRIvgQ5MvwAMIcAvnEIMgq9/HQCQB1Rm6DSFQmYeJcu2RMw==
X-Received: by 2002:a17:902:c3d4:b029:d3:df24:1619 with SMTP id j20-20020a170902c3d4b02900d3df241619mr797802plj.1.1603128331445;
        Mon, 19 Oct 2020 10:25:31 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h6sm370103pfk.212.2020.10.19.10.25.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:25:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Fix not checking advertisement bondaries
Date:   Mon, 19 Oct 2020 10:25:28 -0700
Message-Id: <20201019172529.1179996-1-luiz.dentz@gmail.com>
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
v2: Fixes rssi parsing.

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

