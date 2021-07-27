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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53724C4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392A260FD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhG0Xvs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhG0Xvp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA720C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so7223234pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylIJAmp+yr1bvyYwwG8PQSq7oO8H0eUvt5uuIq7+q+4=;
        b=Oi5Ojwywb/uI7I2MdJPBNyXegskfjr58cAFmnL7qzzgLXUj6WfAyM5jyS53YduERYs
         5RciH5I8gw0wJW3hkagK44q0mV9TwArBNYEtiCPGhcdutnuG3jJMMIZZ/lqYDTkdeOiB
         qFydUwhRwphtXTLQ759ajUGZPl+J6u4OIk0e8+Czb5+ggefyavnKvPGEzKRox6NNNAv2
         Gp476CEEek5Y3hlYBBDkFQVEnYLJLeh9SYIfSfH86L6sddt4VHS8wau+4BMEMwU0M+RC
         jrCaHgSqPz0jsP7bR8zqsRzaN6trvkSRDUqAvIk59N9gRFi1uWjlh3IV/yKAvukar0yY
         AIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylIJAmp+yr1bvyYwwG8PQSq7oO8H0eUvt5uuIq7+q+4=;
        b=el6IIfa27lAnTKD1AmZZiC2oqLA/BAQL8o4HZ05oFXLx5T4FwxGroM3foToLjltOIW
         H7G4E9h2K93Q+F9Gs2lPmDDzB9xBL3CJHZerHCWqD6BB8SKQ1LobG0Hn8lbog7E7zsU0
         HLaM9PwreZPtRntnUsVp7ib/22rF7Dh2P9bQV3yLq2OULiC6KAoVGZ5CRzDxnPqObhRB
         G2DoJXwZwdCicHTGgx0Z0Yoo5mDCCwNxU4uME8ioTZZEEfi4PtlZdoij6yOgoV8RN/8c
         panOd3dtcwYw7PHiMEMc0v5Qr6WQjOTPmYMZpjLZt6Lx8Y7cFkveT3R+x5HesWmBqpzT
         B7/g==
X-Gm-Message-State: AOAM530c/8ITnZQtKh0ACkxWKbRxHOYHJflhDoiCZF0FPi1xJJkx8n4B
        PkNIl9n/c9DatXNqaPRGLm822cqljsw=
X-Google-Smtp-Source: ABdhPJwp3XIOG5Out2IzQUk0rJmFWo0d7PhN3F8EuFc8dNzt4NliRDhj7dCheDjuAVwLtIaiDFjKxw==
X-Received: by 2002:a17:902:e843:b029:129:acb4:2464 with SMTP id t3-20020a170902e843b0290129acb42464mr20736770plg.77.1627429904036;
        Tue, 27 Jul 2021 16:51:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:43 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 05/11] Bluetooth: btintel: Fix the first HCI command not work with ROM device.
Date:   Tue, 27 Jul 2021 16:51:21 -0700
Message-Id: <20210727235127.173149-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
index bf0ad05b80fe..65ecf2ae9a10 100644
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
index 4cd49a758bb0..28ad13d6c032 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_NEWGEN	0x2000000
 #define BTUSB_INTEL_COMBINED	0x4000000
+#define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -376,11 +377,14 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
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
@@ -4221,6 +4225,11 @@ static int btusb_probe(struct usb_interface *intf,
 
 	priv_size = 0;
 
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		/* Allocate extra space for Intel device */
+		priv_size += sizeof(struct btintel_data);
+	}
+
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
@@ -4315,6 +4324,9 @@ static int btusb_probe(struct usb_interface *intf,
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

