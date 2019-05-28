Return-Path: <SRS0=Ljem=T4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBDC04AB6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 07:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4C4208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 07:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfE1Hgx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 May 2019 03:36:53 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:43730 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfE1Hgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 May 2019 03:36:52 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E8BC02818E
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2019 07:36:51 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id DC062283E7; Tue, 28 May 2019 07:36:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203739] New: Bluetooth LTE NULL dereference on
Date:   Tue, 28 May 2019 07:36:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michal.w.witkowski+kernel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-203739-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203739

            Bug ID: 203739
           Summary: Bluetooth LTE NULL dereference on
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.0.0-15
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: michal.w.witkowski+kernel@gmail.com
        Regression: No

I've got a program that maintains long lasting connections to two LTE devices.
At some point the program crashed, got killed and restarted. The crash was
caused by a kernel dereference error from which the module couldn't recover. 


[    9.054702] Bluetooth: hci0: read Intel version: 370810225019140f00
[    9.107011] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
[    9.489986] Bluetooth: hci0: Intel firmware patch completed and activated
[113705.386356] Bluetooth: hci0: link tx timeout
[113705.386365] Bluetooth: hci0: killing stalled connection ee:be:28:d0:42:aa
[113705.614202] NET: Registered protocol family 38
[114312.591688] Bluetooth: hci0: request failed to create LE connection: status
0x0c
[114384.781615] Bluetooth: hci0: request failed to create LE connection: status
0x0c
[114388.069750] BUG: unable to handle kernel NULL pointer dereference at
000000000000001a
[114388.069765] #PF error: [normal kernel read fault]
[114388.069771] PGD 0 P4D 0
[114388.069780] Oops: 0000 [#1] SMP NOPTI
[114388.069788] CPU: 0 PID: 6974 Comm: kworker/u9:0 Not tainted
5.0.0-15-generic #16-Ubuntu
[114388.069796] Hardware name: Intel(R) Client Systems NUC6CAYH/NUC6CAYB, BIOS
AYAPLCEL.86A.0052.2018.0627.1943 06/27/2018
[114388.069847] Workqueue: hci0 hci_rx_work [bluetooth]
[114388.069893] RIP: 0010:hci_connect_le_scan_cleanup+0x14/0x130 [bluetooth]
[114388.069901] Code: c7 46 0c 00 00 00 00 66 89 46 0a c3 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 4c 8d 6f 14 41 54 53 <0f> b6 5f
1a 4c 8b a7 68 05 00 00 80 fb 01 75 14 0f b6 47 19 bb 01
[114388.069914] RSP: 0018:ffffb6ed034d7d50 EFLAGS: 00010246
[114388.069920] RAX: 0000800000070000 RBX: 0000000000000000 RCX:
0000800000050000
[114388.069927] RDX: ffff9d5db616eae8 RSI: 0000000000000000 RDI:
0000000000000000
[114388.069934] RBP: ffffb6ed034d7d70 R08: ffff9d5db6161680 R09:
0000000000000111
[114388.069941] R10: 00000000005bd186 R11: 0000000000000001 R12:
ffff9d5db616e010
[114388.069948] R13: 0000000000000014 R14: 0000000000000000 R15:
000000000000000f
[114388.069956] FS:  0000000000000000(0000) GS:ffff9d5db7a00000(0000)
knlGS:0000000000000000
[114388.069963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[114388.069969] CR2: 000000000000001a CR3: 000000019ca0e000 CR4:
00000000003406f0
[114388.069976] Call Trace:
[114388.070026]  create_le_conn_complete+0xaa/0xe0 [bluetooth]
[114388.070071]  hci_event_packet+0x108/0x29d0 [bluetooth]
[114388.070118]  ? hci_send_to_sock+0x70/0x1d0 [bluetooth]
[114388.070128]  ? skb_release_all+0x24/0x30
[114388.070171]  ? le_conn_timeout+0xc0/0xc0 [bluetooth]
[114388.070212]  hci_rx_work+0x190/0x370 [bluetooth]
[114388.070223]  ? __schedule+0x2d8/0x840
[114388.070232]  process_one_work+0x20f/0x410
[114388.070239]  worker_thread+0x34/0x400
[114388.070247]  kthread+0x120/0x140
[114388.070253]  ? process_one_work+0x410/0x410
[114388.070261]  ? __kthread_parkme+0x70/0x70
[114388.070267]  ret_from_fork+0x35/0x40
[114388.070274] Modules linked in: algif_hash algif_skcipher af_alg
ipt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat
nf_nat_ipv4 xt_addrtype iptable_filter bpfilter xt_conntrack nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc aufs
cmac bnep overlay nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc
scsi_dh_alua snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core snd_soc_skl_ipc
snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match intel_rapl
snd_soc_acpi snd_hda_codec_hdmi snd_soc_core intel_telemetry_pltdrv
snd_compress intel_punit_ipc ac97_bus intel_telemetry_core snd_pcm_dmaengine
intel_pmc_ipc snd_hda_codec_realtek arc4 snd_hda_codec_generic ledtrig_audio
x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_intel iwlmvm
snd_hda_codec kvm_intel mac80211 btusb snd_hda_core btrtl snd_hwdep snd_pcm
crct10dif_pclmul btbcm iwlwifi btintel crc32_pclmul snd_timer mei_me
ghash_clmulni_intel bluetooth snd rtsx_pci_ms intel_cstate memstick
[114388.070339]  8250_dw mei intel_rapl_perf spi_pxa2xx_platform soundcore
idma64 cfg80211 joydev virt_dma ecdh_generic ir_rc6_decoder input_leds
intel_xhci_usb_role_switch roles rc_rc6_mce serio_raw wmi_bmof ite_cir rc_core
mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp
libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_compress
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid uas
usb_storage i915 rtsx_pci_sdmmc kvmgt vfio_mdev mdev vfio_iommu_type1 vfio
aesni_intel kvm aes_x86_64 crypto_simd cryptd irqbypass glue_helper
i2c_algo_bit drm_kms_helper psmouse syscopyarea r8169 sysfillrect sysimgblt
realtek rtsx_pci lpc_ich fb_sys_fops i2c_i801 intel_lpss_pci intel_lpss ahci
drm wmi libahci video pinctrl_broxton pinctrl_intel
[114388.070493] CR2: 000000000000001a
[114388.070500] ---[ end trace c53168aff6647150 ]---
[114388.070544] RIP: 0010:hci_connect_le_scan_cleanup+0x14/0x130 [bluetooth]
[114388.070551] Code: c7 46 0c 00 00 00 00 66 89 46 0a c3 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 4c 8d 6f 14 41 54 53 <0f> b6 5f
1a 4c 8b a7 68 05 00 00 80 fb 01 75 14 0f b6 47 19 bb 01
[114388.070563] RSP: 0018:ffffb6ed034d7d50 EFLAGS: 00010246
[114388.070569] RAX: 0000800000070000 RBX: 0000000000000000 RCX:
0000800000050000
[114388.070576] RDX: ffff9d5db616eae8 RSI: 0000000000000000 RDI:
0000000000000000
[114388.070583] RBP: ffffb6ed034d7d70 R08: ffff9d5db6161680 R09:
0000000000000111
[114388.070590] R10: 00000000005bd186 R11: 0000000000000001 R12:
ffff9d5db616e010
[114388.070597] R13: 0000000000000014 R14: 0000000000000000 R15:
000000000000000f
[114388.070604] FS:  0000000000000000(0000) GS:ffff9d5db7a00000(0000)
knlGS:0000000000000000
[114388.070611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[114388.070617] CR2: 000000000000001a CR3: 000000019ca0e000 CR4:
00000000003406f0

-- 
You are receiving this mail because:
You are the assignee for the bug.
