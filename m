Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFC15099C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481242; cv=none; b=onE0ZpFFz6yYvnTdFtTZGKebujDGlcCT8XJIwRKuny3rO2Rz8hanRg4moMrjguzRxn6rgsYnnTSi1aCqE46DbkzArMhPB2A2Dtk5tLE/M1lgP8Vxwfd9XXyz+R72AXwatoPtXFml6v0MQntf8nt4fRiO5nYVQSKH2561ps4UwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481242; c=relaxed/simple;
	bh=V+9VyyFEUU5Tt0/zldChMRUa7x7UuysycddEsA6gplQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zaj69+bNFnyPAL7vkg7jnD/eAJPuBatApJeFAiHzjuil0BC/ljBdwBgoLQ6L1aSZ34NyoOsif5eaUkfXogTQE2HmldnMi/l67mVTELQPUC8e4RgsdEM/oPBadS8f9TJ6KuEHKC/pWl8mKbu4ph+8HBw8RGyF8EfGQLAJ4kiNyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso555898939f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 16:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720481240; x=1721086040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PagM1HHYLYDwKyHAo5/GE81TCstWTLOvOaKxe8EMN2E=;
        b=qKiIWGYP4sxQoyBK6IKZCOr4Bx5p2WXQoqJxlaMq4pJxU7K6n+clTSR2O8/UNpbnYY
         aHkoN9b1HfY06Fp6LJJL3exynCmRAc2Mn5HGSx1QjssZsoGOLeQtI0dKhSBJ7S9g3xPY
         yZfP8DyuHcWld/JWQrLQxIkwy2r0ZiUhdK/LB7hUjfb2yDvCUdh+ZFvm5jGvpNCjpIxP
         WnaBd59oKXJmUXlRdKi5wXn3orVroFisM4xx1LZaNeQvKQby0valh8TK9iK16O8iBVrm
         E0g+rLUme1V81G1vGfkGN9C4thIVLgDvlEo/glB1+3AAJYcD8VQ4/SCzVXAl3ZgnVVco
         Peeg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Br5ImL7gJr0KshxFdE0t0Mfi1baJiGRFAKe7cn4UbNt37mWhJhIMAbIWbpH6256bTEgPmBnWPIa8SR65qXh97Y9bhwxn/7707G81Lg6B
X-Gm-Message-State: AOJu0Yx8E0xRCVN6aod1gxt1Oq8ABddV85fjEGvQAZwTREY7sALLjWJA
	O4XRZ94azsiMJI5BZU0TWUJp07BUUI9dCS6IwKUdS1r+p62DIt3uaYWwuju3o1kU+YBqOLUmmEO
	t4T2FTEMc4G2nlwE0ikY3EC9qghGzYtQLk+ChYHysLyE9UG6ah/o58wM=
X-Google-Smtp-Source: AGHT+IHP4GE2cKxixBz5JFaBEuv2wNkbPf7C3VKDUwFVLPxxU5KtaWowJms+mFYtdJyJPvGznU/vO1hi9uTCEjiAirxob37L21Ko
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:710a:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4c0b29ba495mr74461173.2.1720481240704; Mon, 08 Jul 2024
 16:27:20 -0700 (PDT)
Date: Mon, 08 Jul 2024 16:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031fb62061cc4c118@google.com>
Subject: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
From: syzbot <syzbot+733a96463546d3026b60@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6653f49e4fd Merge tag 'powerpc-6.10-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170a1059980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=733a96463546d3026b60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a56f9eb616fa/disk-c6653f49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f09515c2f1b/vmlinux-c6653f49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdc471b5cbac/bzImage-c6653f49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+733a96463546d3026b60@syzkaller.appspotmail.com

BUG: workqueue leaked atomic, lock or RCU: kworker/u9:0[53]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=hci_rx_work
1 lock held by kworker/u9:0/53:
 #0: ffff88802f56d518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff88802f56d518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff88802f56d518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x7ca/0x10830 net/bluetooth/l2cap_core.c:6830
CPU: 1 PID: 53 Comm: kworker/u9:0 Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 process_one_work kernel/workqueue.c:3269 [inline]
 process_scheduled_works+0x1121/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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
