Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F36C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhLVW4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLVW4i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 17:56:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CDC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 14:56:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D2CCB81E96
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 22:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10A02C36AE8
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640213795;
        bh=3LDGATTNpfhAZpL4ltVkpM/MK4JXDUnSOArvs8kYLiM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OKMS9ZhgFrvqd2J+omke6EeOaiFZm7fX853w3lAuCojE2g8EbaUoErSVk1WjTGuMa
         Asi/AOSLhshRE+zJgAX0cu7EuMRPB02lIXKFVkEjUVIdsTCzwyUE49kjFec8ejYkxS
         ZGVT4HyEK+aqeEVXrepxdnU++hUMemOyJLOo6XzO1kqIugcQXmA1w7jDmx9eH21Wyh
         PsR8n9v/Tk6dzeaH5QqYyT4ix30R6UfozT/PktWDjDj5m/umNJ3h/EDI+eIAPtob11
         n7/A/IX6VHuf3ME9jzGfIVCB/QyYQIBm8W6W8mz5fnZ/yUmPinj3OsUxMIMq6JtjeT
         3xJkpDlZKcLZQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id CB15161177; Wed, 22 Dec 2021 22:56:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Wed, 22 Dec 2021 22:56:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-UBe6zE5fu8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #8 from Tedd An (tedd.an@intel.com) ---
It seems like kernel oops in the dmesg and it may causes the issue.

[   46.401807] ------------[ cut here ]------------
[   46.401808] kernel BUG at net/core/skbuff.c:113!
[   46.401819] invalid opcode: 0000 [#1] PREEMPT SMP
[   46.401826] CPU: 7 PID: 142 Comm: kworker/u33:0 Not tainted 5.16.0-rc1+ =
#1
[   46.401831] Hardware name: LENOVO 20U8S0PQ00/20U8S0PQ00, BIOS R19ET36W (=
1.20
) 07/12/2021
[   46.401835] Workqueue: hci0 hci_rx_work [bluetooth]
[   46.401890] RIP: 0010:skb_panic+0x4c/0x4e
[   46.401899] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50 ff =
b7
c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 e8 00 a7 98 e8 46 11 fb ff <0f> 0=
b 48
8b 55 08 48 c7 c1 60 b1 71 98 e8 a2 ff ff ff 48 c7 c6 b0
[   46.401903] RSP: 0018:ffffa22980aa3c60 EFLAGS: 00010246
[   46.401908] RAX: 0000000000000088 RBX: 0000000000000000 RCX:
0000000000000000
[   46.401911] RDX: 0000000000000000 RSI: ffffffff989a0551 RDI:
00000000ffffffff
[   46.401914] RBP: ffffa22980aa3c80 R08: 0000000000000000 R09:
ffffa22980aa3a50
[   46.401917] R10: 0000000000000001 R11: 0000000000000001 R12:
00000000000000a5
[   46.401919] R13: 00000000000000a5 R14: ffff9409c4e7c300 R15:
00000000000000aa
[   46.401923] FS:  0000000000000000(0000) GS:ffff940ccefc0000(0000)
knlGS:0000000000000000
[   46.401927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.401930] CR2: 00007fae7c01b398 CR3: 000000040c20f000 CR4:
0000000000350ee0
[   46.401933] Call Trace:
[   46.401937]  <TASK>
[   46.401942]  skb_put.cold+0x10/0x10
[   46.401947]  mgmt_device_found+0x3c8/0x4c0 [bluetooth]
[   46.402004]  hci_extended_inquiry_result_evt+0x162/0x230 [bluetooth]
[   46.402054]  hci_event_packet+0x2cd/0x4b0 [bluetooth]
[   46.402099]  ? hci_remote_oob_data_request_evt+0x1f0/0x1f0 [bluetooth]
[   46.402144]  hci_rx_work+0x1b2/0x3d0 [bluetooth]
[   46.402190]  ? queue_delayed_work_on+0x3d/0x50
[   46.402198]  process_one_work+0x1ec/0x3c0
[   46.402204]  worker_thread+0x4d/0x3d0
[   46.402210]  kthread+0x17a/0x1a0
[   46.402214]  ? process_one_work+0x3c0/0x3c0
[   46.402218]  ? set_kthread_struct+0x40/0x40
[   46.402223]  ret_from_fork+0x22/0x30
[   46.402232]  </TASK>
[   46.402234] Modules linked in: rfcomm bnep nls_iso8859_1 intel_rapl_msr
intel_rapl_common snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_intel edac_mce_amd snd_intel_dspcfg
snd_intel_sdw_acpi uvcvideo snd_hda_codec videobuf2_vmalloc snd_hda_core
videobuf2_memops btusb snd_hwdep videobuf2_v4l2 btrtl kvm_amd btbcm snd_pcm
input_leds btintel videobuf2_common kvm snd_seq_midi btmtk snd_seq_midi_eve=
nt
bluetooth videodev snd_rawmidi joydev iwlmvm ecdh_generic think_lmi
thinkpad_acpi mc rapl ecc serio_raw firmware_attributes_class efi_pstore
wmi_bmof snd_seq nvram mac80211 platform_profile libarc4 ledtrig_audio
snd_seq_device iwlwifi snd_timer snd_rn_pci_acp3x ucsi_acpi ipmi_devintf snd
typec_ucsi snd_pci_acp3x cfg80211 k10temp ipmi_msghandler soundcore typec
mac_hid sch_fq_codel msr parport_pc ppdev lp parport sunrpc ip_tables x_tab=
les
autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq
[   46.402343]  libcrc32c raid1 raid0 multipath linear dm_mirror dm_region_=
hash
dm_log amdgpu iommu_v2 gpu_sched i2c_algo_bit drm_ttm_helper ttm drm_kms_he=
lper
syscopyarea sysfillrect rtsx_pci_sdmmc sysimgblt fb_sys_fops crc32c_intel
psmouse cec rc_core drm xhci_pci i2c_piix4 xhci_pci_renesas nvme rtsx_pci r=
8169
realtek nvme_core wmi video i2c_scmi
[   46.402425] ---[ end trace e9aa209601e9071e ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
