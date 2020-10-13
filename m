Return-Path: <SRS0=LHzf=DU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D6C433E7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Oct 2020 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA20B2491E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Oct 2020 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgJMPWO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgJMPWO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Oct 2020 11:22:14 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209659] New: Intel USB bluetooth 8087:0026 device is gone after
 system resume
Date:   Tue, 13 Oct 2020 15:22:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: pawelwod@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-209659-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209659

            Bug ID: 209659
           Summary: Intel USB bluetooth 8087:0026 device is gone after
                    system resume
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.0-050900
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pawelwod@gmail.com
        Regression: No

I'm facing an issue that the BT device is gone after I suspend and resume.
Kernel say that device is disconnected and thats it.
I tried following options for btusb module
        enable_autosuspend=0
        enable_autosuspend=0 reset=1

Also tried set power/persistent = 0/1 but result is still the same. Only reboot
helps in bringing it back.
In addition I checked that BT + suspend/resume is working fine under Windows
10.

Hardware:
        Lenovo ThinkBook 15 IIL.

BIOS is updated to latest one from Lenovo site
        DJCN18WW 05/08/2020

The BT device is
        Bus 003 Device 005: ID 8087:0026 Intel Corp.

OS is Ubuntu 18.04, issue happens on distro kernel kernel 5.4 and mainline 5.9

Here is USB dev tree before suspand:
$ lsusb -t
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 10000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
    |__ Port 6: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 6: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
    |__ Port 10: Dev 5, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 10: Dev 5, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 480M

And after resume:
$ lsusb -t
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 10000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
    |__ Port 6: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 6: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 480M

# dmesg --follow 
[ 5577.434207] PM: suspend entry (deep)
[ 5577.441904] Filesystems sync: 0.007 seconds
[ 5577.469737] Freezing user space processes ... (elapsed 0.253 seconds) done.
[ 5577.722933] OOM killer disabled.
[ 5577.722935] Freezing remaining freezable tasks ... (elapsed 0.001 seconds)
done.
[ 5577.724425] printk: Suspending console(s) (use no_console_suspend to debug)
[ 5577.732989] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[ 5577.733160] sd 1:0:0:0: [sda] Stopping disk
[ 5577.876476] ACPI: EC: interrupt blocked
[ 5577.903742] ACPI: Preparing to enter system sleep state S3
[ 5577.904817] ACPI: EC: event blocked
[ 5577.904817] ACPI: EC: EC stopped
[ 5577.904818] PM: Saving platform NVS memory
[ 5577.904958] Disabling non-boot CPUs ...
[ 5577.906547] smpboot: CPU 1 is now offline
[ 5577.909407] smpboot: CPU 2 is now offline
[ 5577.912277] smpboot: CPU 3 is now offline
[ 5577.915730] smpboot: CPU 4 is now offline
[ 5577.917458] IRQ 122: no longer affine to CPU5
[ 5577.917468] IRQ 139: no longer affine to CPU5
[ 5577.918488] smpboot: CPU 5 is now offline
[ 5577.919933] IRQ 123: no longer affine to CPU6
[ 5577.919939] IRQ 127: no longer affine to CPU6
[ 5577.920965] smpboot: CPU 6 is now offline
[ 5577.922347] IRQ 126: no longer affine to CPU7
[ 5577.922356] IRQ 138: no longer affine to CPU7
[ 5577.923374] smpboot: CPU 7 is now offline
[ 5577.926418] ACPI: Low-level resume complete
[ 5577.926523] ACPI: EC: EC started
[ 5577.926523] PM: Restoring platform NVS memory
[ 5577.927744] Enabling non-boot CPUs ...
[ 5577.927791] x86: Booting SMP configuration:
[ 5577.927791] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 5577.928147] smpboot: Scheduler frequency invariance went wobbly, disabling!
[ 5577.928608] CPU1 is up
[ 5577.928635] smpboot: Booting Node 0 Processor 2 APIC 0x4
[ 5577.929474] CPU2 is up
[ 5577.929518] smpboot: Booting Node 0 Processor 3 APIC 0x6
[ 5577.930334] CPU3 is up
[ 5577.930358] smpboot: Booting Node 0 Processor 4 APIC 0x1
[ 5577.931205] CPU4 is up
[ 5577.931233] smpboot: Booting Node 0 Processor 5 APIC 0x3
[ 5577.931869] CPU5 is up
[ 5577.931922] smpboot: Booting Node 0 Processor 6 APIC 0x5
[ 5577.932693] CPU6 is up
[ 5577.932731] smpboot: Booting Node 0 Processor 7 APIC 0x7
[ 5577.933584] CPU7 is up
[ 5577.937061] ACPI: Waking up from system sleep state S3
[ 5577.939947] ACPI: EC: interrupt unblocked
[ 5577.964623] ACPI: EC: event unblocked
[ 5577.964859] sd 1:0:0:0: [sda] Starting disk
[ 5577.965667] usb usb1: root hub lost power or was reset
[ 5577.965668] usb usb2: root hub lost power or was reset
[ 5577.972953] nvme nvme0: 8/0/0 default/read/poll queues
[ 5578.192386] usb 3-6: reset high-speed USB device number 3 using xhci_hcd
[ 5578.275913] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 5578.276164] ata2.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[ 5578.276166] ata2.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[ 5578.276168] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[ 5578.276449] ata2.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[ 5578.276450] ata2.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[ 5578.276451] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[ 5578.276536] ata2.00: configured for UDMA/133
[ 5580.279667] acpi LNXPOWER:05: Turning OFF
[ 5580.279844] acpi LNXPOWER:04: Turning OFF
[ 5580.279997] acpi LNXPOWER:03: Turning OFF
[ 5580.280043] OOM killer enabled.
[ 5580.280044] Restarting tasks ... 
[ 5580.280127] usb 3-10: USB disconnect, device number 5
[ 5580.284916] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[ 5580.285409] done.
[ 5580.286759] PM: suspend exit
[ 5580.344191] Generic FE-GE Realtek PHY r8169-100:00: attached PHY driver
[Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-100:00, irq=IGNORE)
[ 5580.472295] r8169 0000:01:00.0 enp1s0: Link is Down

-- 
You are receiving this mail because:
You are the assignee for the bug.
