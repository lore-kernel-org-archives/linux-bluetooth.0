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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563CAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D65B619DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhCWS7T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhCWS7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A4EC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b184so15277472pfa.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ut7jlS+PqFbwTOsiLm+t82r8Nt+s/HeE/xV+iBk2Vfs=;
        b=rH/XHSE1YwJRQ5Isl05asIeeCrMDzOnbihD17GdmfjlJefefHvROQPktOHTU82Uoqa
         C8qII05BZHOmlE6xV6HJ8WYG24QJRwvpSvWkjhyd+EEQ928RK5p7M90msioSctfLLuca
         PghNnD+oAfrISogC0Cep2DCbNFleUodmyDW5ujHNu6HCxXyZ1emUTqaoPtrO1ra3I6uK
         EIMDlaJQRrRMB57Akpp+VAO/WNSNchfqculAe5cJ7/54VC71odWXEH4xXiuoFlrPxZGu
         wBJn4AuWVf+ggQ5g0SEyA8zmUdRsugrnmaqcgfpuAw6jeWWx4i1fT8LygKZSMd5p7Q4x
         McGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut7jlS+PqFbwTOsiLm+t82r8Nt+s/HeE/xV+iBk2Vfs=;
        b=hyvkRBBe7Tig2LHoBXViZBlRcdoZhTKhSMcyQvyeHSNj78bLGaqJtl7ZaVbKolLHXy
         s3HX3B+mh/vD6xfsxJVywxEjhQ5zr5H2OyeoPMNtv2aKUAvijF3dGaP1QdcckdN5tN9N
         KDDW2wF0LTI9u3/aiXC8RydW2ySGVSIZfCKgn3bPtZdxwETO4fiBXNgdtmL1lGfu8rIU
         EVFkLWnxsxxpuRZkOqz5txtT0iqVw4u+EeGQgcPOf54MRGEqMrjxvxuIlo3cLHjSgijG
         PmE3O77kA8+cc3t4KChb+X5rtjCQwRfJZRT7aqPh1rKFWFoOyOe4wx6jUIKhJS/5uQAg
         XhIA==
X-Gm-Message-State: AOAM531C3Nuo42sP1WzjlKL84wKMeAnNoksXqmihkcD1oHjMLWN4o30Z
        7Os4PIKJK905zXsY2uUwXqkpqow5V7KBbA==
X-Google-Smtp-Source: ABdhPJwJYlUeUe3T+HgMP6muqrOHSPzIq3RqlZ7r3/biyiLogSk5xNghKTvPB16EC/fHm8+G+TWw7g==
X-Received: by 2002:a65:430b:: with SMTP id j11mr5395888pgq.143.1616525951318;
        Tue, 23 Mar 2021 11:59:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 7/9] Bluetooth: btintel: Reorganized bootloader mode tlv checks in intel_version_tlv parsing
Date:   Tue, 23 Mar 2021 11:59:02 -0700
Message-Id: <20210323185904.3372987-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Lokendra Singh <lokendra.singh@intel.com>

This moves limited_cce and sbe_type checks under bootloader during tlv parsing
as operational firmware don't have access to these values. Any attempt to read
such values in operational firmware will only fetch garbage data.

Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bddaa4f32566..4ddbf895c382 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -434,26 +434,26 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		return -EINVAL;
 	}
 
-	/* It is required that every single firmware fragment is acknowledged
-	 * with a command complete event. If the boot parameters indicate
-	 * that this bootloader does not send them, then abort the setup.
-	 */
-	if (version->limited_cce != 0x00) {
-		bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
-			   version->limited_cce);
-		return -EINVAL;
-	}
-
-	/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
-	if (version->sbe_type > 0x01) {
-		bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
-			   version->sbe_type);
-		return -EINVAL;
-	}
-
 	switch (version->img_type) {
 	case 0x01:
 		variant = "Bootloader";
+		/* It is required that every single firmware fragment is acknowledged
+		 * with a command complete event. If the boot parameters indicate
+		 * that this bootloader does not send them, then abort the setup.
+		 */
+		if (version->limited_cce != 0x00) {
+			bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
+				   version->limited_cce);
+			return -EINVAL;
+		}
+
+		/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
+		if (version->sbe_type > 0x01) {
+			bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
+				   version->sbe_type);
+			return -EINVAL;
+		}
+
 		bt_dev_info(hdev, "Device revision is %u", version->dev_rev_id);
 		bt_dev_info(hdev, "Secure boot is %s",
 			    version->secure_boot ? "enabled" : "disabled");
-- 
2.30.2

