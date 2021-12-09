Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D993DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhLIKyp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:54:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbhLIKyo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 05:54:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A2CB8240D
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 10:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A968FC341C3
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639047069;
        bh=H7cPeP9YnCNQLH8/hUlHhxQwouEk7R1RaK52TruvUJI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KKxoG3iZhcjB8LwYT3wQHzCzxWyo9tHlB1RjG7ugVreKLkSJ94qDT4XIY+UJMsjsI
         jHiy6+hbSFMewgqiLGQp1OkunUza0MTe25Y6JQTUmZyczaagvQX0fgNaES6gbomyLG
         cJz9S3/C95IdOb8OH8atPCcAER6WUNPBESfg8++jh2q5JJcBaCnYSK0mm8OOugOGE9
         SPTf+TF/r2vz5YZtkDYS123iCgKjn1mrM370onvoJBmqRjNJYBh6RiXWGk5MHjrEiV
         ZR74gJakENzTnRcQ5vNIZRftif3xyrXQiH9eg7FRR8MsQqFkhYSYIuruxKnw4+35xA
         oGv8eAqrb0xKQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 83CCE60F55; Thu,  9 Dec 2021 10:51:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Thu, 09 Dec 2021 10:51:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215187-62941-2Gsb26Mhp8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215187-62941@https.bugzilla.kernel.org/>
References: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

--- Comment #5 from Takahide Nojima (nozzy123nozzy@gmail.com) ---
Hi Luiz,
>Try renaming it then

I copyed and renamed "intel/ibt-19-16-4.sfi" and "intel/ibt-19-16-4.ddc" to
"intel/ibt-19-16-0.sfi" and "intel/ibt-19-16-0.ddc" respectively. After I
rebooted 5.16-rc3 which has "iwlwifi-QuZ-a0-hr-b0-67.ucode", I found strange
messages in dmesg.
-------------------here-----------------------
kernel: Bluetooth: Core ver 2.22
kernel: NET: Registered PF_BLUETOOTH protocol family
kernel: Bluetooth: HCI device and connection manager initialized
kernel: Bluetooth: HCI socket layer initialized
kernel: Bluetooth: L2CAP socket layer initialized
kernel: Bluetooth: SCO socket layer initialized
kernel: iwlwifi 0000:00:14.3: firmware: direct-loading firmware
iwlwifi-QuZ-a0-hr-b0-67.ucode
kernel: iwlwifi 0000:00:14.3: api flags index 2 larger than supported by dr=
iver
kernel: iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
kernel: iwlwifi 0000:00:14.3: loaded firmware version 67.8f59b80b.0
QuZ-a0-hr-b0-67.ucode op_mode iwlmvm
kernel: iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (=
-2)
kernel: bluetooth hci0: firmware: direct-loading firmware intel/ibt-19-16-0=
.sfi
kernel: Bluetooth: hci0: Found device firmware: intel/ibt-19-16-0.sfi
kernel: Bluetooth: hci0: Boot Address: 0x24800
kernel: Bluetooth: hci0: Firmware Version: 125-46.21
kernel: iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=
=3D0x354
kernel: iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
systemd[1]: Starting Bluetooth service...
kernel: iwlwifi 0000:00:14.3: base HW address: b0:a4:60:b4:69:96
bluetoothd[637]: Bluetooth daemon 5.61
systemd[1]: Started Bluetooth service.
systemd[1]: Reached target Bluetooth Support.
bluetoothd[637]: Starting SDP server
dbus-daemon[505]: [system] Activating via systemd: service
name=3D'org.freedesktop.hostname1' unit=3D'dbus-org.freedesktop.hostname1.s=
ervice'
requested by ':1.12' (uid=3D0 pid=3D637 comm=3D"/usr/libexec/bluetooth/blue=
toothd ")
kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
kernel: Bluetooth: BNEP filters: protocol multicast
kernel: Bluetooth: BNEP socket layer initialized
bluetoothd[637]: Bluetooth management interface 1.21 initialized
kernel: iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
NetworkManager[664]: <info>  [1639037359.3299] rfkill1: found Wi-Fi radio
killswitch (at /sys/devices/pci0000:00/0000:00:14.3/ieee80211/phy0/rfkill1)
(driver iwlwifi)
NetworkManager[664]: <info>  [1639037359.3363] Loaded device plugin:
NMBluezManager
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.32.12/libnm-device-plugin-bluet=
ooth.so)
kernel: Bluetooth: hci0: command 0xfc01 tx timeout
bluetoothd[637]: src/profile.c:register_profile() :1.71 tried to register
00001108-0000-1000-8000-00805f9b34fb which is already registered
bluetoothd[637]: src/profile.c:register_profile() :1.71 tried to register
0000111f-0000-1000-8000-00805f9b34fb which is already registered
systemd[1]: Stopped target Bluetooth Support.
kernel: Bluetooth: hci0: FW download error recovery failed (-110)
kernel: Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
kernel: Bluetooth: hci0: Device revision is 2
kernel: Bluetooth: hci0: Secure boot is enabled
kernel: Bluetooth: hci0: OTP lock is enabled
kernel: Bluetooth: hci0: API lock is enabled
kernel: Bluetooth: hci0: Debug lock is disabled
kernel: Bluetooth: hci0: Minimum firmware build 1 week 10 2014
kernel: bluetooth hci0: firmware: direct-loading firmware intel/ibt-19-0-4.=
sfi
kernel: Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
kernel: Bluetooth: hci0: Boot Address: 0x24800
kernel: Bluetooth: hci0: Firmware Version: 191-21.21
systemd[1]: Reached target Bluetooth Support.
systemd[724]: Reached target Bluetooth.
systemd[1209]: Reached target Bluetooth.
kernel: Bluetooth: hci0: Waiting for firmware download to complete
kernel: Bluetooth: hci0: Firmware loaded in 1578507 usecs
kernel: Bluetooth: hci0: Waiting for device to boot
kernel: Bluetooth: hci0: Device booted in 14827 usecs
kernel: bluetooth hci0: firmware: direct-loading firmware intel/ibt-19-0-4.=
ddc
kernel: Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
kernel: Bluetooth: hci0: Applying Intel DDC parameters completed
kernel: Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
--------------------here-----------------

 As wrote above,the kernel loaded "intel/ibt-19-16-0.sfi" at first,but fail=
s to
load, finally it loads "intel/ibt-19-0-4.sfi" successfully. And more strang=
e, I
rebooted this kernel several times, I found the kernel became not to load
"intel/ibt-19-16-0.sfi" and load "intel/ibt-19-0-4.sfi" from the beginning =
of
boot. I'm not sure why the kernel suddenly began to load
"intel/ibt-19-0-4.sfi". Does someone let known to me why, please? I guess it
could be that "btintel.c" lacks some important sequence to AX201, an Example
for resetting the device, or some prerequisite process.

>I don't think the wifi firmware has any relation to the bluetooth firmware

 I wish the documents of the AX201 datasheet could show details.

Takahide Nojima

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
