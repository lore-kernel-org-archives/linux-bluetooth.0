Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jan 2022 21:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiADVAz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiADVAy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jan 2022 16:00:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34549C061761
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jan 2022 13:00:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso981560pje.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jan 2022 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VZWY56Xt6CKt+/kdJXdBXHceV4AOU3kE15D/bE9RgY=;
        b=Ug5cAojzB+oRt0shFd/TgTQEDFU6S85VY483/prXj67kHa3/nqGtLzY31FhW8l1oCd
         NsJFk47mGetpaboBy9nJTEzrwoqBhWJ2+s3nHjhI/9SDFs5UDuTeNIFnp0IWDf6z7IJf
         OuyWFLzsiFnR/Cpr2CxAhBVsWzUrIn75z+Yw47tLoWJXjl9SaiXxSw9mmsxeDkcohhld
         uDowpbO7RjqAW1ADcBF+V518C1kxti9ENW6z8hvPMeeDP+3ZUJc2Ps3GB2DSDrL3cnls
         Vue2bC7gJTuq3J2njv9qKDswAiC1wTbfjt5TCTOUUsbzdrmbMKvorys5/0JyKHxU9tsi
         6dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3VZWY56Xt6CKt+/kdJXdBXHceV4AOU3kE15D/bE9RgY=;
        b=p90+79U7dtmPlgaMv2j5E0Tu4QjOjDwC1/TUKdSH7IcQLB1jqSLXQPqoDJdYOiatH7
         SS9yICeBdnpV3t1JSgBO/FCU26R+PX1bpE4fyE1RXIAXvvsEibgtWhiSdzSxVSo1aY1P
         JicQ3GJSTp/G0y7bcbK0K5n7pFUv3FeQ0/A0i2LKZujNgyaiJqK1q5pxJTbkIhD2L9Nf
         PVx82UE2EzM6CS0luA+FfnFebG7CRnEFd3glrTemzktMDpRrfhTGwQbzsst8yqc+FZNB
         ddI/PXKiEFxClxnqsF55uj/yAdryLCp1oXR4EXxnD13w4J+4MCSxXY0CxyjAV+M7XwxV
         BSCQ==
X-Gm-Message-State: AOAM532AyHGNAXDpAJ/STskmkYwYWZBwmvFChUY//VSl3Skyd3tZRfYM
        BkuN9MeRQX4ORCZuSh9fPGkb6eyR2/s=
X-Google-Smtp-Source: ABdhPJxHcVuoDNHn6NDiPCkhtnqk1TNQ+YoT3BEzsyz58lEtJMuuHL3X1GECWuA7+kgKXlGsKq7Nfg==
X-Received: by 2002:a17:902:6b0a:b0:149:9fb2:8631 with SMTP id o10-20020a1709026b0a00b001499fb28631mr26097711plk.73.1641330053386;
        Tue, 04 Jan 2022 13:00:53 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b6sm218948pjk.29.2022.01.04.13.00.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 13:00:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_event: Rework hci_inquiry_result_with_rssi_evt
Date:   Tue,  4 Jan 2022 13:00:51 -0800
Message-Id: <20220104210051.2982871-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework the handling of hci_inquiry_result_with_rssi_evt to not use
a union to represent the different inquiry responses.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  6 +-----
 net/bluetooth/hci_event.c   | 19 +++++++++----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e2b06bb79e2e..35c073d44ec5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2233,11 +2233,7 @@ struct inquiry_info_rssi_pscan {
 } __packed;
 struct hci_ev_inquiry_result_rssi {
 	__u8     num;
-	struct inquiry_info_rssi info[];
-} __packed;
-struct hci_ev_inquiry_result_rssi_pscan {
-	__u8     num;
-	struct inquiry_info_rssi_pscan info[];
+	__u8     data[];
 } __packed;
 
 #define HCI_EV_REMOTE_EXT_FEATURES	0x23
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1082b7c0218..fc30f4c03d29 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4507,16 +4507,13 @@ static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, void *data,
 static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 					     struct sk_buff *skb)
 {
-	union {
-		struct hci_ev_inquiry_result_rssi *res1;
-		struct hci_ev_inquiry_result_rssi_pscan *res2;
-	} *ev = edata;
+	struct hci_ev_inquiry_result_rssi *ev = edata;
 	struct inquiry_data data;
 	int i;
 
-	bt_dev_dbg(hdev, "num_rsp %d", ev->res1->num);
+	bt_dev_dbg(hdev, "num_rsp %d", ev->num);
 
-	if (!ev->res1->num)
+	if (!ev->num)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
@@ -4524,10 +4521,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 	hci_dev_lock(hdev);
 
-	if (skb->len == flex_array_size(ev, res2->info, ev->res2->num)) {
+	if (skb->len == array_size(ev->num,
+				   sizeof(struct inquiry_info_rssi_pscan))) {
 		struct inquiry_info_rssi_pscan *info;
 
-		for (i = 0; i < ev->res2->num; i++) {
+		for (i = 0; i < ev->num; i++) {
 			u32 flags;
 
 			info = hci_ev_skb_pull(hdev, skb,
@@ -4554,10 +4552,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 					  info->dev_class, info->rssi,
 					  flags, NULL, 0, NULL, 0);
 		}
-	} else if (skb->len == flex_array_size(ev, res1->info, ev->res1->num)) {
+	} else if (skb->len == array_size(ev->num,
+					  sizeof(struct inquiry_info_rssi))) {
 		struct inquiry_info_rssi *info;
 
-		for (i = 0; i < ev->res1->num; i++) {
+		for (i = 0; i < ev->num; i++) {
 			u32 flags;
 
 			info = hci_ev_skb_pull(hdev, skb,
-- 
2.33.1

