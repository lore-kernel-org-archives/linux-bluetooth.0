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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25773C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE4760EBB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhHDElF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhHDElA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA5C061798
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q2so1635839plr.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B25hHem+W7ZHvQjo+S7Hu9HsGQC1G+4tTx8YyYIVy2E=;
        b=HXZiEmvDoOQcIJKaj0Whg2SAKAcr86C4aWNfHyFoq2YP8sNZVdsR7wAWokfxvktmIK
         DMofhNqgpjKsGus0Pid6PRYheoB/98hGpkwGFN41JOUe1BajwvUu0iZ4smqkja8gzJOe
         z7tV6D6Uj+DYArVoO+LMzQBM5Sf3dyEQaLdH7llyJNUsFrLPPNt+Xg0nk0RBJxyxiGNu
         WzUpvtuMKY6B2SK1nktBSCamGFuokKb+6pB82RHV98W5hNSBOk9GoPOt8VF4+5JVrlY5
         cZ02JW35SMNiqKi++s7G5GUAnVMG0F6nldHhzrC0L1KBayeMkhqS2W/wEGYx/R4zscZO
         ZK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B25hHem+W7ZHvQjo+S7Hu9HsGQC1G+4tTx8YyYIVy2E=;
        b=Uk6ymcuy9oYMvroa0cHPcyrvrK//aXKYO/Vc1EWKy3a+cWNo6dDcLdbDHXYRgb64ZW
         UpCCK8+KCN0o5Tf7VkUOyHx589+sj30kfki0lxzW3SoJEkn8vHYE+z80Tip0Vs1+cWxo
         HYFatXYSqsButFWIpTI7P0VUG+ZbWtrBdVV51RrUNswZoaWWMmOuUALOg/Kqnu3m02FB
         2PmzWcaJbgsfZfKv5SeDpBVfFlB6Fj58fQqmK4NxxfZ3MDl6m0UPhNooUz1uohCH20lT
         nChYzRC11otD+8nLqJ8UtBG3xhULHqYvg3KL8YlJXwCY2xgsybK9ONpZjxrF+vhhGaKZ
         7C/Q==
X-Gm-Message-State: AOAM5323x4TdxnD2PcmSzRKLkPh4QRM6fXBK69NEM1KZVShQ7W9yKuSm
        EqclYUrHu+6I617dYlcKKP9ByRXoV/M=
X-Google-Smtp-Source: ABdhPJzHQbvVHgs0iFYPdZNDUvN4uMC+AH0nYhvQJ5kLxOWiM2ll1/YSIWgQdli+JZkdq4Q1nvT7zg==
X-Received: by 2002:a05:6a00:2490:b029:3bb:2cb3:25dc with SMTP id c16-20020a056a002490b02903bb2cb325dcmr15558705pfv.48.1628052046868;
        Tue, 03 Aug 2021 21:40:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 06/12] Bluetooth: btintel: Fix the LED is not turning off immediately
Date:   Tue,  3 Aug 2021 21:40:26 -0700
Message-Id: <20210804044032.59729-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
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
index 2cf3cdf8f9cb..0d3893d135f1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1736,6 +1736,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
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
@@ -1780,6 +1787,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 static int btintel_shutdown_combined(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	/* Send HCI Reset to the controller to stop any BT activity which
 	 * were triggered. This will help to save power and maintain the
@@ -1792,6 +1800,21 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
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

