Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF2C4708F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 May 2021 01:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F2C610CC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 May 2021 01:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3BLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 May 2021 21:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhE3BLP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 May 2021 21:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 58E4761151
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622336978;
        bh=TA0YchSlumOdEdxsaXFFVzg7cKgV/16HThNppqK/MVo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kg/iq97G+HNRTu8TJ7ZBH5BKede8nrMcUtrzDiwE76Z9FFINjgRW+0Zwi+Mwu4MfZ
         YhbebEc+h2fDnIDJBUwagYE2Igc+j6S/fsDD12DsE2jkbI+Qt4tz4E8AFEFGUv2RY4
         zpZsMh0yMYVxzIoe6Tpp5VZ9DcYhBdm4AhoHt+KTTmMPjUNvBfdpuV4cOrjLvMUfeF
         kvcfBjt9lJ83GI56HvLW7rDX8moHThK5ZdPc+W6B3xtBoywlM7ihkkYKPydrEHtSnr
         C2UWH03UY9U2bGNeQjjH1uubujuNguR2okyIUaUvribgaECXPdTtVFoz2SXeJ6PaLU
         x4HSGUOf773Ug==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 30 May 2021 01:09:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lucasrizzini@hotmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-tc0jLXEl5P@https.bugzilla.kernel.org/>
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

Lucas Rizzini (lucasrizzini@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lucasrizzini@hotmail.com

--- Comment #184 from Lucas Rizzini (lucasrizzini@hotmail.com) ---
(In reply to Mauro Fontana from comment #67)
> Created attachment 289017 [details]
> lsusb for bcdDevice 25.20
>=20
> Okay, managed to compiled the module with the fixups option and loaded.
> Unfortunately, although the module loads without problems, the BT adapter
> won't work.
>=20
> hciconfig hci0 up=20
>=20
> ends in connection timed out.
>=20
> I attach the full lsusb -v output for this device. Is there any other
> helpful info I can provide? Being able to solve this would be great, as in
> my country all the BT dongles I've seen online are CSR dongles.

Same here. I managed to compile the module on kernel 5.4.6 with the patch t=
hat
has the fixups made by Fernando Carvalho, but the symptoms are the same as
without it; no bluetooth adapter found with bluetoothctl or any other front
end.=20

Dmesg shows the patch and the fixups are indeed applied.

lsusb -v -> https://pastebin.com/HDc9z10e

/etc/modprobe.d/csr-bluetoothbongle.conf:
<code>options btusb fixups=3D0x0800000:0x000004:0x0a12:0x0001:0x8891</code>

dmesg:
<code>
[ 2080.767176] usbcore: registered new interface driver btusb
[ 2086.045608] usb 2-4: new full-speed USB device number 11 using xhci_hcd
[ 2086.187920] usb 2-4: config 1 interface 1 altsetting 0 endpoint 0x3 has
wMaxPacketSize 0, skipping
[ 2086.187922] usb 2-4: config 1 interface 1 altsetting 0 endpoint 0x83 has
wMaxPacketSize 0, skipping
[ 2086.188519] usb 2-4: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[ 2086.188520] usb 2-4: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[ 2086.188522] usb 2-4: Product: BT DONGLE10
[ 2086.190717] btusb: New fixups. Device: 0x0a12:0x0001/0x8891. Rule 1/1 (5
terms): 0x0a12:0x0001/0x8891
[ 2086.190718] btusb: driver flags: initial =3D> 0x0000000000000004
[ 2086.190719] btusb: driver flags: masked  =3D> 0x0000000000800000</code>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
