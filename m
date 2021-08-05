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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6AAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2982A610A8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHEAcu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhHEAcq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F21C06179E
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so11506599pjs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYMgVuv7CW+Mc+VoJ8WwPS8mpOyhR9syen+o/tmtWaw=;
        b=fUoiP/RlaxunQQRBHEcr7ai88hmpnV8lrZC8Vr+LiWYRHAKY/L8p/w5v2/Ix47PIm5
         r040whggAh49Bz1Wb621Z+YPIjdiXZuZDPR5c3KoyybUTRwUrV4iBf7mX20n/tLd9oIx
         S0DeQqa0kBfK9AJ8PCA+nX+z/uLnDL4efc02jyx4EjxF0hEr+hoboQyvueZqm308gUjJ
         6RsCWtPaZ/IwC/rdoL+0G/Bnl1pW/+8P3A/aqvG4gtDhEPCTkQKS18kcGVbq6yE7B/d4
         7ESPj3cWr+3bfHzxaoSVGW0btN3xWaNJaexeUz1TZqtAEyKNcOOmojkhQwH6LVB+Cdrg
         nsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYMgVuv7CW+Mc+VoJ8WwPS8mpOyhR9syen+o/tmtWaw=;
        b=pmo0ZSxzM6/ocG3HtgSNB9XLStsjD1sGFfuB5ee23mC1Lpf1qZgOMPemXuj1xT6X+F
         cbZHm5qXsEckMQKx354PVKni5rqqe2xPE1Hg9shavih1Yi7FQ2oegwreDKRmRijpYZ5m
         EVik/OSpS/+KnEVbkaWzl9pVl4XO5XG8qVnAhDeukj6ww0qid1VZJuf2NGPUtioQG/Bu
         i+8/QmmowPOenlEFqNvhXj9Fs7fVnoJ8+Gs26942Jhsg0wAL5TmqnMioom0OiTa2yEW6
         mY8qWYRg+uG7AKAf30233Za4zMEzrbdW5aILyJxJn21ON3uVEW3bwZtUKWMLtynIB7tW
         z4lQ==
X-Gm-Message-State: AOAM5339U/dJ2mHJYvYXBw0r3lKApX3aGAYrptHOe5ui4pEL88ZemNMm
        Js5wVsQw9zLFSjXw9QMCR9x47xRKrYE=
X-Google-Smtp-Source: ABdhPJwGo4abqt0EOebGMxDoXsDOXCa0/fpNG0Lw0xt0z6c06E5w0GsSORBxjC5//m/WsRsjC/Orig==
X-Received: by 2002:a65:6107:: with SMTP id z7mr118353pgu.43.1628123552075;
        Wed, 04 Aug 2021 17:32:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 11/12] Bluetooth: btintel: Fix the legacy bootloader returns tlv based version
Date:   Wed,  4 Aug 2021 17:32:18 -0700
Message-Id: <20210805003219.23221-12-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

From the ThP, it supports both legacy and TLV based HCI_Intel_Read_Version
command after downloading the operational firmware, and it causes the
driver to choose the wrong setup routines and missing firmware/ddc file.

So, as a workaround, this patch checks the fw variant from the TLV based
version, and if the device is legacy bootloader device, the legacy
HCI_Intel_Read_Version command is used to get the legacy version
information and run the legacy bootloader setup with it.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 4f0ba6031c57..2941d33d0bc2 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2312,6 +2312,27 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * along.
 	 */
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		/* Some legacy bootloader devices from JfP supports both old
+		 * and TLV based HCI_Intel_Read_Version command. But we don't
+		 * want to use the TLV based setup routines for those legacy
+		 * bootloader device.
+		 *
+		 * Also, it is not easy to convert TLV based version from the
+		 * legacy version format.
+		 *
+		 * So, as a workaround for those devices, use the legacy
+		 * HCI_Intel_Read_Version to get the version information and
+		 * run the legacy bootloader setup.
+		 */
+		err = btintel_read_version(hdev, &ver);
+		if (err)
+			return err;
+		err = btintel_bootloader_setup(hdev, &ver);
+		break;
 	case 0x17:
 	case 0x18:
 	case 0x19:
-- 
2.25.1

