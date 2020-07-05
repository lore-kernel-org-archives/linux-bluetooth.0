Return-Path: <SRS0=8wDQ=AQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_HELO_IP_MISMATCH,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A3FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jul 2020 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A522070C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jul 2020 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYxhHsMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGETVr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgGETVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jul 2020 15:21:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899EC061794
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2020 12:21:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so38487374wrj.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2020 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8Hja5VcLLy1RGMrUMqsHxzuU/DDmvRgUxzFKmXiKvHs=;
        b=TYxhHsMeUuD5Fydk6Q9l+Is3ZC1NB8Z1hoEEIKPgrJXOAbhRFMZ2Pqx5jKBpb38an3
         Hy2dQHI9glvdtSvyn/6vKdBsyXe3pYMule5RTeWCrtvXMkSRYjoCn2ofNIAvT9I1MHK+
         sIg52sXIsmvObicd6Q0+n9rFwyZay+ExKouyZYitgYqeVUgNOjToLUdpHM20vH5zOvFp
         yLyAOcEDTa2fUQU5GEImpCfRr3cPMsjtHLDNP3TYnbyRqaO2D4oclA2hQO8WTS6nmlAz
         CnFql5eIGjQ3EpeqqSoWtv6SvSvW0OenDBLutEBzoe/1Eue49x3wLLjrB8m2waqg2pGF
         Kz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8Hja5VcLLy1RGMrUMqsHxzuU/DDmvRgUxzFKmXiKvHs=;
        b=Qh42So+HJWiUGaWIcJNj7S8OK71J4qGC7lnL5lLdsb+gV1NS8rveCpe3L7rBD5MDwH
         v0/0n07TCH6OJ7805rxTWpl1MNRrDTZdVOfTkqxsrI4O1ChdmSvpt6QhKuMVDMCKd0gc
         YEfz4NB7qyQwael1GOApEmia2quXSH8KcmOWQhuImbwI6GXoTj1on8IQmg9B7MnwWXQ+
         8NfIAdI8jcvahoZ/VgX8ftx6ntqlE+E9tWNS+RRGe8UsAKxVyIk/9QK0Sdv0XKi9TFAU
         1k5fYcrglJbJ7VXvmkMhc/VOy8CPDAKpSdggwVp9MxTYt7i97+toNRPqekA0rtZtitrI
         vFxQ==
X-Gm-Message-State: AOAM530AikTQmKzo3m4j2Fya9B4EjMA9XMR2GY2CBW6rPIVu4MsoRggk
        duUW8WhvEid1nIog4HcsgZPf0HTi
X-Google-Smtp-Source: ABdhPJxLGG7bZwL5kO9yUaVFfzmeMlGstdi828BnYgkQWIXWfEB6lX/nna/+QMxHpA79HLzuIR/FSA==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr45550302wrv.21.1593976904926;
        Sun, 05 Jul 2020 12:21:44 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id z1sm21242044wru.30.2020.07.05.12.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 12:21:43 -0700 (PDT)
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v3] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-ID: <6bce2c08-48f0-f49c-d70c-280475220550@gmail.com>
Date:   Sun, 5 Jul 2020 21:21:41 +0200
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
searching around for legit CSR dongles in similar product ranges we can
find what CSR BlueCore firmware supported which Bluetooth versions.

That way we can narrow down ranges of fakes for each of them.

e.g. Real CSR dongles with LMP subversion 0x73 are old enough that
     support BT 1.1 only; so it's a dead giveaway when some
     third-party BT 4.0 dongle reuses it.

So, to sum things up; there are multiple classes of fake controllers
reusing the same 0A12:0001 VID/PID. This has been broken for a while.

Known 'fake' bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
  IC markings on 0x7558: FR3191AHAL 749H15143 (???)

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)
Reported-by: Michał Wiśniewski <brylozketrzyn@gmail.com>
Tested-by: Mike Johnson <yuyuyak@gmail.com>
Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

Changes in v3:
* Find an even better way of detecting which type is which; use the
  best parts of v1 and v2 and combine them with previous feedback.
* Additionally, detect fakes by comparing against a BlueCore
  firmware numbers and their supported protocol versions.
* Introduce HCI_QUIRK_BROKEN_ERR_DATA_REPORTING and use it on all
  fake chips. It doesn't seem to cause any drawback, and if we
  make it too specific a lot of these chips won't work at all,
  so it's probably better than nothing. Other user reported
  being able to finally pair with their stereo A2DP speaker
  with this fix.
* Limit the use of btusb_setup_csr() only to cover 0A12:0001.
* Use bt_dev_warn for the fake detection notice.
* Remove all other noisy bt_dev_info() calls.

Changes in v2:
* Find a better way of detecting which type is which; scrap the wonky
  >=Bluetooth 1.2 protocol check and instead do what's described above.
* Move all the quirk logic to btusb_setup_csr(), simplify it a bit.
* Use a switch statement and list all the known broken bcdDevice
  instead of trying to penalize the real CSR devices.
* Add two bt_dev_info() prints because this may be important in the
  future, given the amount of variables we are playing with here.
* Try to keep my comments within a 80-column limit.

Now I'm able of pairing with Android devices, A2DP headphones,
DS4 controllers and more; whereas previously set up failed
and userland software couldn't even scan with it.

This patch probably uncovers other quirks in some of these
previously *unusable* dongles, so it's probably a good start
point so that other fixes can be implemented on top.

Looking forward to fine-tune these checks in the future.
Let me know what you think.

 drivers/bluetooth/btusb.c         | 74 ++++++++++++++++++++++++++-----
 include/net/bluetooth/bluetooth.h |  2 +
 include/net/bluetooth/hci.h       | 11 +++++
 net/bluetooth/hci_core.c          |  6 ++-
 4 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf..89686379a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1720,6 +1720,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_local_version *rp;
 	struct sk_buff *skb;
+	bool is_fake = false;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1739,18 +1740,69 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 
 	rp = (struct hci_rp_read_local_version *)skb->data;
 
-	/* Detect controllers which aren't real CSR ones. */
+	/* Detect a wide host of Chinese controllers that aren't CSR.
+	 *
+	 * Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
+	 *
+	 * The main thing they have in common is that these are really popular low-cost
+	 * options that support newer Bluetooth versions but rely on heavy VID/PID
+	 * squatting of this poor old Bluetooth 1.1 device. Even sold as such.
+	 *
+	 * We detect actual CSR devices by checking that the HCI manufacturer code
+	 * is Cambridge Silicon Radio (10) and ensuring that LMP sub-version and
+	 * HCI rev values always match. As they both store the firmware number.
+	 */
 	if (le16_to_cpu(rp->manufacturer) != 10 ||
-	    le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
+	    le16_to_cpu(rp->hci_rev) != le16_to_cpu(rp->lmp_subver))
+		is_fake = true;
+
+	/* Known legit CSR firmware build numbers and their supported BT versions:
+	 * - 1.1 (0x1) -> 0x0073, 0x020d, 0x033c, 0x034e
+	 * - 1.2 (0x2) ->                 0x04d9, 0x0529
+	 * - 2.0 (0x3) ->         0x07a6, 0x07ad, 0x0c5c
+	 * - 2.1 (0x4) ->         0x149c, 0x1735, 0x1899 (0x1899 is a BlueCore4-External)
+	 * - 4.0 (0x6) ->         0x1d86, 0x2031, 0x22bb
+	 *
+	 * e.g. Real CSR dongles with LMP subversion 0x73 are old enough that
+	 *      support BT 1.1 only; so it's a dead giveaway when some
+	 *      third-party BT 4.0 dongle reuses it.
+	 */
+	if (le16_to_cpu(rp->lmp_subver) <= 0x034e &&
+	    le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_1)
+		is_fake = true;
+
+	if (le16_to_cpu(rp->lmp_subver) <= 0x0529 &&
+	    le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_2)
+		is_fake = true;
+
+	if (le16_to_cpu(rp->lmp_subver) <= 0x0c5c &&
+	    le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_0)
+		is_fake = true;
+
+	if (le16_to_cpu(rp->lmp_subver) <= 0x1899 &&
+	    le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_1)
+		is_fake = true;
+
+	if (le16_to_cpu(rp->lmp_subver) <= 0x22bb &&
+	    le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
+		is_fake = true;
+
+	if (is_fake) {
+		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
+
+		/* Generally these clones have big discrepancies between
+		 * advertised features and what's actually supported.
+		 * Probably will need to be expanded in the future;
+		 * without these the controller will lock up.
+		 */
+		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
 		 */
 		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
-
-		/* These fake CSR controllers have all a broken
-		 * stored link key handling and so just disable it.
-		 */
-		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 	kfree_skb(skb);
@@ -4001,11 +4053,13 @@ static int btusb_probe(struct usb_interface *intf,
 		if (bcdDevice < 0x117)
 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
+		/* This must be set first in case we disable it for fakes */
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
 		/* Fake CSR devices with broken commands */
-		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
+		if (udev->descriptor.idVendor  == 0x0a12 &&
+		    udev->descriptor.idProduct == 0x0001)
 			hdev->setup = btusb_setup_csr;
-
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 181900553..155019220 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -41,6 +41,8 @@
 #define BLUETOOTH_VER_1_1	1
 #define BLUETOOTH_VER_1_2	2
 #define BLUETOOTH_VER_2_0	3
+#define BLUETOOTH_VER_2_1	4
+#define BLUETOOTH_VER_4_0	6
 
 /* Reserv for core and drivers use */
 #define BT_SKB_RESERVE	8
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 16ab6ce87..1c321b6d1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -227,6 +227,17 @@ enum {
 	 * supported.
 	 */
 	HCI_QUIRK_VALID_LE_STATES,
+
+	/* When this quirk is set, then erroneous data reporting
+	 * is ignored. This is mainly due to the fact that the HCI
+	 * Read Default Erroneous Data Reporting command is advertised,
+	 * but not supported; these controllers often reply with unknown
+	 * command and tend to lock up randomly. Needing a hard reset.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbe2d79f2..48d7c7e23 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -606,7 +606,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[8] & 0x01)
 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
 
-	if (hdev->commands[18] & 0x04)
+	if (hdev->commands[18] & 0x04 &&
+	    !test_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks))
 		hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
 
 	/* Some older Broadcom based Bluetooth 1.2 controllers do not
@@ -851,7 +852,8 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	/* Set erroneous data reporting if supported to the wideband speech
 	 * setting value
 	 */
-	if (hdev->commands[18] & 0x08) {
+	if (hdev->commands[18] & 0x08 &&
+	    !test_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks)) {
 		bool enabled = hci_dev_test_flag(hdev,
 						 HCI_WIDEBAND_SPEECH_ENABLED);
 
-- 
2.22.0

