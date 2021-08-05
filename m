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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD59C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A8B610A8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHEAcr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhHEAcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3FC06179B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so6055328pjh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaycH7KRELuaxrANYSzy5y2MwgPvz/0da2BPly/aaX4=;
        b=ZFj+hox0Tt9nABAewFBTVTwgr/2HdiT1B8s6y00BCMuKUNR/MvIl9n1Cron16acemq
         bFVIVHiT6nrZOI7lSq42UH83DRMcc6HfJ4ngOs5RTy1vfJDGyPOPl6eAeUPyaNBYXV6i
         UYrFKIC4y9nHem32rnQIbcF6OmGELuiAlYwxw6PBO5ikTuvnCj6Ft1WWG5DtS0inA29P
         HBV7GT6OL2foDmLGusVHjo+MUn0JcTMunAMKjJqXUo+pr+ugZTE5nI9LS3yjsaXReEiz
         Iszc9JJa4s3SO9RYbkb+2jFQjptlb0P7tMrSBLt+F4IcLJNkwc2A949nCAZiXULPWX4/
         LaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaycH7KRELuaxrANYSzy5y2MwgPvz/0da2BPly/aaX4=;
        b=H3/YIL5aPd1ePsrSdS9OAmfKmOeXr9jpqfzLmCU6OLXga/0zquvVTU3+dX1JidgxY8
         ZV7wZHf7VOBTfwZXhqHI9R4MG57Pp8DLfXfCbgnPzI9aoHfMC7aB/4JGVerjdfaUxJX/
         enY95jcUseDze8rG6E8LHz5ypY9u59o1S3D+doVh/8X5oH/mCJ60rhUTyJCUBWVniokq
         VF7XRCBmT6RJD1J/4qxmm3azyrPE85kGgfcmp8WKoPMFdwYbsyveLOf9/A2EVomUYQSm
         G6y9os9vM9eYn8VLXdOdcIJTXd2+jy+Dp5GULeOgp54OxGz7/neQbHSo+jtMzwXsGDHa
         WwSA==
X-Gm-Message-State: AOAM533zeF06IgSjOMYKyV7Y9YTfU/yfqM2402oCZtYUiLNlzUSSKFud
        TrYIByA0R+pC/RedwJ9JWkqbGS/skOU=
X-Google-Smtp-Source: ABdhPJzGJISuFk9XLpB0TVeHt4+3IxVIhagSFLC9O8kyaNBZTm4QUa+ZVTaiu85HGangS8djnBr90Q==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr1729091pjp.121.1628123550623;
        Wed, 04 Aug 2021 17:32:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:30 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 09/12] Bluetooth: btintel: Move hci quirks to setup routine
Date:   Wed,  4 Aug 2021 17:32:16 -0700
Message-Id: <20210805003219.23221-10-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch moves the hci quirks for Intel devices into the setup
routines and cleaned up the driver flags.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c   | 31 ++++++++-----------------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8593b27b7c4a..421357831f3d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2223,6 +2223,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
+	/* Apply the common HCI quirks for Intel device */
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
@@ -2245,6 +2250,15 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			/* Legacy ROM product */
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY);
 
+			/* Apply the device specific HCI quirks
+			 *
+			 * WBS for SdP - SdP and Stp have a same hw_varaint but
+			 * different fw_variant
+			 */
+			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+					&hdev->quirks);
+
 			/* These devices have an issue with LED which doesn't
 			 * go off immediately during shutdown. Set the flag
 			 * here to send the LED OFF command during shutdown.
@@ -2259,6 +2273,18 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
 		case 0x14:      /* CcP */
+			/* Apply the device specific HCI quirks
+			 *
+			 * All Legacy bootloader devices support WBS
+			 */
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+				&hdev->quirks);
+
+			/* Valid LE States quirk for JfP/ThP familiy */
+			if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
+				set_bit(HCI_QUIRK_VALID_LE_STATES,
+					&hdev->quirks);
+
 			err = btintel_bootloader_setup(hdev, &ver);
 			break;
 		default:
@@ -2298,6 +2324,16 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
+		/* Apply the device specific HCI quirks for TLV based devices
+		 *
+		 * All TLV based devices support WBS
+		 */
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+		/* Valid LE States quirk for GfP */
+		if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		break;
 	default:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 26863d8c1337..a97af4ef6bc4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -358,29 +358,18 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
-	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
-	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH},
-	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
-	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -3821,10 +3810,6 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 	}
-- 
2.25.1

