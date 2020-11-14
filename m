Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C04C63697
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EC32225D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGrHIHvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKNAoj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKNAoj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 19:44:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E2DC0617A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:44:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so1647701pgg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eIG3Dtm+IGdbq9IpvOcpsuoDuBMCpe0wqe/XI6Qb70g=;
        b=nGrHIHvm28wHs5syCH4lIzdwTF3tF4fBsX1walKVDFUF8hO8VQ5ikuQQGBw91BTYC7
         l9ckQyOW2dxWfzBKLCe2xp9K/uwn57ZkcBN/SynVPONdVmmGx9NglikHIJQuYwb/KsAx
         OTORptiq3oEhkb8I0MffLatIrI1gKHW0YQSXfSjvdakCbbubzFAsJc2vDZNLVdVIsOY+
         By/YTRsb0sS1rzZ3LQ8M81behIsVYnmUsDszC1fTUWloZledi/ifUrt3rIYKkKh95oIN
         8lx8LIF+fEGbhuBo6RNaS7+7z3dZtR2tCR4QV9tLbQHlQj2j5oys3ptWjq3CevJe40Js
         WODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIG3Dtm+IGdbq9IpvOcpsuoDuBMCpe0wqe/XI6Qb70g=;
        b=IPWcZ45kTKZkf98UHHJIVGbSdE4cfmw8l7kwVGVjiuB+Na8pr8g0ohrp/i8qGzGktU
         OmoRq9jlFsNH+Mh0i0rwv+Wvpb6/q0SaFyOLPbpCvJCQhQ4eSqUXhyfLvove/OmNS9+l
         RpgHPFHD8jNxZVhWOBI3Kfzup4j+s/cInfhVRwoKDctns650InZ+iDI6lUSDurox9fZF
         p3OFPonx/dPO45qEia++VNzBrnIdSncfeMLBHzXEMg79x8TBYKyEIq7rvs9lJ1p/SlPZ
         Lwql1yAiOvcKipI+N9LarLe88q5COZ3JWCntMPfQhpuiYkZC+/DmqdPzVctcM9Mub12u
         7nTw==
X-Gm-Message-State: AOAM531vLzTufn22rQkscyteoha9LNKpE94V8GNWRZQitZ+Qn4G0joG3
        79BXaZo1zz1fcoiTNtzEUDxQo5cK1N4=
X-Google-Smtp-Source: ABdhPJy98dkiusnd5NLA4sg+4/55Wv2ympxsu7vg3N9vpnY/uZoxP2KPFgBkqj4CwyxddJEV2yHbHg==
X-Received: by 2002:aa7:8c12:0:b029:18b:9939:9798 with SMTP id c18-20020aa78c120000b029018b99399798mr4207333pfd.44.1605314677028;
        Fri, 13 Nov 2020 16:44:37 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r12sm10710637pfh.213.2020.11.13.16.44.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:44:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Rename get_adv_instance_scan_rsp
Date:   Fri, 13 Nov 2020 16:44:34 -0800
Message-Id: <20201114004434.3852104-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201114004434.3852104-1-luiz.dentz@gmail.com>
References: <20201114004434.3852104-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames get_adv_instance_scan_rsp to adv_instance_is_scannable and
make it return a bool since it was not actually properly return the size
of the scan response as one could expect.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index bd67c80347cf..d7429f02d50d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1040,23 +1040,23 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 			   own_addr_type, filter_policy, addr_resolv);
 }
 
-static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
+static bool adv_instance_is_scannable(struct hci_dev *hdev, u8 instance)
 {
 	struct adv_info *adv_instance;
 
 	/* Instance 0x00 always set local name */
 	if (instance == 0x00)
-		return 1;
+		return true;
 
 	adv_instance = hci_find_adv_instance(hdev, instance);
 	if (!adv_instance)
-		return 0;
+		return false;
 
 	if (adv_instance->flags & MGMT_ADV_FLAG_APPEARANCE ||
 	    adv_instance->flags & MGMT_ADV_FLAG_LOCAL_NAME)
-		return 1;
+		return true;
 
-	return adv_instance->scan_rsp_len;
+	return adv_instance->scan_rsp_len ? true : false;
 }
 
 static void hci_req_clear_event_filter(struct hci_request *req)
@@ -1301,23 +1301,9 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 	wake_up(&hdev->suspend_wait_q);
 }
 
-static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
+static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
 {
-	u8 instance = hdev->cur_adv_instance;
-	struct adv_info *adv_instance;
-
-	/* Instance 0x00 always set local name */
-	if (instance == 0x00)
-		return 1;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return 0;
-
-	/* TODO: Take into account the "appearance" and "local-name" flags here.
-	 * These are currently being ignored as they are not supported.
-	 */
-	return adv_instance->scan_rsp_len;
+	return adv_instance_is_scannable(hdev, hdev->cur_adv_instance);
 }
 
 void __hci_req_disable_advertising(struct hci_request *req)
@@ -1473,7 +1459,7 @@ void __hci_req_enable_advertising(struct hci_request *req)
 		adv_min_interval = hdev->le_adv_min_interval;
 		adv_max_interval = hdev->le_adv_max_interval;
 	} else {
-		if (get_cur_adv_instance_scan_rsp_len(hdev))
+		if (adv_cur_instance_is_scannable(hdev))
 			cp.type = LE_ADV_SCAN_IND;
 		else
 			cp.type = LE_ADV_NONCONN_IND;
@@ -2015,7 +2001,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
 		else
 			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	} else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
+	} else if (adv_instance_is_scannable(hdev, instance)) {
 		if (secondary_adv)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
 		else
-- 
2.26.2

