Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1740C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 23:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJHXoJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Oct 2022 19:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHXoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Oct 2022 19:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327F3A171
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Oct 2022 16:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8614960B88
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Oct 2022 23:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBE5BC43142
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Oct 2022 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665272644;
        bh=DkweFgW29y1q/7U7+maVpWLQywo+7EM38r6M+QUYPlU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uNLPntvVrMwIeZtdBGSvfNEkGKqTai/Ad5z3RHWN2e/M/wENa+4aXuxIG+gTyHja2
         U4IQhvwb9FkoIE5PfFuNUeRufNseZFRfFPdxpxNld/fla1cFq4E8DK5OqHO0/gCouj
         UvEHsm0hnWmZc4mljCR+k6BQdAt+l3ohoAXRt4o1amLScoINry9TBg/EyByhCl3EDB
         N7f5Ru9+/Nk3PFZPkTbLjq+aQrbkZumw2xzIG1D88ynlMH+JcVhMEHlUFKX99HH6Xd
         daCM4NoGB1ue81M5s6/HnIEQgl7ghdpW2VqYC17lsWNqpm70uXisVXk6nwclHeE9Hx
         NDYAvgFxwtObQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CCAB3C433E9; Sat,  8 Oct 2022 23:44:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 08 Oct 2022 23:44:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-93j8D3zBrU@https.bugzilla.kernel.org/>
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

--- Comment #232 from Jack (ostroffjh@users.sourceforge.net) ---
I guess it's just been too quiet here.  I have one of those Chinese dongles
that started working based on patches much earlier in this thread, and then
without the patch with an earlier 5.1x kernel.  It worked fine with all of =
the
5.19.x kernels I used, but it won't work with 6.0.0.  From dmesg:

[19435.084529] usb 1-2: new full-speed USB device number 7 using xhci_hcd
[19435.402402] usb 1-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[19435.402411] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[19435.402413] usb 1-2: Product: BT DONGLE10
[19435.415159] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[19435.415166] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[19435.415171] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[19435.415173] Bluetooth: hci0: HCI Set Event Filter command not supported.
[19435.456635] usb 1-2: USB disconnect, device number 7
[19435.457303] Bluetooth: hci0: Opcode 0x c58 failed: -19
[19438.934106] usb 1-2: new full-speed USB device number 8 using xhci_hcd
[19439.255461] usb 1-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[19439.255469] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[19439.255472] usb 1-2: Product: BT DONGLE10
[19439.264346] ------------[ cut here ]------------
[19439.264352] notifier callback hci_suspend_notifier [bluetooth] already
registered
[19439.264388] WARNING: CPU: 6 PID: 13828 at kernel/notifier.c:28
notifier_chain_register+0x3e/0x70
[19439.264395] Modules linked in: auth_rpcgss nfsv4 dns_resolver nfs lockd
grace fscache netfs sunrpc bnep amdgpu mfd_core iommu_v2 gpu_sched drm_buddy
vfat fat btusb btrtl uvcvideo btbcm btintel videobuf2_vmalloc videobuf2_mem=
ops
snd_usb_audio videobuf2_v4l2 bluetooth videobuf2_common snd_usbmidi_lib
videodev snd_rawmidi rfkill sr_mod mc ecdh_generic sd_mod cdrom radeon
i2c_algo_bit drm_ttm_helper vboxnetadp(OE) vboxnetflt(OE) kvm_amd
snd_hda_codec_realtek ttm snd_hda_codec_generic ppdev ledtrig_audio vboxdrv=
(OE)
snd_hda_codec_hdmi drm_display_helper kvm drm_kms_helper snd_hda_intel nct6=
775
syscopyarea irqbypass nct6775_core snd_intel_dspcfg sysfillrect snd_hda_cod=
ec
crct10dif_pclmul hwmon_vid sysimgblt crc32_pclmul crc32c_intel aic7xxx
fb_sys_fops snd_hwdep scsi_transport_spi ghash_clmulni_intel snd_hda_core d=
rm
snd_pcm backlight xhci_pci aesni_intel snd_timer xhci_pci_renesas sp5100_tco
snd crypto_simd cec cryptd i2c_piix4 ahci xhci_hcd soundcore ccp k10temp
libahci i2c_core rapl pcspkr
[19439.264466]  efi_pstore parport_pc parport gpio_amdpt gpio_generic
acpi_cpufreq efivarfs
[19439.264477] CPU: 6 PID: 13828 Comm: kworker/6:2 Tainted: G           OE=
=20=20=20=20=20
6.0.0-gentoo-x86_64-01 #1
[19439.264482] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B3=
50
TOMAHAWK (MS-7A34), BIOS 1.M0 01/23/2019
[19439.264485] Workqueue: usb_hub_wq hub_event
[19439.264493] RIP: 0010:notifier_chain_register+0x3e/0x70
[19439.264497] Code: 10 7f 33 75 04 84 d2 75 3b 48 8d 78 08 48 8b 40 08 48 =
85
c0 74 20 48 39 c6 75 e0 48 8b 36 48 c7 c7 50 a2 34 a2 e8 f9 d1 a7 00 <0f> 0=
b b8
ef ff ff ff e9 46 18 d6 00 48 89 46 08 31 c0 48 89 37 e9
[19439.264500] RSP: 0018:ffffb2af8fb8f7d8 EFLAGS: 00010286
[19439.264503] RAX: 0000000000000000 RBX: ffffffffc1073290 RCX:
0000000000000000
[19439.264505] RDX: 0000000000000001 RSI: ffffffffa239a2ab RDI:
00000000ffffffff
[19439.264507] RBP: ffffffffa264f0a0 R08: 0000000000000000 R09:
ffffffffa2dbdda0
[19439.264509] R10: 0000000000000001 R11: 0000000000000001 R12:
ffff9f62c0a70b78
[19439.264511] R13: ffffffffa264f0c8 R14: ffff9f62c0a70d08 R15:
ffffffffc0d22700
[19439.264513] FS:  0000000000000000(0000) GS:ffff9f69ba780000(0000)
knlGS:0000000000000000
[19439.264516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19439.264518] CR2: 00007ffc4d8b3248 CR3: 0000000301a2e000 CR4:
00000000003506e0
[19439.264521] Call Trace:
[19439.264523]  <TASK>
[19439.264525]  blocking_notifier_chain_register+0x3d/0x80
[19439.264530]  hci_register_dev+0x32b/0x3d0 [bluetooth]
[19439.264558]  btusb_probe+0xc24/0xdea [btusb]
[19439.264563]  ? recalibrate_cpu_khz+0x10/0x10
[19439.264567]  ? ktime_get_mono_fast_ns+0x3d/0x90
[19439.264571]  usb_probe_interface+0xf6/0x2d0
[19439.264576]  really_probe+0xe1/0x3a0
[19439.264579]  ? pm_runtime_barrier+0x61/0xb0
[19439.264582]  __driver_probe_device+0x78/0x180
[19439.264585]  driver_probe_device+0x2c/0xb0
[19439.264588]  __device_attach_driver+0x8c/0x100
[19439.264591]  ? driver_allows_async_probing+0x60/0x60
[19439.264593]  ? driver_allows_async_probing+0x60/0x60
[19439.264596]  bus_for_each_drv+0x7e/0xd0
[19439.264599]  __device_attach+0xca/0x230
[19439.264602]  bus_probe_device+0x8e/0xb0
[19439.264604]  device_add+0x45c/0x970
[19439.264607]  ? preempt_count_add+0x70/0xa0
[19439.264611]  usb_set_configuration+0x483/0x890
[19439.264616]  usb_generic_driver_probe+0x50/0x70
[19439.264619]  usb_probe_device+0x47/0x110
[19439.264621]  really_probe+0xe1/0x3a0
[19439.264624]  ? pm_runtime_barrier+0x61/0xb0
[19439.264626]  __driver_probe_device+0x78/0x180
[19439.264629]  driver_probe_device+0x2c/0xb0
[19439.264632]  __device_attach_driver+0x8c/0x100
[19439.264634]  ? driver_allows_async_probing+0x60/0x60
[19439.264637]  ? driver_allows_async_probing+0x60/0x60
[19439.264639]  bus_for_each_drv+0x7e/0xd0
[19439.264642]  __device_attach+0xca/0x230
[19439.264644]  bus_probe_device+0x8e/0xb0
[19439.264647]  device_add+0x45c/0x970
[19439.264649]  ? blake2s_update+0x5c/0xe0
[19439.264654]  usb_new_device.cold+0x148/0x36a
[19439.264659]  hub_event+0xfa8/0x1950
[19439.264665]  process_one_work+0x1e5/0x3b0
[19439.264668]  ? rescuer_thread+0x390/0x390
[19439.264671]  worker_thread+0x50/0x3b0
[19439.264673]  ? rescuer_thread+0x390/0x390
[19439.264675]  kthread+0xe8/0x110
[19439.264678]  ? kthread_complete_and_exit+0x20/0x20
[19439.264681]  ret_from_fork+0x22/0x30
[19439.264687]  </TASK>
[19439.264688] ---[ end trace 0000000000000000 ]---
[19439.264702] btusb: probe of 1-2:1.0 failed with error -17
[19441.764603] general protection fault, probably for non-canonical address
0xff4c265eff4ee67f: 0000 [#1] PREEMPT SMP NOPTI
[19441.764612] CPU: 6 PID: 13828 Comm: kworker/6:2 Tainted: G        W  OE=
=20=20=20=20=20
6.0.0-gentoo-x86_64-01 #1
[19441.764615] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B3=
50
TOMAHAWK (MS-7A34), BIOS 1.M0 01/23/2019
[19441.764618] Workqueue: pm pm_runtime_work
[19441.764624] RIP: 0010:queued_spin_lock_slowpath+0x25b/0x2a0
[19441.764629] Code: ff f3 90 48 8b 13 48 85 d2 74 f6 eb d6 c1 ea 12 83 e0 =
03
ff ca 48 c1 e0 04 48 63 d2 48 05 00 c0 02 00 48 03 04 d5 20 18 43 a2 <48> 8=
9 18
8b 43 08 85 c0 75 09 f3 90 8b 53 08 85 d2 74 f7 48 8b 13
[19441.764631] RSP: 0018:ffffb2af8fb8fcf8 EFLAGS: 00010082
[19441.764634] RAX: ff4c265eff4ee67f RBX: ffff9f69ba7ac000 RCX:
0000000000000007
[19441.764636] RDX: 0000000000003ffe RSI: ffffffffa239a2ab RDI:
ffffffffa2368164
[19441.764638] RBP: ffff9f64a246118c R08: ffff9f632c210800 R09:
ffff9f64a2464ca8
[19441.764640] R10: 0000000000000003 R11: 00000000010a1ab1 R12:
00000000001c0000
[19441.764641] R13: 00000000001c0000 R14: 0000000000000002 R15:
ffff9f69ba7b2105
[19441.764643] FS:  0000000000000000(0000) GS:ffff9f69ba780000(0000)
knlGS:0000000000000000
[19441.764645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19441.764647] CR2: 000000f403928000 CR3: 00000006bdec2000 CR4:
00000000003506e0
[19441.764649] Call Trace:
[19441.764652]  <TASK>
[19441.764656]  btusb_suspend+0x87/0x1c0 [btusb]
[19441.764662]  usb_suspend_both+0xaa/0x220
[19441.764667]  usb_runtime_suspend+0x2b/0x70
[19441.764670]  ? usb_autoresume_device+0x60/0x60
[19441.764673]  __rpm_callback+0x5b/0x140
[19441.764675]  ? usb_autoresume_device+0x60/0x60
[19441.764678]  rpm_callback+0x79/0x90
[19441.764680]  ? usb_autoresume_device+0x60/0x60
[19441.764682]  rpm_suspend+0x14a/0x730
[19441.764685]  ? vtime_task_switch_generic+0x8d/0xf0
[19441.764687]  ? _raw_spin_unlock+0x12/0x40
[19441.764691]  ? finish_task_switch.isra.0+0x96/0x2d0
[19441.764694]  pm_runtime_work+0x94/0xa0
[19441.764697]  process_one_work+0x1e5/0x3b0
[19441.764700]  ? rescuer_thread+0x390/0x390
[19441.764702]  worker_thread+0x50/0x3b0
[19441.764704]  ? rescuer_thread+0x390/0x390
[19441.764706]  kthread+0xe8/0x110
[19441.764709]  ? kthread_complete_and_exit+0x20/0x20
[19441.764712]  ret_from_fork+0x22/0x30
[19441.764717]  </TASK>
[19441.764718] Modules linked in: auth_rpcgss nfsv4 dns_resolver nfs lockd
grace fscache netfs sunrpc bnep amdgpu mfd_core iommu_v2 gpu_sched drm_buddy
vfat fat btusb btrtl uvcvideo btbcm btintel videobuf2_vmalloc videobuf2_mem=
ops
snd_usb_audio videobuf2_v4l2 bluetooth videobuf2_common snd_usbmidi_lib
videodev snd_rawmidi rfkill sr_mod mc ecdh_generic sd_mod cdrom radeon
i2c_algo_bit drm_ttm_helper vboxnetadp(OE) vboxnetflt(OE) kvm_amd
snd_hda_codec_realtek ttm snd_hda_codec_generic ppdev ledtrig_audio vboxdrv=
(OE)
snd_hda_codec_hdmi drm_display_helper kvm drm_kms_helper snd_hda_intel nct6=
775
syscopyarea irqbypass nct6775_core snd_intel_dspcfg sysfillrect snd_hda_cod=
ec
crct10dif_pclmul hwmon_vid sysimgblt crc32_pclmul crc32c_intel aic7xxx
fb_sys_fops snd_hwdep scsi_transport_spi ghash_clmulni_intel snd_hda_core d=
rm
snd_pcm backlight xhci_pci aesni_intel snd_timer xhci_pci_renesas sp5100_tco
snd crypto_simd cec cryptd i2c_piix4 ahci xhci_hcd soundcore ccp k10temp
libahci i2c_core rapl pcspkr
[19441.764783]  efi_pstore parport_pc parport gpio_amdpt gpio_generic
acpi_cpufreq efivarfs
[19441.764792] ---[ end trace 0000000000000000 ]---
[19441.820869] RIP: 0010:queued_spin_lock_slowpath+0x25b/0x2a0
[19441.820885] Code: ff f3 90 48 8b 13 48 85 d2 74 f6 eb d6 c1 ea 12 83 e0 =
03
ff ca 48 c1 e0 04 48 63 d2 48 05 00 c0 02 00 48 03 04 d5 20 18 43 a2 <48> 8=
9 18
8b 43 08 85 c0 75 09 f3 90 8b 53 08 85 d2 74 f7 48 8b 13
[19441.820889] RSP: 0018:ffffb2af8fb8fcf8 EFLAGS: 00010082
[19441.820893] RAX: ff4c265eff4ee67f RBX: ffff9f69ba7ac000 RCX:
0000000000000007
[19441.820895] RDX: 0000000000003ffe RSI: ffffffffa239a2ab RDI:
ffffffffa2368164
[19441.820897] RBP: ffff9f64a246118c R08: ffff9f632c210800 R09:
ffff9f64a2464ca8
[19441.820899] R10: 0000000000000003 R11: 00000000010a1ab1 R12:
00000000001c0000
[19441.820900] R13: 00000000001c0000 R14: 0000000000000002 R15:
ffff9f69ba7b2105
[19441.820902] FS:  0000000000000000(0000) GS:ffff9f69ba780000(0000)
knlGS:0000000000000000
[19441.820904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19441.820906] CR2: 000000f403928000 CR3: 00000006bdec2000 CR4:
00000000003506e0
[19441.820909] note: kworker/6:2[13828] exited with preempt_count 1

Is there anything other useful info I can provide, or any patch to test?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
