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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4223660E93
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhGXGtu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhGXGtm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC7C061575
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso759426pjf.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCrpRmJT/KyYZHmTmn5ywUeXiLYiINnwUWDpxsHKBfc=;
        b=aszbt8K+3MuC1I2RgpRl8qBdK3BS9f+ZfHHDOLD/9Dyqwio56VNT5V1AB2p598zO/9
         auHv4SFILH5JZXoC3PWT1ONyOhRmb7xaYwPHlyuZpLdRj7kcrqNzfxygZ6/XIgvTc1Jw
         ZaSb9Zhw04/VYZkvf5Eo+ETyHFxMpnRRR9xozhG/gP1eOIV77NTLq/1Z15UjEXspdq7r
         X8tJQxNrFqNE0derSBQ47xdvCLPP8UvPahRyDPAcPQ6T3tYiJqNS5un/qPjElsfTl6bw
         fs+0nGg5jrXwjtf61kOPB23cElbS2dO6/b4Jy61ooFQjVUrgYRptzzIsAMyLXSHpFEIV
         tP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCrpRmJT/KyYZHmTmn5ywUeXiLYiINnwUWDpxsHKBfc=;
        b=Edv1Ct98OIpPHCdNZZDhE2fb6ckv8wGX6D5Jp33egnB+cbYOaYMiuAo2hNxiXCX4D4
         1UCY5+rFXqXbaW6PSJXvuLawCSg6ZacE9jlBqtPBgZ3cKT0NhZcHHXh7Zwst3vzIR0Jb
         3PonSBZFL9/EmcdZm0iypaR0Q5OGsvn7JZSlvpJQU41BjRTNAnJCSubkeno5EzwZhVJo
         86EXUvxjfCAwCl4IoxIPDMYcroBysM/IlgiowY6mVX0twpaWQ4it6ou457m+clkaIW1e
         mqDivRbzETMyuVFME8ornv4Erm2Em9yqcE1JH9iLlpfKqgH6m1PvY7qqQyisy11gLlQ1
         X+0A==
X-Gm-Message-State: AOAM5328vg2arM6bEAklJd+WkCwp6SJnVZ3x7kPQi97so4qUR1+XaaFA
        q3nytMMocUNBlewb53x26vrtEl5jZf8=
X-Google-Smtp-Source: ABdhPJxdquViqcb8MlZ7NnR2AFFyvjB7pVBwbnfBYHYvaGbDz6GoUCZFhFRRlHfCO8uqMtz8TxDTKg==
X-Received: by 2002:a17:902:9688:b029:129:183a:2a61 with SMTP id n8-20020a1709029688b0290129183a2a61mr6606050plp.27.1627111813965;
        Sat, 24 Jul 2021 00:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:13 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 5/9] Bluetooth: btintel: Fix the first HCI command not work with ROM device.
Date:   Sat, 24 Jul 2021 00:30:01 -0700
Message-Id: <20210724073005.714003-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210724073005.714003-1-hj.tedd.an@gmail.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The some legacy ROM controllers have a bug with the first HCI command
sent to it returning number of completed commands as zero, which would
stall the command processing in the Bluetooth core.

As a workaround, send HCI Rest command first which will reset the
controller to fix the issue.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 21 +++++++++++++++++++++
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   | 16 ++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5ad005dd6775..dd319306ebb0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1659,6 +1659,7 @@ static int btintel_legacy_rom_setup(struct hci_dev *hdev,
 
 int btintel_setup_combined(struct hci_dev *hdev)
 {
+	struct btintel_data *intel = hci_get_priv(hdev);
 	const u8 param[1] = { 0xFF };
 	struct intel_version ver;
 	struct intel_version_tlv ver_tlv;
@@ -1667,6 +1668,26 @@ int btintel_setup_combined(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	/* The some controllers have a bug with the first HCI command sent to it
+	 * returning number of completed commands as zero. This would stall the
+	 * command processing in the Bluetooth core.
+	 *
+	 * As a workaround, send HCI Reset command first which will reset the
+	 * number of completed commands and allow normal command processing
+	 * from now on.
+	 */
+	if (test_bit(INTEL_BROKEN_READ_VERSION, &intel->flags)) {
+		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			bt_dev_err(hdev,
+				   "sending initial HCI reset failed (%ld)",
+				   PTR_ERR(skb));
+			return PTR_ERR(skb);
+		}
+		kfree_skb(skb);
+	}
+
 	/* Starting from TyP device, the command parameter and response are
 	 * changed even though the OCF for HCI_Intel_Read_Version command
 	 * remains same. The legacy devices can handle even if the
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index df7aa30142b4..29b678364a79 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -143,6 +143,7 @@ struct intel_debug_features {
 #define INTEL_FIRMWARE_LOADED		2
 #define INTEL_FIRMWARE_FAILED		3
 #define INTEL_BOOTING			4
+#define INTEL_BROKEN_READ_VERSION	5
 
 struct btintel_data {
 	unsigned long flags;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1ad066ef06f7..53bfe831b7bc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_NEWGEN	0x2000000
 #define BTUSB_INTEL_COMBINED	0x4000000
+#define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -374,11 +375,14 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
-	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_READ_VERSION },
+	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_READ_VERSION },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_READ_VERSION |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH |
@@ -4206,6 +4210,11 @@ static int btusb_probe(struct usb_interface *intf,
 
 	priv_size = 0;
 
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		/* Allocate extra space for Intel device */
+		priv_size += sizeof(struct btintel_data);
+	}
+
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
@@ -4300,6 +4309,9 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		if (id->driver_info & BTUSB_INTEL_BROKEN_READ_VERSION)
+			btintel_set_flags(hdev, INTEL_BROKEN_READ_VERSION);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.26.3

