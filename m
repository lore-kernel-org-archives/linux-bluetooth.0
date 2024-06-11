Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4D171677
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086873; cv=none; b=teahPTc28RlEAgNGCCniT3Zp4QfE5no1QLJBc/nPTgcNIskgzn1zT6lvcw9GEqq7O0mEZ17tKHLcFYYoI1ZARgNks5EDJEkFLEd012dCSWJR5XpcUPZxsiHBBmL9taPtU211w/pgGKvMLed8QODdYphp2Gt+g1ni1OsBuBZZcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086873; c=relaxed/simple;
	bh=/Px+X21o3U3/nsgRjdospNdX6JY8iYyobwLQnpsnXNM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WDu61znRE9kWcIa0IuglN+4fQL8zhb2qGwIvrfLY/BfbVpv5BMAcp8odoSK8olLf5mhkbOm9JYYaiX52CVT2LoGItP0pGmJYQ18VlOq00PJ6XGf1SjFFuxL2lnqQetasdBKoItzPx0FBkaLFShrrVM+vOD7jUz5fKtN630Mw12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsrAu6Ue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsrAu6Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10769C2BD10
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718086873;
	bh=/Px+X21o3U3/nsgRjdospNdX6JY8iYyobwLQnpsnXNM=;
	h=From:To:Subject:Date:From;
	b=PsrAu6UeyZb57dtuT/hy+bxAdmVqyy4NgnVxJGjD1lD8qvBduSzI52FpqlklL6hbW
	 nnxBdPmarGzk36AuqUPVcZz1VdKI98Scy8j0v+BlY9PfpBclXgCA075VijMqDzRfLt
	 oglwfBSGI1kwkYFskK1BEUyT+75iJTrUIAOCzA5tlePyiHhgtf/Vgc39wXC80VxelW
	 bu8dKq4d+6ufmAP7QomgwdywIIMJhG8fbT+qFiwkmuuo8zx8YUuLdWVz8KQQewl4Q9
	 rXN3pNSs+HhzqRyq062+hFg0xcvR5HT7WKkuLnPlZqZ2Hn3IkiCsgXC8e69WKuoaHN
	 wuiMTwTBogZaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3EC0C53B73; Tue, 11 Jun 2024 06:21:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] New: bluetooth and wireplumber stop working after some
 time - dmesg report BUG
Date: Tue, 11 Jun 2024 06:21:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: nicolas.baranger@3xo.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218952-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

            Bug ID: 218952
           Summary: bluetooth and wireplumber stop working after some time
                    - dmesg report BUG
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nicolas.baranger@3xo.fr
        Regression: No

Dear maintener

While using normaly a desktop session under Debian stable (12) an a new Dell
XPS15 9530, after some time bluetooth stop working and wireplumber too

uname -a
Linux lap-nba.14rv.lan 6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.90-1
(2024-05-03) x86_64 GNU/Linux


Having a look at dmesg show the following output :

  [lun. 10 juin 18:09:34 2024] BUG: kernel NULL pointer dereference, addres=
s:
0000000000000740
[lun. 10 juin 18:09:34 2024] #PF: supervisor read access in kernel mode
[lun. 10 juin 18:09:34 2024] #PF: error_code(0x0000) - not-present page
[lun. 10 juin 18:09:34 2024] PGD 0 P4D 0=20
[lun. 10 juin 18:09:34 2024] Oops: 0000 [#1] PREEMPT SMP NOPTI
[lun. 10 juin 18:09:34 2024] CPU: 6 PID: 5382 Comm: wireplumber Tainted: G=
=20=20=20=20=20
     OE      6.1.0-21-amd64 #1  Debian 6.1.90-1
[lun. 10 juin 18:09:34 2024] Hardware name: Dell Inc. XPS 15 9530/0X0GV7, B=
IOS
1.10.0 12/18/2023
[lun. 10 juin 18:09:34 2024] RIP: 0010:hci_send_sco+0x13/0xb0 [bluetooth]
[lun. 10 juin 18:09:34 2024] Code: c1 48 c7 c7 88 75 a9 c1 48 8b 50 30 e8 9=
6 fc
b6 fa eb ca 0f 1f 40 00 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 =
89
f3 <4c> 8b a7 40 07 00 00 66 90 48 89 df be 03 00 00 00 44 0f b7 75 32
[lun. 10 juin 18:09:34 2024] RSP: 0018:ffffb10005a4bba0 EFLAGS: 00010216
[lun. 10 juin 18:09:34 2024] RAX: 0000000000000001 RBX: ffff9e91c45e8a00 RC=
X:
000000000000003c
[lun. 10 juin 18:09:34 2024] RDX: 0000000000000001 RSI: ffff9e91c45e8a00 RD=
I:
0000000000000000
[lun. 10 juin 18:09:34 2024] RBP: 0000000000000000 R08: 000000000000003c R0=
9:
0000000000000008
[lun. 10 juin 18:09:34 2024] R10: 0000000000000200 R11: 0000000000000000 R1=
2:
ffff9e8fde935700
[lun. 10 juin 18:09:34 2024] R13: ffffb10005a4bc38 R14: 000000000000003c R1=
5:
0000000000000000
[lun. 10 juin 18:09:34 2024] FS:  00007f884ceb46c0(0000)
GS:ffff9e94ef580000(0000) knlGS:0000000000000000
[lun. 10 juin 18:09:34 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
[lun. 10 juin 18:09:34 2024] CR2: 0000000000000740 CR3: 0000000124cf8000 CR=
4:
0000000000750ee0
[lun. 10 juin 18:09:34 2024] PKRU: 55555554
[lun. 10 juin 18:09:34 2024] Call Trace:
[lun. 10 juin 18:09:34 2024]  <TASK>
[lun. 10 juin 18:09:34 2024]  ? __die_body.cold+0x1a/0x1f
[lun. 10 juin 18:09:34 2024]  ? page_fault_oops+0xd2/0x2b0
[lun. 10 juin 18:09:34 2024]  ? exc_page_fault+0x70/0x170
[lun. 10 juin 18:09:34 2024]  ? asm_exc_page_fault+0x22/0x30
[lun. 10 juin 18:09:34 2024]  ? hci_send_sco+0x13/0xb0 [bluetooth]
[lun. 10 juin 18:09:34 2024]  sco_sock_sendmsg+0x231/0x2e0 [bluetooth]
[lun. 10 juin 18:09:34 2024]  __sock_sendmsg+0x5c/0x70
[lun. 10 juin 18:09:34 2024]  sock_write_iter+0x97/0x100
[lun. 10 juin 18:09:34 2024]  vfs_write+0x34f/0x3e0
[lun. 10 juin 18:09:34 2024]  ksys_write+0xb7/0xf0
[lun. 10 juin 18:09:34 2024]  do_syscall_64+0x55/0xb0
[lun. 10 juin 18:09:34 2024]  ? do_fault+0x1a4/0x410
[lun. 10 juin 18:09:34 2024]  ? __handle_mm_fault+0x660/0xfa0
[lun. 10 juin 18:09:34 2024]  ? handle_mm_fault+0xdb/0x2d0
[lun. 10 juin 18:09:34 2024]  ? do_user_addr_fault+0x1b0/0x580
[lun. 10 juin 18:09:34 2024]  ? exit_to_user_mode_prepare+0x44/0x1f0
[lun. 10 juin 18:09:34 2024]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[lun. 10 juin 18:09:34 2024] RIP: 0033:0x7f884dd1c27f
[lun. 10 juin 18:09:34 2024] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e=
8 39
d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 =
0f
05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 48
[lun. 10 juin 18:09:34 2024] RSP: 002b:00007f884ceb3850 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
[lun. 10 juin 18:09:34 2024] RAX: ffffffffffffffda RBX: 0000562977a9b000 RC=
X:
00007f884dd1c27f
[lun. 10 juin 18:09:34 2024] RDX: 000000000000003c RSI: 0000562977a9b000 RD=
I:
0000000000000033
[lun. 10 juin 18:09:34 2024] RBP: 000000000000003c R08: 0000000000000000 R0=
9:
0000000000000004
[lun. 10 juin 18:09:34 2024] R10: 0000000000000006 R11: 0000000000000293 R1=
2:
0000562977a9b000
[lun. 10 juin 18:09:34 2024] R13: 000000000000003c R14: 000000000000003c R1=
5:
000056297855c330
[lun. 10 juin 18:09:34 2024]  </TASK>
[lun. 10 juin 18:09:34 2024] Modules linked in: tun npreal2(OE) cdc_acm
ppp_deflate bsd_comp ppp_async tls uinput ctr ccm uhid rfcomm snd_seq_dummy
snd_hrtimer snd_seq l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunn=
el
pppox ppp_generic slhc xfrm_user xfrm_algo nvme_fabrics vboxnetadp(OE)
vboxnetflt(OE) team_mode_loadbalance team 8021q garp stp mrp llc vboxdrv(OE)
qrtr cmac algif_hash algif_skcipher af_alg bnep sunrpc binfmt_misc
snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device squashfs btusb btr=
tl
btbcm btintel btmtk bluetooth uvcvideo videobuf2_vmalloc jitterentropy_rng
videobuf2_memops videobuf2_v4l2 videobuf2_common drbg videodev ansi_cprng mc
ecdh_generic ecc nls_ascii nls_cp437 vfat fat ext4 crc16 mbcache jbd2
snd_ctl_led snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common snd_soc_hdac_h=
dmi
snd_sof_probes snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_gener=
ic
snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_intel_hda_common soundwire_intel
soundwire_generic_allocation
[lun. 10 juin 18:09:34 2024]  soundwire_cadence snd_sof_intel_hda snd_sof_p=
ci
x86_pkg_temp_thermal intel_powerclamp snd_sof_xtensa_dsp coretemp snd_sof
snd_sof_utils snd_soc_hdac_hda iwlmvm snd_hda_ext_core kvm_intel
snd_soc_acpi_intel_match mac80211 snd_soc_acpi dell_laptop ledtrig_audio
libarc4 kvm snd_soc_core snd_compress soundwire_bus iwlwifi irqbypass
snd_hda_intel rapl snd_intel_dspcfg snd_intel_sdw_acpi pmt_telemetry mei_hd=
cp
pmt_class snd_hda_codec snd_hda_scodec_cs35l41_spi intel_cstate regmap_spi
cfg80211 intel_rapl_msr snd_hda_scodec_cs35l41_i2c dell_wmi snd_hda_core
snd_hda_scodec_cs35l41 snd_hwdep dell_wmi_sysman joydev dell_smbios snd_pcm
snd_hda_cs_dsp_ctls hid_sensor_als dcdbas intel_uncore
firmware_attributes_class wmi_bmof dell_wmi_descriptor pcspkr cs_dsp
processor_thermal_device_pci iTCO_wdt hid_sensor_trigger snd_timer ucsi_acpi
snd_soc_cs35l41_lib processor_thermal_device intel_pmc_bxt
processor_thermal_rfim mei_me hid_sensor_iio_common iTCO_vendor_support
typec_ucsi
[lun. 10 juin 18:09:34 2024]  processor_thermal_mbox snd
industrialio_triggered_buffer roles processor_thermal_rapl kfifo_buf watchd=
og
soundcore industrialio mei rfkill intel_vsec intel_rapl_common typec
int3403_thermal serial_multi_instantiate int340x_thermal_zone intel_hid
int3400_thermal intel_pmc_core sparse_keymap acpi_pad acpi_tad acpi_thermal=
_rel
ac hid_multitouch evdev serio_raw msr parport_pc ppdev lp parport loop fuse
efi_pstore configfs efivarfs ip_tables x_tables autofs4 btrfs blake2b_gener=
ic
xor raid6_pq zstd_compress libcrc32c crc32c_generic dm_crypt usbhid r8153_e=
cm
cdc_ether usbnet r8152 mii hid_sensor_custom hid_sensor_hub intel_ishtp_hid
dm_mod hid_generic spi_pxa2xx_platform dw_dmac dw_dmac_core i915 crc32_pclm=
ul
nvme crc32c_intel drm_buddy nvme_core i2c_algo_bit t10_pi drm_display_helper
ghash_clmulni_intel cec crc64_rocksoft_generic rc_core sha512_ssse3
rtsx_pci_sdmmc crc64_rocksoft ttm crc_t10dif xhci_pci sha512_generic mmc_co=
re
sha256_ssse3 video crct10dif_generic atlantic
[lun. 10 juin 18:09:34 2024]  sha1_ssse3 drm_kms_helper xhci_hcd i2c_i801
crct10dif_pclmul intel_lpss_pci intel_ish_ipc crc64 i2c_hid_acpi thunderbolt
aesni_intel drm psmouse usbcore crypto_simd cryptd rtsx_pci macsec i2c_smbus
intel_lpss intel_ishtp idma64 usb_common crct10dif_common i2c_hid battery
button hid wmi [last unloaded: npreal2(OE)]
[lun. 10 juin 18:09:34 2024] CR2: 0000000000000740
[lun. 10 juin 18:09:34 2024] ---[ end trace 0000000000000000 ]---
[lun. 10 juin 18:09:35 2024] RIP: 0010:hci_send_sco+0x13/0xb0 [bluetooth]
[lun. 10 juin 18:09:35 2024] Code: c1 48 c7 c7 88 75 a9 c1 48 8b 50 30 e8 9=
6 fc
b6 fa eb ca 0f 1f 40 00 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 48 =
89
f3 <4c> 8b a7 40 07 00 00 66 90 48 89 df be 03 00 00 00 44 0f b7 75 32
[lun. 10 juin 18:09:35 2024] RSP: 0018:ffffb10005a4bba0 EFLAGS: 00010216
[lun. 10 juin 18:09:35 2024] RAX: 0000000000000001 RBX: ffff9e91c45e8a00 RC=
X:
000000000000003c
[lun. 10 juin 18:09:35 2024] RDX: 0000000000000001 RSI: ffff9e91c45e8a00 RD=
I:
0000000000000000
[lun. 10 juin 18:09:35 2024] RBP: 0000000000000000 R08: 000000000000003c R0=
9:
0000000000000008
[lun. 10 juin 18:09:35 2024] R10: 0000000000000200 R11: 0000000000000000 R1=
2:
ffff9e8fde935700
[lun. 10 juin 18:09:35 2024] R13: ffffb10005a4bc38 R14: 000000000000003c R1=
5:
0000000000000000
[lun. 10 juin 18:09:35 2024] FS:  00007f884ceb46c0(0000)
GS:ffff9e94ef580000(0000) knlGS:0000000000000000
[lun. 10 juin 18:09:35 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
[lun. 10 juin 18:09:35 2024] CR2: 0000000000000740 CR3: 0000000124cf8000 CR=
4:
0000000000750ee0
[lun. 10 juin 18:09:35 2024] PKRU: 55555554
[lun. 10 juin 18:09:35 2024] note: wireplumber[5382] exited with irqs disab=
led


After that, all interractions with bluetooth and wireplumber are impossible.

My blutooth Poly V4320 headset don't work anymore and my Logitech M240 blut=
ooth
mouse stop working in the exact instant when the BUG apperars=20

Sound card seems to have disappear :

07:44:21 nba@lap-nba:~$ pactl list cards
Connection failure: Timeout
07:45:02 nba@lap-nba:~$ pactl list sinks
Connection failure: Timeout

also, systemd interraction with wirelplumber become impossible :=20

07:51:34 nba@lap-nba:~$ sudo systemctl --user status wireplumber.service
Failed to connect to bus: no medium found

pstree -s $(pgrep wireplumber)
systemd=E2=94=80=E2=94=80=E2=94=80systemd=E2=94=80=E2=94=80=E2=94=80wireplu=
mber=E2=94=80=E2=94=80=E2=94=803*[{wireplumber}]


and bluetooth is not detected anymore :
08:14:49 nba@lap-nba:~$ sudo btmgmt
timeout


I can be availiable to provide more traces, juste let me know what is needed
Regards
Nicolas BARANGER

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
