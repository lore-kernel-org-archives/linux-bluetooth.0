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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2AEC33CB6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D89B2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWX8cunq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAOGgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38657 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgAOGgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so7722092pgm.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=kWX8cunqK4t6fy0USiiEPa+TN0DWfEv7m/qEeEGZJxSe2mbghuEnP3ynB36Yb1n8lq
         n9MWZNXu+vQj0ccHMBFXsF9Ox+dzH2NHUlrDOLQ+4Ey6nxbGW34Pp9oqpM3oEqL3NJXz
         AUlTVwSSb1jV5TvDt7fkTY/yzTnp5oZ3Ktd4EyCHDzk0CUsIw4IIzzIg3AzQxfAw8r9+
         0+AFwOf1i5xESJIxNGWvFjd/cJkXUgcAjZLW4wgiKk0QeG1c2BCdFK7ki8TG88ZTTApN
         nKzu6cjQSI9Y/B7DrMFdq+oClK95lGlcDlxW4BRWjMZcpAlqoXKs7v4RM2j/liGMbVsK
         hpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHqSmS/H24jXyYIiH8Dw8BZO8Ld4AD9qcBK9/ryLFo=;
        b=S2tnefdutJFCA8q8v1jUnhpNSnMeB2wDTrm9569oe1xIbiaIIxZf/xCwMCsI3/2fWz
         ChmN8Ml8HExZMBX5NIQ9lkK1yt9vrAO3mRFlSbdiNsfmKQx5D11E0VQHb2gPN6rOVYzQ
         vpaBNfbFJim0/ETFRXUYb7dGod7ticxV22s9uAr89ogchOXdkAA2WYStHT4HzAl2Rjzo
         LkyIPwKOZk/ffli/zP7Umf25LRd5U0q6Lba4tQ4/8xy6bGhczeUEeIGI2wgApUqICXUp
         w47c/Cb/BQlauJ8kGDJuwZOywZDBXQh52uKtWmHmfvLxCto12Rp+U+tcq/QKL2RrsF7v
         3v3g==
X-Gm-Message-State: APjAAAUxSwGXnhzb83pk0B1ocjbdXaA7hBk7UNu4pw35cSfiDmrEGV7X
        5Xnv6cp09kajXpGfUaxMkIirD7IJRH4=
X-Google-Smtp-Source: APXvYqyUGQO8g1U9W1zf7MRECpOTgRyNcUybVOld2Ag5+FQ2ospD4mNuQ5WBUOYuszB6pd2vfNCohg==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr32232721pgs.167.1579070201341;
        Tue, 14 Jan 2020 22:36:41 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 06/11] Bluetooth: hci_vhci: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:36:28 -0800
Message-Id: <20200115063633.32441-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
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

