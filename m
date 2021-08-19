Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD41C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469F861075
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 20:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhHSUfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhHSUfl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 16:35:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D81AF60720
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629405304;
        bh=YuurokQOwzms8D5Jy25H2m//DRa0qOQkvtJigCi9X4Y=;
        h=From:To:Subject:Date:From;
        b=HZqWQjELxxeyWScGvmfZ5czaOGANtz9vXb0bMJ247EejOFj0j5UqBU5QokU8cxF8R
         GfdnSbFK7MjDtsZ+pJiSNFf7aIoAUalg05nCWFN2ATWQ8vNHrAQyz4hZNn2YN5VYP6
         EyKFrkoZqqJqkHxUAdub32mfMx7HPlSZ3HSwY55UslO8beoI7DWCeGAijnS6HcTxd5
         488BqmasFudHoNgmmAHI7MHmZpiVDzO0/Ap/v3NrZvL/yMHCY77+aeSvc4t051y9tb
         eErNLFR8TIDhqYarvDi7puqCP9ud+GJbvpcPO4gAyzoaHSAliQsi1pILiMOhzMp0uf
         o3NERhrxivD9g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] New: rtl8761b usb bluetooth doesn't work following
 reboot until unplug/replug
Date:   Thu, 19 Aug 2021 20:35:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bryanhoop@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

            Bug ID: 214111
           Summary: rtl8761b usb bluetooth doesn't work following reboot
                    until unplug/replug
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bryanhoop@gmail.com
        Regression: No

I'm not sure if this is the correct place to report this problem, but since=
 the
firmware is so new I figure that it is probably a firmware bug.

I have a USB Bluetooth 5.0 dongle using the rtl8761b chipset that was recen=
tly
added to the kernel. It works fine until I reboot my computer, after which =
I am
unable to activate Bluetooth (from GNOME settings) until I unplug and replug
the dongle. Then everything starts working normally.

Logs:

After reboot (dongle not working):

`journalctl -r | grep -i bluetooth`
Aug 19 16:17:21 workstation systemd[1560]: Started Bluetooth OBEX service.
Aug 19 16:17:21 workstation systemd[1560]: Starting Bluetooth OBEX service.=
..
Aug 19 16:16:59 workstation bluetoothd[1237]: Failed to set mode: Failed (0=
x03)
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/sbc
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSink/sbc
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/sbc_xq
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSink/sbc_xq
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/aac
Aug 19 16:16:54 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/ldac
Aug 19 16:16:54 workstation kernel: Bluetooth: RFCOMM ver 1.11
Aug 19 16:16:54 workstation kernel: Bluetooth: RFCOMM socket layer initiali=
zed
Aug 19 16:16:54 workstation kernel: Bluetooth: RFCOMM TTY layer initialized
Aug 19 16:16:50 workstation bluetoothd[1237]: Loading LTKs timed out for hc=
i0
Aug 19 16:16:49 workstation NetworkManager[1358]: <info>  [1629404209.5205]
Loaded device plugin: NMBluezManager
(/usr/lib64/NetworkManager/1.30.6-1.fc34/libnm-device-plugin-bluetooth.so)
Aug 19 16:16:49 workstation kernel: Bluetooth: BNEP socket layer initialized
Aug 19 16:16:49 workstation kernel: Bluetooth: BNEP filters: protocol multi=
cast
Aug 19 16:16:49 workstation kernel: Bluetooth: BNEP (Ethernet Emulation) ver
1.3
Aug 19 16:16:49 workstation bluetoothd[1237]: Bluetooth management interface
1.20 initialized
Aug 19 16:16:49 workstation systemd[1]: Reached target Bluetooth Support.
Aug 19 16:16:49 workstation systemd[1]: Started Bluetooth service.
Aug 19 16:16:49 workstation audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D=
4294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dbluetooth
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D?
res=3Dsuccess'
Aug 19 16:16:49 workstation bluetoothd[1237]: Starting SDP server
Aug 19 16:16:48 workstation bluetoothd[1237]: Bluetooth daemon 5.60
Aug 19 16:16:48 workstation systemd[1]: Starting Bluetooth service...
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: fw version 0x0d99=
646b
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: cfg_sz 25, total =
sz
21389
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8761b_config.bin
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8761b_fw.bin
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: rom_version statu=
s=3D0
version=3D1
Aug 19 16:16:38 workstation kernel: Bluetooth: hci0: RTL: examining hci_ver=
=3D0a
hci_rev=3D000b lmp_ver=3D0a lmp_subver=3D8761
Aug 19 16:16:38 workstation kernel: Bluetooth: SCO socket layer initialized
Aug 19 16:16:38 workstation kernel: Bluetooth: L2CAP socket layer initializ=
ed
Aug 19 16:16:38 workstation kernel: Bluetooth: HCI socket layer initialized
Aug 19 16:16:38 workstation kernel: Bluetooth: HCI device and connection
manager initialized
Aug 19 16:16:38 workstation kernel: Bluetooth: Core ver 2.22
Aug 19 16:16:22 workstation kernel: usb 1-2.4: Product: Bluetooth Radio


`dmesg | grep -i bluetooth`
[    2.020516] usb 1-2.4: Product: Bluetooth Radio
[   28.530291] Bluetooth: Core ver 2.22
[   28.530379] Bluetooth: HCI device and connection manager initialized
[   28.530382] Bluetooth: HCI socket layer initialized
[   28.530384] Bluetooth: L2CAP socket layer initialized
[   28.530389] Bluetooth: SCO socket layer initialized
[   28.585079] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000b
lmp_ver=3D0a lmp_subver=3D8761
[   28.586075] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[   28.586079] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_fw.bin
[   28.589119] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_config.bin
[   28.589314] Bluetooth: hci0: RTL: cfg_sz 25, total sz 21389
[   28.704283] Bluetooth: hci0: RTL: fw version 0x0d99646b
[   39.076711] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   39.076713] Bluetooth: BNEP filters: protocol multicast
[   39.076716] Bluetooth: BNEP socket layer initialized
[   44.973247] Bluetooth: RFCOMM TTY layer initialized
[   44.973253] Bluetooth: RFCOMM socket layer initialized
[   44.973332] Bluetooth: RFCOMM ver 1.11

After unplug/replug (dongle working):

`journalctl -r | grep -i bluetooth`
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/sbc
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSink/sbc
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/sbc_xq
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSink/sbc_xq
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/aac
Aug 19 16:20:21 workstation bluetoothd[1237]: Endpoint registered: sender=
=3D:1.76
path=3D/MediaEndpoint/A2DPSource/ldac
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: fw version 0x0d99=
646b
Aug 19 16:20:20 workstation systemd[1]: Reached target Bluetooth Support.
Aug 19 16:20:20 workstation systemd[1560]: Reached target Bluetooth.
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: cfg_sz 25, total =
sz
21389
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8761b_config.bin
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: loading
rtl_bt/rtl8761b_fw.bin
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: rom_version statu=
s=3D0
version=3D1
Aug 19 16:20:20 workstation kernel: Bluetooth: hci0: RTL: examining hci_ver=
=3D0a
hci_rev=3D000b lmp_ver=3D0a lmp_subver=3D8761
Aug 19 16:20:20 workstation kernel: usb 1-2.4: Product: Bluetooth Radio
Aug 19 16:20:19 workstation systemd[1]: Stopped target Bluetooth Support.
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSource/sbc
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSink/sbc
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSource/sbc_xq
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSink/sbc_xq
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSource/aac
Aug 19 16:20:19 workstation bluetoothd[1237]: Endpoint unregistered:
sender=3D:1.76 path=3D/MediaEndpoint/A2DPSource/ldac

`dmesg | grep -i bluetooth`
[  248.282331] usb 1-2.4: USB disconnect, device number 4
[  249.115317] usb 1-2.4: new full-speed USB device number 6 using xhci_hcd
[  249.332301] usb 1-2.4: New USB device found, idVendor=3D0bda, idProduct=
=3D8771,
bcdDevice=3D 2.00
[  249.332309] usb 1-2.4: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[  249.332313] usb 1-2.4: Product: Bluetooth Radio
[  249.332315] usb 1-2.4: Manufacturer: Realtek
[  249.332317] usb 1-2.4: SerialNumber: 00E04C239987
[  249.353595] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000b
lmp_ver=3D0a lmp_subver=3D8761
[  249.354534] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[  249.354539] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_fw.bin
[  249.356429] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_config.bin
[  249.356694] Bluetooth: hci0: RTL: cfg_sz 25, total sz 21389
[  249.470211] Bluetooth: hci0: RTL: fw version 0x0d99646b

Other information:

`uname -a`
Linux workstation 5.13.10-200.fc34.x86_64 #1 SMP Fri Aug 13 20:13:23 UTC 20=
21
x86_64 x86_64 x86_64 GNU/Linux

`dnf info linux-firmware`
Name         : linux-firmware
Version      : 20210716
Release      : 121.fc34
Architecture : noarch
Size         : 195 M
Source       : linux-firmware-20210716-121.fc34.src.rpm
Repository   : @System
From repo    : updates
Summary      : Firmware files used by the Linux kernel
URL          : http://www.kernel.org/
License      : GPL+ and GPLv2+ and MIT and Redistributable, no modification
permitted
Description  : This package includes firmware files required for some devic=
es
to
             : operate.


Please let me know what other information I can provide to help debug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
