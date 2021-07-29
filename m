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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F0C43214
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E11D60F01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhG2SgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhG2SgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8DC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so17019527pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeH+jiMRxeNApAVqurgXh8QcDnXO8n9TaNOfyAwz1WY=;
        b=ndGcrdfSEzkz1+ZDCwF7kg9NgaM0x3a8CeBEYnNf8qYcU3pcL9i7A1v5KOBLFDYwjz
         woGaA4Zo/AS6hhDDyFxrVe3a7uthowGdp0vrIs2ErVFsc1/1bZIifzbMbv3zu96IZSk7
         +snvZrSfNO5vLwxK8PkrfqzGkcQTGtjxs+XEHXW/I8hNqY0z1PEq0NHLTYUmsiDkU/be
         FzkjAfzimrJ9M+ta3lZcNJ3R4A5Oz7fxPNNyifd5FpW00YRW179tNtfIufsARFmESEEo
         qUL7o0HYgUj1TcQDTfVO9Jm1JcpdanZe29FNzTD2o9WxFbkybK2qvA8sIyNOVyR8c1jU
         SYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeH+jiMRxeNApAVqurgXh8QcDnXO8n9TaNOfyAwz1WY=;
        b=EUAaOYdSbUuoUQsvceKiweJFPQjCG2wUdRf/jz+gz8+lqOe3K3lXMfzLqjGYxT69/p
         DfwtKqeX2o1iJXdQjLUe1AAHls3zc3qDg/mI2etuKpiaqz2xenrzK31W7Wqpiprb+4OF
         WmcGEkzbuHR6aYkf/X5hWBpgVUIeoow2yQM/iAuUs/ZlFGIH4Dlv/gJZI5KGs4808fpo
         LuHHuzPWTdIZYq0Jxo7lIip0cIZU+pSEoNYgsEpuYrmn6a0Vl2Is+XXo14J6Z6pUvcAn
         ZxFBiXLCSVI38PeYC2sPI4AX1Ic4922GCbyaHAjHIh9gA7TaFDUQMYzmzrqarABhHCaK
         wY2w==
X-Gm-Message-State: AOAM530Kn4zAGcUVn9O6dbti0woBACiAuzpgaqS2uXnYliqqz+Dt00PO
        Tvx1z3BtKmoO0w9GJiIXwR8oFbM/ko8=
X-Google-Smtp-Source: ABdhPJy+eRCZ6TEC6g8OGHg38DL3arTI4pMPI8Af2EIJ82xIJ6S1xQr/sqw2OcVsXlrBuvHcuuRbMA==
X-Received: by 2002:a05:6a00:704:b029:39e:3043:ec64 with SMTP id 4-20020a056a000704b029039e3043ec64mr6461611pfl.68.1627583774210;
        Thu, 29 Jul 2021 11:36:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:13 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 11/11] Bluetooth: btintel: Fix the legacy bootloader returns tlv based version
Date:   Thu, 29 Jul 2021 11:36:00 -0700
Message-Id: <20210729183600.281586-12-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

From the ThP, it supports both old and TLV based HCI_Intel_Read_Version
command after downloading the operational firmware.
Starting from th JfP, it supports both old and TLV based
HCI_Intel_Read_Version command in the operational firmware and it causes
the setup() uses the TLV based setup instead of legacy setup.

So, as a workaround, this patch checks the fw variant from the TLV based
version and it uses the legacy HCI_Intel_Read_Version command to get the
legacy version information and run the legacy bootloader setup with it.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 57b64d744f0a..f11882d10da7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2254,10 +2254,33 @@ int btintel_setup_combined(struct hci_dev *hdev)
 	/* For TLV type device, parse the tlv data */
 	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
 
+	/* Some legacy bootloader devices from JfP supports both old and TLV
+	 * based HCI_Intel_Read_Version command. But we don't want to use the
+	 * TLV based setup routines for those old bootloader device.
+	 * Also, it is not easy to convert TLV based version to the legacy
+	 * version format.
+	 *
+	 * So, as a workaround for those devices, use the legacy
+	 * HCI_Intel_Read_Version to get the version information and run the
+	 * legacy bootloader setup.
+	 */
+	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		err = btintel_read_version(hdev, &ver);
+		if (err)
+			return err;
+		return btintel_bootloader_setup(hdev, &ver);
+	default:
+		/* Nothing to do here */
+		break;
+	}
+
 	/* Display version information of TLV type */
 	btintel_version_info_tlv(hdev, &ver_tlv);
 
-	/* TODO: Need to filter the device for new generation */
 	err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 
 	return err;
-- 
2.25.1

