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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B67C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C51E60F22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhG2SgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhG2SgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B7C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso17062015pjq.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3ymDP6+9U9Vsvpej7yDpJT4CaOVv4qezLUB+IS2PDY=;
        b=OenMCGayqSS6OJWvhU3DtFGyJi1Klov/oSwzmYdHcfn888bZtecJZ0OBtcVznNF5gP
         KFEQi1LLXe5Lu85FtpZD+bl7p/iXO+sOUc0iu9lvCCGX4+I9BzZb/FDOzOUe++0MhtuS
         iqI5ouS6Ky2XRbO3Qn88qBs3ekx6xJqp0UiMBZdW6NKKTI9GpzsQEK/4CZ8SsS+UCJgf
         uNeqAamhfSl3XZYqoSgUPVTMMes8tY9CPKwjQYnQojOO/SjUDk/RuNwcGvPw5jS1GK64
         Tzt5cAYupYkL4dQnEz0oBna1N8jIKn4rQDXddFkarealpJj4Jf0lQp0ok/E85t7GJsYT
         88Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3ymDP6+9U9Vsvpej7yDpJT4CaOVv4qezLUB+IS2PDY=;
        b=AWbCdbsAtMo8OR0vlD2EqCFMz2FiZBsKjJecdY1eTEKT58ekyerOzZL/BB3oVHodzi
         MnvEZ6TG6ZQHyey4SOC2SPDq/9sHB8yT99K8qFG+laBo2ynIxZEmROMTUKbziwc/3nhK
         0jX9YV6ekKQBIOF9WxJMSgZzcvwsz3KlrdWooGOo5JyBJ9draSoDjW5/m5B1pt/Jhlni
         JhCPPpKL8ajBFjbOiaFmoZxmVsX3f+QKWqLcrBLyrk1rTP/cwXrT4NTUKHa1o/bYxKmJ
         U/yGP3GRnbaoCzDoJSfQreZlTbEd3qIkifJX619/pb21tV8ouamDpquPHkKySgXONyoz
         lAHg==
X-Gm-Message-State: AOAM5336+CVEwys+lXIKQZ6mZ2A3/AoCzrAKgKrjaptsj4cX2ZhhvN//
        09trLU0J5TsPp0JKq+4PqkqgbQnPVks=
X-Google-Smtp-Source: ABdhPJxyDJ/cA5WaPIvwh48SrJLyLGxUvftrX0R2gKLDkA9LEIPD1BIXgASPFbvH9v8wDTb/5ipyYQ==
X-Received: by 2002:a17:902:bc82:b029:12b:a074:1fae with SMTP id bb2-20020a170902bc82b029012ba0741faemr5916830plb.29.1627583769694;
        Thu, 29 Jul 2021 11:36:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:09 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 06/11] Bluetooth: btintel: Fix the LED is not turning off immediately
Date:   Thu, 29 Jul 2021 11:35:55 -0700
Message-Id: <20210729183600.281586-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 17 +++++++++++++++++
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   | 11 +++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 65ecf2ae9a10..4e72d806387c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1757,7 +1757,9 @@ EXPORT_SYMBOL_GPL(btintel_setup_combined);
 
 int btintel_shutdown_combined(struct hci_dev *hdev)
 {
+	struct btintel_data *intel = hci_get_priv(hdev);
 	struct sk_buff *skb;
+	int ret;
 
 	/* Send HCI Reset to the controller to stop any BT activity which
 	 * were triggered. This will help to save power and maintain the
@@ -1770,6 +1772,21 @@ int btintel_shutdown_combined(struct hci_dev *hdev)
 	}
 	kfree_skb(skb);
 
+
+	/* Some platforms have an issue with BT LED when the interface is
+	 * down or BT radio is turned off, which takes 5 seconds to BT LED
+	 * goes off. This command turns off the BT LED immediately.
+	 */
+	if (test_bit(INTEL_BROKEN_LED, &intel->flags)) {
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
 EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 29b678364a79..4a35762c3220 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -144,6 +144,7 @@ struct intel_debug_features {
 #define INTEL_FIRMWARE_FAILED		3
 #define INTEL_BOOTING			4
 #define INTEL_BROKEN_READ_VERSION	5
+#define INTEL_BROKEN_LED		6
 
 struct btintel_data {
 	unsigned long flags;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a64473c525eb..8f87c600d026 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -63,6 +63,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NEWGEN	0x2000000
 #define BTUSB_INTEL_COMBINED	0x4000000
 #define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
+#define BTUSB_INTEL_BROKEN_LED	0x10000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -378,13 +379,16 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_INTEL_BROKEN_READ_VERSION },
+						     BTUSB_INTEL_BROKEN_READ_VERSION |
+						     BTUSB_INTEL_BROKEN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_INTEL_BROKEN_READ_VERSION },
+						     BTUSB_INTEL_BROKEN_READ_VERSION |
+						     BTUSB_INTEL_BROKEN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_READ_VERSION |
+						     BTUSB_INTEL_BROKEN_LED |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH |
@@ -4327,6 +4331,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_READ_VERSION)
 			btintel_set_flags(hdev, INTEL_BROKEN_READ_VERSION);
+
+		if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
+			btintel_set_flags(hdev, INTEL_BROKEN_LED);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.25.1

