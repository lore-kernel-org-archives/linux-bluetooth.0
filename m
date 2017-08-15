Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225
 _request_firmware+0x329/0x890
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2237498.dXpkGoRScD@blindfold>
Date: Tue, 15 Aug 2017 12:22:27 +0200
Cc: kernel list <linux-kernel@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
References: <2237498.dXpkGoRScD@blindfold>
To: Richard Weinberger <richard@sigma-star.at>,
        Greg Kroah-Hartman <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Richard,

> My new Thinkpad T470p regularly triggers this warning.
> Seems to happy only after resuming from suspend.
> 
> [147242.220708] PM: Finishing wakeup.
> [147242.220711] OOM killer enabled.
> [147242.220711] Restarting tasks ... 
> [147242.221908] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 2015
> [147242.222888] [drm] RC6 on
> [147242.227695] Bluetooth: hci0: Device revision is 16
> [147242.227696] Bluetooth: hci0: Secure boot is enabled
> [147242.227697] Bluetooth: hci0: OTP lock is enabled
> [147242.227697] Bluetooth: hci0: API lock is enabled
> [147242.227698] Bluetooth: hci0: Debug lock is disabled
> [147242.227698] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [147242.227701] firmware request while host is not available

seems like the hardware looses power and has to do a full reload of the firmware. Why the firmware is not cached or why the Bluetooth controller looses its power is unclear to me.

> [147242.227708] ------------[ cut here ]------------
> [147242.227713] WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225 _request_firmware+0x329/0x890
> [147242.227713] Modules linked in: rndis_wlan rndis_host cdc_ether cdc_phonet usbnet phonet mii cdc_acm nls_utf8 udf crc_itu_t msr fuse tun ppp_deflate bsd_comp ppp_async ppp_generic slhc sr_mod cdrom uas usb_storage option usb_wwan usbserial ctr ccm rfcomm nf_log_ipv6 xt_comment nf_log_ipv4 nf_log_common xt_LOG xt_limit af_packet binfmt_misc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 xt_pkttype xt_tcpudp iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack libcrc32c ip6table_filter ip6_tables x_tables bnep snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic arc4 btusb hci_uart btrtl btbcm btqca btintel bluetooth snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep
> [147242.227739]  snd_pcm iwlmvm mac80211 snd_timer intel_rapl x86_pkg_temp_thermal iwlwifi intel_powerclamp cfg80211 coretemp e1000e mei_me ptp kvm_intel iTCO_wdt rtsx_pci_ms thinkpad_acpi iTCO_vendor_support memstick kvm snd irqbypass drbg pcspkr joydev wmi_bmof i2c_i801 pps_core mei shpchp intel_pch_thermal soundcore battery ac ansi_cprng ecdh_generic rfkill crc16 pinctrl_sunrisepoint pinctrl_intel thermal intel_lpss_acpi intel_lpss tpm_crb acpi_pad btrfs xor raid6_pq dm_crypt crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc rtsx_pci_sdmmc mmc_core aesni_intel aes_x86_64 crypto_simd glue_helper cryptd serio_raw nvme nvme_core i915 xhci_pci rtsx_pci mfd_core i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops xhci_hcd drm usbcore wmi video i2c_hid button dm_mirror
> [147242.227767]  dm_region_hash dm_log dm_mod sg scsi_mod efivarfs autofs4
> [147242.227771] CPU: 3 PID: 2952 Comm: kworker/u9:0 Tainted: G        W       4.13.0-rc4-rw+ #5
> [147242.227772] Hardware name: LENOVO 20J6CTO1WW/20J6CTO1WW, BIOS R0FET34W (1.14 ) 06/30/2017
> [147242.227783] Workqueue: hci0 hci_power_on [bluetooth]
> [147242.227784] task: ffff88011e47cb00 task.stack: ffffc90008294000
> [147242.227786] RIP: 0010:_request_firmware+0x329/0x890
> [147242.227786] RSP: 0018:ffffc90008297c88 EFLAGS: 00010286
> [147242.227787] RAX: 000000000000002c RBX: ffffc90008297d58 RCX: 0000000000000006
> [147242.227788] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff88041f58e010
> [147242.227788] RBP: ffffc90008297ce8 R08: 0000000000000000 R09: 0000000000000ba3
> [147242.227789] R10: 0000000000000004 R11: 0000000000000ba2 R12: ffff8803a731dd40
> [147242.227789] R13: ffffc90008297d40 R14: 0000000000000000 R15: ffffffff81ae61b0
> [147242.227790] FS:  0000000000000000(0000) GS:ffff88041f580000(0000) knlGS:0000000000000000
> [147242.227791] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [147242.227791] CR2: 00007f8f905bb2d8 CR3: 000000032225d000 CR4: 00000000003406e0
> [147242.227792] Call Trace:
> [147242.227795]  request_firmware+0x37/0x50
> [147242.227798]  btusb_setup_intel_new+0x257/0x7c0 [btusb]
> [147242.227806]  ? usb_autopm_put_interface+0x30/0x40 [usbcore]
> [147242.227812]  hci_dev_do_open+0x3ff/0x530 [bluetooth]
> [147242.227814]  ? __switch_to+0x21a/0x440
> [147242.227819]  hci_power_on+0x43/0x220 [bluetooth]
> [147242.227821]  ? __schedule+0x29a/0x8c0
> [147242.227823]  process_one_work+0x13f/0x3a0
> [147242.227824]  worker_thread+0x4d/0x3d0
> [147242.227825]  kthread+0x114/0x150
> [147242.227826]  ? rescuer_thread+0x350/0x350
> [147242.227828]  ? kthread_park+0x60/0x60
> [147242.227829]  ? do_syscall_64+0x6e/0x160
> [147242.227831]  ret_from_fork+0x25/0x30
> [147242.227831] Code: ff 8b 55 c4 48 8b 75 c8 4c 89 e7 e8 12 fb ff ff 41 89 c1 e9 11 ff ff ff e8 25 9c 1c 00 48 c7 c7 18 4e aa 81 31 c0 e8 9a a3 bc ff <0f> ff 41 b9 90 ff ff ff e9 0e fd ff ff 4c 89 f7 e8 72 e8 1b 00 
> [147242.227848] ---[ end trace 2d0d21cf844f8a8d ]---
> 
> Is this known?

It is not known, but it is also unclear why this happens. Basically the card looses power and thus ends up in bootloader mode.

Regards

Marcel
