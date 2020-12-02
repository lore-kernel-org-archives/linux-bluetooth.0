Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A865FC64E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AF208FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 13:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgLBNqY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLBNqY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 08:46:24 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210453] New: rtl8822cu device : "Bluetooth : No device found"
Date:   Wed, 02 Dec 2020 13:45:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: forum.viennet@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210453-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210453

            Bug ID: 210453
           Summary: rtl8822cu device : "Bluetooth : No device found"
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.12 mainline
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: forum.viennet@free.fr
        Regression: No

Hi,

The bluetooth with device rtl8822cu does not work with 5.9.12 mainline kernel
(and all 5.9 kernel).

Before it worked fine with 5.8.0 mainline kernel.

A similar problem was solved for rl8822ce in 5.9.11 kernel by arch.
Discussion here : https://bbs.archlinux.org/viewtopic.php?pid=1940003#p1940003

I'm new here, so let me know what attachment you need.

Thank you.

meloli@Asus-A17:~$ sudo dmesg | grep -i bluetooth
[ 1.476073] usb 5-1: Product: Bluetooth Radio
[ 3.977975] Bluetooth: Core ver 2.22
[ 3.978022] Bluetooth: HCI device and connection manager initialized
[ 3.978030] Bluetooth: HCI socket layer initialized
[ 3.978035] Bluetooth: L2CAP socket layer initialized
[ 3.978043] Bluetooth: SCO socket layer initialized
[ 4.002039] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a
lmp_subver=8822
[ 4.003996] Bluetooth: hci0: RTL: rom_version status=0 version=3
[ 4.004001] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[ 4.006885] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[ 4.007705] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422
[ 4.283989] Bluetooth: hci0: RTL: fw version 0x09993aa1
[ 4.933204] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 4.933207] Bluetooth: BNEP filters: protocol multicast
[ 4.933214] Bluetooth: BNEP socket layer initialized
[ 1422.650815] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
lmp_ver=0a lmp_subver=8822
[ 1422.652695] Bluetooth: hci0: RTL: rom_version status=0 version=3
[ 1422.652725] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[ 1422.652877] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[ 1422.653058] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422
[ 1422.931399] Bluetooth: hci0: RTL: fw version 0x09993aa1
[ 1632.862056] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=0999
lmp_ver=0a lmp_subver=3aa1
[ 1632.862064] Bluetooth: hci0: RTL: unknown IC info, lmp subver 3aa1, hci rev
0999, hci ver 000a
[ 1632.862065] Bluetooth: hci0: RTL: assuming no firmware upload needed
meloli@Asus-A17:~$ lsmod|grep blue
bluetooth 647168 12 btrtl,btintel,btbcm,bnep,btusb
ecdh_generic 16384 1 bluetooth

meloli@Asus-A17:~$ lsusb
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 002: ID 13d3:3548 IMC Networks Bluetooth Radio
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 002: ID 0951:1666 Kingston Technology DataTraveler 100 G3/G4/SE9
G2
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 13d3:56a2 IMC Networks USB2.0 HD UVC WebCam
Bus 003 Device 002: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

meloli@Asus-A17:~$ rfkill list all
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
3: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
---
ProblemType: Bug
ApportVersion: 2.20.11-0ubuntu27.13
Architecture: amd64
CasperMD5CheckResult: skip
CurrentDesktop: KDE
DistroRelease: Ubuntu 20.04
InstallationDate: Installed on 2020-09-18 (75 days ago)
InstallationMedia: Kubuntu 20.04.1 LTS "Focal Fossa" - Release amd64 (20200731)
NonfreeKernelModules: nvidia_modeset nvidia
Package: linux (not installed)
Tags: focal
Uname: Linux 5.9.12-050912-generic x86_64
UnreportableReason: The running kernel is not an Ubuntu kernel
UpgradeStatus: No upgrade log present (probably fresh install)
UserGroups: adm cdrom dip lp lpadmin lxd plugdev sambashare sudo vboxusers
_MarkForUpload: True

-- 
You are receiving this mail because:
You are the assignee for the bug.
