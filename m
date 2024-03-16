Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2118E28
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Mar 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710599363; cv=none; b=XF99LEIEmQ+EYhzI5s8fNDoXMZb4oNnGEl2IwRnysWhRScdcNVK/1YJKxsCuueWus302tTm9SyLMO34YyqGz+Vc3jCkPM3h+fTCvAWiD4/WVAxUavmXrzz/tzaYt+69tuVMCODthPeLoSPvWnSatH/koVdTn4Iy/X9n3jTvny4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710599363; c=relaxed/simple;
	bh=QCwYqQjhjYC6Mtz9N2wL1v6V+ItwgozkQFWDvVwMSOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i2otlup1D3RnhRuzhnF9InFmypNNUDFyCrP7mBiR2HQK54wKYX+WmjZllHSa/SBkPwn41K+gxUIyAdHmsAQHACGjpxUuxzZ4cnWqFWrl3LN1s+8aAMlyyizGGPe++vq/0Hw4rLsML4Sr5myCTYSkMdyH+UBpZATvj4ZALJwIOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbffd468acso116885339f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Mar 2024 07:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710599361; x=1711204161;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBlxUcE/g2KRsZ0ndZ7v/yllHATvI+L45HZeDhwmPt0=;
        b=msEXDEA4ejvHOKUecxcicK3gW0hJJMD6KsM6E7wv91DZRqaFl1lgskbx+QLTrLxCUt
         EwFLTojnoiuls/XK4YPwPahAp23bFTJp1yFWj7B2I2nf5e+mgUBRHfgyDZY1dbFosuVp
         F6F1ttq3MuCab0fgxSk7CjLu/Sx8+P2nT2yzzPBRJTXJVmZBuqKooRxY1Lr6DmqUToI5
         HJToovbmuxmakjAntY7MZqn/AmJtBkb0htsznym9QYcTo/sGZK9odEM7zzFmjMacIJ8+
         HEyVDSwWG6ji00f+VTS9wTwfrlLW93BROAwZGaQDmb+FdnCRGhLzXxDU3yopBy8ot53B
         kKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGbmu50Cb18OU5xs8TbcFeMcS/EaLYfyhmrcWxJEoohDTZwS8QKARzhHjCGdhuVL/fttim18Qev9xGCSuOe8HxU7vjKHTXHMq/eEf1S9TL
X-Gm-Message-State: AOJu0Yz/Ue1STcn8G7UIfa6xbkzsPCukG3R1TX9vqz5qiXifIAzH+dlO
	+XNJvypg+33/MsojINrneF13XDgWP4skn37THWR3sFw6KJ4W4fzGDPslNMjr96zgKkGkXEvLTCJ
	6ympCj70glJvNH1ICNLBuKVTKEkZWbkEOM92RtTwGcFcCVsmF+o0csAU=
X-Google-Smtp-Source: AGHT+IGrWyxEpLJVniT1wbHec5IzgHRGHg+9Q0HHpf/n9TytwpRZjKBgQTUcSnuNlUBopYejXE7drX9Z3MGcsWvgScOsmgQt0tkm
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349e:b0:476:fa0b:c9b9 with SMTP id
 t30-20020a056638349e00b00476fa0bc9b9mr490678jal.4.1710599361429; Sat, 16 Mar
 2024 07:29:21 -0700 (PDT)
Date: Sat, 16 Mar 2024 07:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a975c0613c7f382@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
From: syzbot <syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9187210eee7d Merge tag 'net-next-6.9' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122856fa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=222448ff79dba2ea
dashboard link: https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98c1ea7ddb95/disk-9187210e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/343c5524f68f/vmlinux-9187210e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c0c68b0ee90/bzImage-9187210e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com

Bluetooth: hci0: Opcode 0x0c03 failed: -110
============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05202-g9187210eee7d #0 Not tainted
--------------------------------------------
kworker/u9:5/13642 is trying to acquire lock:
ffff88803165d148 ((wq_completion)hci0){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x6e/0x120 kernel/workqueue.c:3901

but task is already holding lock:
ffff88803165d148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x1296/0x1a60 kernel/workqueue.c:3229

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)hci0);
  lock((wq_completion)hci0);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u9:5/13642:
 #0: ffff88803165d148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x1296/0x1a60 kernel/workqueue.c:3229
 #1: ffffc90004d47d80 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work+0x906/0x1a60 kernel/workqueue.c:3230

stack backtrace:
CPU: 0 PID: 13642 Comm: kworker/u9:5 Not tainted 6.8.0-syzkaller-05202-g9187210eee7d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: hci0 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 touch_wq_lockdep_map+0x78/0x120 kernel/workqueue.c:3901
 __flush_workqueue+0x129/0x1200 kernel/workqueue.c:3943
 drain_workqueue+0x18f/0x3d0 kernel/workqueue.c:4107
 destroy_workqueue+0xc2/0xaa0 kernel/workqueue.c:5673
 hci_release_dev+0x14e/0x660 net/bluetooth/hci_core.c:2808
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:94
 device_release+0xa1/0x240 drivers/base/core.c:2499
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3747
 process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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
