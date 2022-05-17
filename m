Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3257C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 17:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351316AbiEQRFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 May 2022 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiEQRFE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 May 2022 13:05:04 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C74339D
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 10:05:00 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e5e433d66dso24962248fac.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZZfLdTX+0GOFocOPRKH3yB2J3ULV7A1AmZu4QAKNf4I=;
        b=PtkZnWZ1Egyp9/Q59vojOcoCZrZRD8s7ciqSCNLtECeQSjDMUXZdw3+WbdQr7c6Gl1
         4951Fi/MHbez5MDSZQiw/KdY0jdir6POnJ1VNQuw/2FVbYpCGd/JjW0du1TloRTg1SU+
         zix0dppK01PW2ESZq7crVzojQliMmzIcNt7LDmxR8Fi98oGW5FgdNudzcL4BP7HLjfq9
         p572zwqx7pKggpc/z0gYCVUZknlFoD3ENur4kIfFDEs70TSasQN+7J/ttH6eQUPUb52/
         UNTzlgCU7gKtnDKr7QLGT3bC0QBiiaPIEvRy8aoK+zugBeK/KoSMQMokWWYgqQrrYJAV
         F75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZZfLdTX+0GOFocOPRKH3yB2J3ULV7A1AmZu4QAKNf4I=;
        b=KdqPCXefkznb16qoSJtYEGDDiPOacrgPQeuHDh+15KHSvy/9ImYaA8Ix3WG49p9DFe
         VxTrXFf5Sy/YidGGeAenakV7wQHstCgZ+O6aLxZ53pyPIVJA4/QrdVX993WRZqainyNL
         fag/GJMq25BWY7fsBHLLNFyMbhhPfu5As1Fi+McfBQChw7FHzoqvRcj3XvCwdmC56607
         WEz+0N1PajMzmndQg/nugGj8TPbW/aneMv8GxZ0tqJkEl9TZn2fFqNiqwjLnZi/ADLM3
         sxJukRRSsCTJS6/toPy0wjFzFO7uM3RuI6f/1zcKOI8dBH7ullQX0BPkVuxcIUtZK+CO
         UGPA==
X-Gm-Message-State: AOAM530FVHnT8cA1cnuLcbqakDb6UzarqqgYmvFS7R3ZoqjNcRAuRuq3
        43clLbRKGHq5WTV13Qs96ZxVyKNcTvbbyK0PgraTapzT+Yw=
X-Google-Smtp-Source: ABdhPJwco2Pc6qCA5u8jMGGqSgivzwtfSCICQhQ3TUK1iRwvLge1WvP/w0bZmhXMU9Mdsunw8WQMTkAJXQWga9aZXjU=
X-Received: by 2002:a05:6870:14d5:b0:ee:20f7:38e with SMTP id
 l21-20020a05687014d500b000ee20f7038emr13138284oab.51.1652807099335; Tue, 17
 May 2022 10:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAMBK1_QsN7==LDGH5swhJ==qg9mZbXK5CjqT_c7V8NF=AsJGXA@mail.gmail.com>
In-Reply-To: <CAMBK1_QsN7==LDGH5swhJ==qg9mZbXK5CjqT_c7V8NF=AsJGXA@mail.gmail.com>
From:   Serge SIMON <serge.simon@gmail.com>
Date:   Tue, 17 May 2022 19:03:22 +0200
Message-ID: <CAMBK1_RrRgdRHhh9MKJh5+J4MJR0-0QDKJh8PzQcjWKkfDvQdg@mail.gmail.com>
Subject: Kernel crashes about bluetooth (up-to-date archlinux)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello !

Sorry if this is not the proper place to report such an issue
(otherwise please feel free to give me the proper procedure, JIRA URL,
whatever).

I have a fresh archlinux install on a new device (MELE QUIETER 2D, x86
64 bits), so everything is up-to-date (kernel is : "Linux hyperion
5.17.7-arch1-2 #1 SMP PREEMPT Sun, 15 May 2022 05:00:14 +0000 x86_64
GNU/Linux").

I'm willing to use bluetooth to read some xiaomi plant sensors
(through a python script).

The first measures are correctly read (through Bluetooth LE), but just
after i systematically have kernel crashes (so ~30 seconds after
boot).

After that i have to reboot the box (system is still responding but
the bluetooth stack is gone and cannot be recovered, not even by a
service restart with systemctl).

Crash dump is attached below.

Thanks in advance for any help and regards.

---

mai 17 10:22:40 hyperion kernel: Bluetooth: hci0: Opcode 0x200d failed: -110
mai 17 10:22:40 hyperion kernel: Bluetooth: hci0: request failed to
create LE connection: err -110
mai 17 10:22:40 hyperion bluetoothd[320]: Disconnecting failed:
already disconnected
mai 17 10:22:54 hyperion kernel: Bluetooth: hci0: Opcode 0x200d failed: -110
mai 17 10:22:54 hyperion kernel: Bluetooth: hci0: request failed to
create LE connection: err -110
mai 17 10:22:54 hyperion kernel: ------------[ cut here ]------------
mai 17 10:22:54 hyperion kernel: list_del corruption,
ffffa0e00caf4800->prev is LIST_POISON2 (dead000000000122)
mai 17 10:22:54 hyperion kernel: WARNING: CPU: 1 PID: 285 at
lib/list_debug.c:48 __list_del_entry_valid+0x5e/0xa0
mai 17 10:22:54 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:22:54 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:22:54 hyperion kernel: CPU: 1 PID: 285 Comm: kworker/u9:1
Not tainted 5.17.7-arch1-2 #1 fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:22:54 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:22:54 hyperion kernel: Workqueue: hci0 hci_cmd_sync_work [bluetooth]
mai 17 10:22:54 hyperion kernel: RIP: 0010:__list_del_entry_valid+0x5e/0xa0
mai 17 10:22:54 hyperion kernel: Code: 00 c3 cc 48 89 fe 48 c7 c7 28
dc 4c ac e8 da a8 5f 00 0f 0b 31 c0 c3 cc 48 89 fe 48 89 ca 48 c7 c7
60 dc 4c ac e8 c2 a8 5f 00 <0f> 0b eb e6 48 89 fe 48 89 c2 48 c7 c7 98
dc 4c ac e8 ac a8 5f 00
mai 17 10:22:54 hyperion kernel: RSP: 0018:ffffc31c8061fd98 EFLAGS: 00010286
mai 17 10:22:54 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e00caf4800 RCX: 0000000000000027
mai 17 10:22:54 hyperion kernel: RDX: ffffa0e07bca16e8 RSI:
0000000000000001 RDI: ffffa0e07bca16e0
mai 17 10:22:54 hyperion kernel: RBP: ffffa0e00cbf6000 R08:
0000000000000000 R09: ffffc31c8061fbb0
mai 17 10:22:54 hyperion kernel: R10: ffffc31c8061fba8 R11:
0000000000000003 R12: 0000000000000092
mai 17 10:22:54 hyperion kernel: R13: ffffa0e00cbf6000 R14:
ffffa0e00caf4814 R15: ffffa0e01085c180
mai 17 10:22:54 hyperion kernel: FS:  0000000000000000(0000)
GS:ffffa0e07bc80000(0000) knlGS:0000000000000000
mai 17 10:22:54 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:22:54 hyperion kernel: CR2: 00007fd71a8babf0 CR3:
0000000130610000 CR4: 0000000000350ee0
mai 17 10:22:54 hyperion kernel: Call Trace:
mai 17 10:22:54 hyperion kernel:  <TASK>
mai 17 10:22:54 hyperion kernel:  hci_conn_cleanup+0x33/0x180
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_conn_del+0xd4/0x1b0 [bluetooth
4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_le_conn_failed+0x168/0x210
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  create_le_conn_complete+0x53/0x80
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_cmd_sync_work+0xb6/0x150
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  process_one_work+0x1c4/0x380
mai 17 10:22:54 hyperion kernel:  worker_thread+0x4d/0x380
mai 17 10:22:54 hyperion kernel:  ? rescuer_thread+0x3a0/0x3a0
mai 17 10:22:54 hyperion kernel:  kthread+0xd7/0x100
mai 17 10:22:54 hyperion kernel:  ? kthread_complete_and_exit+0x20/0x20
mai 17 10:22:54 hyperion kernel:  ret_from_fork+0x1f/0x30
mai 17 10:22:54 hyperion kernel:  </TASK>
mai 17 10:22:54 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:22:54 hyperion kernel: ------------[ cut here ]------------
mai 17 10:22:54 hyperion kernel: list_del corruption. prev->next
should be ffffa0e004181090, but was ffffa0e004181f90.
(prev=ffffa0e004181390)
mai 17 10:22:54 hyperion kernel: WARNING: CPU: 1 PID: 285 at
lib/list_debug.c:51 __list_del_entry_valid+0x74/0xa0
mai 17 10:22:54 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:22:54 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:22:54 hyperion kernel: CPU: 1 PID: 285 Comm: kworker/u9:1
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:22:54 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:22:54 hyperion kernel: Workqueue: hci0 hci_cmd_sync_work [bluetooth]
mai 17 10:22:54 hyperion kernel: RIP: 0010:__list_del_entry_valid+0x74/0xa0
mai 17 10:22:54 hyperion kernel: Code: c3 cc 48 89 fe 48 89 ca 48 c7
c7 60 dc 4c ac e8 c2 a8 5f 00 0f 0b eb e6 48 89 fe 48 89 c2 48 c7 c7
98 dc 4c ac e8 ac a8 5f 00 <0f> 0b eb d0 48 89 d1 48 c7 c7 e0 dc 4c ac
48 89 f2 48 89 c6 e8 93
mai 17 10:22:54 hyperion kernel: RSP: 0018:ffffc31c8061fd40 EFLAGS: 00010282
mai 17 10:22:54 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e004181000 RCX: 0000000000000027
mai 17 10:22:54 hyperion kernel: RDX: ffffa0e07bca16e8 RSI:
0000000000000001 RDI: ffffa0e07bca16e0
mai 17 10:22:54 hyperion kernel: RBP: ffffa0e004181c00 R08:
0000000000000000 R09: ffffc31c8061fb58
mai 17 10:22:54 hyperion kernel: R10: ffffc31c8061fb50 R11:
0000000000000003 R12: ffffa0e004181058
mai 17 10:22:54 hyperion kernel: R13: ffffa0e004181c00 R14:
ffffa0e00caf4814 R15: ffffa0e01085c180
mai 17 10:22:54 hyperion kernel: FS:  0000000000000000(0000)
GS:ffffa0e07bc80000(0000) knlGS:0000000000000000
mai 17 10:22:54 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:22:54 hyperion kernel: CR2: 00007fd71a8babf0 CR3:
0000000130610000 CR4: 0000000000350ee0
mai 17 10:22:54 hyperion kernel: Call Trace:
mai 17 10:22:54 hyperion kernel:  <TASK>
mai 17 10:22:54 hyperion kernel:  __dentry_kill+0x86/0x170
mai 17 10:22:54 hyperion kernel:  dput+0x13e/0x310
mai 17 10:22:54 hyperion kernel:  debugfs_remove+0x40/0x60
mai 17 10:22:54 hyperion kernel:  hci_conn_cleanup+0xad/0x180
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_conn_del+0xd4/0x1b0 [bluetooth
4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_le_conn_failed+0x168/0x210
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  create_le_conn_complete+0x53/0x80
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_cmd_sync_work+0xb6/0x150
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  process_one_work+0x1c4/0x380
mai 17 10:22:54 hyperion kernel:  worker_thread+0x4d/0x380
mai 17 10:22:54 hyperion kernel:  ? rescuer_thread+0x3a0/0x3a0
mai 17 10:22:54 hyperion kernel:  kthread+0xd7/0x100
mai 17 10:22:54 hyperion kernel:  ? kthread_complete_and_exit+0x20/0x20
mai 17 10:22:54 hyperion kernel:  ret_from_fork+0x1f/0x30
mai 17 10:22:54 hyperion kernel:  </TASK>
mai 17 10:22:54 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:22:54 hyperion kernel: ------------[ cut here ]------------
mai 17 10:22:54 hyperion kernel: WARNING: CPU: 1 PID: 285 at
fs/dcache.c:365 dentry_free+0x5f/0x70
mai 17 10:22:54 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:22:54 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:22:54 hyperion kernel: CPU: 1 PID: 285 Comm: kworker/u9:1
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:22:54 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:22:54 hyperion kernel: Workqueue: hci0 hci_cmd_sync_work [bluetooth]
mai 17 10:22:54 hyperion kernel: RIP: 0010:dentry_free+0x5f/0x70
mai 17 10:22:54 hyperion kernel: Code: c7 b0 00 00 00 48 c7 c6 00 f5
33 ab e9 da 32 de ff f0 ff 48 f0 75 d0 48 81 c7 b0 00 00 00 48 c7 c6
d0 f4 33 ab e9 c1 32 de ff <0f> 0b eb ac 66 66 2e 0f 1f 84 00 00 00 00
00 66 90 0f 1f 44 00 00
mai 17 10:22:54 hyperion kernel: RSP: 0018:ffffc31c8061fd40 EFLAGS: 00010286
mai 17 10:22:54 hyperion kernel: RAX: 000000000000800c RBX:
ffffa0e004181000 RCX: 0000000000000027
mai 17 10:22:54 hyperion kernel: RDX: 0000000000000001 RSI:
0000000000000001 RDI: ffffa0e004181000
mai 17 10:22:54 hyperion kernel: RBP: ffffa0e004181c00 R08:
0000000000000000 R09: ffffc31c8061fb58
mai 17 10:22:54 hyperion kernel: R10: ffffc31c8061fb50 R11:
0000000000000003 R12: ffffa0e004181058
mai 17 10:22:54 hyperion kernel: R13: ffffa0e004181c00 R14:
ffffa0e00caf4814 R15: ffffa0e01085c180
mai 17 10:22:54 hyperion kernel: FS:  0000000000000000(0000)
GS:ffffa0e07bc80000(0000) knlGS:0000000000000000
mai 17 10:22:54 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:22:54 hyperion kernel: CR2: 00007fd71a8babf0 CR3:
0000000130610000 CR4: 0000000000350ee0
mai 17 10:22:54 hyperion kernel: Call Trace:
mai 17 10:22:54 hyperion kernel:  <TASK>
mai 17 10:22:54 hyperion kernel:  __dentry_kill+0x135/0x170
mai 17 10:22:54 hyperion kernel:  dput+0x13e/0x310
mai 17 10:22:54 hyperion kernel:  debugfs_remove+0x40/0x60
mai 17 10:22:54 hyperion kernel:  hci_conn_cleanup+0xad/0x180
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_conn_del+0xd4/0x1b0 [bluetooth
4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_le_conn_failed+0x168/0x210
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  create_le_conn_complete+0x53/0x80
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_cmd_sync_work+0xb6/0x150
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  process_one_work+0x1c4/0x380
mai 17 10:22:54 hyperion kernel:  worker_thread+0x4d/0x380
mai 17 10:22:54 hyperion kernel:  ? rescuer_thread+0x3a0/0x3a0
mai 17 10:22:54 hyperion kernel:  kthread+0xd7/0x100
mai 17 10:22:54 hyperion kernel:  ? kthread_complete_and_exit+0x20/0x20
mai 17 10:22:54 hyperion kernel:  ret_from_fork+0x1f/0x30
mai 17 10:22:54 hyperion kernel:  </TASK>
mai 17 10:22:54 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:22:54 hyperion kernel: ------------[ cut here ]------------
mai 17 10:22:54 hyperion kernel: refcount_t: underflow; use-after-free.
mai 17 10:22:54 hyperion kernel: WARNING: CPU: 1 PID: 285 at
lib/refcount.c:28 refcount_warn_saturate+0xaa/0xf0
mai 17 10:22:54 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:22:54 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:22:54 hyperion kernel: CPU: 1 PID: 285 Comm: kworker/u9:1
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:22:54 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:22:54 hyperion kernel: Workqueue: hci0 hci_cmd_sync_work [bluetooth]
mai 17 10:22:54 hyperion kernel: RIP: 0010:refcount_warn_saturate+0xaa/0xf0
mai 17 10:22:54 hyperion kernel: Code: 89 2f 8c 01 01 e8 26 59 60 00
0f 0b c3 cc 80 3d 78 2f 8c 01 00 75 91 48 c7 c7 98 d0 4c ac c6 05 68
2f 8c 01 01 e8 06 59 60 00 <0f> 0b c3 cc 80 3d 56 2f 8c 01 00 0f 85 6d
ff ff ff 48 c7 c7 f0 d0
mai 17 10:22:54 hyperion kernel: RSP: 0018:ffffc31c8061fdb0 EFLAGS: 00010286
mai 17 10:22:54 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e00caf4800 RCX: 0000000000000027
mai 17 10:22:54 hyperion kernel: RDX: ffffa0e07bca16e8 RSI:
0000000000000001 RDI: ffffa0e07bca16e0
mai 17 10:22:54 hyperion kernel: RBP: ffffa0e00cbf6000 R08:
0000000000000000 R09: ffffc31c8061fbc8
mai 17 10:22:54 hyperion kernel: R10: ffffc31c8061fbc0 R11:
0000000000000003 R12: 0000000000000092
mai 17 10:22:54 hyperion kernel: R13: ffffa0e00cbf6000 R14:
ffffa0e00caf4814 R15: ffffa0e01085c180
mai 17 10:22:54 hyperion kernel: FS:  0000000000000000(0000)
GS:ffffa0e07bc80000(0000) knlGS:0000000000000000
mai 17 10:22:54 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:22:54 hyperion kernel: CR2: 00007fd71a8babf0 CR3:
0000000130610000 CR4: 0000000000350ee0
mai 17 10:22:54 hyperion kernel: Call Trace:
mai 17 10:22:54 hyperion kernel:  <TASK>
mai 17 10:22:54 hyperion kernel:  hci_conn_del+0xd4/0x1b0 [bluetooth
4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_le_conn_failed+0x168/0x210
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  create_le_conn_complete+0x53/0x80
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  hci_cmd_sync_work+0xb6/0x150
[bluetooth 4a604ba80830197080e3db3e4b344fabc243a779]
mai 17 10:22:54 hyperion kernel:  process_one_work+0x1c4/0x380
mai 17 10:22:54 hyperion kernel:  worker_thread+0x4d/0x380
mai 17 10:22:54 hyperion kernel:  ? rescuer_thread+0x3a0/0x3a0
mai 17 10:22:54 hyperion kernel:  kthread+0xd7/0x100
mai 17 10:22:54 hyperion kernel:  ? kthread_complete_and_exit+0x20/0x20
mai 17 10:22:54 hyperion kernel:  ret_from_fork+0x1f/0x30
mai 17 10:22:54 hyperion kernel:  </TASK>
mai 17 10:22:54 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:22:54 hyperion kernel: ------------[ cut here ]------------
mai 17 10:22:54 hyperion kernel: WARNING: CPU: 1 PID: 26 at
kernel/rcu/tree.c:2586 rcu_core+0x6e9/0x750
mai 17 10:22:54 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:22:54 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:22:54 hyperion kernel: CPU: 1 PID: 26 Comm: ksoftirqd/1
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:22:54 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:22:54 hyperion kernel: RIP: 0010:rcu_core+0x6e9/0x750
mai 17 10:22:54 hyperion kernel: Code: 43 fc ff ff 0f 0b e9 3c fc ff
ff 4c 89 ee 4c 89 e7 e8 5b b3 a4 00 e9 19 fa ff ff 48 8b 55 78 48 85
d2 0f 84 a2 fd ff ff eb c6 <0f> 0b e9 26 fc ff ff 4c 8b 3d d1 9e ba 01
65 8b 3d aa 62 ef 54 e8
mai 17 10:22:54 hyperion kernel: RSP: 0018:ffffc31c8011be38 EFLAGS: 00010046
mai 17 10:22:54 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e07bcb38f8 RCX: 0000000001246401
mai 17 10:22:54 hyperion kernel: RDX: ffffffffffffd8f0 RSI:
0000000000000001 RDI: ffffa0e07bcb38f8
mai 17 10:22:54 hyperion kernel: RBP: ffffa0e07bcb3880 R08:
0000000000000000 R09: 0000000074f5853d
mai 17 10:22:54 hyperion kernel: R10: ffffa0e00fcfd700 R11:
ffffffffacc060c0 R12: 0000000000000246
mai 17 10:22:54 hyperion kernel: R13: fffffffffffffffe R14:
000000000000000a R15: 0000000000000000
mai 17 10:22:54 hyperion kernel: FS:  0000000000000000(0000)
GS:ffffa0e07bc80000(0000) knlGS:0000000000000000
mai 17 10:22:54 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:22:54 hyperion kernel: CR2: 00007f2cc9161ff0 CR3:
0000000130610000 CR4: 0000000000350ee0
mai 17 10:22:54 hyperion kernel: Call Trace:
mai 17 10:22:54 hyperion kernel:  <TASK>
mai 17 10:22:54 hyperion kernel:  __do_softirq+0xcd/0x2c4
mai 17 10:22:54 hyperion kernel:  ? smpboot_register_percpu_thread+0xf0/0xf0
mai 17 10:22:54 hyperion kernel:  run_ksoftirqd+0x27/0x40
mai 17 10:22:54 hyperion kernel:  smpboot_thread_fn+0xd5/0x1c0
mai 17 10:22:54 hyperion kernel:  kthread+0xd7/0x100
mai 17 10:22:54 hyperion kernel:  ? kthread_complete_and_exit+0x20/0x20
mai 17 10:22:54 hyperion kernel:  ret_from_fork+0x1f/0x30
mai 17 10:22:54 hyperion kernel:  </TASK>
mai 17 10:22:54 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:23:00 hyperion kernel: ------------[ cut here ]------------
mai 17 10:23:00 hyperion kernel: list_del corruption. prev->next
should be ffffa0e004181c90, but was ffffa0e004181be0.
(prev=ffffa0e004181be0)
mai 17 10:23:00 hyperion kernel: WARNING: CPU: 0 PID: 612 at
lib/list_debug.c:51 __list_del_entry_valid+0x74/0xa0
mai 17 10:23:00 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:23:00 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:23:00 hyperion kernel: CPU: 0 PID: 612 Comm: python3
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:23:00 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:23:00 hyperion kernel: RIP: 0010:__list_del_entry_valid+0x74/0xa0
mai 17 10:23:00 hyperion kernel: Code: c3 cc 48 89 fe 48 89 ca 48 c7
c7 60 dc 4c ac e8 c2 a8 5f 00 0f 0b eb e6 48 89 fe 48 89 c2 48 c7 c7
98 dc 4c ac e8 ac a8 5f 00 <0f> 0b eb d0 48 89 d1 48 c7 c7 e0 dc 4c ac
48 89 f2 48 89 c6 e8 93
mai 17 10:23:00 hyperion kernel: RSP: 0018:ffffc31c80b6bbf8 EFLAGS: 00010286
mai 17 10:23:00 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e004181c00 RCX: 0000000000000027
mai 17 10:23:00 hyperion kernel: RDX: ffffa0e07bc216e8 RSI:
0000000000000001 RDI: ffffa0e07bc216e0
mai 17 10:23:00 hyperion kernel: RBP: ffffa0e004181b40 R08:
0000000000000000 R09: ffffc31c80b6ba10
mai 17 10:23:00 hyperion kernel: R10: ffffc31c80b6ba08 R11:
0000000000000003 R12: ffffa0e004181c58
mai 17 10:23:00 hyperion kernel: R13: ffffa0e004181b40 R14:
ffffa0e003518eb0 R15: ffffa0e00ee2f180
mai 17 10:23:00 hyperion kernel: FS:  00007fd71aca3740(0000)
GS:ffffa0e07bc00000(0000) knlGS:0000000000000000
mai 17 10:23:00 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:23:00 hyperion kernel: CR2: 00007fd71a90e1b0 CR3:
0000000112306000 CR4: 0000000000350ef0
mai 17 10:23:00 hyperion kernel: Call Trace:
mai 17 10:23:00 hyperion kernel:  <TASK>
mai 17 10:23:00 hyperion kernel:  __dentry_kill+0x86/0x170
mai 17 10:23:00 hyperion kernel:  dput+0x13e/0x310
mai 17 10:23:00 hyperion kernel:  proc_invalidate_siblings_dcache+0x133/0x150
mai 17 10:23:00 hyperion kernel:  release_task+0x382/0x530
mai 17 10:23:00 hyperion kernel:  wait_consider_task+0x4e8/0xa80
mai 17 10:23:00 hyperion kernel:  do_wait+0x16b/0x2f0
mai 17 10:23:00 hyperion kernel:  kernel_wait4+0xb4/0x150
mai 17 10:23:00 hyperion kernel:  ? thread_group_exited+0x50/0x50
mai 17 10:23:00 hyperion kernel:  __do_sys_wait4+0x9f/0xb0
mai 17 10:23:00 hyperion kernel:  do_syscall_64+0x58/0x80
mai 17 10:23:00 hyperion kernel:  ? do_user_addr_fault+0x1d8/0x680
mai 17 10:23:00 hyperion kernel:  ? exc_page_fault+0x71/0x170
mai 17 10:23:00 hyperion kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
mai 17 10:23:00 hyperion kernel: RIP: 0033:0x7fd71ad71207
mai 17 10:23:00 hyperion kernel: Code: 89 7c 24 10 48 89 4c 24 18 e8
95 9b fb ff 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c
24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24
10 e8 c5 9b fb ff 8b 44
mai 17 10:23:00 hyperion kernel: RSP: 002b:00007ffe0fcd0140 EFLAGS:
00000293 ORIG_RAX: 000000000000003d
mai 17 10:23:00 hyperion kernel: RAX: ffffffffffffffda RBX:
0000000001bd21c0 RCX: 00007fd71ad71207
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000000 RSI:
00007ffe0fcd017c RDI: 0000000000000029
mai 17 10:23:00 hyperion kernel: RBP: 0000000001bd21c0 R08:
0000000000000000 R09: 0000000000000000
mai 17 10:23:00 hyperion kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 0000000000000029
mai 17 10:23:00 hyperion kernel: R13: 0000000000000000 R14:
00007fd71a90dcc0 R15: 0000000001bd21c0
mai 17 10:23:00 hyperion kernel:  </TASK>
mai 17 10:23:00 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:23:00 hyperion kernel: ------------[ cut here ]------------
mai 17 10:23:00 hyperion kernel: WARNING: CPU: 0 PID: 612 at
fs/dcache.c:365 dentry_free+0x5f/0x70
mai 17 10:23:00 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:23:00 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:23:00 hyperion kernel: CPU: 0 PID: 612 Comm: python3
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:23:00 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:23:00 hyperion kernel: RIP: 0010:dentry_free+0x5f/0x70
mai 17 10:23:00 hyperion kernel: Code: c7 b0 00 00 00 48 c7 c6 00 f5
33 ab e9 da 32 de ff f0 ff 48 f0 75 d0 48 81 c7 b0 00 00 00 48 c7 c6
d0 f4 33 ab e9 c1 32 de ff <0f> 0b eb ac 66 66 2e 0f 1f 84 00 00 00 00
00 66 90 0f 1f 44 00 00
mai 17 10:23:00 hyperion kernel: RSP: 0018:ffffc31c80b6bbf8 EFLAGS: 00010286
mai 17 10:23:00 hyperion kernel: RAX: 000000000000800c RBX:
ffffa0e004181c00 RCX: 0000000000000027
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000001 RSI:
0000000000000001 RDI: ffffa0e004181c00
mai 17 10:23:00 hyperion kernel: RBP: ffffa0e004181b40 R08:
0000000000000000 R09: ffffc31c80b6ba10
mai 17 10:23:00 hyperion kernel: R10: ffffc31c80b6ba08 R11:
0000000000000003 R12: ffffa0e004181c58
mai 17 10:23:00 hyperion kernel: R13: ffffa0e004181b40 R14:
ffffa0e003518eb0 R15: ffffa0e00ee2f180
mai 17 10:23:00 hyperion kernel: FS:  00007fd71aca3740(0000)
GS:ffffa0e07bc00000(0000) knlGS:0000000000000000
mai 17 10:23:00 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:23:00 hyperion kernel: CR2: 00007fd71a90e1b0 CR3:
0000000112306000 CR4: 0000000000350ef0
mai 17 10:23:00 hyperion kernel: Call Trace:
mai 17 10:23:00 hyperion kernel:  <TASK>
mai 17 10:23:00 hyperion kernel:  __dentry_kill+0x135/0x170
mai 17 10:23:00 hyperion kernel:  dput+0x13e/0x310
mai 17 10:23:00 hyperion kernel:  proc_invalidate_siblings_dcache+0x133/0x150
mai 17 10:23:00 hyperion kernel:  release_task+0x382/0x530
mai 17 10:23:00 hyperion kernel:  wait_consider_task+0x4e8/0xa80
mai 17 10:23:00 hyperion kernel:  do_wait+0x16b/0x2f0
mai 17 10:23:00 hyperion kernel:  kernel_wait4+0xb4/0x150
mai 17 10:23:00 hyperion kernel:  ? thread_group_exited+0x50/0x50
mai 17 10:23:00 hyperion kernel:  __do_sys_wait4+0x9f/0xb0
mai 17 10:23:00 hyperion kernel:  do_syscall_64+0x58/0x80
mai 17 10:23:00 hyperion kernel:  ? do_user_addr_fault+0x1d8/0x680
mai 17 10:23:00 hyperion kernel:  ? exc_page_fault+0x71/0x170
mai 17 10:23:00 hyperion kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
mai 17 10:23:00 hyperion kernel: RIP: 0033:0x7fd71ad71207
mai 17 10:23:00 hyperion kernel: Code: 89 7c 24 10 48 89 4c 24 18 e8
95 9b fb ff 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c
24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24
10 e8 c5 9b fb ff 8b 44
mai 17 10:23:00 hyperion kernel: RSP: 002b:00007ffe0fcd0140 EFLAGS:
00000293 ORIG_RAX: 000000000000003d
mai 17 10:23:00 hyperion kernel: RAX: ffffffffffffffda RBX:
0000000001bd21c0 RCX: 00007fd71ad71207
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000000 RSI:
00007ffe0fcd017c RDI: 0000000000000029
mai 17 10:23:00 hyperion kernel: RBP: 0000000001bd21c0 R08:
0000000000000000 R09: 0000000000000000
mai 17 10:23:00 hyperion kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 0000000000000029
mai 17 10:23:00 hyperion kernel: R13: 0000000000000000 R14:
00007fd71a90dcc0 R15: 0000000001bd21c0
mai 17 10:23:00 hyperion kernel:  </TASK>
mai 17 10:23:00 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:23:00 hyperion kernel: ------------[ cut here ]------------
mai 17 10:23:00 hyperion kernel: list_del corruption. prev->next
should be ffffa0e004181bd0, but was ffffa0e00e239d50.
(prev=ffffa0e00e13b6a0)
mai 17 10:23:00 hyperion kernel: WARNING: CPU: 0 PID: 612 at
lib/list_debug.c:51 __list_del_entry_valid+0x74/0xa0
mai 17 10:23:00 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:23:00 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:23:00 hyperion kernel: CPU: 0 PID: 612 Comm: python3
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:23:00 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:23:00 hyperion kernel: RIP: 0010:__list_del_entry_valid+0x74/0xa0
mai 17 10:23:00 hyperion kernel: Code: c3 cc 48 89 fe 48 89 ca 48 c7
c7 60 dc 4c ac e8 c2 a8 5f 00 0f 0b eb e6 48 89 fe 48 89 c2 48 c7 c7
98 dc 4c ac e8 ac a8 5f 00 <0f> 0b eb d0 48 89 d1 48 c7 c7 e0 dc 4c ac
48 89 f2 48 89 c6 e8 93
mai 17 10:23:00 hyperion kernel: RSP: 0018:ffffc31c80b6bbf8 EFLAGS: 00010286
mai 17 10:23:00 hyperion kernel: RAX: 0000000000000000 RBX:
ffffa0e004181b40 RCX: 0000000000000027
mai 17 10:23:00 hyperion kernel: RDX: ffffa0e07bc216e8 RSI:
0000000000000001 RDI: ffffa0e07bc216e0
mai 17 10:23:00 hyperion kernel: RBP: ffffa0e00e13b600 R08:
0000000000000000 R09: ffffc31c80b6ba10
mai 17 10:23:00 hyperion kernel: R10: ffffc31c80b6ba08 R11:
0000000000000003 R12: ffffa0e004181b98
mai 17 10:23:00 hyperion kernel: R13: ffffa0e00e13b600 R14:
ffffa0e003518eb0 R15: ffffa0e00ee2f180
mai 17 10:23:00 hyperion kernel: FS:  00007fd71aca3740(0000)
GS:ffffa0e07bc00000(0000) knlGS:0000000000000000
mai 17 10:23:00 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:23:00 hyperion kernel: CR2: 00007fd71a90e1b0 CR3:
0000000112306000 CR4: 0000000000350ef0
mai 17 10:23:00 hyperion kernel: Call Trace:
mai 17 10:23:00 hyperion kernel:  <TASK>
mai 17 10:23:00 hyperion kernel:  __dentry_kill+0x86/0x170
mai 17 10:23:00 hyperion kernel:  dput+0x13e/0x310
mai 17 10:23:00 hyperion kernel:  proc_invalidate_siblings_dcache+0x133/0x150
mai 17 10:23:00 hyperion kernel:  release_task+0x382/0x530
mai 17 10:23:00 hyperion kernel:  wait_consider_task+0x4e8/0xa80
mai 17 10:23:00 hyperion kernel:  do_wait+0x16b/0x2f0
mai 17 10:23:00 hyperion kernel:  kernel_wait4+0xb4/0x150
mai 17 10:23:00 hyperion kernel:  ? thread_group_exited+0x50/0x50
mai 17 10:23:00 hyperion kernel:  __do_sys_wait4+0x9f/0xb0
mai 17 10:23:00 hyperion kernel:  do_syscall_64+0x58/0x80
mai 17 10:23:00 hyperion kernel:  ? do_user_addr_fault+0x1d8/0x680
mai 17 10:23:00 hyperion kernel:  ? exc_page_fault+0x71/0x170
mai 17 10:23:00 hyperion kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
mai 17 10:23:00 hyperion kernel: RIP: 0033:0x7fd71ad71207
mai 17 10:23:00 hyperion kernel: Code: 89 7c 24 10 48 89 4c 24 18 e8
95 9b fb ff 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c
24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24
10 e8 c5 9b fb ff 8b 44
mai 17 10:23:00 hyperion kernel: RSP: 002b:00007ffe0fcd0140 EFLAGS:
00000293 ORIG_RAX: 000000000000003d
mai 17 10:23:00 hyperion kernel: RAX: ffffffffffffffda RBX:
0000000001bd21c0 RCX: 00007fd71ad71207
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000000 RSI:
00007ffe0fcd017c RDI: 0000000000000029
mai 17 10:23:00 hyperion kernel: RBP: 0000000001bd21c0 R08:
0000000000000000 R09: 0000000000000000
mai 17 10:23:00 hyperion kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 0000000000000029
mai 17 10:23:00 hyperion kernel: R13: 0000000000000000 R14:
00007fd71a90dcc0 R15: 0000000001bd21c0
mai 17 10:23:00 hyperion kernel:  </TASK>
mai 17 10:23:00 hyperion kernel: ---[ end trace 0000000000000000 ]---
mai 17 10:23:00 hyperion kernel: ------------[ cut here ]------------
mai 17 10:23:00 hyperion kernel: WARNING: CPU: 0 PID: 612 at
fs/dcache.c:365 dentry_free+0x5f/0x70
mai 17 10:23:00 hyperion kernel: Modules linked in: xt_conntrack
xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype
iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc>
mai 17 10:23:00 hyperion kernel:  cfg80211 rfkill fuse crypto_user
bpf_preload ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
usbhid nvme xhci_pci crc32c_intel nvme_core xhci_pci_renesas
mai 17 10:23:00 hyperion kernel: CPU: 0 PID: 612 Comm: python3
Tainted: G        W         5.17.7-arch1-2 #1
fe265fe1a78e524d12fe011a47a592e490cc7efb
mai 17 10:23:00 hyperion kernel: Hardware name: Fanless Mini PC
Quieter2/Rev GMLR1 1.10, BIOS 17.10 11/04/2021
mai 17 10:23:00 hyperion kernel: RIP: 0010:dentry_free+0x5f/0x70
mai 17 10:23:00 hyperion kernel: Code: c7 b0 00 00 00 48 c7 c6 00 f5
33 ab e9 da 32 de ff f0 ff 48 f0 75 d0 48 81 c7 b0 00 00 00 48 c7 c6
d0 f4 33 ab e9 c1 32 de ff <0f> 0b eb ac 66 66 2e 0f 1f 84 00 00 00 00
00 66 90 0f 1f 44 00 00
mai 17 10:23:00 hyperion kernel: RSP: 0018:ffffc31c80b6bbf8 EFLAGS: 00010286
mai 17 10:23:00 hyperion kernel: RAX: 000000000000800c RBX:
ffffa0e004181b40 RCX: 0000000000000027
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000001 RSI:
0000000000000001 RDI: ffffa0e004181b40
mai 17 10:23:00 hyperion kernel: RBP: ffffa0e00e13b600 R08:
0000000000000000 R09: ffffc31c80b6ba10
mai 17 10:23:00 hyperion kernel: R10: ffffc31c80b6ba08 R11:
0000000000000003 R12: ffffa0e004181b98
mai 17 10:23:00 hyperion kernel: R13: ffffa0e00e13b600 R14:
ffffa0e003518eb0 R15: ffffa0e00ee2f180
mai 17 10:23:00 hyperion kernel: FS:  00007fd71aca3740(0000)
GS:ffffa0e07bc00000(0000) knlGS:0000000000000000
mai 17 10:23:00 hyperion kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
mai 17 10:23:00 hyperion kernel: CR2: 00007fd71a90e1b0 CR3:
0000000112306000 CR4: 0000000000350ef0
mai 17 10:23:00 hyperion kernel: Call Trace:
mai 17 10:23:00 hyperion kernel:  <TASK>
mai 17 10:23:00 hyperion kernel:  __dentry_kill+0x135/0x170
mai 17 10:23:00 hyperion kernel:  dput+0x13e/0x310
mai 17 10:23:00 hyperion kernel:  proc_invalidate_siblings_dcache+0x133/0x150
mai 17 10:23:00 hyperion kernel:  release_task+0x382/0x530
mai 17 10:23:00 hyperion kernel:  wait_consider_task+0x4e8/0xa80
mai 17 10:23:00 hyperion kernel:  do_wait+0x16b/0x2f0
mai 17 10:23:00 hyperion kernel:  kernel_wait4+0xb4/0x150
mai 17 10:23:00 hyperion kernel:  ? thread_group_exited+0x50/0x50
mai 17 10:23:00 hyperion kernel:  __do_sys_wait4+0x9f/0xb0
mai 17 10:23:00 hyperion kernel:  do_syscall_64+0x58/0x80
mai 17 10:23:00 hyperion kernel:  ? do_user_addr_fault+0x1d8/0x680
mai 17 10:23:00 hyperion kernel:  ? exc_page_fault+0x71/0x170
mai 17 10:23:00 hyperion kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
mai 17 10:23:00 hyperion kernel: RIP: 0033:0x7fd71ad71207
mai 17 10:23:00 hyperion kernel: Code: 89 7c 24 10 48 89 4c 24 18 e8
95 9b fb ff 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c
24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24
10 e8 c5 9b fb ff 8b 44
mai 17 10:23:00 hyperion kernel: RSP: 002b:00007ffe0fcd0140 EFLAGS:
00000293 ORIG_RAX: 000000000000003d
mai 17 10:23:00 hyperion kernel: RAX: ffffffffffffffda RBX:
0000000001bd21c0 RCX: 00007fd71ad71207
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000000 RSI:
00007ffe0fcd017c RDI: 0000000000000029
mai 17 10:23:00 hyperion kernel: RBP: 0000000001bd21c0 R08:
0000000000000000 R09: 0000000000000000
mai 17 10:23:00 hyperion kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 0000000000000029
mai 17 10:23:00 hyperion kernel:  ? exc_page_fault+0x71/0x170
mai 17 10:23:00 hyperion kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
mai 17 10:23:00 hyperion kernel: RIP: 0033:0x7fd71ad71207
mai 17 10:23:00 hyperion kernel: Code: 89 7c 24 10 48 89 4c 24 18 e8
95 9b fb ff 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c
24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24
10 e8 c5 9b fb ff 8b 44
mai 17 10:23:00 hyperion kernel: RSP: 002b:00007ffe0fcd0140 EFLAGS:
00000293 ORIG_RAX: 000000000000003d
mai 17 10:23:00 hyperion kernel: RAX: ffffffffffffffda RBX:
0000000001bd21c0 RCX: 00007fd71ad71207
mai 17 10:23:00 hyperion kernel: RDX: 0000000000000000 RSI:
00007ffe0fcd017c RDI: 0000000000000029
mai 17 10:23:00 hyperion kernel: RBP: 0000000001bd21c0 R08:
0000000000000000 R09: 0000000000000000
mai 17 10:23:00 hyperion kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 0000000000000029
mai 17 10:23:00 hyperion kernel: R13: 0000000000000000 R14:
00007fd71a90dcc0 R15: 0000000001bd21c0
mai 17 10:23:00 hyperion kernel:  </TASK>
mai 17 10:23:00 hyperion kernel: ---[ end trace 0000000000000000 ]---



HCI Config :

hci0: Type: Primary  Bus: USB
BD Address: DC:21:48:2B:00:BF  ACL MTU: 1021:5  SCO MTU: 96:6
UP RUNNING
RX bytes:149901 acl:968 sco:0 events:11514 errors:0
TX bytes:74183 acl:34 sco:0 commands:6840 errors:0

Controller :

[bluetooth]# show
Controller DC:21:48:2B:00:BF (public)
Name: hyperion
Alias: hyperion
Class: 0x0000010c
Powered: yes
Discoverable: no
DiscoverableTimeout: 0x000000b4
Pairable: yes
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
Modalias: usb:v1D6Bp0246d0540
Discovering: no
Roles: central
Roles: peripheral
Advertising Features:
ActiveInstances: 0x00 (0)
SupportedInstances: 0x05 (5)
SupportedIncludes: tx-power
SupportedIncludes: appearance
SupportedIncludes: local-name


-- 
Serge.
