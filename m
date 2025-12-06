Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5518DB35
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987924; cv=none; b=WKvAlBNQ16JPua9wHwhJS7PXUSmxN92RdyzwjNd7l0Dt5FA9QF4UbmeZvnWeA3TL2LfpJPNCbk7nv018XFrnU0We1sJTFHjLKYNUr0hlOSB+eBtYgYJUcC5Rc5bcT7rPfw0b+PEIbKm7hX5sd/zt50N4rsntZPPXn9StnqFrGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987924; c=relaxed/simple;
	bh=PygA9F4w9kDDEbkivfJhU39iaA2NDuaJ2/ghDyrDf58=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GCtg/ud+2ngYUtc4PQionOr5jN8HoByZqYx4hUAB/toajQkZbPthpZ2Ta7A8ZgwImM1HgGKUdlsVT8Ko7oeBEZG+3w3C/Y1tDknn2qkpBmC6S3L5c4MgmZQwvflkh+J2UkL1jQcE5oK1yZa1WtHvFizKTOjITNkaZCVxhBvTgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6579875eaa2so3533298eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 18:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764987922; x=1765592722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYgRIi+uMi1BlSZHiAIHkVoXNhvbpwhjPSto8JBqqGw=;
        b=P3RotOg9S0IES8ZWA8HWqglagnAv9tU82g+9V/ngTIk59RVwv5+AmhtYbPQaucbUdq
         JiVBXWzA22Ne53TWhi1tT1LJDbnqaIAraSN/dBr90OZs4LHZOZtFU6RJDzg+jJQbjS3w
         ah7FnFkG1J7lZDUHbagl363VYpUjpOHyvnQiH9O2NIr0Lxsv5hZPZD2bd8sHdquXc6yH
         sHB2nA/jzCS0YIA+sToT2hi+LE2AupVjLYh7XQHAKcK481XYTOsYSuxt2nG5G6LZO5fp
         eaIrNd+W380tqspP4SJvHJS/os9etvn9jdcGNB0mgvPTttVjhjrqfsPYaYmZtx196Irb
         ThnQ==
X-Gm-Message-State: AOJu0YyPX7ncyjZs3nm65qjaTtbSpxc9E8zfUxD4hAMla59vFGs71Xie
	9ut5LMpe9TwK1jPyRGpn3TzVyUgPwNw8lPCmc+biUxoJW9I0aEfJGSf20R4Pg84kXzq3/0WO/Nj
	dx+qcWwiNRGJpBR7WQnYvvCBoH3+efYWQaqDc1Jz0yxHZbvz7A7+pNq0SL55NKQ==
X-Google-Smtp-Source: AGHT+IEUuZDWDmEMmwk8RzegtbA4EcQ3+G6rjEY8bprn/pESbVDhXqt/AlLCnNpUWkgbnaFXbpBhPU9EIqcPAHR9FDa5eKEokOjy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:809:b0:659:9a49:8fd8 with SMTP id
 006d021491bc7-6599a99461emr547345eaf.81.1764987921934; Fri, 05 Dec 2025
 18:25:21 -0800 (PST)
Date: Fri, 05 Dec 2025 18:25:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69339411.050a0220.3a66f.0007.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in get_signal (2)
From: syzbot <syzbot+edae0f1918326febf965@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a242b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec890b8333fce099
dashboard link: https://syzkaller.appspot.com/bug?extid=edae0f1918326febf965
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16756512580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bcc6eb60940/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/895bc1bfae48/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48f15e4679f3/bzImage-7d31f578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edae0f1918326febf965@syzkaller.appspotmail.com

INFO: task syz-executor:5969 blocked for more than 143 seconds.
      Not tainted syzkaller #0
task:syz-executor    state:D
Call Trace:
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
 __flush_work+0x9b9/0xbc0 kernel/workqueue.c:4281
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac0ed9148a
 #2: ffff88807c668ec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d3/0x400 net/bluetooth/hci_sync.c:331
3 locks held by kworker/u9:3/5978:
 #0: ffff888057c3e948 ((wq_completion)hci6){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3236
 #1: ffffc9000412fb80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3237
 #2: ffff88807ef20ec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d3/0x400 net/bluetooth/hci_sync.c:331
3 locks held by kworker/u9:4/5979:
 #0: ffff88801e7c2148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3236
 #1: ffffc900040afb80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3237
 #2: ffff888054900ec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d3/0x400 net/bluetooth/hci_sync.c:331
3 locks held by kworker/u9:5/6113:
 #0: ffff8880296d3148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3236
 #1: ffffc90002f17b80 (
(work_completion)(&hdev->cmd_sync_work)
){+.+.}-{0:0}
3 locks held by kworker/u9:9/11288:
 #1: ffffc9000411fb80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3237
 #2: ffff888030d98ec0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1d3/0x400 net/bluetooth/hci_sync.c:331
3 locks held by kworker/u9:10/11292:
 #0: ffff88801e7c1148 ((wq_completion)hci4#2){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3236
 #1: ffffc9000c69fb80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3237
 #2: ffff8880549000c0 (&hdev->lock){+.+.}-{4:4}, at: hci_event_packet+0x162/0x1260 net/bluetooth/hci_event.c:7736
7 locks held by kworker/u9:11/12552:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
