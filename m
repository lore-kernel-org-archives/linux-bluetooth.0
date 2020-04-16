Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15799C3815B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43D52222D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgDPQfa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgDPQf1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Apr 2020 12:35:27 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 207309] New: system freeze after "Bluetooth: hci0: hardware
 error 0x44"
Date:   Thu, 16 Apr 2020 16:35:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hurikhan77+bko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-207309-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207309

            Bug ID: 207309
           Summary: system freeze after "Bluetooth: hci0: hardware error
                    0x44"
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4.32
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: hurikhan77+bko@gmail.com
        Regression: No

While playing a game, my Xbox One S controller suddenly lost connection and
after a few seconds the system froze (with audio playing in a loop):

Apr 16 17:50:05 jupiter kernel: Bluetooth: hci0: hardware error 0x44
Apr 16 17:50:05 jupiter kernel: general protection fault: 0000 [#1] PREEMPT SMP
Apr 16 17:50:05 jupiter kernel: CPU: 0 PID: 261163 Comm: kworker/u17:0 Tainted:
P           O      5.4.32-gentoo #1
Apr 16 17:50:05 jupiter kernel: Hardware name: To Be Filled By O.E.M. To Be
Filled By O.E.M./Z68 Pro3, BIOS L2.16A 02/22/2013
Apr 16 17:50:05 jupiter kernel: Workqueue: hci0 hci_error_reset [bluetooth]
Apr 16 17:50:05 jupiter kernel: RIP: 0010:__wake_up_common+0xac/0x130
Apr 16 17:50:05 jupiter kernel: Code: 08 00 74 26 83 c5 01 83 fd 40 7e 1e 49 8d
44 24 18 48 39 04 24 75 6a 8b 44 24 14 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41
5f c3 <49> 8b 44 24 18 49 8d 4c 24 18 48 8d 50 e8 4c 89 e0 48 39 0c 24 74
Apr 16 17:50:05 jupiter kernel: RSP: 0018:ffffc9000b053c90 EFLAGS: 00010083
Apr 16 17:50:05 jupiter kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffffffffa18b2078
Apr 16 17:50:05 jupiter kernel: RDX: 0000000000000001 RSI: 0000000000000096
RDI: ffffffffa18b2070
Apr 16 17:50:05 jupiter kernel: RBP: 0000000000000002 R08: 0000000000000000
R09: ffffc9000b053c28
Apr 16 17:50:05 jupiter kernel: R10: ffff88843c995000 R11: 0000000000000000
R12: dead0000000000e8
Apr 16 17:50:05 jupiter kernel: R13: 0000000000000001 R14: 0000000000000000
R15: 0000000000000000
Apr 16 17:50:05 jupiter kernel: FS:  0000000000000000(0000)
GS:ffff88880f000000(0000) knlGS:0000000000000000
Apr 16 17:50:05 jupiter kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Apr 16 17:50:05 jupiter kernel: CR2: 00000001aa487000 CR3: 00000007e2401005
CR4: 00000000001606f0
Apr 16 17:50:05 jupiter kernel: Call Trace:
Apr 16 17:50:05 jupiter kernel:  __wake_up_common_lock+0x67/0x90
Apr 16 17:50:05 jupiter kernel:  sock_def_wakeup+0x36/0x40
Apr 16 17:50:05 jupiter kernel:  l2cap_sock_teardown_cb+0x132/0x150 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  l2cap_chan_del+0x33/0x2a0 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  l2cap_conn_del.isra.0+0x10b/0x200 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  hci_conn_hash_flush+0x55/0xb0 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  hci_dev_do_close+0x1bb/0x450 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  hci_error_reset+0x28/0x60 [bluetooth]
Apr 16 17:50:05 jupiter kernel:  process_one_work+0x1a9/0x2e0
Apr 16 17:50:05 jupiter kernel:  worker_thread+0x45/0x3c0
Apr 16 17:50:05 jupiter kernel:  kthread+0xee/0x130
Apr 16 17:50:05 jupiter kernel:  ? current_work+0x30/0x30
Apr 16 17:50:05 jupiter kernel:  ? kthread_park+0x80/0x80
Apr 16 17:50:05 jupiter kernel:  ret_from_fork+0x1f/0x30
Apr 16 17:50:05 jupiter kernel: Modules linked in: hid_xpadneo hidp snd_hrtimer
snd_seq snd_seq_device rfcomm fuse ip6table_mangle ip6_tables xt_DSCP xt_tcpudp
iptable_mangle bpfilter bnep cachefiles btusb btrtl btbcm btintel bluetooth
af_packet snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
input_leds led_class snd_hda_intel snd>
Apr 16 17:50:05 jupiter kernel: ---[ end trace 9e5f04e507fe7ebd ]---
Apr 16 17:50:05 jupiter kernel: RIP: 0010:__wake_up_common+0xac/0x130
Apr 16 17:50:05 jupiter kernel: Code: 08 00 74 26 83 c5 01 83 fd 40 7e 1e 49 8d
44 24 18 48 39 04 24 75 6a 8b 44 24 14 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41
5f c3 <49> 8b 44 24 18 49 8d 4c 24 18 48 8d 50 e8 4c 89 e0 48 39 0c 24 74
Apr 16 17:50:05 jupiter kernel: RSP: 0018:ffffc9000b053c90 EFLAGS: 00010083
Apr 16 17:50:05 jupiter kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: ffffffffa18b2078
Apr 16 17:50:05 jupiter kernel: RDX: 0000000000000001 RSI: 0000000000000096
RDI: ffffffffa18b2070
Apr 16 17:50:05 jupiter kernel: RBP: 0000000000000002 R08: 0000000000000000
R09: ffffc9000b053c28
Apr 16 17:50:05 jupiter kernel: R10: ffff88843c995000 R11: 0000000000000000
R12: dead0000000000e8
Apr 16 17:50:05 jupiter kernel: R13: 0000000000000001 R14: 0000000000000000
R15: 0000000000000000
Apr 16 17:50:05 jupiter kernel: FS:  0000000000000000(0000)
GS:ffff88880f000000(0000) knlGS:0000000000000000
Apr 16 17:50:05 jupiter kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Apr 16 17:50:05 jupiter kernel: CR2: 00000001aa487000 CR3: 00000007e2401005
CR4: 00000000001606f0
Apr 16 17:50:05 jupiter kernel: note: kworker/u17:0[261163] exited with
preempt_count 1

I had to SysRQ+REISUB (tho, only B did actually have an effect).

# lsusb | grep -i bluetooth
Bus 002 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)

# dmesg|grep -i bluetooth
[   12.722976] Bluetooth: Core ver 2.22
[   12.722981] Bluetooth: HCI device and connection manager initialized
[   12.722983] Bluetooth: HCI socket layer initialized
[   12.722984] Bluetooth: L2CAP socket layer initialized
[   12.722985] Bluetooth: SCO socket layer initialized
[   16.113440] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.113442] Bluetooth: BNEP filters: protocol multicast
[   16.113445] Bluetooth: BNEP socket layer initialized
[   23.623322] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   23.623330] Bluetooth: HIDP socket layer initialized
[   23.661883] input: Xbox Wireless Controller as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.7/2-1.2.7.2/2-1.2.7.2:1.0/bluetooth/hci0/hci0:70/0005:045E:02E0.0010/input/input19
[   23.662096] xpadneo 0005:045E:02E0.0010: input,hidraw9: BLUETOOTH HID v9.03
Gamepad [Xbox Wireless Controller] on 00:1a:7d:da:71:08
[   46.035721] Bluetooth: RFCOMM TTY layer initialized
[   46.035726] Bluetooth: RFCOMM socket layer initialized
[   46.035727] Bluetooth: RFCOMM ver 1.11

-- 
You are receiving this mail because:
You are the assignee for the bug.
