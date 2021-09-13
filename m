Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0E460FDA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 07:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhIMHaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhIMHaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 03:30:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB0C061760
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id n30so5274083pfq.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zCYdlsfppNPwVWp82IXgP0ehxEmeMjdmzKt1MZjwpc=;
        b=ZeEsB1XIs3wKP/Y06tvwmKpkvoqpXUDgLh+NB8aheVtSoCD0+c7ke5/nieY5wg7762
         yUn8jWrxLXlx7bYEIXgVtkuO/eUwATPTfTygZrDa9/ytM954YQLk5QQpA/Cu1rxcF1Lg
         XM+6fdhfKiXJ1qAXKo1TNiZvtctlLua6xUo6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zCYdlsfppNPwVWp82IXgP0ehxEmeMjdmzKt1MZjwpc=;
        b=4yQBOh5GR6/NBRwPOcIy0iXsJ8knkQMBdiBH+9rA0gxcWxV9AE86A1jTk4QpETCkq9
         hdFLlGk/kGj5EpbGxfdx4EIjNZ5hUcfh9NQeKGFm120+Wmil6UbliSDfaxla4hs0rsXm
         /V+sd7BQvAQcsHidkNDYDSD7Pl3LjFy6aCXUNyeAjdzD9GetFBqL0In9VDYvbzPqody9
         07k5gf3zVnx9ebLXkWeEw8UEXNG1waqCEGIpPoFACweAv01TsFWy0gn6wI1gmaGKlCJ7
         ClcnU/yII0ozf6CpTg8YSkq78m6ngK4AG5+CAsi7f8jJQqLRFk+ZKaKqBttWNL3XnLjx
         2FUg==
X-Gm-Message-State: AOAM533wKtEaKfZ9KRi+rccsTkrSXTSvAb91HGFu2Dfw3s2BCHapFEl9
        AUtMm+Pe2DdSG5xR6yGx0fcHA1P2PlMwQA==
X-Google-Smtp-Source: ABdhPJxmfuPOVwpj+1LU6eb8tITQ4Rtckdfl8xMmkt0+NTbLMm9QQ53x/9FBfReaGxRVW5kStaakxw==
X-Received: by 2002:a63:7112:: with SMTP id m18mr9993627pgc.93.1631518128727;
        Mon, 13 Sep 2021 00:28:48 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b418:a601:c444:4951])
        by smtp.gmail.com with ESMTPSA id g8sm5688019pfv.51.2021.09.13.00.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:28:48 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: btrtl: Set up Realtek 8822CE for Android BQR commands
Date:   Mon, 13 Sep 2021 15:28:38 +0800
Message-Id: <20210913152801.v3.3.Ic8dcac2622d16775748f9d36c0a5e893372aa48d@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch sets up Realtek 8822CE to support the Android BQR commands.

Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.

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
2.33.0.309.g3052b89438-goog

