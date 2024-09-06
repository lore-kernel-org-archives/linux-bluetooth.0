Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3631C8FD8;
	Fri,  6 Sep 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618865; cv=none; b=hqLtdt8iWYlKOlvmSY5L4FeYoEcolw+4ivldVReJKofecxdr6hRz7YWCOuf9RqhpDv/GZiYYi2Z8nX0kgYwFkjj6Ngcg+eoCrzAUH33iiqwkcii//jIP3wtA7PHOzF+B1Ylg7/Hwd+ZOohPW7i0xTdFYkYq5wnIp3YHcFhJB2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618865; c=relaxed/simple;
	bh=vB2FJuuizfd2rYmcEvSXy+gBR3s8h/de3oHXjn+Fbig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edir2CSCCqpBFqQUc7676KvXWbKKcOwZVQ9Iup4jZYCS8BlMlqU+B8KXzx0BsP4efdrbA/0gQLE4pdkp9Bzf4TRml7Ke4NwFHdQ2Ild6ZWuH5QZ6SW/rTotlEoB3PMvxN3RZ+0nnxW/ihlp3HeOA6DaLEH2PxGUz/8URrJ4FuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FjlsL7yt; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FjlsL7yt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=PaELr/NMlbY4kPhEblBsFW2glGzQ7c1GBjPxUXDUvpg=;
	t=1725618863; x=1726050863; b=FjlsL7ytmLQHR4ffYurXc3zOAdoxpP07CsUmD+aM2FHFdvw
	58IqMSbAWTWt6XHi2V5DEiV/b0OWRmVIZL9v6H6K9jw5UdFhKW0u6B71iKnK38/edSqMXfgMBDxK2
	x6QL5ctlARaxdUjBj0dULZxwXBxi0PZmgq975Z9PmCrR87929GeXNYnQpvKHjDvdhBETl0g/LbLmZ
	W+KaIe/vzeRxx8DrODifpsjmoQsyc99p9CsPYGnwaw4QNHYZcawoZlL2N8jcsblDzJJ0T3KfovZQz
	SWqg9xRdKKG9W5ReaZO25V/BXswMEWV9GNvdixwsRm+cjCcPSACRTElN8H37ZQ8g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1smWIF-0007ZO-9C; Fri, 06 Sep 2024 12:34:19 +0200
Message-ID: <acc76c2a-b176-4a19-8b5b-2ced402c3c8e@leemhuis.info>
Date: Fri, 6 Sep 2024 12:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] [BISECTED] btusb: driver fails to initialize
 MT7921AUN on v6.11-rc4
To: Marc Payne <marc.payne@mdpsys.co.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>, Hao Qin <hao.qin@mediatek.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Menzel <pmenzel@molgen.mpg.de>, Chris Lu <chris.lu@mediatek.com>,
 linux-mediatek@lists.infradead.org, regressions@lists.linux.dev,
 Sean Wang <sean.wang@mediatek.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZsTh7Jyug7MbZsLE@mdpsys.co.uk>
 <76922517-7497-48b5-a581-d1290d413604@molgen.mpg.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <76922517-7497-48b5-a581-d1290d413604@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725618863;9902bd4e;
X-HE-SMSGID: 1smWIF-0007ZO-9C

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Marc, does the problem still occur with recent mainline? It looks like
nobody ever took care of this report, but I might be missing something
-- or maybe some later change fixed this intentionally or due to
side-effects.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

On 21.08.24 07:27, Paul Menzel wrote:
> [Cc: +Marcel, +Luiz]
> 
> Thank you for your report and bisecting the issue. I just add the
> maintainers, and tell regzbot about it.
> 
> Am 20.08.24 um 20:35 schrieb Marc Payne:
>> Hello,
>>
>> I'm testing v6.11-rc4 and the btusb driver fails to properly
>> initialize my
>> MT7921AUN-based Alfa Networks AWUS036AXML:
>>
>> [   63.896319] usb 4-3.1.2: new SuperSpeed USB device number 4 using
>> xhci_hcd
>> [   63.915436] usb 4-3.1.2: New USB device found, idVendor=0e8d,
>> idProduct=7961, bcdDevice= 1.00
>> [   63.915450] usb 4-3.1.2: New USB device strings: Mfr=6, Product=7,
>> SerialNumber=8
>> [   63.915455] usb 4-3.1.2: Product: Wireless_Device
>> [   63.915459] usb 4-3.1.2: Manufacturer: MediaTek Inc.
>> [   63.915461] usb 4-3.1.2: SerialNumber: 000000000
>> [   69.146856] Bluetooth: hci1: Failed to write uhw reg(-110)
>> [   69.149213] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time:
>> 20240716151445
>> [   78.530621] usb 4-3.1.2: Failed to suspend device, error -110
>> [   88.553074] Bluetooth: hci1: Execution of wmt command timed out
>> [   88.553097] Bluetooth: hci1: Failed to send wmt patch dwnld (-110)
>> [   88.553186] Bluetooth: hci1: Failed to set up firmware (-110)
>> [   88.553193] Bluetooth: hci1: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
>> [   90.899462] usb 4-3.1.2: Failed to suspend device, error -110
>>
>> I have bisected the issue down to the following commit:
>>
>>      ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller
>> before downloading the fw")
>>
>> The commit does not revert cleanly due to refactoring in subsequent
>> commits but
>> removing the relevant ten lines of code allows the driver to
>> initialize the
>> device correctly, albeit with some failures and 'Mediatek coredump'
>> errors
>> followed by an additional reset. Interestingly, after the reset the
>> device is
>> now showing as hci2 rather than hci1, suggesting an HCI device
>> registration
>> issue... Bluetooth devices are able to pair and connect as expected:
>>
>> [   77.765047] usb 4-3.1.2: new SuperSpeed USB device number 4 using
>> xhci_hcd
>> [   77.785044] usb 4-3.1.2: New USB device found, idVendor=0e8d,
>> idProduct=7961, bcdDevice= 1.00
>> [   77.785063] usb 4-3.1.2: New USB device strings: Mfr=6, Product=7,
>> SerialNumber=8
>> [   77.785069] usb 4-3.1.2: Product: Wireless_Device
>> [   77.785073] usb 4-3.1.2: Manufacturer: MediaTek Inc.
>> [   77.785077] usb 4-3.1.2: SerialNumber: 000000000
>> [   77.807685] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time:
>> 20240716151445
>> [   80.570163] Bluetooth: hci1: Device setup in 2710186 usecs
>> [   80.570173] Bluetooth: hci1: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
>> [   81.871516] Bluetooth: hci1: Mediatek coredump end
>> [   82.734805] Bluetooth: hci1: Opcode 0x0c03 failed: -110
>> [   82.754807] Bluetooth: hci1: Mediatek coredump end
>> [   84.868215] Bluetooth: hci1: Failed to read MSFT supported features
>> (-110)
>> [   87.001566] Bluetooth: hci1: AOSP get vendor capabilities (-110)
>> [   92.292375] usb 4-3.1.2: reset SuperSpeed USB device number 4 using
>> xhci_hcd
>> [   92.385619] usb 4-3.1.2: reset SuperSpeed USB device number 4 using
>> xhci_hcd
>> [   92.406786] Bluetooth: hci2: HW/SW Version: 0x008a008a, Build Time:
>> 20240716151445
>> [   94.920337] Bluetooth: hci2: Device setup in 2455839 usecs
>> [   94.920343] Bluetooth: hci2: HCI Enhanced Setup Synchronous
>> Connection command is advertised, but not supported.
>> [   94.994480] Bluetooth: hci2: AOSP extensions version v1.00
>> [   94.994494] Bluetooth: hci2: AOSP quality report is supported
>> [   94.995001] Bluetooth: MGMT ver 1.23
>>
>> However, when disconnecting the AWUS036AXML device I get an Oops in
>> the hci_unregister_dev function, again indicating an issue with HCI
>> registration
>> which was not present in the 6.10 kernel versions:
>>
>> [ 1210.222351] usb 4-3.1.2: USB disconnect, device number 4
>> [ 1210.271146] Oops: general protection fault, probably for non-
>> canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
>> [ 1210.271166] CPU: 2 UID: 0 PID: 2275 Comm: kworker/2:1 Not tainted
>> 6.11.0-rc4-dirty #67 a319890a1bc323fc297a70bfc980897913c059f7
>> [ 1210.271178] Hardware name: Intel(R) Client Systems NUC12WSHi7/
>> NUC12WSBi7, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
>> [ 1210.271183] Workqueue: usb_hub_wq hub_event
>> [ 1210.271200] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
>> [ 1210.271292] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48
>> 89 ef e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08
>> 48 8b 13 <48> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48
>> 89 42
>> [ 1210.271297] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
>> [ 1210.271305] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX:
>> 0000000000000000
>> [ 1210.271310] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI:
>> ffffffffc1447068
>> [ 1210.271314] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09:
>> 00000000802a0026
>> [ 1210.271318] R10: 00000000802a0026 R11: 0000000000000001 R12:
>> ffff97bc8f92e000
>> [ 1210.271323] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15:
>> ffff97bcf25acc50
>> [ 1210.271327] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000)
>> knlGS:0000000000000000
>> [ 1210.271332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1210.271337] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4:
>> 0000000000f50ef0
>> [ 1210.271342] PKRU: 55555554
>> [ 1210.271346] Call Trace:
>> [ 1210.271352]  <TASK>
>> [ 1210.271359]  ? __die_body.cold+0x19/0x27
>> [ 1210.271371]  ? die_addr+0x3c/0x60
>> [ 1210.271378]  ? exc_general_protection+0x17d/0x400
>> [ 1210.271391]  ? asm_exc_general_protection+0x26/0x30
>> [ 1210.271403]  ? hci_unregister_dev+0x45/0x1f0 [bluetooth
>> ffdb4fb65cead032fbb8f4718e5d0aa7b94d492f]
>> [ 1210.271479]  ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
>> ffdb4fb65cead032fbb8f4718e5d0aa7b94d492f]
>> [ 1210.271551]  btusb_disconnect+0x67/0x170 [btusb
>> ce322bda915639979ec31f72a2b85eb752188d36]
>> [ 1210.271563]  usb_unbind_interface+0x90/0x290
>> [ 1210.271576]  device_release_driver_internal+0x19c/0x200
>> [ 1210.271589]  bus_remove_device+0xc6/0x130
>> [ 1210.271599]  device_del+0x161/0x3e0
>> [ 1210.271608]  ? kobject_put+0xa0/0x1d0
>> [ 1210.271617]  usb_disable_device+0x104/0x220
>> [ 1210.271627]  usb_disconnect+0xe6/0x2e0
>> [ 1210.271637]  hub_event+0x7f9/0x19d0
>> [ 1210.271648]  ? __schedule+0x3dd/0x1520
>> [ 1210.271656]  process_one_work+0x17b/0x330
>> [ 1210.271667]  worker_thread+0x2d2/0x400
>> [ 1210.271676]  ? __pfx_worker_thread+0x10/0x10
>> [ 1210.271684]  kthread+0xcf/0x100
>> [ 1210.271695]  ? __pfx_kthread+0x10/0x10
>> [ 1210.271705]  ret_from_fork+0x31/0x50
>> [ 1210.271711]  ? __pfx_kthread+0x10/0x10
>> [ 1210.271720]  ret_from_fork_asm+0x1a/0x30
>> [ 1210.271732]  </TASK>
>> [ 1210.271735] Modules linked in: mt792x_usb mt7921_common mt792x_lib
>> mt76_connac_lib mt76_usb mt76 ccm option usb_wwan rndis_host uhid cmac
>> algif_hash algif_skcipher af_alg bnep vfat fat cdc_ether usbnet
>> intel_rapl_msr intel_rapl_common intel_uncore_frequency
>> intel_uncore_frequency_common snd_sof_pci_intel_tgl
>> snd_sof_pci_intel_cnl iwlmvm snd_sof_intel_hda_generic soundwire_intel
>> soundwire_cadence snd_sof_intel_hda_common x86_pkg_temp_thermal
>> intel_powerclamp snd_sof_intel_hda_mlink snd_sof_intel_hda coretemp
>> snd_sof_pci snd_sof_xtensa_dsp kvm_intel snd_sof r8152 mii
>> snd_sof_utils mac80211 libphy snd_soc_hdac_hda kvm
>> snd_soc_acpi_intel_match soundwire_generic_allocation snd_soc_acpi
>> soundwire_bus snd_soc_avs snd_hda_codec_hdmi snd_soc_hda_codec
>> snd_hda_ext_core snd_hda_codec_realtek snd_soc_core
>> snd_hda_codec_generic snd_hda_scodec_component crct10dif_pclmul
>> crc32_pclmul polyval_clmulni snd_compress polyval_generic ac97_bus
>> libarc4 ghash_clmulni_intel snd_pcm_dmaengine sha512_ssse3
>> sha256_ssse3 snd_hda_intel sha1_ssse3
>> [ 1210.271851]  aesni_intel btusb snd_intel_dspcfg snd_intel_sdw_acpi
>> gf128mul iwlwifi snd_hda_codec btrtl crypto_simd cryptd btintel
>> tps6598x btbcm typec snd_hda_core btmtk rapl cfg80211 roles mei_pxp
>> mei_hdcp snd_hwdep intel_cstate ee1004 bluetooth igc snd_pcm spi_nor
>> intel_uncore ov13858 mei_me snd_timer thunderbolt v4l2_fwnode snd ptp
>> mei i2c_i801 v4l2_async wdat_wdt mtd pcspkr intel_lpss_pci wmi_bmof
>> pps_core i2c_smbus intel_lpss videodev soundcore i2c_mux rfkill idma64
>> intel_pmc_core mousedev igen6_edac joydev serial_multi_instantiate
>> intel_vsec mc pmt_telemetry acpi_pad acpi_tad pinctrl_tigerlake
>> pmt_class mac_hid i2c_dev dm_mod sg crypto_user loop nfnetlink
>> ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 xe
>> drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec i915
>> hid_generic usbhid i2c_algo_bit drm_buddy ttm intel_gtt nvme
>> drm_display_helper nvme_core video spi_intel_pci cec xhci_pci
>> crc32c_intel nvme_auth spi_intel xhci_pci_renesas wmi
>> [ 1210.271992] ---[ end trace 0000000000000000 ]---
>> [ 1210.271996] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
>> [ 1210.272061] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48
>> 89 ef e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08
>> 48 8b 13 <48> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48
>> 89 42
>> [ 1210.272066] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
>> [ 1210.272071] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX:
>> 0000000000000000
>> [ 1210.272075] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI:
>> ffffffffc1447068
>> [ 1210.272078] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09:
>> 00000000802a0026
>> [ 1210.272082] R10: 00000000802a0026 R11: 0000000000000001 R12:
>> ffff97bc8f92e000
>> [ 1210.272085] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15:
>> ffff97bcf25acc50
>> [ 1210.272088] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000)
>> knlGS:0000000000000000
>> [ 1210.272092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1210.272096] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4:
>> 0000000000f50ef0
>> [ 1210.272099] PKRU: 55555554
>> [ 1210.272102] note: kworker/2:1[2275] exited with preempt_count 1
>>
>>
>> The kworker exiting obviously means that the kernel no longer responds
>> to events
>> on any of the USB ports...
>>
>> I hope you can track down the issue, let me know if you need any
>> additional
>> details.
>>
>> Regards,
>>
>> Marc

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

