Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75875C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 10:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347787AbiAYKXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:23:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46382 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbiAYKUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1102FB81750
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BFFC340E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106018;
        bh=1jPRd0v88c/9OqELKkf0BtlNtrnr2Q5pEjjCcXpBdAs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tPRs0i+Nt5eu+czCkyJi3LcWSR065O8U/uevdakxRqRWKU8YXy4Ok2aidCE56YY5k
         IpTalY3tyE268MFUXZkhzInSt7887hV5+aP2lO94gq7WNen2p/AT8YnbXYi8a9rjRp
         uZGlLZtSYbLoddTFZ1hbwF0Tu/4+YmRJai+rJcBmhuS89j9amKdo5VXxQNLIVt3aGu
         c/j+ntsJXJh1b7GIcEq/eFMXL0PdYGDrDYfLlCRuDVuh68Br1tdIovOHxPEQ0BxujK
         GKqoueVeSZ2kDkUI8yU3GPps/+PxaozZRM2Ov3ODTqYI/9xGaAAH1jnfnPsLk+Efcg
         REatM0FhfZSew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AF9F0CC13B1; Tue, 25 Jan 2022 10:20:18 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 10:20:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-HyHOiJcb5a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
dmesg will have to wait, I don't want to reboot yet.

After all these errors I've updated the firmware just in case:

...
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
Bluetooth: hci0: urb 000000001aab8aa3 submission failed (90)
Bluetooth: hci0: sending frame failed (-90)
usbcore: deregistering interface driver btusb
usbcore: registered new interface driver btusb
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 207-35.21
Bluetooth: hci0: Firmware already loaded
show_signal_msg: 20 callbacks suppressed
Bluetooth: hci0: Ignoring error of Inquiry Cancel command
usbcore: deregistering interface driver btusb
Bluetooth: hci0: urb 000000009344aaa5 failed to resubmit (2)
usbcore: registered new interface driver btusb
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 86-46.21
usb 3-5: USB disconnect, device number 2
Bluetooth: hci0: command 0xfc01 tx timeout
usbcore: deregistering interface driver btusb
Bluetooth: hci0: FW download error recovery failed (-110)
usb 3-5: new full-speed USB device number 4 using xhci_hcd
usb 3-5: New USB device found, idVendor=3D8087, idProduct=3D0025, bcdDevice=
=3D 0.02
usb 3-5: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
usbcore: registered new interface driver btusb
Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
Bluetooth: hci0: Device revision is 2
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1142406 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 14837 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware revision 0.1 build 86 week 46 2021
usbcore: deregistering interface driver btusb
usbcore: registered new interface driver btusb
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 86-46.21
Bluetooth: hci0: Firmware already loaded

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
