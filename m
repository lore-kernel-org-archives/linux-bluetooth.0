Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE72C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D8961165
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 08:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351228AbhIHIwv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351211AbhIHIws (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 04:52:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D8C061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 01:51:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y17so1337878pfl.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Sep 2021 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/jz9wO1SGt/hhEdg1yAC3RPmMu7W7zoLXVtu4Hp5Dg=;
        b=COln1LhUlpdbBNv7AiMt4WJskJaa/MnLPpGyV/sUrX7ef4Xoqvy0pw60LCloN+goca
         No+MlB7yV9b3cblusxeFl1+dumSB86tkFB+b4qGn9uWGJIPhU/te/y3omPv5wWgJ9yqH
         MEQA5+AYurrdFbWHe6vUJg+uFqee9QQP4Jvjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/jz9wO1SGt/hhEdg1yAC3RPmMu7W7zoLXVtu4Hp5Dg=;
        b=mnIvuke0+ITGnIxU5PY1eCtaXJ/3bpT20Tgcdqyges0iyoxDDETEiPTxaRJwWfhz6I
         HhePWND+TRlMRvcX0Tv8n0EpzbSiquC1zksPC7jrzsfuYD90TJUNZoxgzlCtzgSlud0y
         UjvyInDTnATZFrseczhaY9yqn65q+kiSRjYJRs7Xc7yG86M5dlrfWaLkZvuBiWnd4b7O
         gPs0c7wCTBxEFJimti0WJpnmIJR0m9WEds5p0yROikX3HMGZHWX7NxQEcwveIs1x9we+
         nAc5TvoH8t6RSOrgc9hCii8MkPmptQaG5p5njePHnON1/4a/t0OS23jGWe4U9sMzeoTy
         mrzg==
X-Gm-Message-State: AOAM532N5Z9blVu8/2zTr8f/Q1aPfS/1XNydzH1VYX3+RXIPlNl33ANZ
        5VVukVa7eHK/jdgnfMOp6oy6zCr8xg6M4Q==
X-Google-Smtp-Source: ABdhPJzxPQ9K0dGDUzSIQ1ned5DbSJP79RI/JGsFbp1BIxMp7ZGSwI+GCuyKPB5kCKlRWIXFLwtODw==
X-Received: by 2002:a05:6a00:a10:b0:412:448c:89c7 with SMTP id p16-20020a056a000a1000b00412448c89c7mr2549250pfh.83.1631091100780;
        Wed, 08 Sep 2021 01:51:40 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id i7sm2116694pgd.56.2021.09.08.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:51:40 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] CHROMIUM: drivers: bluetooth: set up Realtek 8822CE for Android BQR commands
Date:   Wed,  8 Sep 2021 16:51:19 +0800
Message-Id: <20210908165017.v1.3.Ic8dcac2622d16775748f9d36c0a5e893372aa48d@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch sets up Realtek 8822CE to support the Android BQR commands.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

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

