Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F32C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B42C61078
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351430AbhIHLVP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351384AbhIHLVL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 07:21:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B84C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 04:20:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u1so1091394plq.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmk2a81JVl4SkAncwyxKrhCXZFyctOgBxo36TTei3kc=;
        b=AWG1220m9+DCOAGn5Ytl/f+I2ojC1KPGwYixzk2HOe/AqaVO3K9yqyNxd/B9HKWV1T
         du/mzJWSwa6TLuad+dcXAYyNHmm5m2yb6c95yjmS0YvspxMQORTQJrETXD3xiiEvEbf/
         zLBg0dbQfcSQv0JXkIwPxqWZKyMQpeM14Cxog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmk2a81JVl4SkAncwyxKrhCXZFyctOgBxo36TTei3kc=;
        b=HPrmHkKqgMP4vTtW6FJI288g3nn3LKQOLwXxv3oK7dMcKoaDRaXmXPR/Ke/NPi0OVS
         9Tn+BciAYVSrz0tPaFPNX/5SMZsTplr7RlJoKZ2+jWKcCEgqR8aiyd1nMjRDmobNiy0w
         hZRJy485JmV0IQ4zTof0JUuOZ0QkRrFarnRCzv7HWwwapHnZAxs/KRQpZ1iemRXLgkp3
         cR3S5VY1GiMBYH9Wr+B3WcYSE0qb/H7dvKvsR6FtAQEf82mnI4J4wMNUMq3T/kmxNdC/
         JqWpzQqf12t1u0QIOHkWqL8NtxZNbqOH62uL7xAZ7Z+7ZMUzThRyHwhdSz9UF+Y9SxgX
         xe+g==
X-Gm-Message-State: AOAM5327Ax1CwdyO+ISri6SVVSGmaLyKRuzp58Y5p+Y1BG+FdeBmfPCO
        4jEt+hWkqqJXqYuIt/jko5JnpsAQzitA9Q==
X-Google-Smtp-Source: ABdhPJxHbqzFAiURaotJ7J2wZ1NVUHXZuEv5T02En4QRCuPNLGNTg50874q3/ZcCbJ9rEkc5ktwr2w==
X-Received: by 2002:a17:902:b713:b0:132:5a48:18cb with SMTP id d19-20020a170902b71300b001325a4818cbmr2583683pls.50.1631100003426;
        Wed, 08 Sep 2021 04:20:03 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id v6sm2160881pjr.41.2021.09.08.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:20:03 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btrtl: Set up Realtek 8822CE for Android BQR commands
Date:   Wed,  8 Sep 2021 19:19:51 +0800
Message-Id: <20210908191915.v2.3.Ic8dcac2622d16775748f9d36c0a5e893372aa48d@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch sets up Realtek 8822CE to support the Android BQR commands.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- Fix the title

 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..e0bcdbe03eca 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "btrtl.h"
+#include "btandroid.h"
 
 #define VERSION "0.1"
 
@@ -740,12 +741,13 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	/* Enable central-peripheral role (able to create new connections with
 	 * an existing connection in slave role).
 	 */
-	/* Enable WBS supported for the specific Realtek devices. */
+	/* Enable WBS and quality report supported by the specific devices. */
 	switch (btrtl_dev->project_id) {
 	case CHIP_ID_8822C:
 	case CHIP_ID_8852A:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+		hdev->set_quality_report = btandroid_set_quality_report;
 		break;
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
-- 
2.33.0.153.gba50c8fa24-goog

