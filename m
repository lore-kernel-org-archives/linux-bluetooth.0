Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_HELO_IP_MISMATCH,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D713C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 00:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8120CC7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 00:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnE7+y+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbgFXA1f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbgFXA1f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 20:27:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E04C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 17:27:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so3313435wmn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BFY+YndMAghTEmlFUiu1ILe1qKf5M8PgPZFK/r+KZgY=;
        b=RnE7+y+Z9QpzevggTi6Aen7lQlEdHnSOD4zaGg8KkwKphq5RK1yksz6PsbTUL0idVx
         4r/43jPqIvbb+IJ49b1wgjLJ34PewT0N4yDGjFBLVb3DwBXXxme+B/AGTBg3jPfuVTGC
         kGKAnQp/LnTKs3hMxSwcBsYMoct10t+h1I9dOBL37Kw2HjMFPzdKqs9O/wjifjxvORX9
         TOhDE6NWd+xqqqXS67q7KTCzI589F3GR5bkKXsr2yUDs8HwlU2VS/Wa31m+dvb8/qjVx
         qLjJhqSKqxSRn2wrJQIjsCi/VVsyEVdrzvoEPuf6gXcoXiUDwdNB9DsQqJcDXFinscnp
         uImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BFY+YndMAghTEmlFUiu1ILe1qKf5M8PgPZFK/r+KZgY=;
        b=F2Gvyg1HVizmFy/0SbtCBw+GgXWw/TxbZxZLRu0oZYVq/9fhG2TRK47xSMmviP6na8
         neTgkcajuPvTgAxLO6H2SWqq8n8nNHT01VV05AenepMYrorvs6n0KjeOGuZjyZVz2nx/
         mX9fGBfH2FQKiXrQmRUd5XUPLx5ZLA9qvAECrwDrOrbp6Ac4/uxOTLvGlLxArjQqtoQn
         5an1D0/kHiZHNqzoTnZviiij+EL1J26MzYeFHnSladE2InCl7V2Jc8WmUc5UTaG+sq/v
         KQcEHldhrnkNgiGBf0JfYLDrsGQVyc3o4RNp2a6faky5lQ/e/EUZnw1Js1CMG1i51shH
         IbTA==
X-Gm-Message-State: AOAM530FRWs/VnwGSLgNs5a3TFgY+R2TzX6bQf+l+QTpcncq4Ex9RLke
        gA5+XSuyc7HWNeWVjTlAgVFhUSm2OoI=
X-Google-Smtp-Source: ABdhPJybb+S7puDrI41gTPXgpQZEs7AQwrdWpc/iQq/D3cmRKq5jkOogrgl6stczaPFqaA8ur1mWYQ==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr85873wmg.14.1592958453358;
        Tue, 23 Jun 2020 17:27:33 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id l18sm2641278wrt.59.2020.06.23.17.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 17:27:32 -0700 (PDT)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-ID: <a36966dd-677a-916c-9a03-c82b4e980652@gmail.com>
Date:   Wed, 24 Jun 2020 02:28:27 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For some reason they tend to squat on the very first CSR/
Cambridge Silicon Radio VID/PID instead of paying fees.

This is an extremely common problem; the issue goes as back as 2013
and these devices are only getting more popular, even rebranded by
reputable vendors and sold by retailers everywhere.

So, at this point in time there are hundreds of modern dongles reusing
the ID of what originally was an early Bluetooth 1.1 controller.

Linux is the only place where they don't work due to spotty checks
in our detection code. It only covered a minimum subset.

So what's the big idea? Take advantage of the fact that all CSR
chips report the same internal version as both the LMP sub-version and
HCI revision number. It always matches, couple that with the manufacturer
code, that rarely lies, and we now have a good idea of who is who.

Additionally, by compiling a list of user-reported HCI/lsusb dumps, and
searching around for Windows drivers with similar product ranges
we can find an official superset within their .inf files.

So it turns out that most of what it was thought to be counterfeit
was just a newer chip with different quirks. Internet shows that
this has been a problem on Windows, too.

So, to sum things up; there are actually three classes of controllers
reusing the same 0A12:0001 VID/PID. This has been broken for a while.

Known 'fake' bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
  IC markings on 0x7558: FR3191AHAL 749H15143 (???)

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)
Reported-by: Michał Wiśniewski <brylozketrzyn@gmail.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

Changes in v2:
* Find a better way of detecting which type is which; scrap the wonky
  >=Bluetooth 1.2 protocol check and instead do what's described above.
* Move all the quirk logic to btusb_setup_csr(), simplify it a bit.
* Use a switch statement and list all the known broken bcdDevice
  instead of trying to penalize the real CSR devices.
* Add two bt_dev_info() prints because this may be important in the
  future, given the amount of variables we are playing with here.
* Try to keep my comments within a 80-column limit.

I think this makes way more sense, getting all the dongles to work without
penalizing either side. And provides a baseline to *maybe* expand the list
in the future, easily. But I'm pretty sure it should cover most of them.

Let me know what you think.

 drivers/bluetooth/btusb.c | 97 +++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf..b7b8680c3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1718,6 +1718,8 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 
 static int btusb_setup_csr(struct hci_dev *hdev)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_device *udev = data->udev;
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
 
@@ -1739,18 +1741,77 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
-	/* Detect controllers which aren't real CSR ones. */
-	if (le16_to_cpu(rp->manufacturer) != 10 ||
-	    le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
-		/* Clear the reset quirk since this is not an actual
-		 * early Bluetooth 1.1 device from CSR.
+	/* Of interest to fine-tune the logic in the future */
+	bt_dev_info(hdev, "CSR: New controller detected; bcdDevice=%#x, HCI manufacturer=%u, HCI rev=%#x, LMP subver=%#x",
+		    le16_to_cpu(udev->descriptor.bcdDevice),
+		    le16_to_cpu(rp->manufacturer),
+		    le16_to_cpu(rp->hci_rev),
+		    le16_to_cpu(rp->lmp_subver));
+
+	/* Detect a wide host of Chinese controllers that rely on heavy VID/PID
+	 * squatting of this poor old Bluetooth 1.1 device. As if that wasn't
+	 * enough there are actually three classes of controllers reusing
+	 * the same 0A12:0001 VID/PID:
+	 *
+	 * * Old CSR Bluetooth 1.1 devices (BlueCore?):
+	 *   HCI_QUIRK_SIMULTANEOUS_DISCOVERY
+	 *   HCI_QUIRK_RESET_ON_CLOSE
+	 *
+	 * * New CSR Bluetooth devices based on CSR8510 (BlueSoleil?):
+	 *   HCI_QUIRK_BROKEN_STORED_LINK_KEY
+	 *
+	 * * Unbranded CSR clone:
+	 *   Their HCI chip uses a different manufacturer number;
+	 *   sourced from various vendors. Most common ones are:
+	 *     - Broadcom Corporation (15)
+	 *     - Mitel Semiconductor (16)
+	 *
+	 *   No quirks, varies depending on the real manufacturer.
+	 *
+	 * We detect actual CSR devices by checking that the HDI manufacturer code
+	 * is Cambridge Silicon Radio (10) and ensuring that LMP sub-version and
+	 * the HID values will always match. The full list of newer bcdDevices
+	 * is documented in the official driver .inf files.
+	 *
+	 * Because diagnosing all this has been very tricky in the past, with the
+	 * original bug being reported in 2013, and left unsolved until 2020, let's
+	 * report the chip type to potentially have a better coverage and reports.
+	 */
+	if (le16_to_cpu(rp->manufacturer) == 10 &&
+	    le16_to_cpu(rp->hci_rev) == le16_to_cpu(rp->lmp_subver)) {
+		/* Only apply the reset quirk on actual, early Bluetooth 1.1 devices
+		 * from CSR. Old firmware would otherwise execute USB reset
 		 */
-		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
+			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-		/* These fake CSR controllers have all a broken
-		 * stored link key handling and so just disable it.
-		 */
-		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+		if (udev->descriptor.idVendor  == 0x0a12 &&
+		    udev->descriptor.idProduct == 0x0001) {
+			switch (udev->descriptor.bcdDevice) {
+			case 0x0100:
+			case 0x0134:
+			case 0x1915:
+			case 0x1958:
+			case 0x2520:
+			case 0x3164:
+			case 0x4839:
+			case 0x5276:
+			case 0x7558:
+			case 0x8891:
+				/* These newer CSR controllers have all a broken
+				 * stored link key handling, so just disable it.
+				 */
+				set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+				bt_dev_info(hdev, "CSR: Modern CSR controller type detected");
+				break;
+			default:
+				/* Only apply this quirk to actual, old CSR devices */
+				set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+				bt_dev_info(hdev, "CSR: Old CSR controller type detected");
+			}
+		}
+	} else {
+		bt_dev_info(hdev, "CSR: Unbranded CSR clone detected; adding workaround");
 	}
 
 	kfree_skb(skb);
@@ -3993,20 +4054,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_CSR) {
-		struct usb_device *udev = data->udev;
-		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
-
-		/* Old firmware would otherwise execute USB reset */
-		if (bcdDevice < 0x117)
-			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
-
-		/* Fake CSR devices with broken commands */
-		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
-			hdev->setup = btusb_setup_csr;
-
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-	}
+	if (id->driver_info & BTUSB_CSR)
+		hdev->setup = btusb_setup_csr;
 
 	if (id->driver_info & BTUSB_SNIFFER) {
 		struct usb_device *udev = data->udev;
-- 
2.27.0

