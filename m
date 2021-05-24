Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95895C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB466109F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 19:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhEXTmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 May 2021 15:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhEXTmE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 May 2021 15:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 38D476109F
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621885236;
        bh=zQ4TiNwiG7N6y34MxxUg/1m3T7LJCOVbxYy3uZ7vH1Y=;
        h=From:To:Subject:Date:From;
        b=LWzv9IIlbi4qPwTJdvqPCFi0X+Fk/c8u/Z+pdTDQ6fiUxl9MmWvrKAiSYhqHGOD9w
         tgwFrvg9nd4QBy1qBV2573oY7vAG0Rnjj3egmVie+wJ1Lmd1gt99H98lZHLT3GwnjD
         aBX9NYLgn6QAtwP4RmrDOhUbO9vgBVmG+W9tWOQGyj5Ekwpnzi8W9/aWZD/oVMpoMV
         +RWPwGxADxnY5PNUL+Qi+xUOe8O8GRWS714YSV1akFAxUaFSKpUrwyoxwjL8+lAa8q
         SD/UdPwGL9tm+INIhr+wlwBunmwDI48mfQtEUJFQvYIFgUWp6nYi1g6jkARSW3QUdj
         QHcLGFcFGNddg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213203] New: KASAN: null-ptr-deref in range
 [0x0000000000000000-0x0000000000000007] when ASUS USB-BT500 bluetooth dongle
 is connected
Date:   Mon, 24 May 2021 19:40:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-213203-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213203

            Bug ID: 213203
           Summary: KASAN: null-ptr-deref in range
                    [0x0000000000000000-0x0000000000000007] when ASUS
                    USB-BT500 bluetooth dongle is connected
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: erhard_f@mailbox.org
        Regression: No

Created attachment 296971
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296971&action=3Dedit
kernel dmesg (5.13-rc3, AMD A10 PRO-7800B)

Getting this at shutdown with my ASUS USB-BT500 bluetooth dongle connected:

[...]
general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 PID: 110 Comm: kworker/u9:0 Not tainted 5.13.0-rc3-bdver3 #4
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./FM2A88M Pro3+,
BIOS P2.60 01/11/2016
Workqueue: hci0 hci_power_off [bluetooth]
RIP: 0010:smp_del_chan+0x35/0x12f [bluetooth]
Code: c1 ea 03 48 c1 e0 2a 55 48 89 fd 80 3c 02 00 74 05 e8 70 df 43 d2 4c =
8b
65 00 b8 ff ff 37 00 48 c1 e0 2a 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 74 08 4=
c 89
e7 e8 4e df 43 d2 4d 8b 24 24 b8 ff ff 37
RSP: 0018:ffff88811896fca0 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: ffff88811fb6a000 RCX: 1ffff1102312df86
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88816e770800
RBP: ffff88816e770800 R08: ffffed1023f6d403 R09: ffff88811fb6a017
R10: 0000000000000001 R11: ffffffff94fabad1 R12: 0000000000000000
R13: ffff88811fb6a0a8 R14: dffffc0000000000 R15: ffff88811fb6b758
FS:  0000000000000000(0000) GS:ffff888377f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6acdb50000 CR3: 000000012f1fc000 CR4: 00000000000506e0
Call Trace:
 smp_unregister+0x42/0x83 [bluetooth]
 hci_dev_do_close+0x455/0x7b1 [bluetooth]
 ? hci_inquiry+0x58f/0x58f [bluetooth]
 ? rcu_read_lock_sched_held+0x73/0xc8
 process_one_work+0x625/0x99f
 ? rcu_read_unlock+0x59/0x59
 ? cancel_delayed_work+0xe9/0xe9
 ? __raw_spin_lock_init+0xf0/0xf0
 worker_thread+0x47a/0x597
 ? __kthread_parkme+0x6f/0xc3
 kthread+0x2b6/0x2c5
 ? drain_workqueue+0x268/0x268
 ? kthread_unpark+0x82/0x82
 ret_from_fork+0x22/0x30
Modules linked in: rfcomm cmac bnep dm_crypt nhpoly1305_sse2 nhpoly1305
chacha_generic chacha_x86_64 libchacha adiantum libpoly1305 algif_skcipher
dm_mod input_leds joydev btusb btrtl btbcm hid_generic btintel bluetooth
jitterentropy_rng usbhid hid drbg ansi_cprng ecdh_generic ecc rfkill raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx md_mod evdev amd=
gpu
edac_mce_amd crc32_generic crc32_pclmul ohci_pci f2fs lz4hc_compress
lz4_compress lz4_decompress aesni_intel libaes crypto_simd cryptd k10temp
fam15h_power i2c_piix4 ext4 snd_hda_codec_realtek crc16 snd_hda_codec_gener=
ic
mbcache ledtrig_audio drm_ttm_helper led_class jbd2 ttm snd_hda_codec_hdmi
mfd_core snd_hda_intel gpu_sched i2c_algo_bit snd_intel_dspcfg xhci_pci
snd_hda_codec drm_kms_helper ohci_hcd ehci_pci snd_hwdep cfbfillrect ehci_h=
cd
syscopyarea cfbimgblt sysfillrect snd_hda_core xhci_hcd sysimgblt acpi_cpuf=
req
fb_sys_fops cfbcopyarea snd_pcm snd_timer fb usbcore font video snd usb_com=
mon
fbdev
 soundcore button processor zram zsmalloc nct6775 hwmon_vid hwmon nfsd
auth_rpcgss lockd drm grace drm_panel_orientation_quirks fuse backlight
configfs sunrpc efivarfs
---[ end trace ef1888241aeb31e2 ]---
RIP: 0010:smp_del_chan+0x35/0x12f [bluetooth]
Code: c1 ea 03 48 c1 e0 2a 55 48 89 fd 80 3c 02 00 74 05 e8 70 df 43 d2 4c =
8b
65 00 b8 ff ff 37 00 48 c1 e0 2a 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 74 08 4=
c 89
e7 e8 4e df 43 d2 4d 8b 24 24 b8 ff ff 37
RSP: 0018:ffff88811896fca0 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: ffff88811fb6a000 RCX: 1ffff1102312df86
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88816e770800
RBP: ffff88816e770800 R08: ffffed1023f6d403 R09: ffff88811fb6a017
R10: 0000000000000001 R11: ffffffff94fabad1 R12: 0000000000000000
R13: ffff88811fb6a0a8 R14: dffffc0000000000 R15: ffff88811fb6b758
FS:  0000000000000000(0000) GS:ffff888377f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6acdb50000 CR3: 000000012f1fc000 CR4: 00000000000506e0
[...]


 # inxi -bZ
System:    Host: yea Kernel: 5.13.0-rc3-bdver3 x86_64 bits: 64 Console: tty=
 1
Distro: Gentoo Base System release 2.7=20
Machine:   Type: Desktop Mobo: ASRock model: FM2A88M Pro3+ serial: N/A UEFI:
American Megatrends v: P2.60 date: 01/11/2016=20
CPU:       Info: Quad Core AMD A10 PRO-7800B R7 12 Compute Cores 4C+8G [MCP]
speed: 1897 MHz min/max: 1400/3500 MHz=20
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Kaveri [Radeon R7
Graphics] driver: amdgpu v: kernel=20
           Display: server: X.org 1.20.11 driver: amdgpu,ati unloaded:
fbdev,modesetting tty: 211x54=20
           Message: Advanced graphics data unavailable in console for root.=
=20
Network:   Device-1: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet
driver: r8169


 # lsusb -s 007:002 -v

Bus 007 Device 002: ID 0b05:190e ASUSTek Computer, Inc. ASUS USB-BT500
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0b05 ASUSTek Computer, Inc.
  idProduct          0x190e=20
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 ASUS USB-BT500
  iSerial                 3 00E04C239987
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0001
  Self Powered

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
