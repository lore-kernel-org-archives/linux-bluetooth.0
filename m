Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E3C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE861040
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhHEAcv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhHEAcr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE2C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so6084824pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXGfzjHBAiiw8W9hKA1qQJuiDfomAnsOYfqk32XU04U=;
        b=sutC7bmG4B+WHsO/KBS+NVAeibVe3iVwmt1t7vuacE6bhyqaQsfZlNQyvxWFGqO9en
         VxdJGB4zUtv3FvdgRaufIM1AlFv7tj72zLD751dFhfjunCFZ6BVi0rQKcautjNdP1muV
         +j4i4ZVu0sEdkpsLnE4RcxShCebfhilA0oclznSJF9KeH+lzp93rsCVl+6g2e7DlJrdK
         uxzFEM0d8dur8kZXBiZvvKPtnO7xwesUvbX8FID2fxdt66gVpOkGr+1BjqKoOY7RnA5X
         6kNxZ4GcPp30iO5EvMF7G3nhRWct5vl7E4sHBlL48i/1sCfnlKjwzODp/iJNvZFqb8RF
         DlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXGfzjHBAiiw8W9hKA1qQJuiDfomAnsOYfqk32XU04U=;
        b=TeirQsxdGFjPiBL7tAjJd67/R/NIaqh5c2D94FhNfB5jViknFfUIKMGfFFhPP4E7VC
         mFOJzKzYQRFBn3S6YwaM22ZRIS4qT0u/ArnPE2o4DOwoFF5cjKoH4XYBFN8T+OKt50F2
         uz4nlftlI97Q0PufcoJD1wSbFo/Jk9c+JMIiCLweuvFaF6YdqDJGyrPyIxD78ve/6Cc7
         s07ZOczuqFfg5Hal2xAxqQ+1jR1BQRnEdNUmMVfSgjOxYgeBO5DBsfNEEryIyYSGSVrU
         Ec1BHR+xNLfZ4Jx45XheaOte+4yhMIqPHEx5eRSzbccBXa/oJlYGHHiPNjRYeAb8nH5e
         ANVg==
X-Gm-Message-State: AOAM5327a/h27qHwcoaoV6NEUhkMqsYzIBqCFN7N+iDTY/vyLKg3EINb
        amiQ5Ovs2+uhTv1EyEW8UmeXIjPS8bE=
X-Google-Smtp-Source: ABdhPJwiHNC1UIJCZ7zuF/tG/w+lTpuWn9XGO2sTTbQqCwXer63JhEZ1H4qC+WQSyMykHJPPGU6ugA==
X-Received: by 2002:a17:90a:7884:: with SMTP id x4mr12778217pjk.53.1628123552840;
        Wed, 04 Aug 2021 17:32:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:32 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 12/12] Bluetooth: btintel: Combine setting up MSFT extension
Date:   Wed,  4 Aug 2021 17:32:19 -0700
Message-Id: <20210805003219.23221-13-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
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
index 2941d33d0bc2..f1705b46fc88 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1951,18 +1951,6 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
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
@@ -2166,6 +2154,28 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
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
@@ -2279,6 +2289,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 				set_bit(HCI_QUIRK_VALID_LE_STATES,
 					&hdev->quirks);
 
+			/* Setup MSFT Extension support */
+			btintel_set_msft_opcode(hdev, ver.hw_variant);
+
 			err = btintel_bootloader_setup(hdev, &ver);
 			break;
 		default:
@@ -2349,6 +2362,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
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

