Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2952C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Nov 2022 06:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiKNGIV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 01:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKNGIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 01:08:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA60A646F
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 22:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55C01CE0C45
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69CD0C433D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 06:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668406093;
        bh=Uuzrt0i5AvsAT/BynMg+6HgSg4uIvCKaNYS07h0pSZE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dgyf+sJftAuO/YtUDxf4ZrBWA/EWSxkJGmMAAT5L0QqgLeRv/zpVAYOf2aUUvFqoF
         zHY9MndrogcMuJRQ0PXkBnSvckg7pHStMnS1YQ0o5MeWY8UcVijC1key2+S66dfur6
         Ks7/LpIjUpH6pljJwWRRo79wOZbA3cNeJO2+/aGgtdCmZamLkNKdVxjKm9PFgj9XCq
         bEEl+wafn+xkqxjLC0NbbqpTAslFZxXo2Nr2fQMuQB3q1JHxtk0iKyd27g+yUn530M
         BEsjbyaglp9RubjON+5vRF53BsB+4dsrYL8eXy7iFnCVxs4l2iL9sCKXSFkgPYFWyX
         MoJApRVK6jcqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5567CC433E4; Mon, 14 Nov 2022 06:08:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Mon, 14 Nov 2022 06:08:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216686-62941-hyN7OTyDZF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #12 from frc.gabriel@gmail.com ---
Created attachment 303171
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303171&action=3Dedit
dmesg bluetooth-next master branch HEAD

Triggering the bug while running btmon with the HEAD of master branch from
bluetooth-next does not renders the computer unusable, but
disconnecting+connecting the the headset is not as smooth compared with
bluetooth-next branch (which freezes computer).

```
[  301.300526] PM: suspend exit
[  301.301469] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[  301.301473] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852au_fw.bin
[  301.301583] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852au_config.bin
[  301.301640] Bluetooth: hci0: RTL: cfg_sz 6, total sz 47155
[  301.393319] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[  301.429363] usb 5-3: new full-speed USB device number 5 using xhci_hcd
[  301.508834] psmouse serio1: synaptics: queried max coordinates: x [..567=
8],
y [..4694]
[  301.521632] r8169 0000:02:00.0 enp2s0f0: Link is Down
[  301.547243] psmouse serio1: synaptics: queried min coordinates: x [1266.=
.],
y [1162..]
[  301.553423] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[  301.590802] usb 5-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00bd,
bcdDevice=3D 0.00
[  301.590815] usb 5-3: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D1
[  301.590821] usb 5-3: SerialNumber: f699a1169720
[  301.700442] Bluetooth: hci0: RTL: fw version 0xd9b88207
[  301.757826] r8169 0000:05:00.0 enp5s0: Link is Down
[  301.824556] Bluetooth: MGMT ver 1.22
[  305.674822] wlp3s0: authenticate with e4:bf:fa:cc:15:70
[  305.674836] wlp3s0: Invalid HE elem, Disable HE
[  305.800382] wlp3s0: send auth to e4:bf:fa:cc:15:70 (try 1/3)
[  305.802262] wlp3s0: authenticated
[  305.805269] wlp3s0: associate with e4:bf:fa:cc:15:70 (try 1/3)
[  305.806658] wlp3s0: RX AssocResp from e4:bf:fa:cc:15:70 (capab=3D0x1011
status=3D0 aid=3D3)
[  305.917751] wlp3s0: associated
[  305.917962] wlp3s0: Limiting TX power to 23 (23 - 0) dBm as advertised by
e4:bf:fa:cc:15:70
[  305.985550] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[  316.051610] audit: type=3D1400 audit(1668405359.412:35): apparmor=3D"DEN=
IED"
operation=3D"open" profile=3D"/usr/sbin/cups-browsed"
name=3D"/proc/sys/net/ipv6/conf/all/disable_ipv6" pid=3D1948 comm=3D"cups-b=
rowsed"
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ouid=3D0
[  316.101113] audit: type=3D1400 audit(1668405359.460:36): apparmor=3D"DEN=
IED"
operation=3D"open" profile=3D"/usr/sbin/cups-browsed"
name=3D"/proc/sys/net/ipv6/conf/all/disable_ipv6" pid=3D1948 comm=3D"cups-b=
rowsed"
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ouid=3D0
[  316.110480] audit: type=3D1400 audit(1668405359.472:37): apparmor=3D"DEN=
IED"
operation=3D"open" profile=3D"/usr/sbin/cups-browsed"
name=3D"/proc/sys/net/ipv6/conf/all/disable_ipv6" pid=3D1948 comm=3D"cups-b=
rowsed"
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ouid=3D0
[  316.119295] audit: type=3D1400 audit(1668405359.480:38): apparmor=3D"DEN=
IED"
operation=3D"open" profile=3D"/usr/sbin/cups-browsed"
name=3D"/proc/sys/net/ipv6/conf/all/disable_ipv6" pid=3D1948 comm=3D"cups-b=
rowsed"
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D0 ouid=3D0
[  334.857310] Bluetooth: \x05: unknown dev_type 141
[  334.857335] BUG: kernel NULL pointer dereference, address: 0000000000000=
102
[  334.857339] #PF: supervisor read access in kernel mode
[  334.857343] #PF: error_code(0x0000) - not-present page
[  334.857346] PGD 0 P4D 0=20
[  334.857351] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  334.857356] CPU: 12 PID: 1382 Comm: krfcommd Not tainted 6.0.0-rc7+ #1
[  334.857360] Hardware name: LENOVO 21A00004GE/21A00004GE, BIOS R1MET51W (=
1.21
) 09/15/2022
[  334.857364] RIP: 0010:__queue_work+0x1c/0x460
[  334.857376] Code: 8f 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 =
00
41 57 41 56 41 55 41 89 fd 41 54 49 89 f4 55 53 48 89 d3 48 83 ec 08 <f6> 8=
6 02
01 00 00 01 0f 85 e1 02 00 00 e8 42 e4 06 00 45 89 ee 41
[  334.857379] RSP: 0018:ffffc16dcc66fc40 EFLAGS: 00010082
[  334.857383] RAX: 0000000000000282 RBX: ffff9ecde6f2b488 RCX:
0000000000000000
[  334.857385] RDX: ffff9ecde6f2b488 RSI: 0000000000000000 RDI:
0000000000002000
[  334.857387] RBP: ffffc16dcc66fd10 R08: 0000000000000000 R09:
ffffc16dcc66fa58
[  334.857389] R10: 0000000000000003 R11: ffffffffa3ad16a8 R12:
0000000000000000
[  334.857391] R13: 0000000000002000 R14: ffff9ecd809e4e00 R15:
ffff9ecdb3282400
[  334.857393] FS:  0000000000000000(0000) GS:ffff9ed392100000(0000)
knlGS:0000000000000000
[  334.857396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  334.857399] CR2: 0000000000000102 CR3: 000000042b410000 CR4:
0000000000750ee0
[  334.857401] PKRU: 55555554
[  334.857403] Call Trace:
[  334.857408]  <TASK>
[  334.857416]  queue_work_on+0x37/0x40
[  334.857426]  l2cap_chan_send+0x12f/0xc60 [bluetooth]
[  334.857483]  ? remove_wait_queue+0x20/0x60
[  334.857489]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[  334.857497]  ? preempt_count_add+0x6a/0xa0
[  334.857503]  l2cap_sock_sendmsg+0x9a/0x100 [bluetooth]
[  334.857539]  sock_sendmsg+0x5f/0x70
[  334.857548]  rfcomm_send_frame+0x62/0xa0 [rfcomm]
[  334.857562]  rfcomm_send_disc.isra.0+0x80/0xd0 [rfcomm]
[  334.857570]  __rfcomm_dlc_disconn+0x10a/0x120 [rfcomm]
[  334.857577]  __rfcomm_dlc_close+0x60/0x200 [rfcomm]
[  334.857583]  rfcomm_run+0x6f6/0x1900 [rfcomm]
[  334.857591]  ? _raw_spin_rq_lock_irqsave+0x20/0x20
[  334.857596]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[  334.857602]  kthread+0xe9/0x110
[  334.857608]  ? kthread_complete_and_exit+0x20/0x20
[  334.857613]  ret_from_fork+0x22/0x30
[  334.857622]  </TASK>
[  334.857623] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE
nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables libcrc32c nfnetlink
br_netfilter bridge stp llc nvme_fabrics uinput ctr ccm rfcomm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device qrtr overlay cpufreq_ondemand
cpufreq_powersave cpufreq_conservative cmac cpufreq_userspace algif_hash
algif_skcipher zstd af_alg zstd_compress bnep zram zsmalloc binfmt_misc
nls_ascii nls_cp437 vfat fat btusb btrtl btbcm btintel btmtk bluetooth
snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic rtw89_8852ae
rtw89_8852a snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common rtw89_pci
uvcvideo snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn jitterentropy_rng
rtw89_core snd_hda_intel videobuf2_vmalloc snd_soc_core videobuf2_memops
videobuf2_v4l2 snd_intel_dspcfg snd_hda_codec kvm_amd snd_pci_acp6x drbg
videobuf2_common snd_hwdep mac80211 wmi_bmof snd_pci_acp5x
[  334.857705]  ansi_cprng kvm libarc4 videodev irqbypass snd_rn_pci_acp3x
snd_hda_core ecdh_generic snd_acp_config mc rapl ecc pcspkr thinkpad_acpi
snd_soc_acpi ccp snd_pcm cfg80211 snd_pci_acp3x nvram rng_core ledtrig_audio
snd_timer sp5100_tco platform_profile ucsi_acpi k10temp watchdog snd typec_=
ucsi
roles soundcore rfkill typec wmi ac battery video button evdev joydev serio=
_raw
amd_pstate msr parport_pc ppdev lp parport fuse configfs efi_pstore efivarfs
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 dm_crypt
dm_mod amdgpu crc32_pclmul crc32c_intel drm_ttm_helper ttm ghash_clmulni_in=
tel
gpu_sched nvme i2c_algo_bit drm_buddy nvme_core rtsx_pci_sdmmc xhci_pci
drm_display_helper t10_pi mmc_core xhci_hcd r8169 drm_kms_helper realtek
crc64_rocksoft_generic aesni_intel crc64_rocksoft mdio_devres drm crc_t10dif
crypto_simd usbcore psmouse cec cryptd crct10dif_generic libphy rc_core
crct10dif_pclmul i2c_piix4 rtsx_pci usb_common crc64 crct10dif_common i2c_s=
cmi
sha512_ssse3
[  334.857807]  sha512_generic
[  334.857814] CR2: 0000000000000102
[  334.857817] ---[ end trace 0000000000000000 ]---
[  334.861275] RIP: 0010:__queue_work+0x1c/0x460
[  334.861275] Code: 8f 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 =
00
41 57 41 56 41 55 41 89 fd 41 54 49 89 f4 55 53 48 89 d3 48 83 ec 08 <f6> 8=
6 02
01 00 00 01 0f 85 e1 02 00 00 e8 42 e4 06 00 45 89 ee 41
[  334.861275] RSP: 0018:ffffc16dcc66fc40 EFLAGS: 00010082
[  334.861275] RAX: 0000000000000282 RBX: ffff9ecde6f2b488 RCX:
0000000000000000
[  334.861275] RDX: ffff9ecde6f2b488 RSI: 0000000000000000 RDI:
0000000000002000
[  334.861275] RBP: ffffc16dcc66fd10 R08: 0000000000000000 R09:
ffffc16dcc66fa58
[  334.959941] R10: 0000000000000003 R11: ffffffffa3ad16a8 R12:
0000000000000000
[  334.959941] R13: 0000000000002000 R14: ffff9ecd809e4e00 R15:
ffff9ecdb3282400
[  334.959941] FS:  0000000000000000(0000) GS:ffff9ed392100000(0000)
knlGS:0000000000000000
[  334.959941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  334.959941] CR2: 0000000000000102 CR3: 0000000161a42000 CR4:
0000000000750ee0
[  334.959941] PKRU: 55555554
[  350.116698] BUG: unable to handle page fault for address: ffffc16dcc66fe=
b0
[  350.116706] #PF: supervisor read access in kernel mode
[  350.116709] #PF: error_code(0x0000) - not-present page
[  350.116712] PGD 100000067 P4D 100000067 PUD 1001a4067 PMD 106ffa067 PTE 0
[  350.116717] Oops: 0000 [#2] PREEMPT SMP NOPTI
[  350.116721] CPU: 4 PID: 860 Comm: kworker/u33:1 Tainted: G      D=20=20=
=20=20=20=20=20=20=20=20=20
6.0.0-rc7+ #1
[  350.116724] Hardware name: LENOVO 21A00004GE/21A00004GE, BIOS R1MET51W (=
1.21
) 09/15/2022
[  350.116727] Workqueue: hci0 hci_rx_work [bluetooth]
[  350.116759] RIP: 0010:__wake_up_common+0x4c/0x180
[  350.116768] Code: 24 0c 89 4c 24 08 4d 85 c9 74 0a 41 f6 01 04 0f 85 a3 =
00
00 00 48 8b 43 08 4c 8d 40 e8 48 83 c3 08 49 8d 40 18 48 39 c3 74 5b <49> 8=
b 40
18 31 ed 4c 8d 70 e8 45 8b 28 41 f6 c5 04 75 5f 49 8b 40
[  350.116770] RSP: 0018:ffffc16dc2777ce0 EFLAGS: 00010002
[  350.116773] RAX: ffffc16dcc66feb0 RBX: ffffffffc18440a8 RCX:
0000000000000000
[  350.116775] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
ffffffffc18440a0
[  350.116777] RBP: 0000000000000246 R08: ffffc16dcc66fe98 R09:
ffffc16dc2777d30
[  350.116778] R10: ffff9ecdb3282421 R11: 00000000dd721946 R12:
ffffc16dc2777d30
[  350.116780] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
[  350.116781] FS:  0000000000000000(0000) GS:ffff9ed391f00000(0000)
knlGS:0000000000000000
[  350.116784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.116785] CR2: ffffc16dcc66feb0 CR3: 000000042b410000 CR4:
0000000000750ee0
[  350.116787] PKRU: 55555554
[  350.116789] Call Trace:
[  350.116794]  <TASK>
[  350.116800]  __wake_up_common_lock+0x7b/0xc0
[  350.116805]  hci_encrypt_change_evt+0x160/0x4e0 [bluetooth]
[  350.116835]  ? hci_cs_read_remote_features+0x1e0/0x1e0 [bluetooth]
[  350.116859]  hci_event_packet+0x3ad/0x570 [bluetooth]
[  350.116884]  hci_rx_work+0x9c/0x580 [bluetooth]
[  350.116909]  process_one_work+0x1c7/0x380
[  350.116913]  worker_thread+0x4d/0x380
[  350.116916]  ? rescuer_thread+0x3a0/0x3a0
[  350.116918]  kthread+0xe9/0x110
[  350.116922]  ? kthread_complete_and_exit+0x20/0x20
[  350.116925]  ret_from_fork+0x22/0x30
[  350.116931]  </TASK>
[  350.116932] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE
nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables libcrc32c nfnetlink
br_netfilter bridge stp llc nvme_fabrics uinput ctr ccm rfcomm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device qrtr overlay cpufreq_ondemand
cpufreq_powersave cpufreq_conservative cmac cpufreq_userspace algif_hash
algif_skcipher zstd af_alg zstd_compress bnep zram zsmalloc binfmt_misc
nls_ascii nls_cp437 vfat fat btusb btrtl btbcm btintel btmtk bluetooth
snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic rtw89_8852ae
rtw89_8852a snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common rtw89_pci
uvcvideo snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn jitterentropy_rng
rtw89_core snd_hda_intel videobuf2_vmalloc snd_soc_core videobuf2_memops
videobuf2_v4l2 snd_intel_dspcfg snd_hda_codec kvm_amd snd_pci_acp6x drbg
videobuf2_common snd_hwdep mac80211 wmi_bmof snd_pci_acp5x
[  350.116993]  ansi_cprng kvm libarc4 videodev irqbypass snd_rn_pci_acp3x
snd_hda_core ecdh_generic snd_acp_config mc rapl ecc pcspkr thinkpad_acpi
snd_soc_acpi ccp snd_pcm cfg80211 snd_pci_acp3x nvram rng_core ledtrig_audio
snd_timer sp5100_tco platform_profile ucsi_acpi k10temp watchdog snd typec_=
ucsi
roles soundcore rfkill typec wmi ac battery video button evdev joydev serio=
_raw
amd_pstate msr parport_pc ppdev lp parport fuse configfs efi_pstore efivarfs
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 dm_crypt
dm_mod amdgpu crc32_pclmul crc32c_intel drm_ttm_helper ttm ghash_clmulni_in=
tel
gpu_sched nvme i2c_algo_bit drm_buddy nvme_core rtsx_pci_sdmmc xhci_pci
drm_display_helper t10_pi mmc_core xhci_hcd r8169 drm_kms_helper realtek
crc64_rocksoft_generic aesni_intel crc64_rocksoft mdio_devres drm crc_t10dif
crypto_simd usbcore psmouse cec cryptd crct10dif_generic libphy rc_core
crct10dif_pclmul i2c_piix4 rtsx_pci usb_common crc64 crct10dif_common i2c_s=
cmi
sha512_ssse3
[  350.117065]  sha512_generic
[  350.117069] CR2: ffffc16dcc66feb0
[  350.117071] ---[ end trace 0000000000000000 ]---
[  350.120656] RIP: 0010:__queue_work+0x1c/0x460
[  350.120656] Code: 8f 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 =
00
41 57 41 56 41 55 41 89 fd 41 54 49 89 f4 55 53 48 89 d3 48 83 ec 08 <f6> 8=
6 02
01 00 00 01 0f 85 e1 02 00 00 e8 42 e4 06 00 45 89 ee 41
[  350.120656] RSP: 0018:ffffc16dcc66fc40 EFLAGS: 00010082
[  350.120656] RAX: 0000000000000282 RBX: ffff9ecde6f2b488 RCX:
0000000000000000
[  350.120656] RDX: ffff9ecde6f2b488 RSI: 0000000000000000 RDI:
0000000000002000
[  350.120656] RBP: ffffc16dcc66fd10 R08: 0000000000000000 R09:
ffffc16dcc66fa58
[  350.120656] R10: 0000000000000003 R11: ffffffffa3ad16a8 R12:
0000000000000000
[  350.120656] R13: 0000000000002000 R14: ffff9ecd809e4e00 R15:
ffff9ecdb3282400
[  350.120656] FS:  0000000000000000(0000) GS:ffff9ed391f00000(0000)
knlGS:0000000000000000
[  350.120656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.120656] CR2: ffffc16dcc66feb0 CR3: 0000000206866000 CR4:
0000000000750ee0
[  350.120656] PKRU: 55555554
[  350.120656] note: kworker/u33:1[860] exited with preempt_count 1

```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
