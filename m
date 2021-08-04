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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346EC60EFD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhHDElJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhHDElF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518CC0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so6984375pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gK3KrDN+2OxfYaA9Sk2O2YIvZ84uImPWUbO7tldJ2Co=;
        b=n4ie0gtkauAYk9rE0CMmwrcNIk7DONDJ5dFRpW+ZgL3KwK3DjJnqv8JiCx8VAxg/lH
         BfoX/cNcA3OGB2TtybEsYEnf8ANwyxGPyDS7jtI2ubyf9Vbx5S3ebEQmhdUmznKz15t7
         HjVa1nmq8v3CUmCZAsLMg9GjU32GDiPWMhKEEueC/TYBS9HgoVWZBg4LPjKnu4PBW8ae
         eUGb1ETkZpg2rE0Q65aO5PwmWH4oZYOBYlGNOcyB842zwYAK18N5OG+fwK/xmJB4TICS
         itXGGlSd1k4MGodXCkeXnt4YzZs58vKs44KR/SN+kIOuJWTRf/jTApKv0azMMOJ/tgbO
         Dr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gK3KrDN+2OxfYaA9Sk2O2YIvZ84uImPWUbO7tldJ2Co=;
        b=Hn0C8mDoyAHhpr3lCpcCygJUipBlsCJGuhI4yZpz5hHk3/xJcFjR9kQGWQVzr3uhdW
         HA/aolvl/L4xlLPGi2Kf/oDcUu6mwDe4s2jQ1wBraMH1EqsjdOY86/SL6KsBpg/ujM5V
         cidYS+82ismShnMDbFToI9OeKjIYkfCUjGA6TruoK7prL2ugw+UfEJsqeHxPvfncLbdO
         JYQe3JfMwNd6NnY3y1tCF9vl/82K41r/WeKUSAFNysr1sZqb6G6bDej5/X4UvhPgLFy0
         ABKuPEMGsXI62OpGcB5ULkDtkFsrrBuCMoijHhLwTAGVZbB+UvQEBgFmP8lNRmJNldD2
         hrgA==
X-Gm-Message-State: AOAM5319GwcEFX/qB4HtsEOurQ44dc1YuwQpK6Hc/rySnokefYZAL45D
        kbYToj0l/TwoV37JQnnyOrmjKq4RFcU=
X-Google-Smtp-Source: ABdhPJyT3uHxo6zBYahbbC9tuqNjUqeo6rkPQBfmTHs78fq+B9n26R9RZ/CG7KXE1fEuHHVMLzLbUA==
X-Received: by 2002:a65:6487:: with SMTP id e7mr1626934pgv.27.1628052052866;
        Tue, 03 Aug 2021 21:40:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:51 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 11/12] Bluetooth: btintel: Fix the legacy bootloader returns tlv based version
Date:   Tue,  3 Aug 2021 21:40:31 -0700
Message-Id: <20210804044032.59729-12-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

From the ThP, it supports both legacy and TLV based HCI_Intel_Read_Version
command after downloading the operational firmware, and it causes the
driver to choose the wrong setup routines and missing firmware/ddc file.

So, as a workaround, this patch checks the fw variant from the TLV based
version, and if the device is legacy bootloader device, the legacy
HCI_Intel_Read_Version command is used to get the legacy version
information and run the legacy bootloader setup with it.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 57cbe8191524..ba124a26e80c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2313,6 +2313,27 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * along.
 	 */
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		/* Some legacy bootloader devices from JfP supports both old
+		 * and TLV based HCI_Intel_Read_Version command. But we don't
+		 * want to use the TLV based setup routines for those legacy
+		 * bootloader device.
+		 *
+		 * Also, it is not easy to convert TLV based version from the
+		 * legacy version format.
+		 *
+		 * So, as a workaround for those devices, use the legacy
+		 * HCI_Intel_Read_Version to get the version information and
+		 * run the legacy bootloader setup.
+		 */
+		err = btintel_read_version(hdev, &ver);
+		if (err)
+			return err;
+		err = btintel_bootloader_setup(hdev, &ver);
+		break;
 	case 0x17:
 	case 0x18:
 	case 0x19:
-- 
2.25.1

