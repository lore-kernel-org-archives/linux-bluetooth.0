Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04482C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22E92075B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PXHSe2o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGOZ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGOZ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 10:25:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7DC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 07:25:59 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id c11so4368918vkn.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnZmo5aG+HFBUgW4//dN6Ikyqu1siCQtSkjWOi1Ga3M=;
        b=PXHSe2o5AnxQyAW4UCumaLJKIam4lZWtyLZ4UTd2M+uCT+gHYhXezn1unoor3k1C9i
         Zfgl2ieFWcWFDiKr2Fi3ASvifvmq4y0JLH0n8nwOw3zlj3/hQSK+ohtQe+iVCHxqzM4N
         gJ6Jv0L91FFMvnY2lT6cRiV2Zi70pqOhAaHL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnZmo5aG+HFBUgW4//dN6Ikyqu1siCQtSkjWOi1Ga3M=;
        b=T9zBBF472fGYVJxauHnDIXlCzeCWV30ePA10YGEIpsu9kiKm1WT1aw0HBnX7dSsxRs
         79p7CsNpFxO0dPZXHkpyZHhBXviVAH4+CHPt5hDD3LfM133IhmBqXB8cJ8zHEMTKjih6
         kLlpmtkx9VwAG7meVkPhTzQua7DbgezGuQaHlD8UaoCclEBEnZU8c0Phfv6fWf/cpuln
         7NX4X46Hsd5V7PdRwVocSKDOyWD/igprf0erPjuRxD3hdiWImRPMcJkp1iTOa/0kNEJL
         INkS/k3Om3Y5gSDc2J7TmUeC3DLOO+o72uuEWKbj+kmNf/JTnmW7m8LyU2o109AcuaMc
         yPPQ==
X-Gm-Message-State: AOAM531MJ/1WyVMJn2RDhDBKxHluq+3orbnH7zQEu80+/TiaHEMFQEwa
        ZIzW5cFB8tHeHHn9OdPOypY75zLcV0c=
X-Google-Smtp-Source: ABdhPJxfI9Vq6m0Yt5DXVZfKb0xVna61RaM+8hRmvZwEcfK2Q6wY+q2zBYV7LjZcZ7ILE2ghxl3x9A==
X-Received: by 2002:a1f:7dc6:: with SMTP id y189mr25600159vkc.57.1594131957921;
        Tue, 07 Jul 2020 07:25:57 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id p2sm5104876uap.3.2020.07.07.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:25:57 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v4] Bluetooth: le_simult_central_peripheral experimental feature
Date:   Tue,  7 Jul 2020 14:25:55 +0000
Message-Id: <20200707142555.397598-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds an le_simult_central_peripheral features which allows a
clients to determine if the controller is able to support peripheral and
central connections separately and at the same time.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v4:
 - Wrapping the feature around an if (hdev) per Marcel's feedback.

Changes in v3:
 - Back to the original design of V1 and integrated Marcel's feedback.

Changes in v2:
 - Slight change of design based on offline feedback

 net/bluetooth/mgmt.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9b9728eeac..18a7ae9cb3b2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const u8 le_simult_central_peripheral[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[42];
+	char buf[44];
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
+	u32 flags;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -3766,7 +3773,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	if (!hdev) {
-		u32 flags = bt_dbg_get() ? BIT(0) : 0;
+		flags = bt_dbg_get() ? BIT(0) : 0;
 
 		memcpy(rp->features[idx].uuid, debug_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
@@ -3774,6 +3781,21 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (hdev) {
+		flags = 0;
+		memcpy(rp->features[idx].uuid, le_simult_central_peripheral,
+		       sizeof(le_simult_central_peripheral));
+
+		if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+		    (hdev->le_states[4] & 0x08) &&	/* Central */
+		    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
+		    (hdev->le_states[3] & 0x10)		/* Simultaneous */)
+			flags |= BIT(0);
+
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
-- 
2.27.0.212.ge8ba1cc988-goog

