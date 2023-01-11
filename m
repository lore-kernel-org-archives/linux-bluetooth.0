Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C485C46467
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjAKWGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjAKWGp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Jan 2023 17:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300210A
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 14:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD3861ED4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 22:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 380E3C43392
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jan 2023 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673474803;
        bh=W0Z+A9sJ/MiT9gWOLvxMbEHo/qHikt02uSlqBQ5gjwk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kJ+JCHFkdIj+EqK8JcIfMbySlBo+ZMMyLoQIur/QIlH9KBzE6SAZffwcDlkGa52eh
         TJwRgVZuuHbaoJNPb5qURKdWazKjK+S7sioNkYZiARrrcOKogd1ZRhIhq2a+DowQGp
         yIHmm5fDiruNojrAw1v/VqM1f/EDC9orxY1r3wTPqvQAwZfuO3mpc6piVGaR2FXRKY
         yMbo1UnrsHw0eZ9ofO/ovlrNFrYTae1kf1dstZZ/WIL026ZaMImBbIh2GzneOMSSe3
         0KB2ucyNekODwny16cea8AFXCIe28ugV+DoYwtEvo2spXVVanrKf6hf60YMIafD4DN
         tnDUGupwYrTqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 232B7C004D5; Wed, 11 Jan 2023 22:06:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Wed, 11 Jan 2023 22:06:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: queeup@zoho.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-Pjw8FCdf79@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #12 from queeup (queeup@zoho.com) ---
```
$ lspci -nnk | grep 0280 -A3
03:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:27=
23]
(rev 1a)
        Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi


$ lsusb -d 8087:
Bus 001 Device 004: ID 8087:0029 Intel Corp. AX200 Bluetooth


$ bluetoothctl info
Device 84:FC:FE:E0:A5:F0 (public)
        Alias: Apple Magic Trackpad
        Class: 0x00002594
        Icon: input-tablet
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: yes
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34=
fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34=
fb)
        Modalias: usb:v05ACp030Ed0160


$ uname -a
Linux fedora 5.19.6-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 31 17:58=
:15
UTC 2022 x86_64 x86_64 x86_64 GNU/Linux


$ cat /etc/os-release=20
NAME=3D"Fedora Linux"
VERSION=3D"36.20220902.0 (Silverblue)"
ID=3Dfedora
VERSION_ID=3D36
VERSION_CODENAME=3D""
PLATFORM_ID=3D"platform:f36"
PRETTY_NAME=3D"Fedora Linux 36.20220902.0 (Silverblue)"
ANSI_COLOR=3D"0;38;2;60;110;180"
LOGO=3Dfedora-logo-icon
CPE_NAME=3D"cpe:/o:fedoraproject:fedora:36"
HOME_URL=3D"https://fedoraproject.org/"
DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora-silverblue=
/"
SUPPORT_URL=3D"https://ask.fedoraproject.org/"
BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=3D36
REDHAT_SUPPORT_PRODUCT=3D"Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=3D36
PRIVACY_POLICY_URL=3D"https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
VARIANT=3D"Silverblue"
VARIANT_ID=3Dsilverblue
OSTREE_VERSION=3D'36.20220902.0'


$ rpm -qa linux-firmware iwlax2xx-firmware bluez
bluez-5.65-1.fc36.x86_64
iwlax2xx-firmware-20220815-138.fc36.noarch
linux-firmware-20220815-138.fc36.noarch


$ dmesg | grep firmware
[    3.059539] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_04.bin (v1.4)
[    7.048785] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.101611] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    7.181529] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-cc-a0-72.ucode failed with error -2
[    7.242302] iwlwifi 0000:03:00.0: loaded firmware version 71.058653f6.0
cc-a0-71.ucode op_mode iwlmvm
[    8.865213] Bluetooth: hci0: Waiting for firmware download to complete


$ dmesg | grep Bluetooth
[    6.876698] Bluetooth: Core ver 2.22
[    6.876723] Bluetooth: HCI device and connection manager initialized
[    6.876727] Bluetooth: HCI socket layer initialized
[    6.876728] Bluetooth: L2CAP socket layer initialized
[    6.876734] Bluetooth: SCO socket layer initialized
[    7.047790] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[    7.048779] Bluetooth: hci0: Device revision is 1
[    7.048781] Bluetooth: hci0: Secure boot is enabled
[    7.048782] Bluetooth: hci0: OTP lock is enabled
[    7.048783] Bluetooth: hci0: API lock is enabled
[    7.048784] Bluetooth: hci0: Debug lock is disabled
[    7.048785] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.101611] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    7.101745] Bluetooth: hci0: Boot Address: 0x24800
[    7.101747] Bluetooth: hci0: Firmware Version: 20-28.22
[    8.865213] Bluetooth: hci0: Waiting for firmware download to complete
[    8.865758] Bluetooth: hci0: Firmware loaded in 1722796 usecs
[    8.865806] Bluetooth: hci0: Waiting for device to boot
[    8.880761] Bluetooth: hci0: Device booted in 14623 usecs
[    8.880768] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    8.883561] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[    8.885766] Bluetooth: hci0: Applying Intel DDC parameters completed
[    8.886770] Bluetooth: hci0: Firmware revision 0.3 build 20 week 28 2022
[    8.948322] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.948325] Bluetooth: BNEP filters: protocol multicast
[    8.948330] Bluetooth: BNEP socket layer initialized
[   10.495877] Bluetooth: RFCOMM TTY layer initialized
[   10.495885] Bluetooth: RFCOMM socket layer initialized
[   10.495932] Bluetooth: RFCOMM ver 1.11


$ dmesg | grep iwlwifi
[    7.081904] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
[    7.181529] iwlwifi 0000:03:00.0: Direct firmware load for
iwlwifi-cc-a0-72.ucode failed with error -2
[    7.242004] iwlwifi 0000:03:00.0: api flags index 2 larger than supporte=
d by
driver
[    7.242021] iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:
89.3.35.37
[    7.242302] iwlwifi 0000:03:00.0: loaded firmware version 71.058653f6.0
cc-a0-71.ucode op_mode iwlmvm
[    7.535978] iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz,
REV=3D0x340
[    7.692651] iwlwifi 0000:03:00.0: Detected RF HR B3, rfid=3D0x10a100
[    7.765022] iwlwifi 0000:03:00.0: base HW address: 8c:c6:81:9d:1c:5a
[    7.784984] iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0


$ dmesg | grep Bluetooth
[    6.876698] Bluetooth: Core ver 2.22
[    6.876723] Bluetooth: HCI device and connection manager initialized
[    6.876727] Bluetooth: HCI socket layer initialized
[    6.876728] Bluetooth: L2CAP socket layer initialized
[    6.876734] Bluetooth: SCO socket layer initialized
[    7.047790] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[    7.048779] Bluetooth: hci0: Device revision is 1
[    7.048781] Bluetooth: hci0: Secure boot is enabled
[    7.048782] Bluetooth: hci0: OTP lock is enabled
[    7.048783] Bluetooth: hci0: API lock is enabled
[    7.048784] Bluetooth: hci0: Debug lock is disabled
[    7.048785] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    7.101611] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[    7.101745] Bluetooth: hci0: Boot Address: 0x24800
[    7.101747] Bluetooth: hci0: Firmware Version: 20-28.22
[    8.865213] Bluetooth: hci0: Waiting for firmware download to complete
[    8.865758] Bluetooth: hci0: Firmware loaded in 1722796 usecs
[    8.865806] Bluetooth: hci0: Waiting for device to boot
[    8.880761] Bluetooth: hci0: Device booted in 14623 usecs
[    8.880768] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    8.883561] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-20-1-3.ddc
[    8.885766] Bluetooth: hci0: Applying Intel DDC parameters completed
[    8.886770] Bluetooth: hci0: Firmware revision 0.3 build 20 week 28 2022
[    8.948322] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    8.948325] Bluetooth: BNEP filters: protocol multicast
[    8.948330] Bluetooth: BNEP socket layer initialized
[   10.495877] Bluetooth: RFCOMM TTY layer initialized
[   10.495885] Bluetooth: RFCOMM socket layer initialized
[   10.495932] Bluetooth: RFCOMM ver 1.11
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
