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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD730C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C726D610CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhHEAcj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhHEAci (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639EC0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so6055027pjh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eotsLWc+Kd3aMTO7f8LyPFVIntd2RMJxjiOsBnNyIbU=;
        b=vN+dtrd5fQyzZlqsxR2vtSp+Odp9yxlCeI9dJ2QyFtdzGJZZUrlM26/xNFjUdfsJ6i
         UP4rf/2S1J9s0x2ke/kFK2NqVomSVtIMiTw2m0IarzEx3eHKxPFk9cPq6Aq3mJ/1p1uQ
         RLYFaKjjolrrQ4PVAiwWWCGBmtxtijkrBnDNl4x9XpClx1cNfgridzF0xv51beZNlvxi
         8KiQBxP26rLCtN7wu9cpgUZViCp7pX3V657vzUZbyKAUMSv0UDRna1KoS2ijg3sm08uw
         /Wn/IHvYkiIPZkGzKj9gNxITzEd4XbX9dVrjuFJpyMlFaSe31i6SgYBrqnQOwHTXWufr
         UtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eotsLWc+Kd3aMTO7f8LyPFVIntd2RMJxjiOsBnNyIbU=;
        b=RS8jDtqcrIVatszdRoW9lnLsaFhCIETTZRRK2P7xGZ+oW/c5loFq5KY8QCgCoDBPtI
         YVH0D1aaDefHCvD7YnfwMWmXCkbkBhoW+Qjk7CJopRe0WHPwBFUG3VRwysz5ApHSO4xo
         krB6kC5XEgj1B5e7MSZNW4nLMxTIfoL5FkVIC8O69X2IYyn5vPLDFYiaR0s4B/McmJ0U
         z9gcOtCUNgT9Ze7mpp8XMzvQ09u1Ifnblv1fQER4rvWlM9wFp+Ww3QGFOj5OPcT16Y7s
         2tHbR7/8iGgHjZRp7x939obC5hwOaxnDA8FxtD97YcmFKUhHgRt0I1jc33ZweymFKWrv
         a4OA==
X-Gm-Message-State: AOAM532L2565QrDuzUTDr3T2Gf9+TuqqA4cDm97hLyUGvc3+l2U+ObNl
        jR8fHqTf71CwNHNvoCnPywrxGFsqFu8=
X-Google-Smtp-Source: ABdhPJzzwqzz3hVOnd9m2RF2AHbqsZJHH16evYycnBlmF2B8n8aYXbvMiix5W2iIn+UxMRU5Q+DfQA==
X-Received: by 2002:a05:6a00:1311:b029:3b2:87fe:a598 with SMTP id j17-20020a056a001311b02903b287fea598mr2050251pfu.74.1628123543988;
        Wed, 04 Aug 2021 17:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:23 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 01/12] Bluetooth: Add support hdev to allocate private data
Date:   Wed,  4 Aug 2021 17:32:08 -0700
Message-Id: <20210805003219.23221-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
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
index b011eeea28c3..a7d06d7da602 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1224,10 +1224,21 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
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

