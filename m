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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D181AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EB0610FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbhHDElE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhHDEk7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC88C0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so1926587pjd.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCQCFZypUADyI+Udwui6E+ECa9VmRhuQmOWlz8VAMX4=;
        b=WegkuV3d2CIy8kLVxAf23qt5AZmzsWoR1kwmiL63C+YgIZSf9dxpgnrg66Puzr4j2t
         306aBFbEf19bGgNFdm4NYIy/wIFRYr8NoWEAlzgvbEmoZDtBqLRRBVhSpRgYho4/IK/v
         w3F8qGrhZpkj6Avn5/yzsZKOzfLQ6OZ/QV28Ua49MwwUSUaH6dxL976iArAUto5WYzIs
         dWe/Cbz4dKRIAGrmOSxuRgaGKRsxjkbQxKa0VC+rmhPNlBOesG1LSyb/7amg7k3og/3n
         dUiRviM1qweWFgKb5J6HfYuinnjdXA1GxR0mmIVOzA/e0QusguMFZMUdKKCmp4zdd20x
         uiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCQCFZypUADyI+Udwui6E+ECa9VmRhuQmOWlz8VAMX4=;
        b=RMbDQBvaFNcJDE8ymF9AVCNIC6+ZWyZGIec5SX+tM/Jw44kiDV4PaYc46Vblqmx4dI
         f2316yV6H5U2mdx33zj3UJFoSoHXUJBd2AgXG2VD7M4tGv+2H+82wz6VpRLCsacILt9X
         fU8tcaHjF7pYlHLhmziKAEPsabGKAz8UvJtez5wlH8dOOwsmo79O5/qm4L+LW2/c0c+L
         VDq4qBorHLEBl/s6vFNJD64SDyJR50GN7UgFbwVHlo+Emaxqgd00zlDnUXEREokVT1i7
         uPgXteilHOIyHRu0cbvOwMXV5BdXo0sZplb7D80d179ANjrqezLBEdYePk3FEGAWd/xC
         IAGw==
X-Gm-Message-State: AOAM532roZ2fekw2fawP4U9bpmuKEO/SrwLu1BhZa+cLr5qqLJkL77DH
        NkgYbBBfYcfo3qBGQeOT6+n/RMqSbHQ=
X-Google-Smtp-Source: ABdhPJyrtFOrBZabILpjpkCNMdF+6yooHUz4BRKE1vCHgYp5RzhbkaI1ARFEtgnAUoyOz/QsgkC7HA==
X-Received: by 2002:aa7:80d3:0:b029:347:820c:fbf with SMTP id a19-20020aa780d30000b0290347820c0fbfmr25884688pfn.73.1628052044872;
        Tue, 03 Aug 2021 21:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:43 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 05/12] Bluetooth: btintel: Fix the first HCI command not work with ROM device
Date:   Tue,  3 Aug 2021 21:40:25 -0700
Message-Id: <20210804044032.59729-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 20 ++++++++++++++++++++
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   |  7 ++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a4c8329a8945..2cf3cdf8f9cb 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1675,6 +1675,26 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	/* The some controllers have a bug with the first HCI command sent to it
+	 * returning number of completed commands as zero. This would stall the
+	 * command processing in the Bluetooth core.
+	 *
+	 * As a workaround, send HCI Reset command first which will reset the
+	 * number of completed commands and allow normal command processing
+	 * from now on.
+	 */
+	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
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
index fb5e73ef71eb..8a49795ad5af 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -144,6 +144,7 @@ enum {
 	INTEL_FIRMWARE_LOADED,
 	INTEL_FIRMWARE_FAILED,
 	INTEL_BOOTING,
+	INTEL_BROKEN_INITIAL_NCMD,
 
 	__INTEL_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 53216274764a..f4b631673e89 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -61,6 +61,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_NEWGEN	0x2000000
+#define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -372,7 +373,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
-	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
@@ -4335,6 +4337,9 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
+			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.25.1

