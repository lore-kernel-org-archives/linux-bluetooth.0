Return-Path: <SRS0=ohN3=NZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6590C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Nov 2018 06:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2D720854
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Nov 2018 06:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2D720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeKNQee (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:34:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:59166 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeKNQee (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Nov 2018 11:34:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 22:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,231,1539673200"; 
   d="scan'208";a="91909469"
Received: from ubuntu16.iind.intel.com ([10.224.186.218])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2018 22:32:42 -0800
From:   raghuram.hegde@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029
Date:   Wed, 14 Nov 2018 12:02:24 +0530
Message-Id: <1542177144-16173-1-git-send-email-raghuram.hegde@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Raghuram Hegde <raghuram.hegde@intel.com>

Include the new USB product ID for Intel Bluetooth device 22260
family (CcPeak)

The /sys/kernel/debug/usb/devices portion for this device is:

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0029 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7439a7eb50ac..1cd54e9228d3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -342,6 +342,7 @@ static const struct usb_device_id blacklist_table[] = {
	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },

	/* Intel Bluetooth devices */
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
@@ -2106,7 +2107,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
	case 0x11:	/* JfP */
	case 0x12:	/* ThP */
	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
+	case 0x14:	/* CcP */
		break;
	default:
		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
@@ -2200,7 +2201,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
	case 0x11:	/* JfP */
	case 0x12:	/* ThP */
	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
+	case 0x14:	/* CcP */
		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
			 le16_to_cpu(ver.hw_variant),
			 le16_to_cpu(ver.hw_revision),
@@ -2232,7 +2233,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
	case 0x11:	/* JfP */
	case 0x12:	/* ThP */
	case 0x13:	/* HrP */
-	case 0x14:	/* QnJ, IcP */
+	case 0x14:	/* CcP */
		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
			 le16_to_cpu(ver.hw_variant),
			 le16_to_cpu(ver.hw_revision),
--
2.7.4
