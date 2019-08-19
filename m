Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A98BC3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 23:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B822CF5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 23:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSXOu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfHSXOu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 19:14:50 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204633] New: Connecting BT headphones causes spinlock to lock
 up
Date:   Mon, 19 Aug 2019 23:14:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: olivier.crete@ocrete.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204633-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204633

            Bug ID: 204633
           Summary: Connecting BT headphones causes spinlock to lock up
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.2.8-200.fc30.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: olivier.crete@ocrete.ca
        Regression: No

Hardware is a ThinkPad x230, BT host is BCM20702A1 and this is 100%
reproducible when brcm/BCM20702A1-0a5c-21e6.hcd is present, but otherwise is
pretty random.

It didn't happen before I upgraded for Fedora 30 (from 29, so it broken around
kernel 5.0 to 5.1 I think).

All I have to do is to connect my bluetooth headset and I get the following
error, which looks like the same device is being registered more than once:

Aug 19 15:33:56 TesterTop4 kernel: list_add double add: new=ffff9309fb743a70,
prev=ffff9309fb743a70, next=ffff930d8bedf240.
Aug 19 15:33:56 TesterTop4 kernel: ------------[ cut here ]------------
Aug 19 15:33:56 TesterTop4 kernel: kernel BUG at lib/list_debug.c:29!
Aug 19 15:33:56 TesterTop4 kernel: invalid opcode: 0000 [#1] SMP PTI
Aug 19 15:33:56 TesterTop4 kernel: CPU: 0 PID: 7972 Comm: kworker/u17:0
Tainted: G           OE     5.2.5-200.fc30.x86_64 #1
Aug 19 15:33:56 TesterTop4 kernel: Hardware name: LENOVO 232577G/232577G, BIOS
G2ETB5WW (2.75 ) 04/09/2019
Aug 19 15:33:56 TesterTop4 kernel: Workqueue: hci0 hci_rx_work [bluetooth]
Aug 19 15:33:56 TesterTop4 kernel: RIP: 0010:__list_add_valid.cold+0x26/0x3f
Aug 19 15:33:56 TesterTop4 kernel: Code: 00 00 00 c3 4c 89 c1 48 c7 c7 18 90 13
9c e8 83 39 c6 ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 c8 90 13 9c e8 6c
39 c6 ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 70 90 13 9c e8 55 39 c6
Aug 19 15:33:56 TesterTop4 kernel: RSP: 0018:ffffa7c90bef7c80 EFLAGS: 00010246
Aug 19 15:33:56 TesterTop4 kernel: RAX: 0000000000000058 RBX: ffff930a1cf2ec28
RCX: 0000000000000000
Aug 19 15:33:56 TesterTop4 kernel: RDX: 0000000000000000 RSI: ffff930d8e017908
RDI: ffff930d8e017908
Aug 19 15:33:56 TesterTop4 kernel: RBP: ffff9309fb743a68 R08: ffff930d8e017908
R09: 0000000000000c3d
Aug 19 15:33:56 TesterTop4 kernel: R10: ffffffff9cc0f49c R11: 0000000000000003
R12: ffff930d8bedf240
Aug 19 15:33:56 TesterTop4 kernel: R13: ffff9309fb743a70 R14: ffff9309fb743a70
R15: ffff930a1cf2e010
Aug 19 15:33:56 TesterTop4 kernel: FS:  0000000000000000(0000)
GS:ffff930d8e000000(0000) knlGS:0000000000000000
Aug 19 15:33:56 TesterTop4 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 19 15:33:56 TesterTop4 kernel: CR2: 00007f9a1bb34000 CR3: 000000028140a001
CR4: 00000000001606f0
Aug 19 15:33:56 TesterTop4 kernel: Call Trace:
Aug 19 15:33:56 TesterTop4 kernel:  kobject_add_internal+0x7e/0x2b0
Aug 19 15:33:56 TesterTop4 kernel:  kobject_add+0x7e/0xb0
Aug 19 15:33:56 TesterTop4 kernel:  ? kobject_set_name_vargs+0x6f/0x90
Aug 19 15:33:56 TesterTop4 kernel:  device_add+0x121/0x670
Aug 19 15:33:56 TesterTop4 kernel:  hci_conn_add_sysfs+0x43/0xb0 [bluetooth]
Aug 19 15:33:56 TesterTop4 kernel:  hci_event_packet+0x1138/0x2870 [bluetooth]
Aug 19 15:33:56 TesterTop4 kernel:  ? __switch_to_asm+0x40/0x70
Aug 19 15:33:56 TesterTop4 kernel:  ? __switch_to_asm+0x34/0x70
Aug 19 15:33:56 TesterTop4 kernel:  ? __switch_to_asm+0x34/0x70
Aug 19 15:33:56 TesterTop4 kernel:  ? __switch_to_asm+0x40/0x70
Aug 19 15:33:56 TesterTop4 kernel:  hci_rx_work+0x180/0x340 [bluetooth]
Aug 19 15:33:56 TesterTop4 kernel:  ? __schedule+0x2a7/0x680
Aug 19 15:33:56 TesterTop4 kernel:  process_one_work+0x19d/0x380
Aug 19 15:33:56 TesterTop4 kernel:  worker_thread+0x50/0x3b0
Aug 19 15:33:56 TesterTop4 kernel:  kthread+0xfb/0x130
Aug 19 15:33:56 TesterTop4 kernel:  ? process_one_work+0x380/0x380
Aug 19 15:33:56 TesterTop4 kernel:  ? kthread_park+0x80/0x80
Aug 19 15:33:56 TesterTop4 kernel:  ret_from_fork+0x35/0x40
Aug 19 15:33:56 TesterTop4 kernel: Modules linked in: uinput cmac rfcomm
hid_logitech_hidpp hid_logitech_dj nfnetlink_queue nfnetlink_log bnep ccm
xt_CHECKSUM xt_MASQUERADE tun bridge stp llc nf_conntrack_netbios_ns
nf_conntrack_broadcas>
Aug 19 15:33:56 TesterTop4 kernel:  snd_hda_codec_realtek iwlwifi
snd_hda_codec_generic snd_hda_intel joydev cfg80211 snd_hda_codec wmi_bmof
snd_hda_core i2c_i801 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer
lpc_ich mei_me mei thin>
Aug 19 15:33:56 TesterTop4 kernel: ---[ end trace cd24dbf33eac4e06 ]---
Aug 19 15:33:56 TesterTop4 kernel: RIP: 0010:__list_add_valid.cold+0x26/0x3f
Aug 19 15:33:56 TesterTop4 kernel: Code: 00 00 00 c3 4c 89 c1 48 c7 c7 18 90 13
9c e8 83 39 c6 ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 c8 90 13 9c e8 6c
39 c6 ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 70 90 13 9c e8 55 39 c6
Aug 19 15:33:56 TesterTop4 kernel: RSP: 0018:ffffa7c90bef7c80 EFLAGS: 00010246
Aug 19 15:33:56 TesterTop4 kernel: RAX: 0000000000000058 RBX: ffff930a1cf2ec28
RCX: 0000000000000000
Aug 19 15:33:56 TesterTop4 kernel: RDX: 0000000000000000 RSI: ffff930d8e017908
RDI: ffff930d8e017908
Aug 19 15:33:56 TesterTop4 kernel: RBP: ffff9309fb743a68 R08: ffff930d8e017908
R09: 0000000000000c3d
Aug 19 15:33:56 TesterTop4 kernel: R10: ffffffff9cc0f49c R11: 0000000000000003
R12: ffff930d8bedf240
Aug 19 15:33:56 TesterTop4 kernel: R13: ffff9309fb743a70 R14: ffff9309fb743a70
R15: ffff930a1cf2e010
Aug 19 15:33:56 TesterTop4 kernel: FS:  0000000000000000(0000)
GS:ffff930d8e000000(0000) knlGS:0000000000000000
Aug 19 15:33:56 TesterTop4 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 19 15:33:56 TesterTop4 kernel: CR2: 00007f9a1bb34000 CR3: 000000028140a001
CR4: 00000000001606f0


After this, I get random lockups that look like this:

Aug 19 15:57:41 TesterTop4 kernel: watchdog: BUG: soft lockup - CPU#3 stuck for
23s! [kworker/3:0:17896]
Aug 19 15:57:41 TesterTop4 kernel: Modules linked in: uinput cmac rfcomm
hid_logitech_hidpp hid_logitech_dj nfnetlink_queue nfnetlink_log bnep ccm
xt_CHECKSUM xt_MASQUERADE tun bridge stp llc nf_conntrack_netbios_ns
nf_conntrack_broadcas>
Aug 19 15:57:41 TesterTop4 kernel:  snd_hda_codec_realtek iwlwifi
snd_hda_codec_generic snd_hda_intel joydev cfg80211 snd_hda_codec wmi_bmof
snd_hda_core i2c_i801 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer
lpc_ich mei_me mei thin>
Aug 19 15:57:41 TesterTop4 kernel: CPU: 3 PID: 17896 Comm: kworker/3:0 Tainted:
G      D    OE     5.2.5-200.fc30.x86_64 #1
Aug 19 15:57:41 TesterTop4 kernel: Hardware name: LENOVO 232577G/232577G, BIOS
G2ETB5WW (2.75 ) 04/09/2019
Aug 19 15:57:41 TesterTop4 kernel: Workqueue: usb_hub_wq hub_event
Aug 19 15:57:41 TesterTop4 kernel: RIP:
0010:queued_spin_lock_slowpath+0x5b/0x1d0
Aug 19 15:57:41 TesterTop4 kernel: Code: 6d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1
e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74
08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00
Aug 19 15:57:41 TesterTop4 kernel: RSP: 0000:ffffa7c90b85fc50 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
Aug 19 15:57:41 TesterTop4 kernel: RAX: 0000000000080101 RBX: ffff930ade229810
RCX: 00000000801e001b
Aug 19 15:57:41 TesterTop4 kernel: RDX: 0000000000000000 RSI: 0000000000000000
RDI: ffff930d8bedf250
Aug 19 15:57:41 TesterTop4 kernel: RBP: ffff930ade229818 R08: 0000000000000000
R09: 0000000000000001
Aug 19 15:57:41 TesterTop4 kernel: R10: fffff78b8ff08000 R11: fffff78b8ff08060
R12: ffff930ade22bc30
Aug 19 15:57:41 TesterTop4 kernel: R13: ffff930ade2298c0 R14: ffff930ade2298b8
R15: 0000000000000000
Aug 19 15:57:41 TesterTop4 kernel: FS:  0000000000000000(0000)
GS:ffff930d8e0c0000(0000) knlGS:0000000000000000
Aug 19 15:57:41 TesterTop4 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 19 15:57:41 TesterTop4 kernel: CR2: 000055fc89f68d10 CR3: 0000000379da0002
CR4: 00000000001606e0
Aug 19 15:57:41 TesterTop4 kernel: Call Trace:
Aug 19 15:57:41 TesterTop4 kernel:  kobj_kset_leave+0x1b/0x60
Aug 19 15:57:41 TesterTop4 kernel:  kobject_del+0x3c/0x60
Aug 19 15:57:41 TesterTop4 kernel:  device_del+0x271/0x360
Aug 19 15:57:41 TesterTop4 kernel:  device_unregister+0x16/0x60
Aug 19 15:57:41 TesterTop4 kernel:  usb_remove_ep_devs+0x1b/0x30
Aug 19 15:57:41 TesterTop4 kernel:  remove_intf_ep_devs+0x33/0x50
Aug 19 15:57:41 TesterTop4 kernel:  usb_disable_device+0x8a/0x240
Aug 19 15:57:41 TesterTop4 kernel:  usb_disconnect+0xba/0x250
Aug 19 15:57:41 TesterTop4 kernel:  hub_event+0xd5c/0x1520
Aug 19 15:57:41 TesterTop4 kernel:  process_one_work+0x19d/0x380
Aug 19 15:57:41 TesterTop4 kernel:  worker_thread+0x50/0x3b0
Aug 19 15:57:41 TesterTop4 kernel:  kthread+0xfb/0x130
Aug 19 15:57:41 TesterTop4 kernel:  ? process_one_work+0x380/0x380
Aug 19 15:57:41 TesterTop4 kernel:  ? kthread_park+0x80/0x80
Aug 19 15:57:41 TesterTop4 kernel:  ret_from_fork+0x35/0x40

-- 
You are receiving this mail because:
You are the assignee for the bug.
