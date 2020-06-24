Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1FC20836
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405438AbgFXRXW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405318AbgFXRXW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 13:23:22 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 24 Jun 2020 17:23:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hello@andres.codes
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-xg9q0UpoD8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #83 from Andrés Rodríguez (hello@andres.codes) ---
Before removing hci_rev check (patch 2.0 as-is)

hcidump -X

https://gist.github.com/mixedCase/67bfaa752050aa4a705e538f9d478ec3

dmesg:

[14225.389482] usb 1-2: new full-speed USB device number 6 using xhci_hcd
[14225.549112] usb 1-2: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice=25.20
[14225.549115] usb 1-2: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[14225.549117] usb 1-2: Product: CSR8510 A10
[14225.557143] Bluetooth: hci0: CSR: New controller detected; bcdDevice=0x2520,
HCI manufacturer=10, HCI rev=0x3120, LMP subver=0x22bb
[14225.557144] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workaround

---

After removing hci_rev check

hcidump -X

https://gist.github.com/mixedCase/2e1c670e5d4ff414558b35db37472058

dmesg:

[13938.833774] usb 1-2: new full-speed USB device number 4 using xhci_hcd
[13938.996271] usb 1-2: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice=25.20
[13938.996274] usb 1-2: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[13938.996276] usb 1-2: Product: CSR8510 A10
[13939.004322] Bluetooth: hci0: CSR: New controller detected; bcdDevice=0x2520,
HCI manufacturer=10, HCI rev=0x3120, LMP subver=0x22bb
[13939.004324] Bluetooth: hci0: CSR: Modern CSR controller type detected

-- 
You are receiving this mail because:
You are the assignee for the bug.
