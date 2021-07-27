Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F70CC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CF960FC0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhG0Xvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhG0Xvq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B53C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t21so428444plr.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6W6r/P4hJaZ5RSIDZqCKaCzrxnbkZ7j5E64mDodXO8=;
        b=qs3f2EnptgHUKryYPiZHd7Lhv48tEw5KLnuxWxHogw5IH5RPYcYEURIMwH2ebbLqu8
         wQVyhw4Nkc9LPreKRZSp4T7g62WxxnoyNOhdYaB0F9plR8kjVD4Xebs3f72YvJkt6t0C
         /UQNAwa1FwIMhvQfHDK/yk0dOylTDx+M98+X6f+xaUfYGgSxlKe9ClGituflOoOMlyfZ
         KOlLbFeGwcUAP4VRY/fW5OU4twom0OspRFpcWMFiij2SKafb3LXEqkeDEUFGMtiSU6pi
         0TwnFjNuoHEBjizZdiLe+8mWSLAWwbAc/slapPE4+mBz8rmL6sN8egQUEXOAvEIv2O44
         H7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6W6r/P4hJaZ5RSIDZqCKaCzrxnbkZ7j5E64mDodXO8=;
        b=l/PqvHEKypgkNhOoPqWqzjc7+Y5JyZPzvb3wggp2D5IxN/NqKAWlSXSdZ4a7K7SpVQ
         JZAYqQ+Rlvq90xlpBuOFAeYDWNJYFpv1Y5UQM0OTD+wfvubJD5tevBRRBy8lpSSM1fFg
         M1ckKklcN3h1r4bniZft9x2+F22r71Y4y1s39VaY5vkSojHF8JI1L27MXRBIaSXYxOW0
         Fq97VF/KAbvB8pu2ndQDAYpof9rRdsmoaexBotksGiX3ENDZ5FlIVRzKcucobhkUlwqY
         Vwx6Zd58OmIj22xLS/Cv+p9ZiUPbFalMMvNMIm8Jt5w7nNnzULKTsA4bgZBzntemrxgM
         f0pw==
X-Gm-Message-State: AOAM530zJX6hnI9U24LUMzD0U0sCzTjRwRYZWuiPBVT3Wa9P2PoNhGQm
        KuNab92WYJ3g6CdUjXd/IKT4IuGvBy0=
X-Google-Smtp-Source: ABdhPJx6XaNiMqyT9lF+StYGtjEBuBMBIkEJn0IqOIlr87hyOgXPTz3O6Skn2RHueUWMgFIv6NyNxw==
X-Received: by 2002:a17:90a:9314:: with SMTP id p20mr1930962pjo.87.1627429904812;
        Tue, 27 Jul 2021 16:51:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 06/11] Bluetooth: btintel: Fix the LED is not turning off immediately
Date:   Tue, 27 Jul 2021 16:51:22 -0700
Message-Id: <20210727235127.173149-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
index 28ad13d6c032..542fe0196ac7 100644
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
2.26.3

