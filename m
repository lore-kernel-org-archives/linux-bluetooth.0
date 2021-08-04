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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEACFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3B6610FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhHDEkx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhHDEkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFBEC0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1823901pji.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcDVWmgpsQDZsXk+HDST9mB/mi6wxTRLYW/SvZIXL4I=;
        b=MeRSUV6RmI8J6fiJkr8lx099XzvxB8GIVgjhKXIBSDVaYdDHvrWiDCrTsIxH3oedhC
         whYxvqm/WxR/Ycim3koJNP0+URfNuHPlzUhljGTKEYOakQt0chkGpjwzLrNcFFzEINQ/
         u+RwKBNB2d5auot7arsOahwsNIKkZy8ZD9ninQt8RIzUIZlHRN0/xoggcVfSu4h9alp8
         zJ6NzEHKtNHx41pUs299Yx2mh3B6jO3nRJfP8lKpGTZJjP9ObHjfPwsBR7D0hfXMght/
         Q412XAgsj9vOGahneugXgspY/kMbqF8M5BVx+fAilf7gnrdHTIy9JYLtS/lBiut8E6YS
         zhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcDVWmgpsQDZsXk+HDST9mB/mi6wxTRLYW/SvZIXL4I=;
        b=Nwkhm0bLcwuFx/lJChb1NMZp84CCNcJ0qibxUhjpHWLPhHm3QmY0FmSP6tUlDtqTZD
         yEUHGRQOiKMSQq+UyozcduQZeJeZ5j7NM+aIlYKqJ/QaLT48lVpu2ca/tJSqXR21q6j7
         2rQZJisiJTZlgGEEPwfFUCaHUYGW5dWxWBPAiky0rn+wc3uTLVIaH14zZopCL4fPixr2
         Bgeb7+U/0URHrPjDzne+CuPUMNvzY+SLPGJhjsfHuHSgRMb1pmdoVTMRk0CNya4JAvfM
         rReNSsuSC9eDKw+kpUMRHRvuEPKMxYrvXy0Ju5BNs1OHPAoLqERcojif+3o1XLLAW6d4
         DUwQ==
X-Gm-Message-State: AOAM5308tpfdstl98WPLZ8XFdhSR5c+bMpisuP2xK2yTcHJV+mJyqLoX
        Trx6FRQHefBTCTtDYPM8rBgu+F7MezU=
X-Google-Smtp-Source: ABdhPJwCILCf9Xdk2a1L7yAYCPpdbuNiMtlR8f3+GYntJ7aMU6xK1O6im4TfLtsQbIrFR5g3TrYwJw==
X-Received: by 2002:a63:5259:: with SMTP id s25mr1004339pgl.397.1628052038940;
        Tue, 03 Aug 2021 21:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:37 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 01/12] Bluetooth: Add support hdev to allocate private data
Date:   Tue,  3 Aug 2021 21:40:21 -0700
Message-Id: <20210804044032.59729-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support hdev to allocate extra size for private data.
The size of private data is specified in the hdev_alloc_size(priv_size)
and the allocated buffer can be accessed with hci_get_priv(hdev).

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 include/net/bluetooth/hci_core.h | 13 ++++++++++++-
 net/bluetooth/hci_core.c         | 13 ++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4abe3c494002..faffa7bfd85e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1223,10 +1223,21 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
 	dev_set_drvdata(&hdev->dev, data);
 }
 
+static inline void *hci_get_priv(struct hci_dev *hdev)
+{
+	return (char *)hdev + sizeof(*hdev);
+}
+
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, u8 src_type);
 
-struct hci_dev *hci_alloc_dev(void);
+struct hci_dev *hci_alloc_dev_priv(int sizeof_priv);
+
+static inline struct hci_dev *hci_alloc_dev(void)
+{
+	return hci_alloc_dev_priv(0);
+}
+
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2b78e1336c53..cb2e9e513907 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3751,11 +3751,18 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 }
 
 /* Alloc HCI device */
-struct hci_dev *hci_alloc_dev(void)
+struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 {
 	struct hci_dev *hdev;
+	unsigned int alloc_size;
 
-	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	alloc_size = sizeof(*hdev);
+	if (sizeof_priv) {
+		/* Fixme: May need ALIGN-ment? */
+		alloc_size += sizeof_priv;
+	}
+
+	hdev = kzalloc(alloc_size, GFP_KERNEL);
 	if (!hdev)
 		return NULL;
 
@@ -3869,7 +3876,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	return hdev;
 }
-EXPORT_SYMBOL(hci_alloc_dev);
+EXPORT_SYMBOL(hci_alloc_dev_priv);
 
 /* Free HCI device */
 void hci_free_dev(struct hci_dev *hdev)
-- 
2.25.1

