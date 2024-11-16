Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28313A26F
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762805; cv=none; b=KS2N9qQhmHh/nmIHVHfPA+S8JCneWrcS3+3ZpsxUC5KffHcvVnHtxh0c3VrR+4fI9r+HEqWGGO4PRtTkXXqTRuZDJZKQTpRl9h0GOKDoGUlNda9LMq8QQCb1MA5dfYnBksUm0M2BnwB3uieLfJqGuCm5FkoeSolOCMQpuRqe61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762805; c=relaxed/simple;
	bh=HmIJf5oq0Ta9gbPSfpdKvplD9gOOwXRsb1Ne99WGRnc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mm85jl3uQJXlvqb2r/uwCBt5hKONwAHCIAOLxrCNqzq5mOWVnx7mALVnHh+ntgK6NgY8gTNU1mKUqWHP36pkzJDsGS5ISqhCC+TE6D8+78jkbVFd0Lh+6fGGHRDghBjQcOtu9zra1MQKzS9YGNotN4BT+Bhyi+Eoe0eNNXlnjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abe8804a5so272445739f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Nov 2024 05:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762803; x=1732367603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABsb/moOV6pCjySDHZbyYwJBpCe4I9gMuXMFEMDpgZg=;
        b=XkOkSWTwNWKMyosT9M/kvhSk5OtyHN0UNTs7aPmxJqEyqrVH63yv47eFsb1Ahila99
         9MbiKuUL1mc3aDgUpVKPSWVYvPE0pT2hqOBnPAWRyUw4SjxFvbT6EJVYGZwg3Zf0Iy/G
         6UBwKpucFHXhrfOK+D0drDRCBnzOsV4uLSj5UNAThQ6xY2lYMxOULQo5h7ILEIfHVuCS
         sdkYdeE/ioEFtlNOdfsuHF4yx+n7aY14CyQjga6t46Yw344pO4sH2L9uZhiYxLdy9yrf
         RuphRF2to8ZMuweRdpCUXKfH7iiXQRPhH4cuGGvrLFqlHKEOs+MCDEBFNvqjN/5Jrolk
         wU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVXvyHDm9bp30dmCo+sc4U/V8wwrGWsDF5mDhxsi1tGExTTq/M1M0j7A9cwh/n92X1PSFS+38NL+te4GQgLmkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0EKY7HW0RKptNAqmWH8Cmrz11mB48Suy7LIQ11DlisFEeDaU
	c3iGaaGNGzdAuK3kFfTiEhCJZc2WHSetcUsH34zCwTFhnsaMxEFWDJeLmyGSpktEe6B14eE8qNb
	83zrjgSiF59WLjeQJU3nAqsKTT0e4SIDDwU7NRZ4TlM1bZfS7+NIF4r8=
X-Google-Smtp-Source: AGHT+IHWhev16VILb5Y75Z+PMmUrYfwmu2wKvXzc/BlWClFJuE51ISU9lEJjKfGDegpW2dMWFHXrzGjnWwVwhxrrqxtGWXkcGwk0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a7480a0777mr57715705ab.23.1731762803512; Sat, 16 Nov 2024
 05:13:23 -0800 (PST)
Date: Sat, 16 Nov 2024 05:13:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67389a73.050a0220.bb738.000a.GAE@google.com>
Subject: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1357fe30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2910755fac8/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a135257837ee/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f8930906164/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_cmd_complete_evt+0xd7b/0xeb0 net/bluetooth/hci_event.c:4221
 hci_cmd_complete_evt+0xd7b/0xeb0 net/bluetooth/hci_event.c:4221
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x11df/0x1c20 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x9d1/0x11f0 net/bluetooth/hci_core.c:4031
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 hci_cmd_complete_evt+0xaf4/0xeb0
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x11df/0x1c20 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x9d1/0x11f0 net/bluetooth/hci_core.c:4031
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:494 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x127/0x900 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb2b/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5791 Comm: kworker/u9:2 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: hci1 hci_rx_work
=====================================================


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
