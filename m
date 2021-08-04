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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6878C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE616112F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhHDElG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhHDElB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E08AC0617A0
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1824331pji.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDsxWflQChbvAnucwQCPJ2BowmcJLb039CAcsL+Ixt0=;
        b=TaeO3etbU8IOwG7RZCWs6BlojXRtke7mDf8PhYwDbETrkt0XGQ0VIfLkgA5G7UoVDZ
         L5tdkif4Y0KTghiCsqqxvrOokV90ovxYLm+0Ddc1XAdK5wNgWOLKMvX209LvwYEFdm6c
         mm5zzlBD/gLDwmB6RP9r4ScgwJvSXy2KvqZiEUR5DmyM/aObDJlz5ALlb1QDcCKS5TeY
         CqikwOoyrGHaHNZt8FjidI5cynKT2gSlUobMyloP/hgjrUwCsb0laj922kkmKnnZZu4m
         L7rLxChk/paWPpWcxdJHhkjrydsHWFbKSIp25shjFjgD95Gjqppf1jHxssiddnWcJHtd
         H6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDsxWflQChbvAnucwQCPJ2BowmcJLb039CAcsL+Ixt0=;
        b=BoTP7o6gR6lIT/2+oecAXRrRhjoKgj9mY4O1t/DTSie6I5RFhswsstRFJ4v4sNLVwV
         NnAZDfuZKSv22+Z2vx6afzSB0sdLO7gngU/ETI6+OrX8OmEhA1NFeHlz0+y2HnWgzSJ1
         pBDZ2s8QuvfrGMWLz55rCKSun+6zHb+MeTQOABRoZHx12uL/U58J+GB/l3jTkRILCzCw
         bXm1HJqb3wYl3SkunH5XyZRZWxiDo24YM/AzaqYOHmPkh2TH0Qca0SwvGBNWQw+AzdQ2
         YKsZC8KCVlfXmsaiFgSGTWY8WrB6Mz4kg+InSSuVWcreU/lAi5BUzYmJu1W+vHqcFKsu
         xWNg==
X-Gm-Message-State: AOAM53028XWqRH3yGA5eiB0xElqUUxn/w1Tq7x7/kLEhG9p1hnTO07RT
        Q0xFw42iEyJU9qrJorjnki7lQDOds9k=
X-Google-Smtp-Source: ABdhPJw5rdMt8Fy2H9i6yAsoWXSMPksHVqiCVG+KEsfO4QMI6Qlua6+sJD1YfwoityD/j/uZaosGCw==
X-Received: by 2002:a17:90a:2882:: with SMTP id f2mr26781250pjd.102.1628052048812;
        Tue, 03 Aug 2021 21:40:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:47 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 07/12] Bluetooth: btintel: Add combined set_diag functions
Date:   Tue,  3 Aug 2021 21:40:27 -0700
Message-Id: <20210804044032.59729-8-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a combined set_diag functions.
It also changes the btintel_set_diag_mfg() to static since it is no
longer used by others.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btintel.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0d3893d135f1..31f68530323f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -181,6 +181,23 @@ static int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 	return ret;
 }
 
+static int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
+{
+	int ret;
+
+	/* Legacy ROM device needs to be in the manufacturer mode to apply
+	 * diagnostic setting
+	 *
+	 * This flag is set after reading the Intel version.
+	 */
+	if (btintel_test_flag(hdev, INTEL_ROM_LEGACY))
+		ret = btintel_set_diag_mfg(hdev, enable);
+	else
+		ret = btintel_set_diag(hdev, enable);
+
+	return ret;
+}
+
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
@@ -1736,6 +1753,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
+			btintel_set_flag(hdev, INTEL_ROM_LEGACY);
 
 			/* These devices have an issue with LED which doesn't
 			 * go off immediately during shutdown. Set the flag
@@ -1823,7 +1841,7 @@ int btintel_configure_setup(struct hci_dev *hdev)
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
 	hdev->shutdown = btintel_shutdown_combined;
-	hdev->set_diag = btintel_set_diag_mfg;
+	hdev->set_diag = btintel_set_diag_combined;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 
 	return 0;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index aef04fa0e1ef..17cb62ac33f6 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -146,6 +146,7 @@ enum {
 	INTEL_BOOTING,
 	INTEL_BROKEN_INITIAL_NCMD,
 	INTEL_BROKEN_LED,
+	INTEL_ROM_LEGACY,
 
 	__INTEL_NUM_FLAGS,
 };
-- 
2.25.1

