Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D52C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E78920771
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGFUxR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgGFUxR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:53:17 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Mon, 06 Jul 2020 20:53:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abhishekpandit@chromium.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-6M7IZRHEEk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

Abhishek Pandit-Subedi (abhishekpandit@chromium.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abhishekpandit@chromium.org

--- Comment #5 from Abhishek Pandit-Subedi (abhishekpandit@chromium.org) ---
There's a recovery mechanism via `cmd_timeout` that the btusb driver uses to
recover from these issues. For Intel chipsets, this requires having a reset
gpio available and listed in the ACPI/DeviceTree. From the logs above, it looks
like that's not the case.

I've had some success on a QCA chipset (6174A) by just resetting the port when
this happens (see https://patchwork.kernel.org/patch/11624041/)

If you don't mind patching your kernel, you could try the following and see if
it helps (you will need the series I linked above as well if you're not using
bluetooth-next master branch).

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0e143c0cecf2a1..cf86104fd62018 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,6 +511,7 @@ struct btusb_data {
        unsigned cmd_timeout_cnt;
 };

+static void btusb_qca_cmd_timeout(struct hci_dev *hdev);
 static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
        struct btusb_data *data = hci_get_drvdata(hdev);
@@ -520,7 +521,8 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
                return;

        if (!reset_gpio) {
-               bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
+               bt_dev_err(hdev, "No reset gpio. Resetting usb instead.");
+               btusb_qca_cmd_timeout(hdev);
                return;
        }

-- 
You are receiving this mail because:
You are the assignee for the bug.
