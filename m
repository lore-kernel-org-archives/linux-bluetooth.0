Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5B14F70
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707677; cv=none; b=LllrCM6JZmDeRCk6F3+qo62jCNGCZseMCRlWG70tFU6FhdZ5QeeSrrwVN4y1+T8w9p4kHtcLCfJh1990dJLfAtpiARXSDm5mrTF57Zt8hTWsVHykK+PeW3brAkYidO/uiPG6EKT3aNaWzgdaHpaIdCnYoyh036G+7YTyfYZ3tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707677; c=relaxed/simple;
	bh=snQJPj1cBXNbtFBaCkvrPpS5ulju4SJe0fYYDxVrewY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fFLAzDMw8ydPP75fm1+uT40em11TomRmgkyYHUVvAFUOQj9lkvvEiBgmr4mDrfipwJDXaEPV27FA2MtWaoaYY0PfHp0nDQgFsAr7fTCBjDSK5337fJWyaYIRQ+4piSvY88srL0BC95upOsqqzUoiiCR8sWoV78G2tjnYiN96clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45e5c3c84so3285310276.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 06:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707674; x=1714312474;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Edx0bRGw66bjE8PmfGzQvt58hWyg9qy/MQstDBxVF1o=;
        b=Jp9bQuH7ex0gtWNzTyzNRtwmJVHincb4esDMJPQKUIMYOqBrIKmgprAbzfCkqBLhai
         JA80agB1wZ8lvDCDv9LllOZiXP8nLFqFjP85Mg3e6KH7X3dCid95Zn5LXp26tBEjxAAk
         Oi2imErk2bEhTMPgAYt6Aq/0/eucp+QDxpqnpTvoG3BMmui8g5Xr3yeXrsM0K3EA7c/3
         keaOZwoWfuh8j3pUWU7eZuq3C5AbjmyeUS4cPdKfgueCs/VmdDCruOGV89cHv7Fwjs7N
         9UJqY421CRqMeHycEUDy1Fe75XqNsXNvgYf17LRE9ePYNG9FbQXW1XORCAnsRjIlCZQR
         mmTQ==
X-Gm-Message-State: AOJu0YxKbMzizTc98YuT6hmLj5qDJb/+j9CyRUQXSqoCsxGetyOdG+kI
	73ZDHsPYgEFCnZDmfVdwww2X8LsCwQWQtsD4ak04r3YP5fsXtzh7NUkcezAyKqysw3n7OwJ5diN
	zIkcNvGUbcjM9Dp3ZpaoNVLC+Wryd2kwHPhg=
X-Google-Smtp-Source: AGHT+IGoPUeF1zvVRcij//aWSc+UgQueRCXilzdyf/0gcTYixLxEglzq7tTc1KpVXnYoqlt3kYKG9k77wbMwAyKDFjU=
X-Received: by 2002:a25:acc2:0:b0:dc6:ebca:c2e8 with SMTP id
 x2-20020a25acc2000000b00dc6ebcac2e8mr6985598ybd.5.1713707674312; Sun, 21 Apr
 2024 06:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>
Date: Sun, 21 Apr 2024 15:54:23 +0200
Message-ID: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
Subject: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

After upgrading my kernel to Debian's latest version (6.1.85), I
started encountering systematic kernel BUGs at boot, making the
bluetooth stack unusable. I initially reported this to Debian's bug
tracker:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1069301

.. but have since confirmed that this is reproducible with vanilla
kernels, including the latest 6.1.y version (6.1.87).

I tried various kernel versions (straight from kernel.org) to pinpoint
when the problem started occurring and the resultats are:

- linux 6.1.80 => OK
- linux 6.1.82 => OK
- linux 6.1.83 => BUG
- linux 6.1.85 => BUG
- linux 6.1.87 => BUG

I have included a trace below, and full system details are available
in the Debian bug listed above. Can you suggest any other tests I can
perform to help diagnose the origin of the problem?

[   22.660847] list_del corruption, ffff94d9f6302000->prev is
LIST_POISON2 (dead000000000122)
[   22.660887] ------------[ cut here ]------------
[   22.660890] kernel BUG at lib/list_debug.c:56!
[   22.660907] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   22.660917] CPU: 10 PID: 139 Comm: kworker/u25:0 Not tainted
6.1.0-20-amd64 #1  Debian 6.1.85-1
[   22.660929] Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.19.1 03/14/2024
[   22.660936] Workqueue: hci0 hci_cmd_sync_work [bluetooth]
[   22.661128] RIP: 0010:__list_del_entry_valid.cold+0x4b/0x6f
[   22.661147] Code: fe ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 48 18 7a
9f e8 14 a1 fe ff 0f 0b 48 89 fe 48 89 ca 48 c7 c7 10 18 7a 9f e8 00
a1 fe ff <0f> 0b 48 89 fe 48 c7 c7 d8 17 7a 9f e8 ef a0 fe ff 0f 0b 48
89 fe
[   22.661156] RSP: 0000:ffffae0e406efde0 EFLAGS: 00010246
[   22.661164] RAX: 000000000000004e RBX: ffff94d9f6302000 RCX: 0000000000000027
[   22.661172] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff94dfaf8a03a0
[   22.661177] RBP: ffff94d859392000 R08: 0000000000000000 R09: ffffae0e406efc78
[   22.661182] R10: 0000000000000003 R11: ffffffff9fed4448 R12: ffff94d859392000
[   22.661187] R13: ffff94d859392770 R14: ffff94d858cb9800 R15: dead000000000100
[   22.661194] FS:  0000000000000000(0000) GS:ffff94dfaf880000(0000)
knlGS:0000000000000000
[   22.661202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.661208] CR2: 00007f423c024038 CR3: 0000000799c04000 CR4: 0000000000750ee0
[   22.661214] PKRU: 55555554
[   22.661218] Call Trace:
[   22.661225]  <TASK>
[   22.661232]  ? __die_body.cold+0x1a/0x1f
[   22.661246]  ? die+0x2a/0x50
[   22.661257]  ? do_trap+0xc5/0x110
[   22.661268]  ? __list_del_entry_valid.cold+0x4b/0x6f
[   22.661279]  ? do_error_trap+0x6a/0x90
[   22.661289]  ? __list_del_entry_valid.cold+0x4b/0x6f
[   22.661298]  ? exc_invalid_op+0x4c/0x60
[   22.661307]  ? __list_del_entry_valid.cold+0x4b/0x6f
[   22.661316]  ? asm_exc_invalid_op+0x16/0x20
[   22.661328]  ? __list_del_entry_valid.cold+0x4b/0x6f
[   22.661337]  hci_conn_del+0x136/0x3e0 [bluetooth]
[   22.661466]  hci_abort_conn_sync+0xaa/0x230 [bluetooth]
[   22.661632]  ? abort_conn_sync+0x3d/0x70 [bluetooth]
[   22.661751]  hci_cmd_sync_work+0x9f/0x150 [bluetooth]
[   22.661915]  process_one_work+0x1c4/0x380
[   22.661929]  worker_thread+0x4d/0x380
[   22.661940]  ? rescuer_thread+0x3a0/0x3a0
[   22.661950]  kthread+0xd7/0x100
[   22.661959]  ? kthread_complete_and_exit+0x20/0x20
[   22.661969]  ret_from_fork+0x1f/0x30
[   22.661984]  </TASK>
[   22.661987] Modules linked in: ctr ccm nft_chain_nat xt_MASQUERADE
nf_nat nf_conntrack_netlink br_netfilter bridge stp llc xfrm_user
xfrm_algo nvme_fabrics rfcomm snd_seq_dummy snd_hrtimer snd_seq
snd_seq_device cmac algif_hash algif_skcipher af_alg snd_ctl_led
snd_soc_sof_sdw snd_soc_intel_hda_dsp_common snd_sof_probes
snd_soc_intel_sof_maxim_common snd_soc_rt715_sdca snd_soc_rt1316_sdw
regmap_sdw_mbq snd_hda_codec_hdmi regmap_sdw overlay ip6t_REJECT
nf_reject_ipv6 xt_hl ip6_tables ip6t_rt ipt_REJECT nf_reject_ipv4
xt_LOG qrtr nf_log_syslog nft_limit bnep ipmi_devintf ipmi_msghandler
xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c nfnetlink
binfmt_misc nls_ascii nls_cp437 vfat fat x86_pkg_temp_thermal
intel_powerclamp coretemp snd_soc_dmic snd_sof_pci_intel_tgl
snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation
soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
snd_sof snd_sof_utils
[   22.662122]  snd_soc_hdac_hda snd_hda_ext_core
snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core kvm_intel
snd_compress btusb soundwire_bus btrtl kvm btbcm snd_hda_intel btintel
snd_intel_dspcfg btmtk dell_laptop snd_intel_sdw_acpi irqbypass
ledtrig_audio bluetooth snd_hda_codec i915 snd_hda_core rapl mei_hdcp
intel_rapl_msr snd_hwdep processor_thermal_device_pci dell_wmi joydev
hid_sensor_als intel_cstate jitterentropy_rng processor_thermal_device
snd_pcm hid_sensor_trigger processor_thermal_rfim dell_smbios
ucsi_acpi dcdbas hid_sensor_iio_common processor_thermal_mbox
drm_buddy intel_uncore iwlmvm pcspkr drbg iTCO_wdt typec_ucsi
dell_wmi_sysman snd_timer industrialio_triggered_buffer
drm_display_helper processor_thermal_rapl mei_me dell_wmi_descriptor
firmware_attributes_class kfifo_buf wmi_bmof ansi_cprng intel_pmc_bxt
cec snd roles intel_rapl_common ecdh_generic iTCO_vendor_support
int3403_thermal watchdog ecc industrialio mei soundcore typec
int3400_thermal rc_core mac80211
[   22.662253]  int340x_thermal_zone intel_pmc_core button intel_hid
acpi_thermal_rel sparse_keymap ttm acpi_pad acpi_tad drm_kms_helper
libarc4 igen6_edac i2c_algo_bit ac evdev hid_multitouch serio_raw
iwlwifi cfg80211 rfkill msr parport_pc ppdev lp drm parport fuse loop
efi_pstore configfs efivarfs ip_tables x_tables autofs4 ext4 crc16
mbcache jbd2 crc32c_generic usbhid hid_sensor_custom hid_sensor_hub
dm_crypt dm_mod intel_ishtp_hid nvme nvme_core t10_pi
crc64_rocksoft_generic crc64_rocksoft crc_t10dif crct10dif_generic
crc64 ahci libahci crct10dif_pclmul crct10dif_common libata
crc32_pclmul crc32c_intel scsi_mod spi_pxa2xx_platform
ghash_clmulni_intel dw_dmac hid_generic sha512_ssse3 scsi_common
dw_dmac_core xhci_pci sha512_generic sha256_ssse3 xhci_hcd sha1_ssse3
usbcore i2c_hid_acpi intel_lpss_pci aesni_intel video intel_ish_ipc
i2c_i801 i2c_hid intel_lpss psmouse thunderbolt crypto_simd cryptd
i2c_smbus vmd intel_ishtp usb_common idma64 hid battery wmi
[   22.662422] ---[ end trace 0000000000000000 ]---

Cheers,

Jeremy
