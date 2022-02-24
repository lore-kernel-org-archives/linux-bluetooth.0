Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3318C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiBXAbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBXAbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:04 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022456E28F
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c1so289535pgk.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9Y5pgaVkXyazSAz0gklrbyoOTE7TwpdgHa0U0KeOhL0=;
        b=DIfpqa1brQh/XV0qXuGqXcKcqxDYhehyt91wLo4+DB2G7I3nm4hPfmNs/N1G3kOtVj
         TLyVZmaTQeQAdU1rhSEOhSTPR6TisxCQYLUtFhVN7ahNVlOI+nOarTqrKtJOS+da690T
         UEQt+gaLP28baM/FOcqZd1Sa8q9Z+s1xp9DyvL3dM5lVX9dEcMEcwJdGOoa20ftjtqry
         nlqm3QJtgCHO7757+ZY75t2nWB8n+krIMLn5eThpz8y/2wMU5qlQHryThzk8BbNaxK8q
         2xdYh0vf/bbpkfBVZo+ZK1wfDgIMj4cTYvgjxlm86AF7p6d+Gi3LoSn56mCfaMHhsB2U
         Ai8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Y5pgaVkXyazSAz0gklrbyoOTE7TwpdgHa0U0KeOhL0=;
        b=gaYTxK+CtLND7A5M2HV81D3NNd/lcLqvwUMvyNNoh9kKNojs86qjdtm7ZJvUlb+oWc
         rm5tPMCb88t2DWnFz6fhHWjyE/nSl2JUPcrO/kx4CMt95OUzObTjAdaEuSinEY8mzis3
         tz3yeVvoKEvl6hQ3drKl5rIo1lA095AIWZxTldkUPIMIG4GMKLm1CVwr8qifl5a5KmO7
         ogjBX5fSw8Nt8p3pMK58XouV1RVWryH5UcJhLWt4z1XO+1u2tou1GBkjXUrbTaYaZK3O
         9S6GC1EriXsTW8bgm7ZGPf2jsqrrATxn5aeGdHZ3oRpdd5GlmRBXb0IlnLwNX498JDE7
         wFMg==
X-Gm-Message-State: AOAM532OhsezJiWL6wlQeGgrUmSReaDmPSDsw3C+paRNzTtQHPSe0djT
        /ukuryFWkV25L0Bk/vJPFBSVWoEffqg=
X-Google-Smtp-Source: ABdhPJxFxgqxsqsIC3JqZvdPSsDLOH1aFHhgTtlwZoG+KUA2uoZAXaTG7aoFmjtZ/RKsWylJKNAQAg==
X-Received: by 2002:a62:1757:0:b0:4f3:9654:2815 with SMTP id 84-20020a621757000000b004f396542815mr45064pfx.52.1645662634211;
        Wed, 23 Feb 2022 16:30:34 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/11] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
Date:   Wed, 23 Feb 2022 16:30:22 -0800
Message-Id: <20220224003029.706163-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC.
---
 emulator/btdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 09101a5df..15689137c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5425,8 +5425,21 @@ static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the periodic advertising train corresponding to the Sync_Handle
+	 * parameter does not exist, then the Controller shall return the error
+	 * code Unknown Advertising Identifier (0x42).
+	 */
+	if (dev->le_periodic_sync_handle != SYC_HANDLE)
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+	else
+		dev->le_periodic_sync_handle = 0x0000;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC,
+					&status, sizeof(status));
+
+	return 0;
 }
 
 static int cmd_per_adv_add(struct btdev *dev, const void *data, uint8_t len)
-- 
2.35.1

