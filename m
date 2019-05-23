Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF34CC46470
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 02:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6774F2173C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 02:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfEWCue convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 22:50:34 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44380 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727802AbfEWCud (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 22:50:33 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E696326E3A
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2019 02:50:32 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id DAB0F27D29; Thu, 23 May 2019 02:50:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203685] New: failed to load firmware after resume
Date:   Thu, 23 May 2019 02:50:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-203685-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203685

            Bug ID: 203685
           Summary: failed to load firmware after resume
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: rui.zhang@intel.com
        Regression: No

Dmesg shows that Bluetooth fails to load its firmware after resume.
This happens 1726 times out of 2000 S3 cycles we tested.

[  384.026665] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 2015
[  384.026666] acpi LNXPOWER:02: Turning OFF
[  384.028800] PM: Finishing wakeup.
[  384.029041] pcieport 0000:00:1d.0: PCI bridge to [bus 04]
[  384.029675] Bluetooth: hci0: Device revision is 16
[  384.029676] Bluetooth: hci0: Secure boot is enabled
[  384.029676] Bluetooth: hci0: OTP lock is enabled
[  384.029676] Bluetooth: hci0: API lock is enabled
[  384.029677] Bluetooth: hci0: Debug lock is disabled
[  384.029677] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  384.029691] bluetooth hci0: Direct firmware load for intel/ibt-12-16.sfi
failed with error -2
[  384.029692] bluetooth hci0: Falling back to syfs fallback for:
intel/ibt-12-16.sfi
[  384.029702] WARNING: CPU: 0 PID: 76 at
/kbuild/src/x86_64/drivers/base/firmware_loader/fallback.c:613
firmware_fallback_sysfs+0x37c/0x480
[  384.029702] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_conexant
snd_hda_codec_generic ledtrig_audio intel_rapl intel_pmc_core
x86_pkg_temp_thermal sd_mod intel_powerclamp coretemp sg kvm irqbypass
snd_soc_skl snd_soc_skl_ipc crct10dif_pclmul crc32_pclmul snd_soc_sst_ipc
crc32c_intel i915 snd_soc_sst_dsp hid_multitouch ghash_clmulni_intel
snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi hp_wmi snd_soc_core
sparse_keymap wmi_bmof snd_compress snd_hda_intel btusb btrtl btbcm
snd_hda_codec btintel iwlwifi uvcvideo snd_hda_core videobuf2_vmalloc
aesni_intel snd_hwdep crypto_simd snd_pcm videobuf2_memops drm_kms_helper
snd_timer bluetooth videobuf2_v4l2 cryptd syscopyarea mei_me sysfillrect
cfg80211 ahci glue_helper snd pcspkr videobuf2_common sysimgblt fb_sys_fops
libahci ecdh_generic i2c_i801 soundcore processor_thermal_device serio_raw
int3400_thermal i2c_designware_platform libata i2c_designware_core drm videodev
rfkill joydev mei hp_accel int3403_thermal intel_soc_dts_iosf
[  384.029728]  wmi i2c_hid lis3lv02d int340x_thermal_zone pinctrl_sunrisepoint
video pinctrl_intel acpi_thermal_rel input_polldev acpi_pad hp_wireless
pcc_cpufreq ip_tables
[  384.029732] CPU: 0 PID: 76 Comm: kworker/u17:0 Not tainted 5.1.0 #1
[  384.029733] Hardware name: HP HP ZHAN 66 Pro G1/83FD, BIOS Q93 Ver. 01.02.01
09/01/2017
[  384.029745] Workqueue: hci0 hci_power_on [bluetooth]
[  384.029748] RIP: 0010:firmware_fallback_sysfs+0x37c/0x480
[  384.029749] Code: e9 da fc ff ff 48 8b 8d 88 00 00 00 48 c7 c2 3a 9c f2 9f
4c 89 fe 48 c7 c7 78 02 41 a0 e8 0c 54 e9 ff e9 96 fe ff ff 89 04 24 <0f> 0b 48
c7 c6 40 9d f2 9f 48 89 ea 4c 89 ef e8 31 76 fe ff 8b 04
[  384.029750] RSP: 0018:fffface68114bc58 EFLAGS: 00010286
[  384.029750] RAX: 00000000fffffff5 RBX: 0000000000000001 RCX:
0000000000000000
[  384.029751] RDX: ffffffffa0261288 RSI: 0000000000000293 RDI:
0000000000000293
[  384.029751] RBP: fffface68114bd80 R08: ffffffffa0261288 R09:
0000000000022400
[  384.029751] R10: fffface68114bc38 R11: 0000000000000000 R12:
000000000000ea60
[  384.029752] R13: ffff93bd53bf4c28 R14: 0000000000000028 R15:
0000000000000000
[  384.029752] FS:  0000000000000000(0000) GS:ffff93bda8000000(0000)
knlGS:0000000000000000
[  384.029753] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  384.029753] CR2: 00007f130037bf48 CR3: 000000014a60e002 CR4:
00000000003606f0
[  384.029754] Call Trace:
[  384.029757]  _request_firmware+0x4e9/0x660
[  384.029759]  request_firmware+0x32/0x50
[  384.029761]  btusb_setup_intel_new+0x130/0x510 [btusb]
[  384.029763]  ? _cond_resched+0x19/0x30
[  384.029763]  ? rpm_check_suspend_allowed+0x4c/0x90
[  384.029764]  ? __pm_runtime_idle+0x4e/0x90
[  384.029774]  hci_dev_do_open+0xd9/0x6d0 [bluetooth]
[  384.029775]  ? __switch_to_asm+0x34/0x70
[  384.029776]  ? __switch_to+0x8c/0x500
[  384.029777]  ? __switch_to_asm+0x34/0x70
[  384.029779] OOM killer enabled.
[  384.029779] Restarting tasks ... 
[  384.031411] pcieport 0000:00:1d.0:   bridge window [io  0x6000-0x6fff]
[  384.032383] done.
[  384.032878]  ? __switch_to_asm+0x40/0x70
[  384.032898]  hci_power_on+0x4e/0x240 [bluetooth]
[  384.032901]  ? __schedule+0x260/0x850
[  384.035061] pcieport 0000:00:1d.0:   bridge window [mem
0xb3000000-0xb30fffff]
[  384.036678]  process_one_work+0x19c/0x3c0
[  384.036681]  worker_thread+0x3c/0x3b0
[  384.038421] pcieport 0000:00:1d.0:   bridge window [mem
0x1c00000000-0x1c001fffff 64bit pref]
[  384.040206]  ? process_one_work+0x3c0/0x3c0
[  384.040207]  kthread+0x11e/0x140
[  384.040210]  ? kthread_park+0x90/0x90
[  384.105279]  ret_from_fork+0x35/0x40
[  384.105280] ---[ end trace cc0c4f62bacb67e7 ]---
[  384.105507] bluetooth hci0: firmware: intel/ibt-12-16.sfi will not be loaded

-- 
You are receiving this mail because:
You are the assignee for the bug.
