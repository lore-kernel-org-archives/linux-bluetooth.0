Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654DC4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A161037
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhHDElK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhHDElG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64FC061799
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a20so1734036plm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NIggNs3Eg4idwzvgRKIWjJRML9HmAHniutGAAAEf+64=;
        b=Dl6JwaG+kL4uc9Y8A3MvYFESjPT8IFPqaYLsL9EvTVYJmLNGyyMJf9UMAShl7SpA0l
         WBEicpLhXdfAPtOlbk2mw+OMcA/Eo6c1RtXhZGFWQvywy4YCNvitsb9MTlAKEA1zJxTr
         WCSku3IiWpCp42dwk+AUoB4K14L/wWDMbLL2HcY26ubmkv+nfqi34Ij6ZL1VTTK22DvZ
         0cnUb3JCWWZI36eL3sn/RAzb+CR0Gx8ayUrU2tvOzaanfuBYEOM8F9e9pOmvB2/dO/Or
         slO+pBgsm0RKzXo1vUbaasp2l7NpMQ5O1SWD64/p5vbut+vc1u1UMwjAVPlf4b0Z2OTd
         nVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NIggNs3Eg4idwzvgRKIWjJRML9HmAHniutGAAAEf+64=;
        b=KpnM3N6E3/LIg7WqoGLQ5TO0JcFUh9qwdJC2x1K3E6GzJvksl9jZb526KF+Ul0a5jj
         bs4DpuHDOW80RZSy2fhFHhd3Z1x1ha0GqFmu+hxcY5+az/uCNBYIYZKGG3tn708pf4qq
         fo80QwTpmUMygX1XFxT5HV2J6/vJUYr9e3D1aPcld++DoQ6TVRSlWnmBWOGV/7mIe9IM
         DpeKGI3RyUICN5HOjHGf02bR4cWIFNAlzXzenqiZFbekIssvTmVlaIOVXIcyP+P8+uoR
         DqEMNj/afyjumCcehaTx3xX/fIs/8+Y/bhQFlGv4i/mHnS0V6kNRW0pel5DU/yIVzbbn
         OfwA==
X-Gm-Message-State: AOAM533u5RowTweq0yo0A/xMrGRvT7vB+ky2Hg/uQ2j2w6x4Rmx4HEAe
        Ci+zvudQTgsJrif+ydg7IEjWQqz3rHQ=
X-Google-Smtp-Source: ABdhPJz25bVYKNEGQJbRMDA23O6u81lb7cNrH7wK0SlCA+mrYfioZUJSvP/bKclq9uwirHPxd0jq8w==
X-Received: by 2002:a62:2987:0:b029:338:c077:ba11 with SMTP id p129-20020a6229870000b0290338c077ba11mr25938175pfp.21.1628052053664;
        Tue, 03 Aug 2021 21:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:53 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 12/12] Bluetooth: btintel: Combine setting up MSFT extension
Date:   Tue,  3 Aug 2021 21:40:32 -0700
Message-Id: <20210804044032.59729-13-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch combines the setting up MSFT extension for the legacy and TLV
based bootloader into the common function based on hw_variant.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 41 ++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ba124a26e80c..98613122d539 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1950,18 +1950,6 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 	btintel_version_info(hdev, &new_ver);
 
 finish:
-	/* All Intel controllers that support the Microsoft vendor
-	 * extension are using 0xFC1E for VsMsftOpCode.
-	 */
-	switch (ver->hw_variant) {
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		hci_set_msft_opcode(hdev, 0xFC1E);
-		break;
-	}
-
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
 	 * does not enable any debugging related events.
@@ -2165,6 +2153,28 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	return 0;
 }
 
+static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
+{
+	switch (hw_variant) {
+	/* Legacy bootloader devices that supports MSFT Extension */
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+	/* All Intel new genration controllers support the Microsoft vendor
+	 * extension are using 0xFC1E for VsMsftOpCode.
+	 */
+	case 0x17:
+	case 0x18:
+	case 0x19:
+		hci_set_msft_opcode(hdev, 0xFC1E);
+		break;
+	default:
+		/* Not supported */
+		break;
+	}
+}
+
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -2278,6 +2288,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 				set_bit(HCI_QUIRK_VALID_LE_STATES,
 					&hdev->quirks);
 
+			/* Setup MSFT Extension support */
+			btintel_set_msft_opcode(hdev, ver.hw_variant);
+
 			err = btintel_bootloader_setup(hdev, &ver);
 			break;
 		default:
@@ -2347,6 +2360,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
 			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
+		/* Setup MSFT Extension support */
+		btintel_set_msft_opcode(hdev,
+					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		break;
 	default:
-- 
2.25.1

