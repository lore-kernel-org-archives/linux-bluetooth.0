Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_HELO_IP_MISMATCH,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C50EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C42F20732
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 21:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK72WaQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgFVVHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFVVHW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 17:07:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE5C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 14:07:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so970172wmh.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ze8thQfg274BZcUXsjzIniEqit0TlV9mf3xVsSQTcZk=;
        b=AK72WaQ/YEGoI02cGqR4pMtzKuLTT41PgKEZ6DOXcxjS+D67keXrW929P653AcVg5h
         V8rReCG4aZ6hhyyAJWgohzY9mQ4wfqnkFXReEdJKAWReiP81cZBb+giXw5nwk7rK3UuZ
         9y0IIU/UJBKqhAHV4imvdY86SxYsyWiJKA2FXwkHGIj0NRxkoptk4c+xwNTZSklFNSc/
         svrzAjiQsaR4RsQrXItg1tX+kNPJybfOj1lKJaZ8x7w1qwFUKKUGw41qX7w0xTW70lsP
         YRg8IbCnBa8R8VUemTA9m//umZeHwgd1iUHmCR5w/aRkXJN2LezI9XI55G4BfxxmcDA3
         9y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ze8thQfg274BZcUXsjzIniEqit0TlV9mf3xVsSQTcZk=;
        b=hINctwgIahW2WUHbyXjcuL67R2S5EB9Svzu0rrKlOpFIgMQ6HjGvlX+WTylv4GM+oK
         hu/Bt/Oye6mYt6n2SyVm6ft/DfHO+2ZHUVMYaN8dT9LEYeOl+tYo+kzttHa6sM24lGBC
         3rT7jTdJhmWzDArXtoPwsAefBViv4Doe0b5uWERwBDuHJI+0924Pxj1ErZZGkmZW+wrn
         FbdmcwzizyI4Hej+4vRdN5joo7K3HglQ16bOUkTiG2tYkreOAhOoI6bd5JsLOIubYl37
         m+Ri0xNUnUtBZFtN6AKWnwN9DcNhyi4XHMGTEnh3ieeCGSMs95O2eXJpvIH4UqhfIK7E
         IZrg==
X-Gm-Message-State: AOAM532B0iknODKdiQSaJZvtibcu0NNuybgYTSBTbWDt1hIXgFgj0Lm1
        QqZT3Qv787Ao5mlXGPcWF5GUaY4WspawPg==
X-Google-Smtp-Source: ABdhPJzcV3SF4dN+LtXgoq87vaQQGm5guNfw2DvELvdNMUXCc7gCkSIhiY0H7xWWSO90E7nh6NObcQ==
X-Received: by 2002:a1c:2901:: with SMTP id p1mr21093970wmp.144.1592860040562;
        Mon, 22 Jun 2020 14:07:20 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id h7sm925567wml.24.2020.06.22.14.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:07:19 -0700 (PDT)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-ID: <0018a41a-5a46-2db6-5df2-e1b026b81bae@gmail.com>
Date:   Mon, 22 Jun 2020 23:07:20 +0200
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

So what's the big idea? Flip the check around, we know that there
are potentially going to be more. But CSR is done for and the
real device only worked in an old and narrow subset of the
protocol that has been amply superseded.

Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
IC markings on 0x7558: FR3191AHAL 749H15143 (???)

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)
Reported-by: Michał Wiśniewski <brylozketrzyn@gmail.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---
 drivers/bluetooth/btusb.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

 PS: I'm wondering how flexible the new 100-column limit really is,
     I tried to trim the comment a bit but it looked ugly. :)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf..880fe46aa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1739,9 +1739,22 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
-	/* Detect controllers which aren't real CSR ones. */
+	/* Detect a wide host of Chinese controllers that aren't CSR. Some of these clones even
+	 * respond with the correct HCI manufacturer, and their bcdDevice tags are all over the place,
+	 * which may be another good angle to look into if we really want to have really long quirk lists.
+	 *
+	 * Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
+	 * IC markings on 0x7558: FR3191AHAL 749H15143 (???)
+	 *
+	 * But the main thing they have in common is that these are really popular low-cost
+	 * options that support newer Bluetooth versions but rely on heavy VID/PID
+	 * squatting of this poor old Bluetooth 1.1 device. Even sold as such.
+	 */
 	if (le16_to_cpu(rp->manufacturer) != 10 ||
-	    le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
+	    le16_to_cpu(rp->lmp_subver) == 0x0c5c ||
+	    le16_to_cpu(rp->hci_ver) >= BLUETOOTH_VER_1_2) {
+		bt_dev_info(hdev, "CSR: Unbranded CSR clone detected; adding workaround");
+
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
 		 */
@@ -1751,6 +1764,9 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 * stored link key handling and so just disable it.
 		 */
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+	} else {
+		/* Only apply these quirks to the actual, old CSR devices */
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 	kfree_skb(skb);
@@ -3995,17 +4011,13 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_CSR) {
 		struct usb_device *udev = data->udev;
-		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
 
 		/* Old firmware would otherwise execute USB reset */
-		if (bcdDevice < 0x117)
+		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 		/* Fake CSR devices with broken commands */
-		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
-			hdev->setup = btusb_setup_csr;
-
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		hdev->setup = btusb_setup_csr;
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
-- 
2.27.0

