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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76AC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A1C610CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhHEAcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhHEAcm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC02C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so4969874plg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hznH/CMot1TF7yCOq6oKfFEBcsvccKj2eFwVYbI6ljA=;
        b=fgP2McRWHbTyzWpe5BTrMCAqcwi/Mx7g2rX4qYo2LzValA5ynBXobNC5jB2qOEAVYr
         ehpJI7kxdotNp9L3zY9F/vCCXKhTkQb5emOj+SdKip+horLXSIoHNH7F8Mgbj2rreLGB
         RfElhh936jE0jQKtGfqyUO4PfQbFfnKYT7RITCi/iDQA56MB35J+LFHkGGaenH5pxRTm
         /SRLuS2pK52eMOVOKGRLPkHLfv7UAp3ZokYqJvR5Vy/cMV08hfYEA2Spj4L7SDfNWmGr
         KP3+mgnaRPH1zUdN+9+lbAdpblUe4AVA9xUJ710SrnEJhHtQ2U9XfG5jmppn2DeobjXl
         yE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hznH/CMot1TF7yCOq6oKfFEBcsvccKj2eFwVYbI6ljA=;
        b=jaa8eAA78mTnBDDdRlM+3MLSkTVJ+1vg2dsC1pulZZ1X2YDqqAV8VSxVVCkPSU5F1d
         5aVVup5QEyCWBAh0eU4GQTzeYA1iMAMFXDuU01vdaJIswcl51+agjFWNd9wra/EqeTS4
         /SQ6PKljYBoatTkkU2MoWkE6PXvTiMvORSqkUK0LOH1B3z20MAdlwEHJCiYJ9mmygH93
         8Z1lw/cpL5U/SM1PDlHHJckZOmVtTLRdx3tyHx7oUwsaF5yrvdnxTjXHc3aDUL8jwGkB
         KiZmuH38fkVVpO/wipU+bewHFkhu/wppVh4XVutj9ylr7sKlQCtD9WoiIVCP0IBVFngi
         OB2w==
X-Gm-Message-State: AOAM530cXv0xSTh8ftL2B3IU7edOExPjBKETaoLEBpCDJAR5BoNcMB61
        bKV33nDRHCdPPSRSRZFZ5CTl+ha4SUM=
X-Google-Smtp-Source: ABdhPJyMpWvUqDx0cYbFZqwNvrPJPtApmDW4wtOdZZ1thTr/2Hgw62qsNI+8WZwkjiFd4F/LYtI1fg==
X-Received: by 2002:a62:92d7:0:b029:3c4:d123:928e with SMTP id o206-20020a6292d70000b02903c4d123928emr2042573pfd.43.1628123547718;
        Wed, 04 Aug 2021 17:32:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:27 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 05/12] Bluetooth: btintel: Fix the first HCI command not work with ROM device
Date:   Wed,  4 Aug 2021 17:32:12 -0700
Message-Id: <20210805003219.23221-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
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
index a6d75afad71b..8e6b497a2164 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1676,6 +1676,26 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
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
index 887b8839e4b2..3ed552d80b66 100644
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
@@ -4489,6 +4491,9 @@ static int btusb_probe(struct usb_interface *intf,
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

