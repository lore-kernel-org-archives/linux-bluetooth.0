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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3BC4332E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822AD64F37
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhCORk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhCORkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EEC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so9192858pjq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e70lSIRb0dkSAfm+z9VJYspUq20DcwQbKSU1L96T/aw=;
        b=K4GDuCZbE/QxDqB+mjFxKACX+IXweQazLAvCTMYObaXhzj0KWkA6XhKJxYtvmYb2d1
         vYHF/ft0ZCRI+6feUjAoeSKZ7tmtFKTE0nG68NwXZ7cYpoJbKfMR55xdepN6ZDc8vN/U
         JElkGyU7NVqEVOrURamWLlyIRCKCRlP+2cnCFHtjpbQRcZ0Ozv6poDWSCevOt/wt8Jy+
         nQrw1iYhYlCFj35T5rCl5Ehf/7ko6YWVpmWddTylJyFyCukimlHkoxZ1e8BdXGUz4aFI
         axcQkYd5fsHPMNRLaRqwpllLtnwwdDap+ZUvx6Y866It0AyU1RoKMHXl+K+4NqRRt93/
         V8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e70lSIRb0dkSAfm+z9VJYspUq20DcwQbKSU1L96T/aw=;
        b=BswCHL1vjnOBM+Y9TC9i5wFiLhqpmDaGdW20Z/J6NjOO/HanD6c+DWKU2WwP6nwVNS
         jQfzyrXYxfLU2idN5PmoXXPEt7XJa+ljs8xLm30z9F+FFBxchZSP6St9C7W49KxO2SJu
         wPNjbpP/f3FOZH1OpID8C93NWvhAEUC5r+tEZKsvLJDV/R2ufbEAotDCeDf0OZ9b+YRv
         utunAqbVHOgTQNMwEMsZeW8i1ztxdlaJSG01J/4lOXSqYc1KnJWeB9nb8TqS19Wmfe37
         VQJP3ODmRJ7bSIalhOH+sxqpRDcjLG3aUJkXqEWYisX8eZzINk7UraklSVBj6qD8cOyB
         NmiA==
X-Gm-Message-State: AOAM533EXSq+Kd/KLnNyjcCrVJ8BpnnPmijOOqWc2d8WjuMzQCB7fd5L
        oph38jdCryoW4vbomrHeUDdGXUop4SZrZQ==
X-Google-Smtp-Source: ABdhPJwEvUvYwsp1dCgIzTQ8C9+EF1LmyatZjcpLR9j97j9HJFN0i4VuebUoKbNBkCcllSQovQMoJg==
X-Received: by 2002:a17:902:bb83:b029:e5:dacc:9035 with SMTP id m3-20020a170902bb83b02900e5dacc9035mr12442993pls.80.1615830009921;
        Mon, 15 Mar 2021 10:40:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 7/9] Bluetooth: btintel: Reorganized bootloader mode tlv checks in intel_version_tlv parsing
Date:   Mon, 15 Mar 2021 10:40:00 -0700
Message-Id: <20210315174002.1778447-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btintel.h |  8 ++++----
 2 files changed, 21 insertions(+), 21 deletions(-)

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
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 7163170410a8..b34165a474c5 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -211,13 +211,13 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
-static inline void btintel_version_info(struct hci_dev *hdev,
-					struct intel_version *ver)
+static inline int btintel_version_info(struct hci_dev *hdev,
+				       struct intel_version *ver)
 {
 }
 
-static inline void btintel_version_info_tlv(struct hci_dev *hdev,
-					    struct intel_version_tlv *version)
+static inline int btintel_version_info_tlv(struct hci_dev *hdev,
+					   struct intel_version_tlv *version)
 {
 }
 
-- 
2.30.2

