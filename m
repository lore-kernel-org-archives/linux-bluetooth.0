Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1D7FBAC
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Aug 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723916790; cv=none; b=jJzxtn9XU+dxFXH4lyXnVTeGdfUszClte9wH9w1w0kZyEa6oTzzrF2Qv5B8L0j1MRtnp9GBZemVi9jituHrVhEAfvBEnfBfT3+PYPAP1+Cq9U0CTd9i1Znbn0EM4l4htD0iDdr1UD740JWdcFuRKOk5MrkzZPfUVZPkIeDQtF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723916790; c=relaxed/simple;
	bh=W/+uVizMVR9vGpQxbGVag0BW2mj4QMLV24SQfH30w9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PceOskT0L4o8LDIXBSjwqYUIXtm6fiVMe9fuBgaG5AAbSxDFjhkCLZd1ylxykrXTk7J2iAIMi9N1tkBbmKXlqZvVk4jlYI5vyfNhYmEVZ/MnU0S+IJYVWlXD+gTgRt2mVYAPI5hyZyRfnlCm3egVbEkyd+bDrQGP5MtQizRjN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d3325ba79so8948845ab.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Aug 2024 10:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723916788; x=1724521588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebWrfS+689otl4sLKCGe5obuD7mBCfaUX+ut3RYyWlU=;
        b=rJOdGn8sk85MKC7E3RIXlYQ8tB3kaGkbHmo10Id7CQwLvfzeXHTMfN8RaUp2pqy+Sb
         riMok5UpshmBsZDyk+jrvtqhDuUt7hHLGUt80Usk8wnz/DZUAhfiUm4W3+SMgAeq1qCD
         P6MQWp3fn3ekOH4pdzIofJRbY+kdCcJktEDy1A5dU82sxsRTcOzU4tOWwd4sozddXrnm
         nMF1jzZywfMkLUL72aHHxRTYit3mZJyqH2yVQmokH/ab6EtrFwrY3cI0u0lJpE5CWUXG
         hYhKUoKOE5cLp71Ts97EJYa9Y/w8zY5G7qtM5T8S578jOShZQBn/fNzCpOS8eKXqn3G3
         4wGg==
X-Forwarded-Encrypted: i=1; AJvYcCWv+D8M4vCYLTesVqiid4aE9zd6cb5n1ZS2XcaJ4uyUTeS/N5FUMRupH/C8DdEyGkWorUZTFCVq5mCfQ6l12cQ8zEHWpT0jut5hkIGG2Xo9
X-Gm-Message-State: AOJu0Yxp/4qP+IdOfXUeU9LJFJ8Lk19fkKFry314SOJleYQ6Y5jixGFm
	iFR2u2AuzBjGpHeAyuHtlSi8aGy0eQQ0C0grSvsx4GEYaOvmfh47/NGLQI3xdfBk0LzgAsZgYJJ
	Xm+cbcSqboUmlQqNge76ot1lhrAw+A+5f3Jb4DmlNPFHfLFG8OlKE5eY=
X-Google-Smtp-Source: AGHT+IFJkwRJhL/l/ms5STwnkH+kjNrJW+5nATteoNlAmTLoyGW3wzXDcOvbR+ZcsdQ9swPDGKg3LOR6H88zavPLvrcuV23rqiCf
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2207:b0:39d:300f:e91c with SMTP id
 e9e14a558f8ab-39d300fecefmr3265535ab.5.1723916787902; Sat, 17 Aug 2024
 10:46:27 -0700 (PDT)
Date: Sat, 17 Aug 2024 10:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3ff9f061fe4a709@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_del (2)
From: syzbot <syzbot+a6d9742ac04af8e8a014@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=158d4405980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc88a9f65787e86
dashboard link: https://syzkaller.appspot.com/bug?extid=a6d9742ac04af8e8a014
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ef30d34e749/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a21c2389ebfb/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9720b12c3f99/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6d9742ac04af8e8a014@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 1 PID: 6377 at lib/idr.c:525 ida_free+0x2b8/0x378 lib/idr.c:525
Modules linked in:
CPU: 1 PID: 6377 Comm: kworker/u9:2 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci3 hci_error_reset
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ida_free+0x2b8/0x378 lib/idr.c:525
lr : ida_free+0x2b8/0x378 lib/idr.c:525
sp : ffff8000a02e7880
x29: ffff8000a02e7930 x28: 1ffff000124706cc x27: 1ffff0001405cf14
x26: dfff800000000000 x25: ffff70001405cf10 x24: ffff0000e735c008
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000002000 x19: ffff8000a02e78a0 x18: 1fffe000367a49de
x17: ffff80008f3bd000 x16: ffff80008033878c x15: 0000000000000001
x14: 1fffe000367a7600 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 97b9b82baa63c900
x8 : 97b9b82baa63c900 x7 : ffff8000802aebf8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008b3800a0 x0 : ffff800124a1d000
Call trace:
 ida_free+0x2b8/0x378 lib/idr.c:525
 hci_conn_cleanup net/bluetooth/hci_conn.c:156 [inline]
 hci_conn_del+0x5c4/0xaa0 net/bluetooth/hci_conn.c:1154
 hci_conn_hash_flush+0x184/0x220 net/bluetooth/hci_conn.c:2585
 hci_dev_close_sync+0x76c/0xec0 net/bluetooth/hci_sync.c:5062
 hci_dev_do_close net/bluetooth/hci_core.c:556 [inline]
 hci_error_reset+0x108/0x35c net/bluetooth/hci_core.c:1087
 process_one_work+0x7b0/0x15e8 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3393
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 6510
hardirqs last  enabled at (6509): [<ffff8000802aec98>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1418 [inline]
hardirqs last  enabled at (6509): [<ffff8000802aec98>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5162
hardirqs last disabled at (6510): [<ffff80008b1fe010>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (6500): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (6500): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
softirqs last disabled at (6341): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
Bluetooth: hci3: Opcode 0x0c03 failed: -110
Bluetooth: hci3: Opcode 0x206c failed: -110
Bluetooth: hci3: Opcode 0x2046 failed: -110


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
