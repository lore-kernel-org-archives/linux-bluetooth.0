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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30566C43214
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B5C60F01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhG2SgN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhG2SgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB06C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k1so7967397plt.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BHK4SMA5g7lw+4R7VnAnyAVNTQ59XS1l2K1IxoToIg=;
        b=r2bN/isn86V5BgeZdM4T6NbqJeLq1/YoO7p3uwfRdBarTxS5ExJyt2fnaHtiXDP5ON
         qloUuZmcuu4v5EUPlUQL4u41zyon0SxfYV+kfuruZz8msDi6cNPqCiD3KcxTx2I9hwno
         aXCmqQDqkTLK7bzfNK5/OqU2SxG7hp/03t7KwxmfmTZdfFx2TBgrRUJe8tsdm88NKbjj
         e49wXHEVU2QCQwngqAEAYULZs06HvZTQ9TMuN8rLxVqNGAXcZ0t89Cy+CrMEVucA1j4U
         vu5YT9fA/re0zm/DGvJtRmxzhVynej6rlz3JwZQmj4DA1EHuFHYAaHN60jl1FBt9bGWN
         V7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BHK4SMA5g7lw+4R7VnAnyAVNTQ59XS1l2K1IxoToIg=;
        b=P/Pq9o7OXRtl6YFytn71w45Eq1bgTSwQRs1Lp5JnM3AF1/gB23Lnkg0uOL94dblcbu
         BreKCiWJSjqyItlHCwjShRMopM53yNUEvwsmHKdmDQVxOoRwgCmrgzYGzva9cxWtmXao
         XEh1SQSJ/C7pKI0+gbUbSaYPbI85P/Xo3LdHn9NfVDpVdgjhj/HLnBslGU2Ky11L5ISP
         ZHWO2SWr5ZuoFfoeO7uuoolCf+9LazbAK1DwJFW8TZjIN1qQG7iglNqZig6ig5F1bUHd
         vqDOq/QGLvExedVVADoGbtStU9BJUdMXZljjMggJBq5mnp4Og/7gor47DUE64M4k3no9
         9lww==
X-Gm-Message-State: AOAM530YJqkKS2Y2tTLZviKuq2TdhC2bSGsFN/Hvoufb2JLYQwQ+4xrQ
        WPOZIHLEQEE75CZNYbCtreZEbmejhwE=
X-Google-Smtp-Source: ABdhPJxQNeqo+z8fEax7ZvkkJmIfnKckJZdNfmS65KgVfAH2hKqMAJdgzGIEBfOaamca3GKnXFgl1A==
X-Received: by 2002:aa7:9086:0:b029:39b:6377:17c1 with SMTP id i6-20020aa790860000b029039b637717c1mr6446244pfa.11.1627583768881;
        Thu, 29 Jul 2021 11:36:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 05/11] Bluetooth: btintel: Fix the first HCI command not work with ROM device
Date:   Thu, 29 Jul 2021 11:35:54 -0700
Message-Id: <20210729183600.281586-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
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
index 8c54ab03ee63..a64473c525eb 100644
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
2.25.1

