Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C098C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BE761157
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhIHXhS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 19:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237321AbhIHXhR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 19:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3C3BD611C6
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Sep 2021 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631144169;
        bh=Asw9WrcAwKCDGwvejLqr2of87nLT1YMBPunj8L1jquM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lGziTAXFxGbav7Eu5rKZJeX+9m9VzfbkIQvSLlA3+dVNGZBbLt7he9i3Am81s55QE
         nGxG6b8TqRZ9NF4KAGwK16SxFllvAuE2NfaxsjCOyynvrAWe3TJWgZrVzLWkKLPOmC
         8U+c6haXhp/6ugqyL/7LtbExoyS+1KNs2qII1o591OVC11YBX657CDOgZqWVpiAQ7n
         7lLhlyTcFxHoHKjQ3IgUrJmdYJUoGtzpOmbbLtAEfLBdbJES+WpLbbkajaayIIFUxm
         fomu8wjzkituUpvWEUdRDr6yjCAamLfkpa3B0wlyF0QZ/zgZcKbEACFMma6KNvgQCS
         5HcOJsxnIpr4A==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 08 Sep 2021 23:36:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-1sba1QhqOb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #199 from guimarcalsilva@gmail.com ---
(In reply to guimarcalsilva from comment #198)
> I tested it using a live image of Fedora Rawride from September 8 2021 wi=
th
> the development version of Kernel 5.15. The dongle is detected but I can't
> turn it on in the settings or in blueman:
>=20
> [1125.221008] usb 1-4: USB disconnect, device number 14
> [1130.356918] usb 1-4: new full-speed USB device number 15 using xhci_hcd
> [1130.486202] usb 1-4: New USB device found, idVendor=3D0a12, idProduct-0=
001,
> bcdDevice=3D25.20
> [1130.486219] usb 1-4: New USB device strings: Mfr=3D0, Product=3D2,
> SerialNumber=3D0 [1130.486227] usb 1-4: Product: CSR8510 A10
> [1130.496424] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
> workarounds and force-suspending once...=20
> [1135.982384] Bluetooth: hci0: CSR: Failed to suspend the device for our
> Barrot 8041a02 receive-issue workaround
> [1141.099165] Bluetooth: hci0: setting interface failed (110)
>=20
> My dongle is packaged as a Bluetooth 5 device. Unfortunately I couldn't r=
un
> hciconfig because for some reason dnf refused to work on the live image.
> I'll try bringing more logs later.

Update - I managed to make it work with the same live image on my laptop
(before I had tested on my desktop), but first I had to change the USB port=
 it
was connected to. It didn`t work before doing that.=20

On Fedora there`s no hciconfig anymore, and since my laptop already has a
internal bluetooth adapter btmon looks confusing. I made sure to select the
right adapter on blueman and also on bluetoothctl.

I connected my DualShock 4 to my laptop using the adapter and it worked aft=
er
changing USB ports and also I had to try a couple of times.

Dmesg

[ 2205.255388] blueman-manager (4133) used greatest stack depth: 11800 bytes
left
[ 2215.403794] usb 1-4: new full-speed USB device number 13 using xhci_hcd
[ 2215.533560] usb 1-4: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D25.20
[ 2215.533566] usb 1-4: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[ 2215.533569] usb 1-4: Product: CSR8510 A10
[ 2215.542252] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[ 2215.542266] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround
[ 2479.091850] sony 0005:054C:09CC.0004: unknown main item tag 0x0
[ 2479.110875] input: Wireless Controller Touchpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/bluetooth/hci0/hci0:48/00=
05:054C:09CC.0004/input/input27
[ 2479.111617] input: Wireless Controller Motion Sensors as
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/bluetooth/hci0/hci0:48/00=
05:054C:09CC.0004/input/input28
[ 2479.120271] input: Wireless Controller as
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/bluetooth/hci0/hci0:48/00=
05:054C:09CC.0004/input/input26
[ 2479.121803] sony 0005:054C:09CC.0004: input,hidraw0: BLUETOOTH HID v81.00
Gamepad [Wireless Controller] on 00:1a:7d:da:71:10


The 00:1a:7d:da:71:10 address is from the fake bluetooth dongle. The intern=
al
bluetooth uses 54:8C:A0:A8:AC:E0. I`m sure I`m connecting through the right
bluetooth adapter because when I disconnect the dongle the controller gets
disconnected and a bluetoothctl + list only shows the internal adapter.


The question now is why do I have to change USB ports for it to work on my
laptop and why it didn`t work on my desktop with the same live system. I`ll=
 try
once again on my desktop and see if I manage to make it work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
