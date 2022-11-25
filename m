Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A50CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Nov 2022 02:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYClh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Nov 2022 21:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYClg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Nov 2022 21:41:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB31264A5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 18:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB0E6228E
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Nov 2022 02:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FB92C433D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Nov 2022 02:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669344093;
        bh=Ltvz4lVfsKkA+RP5ucsbAa3IcCjEJF/YQSyil8vY774=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gFmLUcnnttfXxA6PSp/YH4ujE+H7LDqyQ3aZs4V4M/E2uhiVxTkK3/VmO4aRaZucJ
         b+QGr5xcNsSobd0IqNr8M82wLxv8KwgTw0eDQKR3o7n/IHPfwH0D+jIZmtoOS/HPcd
         7/xmsx69wqu2gj7B5hern30tB52GzFpPu1NqOCgS7bRCW2UVPlujcQbj/+SUsIuwcs
         gQR78K+FxRnuDBWWyGNhcf+DR5V4WHnhEuWxHXhWBxTNNI73ZxAYBZxAKZMdfa4mbK
         bC8pLeHlojlPqLnInXXez3Hk4DGRwVvaNtCaTqHJVr5NKxhn+CVHXbQ/MbE/ydIhnl
         p+Io3sWrzgHJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 503FDC433E4; Fri, 25 Nov 2022 02:41:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] notifier callback hci_suspend_notifier [bluetooth]
 already registered
Date:   Fri, 25 Nov 2022 02:41:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216683-62941-zQiXJvsIVJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

Jack (ostroffjh@users.sourceforge.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ostroffjh@users.sourceforge
                   |                            |.net

--- Comment #1 from Jack (ostroffjh@users.sourceforge.net) ---
I'm getting what may be the same issue not quite daily, without any
unplug/replug of my cheap CSR clone BT dongles.  I'm currently on 6.0.8 (Ge=
ntoo
sources) with what I think is the same patchset mentioned above.  (That link
shows no current patches for me.)  When it happens, the PC seems to respond=
 for
a while, but by the time I realize there is a problem, a power cycle is the
only recovery that works for me.=20=20

Nov 23 14:23:29 ffortso9 kernel: ------------[ cut here ]------------
Nov 23 14:23:29 ffortso9 kernel: notifier callback hci_suspend_notifier
[bluetooth] already registered
Nov 23 14:23:29 ffortso9 kernel: WARNING: CPU: 6 PID: 2174 at
kernel/notifier.c:28 notifier_chain_register+0x3e/0x70
Nov 23 14:23:29 ffortso9 kernel: Modules linked in: fuse rfcomm auth_rpcgss
nfsv4 dns_resolver nfs lockd grace fscache netfs sunrpc cmac algif_skcipher
bnep vfat fat amdgpu mfd_core iommu_v2 gpu_sched drm_buddy radeon uvcvideo
btusb videobuf2_vmalloc btrtl kvm_amd btbcm videobuf2_memops i2c_algo_bit
btintel videobuf2_v4l2 kvm drm_ttm_helper snd_usb_audio videobuf2_common
bluetooth ttm snd_usbmidi_lib irqbypass crct10dif_pclmul snd_hda_codec_real=
tek
videodev drm_display_helper crc32_pclmul sr_mod snd_rawmidi rfkill
snd_hda_codec_generic crc32c_intel mc ecdh_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel drm_kms_helper cdrom ghash_clmulni_intel
snd_intel_dspcfg sd_mod syscopyarea snd_hda_codec sysfillrect sysimgblt nct=
6775
snd_hwdep aic7xxx aesni_intel fb_sys_fops snd_hda_core nct6775_core ppdev
hwmon_vid crypto_simd cryptd scsi_transport_spi snd_pcm drm sp5100_tco
snd_timer xhci_pci pcspkr backlight rapl xhci_pci_renesas snd i2c_piix4
parport_pc cec ccp ahci efi_pstore soundcore xhci_hcd k10temp
Nov 23 14:23:29 ffortso9 kernel:  parport libahci i2c_core gpio_amdpt
gpio_generic acpi_cpufreq efivarfs
Nov 23 14:23:29 ffortso9 kernel: CPU: 6 PID: 2174 Comm: kworker/6:1 Not tai=
nted
6.0.8-gentoo-x86_64-01 #1
Nov 23 14:23:29 ffortso9 kernel: Hardware name: Micro-Star International Co=
.,
Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.M0 01/23/2019
Nov 23 14:23:29 ffortso9 kernel: Workqueue: usb_hub_wq hub_event
Nov 23 14:23:29 ffortso9 kernel: RIP: 0010:notifier_chain_register+0x3e/0x70
Nov 23 14:23:29 ffortso9 kernel: Code: 10 7f 33 75 04 84 d2 75 3b 48 8d 78 =
08
48 8b 40 08 48 85 c0 74 20 48 39 c6 75 e0 48 8b 36 48 c7 c7 40 ad 34 8b e8 =
a9
f1 a7 00 <0f> 0b b8 ef ff ff ff e9 e6 17 d6 00 48 89 46 08 31 c0 48 89 37 e9
Nov 23 14:23:29 ffortso9 kernel: RSP: 0018:ffffb3e0d420f7d8 EFLAGS: 00010286
Nov 23 14:23:29 ffortso9 kernel: RAX: 0000000000000000 RBX: ffffffffc0a91170
RCX: 0000000000000000
Nov 23 14:23:29 ffortso9 kernel: RDX: 0000000000000001 RSI: ffffffff8b39ae13
RDI: 00000000ffffffff
Nov 23 14:23:29 ffortso9 kernel: RBP: ffffffff8b64f0a0 R08: 0000000000000000
R09: ffffffff8bdc0da0
Nov 23 14:23:29 ffortso9 kernel: R10: 0000000000000001 R11: 0000000000000001
R12: ffff8c647188cb78
Nov 23 14:23:29 ffortso9 kernel: R13: ffffffff8b64f0c8 R14: ffff8c647188cd08
R15: ffffffffc0f1a7e0
Nov 23 14:23:29 ffortso9 kernel: FS:  0000000000000000(0000)
GS:ffff8c6afa780000(0000) knlGS:0000000000000000
Nov 23 14:23:29 ffortso9 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov 23 14:23:29 ffortso9 kernel: CR2: 00007f0c4c003078 CR3: 00000001db098000
CR4: 00000000003506e0
Nov 23 14:23:29 ffortso9 kernel: Call Trace:
Nov 23 14:23:29 ffortso9 kernel:  <TASK>
Nov 23 14:23:29 ffortso9 kernel:  blocking_notifier_chain_register+0x3d/0x80
Nov 23 14:23:29 ffortso9 kernel:  hci_register_dev+0x32d/0x3e0 [bluetooth]
Nov 23 14:23:29 ffortso9 kernel:  btusb_probe+0xc24/0xdea [btusb]
Nov 23 14:23:29 ffortso9 kernel:  ? recalibrate_cpu_khz+0x10/0x10
Nov 23 14:23:29 ffortso9 kernel:  ? ktime_get_mono_fast_ns+0x3d/0x90
Nov 23 14:23:29 ffortso9 kernel:  usb_probe_interface+0xf6/0x2d0
Nov 23 14:23:29 ffortso9 kernel:  really_probe+0xe1/0x3a0
Nov 23 14:23:29 ffortso9 kernel:  ? pm_runtime_barrier+0x61/0xb0
Nov 23 14:23:29 ffortso9 kernel:  __driver_probe_device+0x78/0x180
Nov 23 14:23:29 ffortso9 kernel:  driver_probe_device+0x2c/0xb0
Nov 23 14:23:29 ffortso9 kernel:  __device_attach_driver+0x8c/0x100
Nov 23 14:23:29 ffortso9 kernel:  ? driver_allows_async_probing+0x60/0x60
Nov 23 14:23:29 ffortso9 kernel:  ? driver_allows_async_probing+0x60/0x60
Nov 23 14:23:29 ffortso9 kernel:  bus_for_each_drv+0x7e/0xd0
Nov 23 14:23:29 ffortso9 kernel:  __device_attach+0xca/0x230
Nov 23 14:23:29 ffortso9 kernel:  bus_probe_device+0x8e/0xb0
Nov 23 14:23:29 ffortso9 kernel:  device_add+0x45c/0x970
Nov 23 14:23:29 ffortso9 kernel:  ? preempt_count_add+0x70/0xa0
Nov 23 14:23:29 ffortso9 kernel:  usb_set_configuration+0x483/0x890
Nov 23 14:23:29 ffortso9 kernel:  usb_generic_driver_probe+0x50/0x70
Nov 23 14:23:29 ffortso9 kernel:  usb_probe_device+0x47/0x110
Nov 23 14:23:29 ffortso9 kernel:  really_probe+0xe1/0x3a0
Nov 23 14:23:29 ffortso9 kernel:  ? pm_runtime_barrier+0x61/0xb0
Nov 23 14:23:29 ffortso9 kernel:  __driver_probe_device+0x78/0x180
Nov 23 14:23:29 ffortso9 kernel:  driver_probe_device+0x2c/0xb0
Nov 23 14:23:29 ffortso9 kernel:  __device_attach_driver+0x8c/0x100
Nov 23 14:23:29 ffortso9 kernel:  ? driver_allows_async_probing+0x60/0x60
Nov 23 14:23:29 ffortso9 kernel:  ? driver_allows_async_probing+0x60/0x60
Nov 23 14:23:29 ffortso9 kernel:  bus_for_each_drv+0x7e/0xd0
Nov 23 14:23:29 ffortso9 kernel:  __device_attach+0xca/0x230
Nov 23 14:23:29 ffortso9 kernel:  bus_probe_device+0x8e/0xb0
Nov 23 14:23:29 ffortso9 kernel:  device_add+0x45c/0x970
Nov 23 14:23:29 ffortso9 kernel:  ? blake2s_update+0x5c/0xe0
Nov 23 14:23:29 ffortso9 kernel:  usb_new_device.cold+0x148/0x36a
Nov 23 14:23:29 ffortso9 kernel:  hub_event+0xfa8/0x1950
Nov 23 14:23:29 ffortso9 kernel:  process_one_work+0x1e5/0x3b0
Nov 23 14:23:29 ffortso9 kernel:  ? rescuer_thread+0x390/0x390
Nov 23 14:23:29 ffortso9 kernel:  worker_thread+0x50/0x3b0
Nov 23 14:23:29 ffortso9 kernel:  ? rescuer_thread+0x390/0x390
Nov 23 14:23:29 ffortso9 kernel:  kthread+0xe8/0x110
Nov 23 14:23:29 ffortso9 kernel:  ? kthread_complete_and_exit+0x20/0x20
Nov 23 14:23:29 ffortso9 kernel:  ret_from_fork+0x22/0x30
Nov 23 14:23:29 ffortso9 kernel:  </TASK>
Nov 23 14:23:29 ffortso9 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 14:23:29 ffortso9 kernel: btusb: probe of 1-1:1.0 failed with error =
-17
Nov 23 14:23:31 ffortso9 kernel: general protection fault, probably for
non-canonical address 0xff4c6734ff4f2703: 0000 [#1] PREEMPT SMP NOPTI
Nov 23 14:23:31 ffortso9 kernel: CPU: 6 PID: 2174 Comm: kworker/6:1 Tainted=
: G=20
      W          6.0.8-gentoo-x86_64-01 #1
Nov 23 14:23:31 ffortso9 kernel: Hardware name: Micro-Star International Co=
.,
Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.M0 01/23/2019
Nov 23 14:23:31 ffortso9 kernel: Workqueue: pm pm_runtime_work
Nov 23 14:23:31 ffortso9 kernel: RIP:
0010:queued_spin_lock_slowpath+0x25b/0x2a0
Nov 23 14:23:31 ffortso9 kernel: Code: ff f3 90 48 8b 13 48 85 d2 74 f6 eb =
d6
c1 ea 12 83 e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 00 c0 02 00 48 03 04 d5 =
20
18 43 8b <48> 89 18 8b 43 08 85 c0 75 09 f3 90 8b 53 08 85 d2 74 f7 48 8b 13
Nov 23 14:23:31 ffortso9 kernel: RSP: 0018:ffffb3e0d420fcf8 EFLAGS: 00010086
Nov 23 14:23:31 ffortso9 kernel: RAX: ff4c6734ff4f2703 RBX: ffff8c6afa7ac000
RCX: 0000000000000007
Nov 23 14:23:31 ffortso9 kernel: RDX: 0000000000003ffe RSI: ffffffff8b39ae13
RDI: ffffffff8b368d04
Nov 23 14:23:31 ffortso9 kernel: RBP: ffff8c64692be18c R08: ffff8c6a62350800
R09: ffff8c64692be8a8
Nov 23 14:23:31 ffortso9 kernel: R10: 0000000000000003 R11: 000000000018e656
R12: 00000000001c0000
Nov 23 14:23:31 ffortso9 kernel: R13: 00000000001c0000 R14: 0000000000000002
R15: ffff8c6afa7b2105
Nov 23 14:23:31 ffortso9 kernel: FS:  0000000000000000(0000)
GS:ffff8c6afa780000(0000) knlGS:0000000000000000
Nov 23 14:23:31 ffortso9 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov 23 14:23:31 ffortso9 kernel: CR2: 0000562aa8908098 CR3: 0000000103c8a000
CR4: 00000000003506e0
Nov 23 14:23:31 ffortso9 kernel: Call Trace:
Nov 23 14:23:31 ffortso9 kernel:  <TASK>
Nov 23 14:23:31 ffortso9 kernel:  btusb_suspend+0x87/0x1c0 [btusb]
Nov 23 14:23:31 ffortso9 kernel:  usb_suspend_both+0xaa/0x220
Nov 23 14:23:31 ffortso9 kernel:  usb_runtime_suspend+0x2b/0x70
Nov 23 14:23:31 ffortso9 kernel:  ? usb_autoresume_device+0x60/0x60
Nov 23 14:23:31 ffortso9 kernel:  __rpm_callback+0x5b/0x140
Nov 23 14:23:31 ffortso9 kernel:  ? usb_autoresume_device+0x60/0x60
Nov 23 14:23:31 ffortso9 kernel:  rpm_callback+0x79/0x90
Nov 23 14:23:31 ffortso9 kernel:  ? usb_autoresume_device+0x60/0x60
Nov 23 14:23:31 ffortso9 kernel:  rpm_suspend+0x14a/0x730
Nov 23 14:23:31 ffortso9 kernel:  ? vtime_task_switch_generic+0x8d/0xf0
Nov 23 14:23:31 ffortso9 kernel:  ? _raw_spin_unlock+0x12/0x40
Nov 23 14:23:31 ffortso9 kernel:  ? finish_task_switch.isra.0+0x96/0x2d0
Nov 23 14:23:31 ffortso9 kernel:  pm_runtime_work+0x94/0xa0
Nov 23 14:23:31 ffortso9 kernel:  process_one_work+0x1e5/0x3b0
Nov 23 14:23:31 ffortso9 kernel:  ? rescuer_thread+0x390/0x390
Nov 23 14:23:31 ffortso9 kernel:  worker_thread+0x50/0x3b0
Nov 23 14:23:31 ffortso9 kernel:  ? rescuer_thread+0x390/0x390
Nov 23 14:23:31 ffortso9 kernel:  kthread+0xe8/0x110
Nov 23 14:23:31 ffortso9 kernel:  ? kthread_complete_and_exit+0x20/0x20
Nov 23 14:23:31 ffortso9 kernel:  ret_from_fork+0x22/0x30
Nov 23 14:23:31 ffortso9 kernel:  </TASK>
Nov 23 14:23:31 ffortso9 kernel: Modules linked in: fuse rfcomm auth_rpcgss
nfsv4 dns_resolver nfs lockd grace fscache netfs sunrpc cmac algif_skcipher
bnep vfat fat amdgpu mfd_core iommu_v2 gpu_sched drm_buddy radeon uvcvideo
btusb videobuf2_vmalloc btrtl kvm_amd btbcm videobuf2_memops i2c_algo_bit
btintel videobuf2_v4l2 kvm drm_ttm_helper snd_usb_audio videobuf2_common
bluetooth ttm snd_usbmidi_lib irqbypass crct10dif_pclmul snd_hda_codec_real=
tek
videodev drm_display_helper crc32_pclmul sr_mod snd_rawmidi rfkill
snd_hda_codec_generic crc32c_intel mc ecdh_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel drm_kms_helper cdrom ghash_clmulni_intel
snd_intel_dspcfg sd_mod syscopyarea snd_hda_codec sysfillrect sysimgblt nct=
6775
snd_hwdep aic7xxx aesni_intel fb_sys_fops snd_hda_core nct6775_core ppdev
hwmon_vid crypto_simd cryptd scsi_transport_spi snd_pcm drm sp5100_tco
snd_timer xhci_pci pcspkr backlight rapl xhci_pci_renesas snd i2c_piix4
parport_pc cec ccp ahci efi_pstore soundcore xhci_hcd k10temp
Nov 23 14:23:31 ffortso9 kernel:  parport libahci i2c_core gpio_amdpt
gpio_generic acpi_cpufreq efivarfs
Nov 23 14:23:31 ffortso9 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 14:23:31 ffortso9 kernel: RIP:
0010:queued_spin_lock_slowpath+0x25b/0x2a0
Nov 23 14:23:31 ffortso9 kernel: Code: ff f3 90 48 8b 13 48 85 d2 74 f6 eb =
d6
c1 ea 12 83 e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 00 c0 02 00 48 03 04 d5 =
20
18 43 8b <48> 89 18 8b 43 08 85 c0 75 09 f3 90 8b 53 08 85 d2 74 f7 48 8b 13
Nov 23 14:23:31 ffortso9 kernel: RSP: 0018:ffffb3e0d420fcf8 EFLAGS: 00010086
Nov 23 14:23:31 ffortso9 kernel: RAX: ff4c6734ff4f2703 RBX: ffff8c6afa7ac000
RCX: 0000000000000007
Nov 23 14:23:31 ffortso9 kernel: RDX: 0000000000003ffe RSI: ffffffff8b39ae13
RDI: ffffffff8b368d04
Nov 23 14:23:31 ffortso9 kernel: RBP: ffff8c64692be18c R08: ffff8c6a62350800
R09: ffff8c64692be8a8
Nov 23 14:23:31 ffortso9 kernel: R10: 0000000000000003 R11: 000000000018e656
R12: 00000000001c0000
Nov 23 14:23:31 ffortso9 kernel: R13: 00000000001c0000 R14: 0000000000000002
R15: ffff8c6afa7b2105
Nov 23 14:23:31 ffortso9 kernel: FS:  0000000000000000(0000)
GS:ffff8c6afa780000(0000) knlGS:0000000000000000
Nov 23 14:23:31 ffortso9 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Nov 23 14:23:31 ffortso9 kernel: CR2: 0000562aa8908098 CR3: 0000000103c8a000
CR4: 00000000003506e0
Nov 23 14:23:31 ffortso9 kernel: note: kworker/6:1[2174] exited with
preempt_count 1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
