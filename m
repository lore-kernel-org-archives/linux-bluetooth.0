Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=C5biCuJV335yfNWkY77xK29aa5JQ+9xvaE1yr@mail.gmail.com>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
 <20101022171825.GA980@vigoh> <AANLkTi=C5biCuJV335yfNWkY77xK29aa5JQ+9xvaE1yr@mail.gmail.com>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Mon, 25 Oct 2010 10:21:57 +0800
Message-ID: <AANLkTikri0+KPYqbs2VBAp=LUyW2YbyiaUH61e-2XaL7@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by del_timer()
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is a dump context:

[ 2544.321834] l2cap_do_send: sk e0325800, cid 3 skb f4839840 len 50
[ 2546.320108] l2cap_ack_timeout:
[ 2546.320122] l2cap_send_ack:
[ 2546.320129] l2cap_ertm_send: sk e0325800, sk->scid 3, sk->dcid 3
[ 2546.320138] l2cap_send_sframe:
[ 2546.320144] l2cap_send_sframe: pi e0325800, control 0x300
[ 2546.320152] l2cap_retrans_timeout: sk e0325800
[ 2546.320157] l2cap_send_rr_or_rnr:
[ 2546.320162] l2cap_send_sframe:
[ 2546.320166] l2cap_send_sframe: pi e0325800, control 0x310
[ 2548.204103] l2cap_disconn_ind: hcon f0443e00
[ 2548.273408] l2cap_disconn_cfm: hcon f0443e00 reason 22
[ 2548.273415] l2cap_conn_del:
[ 2548.273421] l2cap_conn_del: hcon f0443e00 conn f4839b40, err 103
[ 2548.273428] l2cap_free_sock_a2mp_internal: conn f4839b40	a2mp_sock e0325800
[ 2548.273438] l2cap_sock_close: sk e0325800, conn f4839b40
[ 2548.273444] l2cap_sock_clear_timer: sock e0325800 state 1
[ 2548.273450] l2cap_sock_clear_extimer: sock e0325800 state 1
[ 2548.273456] l2cap_sock_close: sk e0325800, conn f4839b40	a2mp_sock e0325800
[ 2548.273462] amp_a2mp_channel_exit: l2cap_conn f4839b40
[ 2548.273468] amp_a2mp_conn_unlink:
[ 2548.273473] amp_a2mp_channel_exit: exit
[ 2558.320031] l2cap_monitor_timeout: sk e0325800
[ 2558.320045] l2cap_send_disconn_req:
[ 2558.320051] l2cap_get_ident:
[ 2558.352291] BUG: unable to handle kernel NULL pointer dereference at 00000072
[ 2558.352325] IP: [<c0223b19>] dnotify_flush+0x19/0x100
[ 2558.352344] *pde = 00000000
[ 2558.352354] Oops: 0000 [#1] SMP
[ 2558.352364] last sysfs file:
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/PNP0C09:00/PNP0C0A:00/power_supply/BAT0/voltage_now
[ 2558.352376] Modules linked in: netconsole ar6000 binfmt_misc rfcomm
sco bridge stp ppdev bnep sha256_generic l2cap arc4
snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi joydev snd_rawmidi pcmcia iwlagn snd_seq_midi_event
snd_seq mmc_block yenta_socket iwlcore rsrc_nonstatic btusb sdhci_pci
snd_timer pcmcia_core sdhci snd_seq_device thinkpad_acpi tpm_tis
led_class tpm snd mac80211 psmouse bluetooth tpm_bios uvcvideo
soundcore snd_page_alloc videodev v4l1_compat nvram cfg80211 configfs
serio_raw iptable_filter lp ip_tables x_tables parport i915 fbcon
tileblit font bitblit softcursor radeon ttm drm_kms_helper drm usbhid
ohci1394 ieee1394 intel_agp e1000e i2c_algo_bit agpgart video output
[ 2558.352675]
[ 2558.352683] Pid: 1161, comm: Xorg Not tainted 2.6.34-rc7-300 #1
278225C/278225C
[ 2558.352691] EIP: 0060:[<c0223b19>] EFLAGS: 00013282 CPU: 1
[ 2558.352697] EIP is at dnotify_flush+0x19/0x100
[ 2558.352703] EAX: cccccccc EBX: eaf51b00 ECX: 00000000 EDX: eaf51b00
[ 2558.352712] ESI: e032e600 EDI: 00000000 EBP: f487df7c ESP: f487df68
[ 2558.352717]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[ 2558.352727] Process Xorg (pid: 1161, ti=f487c000 task=f671bfc0
task.ti=f487c000)
[ 2558.352732] Stack:
[ 2558.352737]  f487dfac c047a6f0 e032e600 eaf51b00 00000000 f487df94
c01f4027 fffffff7
[ 2558.352761] <0> eaf51b00 e032e600 00000012 f487dfac c01f40d3
eaf51b40 00000012 0c9ff878
[ 2558.352795] <0> 0c91c8c0 f487c000 c0102fa3 00000012 ffffffc8
081e5ff4 0c9ff878 0c91c8c0
[ 2558.352824] Call Trace:
[ 2558.352840]  [<c047a6f0>] ? sys_socketcall+0x140/0x2a0
[ 2558.352853]  [<c01f4027>] ? filp_close+0x37/0x70
[ 2558.352860]  [<c01f40d3>] ? sys_close+0x73/0xb0
[ 2558.352868]  [<c0102fa3>] ? sysenter_do_call+0x12/0x28
[ 2558.352882]  [<c0550000>] ? __down_interruptible+0x60/0xb0
[ 2558.352888] Code: f7 ff ff eb b2 8d b6 00 00 00 00 8d bc 27 00 00
00 00 55 89 e5 83 ec 14 89 5d f4 89 d3 89 75 f8 89 c6 89 7d fc 8b 40
0c 8b 78 10 <0f> b7 47 72 25 00 f0 00 00 3d 00 40 00 00 74 0f 8b 5d f4
8b 75
[ 2558.353070] EIP: [<c0223b19>] dnotify_flush+0x19/0x100 SS:ESP 0068:f487df68
[ 2558.353083] CR2: 0000000000000072
[ 2558.353307] ---[ end trace 577d994b8fcc4773 ]---
[ 2558.362500] BUG: unable to handle kernel NULL pointer dereference at 00000010
[ 2558.362531] IP: [<c01c515c>] set_page_dirty+0x1c/0x60
[ 2558.362554] *pde = 00000000
[ 2558.362563] Oops: 0000 [#2] SMP
[ 2558.362576] last sysfs file:
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/PNP0C09:00/PNP0C0A:00/power_supply/BAT0/voltage_now
[ 2558.362586] Modules linked in: netconsole ar6000 binfmt_misc rfcomm
sco bridge stp ppdev bnep sha256_generic l2cap arc4
snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi joydev snd_rawmidi pcmcia iwlagn snd_seq_midi_event
snd_seq mmc_block yenta_socket iwlcore rsrc_nonstatic btusb sdhci_pci
snd_timer pcmcia_core sdhci snd_seq_device thinkpad_acpi tpm_tis
led_class tpm snd mac80211 psmouse bluetooth tpm_bios uvcvideo
soundcore snd_page_alloc videodev v4l1_compat nvram cfg80211 configfs
serio_raw iptable_filter lp ip_tables x_tables parport i915 fbcon
tileblit font bitblit softcursor radeon ttm drm_kms_helper drm usbhid
ohci1394 ieee1394 intel_agp e1000e i2c_algo_bit agpgart video output
[ 2558.362892]
[ 2558.362901] Pid: 1161, comm: Xorg Tainted: G      D
2.6.34-rc7-300 #1 278225C/278225C
[ 2558.362909] EIP: 0060:[<c01c515c>] EFLAGS: 00013282 CPU: 1
[ 2558.362920] EIP is at set_page_dirty+0x1c/0x60
[ 2558.362930] EAX: c13630c0 EBX: b69d1000 ECX: 4010007c EDX: 00000000
[ 2558.362936] ESI: 00030cd2 EDI: f4873744 EBP: f487dce0 ESP: f487dce0
[ 2558.362942]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[ 2558.362949] Process Xorg (pid: 1161, ti=f487c000 task=f671bfc0
task.ti=f487c000)
[ 2558.362954] Stack:
[ 2558.362958]  f487dd64 c01d5117 f487dd00 c0109f56 00000000 f652e600
f671bfc0 00000001
[ 2558.362985] <0> 00000000 c07f7440 00000000 c1903450 f487dd7c
b69d1fff eaa58b68 b69d2000
[ 2558.363017] <0> 1b106067 f671bfc0 f04394d0 00000000 b69d0000
c1691e6c c1903440 b69d2000
[ 2558.363049] Call Trace:
[ 2558.363061]  [<c01d5117>] ? unmap_vmas+0x587/0x770
[ 2558.363072]  [<c0109f56>] ? __switch_to_xtra+0xb6/0x140
[ 2558.363081]  [<c01db1f0>] ? exit_mmap+0x90/0x150
[ 2558.363092]  [<c014350e>] ? mmput+0x2e/0xb0
[ 2558.363100]  [<c0147c90>] ? exit_mm+0xe0/0x100
[ 2558.363107]  [<c0147f6c>] ? do_exit+0x10c/0x740
[ 2558.363118]  [<c0146999>] ? kmsg_dump+0x119/0x130
[ 2558.363128]  [<c0552430>] ? oops_end+0x90/0xd0
[ 2558.363138]  [<c012960e>] ? no_context+0xbe/0x150
[ 2558.363147]  [<c0204768>] ? set_fd_set+0x38/0x50
[ 2558.363155]  [<c01296d7>] ? __bad_area_nosemaphore+0x37/0x160
[ 2558.363163]  [<c012985a>] ? __bad_area+0x3a/0x50
[ 2558.363171]  [<c0129882>] ? bad_area+0x12/0x20
[ 2558.363181]  [<c05545b6>] ? do_page_fault+0x406/0x410
[ 2558.363191]  [<c0164ad2>] ? __hrtimer_start_range_ns+0x162/0x410
[ 2558.363199]  [<c05541b0>] ? do_page_fault+0x0/0x410
[ 2558.363207]  [<c0551913>] ? error_code+0x73/0x80
[ 2558.363215]  [<c0223b19>] ? dnotify_flush+0x19/0x100
[ 2558.363226]  [<c047a6f0>] ? sys_socketcall+0x140/0x2a0
[ 2558.363237]  [<c01f4027>] ? filp_close+0x37/0x70
[ 2558.363244]  [<c01f40d3>] ? sys_close+0x73/0xb0
[ 2558.363252]  [<c0102fa3>] ? sysenter_do_call+0x12/0x28
[ 2558.363263]  [<c0550000>] ? __down_interruptible+0x60/0xb0
[ 2558.363268] Code: da eb 9b 8d b6 00 00 00 00 8d bf 00 00 00 00 55
8b 08 89 e5 8b 50 10 f7 c1 00 00 01 00 75 3f f6 c2 01 75 22 85 d2 74
1e 8b 52 38 <8b> 52 10 85 d2 74 0d ff d2 89 c2 89 d0 5d c3 90 8d 74 26
00 ba
[ 2558.363453] EIP: [<c01c515c>] set_page_dirty+0x1c/0x60 SS:ESP 0068:f487dce0
[ 2558.363470] CR2: 0000000000000010
[ 2558.363481] ---[ end trace 577d994b8fcc4774 ]---
[ 2558.363489] Fixing recursive fault but reboot is needed!
[ 2558.363497] BUG: scheduling while atomic: Xorg/1161/0x00000001
[ 2558.363502] Modules linked in: netconsole ar6000 binfmt_misc rfcomm
sco bridge stp ppdev bnep sha256_generic l2cap arc4
snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep
snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss
snd_seq_midi joydev snd_rawmidi pcmcia iwlagn snd_seq_midi_event
snd_seq mmc_block yenta_socket iwlcore rsrc_nonstatic btusb sdhci_pci
snd_timer pcmcia_core sdhci snd_seq_device thinkpad_acpi tpm_tis
led_class tpm snd mac80211 psmouse bluetooth tpm_bios uvcvideo
soundcore snd_page_alloc videodev v4l1_compat nvram cfg80211 configfs
serio_raw iptable_filter lp ip_tables x_tables parport i915 fbcon
tileblit font bitblit softcursor radeon ttm drm_kms_helper drm usbhid
ohci1394 ieee1394 intel_agp e1000e i2c_algo_bit agpgart video output
[ 2558.364031] Pid: 1161, comm: Xorg Tainted: G      D    2.6.34-rc7-300 #1
[ 2558.364037] Call Trace:
[ 2558.364054]  [<c0134d9d>] __schedule_bug+0x5d/0x70
[ 2558.364064]  [<c054ed07>] schedule+0x647/0x7e0
[ 2558.364074]  [<c0148518>] do_exit+0x6b8/0x740
[ 2558.364083]  [<c0146999>] ? kmsg_dump+0x119/0x130
[ 2558.364090]  [<c054e548>] ? printk+0x18/0x20
[ 2558.364100]  [<c0552430>] oops_end+0x90/0xd0
[ 2558.364108]  [<c012960e>] no_context+0xbe/0x150
[ 2558.364116]  [<c01296d7>] __bad_area_nosemaphore+0x37/0x160
[ 2558.364124]  [<c0129812>] bad_area_nosemaphore+0x12/0x20
[ 2558.364132]  [<c0554518>] do_page_fault+0x368/0x410
[ 2558.364141]  [<c01c6860>] ? release_pages+0x190/0x1c0
[ 2558.364149]  [<c05541b0>] ? do_page_fault+0x0/0x410
[ 2558.364156]  [<c0551913>] error_code+0x73/0x80
[ 2558.364164]  [<c012007b>] ? mask_IO_APIC_setup+0x9b/0xa0
[ 2558.364171]  [<c01c515c>] ? set_page_dirty+0x1c/0x60
[ 2558.364183]  [<c01d5117>] unmap_vmas+0x587/0x770
[ 2558.364194]  [<c0109f56>] ? __switch_to_xtra+0xb6/0x140
[ 2558.364203]  [<c01db1f0>] exit_mmap+0x90/0x150
[ 2558.364211]  [<c014350e>] mmput+0x2e/0xb0
[ 2558.364217]  [<c0147c90>] exit_mm+0xe0/0x100
[ 2558.364229]  [<c0147f6c>] do_exit+0x10c/0x740
[ 2558.364237]  [<c0146999>] ? kmsg_dump+0x119/0x130
[ 2558.364244]  [<c0552430>] oops_end+0x90/0xd0
[ 2558.364252]  [<c012960e>] no_context+0xbe/0x150
[ 2558.364261]  [<c0204768>] ? set_fd_set+0x38/0x50
[ 2558.364268]  [<c01296d7>] __bad_area_nosemaphore+0x37/0x160
[ 2558.364276]  [<c012985a>] __bad_area+0x3a/0x50
[ 2558.364282]  [<c0129882>] bad_area+0x12/0x20
[ 2558.364290]  [<c05545b6>] do_page_fault+0x406/0x410
[ 2558.364300]  [<c0164ad2>] ? __hrtimer_start_range_ns+0x162/0x410
[ 2558.364308]  [<c05541b0>] ? do_page_fault+0x0/0x410
[ 2558.364315]  [<c0551913>] error_code+0x73/0x80
[ 2558.364323]  [<c0223b19>] ? dnotify_flush+0x19/0x100
[ 2558.364333]  [<c047a6f0>] ? sys_socketcall+0x140/0x2a0
[ 2558.364344]  [<c01f4027>] filp_close+0x37/0x70
[ 2558.364352]  [<c01f40d3>] sys_close+0x73/0xb0
[ 2558.364359]  [<c0102fa3>] sysenter_do_call+0x12/0x28
[ 2558.364370]  [<c0550000>] ? __down_interruptible+0x60/0xb0
[ 2558.365152] init[1]: segfault at 0 ip (null) sp bfb4ba94 error 4 in
libnss_files-2.10.1.so[b74db000+a000]

-- 
Haijun Liu
