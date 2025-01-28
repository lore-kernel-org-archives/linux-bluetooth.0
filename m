Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C671E521
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056201; cv=none; b=evklH9YaxMo/g1BT3Dg2HZs7XuE6TB+LSIUbrKRpq8nBebvZph8qtfjl6RZTvj9dxCbAihMAnYrWcTCuemm2uCRDt0a5AnLeYsx7ixuTLkRJYzJOkMUGAZOd4xaPet/eoQ9SKp6ZiacaJF1qsDXYMdBKWpr6gmUOkLpjG0TthF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056201; c=relaxed/simple;
	bh=DnDEz+GW0Zk/oTo/aTIblUcYo37QIm2lNijNBeTlCbo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K0Gta2vUJF0OD0tIHS44DQuYhWqcBRn4GqRJuBDgGqGE6r/8vCecj985rMuh1PM7Krf6Ha8poEk13UYQ5z0GKh3fN4HcwJbOFBnzzUTryVL1sQHFkopPG7jEJTF97r3YibNv1g9pvYa2PgxRIIf3gBnzgHGdcUbOW3q2ZOMN2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ac005db65eso44384945ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 01:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738056199; x=1738660999;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnikXfM5QULiaNgL95zpXZA4mm+I/t43JGdmFYhkTls=;
        b=MA5sEhKkmYCgF3FwMRuWVlwqF9w4KE7jZDdeD5K5Lq6iOUvFqEZ/IphPp04aiVLx6X
         9t5ZduSY44VZNXNr5nZGGvnge2NIci1HWnYNeq1uw3Cy4zd2wOK5qtWnOO3ZC59XjNtg
         aftqm6cdcCxo2TcWVpdPX60bM7nqYu0vu2GvVh7TDSN+AXNnx0UdBJUKUABGSRO17wF8
         EBVD+mAHF9KLzApWP9pNcMTF15DTRyzCJ/NsWeYp/CGASNPqdNBwaALA+d0/slJxrKT7
         9qlbFte/YOxcrUQp3l9O93ClqLgu+wHWItIY5v220m9FIcuDI8g1G2TZr2MsLjtx67kI
         5umw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKDyFdTBbHZemqMC6Vn3gXjcDY19s+2MLQRo7km6draBNgPQcfALr7/0qg0sVvVLDYKAi+WZ0K8UqlXluHyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuSY0wZ5CDxa/85KmOkD1oqC8ARJwUFlo7PoqGRvFv/U7agfX
	+4dsrrCfkD/+6P1w5XqSV5UbAzCmty6IpehqkjkgJi6rWCP8BtIlOOTDQAAjV/ykOQ4O6ClrmVA
	sIYGCNma1dHe9MH18OHPs8/CnS6xcs0Tb0OFYD8oKB15sr3hdK4Ib9VQ=
X-Google-Smtp-Source: AGHT+IGBdjvNXrsRgxGovcM6aWf4GcjqQTn1nJ/iDLLohTYJGXbOT4wgwPKVrtwf5juitd27aI4D6VTNhGSDo0Xkq3jTTFSCXuGH
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:3ce:7852:129b with SMTP id
 e9e14a558f8ab-3cf7449ddc3mr367307805ab.20.1738056199193; Tue, 28 Jan 2025
 01:23:19 -0800 (PST)
Date: Tue, 28 Jan 2025 01:23:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6798a207.050a0220.ac840.0245.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in
 l2cap_sock_resume_cb (3)
From: syzbot <syzbot+fe280ff30bb95df1577c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8883957b3c9d Merge tag 'fsnotify_hsm_for_v6.14-rc1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13862564580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77593a73383cac88
dashboard link: https://syzkaller.appspot.com/bug?extid=fe280ff30bb95df1577c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8883957b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df6d282e0e7d/vmlinux-8883957b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a6f61832d52/bzImage-8883957b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe280ff30bb95df1577c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1699
Write of size 8 at addr 0000000000000568 by task kworker/u33:4/5957

CPU: 3 UID: 0 PID: 5957 Comm: kworker/u33:4 Not tainted 6.13.0-syzkaller-05154-g8883957b3c9d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1699
 l2cap_security_cfm+0x795/0x11d0 net/bluetooth/l2cap_core.c:7346
 hci_security_cfm include/net/bluetooth/hci_core.h:2088 [inline]
 hci_encrypt_cfm+0x1f2/0x7d0 include/net/bluetooth/hci_core.h:2136
 hci_encrypt_change_evt+0x3f3/0x1130 net/bluetooth/hci_event.c:3655
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0x9eb/0x1190 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x2c5/0x16b0 net/bluetooth/hci_core.c:4015
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
