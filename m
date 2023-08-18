Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F532C7112B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 08:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358551AbjHRIWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358575AbjHRIVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 04:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E292D7D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 01:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F46648FD
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 08:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E434FC433C8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692346911;
        bh=6C2izLVRix0x1qwYw/gJYC1TCl2PQwicBBsJsU2J9/Y=;
        h=From:To:Subject:Date:From;
        b=RcQexFg2xs+bxnUhzSv7Ou8bDORw3kWE1vMbP1yaxIMlbMgvWrYl4ZSD0Ov9gY1IB
         WspU2+I6XyveHhWL09qETwle8AAEM/YelPpe6YNVKD+HqeLpMlPts5ICfTUsdNNGCj
         3UBm6qZMiUhbHdjuv5zumd8tzYfBudBT4T4q8ExEAWXBO1dguvS3uLsR+Vd4iyaWjs
         oM6R1oma12Hk4Y7AP4wVway8LQzitiQwJRZnerpjx0lARgJNdpPsma6c8/MbcrUWKe
         FyHhuOn3gjeVCiSOgsxfUwb+OCZPJ0py3QmtQUebS3zasJtW6V6WR00y/iBHTSoIPi
         yjxp+vzjtzd5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD752C4332E; Fri, 18 Aug 2023 08:21:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217805] New: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth:
 hci0: Failed to send headers (or body or access otp area)
Date:   Fri, 18 Aug 2023 08:21:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fanf42@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217805-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217805

            Bug ID: 217805
           Summary: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0:
                    Failed to send headers (or body or access otp area)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: fanf42@gmail.com
        Regression: No

Hello,

(Sorry by advance if it's not the correct place to discuss that, but I tried
other place like my distro kernel forum
(https://bbs.archlinux.org/viewtopic.php?id=3D286929), interactive chat, et=
c and
nobody was able to help).

[1] =3D=3D Short summary =3D=3D

I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card (which =
is
actually reported by lspci as QCNFA765) and bluetooth never worked on it,
failing to load the rampatch with "failed to send header" or "failed to send
body" or "Failed to access otp area (-71)".

Other people reports bluetooth as working
(https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3) and a w=
ork
friend has a T16 AMD gen1 which seems to have exactly the same chipset and =
work
flowlessly. So perhaps it's an hardware issue, but I don't know how to qual=
ify
it if so.

=3D> How can this be further qualified/debuged/workarounded?

Any help, even RTFM pointing to corresponding manuals would be very much
appreciated.


[2] =3D=3D logs and more details =3D=3D

I have that laptop since october 2022 and use archlinux with the standard
kernels. None made bluetooth wroked since then. First install was around li=
nux
6.0.10 and current kernel: 6.4.10-arch1-10.

There is nothing obvious in bios setting that could lead to that (bluetooth=
 is
enabled).

# LSPCI

lspci -k -s 01:00.0=20
01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless
Network Adapter (rev 01)=20
Subsystem: Lenovo QCNFA765 Wireless Network Adapter=20
Kernel driver in use: ath11k_pci=20
Kernel modules: ath11k_pci


# kernel boot log: "Failed to send headers (-71)"

kernel: thinkpad_acpi: radio switch found; radios are enabled=20
kernel: thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness
control, supported by the ACPI video driver=20
kernel: thinkpad_acpi: Disabling thinkpad-acpi brightness events by default
...=20
kernel: thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocke=
d=20
...=20
rfkill[6774]: unblock set for type bluetooth sudo[6773]:
pam_unix(sudo:session): session closed for user root=20
kernel: usb 1-3.1: new full-speed USB device number 3 using xhci_hcd=20
kernel: usb 1-3.1: New USB device found, idVendor=3D10ab, idProduct=3D9309,
bcdDevice=3D 0.01 kernel: usb 1-3.1: New USB device strings: Mfr=3D0, Produ=
ct=3D0,
SerialNumber=3D0 boltd[935]: probing: started [1000]=20
kernel: Bluetooth: Core ver 2.22 kernel: NET: Registered PF_BLUETOOTH proto=
col
family kernel: Bluetooth: HCI device and connection manager initialized=20
kernel: Bluetooth: HCI socket layer initialized kernel: Bluetooth: L2CAP so=
cket
layer initialized=20
kernel: Bluetooth: SCO socket layer initialized kernel: usbcore: registered=
 new
interface driver btusb=20
systemd[1328]: Reached target Bluetooth.=20
kernel: Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00130201.bin=
=20
kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, firmware ro=
me
0x130201 build 0x38e6=20
kernel: Bluetooth: hci0: Failed to send headers (-71)=20
systemd[1]: Starting Bluetooth service...=20
bluetoothd[6866]: Bluetooth daemon 5.66=20
systemd[1]: Started Bluetooth service.=20
systemd[1]: Reached target Bluetooth Support.=20
bluetoothd[6866]: Starting SDP server bluetoothd[6866]:
profiles/audio/vcp.c:vcp_init() D-Bus experimental not enabled

# rfkill status

sudo rfkill=20
ID TYPE DEVICE SOFT HARD=20
0 bluetooth tpacpi_bluetooth_sw blocked unblocked=20
1 wlan phy0 unblocked unblocked=20

# when trying to unlock: "failed to send body at 40 of 142192 (-71)"

rfkill[105640]: unblock set for type bluetooth=20
sudo[105639]: pam_unix(sudo:session): session closed for user root=20
kernel: usb 1-3.1: new full-speed USB device number 4 using xhci_hcd=20
kernel: usb 1-3.1: New USB device found, idVendor=3D10ab, idProduct=3D9309,
bcdDevice=3D 0.01=20
kernel: usb 1-3.1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumb=
er=3D0=20
kernel: Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00130201.bin=
=20
kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, firmware ro=
me
0x130201 build 0x38e6=20
kernel: Bluetooth: hci0: Failed to send body at 40 of 142192 (-71)=20
kernel: usb 1-3.1: USB disconnect, device number 4=20
boltd[935]: probing: started [1000]=20
systemd[1328]: Reached target Bluetooth.=20
systemd[1328]: Stopped target Bluetooth.=20
systemd[1]: Reached target Bluetooth Support.=20
systemd[1]: Stopped target Bluetooth Support.=20

# unloading and loading back kernel related modules (`bluetooth`, `btusb`, =
etc)
and modprobe them back, and I get the same kind of logs after `rfkill unblo=
ck
bluetoot`:

rfkill[106483]: unblock set for type bluetooth=20
sudo[106482]: pam_unix(sudo:session): session closed for user root=20
kernel: usb 1-3.1: new full-speed USB device number 5 using xhci_hcd=20
kernel: usb 1-3.1: New USB device found, idVendor=3D10ab, idProduct=3D9309,
bcdDevice=3D 0.01=20
kernel: usb 1-3.1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumb=
er=3D0=20
kernel: usb 1-3.1: Failed to access otp area (-71)=20
kernel: usb 1-3.1: USB disconnect, device number 5=20
boltd[935]: probing: started [1000]=20
systemd[1328]: Reached target Bluetooth.=20
systemd[1]: Reached target Bluetooth Support.=20
systemd[1328]: Stopped target Bluetooth.=20
systemd[1]: Stopped target Bluetooth Support.=20
boltd[935]: probing: timeout, done: [3001068] (2000000)

Have a nice day

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
