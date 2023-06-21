Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E501EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 10:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjFUKqE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFUKpE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 06:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD519B7
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 03:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 096FA614E9
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63348C433C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687344229;
        bh=Q7Cgx3WjbOkj5rJy7GD76IRZ1QsCX9c9qxTDID0X1kg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M5FUXIXpGn5yKPghUtdFIGSgzfpFcSB+iTTK9pRbs+MUIs7PypejmbeOJGJmqujJu
         dnToiyiLJzALJjLricwtJdGMwSLZiA3PEc1gi78jW1mQ37buQGqmaisSb5OwSI6/mL
         FbDDkbcYIYTyLVxSOnEzeuFgQ1cjQ8zNf4TEdXEESuhqCxMIJ9PZZfl2fDt237gdFS
         PozNMPXWoeLkw0Pt/u5LeT0gzH0+47swJPqy/ioB676TYfXlxAq26TL0x/6LEiTd6+
         RixISAl0esI9NSaUINcQsZVJ6QmcPQ1YupzHktl1RPJi4S39KmFGjF4v2HN7Q49tDb
         7kAwBvgtzpIcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4AE7FC4332E; Wed, 21 Jun 2023 10:43:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Wed, 21 Jun 2023 10:43:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217581-62941-Tt0m8ZCg1Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217581-62941@https.bugzilla.kernel.org/>
References: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

--- Comment #2 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
Kernel LOG


[ 2415.213175] chan 00000000a604c117
[ 2415.213191] chan 00000000a604c117 orig refcnt 1
[ 2415.320464] hcon 00000000f362d481 bdaddr 48:b0:2d:02:81:0a status 0
[ 2415.320494] hcon 00000000f362d481 conn 000000001363748a hchan
0000000081571a4f
[ 2415.320505] chan 00000000a604c117 orig refcnt 2
[ 2415.320523] chan 00000000128f5e36
[ 2415.320528] chan 00000000128f5e36 orig refcnt 1
[ 2415.320536] conn 000000001363748a, psm 0x00, dcid 0x0004
[ 2415.320543] chan 00000000128f5e36 orig refcnt 2
[ 2415.320548] chan 000000009ddada5b orig refcnt 1
[ 2415.320553] chan 00000000a604c117 orig refcnt 3
[ 2415.320558] chan 00000000d0b20736
[ 2415.320562] conn 000000001363748a, psm 0x00, dcid 0x0006
[ 2415.320567] chan 00000000d0b20736 orig refcnt 1
[ 2415.320573] chan 000000009ddada5b orig refcnt 2
[ 2415.320578] conn 000000001363748a
[ 2415.320628] chan 00000000d0b20736 len 2
[ 2415.320639] chan 00000000d0b20736, skb 0000000099ea3217 len 6 priority 7
[ 2415.320660] hci1 conn 000000001363748a

[ 2415.614466] conn 000000001363748a status 0x00 encrypt 2
[ 2415.614480] chan 00000000d0b20736 scid 0x0006 state BT_CONNECTED
[ 2415.614495] chan 00000000128f5e36 scid 0x0004 state BT_OPEN
[ 2415.710469] hcon 00000000f362d481 reason 19
[ 2415.710495] hcon 00000000f362d481 conn 000000001363748a, err 104
[ 2415.710505] chan 00000000d0b20736 orig refcnt 2
[ 2415.710512] chan 00000000d0b20736, conn 000000001363748a, err 104, state
BT_CONNECTED
[ 2415.710519] chan 00000000d0b20736 orig refcnt 3
[ 2415.710523] chan 00000000d0b20736 orig refcnt 2
[ 2415.710527] chan 00000000d0b20736 orig refcnt 1
[ 2415.710531] chan 00000000d0b20736
[ 2415.710536] chan 00000000128f5e36 orig refcnt 3
[ 2415.710540] chan 00000000128f5e36, conn 000000001363748a, err 104, state
BT_OPEN
[ 2415.710548] chan 00000000128f5e36 orig refcnt 4
[ 2415.710558] chan 00000000128f5e36 orig refcnt 3
[ 2415.710562] chan 00000000128f5e36 orig refcnt 2
[ 2415.815007] chan 00000000a604c117 orig refcnt 2
[ 2415.815018] chan 00000000a604c117 state BT_LISTEN
[ 2415.815022] chan 00000000128f5e36 orig refcnt 1
[ 2415.815024] chan 00000000128f5e36
[ 2415.815030] chan 00000000128f5e36 orig refcnt 0
[ 2415.815031] ------------[ cut here ]------------
[ 2415.815033] refcount_t: addition on 0; use-after-free.
[ 2415.815045] WARNING: CPU: 0 PID: 10662 at lib/refcount.c:25
refcount_warn_saturate+0x12e/0x150
[ 2415.815056] Modules linked in: algif_hash algif_skcipher af_alg cmac
r8153_ecm cdc_ether usbnet r8152 uas mii usb_storage snd_usb_audio
snd_usbmidi_lib mc ccm snd_seq_dummy snd_hrtimer hid_sensor_als
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
hid_sensor_iio_common industrialio hid_sensor_custom joydev snd_ctl_led
snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common snd_soc_hdac_hdmi
snd_sof_probes btusb btrtl btbcm btintel btmtk bluetooth usbhid ecdh_generic
ecc snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common
soundwire_intel soundwire_generic_allocation soundwire_cadence
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
soundwire_bus iwlmvm snd_soc_core binfmt_misc snd_compress x86_pkg_temp_the=
rmal
ac97_bus intel_powerclamp snd_pcm_dmaengine coretemp snd_hda_intel mac80211
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
[ 2415.815127]  kvm_intel snd_hda_core libarc4 snd_hwdep kvm snd_pcm
hid_sensor_hub hid_multitouch irqbypass crct10dif_pclmul crc32_pclmul
polyval_clmulni snd_seq_midi snd_seq_midi_event polyval_generic
ghash_clmulni_intel sha512_ssse3 hid_generic snd_rawmidi mei_hdcp mei_pxp
iwlwifi snd_seq aesni_intel cmdlinepart crypto_simd spi_nor snd_seq_device
cryptd ucsi_acpi pmt_telemetry nls_iso8859_1 mtd pmt_class snd_timer
intel_rapl_msr mei_me processor_thermal_device_pci rapl snd i2c_i801
intel_lpss_pci processor_thermal_device spi_intel_pci processor_thermal_rfim
xhci_pci intel_lpss wmi_bmof cfg80211 intel_cstate typec_ucsi soundcore
i2c_smbus mei spi_intel thunderbolt idma64 intel_vsec processor_thermal_mbox
xhci_pci_renesas processor_thermal_rapl intel_skl_int3472_tps68470 typec
intel_rapl_common igen6_edac tps68470_regulator i2c_hid_acpi clk_tps68470
i2c_hid ideapad_laptop hid platform_profile int3403_thermal
int340x_thermal_zone intel_hid int3400_thermal sparse_keymap
intel_skl_int3472_discrete acpi_thermal_rel acpi_tad
[ 2415.815198]  acpi_pad msr parport_pc ppdev lp parport efi_pstore dmi_sys=
fs
ip_tables x_tables autofs4 i915 i2c_algo_bit drm_buddy drm_display_helper
drm_kms_helper syscopyarea sysfillrect sysimgblt cec rc_core ttm nvme drm
psmouse serio_raw nvme_core video nvme_common mac_hid wmi pinctrl_tigerlake
[ 2415.815230] CPU: 0 PID: 10662 Comm: HCIManager Not tainted
6.3.7-060307-generic #202306090936
[ 2415.815234] Hardware name: LENOVO 82T0/LNVNB161216, BIOS J3CN45WW 08/26/=
2022
[ 2415.815236] RIP: 0010:refcount_warn_saturate+0x12e/0x150
[ 2415.815241] Code: 1d 47 06 e0 01 80 fb 01 0f 87 06 e6 8a 00 83 e3 01 0f =
85
52 ff ff ff 48 c7 c7 00 ab d9 89 c6 05 27 06 e0 01 01 e8 c2 5b 93 ff <0f> 0=
b e9
38 ff ff ff 48 c7 c7 d8 aa d9 89 c6 05 0e 06 e0 01 01 e8
[ 2415.815244] RSP: 0018:ffffba9ac6dcbcf8 EFLAGS: 00010246
[ 2415.815247] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[ 2415.815249] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[ 2415.815250] RBP: ffffba9ac6dcbd00 R08: 0000000000000000 R09:
0000000000000000
[ 2415.815251] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9e6d23f20000
[ 2415.815253] R13: ffff9e6d3a587c00 R14: ffff9e6d3a587000 R15:
ffff9e6d23f236f8
[ 2415.815254] FS:  00007fe9ae5fc6c0(0000) GS:ffff9e7083400000(0000)
knlGS:0000000000000000
[ 2415.815257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2415.815259] CR2: 0000564028065050 CR3: 0000000126a04000 CR4:
0000000000750ef0
[ 2415.815261] PKRU: 55555554
[ 2415.815262] Call Trace:
[ 2415.815264]  <TASK>
[ 2415.815269]  ? show_regs+0x6d/0x80
[ 2415.815275]  ? __warn+0x89/0x160
[ 2415.815282]  ? refcount_warn_saturate+0x12e/0x150
[ 2415.815285]  ? report_bug+0x17e/0x1b0
[ 2415.815290]  ? handle_bug+0x46/0x90
[ 2415.815295]  ? exc_invalid_op+0x18/0x80
[ 2415.815298]  ? asm_exc_invalid_op+0x1b/0x20
[ 2415.815307]  ? refcount_warn_saturate+0x12e/0x150
[ 2415.815311]  ? refcount_warn_saturate+0x12e/0x150
[ 2415.815315]  l2cap_chan_hold+0x7f/0xa0 [bluetooth]
[ 2415.815405]  l2cap_sock_teardown_cb+0x145/0x1f0 [bluetooth]
[ 2415.815478]  l2cap_chan_close+0x9d/0x2d0 [bluetooth]
[ 2415.815543]  l2cap_sock_shutdown+0x251/0x340 [bluetooth]
[ 2415.815606]  l2cap_sock_release+0x4d/0xf0 [bluetooth]
[ 2415.815665]  __sock_release+0x3f/0xc0
[ 2415.815669]  sock_close+0x15/0x30
[ 2415.815672]  __fput+0x95/0x270
[ 2415.815677]  ____fput+0xe/0x20
[ 2415.815680]  task_work_run+0x5e/0xa0
[ 2415.815684]  exit_to_user_mode_loop+0x100/0x130
[ 2415.815688]  exit_to_user_mode_prepare+0xa5/0xb0
[ 2415.815691]  syscall_exit_to_user_mode+0x29/0x50
[ 2415.815694]  do_syscall_64+0x67/0x90
[ 2415.815699]  ? syscall_exit_to_user_mode+0x29/0x50
[ 2415.815702]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 2415.815707] RIP: 0033:0x7fe9aff0c0ca
[ 2415.815759] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 =
ec
18 89 7c 24 0c e8 b3 ee f7 ff 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3=
d 00
f0 ff ff 77 36 89 d7 89 44 24 0c e8 13 ef f7 ff 8b 44 24
[ 2415.815761] RSP: 002b:00007fe9ae5fb9b0 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[ 2415.815764] RAX: 0000000000000000 RBX: 000055c4c29366f8 RCX:
00007fe9aff0c0ca
[ 2415.815766] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000006
[ 2415.815767] RBP: 00007fe9ae5fb9e0 R08: 00007fe9a40013f0 R09:
00000000ffffffff
[ 2415.815769] R10: 00007fe9afe134b8 R11: 0000000000000293 R12:
00007fe9a8000c81
[ 2415.815770] R13: 00007fe9a8000c50 R14: 00007fe9afdfe860 R15:
00007fe9addfc000
[ 2415.815773]  </TASK>
[ 2415.815775] ---[ end trace 0000000000000000 ]---
[ 2415.815778] chan 00000000128f5e36 state BT_OPEN
[ 2415.815780] chan 00000000128f5e36 orig refcnt 3221225472
[ 2415.815782] ------------[ cut here ]------------
[ 2415.815783] refcount_t: underflow; use-after-free.
[ 2415.815789] WARNING: CPU: 0 PID: 10662 at lib/refcount.c:28
refcount_warn_saturate+0xa3/0x150
[ 2415.815794] Modules linked in: algif_hash algif_skcipher af_alg cmac
r8153_ecm cdc_ether usbnet r8152 uas mii usb_storage snd_usb_audio
snd_usbmidi_lib mc ccm snd_seq_dummy snd_hrtimer hid_sensor_als
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf
hid_sensor_iio_common industrialio hid_sensor_custom joydev snd_ctl_led
snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common snd_soc_hdac_hdmi
snd_sof_probes btusb btrtl btbcm btintel btmtk bluetooth usbhid ecdh_generic
ecc snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common
soundwire_intel soundwire_generic_allocation soundwire_cadence
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
soundwire_bus iwlmvm snd_soc_core binfmt_misc snd_compress x86_pkg_temp_the=
rmal
ac97_bus intel_powerclamp snd_pcm_dmaengine coretemp snd_hda_intel mac80211
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
[ 2415.815843]  kvm_intel snd_hda_core libarc4 snd_hwdep kvm snd_pcm
hid_sensor_hub hid_multitouch irqbypass crct10dif_pclmul crc32_pclmul
polyval_clmulni snd_seq_midi snd_seq_midi_event polyval_generic
ghash_clmulni_intel sha512_ssse3 hid_generic snd_rawmidi mei_hdcp mei_pxp
iwlwifi snd_seq aesni_intel cmdlinepart crypto_simd spi_nor snd_seq_device
cryptd ucsi_acpi pmt_telemetry nls_iso8859_1 mtd pmt_class snd_timer
intel_rapl_msr mei_me processor_thermal_device_pci rapl snd i2c_i801
intel_lpss_pci processor_thermal_device spi_intel_pci processor_thermal_rfim
xhci_pci intel_lpss wmi_bmof cfg80211 intel_cstate typec_ucsi soundcore
i2c_smbus mei spi_intel thunderbolt idma64 intel_vsec processor_thermal_mbox
xhci_pci_renesas processor_thermal_rapl intel_skl_int3472_tps68470 typec
intel_rapl_common igen6_edac tps68470_regulator i2c_hid_acpi clk_tps68470
i2c_hid ideapad_laptop hid platform_profile int3403_thermal
int340x_thermal_zone intel_hid int3400_thermal sparse_keymap
intel_skl_int3472_discrete acpi_thermal_rel acpi_tad
[ 2415.815894]  acpi_pad msr parport_pc ppdev lp parport efi_pstore dmi_sys=
fs
ip_tables x_tables autofs4 i915 i2c_algo_bit drm_buddy drm_display_helper
drm_kms_helper syscopyarea sysfillrect sysimgblt cec rc_core ttm nvme drm
psmouse serio_raw nvme_core video nvme_common mac_hid wmi pinctrl_tigerlake
[ 2415.815916] CPU: 0 PID: 10662 Comm: HCIManager Tainted: G        W=20=20=
=20=20=20=20=20=20=20
6.3.7-060307-generic #202306090936
[ 2415.815919] Hardware name: LENOVO 82T0/LNVNB161216, BIOS J3CN45WW 08/26/=
2022
[ 2415.815920] RIP: 0010:refcount_warn_saturate+0xa3/0x150
[ 2415.815924] Code: cc cc 0f b6 1d cd 06 e0 01 80 fb 01 0f 87 79 e6 8a 00 =
83
e3 01 75 dd 48 c7 c7 30 ab d9 89 c6 05 b1 06 e0 01 01 e8 4d 5c 93 ff <0f> 0=
b eb
c6 0f b6 1d a4 06 e0 01 80 fb 01 0f 87 39 e6 8a 00 83 e3
[ 2415.815926] RSP: 0018:ffffba9ac6dcbce0 EFLAGS: 00010246
[ 2415.815928] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[ 2415.815930] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[ 2415.815931] RBP: ffffba9ac6dcbce8 R08: 0000000000000000 R09:
0000000000000000
[ 2415.815932] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9e6d23f20000
[ 2415.815934] R13: ffff9e6d3a587c00 R14: ffff9e6d3a587000 R15:
ffff9e6d23f236f8
[ 2415.815935] FS:  00007fe9ae5fc6c0(0000) GS:ffff9e7083400000(0000)
knlGS:0000000000000000
[ 2415.815937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2415.815939] CR2: 0000564028065050 CR3: 0000000126a04000 CR4:
0000000000750ef0
[ 2415.815941] PKRU: 55555554
[ 2415.815942] Call Trace:
[ 2415.815943]  <TASK>
[ 2415.815944]  ? show_regs+0x6d/0x80
[ 2415.815948]  ? __warn+0x89/0x160
[ 2415.815953]  ? refcount_warn_saturate+0xa3/0x150
[ 2415.815956]  ? report_bug+0x17e/0x1b0
[ 2415.815959]  ? handle_bug+0x46/0x90
[ 2415.815962]  ? exc_invalid_op+0x18/0x80
[ 2415.815965]  ? asm_exc_invalid_op+0x1b/0x20
[ 2415.815971]  ? refcount_warn_saturate+0xa3/0x150
[ 2415.815975]  l2cap_chan_put+0x78/0x90 [bluetooth]
[ 2415.816041]  l2cap_sock_kill+0x42/0xc0 [bluetooth]
[ 2415.816105]  l2cap_sock_teardown_cb+0x10a/0x1f0 [bluetooth]
[ 2415.816167]  l2cap_chan_close+0x9d/0x2d0 [bluetooth]
[ 2415.816231]  l2cap_sock_shutdown+0x251/0x340 [bluetooth]
[ 2415.816292]  l2cap_sock_release+0x4d/0xf0 [bluetooth]
[ 2415.816351]  __sock_release+0x3f/0xc0
[ 2415.816354]  sock_close+0x15/0x30
[ 2415.816357]  __fput+0x95/0x270
[ 2415.816361]  ____fput+0xe/0x20
[ 2415.816364]  task_work_run+0x5e/0xa0
[ 2415.816367]  exit_to_user_mode_loop+0x100/0x130
[ 2415.816370]  exit_to_user_mode_prepare+0xa5/0xb0
[ 2415.816372]  syscall_exit_to_user_mode+0x29/0x50
[ 2415.816375]  do_syscall_64+0x67/0x90
[ 2415.816380]  ? syscall_exit_to_user_mode+0x29/0x50
[ 2415.816382]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 2415.816387] RIP: 0033:0x7fe9aff0c0ca
[ 2415.816394] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 =
ec
18 89 7c 24 0c e8 b3 ee f7 ff 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3=
d 00
f0 ff ff 77 36 89 d7 89 44 24 0c e8 13 ef f7 ff 8b 44 24
[ 2415.816396] RSP: 002b:00007fe9ae5fb9b0 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[ 2415.816399] RAX: 0000000000000000 RBX: 000055c4c29366f8 RCX:
00007fe9aff0c0ca
[ 2415.816401] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000006
[ 2415.816402] RBP: 00007fe9ae5fb9e0 R08: 00007fe9a40013f0 R09:
00000000ffffffff
[ 2415.816403] R10: 00007fe9afe134b8 R11: 0000000000000293 R12:
00007fe9a8000c81
[ 2415.816405] R13: 00007fe9a8000c50 R14: 00007fe9afdfe860 R15:
00007fe9addfc000
[ 2415.816408]  </TASK>
[ 2415.816409] ---[ end trace 0000000000000000 ]---
[ 2415.816411] chan 00000000128f5e36 orig refcnt 3221225472
[ 2415.816413] chan 00000000a604c117 orig refcnt 3
[ 2415.816415] chan 00000000a604c117 orig refcnt 2
[ 2415.816416] chan 00000000a604c117 orig refcnt 3
[ 2415.816418] chan 00000000a604c117 orig refcnt 2
[ 2415.816420] chan 00000000a604c117 orig refcnt 1
[ 2415.816422] chan 00000000a604c117

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
