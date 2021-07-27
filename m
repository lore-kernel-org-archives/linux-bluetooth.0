Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D3C43216
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D9760FD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0Xvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0Xvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A05C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k1so435861plt.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PffmxY3Txm8DGIrTncbEm9nKetf0x7Nku6FrCvIyZ88=;
        b=e2UeuhRxk67ni5dzkA3YzZuhVQY6AMEAWi+leVZDPQM7TnzZ/QDEOOKFGXP8VcaqyW
         PZWANhL2hpw+a3kd2WELyC1Hjz4lPaVYpnUu+TK7z7TLs3Lg5aCOj1XtNxc/AuD5qkmr
         pmj3sCwi9un7tDh4pHNI01d1BIHMetb9gMdEpmtefHkJcu6C3fporqyCoPvxnYPkPIjT
         5IhGNT6PU//B7Pc3S2iQrN56MkSGGtnq1zzU28ZsMll9e2RBEDBuiD3y/F3F+OYEBAxD
         SCfIX2iXJoGIcn+BD4xeRG5/sYChCm0KpufPFnrrxqIF26/k2WNa3lS8ZIAzqHrWq/I6
         BR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PffmxY3Txm8DGIrTncbEm9nKetf0x7Nku6FrCvIyZ88=;
        b=GNxFP0vhn5VE4XzJfbD+yFqfbOsxVqx8vrO7fHU7vfBF5nj9wobC9bG/bdY4jKYArX
         g7nJdK/fHtZZn0f+nBETfBVr368Idgm3XAwGt91Zm8jtnTEzFAbX2QofJmBy38+HrbUy
         TEDtkFIK0Ushy9QFTxE8PUvi1+p4H8UfdbA3q9QF3YeWDrx/5VJQuiWYWqiI/yqlbqKo
         ZZPZsMQY94AfctZrb1k1IHou75dY0NESlCZ+8NyO4XMRVaVn1Ka04igWvR2Y+zUQ2jNb
         K9zRSHHUhNgMc39f0FacW2j1ps9GxOo9kIA8EfWvlUqujLN7sTJf8oO1GS02zBbAbpaM
         wpRg==
X-Gm-Message-State: AOAM5327kqDGEcoay4w6H57LAha1Hi5jUwlmZKQmnCHPQhxCxk3QUR7t
        RnJ0czQ1LKIz/0H4Z8HPlFAbK426tFw=
X-Google-Smtp-Source: ABdhPJzD0A8zKMzfgUaD1kSwU6VF/QIoqXpjVuQWAG9LM52rTQ3IYirfLO6AjAQb+bhsu+5YS37NzA==
X-Received: by 2002:a17:902:c20c:b029:12a:edee:a7fa with SMTP id 12-20020a170902c20cb029012aedeea7famr21064839pll.2.1627429908487;
        Tue, 27 Jul 2021 16:51:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:48 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 11/11] Bluetooth: btintel: Fix the legacy bootloader returns tlv based version
Date:   Tue, 27 Jul 2021 16:51:27 -0700
Message-Id: <20210727235127.173149-12-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
index 57b64d744f0a..7bc9bb65a5be 100644
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
+	switch(INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
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
2.26.3

