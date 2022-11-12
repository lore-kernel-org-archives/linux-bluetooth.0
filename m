Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E7C43217
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Nov 2022 06:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiKLGbm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Nov 2022 01:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKLGbk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Nov 2022 01:31:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472C532FE
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 22:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A326023C
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 06:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F64AC433D6
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668234698;
        bh=o1oXHfuZR2S4bwsQqUBNwOjT8KULSuRRCioH+f5IV90=;
        h=From:To:Subject:Date:From;
        b=KlPfHiqsoOwQgdl7L2djIvVhI1foHX15RbuZ9XqO7NWSE/AJ1ZOUc4YXozlxaFqAm
         8y1ABaCYrbLsLGVpxw4Qmp4nP1x+NE6Bd+Sl8ZxJKlKAM6TDcCRGW/Td2chhRfmeQA
         XPOnAwK10fjmI/lzdzNdzWc520yvb3x/N4R30yD1F3fey6FWrrTc8uc+V6ERu922aI
         f9+dDIy+Qha63d34a/m54AfdeVM0E4pjYMNCFwguevZ1LV/eCLIKO/cNwm5BwW+jV8
         Q66FktsKifWzzDycu9rFU0J5LT2UkM5mHOxyiFxJAPLGNt6rNtSU94Csx3TqaPRRhH
         bfUHpDm13yXfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E7348C433E4; Sat, 12 Nov 2022 06:31:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] New: notifier callback hci_suspend_notifier [bluetooth]
 already registered
Date:   Sat, 12 Nov 2022 06:31:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

            Bug ID: 216683
           Summary: notifier callback hci_suspend_notifier [bluetooth]
                    already registered
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0.7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: justanormaltinkerermihir@duck.com
        Regression: No

[   71.985884] ------------[ cut here ]------------
[   71.985887] notifier callback hci_suspend_notifier [bluetooth] already
registered
[   71.985945] WARNING: CPU: 1 PID: 268 at kernel/notifier.c:28
notifier_chain_register+0x3e/0x70
[   71.985955] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq
snd_seq_device qrtr bnep ccm algif_aead cbc des_generic libdes ecb
algif_skcipher cmac md4 algif_hash af_alg btusb(OE) btrtl btbcm btintel btm=
tk
bluetooth(OE) intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
intel_powerclamp coretemp cfg80211 kvm_intel kvm irqbypass vfat fat
crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek polyval_clmulni
polyval_generic snd_hda_codec_generic gf128mul ghash_clmulni_intel
ledtrig_audio aesni_intel snd_hda_codec_hdmi crypto_simd cryptd rapl
intel_cstate intel_uncore hp_wmi snd_hda_intel snd_intel_dspcfg sparse_keym=
ap
ecdh_generic platform_profile snd_intel_sdw_acpi snd_hda_codec rfkill iTCO_=
wdt
intel_pmc_bxt mei_wdt iTCO_vendor_support psmouse wmi_bmof snd_hda_core
pkcs8_key_parser at24 mei_hdcp gpio_ich mei_pxp snd_hwdep snd_pcm mousedev
joydev tpm_infineon snd_timer nvidia_drm(POE) tpm_tis nvidia_modeset(POE) w=
mi
snd nvidia_uvm(POE) e1000e soundcore tpm_tis_core i2c_i801
[   71.986060]  mei_me tpm mei i2c_smbus rng_core mac_hid lpc_ich nvidia(PO=
E)
fuse crypto_user bpf_preload ip_tables x_tables ext4 crc32c_generic crc16
mbcache jbd2 raid0 uas usb_storage usbhid md_mod serio_raw atkbd libps2
vivaldi_fmap crc32c_intel i8042 serio
[   71.986093] CPU: 1 PID: 268 Comm: kworker/1:3 Tainted: P           OE=20=
=20=20=20=20
6.0.7-arch1-1 #1 54734d35253fb4c526adcfdfa2e7225be9ec4a9a
[   71.986096] Hardware name: Hewlett-Packard HP Compaq 8200 Elite SFF PC/1=
495,
BIOS J01 v02.33 04/12/2019
[   71.986098] Workqueue: usb_hub_wq hub_event
[   71.986103] RIP: 0010:notifier_chain_register+0x3e/0x70
[   71.986107] Code: 10 7f 33 75 04 84 d2 75 3b 48 8d 78 08 48 8b 40 08 48 =
85
c0 74 20 48 39 c6 75 e0 48 8b 36 48 c7 c7 08 c6 d1 b9 e8 92 6d ac 00 <0f> 0=
b b8
ef ff ff ff c3 cc cc cc cc 48 89 46 08 31 c0 48 89 37 c3
[   71.986108] RSP: 0018:ffffa676005fb810 EFLAGS: 00010286
[   71.986110] RAX: 0000000000000000 RBX: ffffffffba45b000 RCX:
0000000000000027
[   71.986112] RDX: ffff895fa5ca1668 RSI: 0000000000000001 RDI:
ffff895fa5ca1660
[   71.986113] RBP: ffff895e8341eb78 R08: 0000000000000000 R09:
ffffa676005fb698
[   71.986114] R10: 0000000000000003 R11: ffffffffba4cb508 R12:
ffffffffba45b028
[   71.986115] R13: ffff895e8341e030 R14: ffff895e8341ed08 R15:
ffffffffc35e9ca0
[   71.986117] FS:  0000000000000000(0000) GS:ffff895fa5c80000(0000)
knlGS:0000000000000000
[   71.986118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.986120] CR2: 000055dffc48e078 CR3: 0000000029010006 CR4:
00000000000606e0
[   71.986122] Call Trace:
[   71.986124]  <TASK>
[   71.986125]  blocking_notifier_chain_register+0x33/0x60
[   71.986130]  hci_register_dev+0x316/0x3d0 [bluetooth
99b5497ea3d09708fa1366c1dc03288bf3cca8da]
[   71.986154]  btusb_probe+0x979/0xd85 [btusb
e1e0605a4f4c01984a4b9c8ac58c3666ae287477]
[   71.986159]  ? __pm_runtime_set_status+0x1a9/0x300
[   71.986162]  ? ktime_get_mono_fast_ns+0x3e/0x90
[   71.986167]  usb_probe_interface+0xe3/0x2b0
[   71.986171]  really_probe+0xdb/0x380
[   71.986174]  ? pm_runtime_barrier+0x54/0x90
[   71.986177]  __driver_probe_device+0x78/0x170
[   71.986180]  driver_probe_device+0x1f/0x90
[   71.986183]  __device_attach_driver+0x89/0x110
[   71.986186]  ? driver_allows_async_probing+0x70/0x70
[   71.986189]  bus_for_each_drv+0x8c/0xe0
[   71.986192]  __device_attach+0xb2/0x1e0
[   71.986195]  bus_probe_device+0x92/0xb0
[   71.986198]  device_add+0x422/0x9a0
[   71.986201]  ? sysfs_merge_group+0xd4/0x110
[   71.986205]  usb_set_configuration+0x57a/0x820
[   71.986208]  usb_generic_driver_probe+0x4f/0x70
[   71.986211]  usb_probe_device+0x3a/0x110
[   71.986213]  really_probe+0xdb/0x380
[   71.986216]  ? pm_runtime_barrier+0x54/0x90
[   71.986219]  __driver_probe_device+0x78/0x170
[   71.986221]  driver_probe_device+0x1f/0x90
[   71.986224]  __device_attach_driver+0x89/0x110
[   71.986227]  ? driver_allows_async_probing+0x70/0x70
[   71.986230]  bus_for_each_drv+0x8c/0xe0
[   71.986232]  __device_attach+0xb2/0x1e0
[   71.986235]  bus_probe_device+0x92/0xb0
[   71.986237]  device_add+0x422/0x9a0
[   71.986239]  ? _dev_info+0x7d/0x98
[   71.986242]  ? blake2s_update+0x4c/0xc0
[   71.986246]  usb_new_device.cold+0x148/0x36d
[   71.986250]  hub_event+0xa8a/0x1910
[   71.986255]  process_one_work+0x1c4/0x380
[   71.986259]  worker_thread+0x51/0x390
[   71.986262]  ? rescuer_thread+0x3b0/0x3b0
[   71.986264]  kthread+0xdb/0x110
[   71.986266]  ? kthread_complete_and_exit+0x20/0x20
[   71.986268]  ret_from_fork+0x1f/0x30
[   71.986273]  </TASK>
[   71.986274] ---[ end trace 0000000000000000 ]---
[   71.986284] btusb: probe of 2-1.6:1.0 failed with error -17

Steps to reproduce: plug in your bluetooth dongle and unplug it, do it till
this appears in the dmesg, this also makes the computer pretty much useless
unless I force restart it.

Please note I have applied this patchset to the kernel 6.0.7:
https://patchwork.kernel.org/project/bluetooth/list/?series=3D690177&state=
=3D*

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
