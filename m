Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C86C4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D2E206F8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJCI20 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgJCI20 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 04:28:26 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Sat, 03 Oct 2020 08:28:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: de99like@mennucci.debian.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-b1o6voXS7l@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

A. M. (de99like@mennucci.debian.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |de99like@mennucci.debian.ne
                   |                            |t

--- Comment #6 from A. M. (de99like@mennucci.debian.net) ---
hi

I have the same problem with a different chipset 8087:0029 

I also got a kernel backtrace

kernel: kobject_add_internal failed for hci0:256 with -EEXIST, don't try to
register things with the same name in the same directory.
kernel: Bluetooth: hci0: failed to register connection device
kernel: Bluetooth: hci0: link tx timeout
kernel: Bluetooth: hci0: killing stalled connection 75:ab:d6:65:ea:56
kernel: BUG: unable to handle kernel NULL pointer dereference at
0000000000000020
kernel: IP: klist_next+0x1c/0x100
kernel: PGD 0 P4D 0 
kernel: Oops: 0000 [#1] SMP NOPTI
kernel: Modules linked in: rfcomm pci_stub vboxpci(OE) vboxnetadp(OE)
vboxnetflt(OE) vboxdrv(OE) ccm cmac bnep binfmt_misc dm_crypt algif_skcipher
af_alg cdc_ether usbnet r8152 mii uvcvideo videobuf2_vmalloc videobuf2_memops
btusb videobuf2_v4l2 btrtl btbcm videobuf2_core btintel videodev bluetooth
media ecdh_generic snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic hid_multitouch arc4 dell_laptop intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_iso8859_1
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_hda_intel
aesni_intel snd_hda_codec aes_x86_64 snd_hda_core crypto_simd glue_helper
snd_hwdep cryptd intel_cstate snd_pcm intel_rapl_perf iwlmvm(OE) snd_seq_midi
snd_seq_midi_event dell_wmi mac80211(OE) joydev input_leds dell_smbios
snd_rawmidi
kernel:  serio_raw dcdbas snd_seq iwlwifi(OE) snd_seq_device snd_timer
dell_wmi_descriptor wmi_bmof snd idma64 intel_wmi_thunderbolt virt_dma
cfg80211(OE) soundcore rtsx_pci_ms compat(OE) memstick ucsi_acpi intel_lpss_pci
intel_lpss typec_ucsi processor_thermal_device intel_soc_dts_iosf typec
int3403_thermal int340x_thermal_zone intel_hid mac_hid int3400_thermal
sparse_keymap acpi_thermal_rel acpi_pad sch_fq_codel parport_pc ppdev lp
parport ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
libcrc32c raid1 raid0 multipath linear hid_generic usbhid i915 i2c_algo_bit
drm_kms_helper rtsx_pci_sdmmc syscopyarea psmouse thunderbolt sysfillrect
sysimgblt fb_sys_fops rtsx_pci drm wmi i2c_hid hid video
kernel: CPU: 3 PID: 17609 Comm: kworker/u17:3 Tainted: G        W  OE   
4.15.0-1097-oem #107-Ubuntu
kernel: Hardware name: Dell Inc. XPS 13 7390/0G2D0W, BIOS 1.6.0 07/07/2020
kernel: Workqueue: hci0 hci_rx_work [bluetooth]
kernel: RIP: 0010:klist_next+0x1c/0x100
kernel: RSP: 0018:ffffbf86c742fc80 EFLAGS: 00010282
kernel: RAX: 0000000000000000 RBX: ffff996fce487000 RCX: 0000000000000000
kernel: RDX: ffffffffc0f4b230 RSI: ffffbf86c742fcc0 RDI: 0000000000000000
kernel: RBP: ffffbf86c742fcb0 R08: 0000377d840d5913 R09: ffff996ffbf49818
kernel: R10: 0000000000000000 R11: 00007fe43cbf3014 R12: ffffbf86c742fcc0
kernel: R13: 0000000000000000 R14: ffff996ff532c000 R15: ffff996fce487000
kernel: FS:  0000000000000000(0000) GS:ffff99700e4c0000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000020 CR3: 00000001a320a002 CR4: 00000000003606e0
kernel: Call Trace:
kernel:  ? bt_link_release+0x20/0x20 [bluetooth]
kernel:  device_find_child+0x5c/0xb0
kernel:  ? bt_link_release+0x20/0x20 [bluetooth]
kernel:  hci_conn_del_sysfs+0x54/0xa0 [bluetooth]
kernel:  hci_conn_cleanup+0x92/0x140 [bluetooth]
kernel:  hci_conn_del+0xf1/0x1f0 [bluetooth]
kernel:  hci_event_packet+0x1155/0x2d60 [bluetooth]
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  hci_rx_work+0x199/0x390 [bluetooth]
kernel:  ? hci_rx_work+0x199/0x390 [bluetooth]
kernel:  process_one_work+0x1de/0x420
kernel:  worker_thread+0x32/0x410
kernel:  kthread+0x121/0x140
kernel:  ? process_one_work+0x420/0x420
kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
kernel:  ret_from_fork+0x1f/0x40
kernel: Code: 41 5c 41 5d 5d c3 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41
56 41 55 41 54 49 89 fc 53 48 83 ec 08 48 8b 3f 4d 8b 6c 24 08 <4c> 8b 77 20 e8
db 24 02 00 4d 85 ed 0f 84 84 00 00 00 49 8b 4d 
kernel: RIP: klist_next+0x1c/0x100 RSP: ffffbf86c742fc80
kernel: CR2: 0000000000000020
kernel: ---[ end trace e0cb46d230eda351 ]---

-- 
You are receiving this mail because:
You are the assignee for the bug.
