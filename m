Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA9C1975A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 19:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E56E20735
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 19:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQTOz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQTOz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 15:14:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206515] Bluetooth drivers crashes the system randomly
Date:   Tue, 17 Mar 2020 19:14:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: warxcell@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206515-62941-TFlwC3W6wa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206515-62941@https.bugzilla.kernel.org/>
References: <bug-206515-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206515

--- Comment #2 from Bozhidar Hristov (warxcell@gmail.com) ---
Another log from today:

мар 17 18:45:41 bhasus kernel: general protection fault: 0000 [#1] PREEMPT SMP
NOPTI
мар 17 18:45:41 bhasus kernel: CPU: 2 PID: 949947 Comm: kworker/u25:1 Not
tainted 5.5.8-zen1-1-zen #1
мар 17 18:45:41 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
мар 17 18:45:41 bhasus kernel: Workqueue: hci0 hci_rx_work [bluetooth]
мар 17 18:45:41 bhasus kernel: RIP: 0010:__wake_up_common+0xf5/0x1b0
мар 17 18:45:41 bhasus kernel: Code: 24 48 89 50 08 48 8d 78 e8 48 89 02 49 89
71 18 48 83 c6 22 49 89 71 20 41 c7 01 00 00 00 00 48 39 c3 0f 85 58 ff ff ff
eb aa <49> 8b 47 18 4c 89 ff 49 8d 57 18 48 83 e8 18 48 39 14 24 74 95 49
мар 17 18:45:41 bhasus kernel: RSP: 0018:ffffb20ec81b3c20 EFLAGS: 00010083
мар 17 18:45:41 bhasus kernel: Code: 24 48 89 50 08 48 8d 78 e8 48 89 02 49 89
71 18 48 83 c6 22 49 89 71 20 41 c7 01 00 00 00 00 48 39 c3 0f 85 58 ff ff ff
eb aa <49> 8b 47 18 4c 89 ff 49 8d 57 18 48 83 e8 18 48 39 14 24 74 95 49
мар 17 18:45:41 bhasus kernel: RSP: 0018:ffffb20ec81b3c20 EFLAGS: 00010083
мар 17 18:45:41 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
мар 17 18:45:41 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
мар 17 18:45:41 bhasus kernel: RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffb20ec81b3bb8
мар 17 18:45:41 bhasus kernel: R10: 0000000000002b34 R11: 0000000000000000 R12:
0000000000000002
мар 17 18:45:41 bhasus kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
dead0000000000e8
мар 17 18:45:41 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff99eb1da80000(0000) knlGS:0000000000000000
мар 17 18:45:41 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
мар 17 18:45:41 bhasus kernel: CR2: 000055dd86b86f80 CR3: 000000079247a002 CR4:
00000000003606e0
мар 17 18:45:41 bhasus kernel: Call Trace:
мар 17 18:45:41 bhasus kernel:  __wake_up+0x7e/0xc0
мар 17 18:45:41 bhasus kernel:  sock_def_wakeup+0x3b/0x50
мар 17 18:45:41 bhasus kernel:  l2cap_sock_teardown_cb+0x19d/0x210 [bluetooth]
мар 17 18:45:41 bhasus kernel:  l2cap_chan_del+0x43/0x2d0 [bluetooth]
мар 17 18:45:41 bhasus kernel:  l2cap_conn_del+0x10d/0x250 [bluetooth]
мар 17 18:45:41 bhasus kernel:  hci_event_packet+0x81e/0x2a30 [bluetooth]
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x40/0x70
мар 17 18:45:41 bhasus kernel:  ? __kprobes_text_end+0x111c50/0x111c50
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x34/0x70
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x40/0x70
мар 17 18:45:41 bhasus kernel:  ? preempt_count_add+0x68/0xa0
мар 17 18:45:41 bhasus kernel:  hci_rx_work+0x19f/0x380 [bluetooth]
мар 17 18:45:41 bhasus kernel:  ? __schedule+0x422/0xbf0
мар 17 18:45:41 bhasus kernel:  process_one_work+0x1e1/0x3c0
мар 17 18:45:41 bhasus kernel:  worker_thread+0x5d/0x490
мар 17 18:45:41 bhasus kernel:  kthread+0x131/0x170
мар 17 18:45:41 bhasus kernel:  ? process_one_work+0x3c0/0x3c0
мар 17 18:45:41 bhasus kernel:  ? kthread_park+0x90/0x90
мар 17 18:45:41 bhasus kernel:  ret_from_fork+0x1f/0x40
мар 17 18:45:41 bhasus kernel: Modules linked in: fuse hidp rfcomm ccm veth
xt_nat nf_conntrack_netlink nfnetlink xt_addrtype br_netfilter overlay
xfrm_user xfrm_algo cmac algif_hash algif_skcipher af_alg xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 >
мар 17 18:45:41 bhasus kernel:  intel_powerclamp snd_hda_core coretemp
snd_hwdep libarc4 iwlwifi snd_pcm kvm_intel snd_timer kvm joydev mousedev snd
irqbypass r8169 wmi_bmof hid_multitouch mei_hdcp intel_rapl_msr iTCO_wdt
iTCO_vendor_support asus_nb_wmi asus_wmi sparse_>
мар 17 18:45:41 bhasus kernel:  scsi_mod i8042 serio i915 i2c_algo_bit
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm intel_agp
intel_gtt agpgart
мар 17 18:45:41 bhasus kernel: ---[ end trace eea9128a365b4677 ]---
мар 17 18:45:41 bhasus kernel: RIP: 0010:__wake_up_common+0xf5/0x1b0
мар 17 18:45:41 bhasus kernel: Code: 24 48 89 50 08 48 8d 78 e8 48 89 02 49 89
71 18 48 83 c6 22 49 89 71 20 41 c7 01 00 00 00 00 48 39 c3 0f 85 58 ff ff ff
eb aa <49> 8b 47 18 4c 89 ff 49 8d 57 18 48 83 e8 18 48 39 14 24 74 95 49
мар 17 18:45:41 bhasus kernel: RSP: 0018:ffffb20ec81b3c20 EFLAGS: 00010083
мар 17 18:45:41 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
мар 17 18:45:41 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
мар 17 18:45:41 bhasus kernel: RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffb20ec81b3bb8
мар 17 18:45:41 bhasus kernel: R10: 0000000000002b34 R11: 0000000000000000 R12:
0000000000000002
мар 17 18:45:41 bhasus kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
dead0000000000e8
мар 17 18:45:41 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff99eb1da80000(0000) knlGS:0000000000000000
мар 17 18:45:41 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
мар 17 18:45:41 bhasus kernel: CR2: 000055dd86b86f80 CR3: 000000079247a002 CR4:
00000000003606e0
мар 17 18:45:41 bhasus kernel: note: kworker/u25:1[949947] exited with
preempt_count 1
мар 17 18:45:43 bhasus dockerd[1241]:
time="2020-03-17T18:45:43.201866331+02:00" level=error msg="stream copy error:
reading from a closed fifo"
мар 17 18:45:43 bhasus dockerd[1241]:
time="2020-03-17T18:45:43.201866321+02:00" level=error msg="stream copy error:
reading from a closed fifo"
мар 17 18:45:43 bhasus kmail[956410]: kf5.kxmlgui: Index  23  is not within
range (0 -  21 )
мар 17 18:45:44 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Executing search "akonadi_newmailnotifier_agent-SearchSession"
мар 17 18:45:44 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search  "akonadi_newmailnotifier_agent-SearchSession" done (without remote
search)
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 33558999
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 49927478
мар 17 18:45:44 bhasus ksmserver[3647]: MapNotify: 49927478
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 33559002
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Error sending
STATISTICS_CMD: time out after 2000ms.
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Current CMD queue read_ptr
243 write_ptr 244
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Status: 0x00000040, count:
6
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Loaded firmware version:
46.6bf1df06.0
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x00000084 |
NMI_INTERRUPT_UNKNOWN       
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0080A210 |
trm_hw_status0
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x00000000 |
trm_hw_status1
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x004882DA | branchlink2
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0047932A |
interruptlink1
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0047932A |
interruptlink2
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0000CA1A | data1
мар 17 18:45:41 bhasus kernel: RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffb20ec81b3bb8
мар 17 18:45:36 bhasus systemd[2917]:
run-docker-runtime\x2drunc-moby-5bfb7c6892e98cbf8d3d848292da836b1bbc0c1ab1b9520135ccbeb51ff2c8c4-runc.72olL0.mount:
Succeeded.
мар 17 18:45:36 bhasus systemd[1]:
run-docker-runtime\x2drunc-moby-5bfb7c6892e98cbf8d3d848292da836b1bbc0c1ab1b9520135ccbeb51ff2c8c4-runc.72olL0.mount:
Succeeded.
мар 17 18:45:39 bhasus kscreenlocker_greet[975691]: Could not create AF_NETLINK
socket (Действието не е позволено)
мар 17 18:45:39 bhasus kscreenlocker_greet[975691]: Could not create AF_NETLINK
socket (Действието не е позволено)
мар 17 18:45:39 bhasus kscreenlocker_greet[975691]: Could not create AF_NETLINK
socket (Действието не е позволено)
мар 17 18:45:39 bhasus kscreenlocker_greet[975691]: Could not create AF_NETLINK
socket (Действието не е позволено)
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Executing search "searchUpdate-1584463539"
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search  "searchUpdate-1584463539" done (without remote search)
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search update for collection "DeclinedInvitations" ( 16 ) finished: all
results:  0 , removed results: 0
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Executing search "searchUpdate-1584463539"
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search  "searchUpdate-1584463539" done (without remote search)
мар 17 18:45:39 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search update for collection "OpenInvitations" ( 15 ) finished: all results:  0
, removed results: 0
мар 17 18:45:41 bhasus charon[1247]: 12[NET] forecast intercepted packet:
192.168.135.1 to 255.255.255.255
мар 17 18:45:41 bhasus kernel: general protection fault: 0000 [#1] PREEMPT SMP
NOPTI
мар 17 18:45:41 bhasus kernel: CPU: 2 PID: 949947 Comm: kworker/u25:1 Not
tainted 5.5.8-zen1-1-zen #1
мар 17 18:45:41 bhasus kernel: Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G531GT_G531GT/G531GT, BIOS G531GT.305 09/24/2019
мар 17 18:45:41 bhasus kernel: Workqueue: hci0 hci_rx_work [bluetooth]
мар 17 18:45:41 bhasus kernel: RIP: 0010:__wake_up_common+0xf5/0x1b0
мар 17 18:45:41 bhasus kernel: Code: 24 48 89 50 08 48 8d 78 e8 48 89 02 49 89
71 18 48 83 c6 22 49 89 71 20 41 c7 01 00 00 00 00 48 39 c3 0f 85 58 ff ff ff
eb aa <49> 8b 47 18 4c 89 ff 49 8d 57 18 48 83 e8 18 48 39 14 24 74 95 49
мар 17 18:45:41 bhasus kernel: RSP: 0018:ffffb20ec81b3c20 EFLAGS: 00010083
мар 17 18:45:41 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
мар 17 18:45:41 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
мар 17 18:45:41 bhasus kernel: RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffb20ec81b3bb8
мар 17 18:45:41 bhasus kernel: R10: 0000000000002b34 R11: 0000000000000000 R12:
0000000000000002
мар 17 18:45:41 bhasus kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
dead0000000000e8
мар 17 18:45:41 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff99eb1da80000(0000) knlGS:0000000000000000
мар 17 18:45:41 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
мар 17 18:45:41 bhasus kernel: CR2: 000055dd86b86f80 CR3: 000000079247a002 CR4:
00000000003606e0
мар 17 18:45:41 bhasus kernel: Call Trace:
мар 17 18:45:41 bhasus kernel:  __wake_up+0x7e/0xc0
мар 17 18:45:41 bhasus kernel:  sock_def_wakeup+0x3b/0x50
мар 17 18:45:41 bhasus kernel:  l2cap_sock_teardown_cb+0x19d/0x210 [bluetooth]
мар 17 18:45:41 bhasus kernel:  l2cap_chan_del+0x43/0x2d0 [bluetooth]
мар 17 18:45:41 bhasus kernel:  l2cap_conn_del+0x10d/0x250 [bluetooth]
мар 17 18:45:41 bhasus kernel:  hci_event_packet+0x81e/0x2a30 [bluetooth]
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x40/0x70
мар 17 18:45:41 bhasus kernel:  ? __kprobes_text_end+0x111c50/0x111c50
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x34/0x70
мар 17 18:45:41 bhasus kernel:  ? __switch_to_asm+0x40/0x70
мар 17 18:45:41 bhasus kernel:  ? preempt_count_add+0x68/0xa0
мар 17 18:45:41 bhasus kernel:  hci_rx_work+0x19f/0x380 [bluetooth]
мар 17 18:45:41 bhasus kernel:  ? __schedule+0x422/0xbf0
мар 17 18:45:41 bhasus kernel:  process_one_work+0x1e1/0x3c0
мар 17 18:45:41 bhasus kernel:  worker_thread+0x5d/0x490
мар 17 18:45:41 bhasus kernel:  kthread+0x131/0x170
мар 17 18:45:41 bhasus kernel:  ? process_one_work+0x3c0/0x3c0
мар 17 18:45:41 bhasus kernel:  ? kthread_park+0x90/0x90
мар 17 18:45:41 bhasus kernel:  ret_from_fork+0x1f/0x40
мар 17 18:45:41 bhasus kernel: Modules linked in: fuse hidp rfcomm ccm veth
xt_nat nf_conntrack_netlink nfnetlink xt_addrtype br_netfilter overlay
xfrm_user xfrm_algo cmac algif_hash algif_skcipher af_alg xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 >
мар 17 18:45:41 bhasus kernel:  intel_powerclamp snd_hda_core coretemp
snd_hwdep libarc4 iwlwifi snd_pcm kvm_intel snd_timer kvm joydev mousedev snd
irqbypass r8169 wmi_bmof hid_multitouch mei_hdcp intel_rapl_msr iTCO_wdt
iTCO_vendor_support asus_nb_wmi asus_wmi sparse_>
мар 17 18:45:41 bhasus kernel:  scsi_mod i8042 serio i915 i2c_algo_bit
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm intel_agp
intel_gtt agpgart
мар 17 18:45:41 bhasus kernel: ---[ end trace eea9128a365b4677 ]---
мар 17 18:45:41 bhasus kernel: RIP: 0010:__wake_up_common+0xf5/0x1b0
мар 17 18:45:41 bhasus kernel: Code: 24 48 89 50 08 48 8d 78 e8 48 89 02 49 89
71 18 48 83 c6 22 49 89 71 20 41 c7 01 00 00 00 00 48 39 c3 0f 85 58 ff ff ff
eb aa <49> 8b 47 18 4c 89 ff 49 8d 57 18 48 83 e8 18 48 39 14 24 74 95 49
мар 17 18:45:41 bhasus kernel: RSP: 0018:ffffb20ec81b3c20 EFLAGS: 00010083
мар 17 18:45:41 bhasus kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
мар 17 18:45:41 bhasus kernel: RDX: 0000000000000002 RSI: 0000000000000046 RDI:
00000000ffffffff
мар 17 18:45:41 bhasus kernel: RBP: 0000000000000001 R08: 0000000000000000 R09:
ffffb20ec81b3bb8
мар 17 18:45:41 bhasus kernel: R10: 0000000000002b34 R11: 0000000000000000 R12:
0000000000000002
мар 17 18:45:41 bhasus kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
dead0000000000e8
мар 17 18:45:41 bhasus kernel: FS:  0000000000000000(0000)
GS:ffff99eb1da80000(0000) knlGS:0000000000000000
мар 17 18:45:41 bhasus kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
мар 17 18:45:41 bhasus kernel: CR2: 000055dd86b86f80 CR3: 000000079247a002 CR4:
00000000003606e0
мар 17 18:45:41 bhasus kernel: note: kworker/u25:1[949947] exited with
preempt_count 1
мар 17 18:45:43 bhasus dockerd[1241]:
time="2020-03-17T18:45:43.201866331+02:00" level=error msg="stream copy error:
reading from a closed fifo"
мар 17 18:45:43 bhasus dockerd[1241]:
time="2020-03-17T18:45:43.201866321+02:00" level=error msg="stream copy error:
reading from a closed fifo"
мар 17 18:45:43 bhasus kmail[956410]: kf5.kxmlgui: Index  23  is not within
range (0 -  21 )
мар 17 18:45:44 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Executing search "akonadi_newmailnotifier_agent-SearchSession"
мар 17 18:45:44 bhasus akonadiserver[4670]: org.kde.pim.akonadiserver.search:
Search  "akonadi_newmailnotifier_agent-SearchSession" done (without remote
search)
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 33558999
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 49927478
мар 17 18:45:44 bhasus ksmserver[3647]: MapNotify: 49927478
мар 17 18:45:44 bhasus ksmserver[3647]: CreateNotify: 33559002
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Error sending
STATISTICS_CMD: time out after 2000ms.
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Current CMD queue read_ptr
243 write_ptr 244
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Status: 0x00000040, count:
6
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: Loaded firmware version:
46.6bf1df06.0
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x00000084 |
NMI_INTERRUPT_UNKNOWN       
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0080A210 |
trm_hw_status0
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x00000000 |
trm_hw_status1
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x004882DA | branchlink2
мар 17 18:45:46 bhasus kernel: iwlwifi 0000:00:14.3: 0x0047932A |
interruptlink1

-- 
You are receiving this mail because:
You are the assignee for the bug.
