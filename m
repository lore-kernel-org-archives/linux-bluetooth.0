Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2571925B3;
	Tue, 31 Dec 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735635942; cv=none; b=qVSmCIZeHn/WyElhPmnTyaKs1nFi9u/4ijeekYHZqmQzZJNKbG8TSFkF0zCB+iLUld6HZse+bEC0ScL6b9bTCxO/1/WHf4Ec5x4apCIZfyspR7+ourpl9uYx+8UMQdp7vxpco1UY6mK530lfqAJFOB3wqFXW/gVMaXH5KjY7Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735635942; c=relaxed/simple;
	bh=HSc0Bqj38xfHlg17a0LgZHCuHfT1Pszdh5StdBXt5rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQjiaBX0WnZAtLYIYDpQ1rOxFD4xpmTIp221hRJqzrUZiXth37MdeVkQD1cBOUnja9tXJwmQpdGF6+A63C0a3p54xvh6UQThGsOuciAIWvFCOBYE0s6DCwzGg4GZ8A+YF7nH4+Jse90dyqP7IG2f3DN2TbD9dUL03BatLXoI1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lBpyrhGX; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lBpyrhGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735635906;
	bh=uosoHsKBY2Iam8tFb412RrpfPq/g2IsGiAHE2wiB1uI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lBpyrhGXfItnBUw9ny35f0PnqsYN4CqBOPPSKEVxZStY+OQvz1iyrXtOeBaxf8HI/
	 tLlPAdnKPGtO3arOFpvzHG6FhVZH3RpYT4FyiqbTLOEK2ZYY4eCyC6eTXE0W4FUyYy
	 GJowyJdixCp10v7DXrYxyGKixX9WY3xeLFaM9Uag=
X-QQ-mid: bizesmtpsz2t1735635902tezq83j
X-QQ-Originating-IP: AEf6osSPvUmHnYm5SMdFom6u9byAMXRlRoV5agEI+3E=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Dec 2024 17:05:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12827392511769339174
From: Wentao Guan <guanwentao@uniontech.com>
To: en-wei.wu@canonical.com
Cc: Markus.Elfring@web.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: Re: Bluetooth: btusb: Add NULL check for data in btusb_suspend
Date: Tue, 31 Dec 2024 17:05:00 +0800
Message-Id: <20241231090500.6970-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241223094411.47496-1-en-wei.wu@canonical.com>
References: <20241223094411.47496-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NHGFjaVOIMm2gU/xJx/gojb+ls45GYEE4FdvGxJ9o0ih2Pr6Rnqp3DdF
	W+jbA62nNCsa3JiWkAqohraC5u0iSqxusOdgom/Ky8nU+yvaEUujm8RfPGYlNnOv3ROxHiS
	evK+kvv8XpGcqwGTOBh9Kb2+QqIrqryLY+0rZTLKlRD9/jj1mhsCL1QTiKzIiJQF+DF4Cj0
	/nCTmLnneGIzUtwH0aAgwWrkt6Mm8pOt3Q6iawnU/DGvz2A7HLOYOTAjUoUGoLEqwAQMoFb
	cB3tklLAyJ6WWFlrOb24IHZp4U2uG3mJx7d42iMEIEqG7KjoACTyDFTEHEdpr2DX8xK5NRc
	9mDIWkzpeyi3H13JAvFKcBOgzo32xfdka0YiSYZ8/ENypFV2v/Jp8A3hlY2YYDZc7jKaBir
	dyCEQtgK4O9/dTyesBgbIJkCd1aaCLBjV+uh/752i3vjc1epPbZGnJTv7VDOgJ+3UktwsE3
	s/L+oMYxhu7mhc2EDz3PKB+pQQEOEtWmAScWlz2ghB0Liup3MOQVvjYQajKhyavJFu7TI0j
	9P07MAbfWIDCSsULELvnoDRXyJQ9V9a4ugqk8Ht2WbxyErIJSaQcDgRY8kaL3zlpsfd8pQS
	9+0t2Y7XPjtH+lZOYjQQ50zY8cl4+phjsIQYLC3TDw0m70sSPjGDBRtpTkiFPdTGR9d45jB
	vTe90mAYcefn9zjIL5REvdbF5L8k07OxjpJfvm7oT91Bxw4+DTewX/2g0LBtfYRdPrVsVN7
	hCDf99Js+kC8efxEC14PTr6DthOHtDl9CHHfAEokgllmqG6EpFHahoW4WeXkPiPycvlFWhj
	3MUZMEAayD2ALGK/yDSBGrJ4ItFn57W9eFXTY9Ot3vVBRI9l/n65FwwqhTiqCyvtJ2E1vfF
	II7ojUrzLSY0rxhRlhFbuOuhxK0l1G5mY4QfqTTGh0ujZXsjSXsECxPaYtTb3iAMIlxQ4rj
	KMnZwTjkfdYigj0lT7Z0TbEs68407MmyZN6OYbmhKfT/KAA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hello Wu,

When I try 6.12 kernel with mt7925e now. I met the same problem.
I tryed this fix, and test reboot many times, it works well.
Thanks.

BRs
Wentao Guan

Problem Log:
[    7.771027] mt7925e 0000:61:00.0 wlp97s0: renamed from wlan0
[    7.807739] r8169 0000:62:00.0: firmware: failed to load rtl_nic/rtl8168=
h-2.fw (-2)
[    7.828394] Generic FE-GE Realtek PHY r8169-0-6200:00: attached PHY driv=
er (mii_bus:phy_addr=3Dr8169-0-6200:00, irq=3DMAC)
[    7.984486] r8169 0000:62:00.0 enp98s0: Link is Down
[    8.475865] Bluetooth: hci0: Device setup in 1814888 usecs
[    8.475889] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[    8.588117] Bluetooth: hci0: AOSP extensions version v1.00
[    8.588137] Bluetooth: hci0: AOSP quality report is supported
[    8.588505] Bluetooth: MGMT ver 1.23
[    8.594166] NET: Registered PF_ALG protocol family
[    8.616544] Bluetooth: hci0: Invalid link address type 1 for 9c:19:c2:3f=
:af:85
[   10.588633] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[   10.588649] #PF: supervisor read access in kernel mode
[   10.588652] #PF: error_code(0x0000) - not-present page
[   10.588655] PGD 0 P4D 0=20
[   10.588660] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   10.588668] CPU: 18 UID: 0 PID: 219 Comm: kworker/18:1 Tainted: G       =
 W  OE      6.12.1 #1
[   10.588676] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   10.588677] Hardware name: LENOVO 21Q4/LNVNB161216, BIOS PXCN22WW 10/16/=
2024
[   10.588680] Workqueue: pm pm_runtime_work
[   10.588694] RIP: 0010:btusb_suspend+0x2a/0x200 [btusb]
[   10.588711] Code: f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 41 =
89 f4 53 48 8b 9f c8 00 00 00 0f 1f 44 00 00 41 81 e4 00 04 00 00 74 45 <48=
> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
[   10.588715] RSP: 0018:ffffa22dc0a13c30 EFLAGS: 00010206
[   10.588718] RAX: ffffffffc21599e0 RBX: 0000000000000000 RCX: 00000000000=
00003
[   10.588721] RDX: ffff9517417c9c00 RSI: 0000000000000402 RDI: ffff9517417=
cec00
[   10.588722] RBP: ffffa22dc0a13c48 R08: ffff9517698a2800 R09: ffff9517417=
c9cb0
[   10.588724] R10: ffff951da1c5ab00 R11: 0000000000000000 R12: 00000000000=
00400
[   10.588726] R13: ffff9517417cec00 R14: 0000000000000003 R15: ffffffffa96=
079c0
[   10.588727] FS:  0000000000000000(0000) GS:ffff951da1f00000(0000) knlGS:=
0000000000000000
[   10.588730] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.588731] CR2: 0000000000000000 CR3: 000000028884c000 CR4: 0000000000f=
50ef0
[   10.588734] PKRU: 55555554
[   10.588736] Call Trace:
[   10.588740]  <TASK>
[   10.588746]  ? show_regs+0x68/0x80
[   10.588755]  ? __die+0x28/0x70
[   10.588758]  ? page_fault_oops+0xa4/0x160
[   10.588765]  ? do_user_addr_fault+0x30f/0x670
[   10.588768]  ? exc_page_fault+0x7b/0x180
[   10.588776]  ? asm_exc_page_fault+0x2b/0x30
[   10.588785]  ? __pfx_usb_runtime_suspend+0x10/0x10
[   10.588793]  ? __pfx_btusb_suspend+0x10/0x10 [btusb]
[   10.588801]  ? btusb_suspend+0x2a/0x200 [btusb]
[   10.588805]  usb_suspend_both+0x97/0x2a0
[   10.588810]  ? sched_clock_noinstr+0xd/0x20
[   10.588814]  ? __pfx_usb_runtime_suspend+0x10/0x10
[   10.588817]  usb_runtime_suspend+0x33/0x80
[   10.588820]  __rpm_callback+0x49/0x160
[   10.588824]  ? __remove_hrtimer+0x40/0x90
[   10.588830]  rpm_callback+0x60/0x70
[   10.588832]  rpm_suspend+0xe5/0x5f0
[   10.588834]  ? sched_clock_cpu+0x14/0x1a0
[   10.588841]  ? psi_group_change+0x130/0x360
[   10.588846]  __pm_runtime_suspend+0x42/0xd0
[   10.588849]  ? __pfx_usb_runtime_idle+0x10/0x10
[   10.588852]  usb_runtime_idle+0x3d/0x50
[   10.588855]  rpm_idle+0xce/0x2a0
[   10.588857]  pm_runtime_work+0x97/0xd0
[   10.588860]  process_one_work+0x18b/0x3c0
[   10.588867]  worker_thread+0x285/0x420
[   10.588871]  ? __pfx_worker_thread+0x10/0x10
[   10.588874]  kthread+0xe5/0x120
[   10.588879]  ? __pfx_kthread+0x10/0x10
[   10.588881]  ret_from_fork+0x3e/0x60
[   10.588887]  ? __pfx_kthread+0x10/0x10
[   10.588889]  ret_from_fork_asm+0x1a/0x30
[   10.588896]  </TASK>
[   10.588896] Modules linked in: cmac algif_hash algif_skcipher af_alg vfs=
_monitor(OE) qrtr bnep binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr int=
el_rapl_common snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_c=
omponent snd_hda_codec_hdmi snd_soc_dmic snd_sof_amd_rembrandt snd_sof_amd_=
renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils=
 snd_soc_core edac_mce_amd snd_compress ac97_bus snd_pcm_dmaengine uvcvideo=
 snd_pci_ps mt7925e snd_hda_intel mt7925_common snd_intel_dspcfg snd_rpl_pc=
i_acp6x videobuf2_vmalloc snd_intel_sdw_acpi mt792x_lib uvc snd_acp_pci btu=
sb videobuf2_memops mt76_connac_lib snd_hda_codec snd_acp_legacy_common kvm=
_amd joydev videobuf2_v4l2 btrtl snd_pci_acp6x mt76 btintel snd_pci_acp5x s=
nd_hda_core videobuf2_common btbcm snd_hwdep kvm mac80211 snd_rn_pci_acp3x =
btmtk videodev snd_pcm snd_acp_config snd_timer think_lmi bluetooth rapl mc=
 firmware_attributes_class snd wmi_bmof pcspkr hid_multitouch snd_soc_acpi =
ucsi_acpi hid_sensor_als cfg80211 soundcore snd_pci_acp3x
[   10.588975]  hid_sensor_trigger amd_pmf typec_ucsi sp5100_tco k10temp in=
dustrialio_triggered_buffer libarc4 amdtee ideapad_laptop kfifo_buf typec s=
parse_keymap hid_sensor_iio_common tee platform_profile industrialio amd_pm=
c input_leds serio_raw mac_hid vmwgfx parport_pc ppdev lp parport efi_pstor=
e nfnetlink dmi_sysfs ip_tables x_tables autofs4 overlay btrfs blake2b_gene=
ric xor raid6_pq libcrc32c amdgpu amdxcp drm_exec gpu_sched drm_buddy i2c_a=
lgo_bit drm_suballoc_helper drm_ttm_helper ttm hid_sensor_custom drm_displa=
y_helper hid_sensor_hub drm_kms_helper hid_generic i2c_hid_acpi i2c_hid drm=
 crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmuln=
i_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 amd_sfh thunderbolt sdhci_pci =
hid r8169 i2c_piix4 cqhci xhci_pci i2c_designware_platform i2c_smbus video =
xhci_pci_renesas sdhci realtek wmi ccp i2c_designware_core aesni_intel cryp=
to_simd cryptd
[   10.589058] CR2: 0000000000000000
[   10.589063] ---[ end trace 0000000000000000 ]---
[   11.594342] pstore: backend (efi_pstore) writing error (-28)
[   11.594345] RIP: 0010:btusb_suspend+0x2a/0x200 [btusb]
[   11.594350] Code: f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 41 =
89 f4 53 48 8b 9f c8 00 00 00 0f 1f 44 00 00 41 81 e4 00 04 00 00 74 45 <48=
> 8b 13 8b 82 bc 09 00 00 03 82 b8 09 00 00 03 82 c4 09 00 00 03
[   11.594351] RSP: 0018:ffffa22dc0a13c30 EFLAGS: 00010206
[   11.594353] RAX: ffffffffc21599e0 RBX: 0000000000000000 RCX: 00000000000=
00003
[   11.594354] RDX: ffff9517417c9c00 RSI: 0000000000000402 RDI: ffff9517417=
cec00
[   11.594355] RBP: ffffa22dc0a13c48 R08: ffff9517698a2800 R09: ffff9517417=
c9cb0
[   11.594355] R10: ffff951da1c5ab00 R11: 0000000000000000 R12: 00000000000=
00400
[   11.594356] R13: ffff9517417cec00 R14: 0000000000000003 R15: ffffffffa96=
079c0
[   11.594357] FS:  0000000000000000(0000) GS:ffff951da1f00000(0000) knlGS:=
0000000000000000
[   11.594358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.594358] CR2: 0000000000000000 CR3: 000000011ef6c000 CR4: 0000000000f=
50ef0
[   11.594359] PKRU: 55555554
[   11.594360] note: kworker/18:1[219] exited with irqs disabled

