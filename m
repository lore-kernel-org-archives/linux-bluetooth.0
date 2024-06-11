Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5361D556
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125849; cv=none; b=bUtT5DldQQBVeEIAE6677bon7dSlQbeltdMBzYUqZxB3AFBnJmqXUfUqTG1L6ZILWykk+wneXi3P/vyms6FHjQTBwCL7GWekpO9RKrkCdCFrXBNECUOANVYBmC9XMM+1aE++/yk8+WOk90fhqjKD4Wh4A/2KUZNEJsIOq5jEGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125849; c=relaxed/simple;
	bh=u7QzbfRF4QoXr/SKPe/FmNYXGaTQS1RfGQ2hySM07lA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VO8DO3o/mScpoo18+tsrH5+LLbCH6dBjXBan+wqdHbTElVmvRqI5hQu4aqMt5iK+4wb0NFnzpuY9bTg+QWuLskHOeLUMky3HN/QEWEg1YDgjvRQ9OPEOlHAdfsr0WAu9nz9TYVHKX9cfkT1wzGhxbHlamN8Qsi0ilfGM/xf3b9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcLAXsan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcLAXsan"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE67BC4AF1C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125848;
	bh=u7QzbfRF4QoXr/SKPe/FmNYXGaTQS1RfGQ2hySM07lA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FcLAXsanXONFl6pHLn2qlh9pNuyeX/CEilGHCLSNnI/TkyCK69bg50aFseoKJy1Zp
	 4pNTR2WiULgbnHPbBWe8ulxb8+ja0zBwHq+sL9vf6ir3X+vvtSALX/zwX8up6RR2VF
	 RVnV053Yip3SL3N+GhVDE8LyhsUF+My0sYLDsOrfLoPn45oksqv8EITOsoInYz9s/X
	 BdkGDRJKuLonvsNZielEFSN7OoMWbhF7B7tFw8FFEzOUwD+JwGTYVrHDueGGXbeqL+
	 YfpJirLy/zFJnu6wiSRrY6NimKaWyQ6W5mZii7Esap1HV7G6Ug0lb/ccAPLDfEqWM/
	 DwcX5Ht6KLeuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACBB8C53B50; Tue, 11 Jun 2024 17:10:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Tue, 11 Jun 2024 17:10:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-AN1eNfusVI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

--- Comment #2 from Nicolas BARANGER (nicolas.baranger@3xo.fr) ---
First, thanks for answer

Today I was using Debian packaged kernel on debian stable
OK, I will build mainline kernel to see if the happend again.

A little more information :=20

First, this morning after I report this bug, I took my laptop -it's my
corporate laptop to  go work at a customer.=20
I decide to take a wired headset and another non bluetooth mouse and to keep
the system in  it's state.
But doing this, the mouse was working BUT the headset and the whole sound on
the laptop wasn't working (I'm not surprised !)
But there was also some other impacts :=20
I was not able to use the Intel AX211 wireless card to connect the customer
network.
So I decide to plug a typeC ethernet dongle on the laptop to connect the
customer wired network.=20
It was impossible to make work network, really impossible as if there were =
no
carier on the wire.=20
NetworkManager and its 'nmcli' command was not working anymore.
SystemD was unable to restart NetworkManager daemon and "systemctl restart
bluetooth.service" didn't work anymore and the command failed after systemd
timeout.
When I insist in trying to kill and restart NetworkManager, the laptop cras=
hs
and I had to force reboot it (pressing 5 second the power button - which al=
so
destroy one of my btrfs filesystem but not the lvm device nor the luks devi=
ce
this btrfs device resides on)

The only way to make the laptop working again (enough to work with it) was =
to
forcely=20

The BUG occurs after 2 ~ 6 or 7 days of normal usage=20
I will build mainline kernel to see if it happends again


Also, here is what I did catch in kernel log from last-1 issue : (~6 days a=
go)

sed '/BUG: kernel NULL.*/,/note: wireplumber.*/!d' /var/log/kern.log.1
2024-06-04T20:52:46.639940+02:00 lap-nba kernel: [787327.735263] BUG: kernel
NULL pointer dereference, address: 0000000000000740
2024-06-04T20:52:46.639941+02:00 lap-nba kernel: [787327.735274] #PF:
supervisor read access in kernel mode
2024-06-04T20:52:46.639943+02:00 lap-nba kernel: [787327.735278] #PF:
error_code(0x0000) - not-present page
2024-06-04T20:52:46.639943+02:00 lap-nba kernel: [787327.735283] PGD 0 P4D =
0=20
2024-06-04T20:52:46.639945+02:00 lap-nba kernel: [787327.735292] Oops: 0000
[#1] PREEMPT SMP NOPTI
2024-06-04T20:52:46.639945+02:00 lap-nba kernel: [787327.735299] CPU: 10 PI=
D:
5643 Comm: wireplumber Tainted: G           OE      6.1.0-21-amd64 #1  Debi=
an
6.1.90-1
2024-06-04T20:52:46.639946+02:00 lap-nba kernel: [787327.735305] Hardware n=
ame:
Dell Inc. XPS 15 9530/0X0GV7, BIOS 1.10.0 12/18/2023
2024-06-04T20:52:46.639947+02:00 lap-nba kernel: [787327.735309] RIP:
0010:hci_send_sco+0x13/0xb0 [bluetooth]
2024-06-04T20:52:46.639948+02:00 lap-nba kernel: [787327.735343] Code: c1 4=
8 c7
c7 88 b5 b8 c1 48 8b 50 30 e8 96 bc 07 e0 eb ca 0f 1f 40 00 e8 eb 79 a5 fe =
41
56 41 55 41 54 55 48 89 fd 53 48 89 f3 <4c> 8b a7 40 07 00 00 66 90 48 89 d=
f be
03 00 00 00 44 0f b7 75 32
2024-06-04T20:52:46.639949+02:00 lap-nba kernel: [787327.735348] RSP:
0018:ffffab06050bbba8 EFLAGS: 00010282
2024-06-04T20:52:46.639953+02:00 lap-nba kernel: [787327.735355] RAX:
0000000000000001 RBX: ffff909c5b3adf00 RCX: 0000000000000000
2024-06-04T20:52:46.639954+02:00 lap-nba kernel: [787327.735359] RDX:
0000000000000001 RSI: ffff909c5b3adf00 RDI: 0000000000000000
2024-06-04T20:52:46.639955+02:00 lap-nba kernel: [787327.735364] RBP:
0000000000000000 R08: 0000000000008a47 R09: 000000054beff8ef
2024-06-04T20:52:46.639955+02:00 lap-nba kernel: [787327.735368] R10:
0000000000000033 R11: 0000000000000000 R12: ffff909cc5ae8600
2024-06-04T20:52:46.639956+02:00 lap-nba kernel: [787327.735372] R13:
ffffab06050bbc40 R14: 000000000000003c R15: 0000000000000000
2024-06-04T20:52:46.639957+02:00 lap-nba kernel: [787327.735376] FS:=20
00007fc8acb396c0(0000) GS:ffff90a3af680000(0000) knlGS:0000000000000000
2024-06-04T20:52:46.639957+02:00 lap-nba kernel: [787327.735381] CS:  0010 =
DS:
0000 ES: 0000 CR0: 0000000080050033
2024-06-04T20:52:46.639958+02:00 lap-nba kernel: [787327.735385] CR2:
0000000000000740 CR3: 000000016c51e000 CR4: 0000000000750ee0
2024-06-04T20:52:46.639959+02:00 lap-nba kernel: [787327.735388] PKRU: 5555=
5554
2024-06-04T20:52:46.639959+02:00 lap-nba kernel: [787327.735391] Call Trace:
2024-06-04T20:52:46.639960+02:00 lap-nba kernel: [787327.735395]  <TASK>
2024-06-04T20:52:46.639961+02:00 lap-nba kernel: [787327.735400]  ?
__die_body.cold+0x1a/0x1f
2024-06-04T20:52:46.639961+02:00 lap-nba kernel: [787327.735409]  ?
page_fault_oops+0xd2/0x2b0
2024-06-04T20:52:46.639962+02:00 lap-nba kernel: [787327.735429]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639963+02:00 lap-nba kernel: [787327.735436]  ?
exc_page_fault+0x70/0x170
2024-06-04T20:52:46.639963+02:00 lap-nba kernel: [787327.735447]  ?
asm_exc_page_fault+0x22/0x30
2024-06-04T20:52:46.639964+02:00 lap-nba kernel: [787327.735466]  ?
hci_send_sco+0x13/0xb0 [bluetooth]
2024-06-04T20:52:46.639964+02:00 lap-nba kernel: [787327.735486]  ?
hci_send_sco+0x5/0xb0 [bluetooth]
2024-06-04T20:52:46.639965+02:00 lap-nba kernel: [787327.735506]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639966+02:00 lap-nba kernel: [787327.735510]=20
sco_sock_sendmsg+0x231/0x2e0 [bluetooth]
2024-06-04T20:52:46.639966+02:00 lap-nba kernel: [787327.735540]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639967+02:00 lap-nba kernel: [787327.735544]=20
__sock_sendmsg+0x5c/0x70
2024-06-04T20:52:46.639967+02:00 lap-nba kernel: [787327.735551]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639968+02:00 lap-nba kernel: [787327.735555]=20
sock_write_iter+0x97/0x100
2024-06-04T20:52:46.639969+02:00 lap-nba kernel: [787327.735568]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639969+02:00 lap-nba kernel: [787327.735573]=20
vfs_write+0x34f/0x3e0
2024-06-04T20:52:46.639970+02:00 lap-nba kernel: [787327.735589]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639970+02:00 lap-nba kernel: [787327.735593]=20
ksys_write+0xb7/0xf0
2024-06-04T20:52:46.639971+02:00 lap-nba kernel: [787327.735601]  ?
ftrace_regs_caller_end+0x59/0x59
2024-06-04T20:52:46.639972+02:00 lap-nba kernel: [787327.735606]=20
do_syscall_64+0x55/0xb0
2024-06-04T20:52:46.639972+02:00 lap-nba kernel: [787327.735613]  ?
trace_buffer_lock_reserve+0x21/0x50
2024-06-04T20:52:46.639973+02:00 lap-nba kernel: [787327.735618]  ?
ring_buffer_unlock_commit+0x35/0x160
2024-06-04T20:52:46.639974+02:00 lap-nba kernel: [787327.735623]  ?
trace_clock_local+0xc/0x30
2024-06-04T20:52:46.639974+02:00 lap-nba kernel: [787327.735628]  ?
__rb_reserve_next.constprop.0+0x57/0x410
2024-06-04T20:52:46.639975+02:00 lap-nba kernel: [787327.735633]  ?
trace_clock_local+0xc/0x30
2024-06-04T20:52:46.639990+02:00 lap-nba kernel: [787327.735638]  ?
__rb_reserve_next.constprop.0+0x57/0x410
2024-06-04T20:52:46.639991+02:00 lap-nba kernel: [787327.735646]  ?
ring_buffer_lock_reserve+0x122/0x390
2024-06-04T20:52:46.639991+02:00 lap-nba kernel: [787327.735658]  ?
trace_buffer_lock_reserve+0x21/0x50
2024-06-04T20:52:46.639992+02:00 lap-nba kernel: [787327.735664]  ?
__trace_graph_return+0x63/0x80
2024-06-04T20:52:46.639993+02:00 lap-nba kernel: [787327.735668]  ?
ring_buffer_unlock_commit+0x35/0x160
2024-06-04T20:52:46.639993+02:00 lap-nba kernel: [787327.735674]  ?
trace_graph_return+0x9b/0xf0
2024-06-04T20:52:46.639994+02:00 lap-nba kernel: [787327.735678]  ?
irqentry_exit_to_user_mode+0x5/0x30
2024-06-04T20:52:46.640001+02:00 lap-nba kernel: [787327.735684]  ?
ftrace_return_to_handler+0xa6/0x110
2024-06-04T20:52:46.640002+02:00 lap-nba kernel: [787327.735689]  ?
syscall_enter_from_user_mode_work+0x40/0x40
2024-06-04T20:52:46.640003+02:00 lap-nba kernel: [787327.735697]  ?
return_to_handler+0x15/0x40
2024-06-04T20:52:46.640003+02:00 lap-nba kernel: [787327.735702]=20
entry_SYSCALL_64_after_hwframe+0x6e/0xd8
2024-06-04T20:52:46.640004+02:00 lap-nba kernel: [787327.735706] RIP:
0033:0x7fc8ad99227f
2024-06-04T20:52:46.640005+02:00 lap-nba kernel: [787327.735711] Code: 89 5=
4 24
18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 =
41
89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 4=
8 89
44 24 08 e8 8c d5 f8 ff 48
2024-06-04T20:52:46.640012+02:00 lap-nba kernel: [787327.735714] RSP:
002b:00007fc8acb38850 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
2024-06-04T20:52:46.640012+02:00 lap-nba kernel: [787327.735719] RAX:
ffffffffffffffda RBX: 000055e2ebac1c10 RCX: 00007fc8ad99227f
2024-06-04T20:52:46.640013+02:00 lap-nba kernel: [787327.735722] RDX:
000000000000003c RSI: 000055e2ebac1c10 RDI: 0000000000000033
2024-06-04T20:52:46.640014+02:00 lap-nba kernel: [787327.735725] RBP:
000000000000003c R08: 0000000000000000 R09: 0000000000000004
2024-06-04T20:52:46.640014+02:00 lap-nba kernel: [787327.735728] R10:
0000000000000006 R11: 0000000000000293 R12: 000055e2ebac1c10
2024-06-04T20:52:46.640015+02:00 lap-nba kernel: [787327.735730] R13:
000000000000003c R14: 000000000000003c R15: 000055e2eba91350
2024-06-04T20:52:46.640022+02:00 lap-nba kernel: [787327.735746]  </TASK>
2024-06-04T20:52:46.640023+02:00 lap-nba kernel: [787327.735749] Modules li=
nked
in: cdc_acm pl2303 usbserial typec_displayport tun ppp_deflate bsd_comp
ppp_async tls uinput uhid rfcomm snd_seq_dummy snd_hrtimer snd_seq l2tp_ppp
l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox ppp_generic slhc
xfrm_user xfrm_algo nvme_fabrics ctr ccm team_mode_loadbalance team
vboxnetadp(OE) vboxnetflt(OE) 8021q garp stp mrp llc vboxdrv(OE) qrtr cmac
algif_hash algif_skcipher af_alg bnep sunrpc binfmt_misc squashfs snd_usb_a=
udio
snd_usbmidi_lib snd_rawmidi snd_seq_device btusb btrtl btbcm btintel btmtk
bluetooth jitterentropy_rng uvcvideo videobuf2_vmalloc videobuf2_memops
videobuf2_v4l2 drbg videobuf2_common ansi_cprng videodev ecdh_generic mc ecc
nls_ascii nls_cp437 vfat fat ext4 crc16 mbcache jbd2 snd_ctl_led
snd_soc_skl_hda_dsp snd_soc_intel_hda_dsp_common snd_sof_probes
snd_soc_hdac_hdmi snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic snd_soc_dmic snd_sof_pci_intel_tgl
snd_sof_intel_hda_common soundwire_intel
2024-06-04T20:52:46.640024+02:00 lap-nba kernel: [787327.735912]=20
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda snd_sof_pci
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core
snd_soc_acpi_intel_match x86_pkg_temp_thermal intel_powerclamp snd_soc_acpi
coretemp snd_soc_core snd_compress dell_laptop soundwire_bus iwlmvm kvm_int=
el
ledtrig_audio pmt_telemetry snd_hda_intel mei_hdcp pmt_class intel_rapl_msr
mac80211 snd_intel_dspcfg libarc4 kvm snd_intel_sdw_acpi irqbypass dell_wmi
snd_hda_codec rapl snd_hda_scodec_cs35l41_spi regmap_spi intel_cstate
snd_hda_scodec_cs35l41_i2c snd_hda_core snd_hda_scodec_cs35l41 snd_hwdep
hid_sensor_als snd_hda_cs_dsp_ctls joydev dell_smbios snd_pcm
hid_sensor_trigger cs_dsp iTCO_wdt hid_sensor_iio_common iwlwifi dcdbas
dell_wmi_sysman snd_timer snd_soc_cs35l41_lib intel_pmc_bxt
industrialio_triggered_buffer intel_uncore firmware_attributes_class wmi_bm=
of
dell_wmi_descriptor pcspkr iTCO_vendor_support snd kfifo_buf mei_me cfg80211
ucsi_acpi processor_thermal_device_pci
2024-06-04T20:52:46.640032+02:00 lap-nba kernel: [787327.736038]  watchdog
industrialio soundcore processor_thermal_device mei processor_thermal_rfim
typec_ucsi processor_thermal_mbox rfkill roles intel_vsec
processor_thermal_rapl intel_rapl_common typec serial_multi_instantiate
int3403_thermal int340x_thermal_zone int3400_thermal intel_hid acpi_pad
intel_pmc_core acpi_thermal_rel sparse_keymap acpi_tad hid_multitouch ac ev=
dev
serio_raw msr parport_pc ppdev lp parport loop fuse efi_pstore configfs
efivarfs ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq
zstd_compress libcrc32c crc32c_generic dm_crypt usbhid r8153_ecm cdc_ether
usbnet r8152 mii hid_sensor_custom hid_sensor_hub intel_ishtp_hid dm_mod i9=
15
crc32_pclmul crc32c_intel ghash_clmulni_intel hid_generic spi_pxa2xx_platfo=
rm
dw_dmac dw_dmac_core sha512_ssse3 drm_buddy sha512_generic i2c_algo_bit
drm_display_helper sha256_ssse3 sha1_ssse3 nvme cec rc_core nvme_core ttm
t10_pi rtsx_pci_sdmmc drm_kms_helper crc64_rocksoft_generic mmc_core
crc64_rocksoft crc_t10dif
2024-06-04T20:52:46.640033+02:00 lap-nba kernel: [787327.736193]=20
crct10dif_generic crct10dif_pclmul xhci_pci video atlantic xhci_hcd aesni_i=
ntel
crc64 i2c_hid_acpi i2c_i801 intel_ish_ipc intel_lpss_pci i2c_hid crypto_simd
intel_lpss psmouse cryptd usbcore drm thunderbolt rtsx_pci macsec intel_ish=
tp
i2c_smbus usb_common idma64 crct10dif_common battery hid button wmi
2024-06-04T20:52:46.640033+02:00 lap-nba kernel: [787327.736253] CR2:
0000000000000740
2024-06-04T20:52:46.640034+02:00 lap-nba kernel: [787327.736257] ---[ end t=
race
0000000000000000 ]---
2024-06-04T20:52:46.640035+02:00 lap-nba kernel: [787328.342652] RIP:
0010:hci_send_sco+0x13/0xb0 [bluetooth]
2024-06-04T20:52:46.640042+02:00 lap-nba kernel: [787328.342693] Code: c1 4=
8 c7
c7 88 b5 b8 c1 48 8b 50 30 e8 96 bc 07 e0 eb ca 0f 1f 40 00 e8 eb 79 a5 fe =
41
56 41 55 41 54 55 48 89 fd 53 48 89 f3 <4c> 8b a7 40 07 00 00 66 90 48 89 d=
f be
03 00 00 00 44 0f b7 75 32
2024-06-04T20:52:46.640071+02:00 lap-nba kernel: [787328.342698] RSP:
0018:ffffab06050bbba8 EFLAGS: 00010282
2024-06-04T20:52:46.640072+02:00 lap-nba kernel: [787328.342706] RAX:
0000000000000001 RBX: ffff909c5b3adf00 RCX: 0000000000000000
2024-06-04T20:52:46.640073+02:00 lap-nba kernel: [787328.342711] RDX:
0000000000000001 RSI: ffff909c5b3adf00 RDI: 0000000000000000
2024-06-04T20:52:46.640073+02:00 lap-nba kernel: [787328.342716] RBP:
0000000000000000 R08: 0000000000008a47 R09: 000000054beff8ef
2024-06-04T20:52:46.640074+02:00 lap-nba kernel: [787328.342721] R10:
0000000000000033 R11: 0000000000000000 R12: ffff909cc5ae8600
2024-06-04T20:52:46.640075+02:00 lap-nba kernel: [787328.342726] R13:
ffffab06050bbc40 R14: 000000000000003c R15: 0000000000000000
2024-06-04T20:52:46.640076+02:00 lap-nba kernel: [787328.342731] FS:=20
00007fc8acb396c0(0000) GS:ffff90a3af680000(0000) knlGS:0000000000000000
2024-06-04T20:52:46.640076+02:00 lap-nba kernel: [787328.342736] CS:  0010 =
DS:
0000 ES: 0000 CR0: 0000000080050033
2024-06-04T20:52:46.640077+02:00 lap-nba kernel: [787328.342740] CR2:
0000000000000740 CR3: 000000016c51e000 CR4: 0000000000750ee0
2024-06-04T20:52:46.640078+02:00 lap-nba kernel: [787328.342745] PKRU: 5555=
5554
2024-06-04T20:52:46.640078+02:00 lap-nba kernel: [787328.342750] note:
wireplumber[5643] exited with irqs disabled


Thanks again=20
Kind regards
Nicolas BARANGER

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
