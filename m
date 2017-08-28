Return-Path: <vbabka@suse.cz>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225
 _request_firmware+0x329/0x890
From: Vlastimil Babka <vbabka@suse.cz>
To: Richard Weinberger <richard@sigma-star.at>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <2237498.dXpkGoRScD@blindfold>
 <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
 <25498655.5hsXaGAV9U@blindfold>
 <0df95753-038b-42bd-c6d5-091d7d5bd741@suse.cz>
 <31bd1615-7b0a-dc94-8795-f9cca2f74d35@suse.cz>
Message-ID: <a94014e1-5afe-bee8-d927-aa16bc769185@suse.cz>
Date: Mon, 28 Aug 2017 14:49:24 +0200
MIME-Version: 1.0
In-Reply-To: <31bd1615-7b0a-dc94-8795-f9cca2f74d35@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/28/2017 02:45 PM, Vlastimil Babka wrote:
> On 08/28/2017 01:50 PM, Vlastimil Babka wrote:
>> On 08/15/2017 01:41 PM, Richard Weinberger wrote:
>>> Marcel,
>>>
>>> Am Dienstag, 15. August 2017, 12:22:27 CEST schrieb Marcel Holtmann:
>>>>> Is this known?
>>>>
>>>> It is not known, but it is also unclear why this happens. Basically the card
>>>> looses power and thus ends up in bootloader mode.
>>>>
>>>
>>> Hm, maybe a BIOS issue?
>>
>> Same here on a T460, also happens on resume from suspend to RAM. Looks
>> like a regression though. First instance I found in the logs is from
>> 4.13-rc2. Looks like previously I've been running 4.11, and managed to
>> skip 4.12 on this laptop. Can check 4.12, though.
> 
> Yep, seems to work on 4.12.8, this after resume:
> 
> [  178.837204] PM: Finishing wakeup.
> [  178.837207] OOM killer enabled.
> [  178.837211] Restarting tasks ... done.
> [  178.844792] thermal thermal_zone3: failed to read out thermal zone (-5)
> [  178.849009] [drm] RC6 on
> [  178.851064] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
> [  178.858072] Bluetooth: hci0: Device revision is 5
> [  178.858076] Bluetooth: hci0: Secure boot is enabled
> [  178.858077] Bluetooth: hci0: OTP lock is enabled
> [  178.858078] Bluetooth: hci0: API lock is enabled
> [  178.858078] Bluetooth: hci0: Debug lock is disabled
> [  178.858079] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [  178.858082] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
> 
> ...
> 
> [  180.402942] Bluetooth: hci0: Waiting for firmware download to complete
> [  180.403039] Bluetooth: hci0: Firmware loaded in 1516730 usecs
> [  180.403048] Bluetooth: hci0: Waiting for device to boot
> [  180.414070] Bluetooth: hci0: Device booted in 10769 usecs
> [  180.414074] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
> [  180.418111] Bluetooth: hci0: Applying Intel DDC parameters completed

And for completeness, 4.13 from my laptop:

[   76.875780] PM: Finishing wakeup.
[   76.875783] OOM killer enabled.
[   76.875789] Restarting tasks ... 
[   76.876808] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[   76.883842] Bluetooth: hci0: Device revision is 5
[   76.883852] Bluetooth: hci0: Secure boot is enabled
[   76.883857] Bluetooth: hci0: OTP lock is enabled
[   76.883861] Bluetooth: hci0: API lock is enabled
[   76.883865] Bluetooth: hci0: Debug lock is disabled
[   76.883870] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   76.883879] firmware request while host is not available
[   76.883911] ------------[ cut here ]------------
[   76.883927] WARNING: CPU: 0 PID: 2760 at ../drivers/base/firmware_class.c:1243 _request_firmware+0x409/0x8e0
[   76.883931] Modules linked in: ccm rfcomm af_packet nf_log_ipv6 xt_comment nf_log_ipv4 nf_log_common xt_LOG xt_limit ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 xt_pkttype xt_tcpudp iptable_filter ip6table_mangle nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack libcrc32c ip6table_filter ip6_tables x_tables bnep msr dm_crypt algif_skcipher af_alg btusb uvcvideo btrtl videobuf2_vmalloc btbcm videobuf2_memops btintel videobuf2_v4l2 videobuf2_core videodev bluetooth ecdh_generic arc4 snd_hda_codec_hdmi snd_hda_codec_realtek intel_rapl snd_hda_codec_generic x86_pkg_temp_thermal intel_powerclamp snd_soc_skl coretemp snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core kvm_intel snd_soc_sst_match snd_soc_core snd_compress kvm snd_pcm_dmaengine
[   76.884034]  irqbypass nls_iso8859_1 crct10dif_pclmul nls_cp437 crc32_pclmul vfat dm_mod fat ghash_clmulni_intel pcbc iwlmvm snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep mac80211 iTCO_wdt snd_pcm iTCO_vendor_support wmi_bmof mei_wdt snd_timer iwlwifi aesni_intel aes_x86_64 crypto_simd thinkpad_acpi glue_helper cryptd rtsx_pci_ms snd cfg80211 e1000e ptp memstick tpm_tis pcspkr joydev i2c_i801 tpm_tis_core pps_core soundcore shpchp tpm rfkill battery thermal ac wmi mei_me mei intel_pch_thermal btrfs xor rtsx_pci_sdmmc mmc_core raid6_pq crc32c_intel i915 xhci_pci xhci_hcd i2c_algo_bit serio_raw drm_kms_helper syscopyarea sysfillrect sysimgblt rtsx_pci fb_sys_fops video button drm usbcore sg efivarfs
[   76.884154] CPU: 0 PID: 2760 Comm: kworker/u9:4 Not tainted 4.13.0-rc6-2.g43edc52-default #1
[   76.884159] Hardware name: LENOVO 20FMS27W03/20FMS27W03, BIOS R06ET42W (1.16 ) 09/20/2016
[   76.884203] Workqueue: hci0 hci_power_on [bluetooth]
[   76.884210] task: ffff916ffa7fc0c0 task.stack: ffff9f260314c000
[   76.884222] RIP: 0010:_request_firmware+0x409/0x8e0
[   76.884227] RSP: 0000:ffff9f260314fcd0 EFLAGS: 00010286
[   76.884234] RAX: 000000000000002c RBX: ffff9f260314fd88 RCX: 0000000000000006
[   76.884239] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff91706140e290
[   76.884244] RBP: ffff9f260314fd70 R08: 0000000000000000 R09: 00000000000003b7
[   76.884249] R10: ffff9f260314fcc0 R11: ffffffff8f4b022d R12: ffff9170469d3800
[   76.884253] R13: ffff917057217900 R14: ffff917057217908 R15: ffff9170475ae3c8
[   76.884259] FS:  0000000000000000(0000) GS:ffff917061400000(0000) knlGS:0000000000000000
[   76.884265] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.884270] CR2: 00005589d52fc000 CR3: 0000000217cbd000 CR4: 00000000003406f0
[   76.884274] Call Trace:
[   76.884289]  ? snprintf+0x36/0x40
[   76.884300]  request_firmware+0x32/0x50
[   76.884313]  btusb_setup_intel_new+0x206/0x750 [btusb]
[   76.884323]  ? __pm_runtime_idle+0x48/0x60
[   76.884363]  hci_dev_do_open+0x3ac/0x540 [bluetooth]
[   76.884375]  ? finish_task_switch+0x75/0x200
[   76.884410]  hci_power_on+0x3e/0x1e0 [bluetooth]
[   76.884419]  ? __schedule+0x286/0x880
[   76.884427]  process_one_work+0x17c/0x3b0
[   76.884436]  worker_thread+0x4a/0x390
[   76.884444]  ? process_one_work+0x3b0/0x3b0
[   76.884453]  kthread+0x118/0x130
[   76.884462]  ? kthread_create_on_node+0x40/0x40
[   76.884471]  ret_from_fork+0x25/0x30
[   76.884479] Code: 08 49 83 fd 28 74 4c 49 8b 8d 60 c9 88 8e e9 36 ff ff ff 48 c7 c7 e0 01 ef 8e e8 93 10 20 00 48 c7 c7 18 fd a9 8e e8 12 61 b7 ff <0f> ff 41 bd 90 ff ff ff 49 8b 7c 24 18 e9 45 fd ff ff 48 c7 44 
[   76.884577] ---[ end trace 513808fe832cf154 ]---
[   76.884586] Bluetooth: hci0: Failed to load Intel firmware file (-112)
[   76.887685] done.
[   76.891479] [drm] RC6 on
[   76.894256] thermal thermal_zone3: failed to read out thermal zone (-5)
