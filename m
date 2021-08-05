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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316636104F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhHEAco (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhHEAcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1003C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u16so5016392ple.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cahrGMaPWpNbTUMEe/gJAsf9oILslRXsQ36He8t3GsI=;
        b=URWH71a6US5X6HsrXi09mVkD20sJC7Ibl0PldT0PC9/zpII+7Ju3bmL2JW9p00LvqX
         gwqV2x4mvGn5g+yO2YwWQ8aHM6pGKMboANFTyu7/9t6+yz2Y1fGS+Tv/lvbhVsdMA7R8
         sfuPi8hfiynX5bcXNBmXy8WSqW8Ll2wsZpExdyfCVrorvx3o9pHy5GQuQIx4JHcWoSrw
         /GQ3WvtR3ARg0/C/RpiRmPZwVnClzyp0eGDq5nwkfFwWF3qSnY0UOJv5H3YD7wXt3W+y
         uQNWLJpBQ1u5UA2iP2mkJofHhOXaMMLVw20L2RbSHWRPYBm6X9dFtupwAgLATfDgzipL
         jDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cahrGMaPWpNbTUMEe/gJAsf9oILslRXsQ36He8t3GsI=;
        b=P/FNQwT5ocjZZlriNcN1FM36M1gaNNMO4tIclhQPIPPH6VhoPUp5sCVl74cvIBz76g
         DYGZ0yEu0rLytvKa7OABDvKluWhLk2dsBIW3iSReBJAfMG1S+QO7USeooeO8t+BbTKbU
         OESJPxdFkLeBthHmRvrA1Htt9dxRnqGhz+YrnQgFkRlSuqRvE7cCPuafLMnQAU4vOXtd
         srgy916OR2JJTwO1WuvzyK2U3tRTB87zjg3qvk5FSJFL/njKPP/+mh1Sm351e7fsoS5k
         R+BebKoU791G/KG5Uoksszt8sQ3fgoJfnuRdWdRQl9rf4YzOSeFpcHP2gmcPaq2GG9Ez
         Nq9A==
X-Gm-Message-State: AOAM530g496DZ0mVPRb+s0RSELO0UcNfacM9EwCyucR7dTFLB+uG5czB
        F28qhuViiqUOHlvDrWrekthaQrYHNv4=
X-Google-Smtp-Source: ABdhPJz8wBs4ODxaNsaKDFgKbDqeFQHSHaIhX4u7sl1H8uWyiQhrzDFyHhPEfo5cemG5zRjuCCYo+Q==
X-Received: by 2002:a63:8948:: with SMTP id v69mr94377pgd.132.1628123548376;
        Wed, 04 Aug 2021 17:32:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:28 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 06/12] Bluetooth: btintel: Fix the LED is not turning off immediately
Date:   Wed,  4 Aug 2021 17:32:13 -0700
Message-Id: <20210805003219.23221-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Some platforms have an issue with BT LED when the interface is
down or BT radio is turned off, which takes 5 seconds to BT LED
goes off. This command turns off the BT LED immediately.

This patch sends the Intel vendor command to turn off the LED.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 23 +++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8e6b497a2164..fd947a8798a9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1737,6 +1737,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
+
+			/* These devices have an issue with LED which doesn't
+			 * go off immediately during shutdown. Set the flag
+			 * here to send the LED OFF command during shutdown.
+			 */
+			btintel_set_flag(hdev, INTEL_BROKEN_LED);
+
 			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
@@ -1785,6 +1792,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 static int btintel_shutdown_combined(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	/* Send HCI Reset to the controller to stop any BT activity which
 	 * were triggered. This will help to save power and maintain the
@@ -1797,6 +1805,21 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 	}
 	kfree_skb(skb);
 
+
+	/* Some platforms have an issue with BT LED when the interface is
+	 * down or BT radio is turned off, which takes 5 seconds to BT LED
+	 * goes off. This command turns off the BT LED immediately.
+	 */
+	if (btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
+		skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			ret = PTR_ERR(skb);
+			bt_dev_err(hdev, "turning off Intel device LED failed");
+			return ret;
+		}
+		kfree_skb(skb);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 8a49795ad5af..aef04fa0e1ef 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -145,6 +145,7 @@ enum {
 	INTEL_FIRMWARE_FAILED,
 	INTEL_BOOTING,
 	INTEL_BROKEN_INITIAL_NCMD,
+	INTEL_BROKEN_LED,
 
 	__INTEL_NUM_FLAGS,
 };
-- 
2.25.1

