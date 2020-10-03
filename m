Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEACC4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683A6206DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnZErZSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgJCIDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCIDb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 04:03:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29CC0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2020 01:03:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so3073490pfn.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2020 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vo9Wti3CHBBLDBlZgUG7E45wVWU0URZ0SP3CCo4PXe0=;
        b=bnZErZSS6KAM3TBAi2iC1bM680ZW+Ab5FEuYeMe7CD2bAl3aDfeCc3s/FGaHB3K9YZ
         Zil12Hr+v5wtY4b77AoEJXYO5OE6f7xa9WhtnQ+N4h0pJhl4eu/7Ulq3bWzhB1/Wahbc
         kO54BeR8tIaJoUPoACItFCo5/nNrag4eGAR7Q4hUfSqptwCF4Z4Y/Nr71Ej4nyv5EUi5
         ZryS0sz6iH3urZqdTgfcMPRfegVkEeDbT36IWTRkxqc2DGajw/xALWwaUq+Y2Sl7n4sI
         cJk6ZkmePJEI+EsvNs8vic5KNQtLikyOgK2H0Nsle0b2XtdGn6KQNIwb8zpweHewHoSz
         Z/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vo9Wti3CHBBLDBlZgUG7E45wVWU0URZ0SP3CCo4PXe0=;
        b=g8jd6cHN45an6Iwy8sgQY2WZ5k/v7ZSgHTyZzpxyen8pjF1FkcTLLEnXDd7a3is/FZ
         2k4tzGyl1shHD5R3SjGkfSoAoTZeUClVdRh8PI2lDiSOXIRzich5LsuGisrxocvVXlhi
         Qjrrn37KuiMOa1E6LXcoeT4H4cG+AfY1ah8qMFcYhHy9s/mT2AZG4NTCXemaDlfqR+FQ
         HZQ8jTJND3W8kgsOVCdnn2r0a0o7JS7kWbMNRfSvl6uW7VesAhnUXPK+f7dOIlQ/OyN9
         ykO1UqTQhh35YBPfifEXDRL9gX9Ez5YXcxs/9uIMl28CwzEoMRLrVx0/cNf39dkMikxy
         AlEA==
X-Gm-Message-State: AOAM532W7h7r4tMeRzSDVzIES/FFl4Iv9igFqLlShX6eDL4k5tbO8/Pi
        LinkXujiskgiy4PeGmVBQQUKTlYtwP4FTQ==
X-Google-Smtp-Source: ABdhPJyyk3fKy0QuiEaQmh0k7ojk72PSP5qe65+fMOxHfAWU1cKUUH/ZpMNkfCgAcXY1PSl3S9WEvg==
X-Received: by 2002:aa7:911a:0:b029:13e:d13d:a13d with SMTP id 26-20020aa7911a0000b029013ed13da13dmr6574510pfh.37.1601712210919;
        Sat, 03 Oct 2020 01:03:30 -0700 (PDT)
Received: from localhost.localdomain ([122.171.170.99])
        by smtp.gmail.com with ESMTPSA id m14sm4742835pfo.202.2020.10.03.01.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2020 01:03:30 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v5 1/2] Bluetooth: btusb: use usb vid/pid for initializing hal callbacks
Date:   Sat,  3 Oct 2020 13:32:58 +0530
Message-Id: <1601712179-13540-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For Intel controllers, use vid/pid for initalizing hardware abstraction
layer callbacks to avoid defining new quirk flags for new products.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
Changes in v5:
* Use usb vid/pid combination to identify controller type istead of using flags

Changes in previous versions:
None. This is a new patch created part of v5

 drivers/bluetooth/btusb.c | 79 ++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e..e2cd78d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3969,13 +3969,21 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
-		data->recv_event = btusb_recv_event_intel;
-		data->recv_bulk = btusb_recv_bulk_intel;
-		set_bit(BTUSB_BOOTLOADER, &data->flags);
-	} else {
-		data->recv_event = hci_recv_frame;
-		data->recv_bulk = btusb_recv_bulk;
+	data->recv_event = hci_recv_frame;
+	data->recv_bulk = btusb_recv_bulk;
+
+	if (id->idVendor == 0x8087) {
+		switch (id->idProduct) {
+		case 0x0025:
+		case 0x0026:
+		case 0x0029:
+		case 0x0a2b:
+		case 0x0aaa:
+			data->recv_event = btusb_recv_event_intel;
+			data->recv_bulk = btusb_recv_bulk_intel;
+			set_bit(BTUSB_BOOTLOADER, &data->flags);
+			break;
+		}
 	}
 
 	hdev = hci_alloc_dev();
@@ -4052,30 +4060,39 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 
-	if (id->driver_info & BTUSB_INTEL) {
-		hdev->manufacturer = 2;
-		hdev->setup = btusb_setup_intel;
-		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_diag = btintel_set_diag_mfg;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-	}
-
-	if (id->driver_info & BTUSB_INTEL_NEW) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_new;
-		hdev->shutdown = btusb_shutdown_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+	if (id->idVendor == 0x8087) {
+		switch (id->idProduct) {
+		case 0x07dc:
+		case 0x0a2a:
+		case 0x0aa7:
+			hdev->manufacturer = 2;
+			hdev->setup = btusb_setup_intel;
+			hdev->shutdown = btusb_shutdown_intel;
+			hdev->set_diag = btintel_set_diag_mfg;
+			hdev->set_bdaddr = btintel_set_bdaddr;
+			hdev->cmd_timeout = btusb_intel_cmd_timeout;
+			set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+			set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+			set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+			break;
+		case 0x0025:
+		case 0x0026:
+		case 0x0029:
+		case 0x0a2b:
+		case 0x0aaa:
+			hdev->manufacturer = 2;
+			hdev->send = btusb_send_frame_intel;
+			hdev->setup = btusb_setup_intel_new;
+			hdev->shutdown = btusb_shutdown_intel_new;
+			hdev->hw_error = btintel_hw_error;
+			hdev->set_diag = btintel_set_diag;
+			hdev->set_bdaddr = btintel_set_bdaddr;
+			hdev->cmd_timeout = btusb_intel_cmd_timeout;
+			set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+			set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+			set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+			break;
+		}
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.7.4

