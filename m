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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972FC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24326023B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhG2SgK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhG2SgK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB55C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so7954652plr.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRBu23cC05oZC7YzojFP1u2rrtum1yT82Z4h3SR/m6Y=;
        b=Av3uuB19nThx4B6LOebg8oU1GlQ50FzRWCuU0o7/gN4n1FLr2s5vCqPzm9mRIM+Cro
         4x8i2poglTTdPrFzt24wgIH548pHb/TBZrz4RKAR1vkXPPhk2bNS2PUQAVIwD7MP9U7o
         sMSyRpVifchUdeY3dJuwOdvS7AjsKdB3JrlTIPw9IYwSp/5ncj5obSViCsLeg8LwqaZJ
         AFzAngcX8EcgZVo6sKNlJn9vX9ziGafjGyzC3FuzApUuw4FpDVFV3eGkojgNSxGhqbJC
         XOPbCHcGV9GWThMo4IsHfs9PSVxdYG87e5zxhRWoP2A1i5QHOufRdev/qO/eveT1RwW8
         LFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRBu23cC05oZC7YzojFP1u2rrtum1yT82Z4h3SR/m6Y=;
        b=ucdg/0aSLhycI76xGuI/2pUakLrODgCYiGmIctogYGIjN4zaG9kwfdFrDclJQGdmgC
         0TatmVVggcMbd6aexn0aZUtrRkhuaTJKVPfZwn6OeclXtKrrq/XKm0w3NESNl4TcinVe
         6HKQaty+pxOWImEamgZtovXkdwse/OeRTP+RmGHdfcwmHwCRyZry2maD4Z0LGFxtZ079
         TXw5GvRtZbAfOKPKEbFaUyAGTqukceHr48XyHAG05S0f5DTnEPN5SvMYmcpaMuhOhPdG
         SmDzY+I6jqkjOTpNl5f9+//jIujWz0w7CdQg/mQIHFfKvE0505Mla0/Sv3H/0A+udnWN
         EAWw==
X-Gm-Message-State: AOAM531kesYlaDk0SN5aE81bcyoz5FHBW6oxvQY4EfMrl7fQGNA4L0bM
        3ay/x+3RrglD6QhxgKuEHSer2fSbEIk=
X-Google-Smtp-Source: ABdhPJxpQLfFQh2RCiDVb+TB7EZRsOdqt1nAXRxuax6y7+M0D4k6M0oxADSeN4FGtR7/IjnVUqBikQ==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr1122357pgl.350.1627583765277;
        Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:04 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 01/11] Bluetooth: Add support hdev to allocate private data
Date:   Thu, 29 Jul 2021 11:35:50 -0700
Message-Id: <20210729183600.281586-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
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
index a53e94459ecd..7ef0e5644e87 100644
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
index 2560ed2f144d..ae6f5f26db6a 100644
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

