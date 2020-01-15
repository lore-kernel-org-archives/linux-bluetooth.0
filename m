Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F36AC33CB6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1484B2467A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug2gJ5Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAOGfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAOGfb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so7724263pga.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=Ug2gJ5LcCR7dPEsF7dv4zoHwKyM6XiA7+ncoojWdnFDXO/3NM9aHkN8Eja21BF7ukC
         IdUfQLp9X2b7dzvG1t1t51+iLubheWzJByRfbbaqLncwoKJStTMr4DHNtRl866HK0rEe
         WpcgnF9PXHYqhFZW1zpfZM7wVCfvAkannknI7oMFQnGo6OxN77IctWMX47Srdpo0qt10
         0+N6Zr8+uxbUzVMdf1MzLPwnMpKd4++LwUyeoq8ZW5p+iohxpQumRuamlzIguzrNByI3
         IQgjAWo6D9Z1P+xzCsCljuDsH0+14iQvjNVJxzFaJ5mr2EewN8D54qESnQCsLYyipPhr
         ORAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=iR+eKeUmc0u27/DoCmoW3izUjXeRW5z2t7R2WFYqrv0zgkH6uZGLfuxt/vZyUvyD9z
         9heLp2oVnMMWIlv+uOxwRJ71+nj0avzrqL2frpNj0xpBK+FKUIWfviTkhGZcZV2r+Gdz
         3VJryIYlKJ4aZkzDC0JNKL4r36jv5AHrhBDcknFIn66bahPd9oCNFCzk/KO5L+1cr7P5
         xLQ3+/rmxkNigt7RlqEPQ5o7DHYyNw/YkHAmVFhb7EmXXpgmS1bzzd/GO1Cb/PNW6DV7
         y27y3A2sD+yhtTU5l/5SjCXKlbh3oPlHTmknCLAtF2VdnjlhBcY2+judU5zl6jHOidlc
         28wg==
X-Gm-Message-State: APjAAAUKTUkMoGM3JiCrLFABwyA4GPmHrJb9FTbhRKk3X5QPUU4tWQhE
        BSkBktdtEZgfVdoIFxirgwJgA6WJ57I=
X-Google-Smtp-Source: APXvYqzBHNJN5svzgOI/UV5ylCnCc1iIRJgSr3uNduSzsTGmCVA+OSrSYLfYmmbAMMRkgVlv5cjsbA==
X-Received: by 2002:a62:7b54:: with SMTP id w81mr29822193pfc.127.1579070130195;
        Tue, 14 Jan 2020 22:35:30 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/8] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:35:13 -0800
Message-Id: <20200115063523.32127-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make virtual controllers to pass ISO packets around.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 65e41c1d760f..8ab26dec5f6e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -178,6 +178,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 	case HCI_EVENT_PKT:
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 		if (!data->hdev) {
 			kfree_skb(skb);
 			return -ENODEV;
-- 
2.21.0

