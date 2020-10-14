Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE0C433E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5220848
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUlazri4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgJNM3B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgJNM3A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 08:29:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC80C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b193so1861304pga.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U0e2zJfxAy+N6g8dT+EzFbnTLYFfoLlNMU4TMWAIKds=;
        b=DUlazri44jf1wHHSa6Gkz9xtu31zeHJJDVqOJp83RtbeYx+V96qdkqtXQkFxDP5Bjn
         LthdFWS7hCBZ6rFSiDjp5lkYFWR5s7Fub0GV84+JAR06vqRT8jHZP7rTupIFtfNkmiqZ
         pcWFCLbG36S97TQ2+d7oZZZQ1BfAFH05BGrho86li/4cqfAD2DVNP+roJhjrq0IdNqWv
         AvPnG4TXy65CUoEiI2kw1DkSQxNYYzmqZRfHn8BQf1Oqetopo63sGwywTLCO4eQD6PnD
         JxM9UXAM/iI2gyUFlwF28s8wwfRR3u/dmXpBpuWt1SpZ30OR6rmlpXzRB08YOqlxo3zk
         P0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U0e2zJfxAy+N6g8dT+EzFbnTLYFfoLlNMU4TMWAIKds=;
        b=rQNCGFQUMC9BIlEBJHg2udiMLUlbc90KPcfyaGZHATXtonyzutEGE/lly7SmVdbHIb
         wQS1x6ZoiUQhOoI2UIG2FieLrv9QoCDPwrvU+ooH8KJFKv/E7hR3auCLldsvYJQ7fdcm
         wFcl0gTzlM4lq2NUyLbUxlKxpHUzfFBA+gJ8PbjOjcnYqL5GVB6oGh6zELFuIGH8p2kk
         +LtFvPbHlG896XXXJ5cAWLPALUcdVLfsYU9mOkrsbQMSJdOamuoRAjLTy7IcSdDxOFmN
         FdJGxjO7pM5AZt1OpBa1EFEFcSHOM1GzZIwHAp89uaT9ydRKWAMQzrE1HGgu1Mgbr2Pq
         9i6g==
X-Gm-Message-State: AOAM530ZmhWQBJnEeKzT6/7/V3Hoa0fOO/Cdq/NmYtWOKiJZcVBYBAKG
        J7eW4KyJ2jEj9c1vUkWRscx7+nyjSvLocQ==
X-Google-Smtp-Source: ABdhPJyylXy6POj6B9NJ3zwNSMiRLOmuPOf5Z8dnkEO9Sb9GTdwBfSmPrFWoS7Raef1Ar7yncxcU+Q==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr3661801pgb.444.1602678539829;
        Wed, 14 Oct 2020 05:28:59 -0700 (PDT)
Received: from localhost.localdomain ([122.179.122.132])
        by smtp.gmail.com with ESMTPSA id r16sm2930000pjo.19.2020.10.14.05.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:28:59 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v7 2/4] Bluetooth: btusb: Define a function to construct firmware filename
Date:   Wed, 14 Oct 2020 17:58:35 +0530
Message-Id: <1602678517-9912-2-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
References: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a new function to construct firmware/ddc filename for new
generation Intel controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btintel.h |  6 ++++++
 drivers/bluetooth/btusb.c   | 19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 09346ae..c4e28a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,12 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
+#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
+#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2e40885..ac532dd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2360,6 +2360,21 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 	return true;
 }
 
+static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
+						 char *fw_name, size_t len,
+						 const char *suffix)
+{
+	/* The firmware file name for new generation controllers will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
+		 suffix);
+}
+
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
 					 struct intel_version *ver,
 					 struct intel_boot_params *params,
@@ -2783,8 +2798,8 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	/* TODO: Insert function call here to get the ddc file name */
-
+	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
+					     "ddc");
 	/* Once the device is running in operational mode, it needs to
 	 * apply the device configuration (DDC) parameters.
 	 *
-- 
2.7.4

