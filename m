Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3ED271
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Apr 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343730; cv=none; b=c0FVushyfNYHQIOa7wZinAeYW3CzMlot4TiEPmiXR4K8UJhcSBTxvaMDjbNH6UlHOxZid4GTuzVOVYWJG1k7qroOUklJpwdIj6AHT61Ku9pBPPFc5cMsx78KytXd9L9kOCl126tyWX0GS9Zd2QruXstFv9hz+RWBAF6FVM2kDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343730; c=relaxed/simple;
	bh=8Jo1RShjteksnEB4+jo8ht85tb2ANBTXBETSvlVt/1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cHtnYySt9ITwUPTcTY018WLd2MqcB0nR/0TkVYJjEkK4xSIDsWShDrmY0hFytBa9yhiRePmR5U2J0ve5dmdUn+aLi9NVvdisucneDrgd3J1e3EAOf0RBdZfzmLw5xeC08pDUArDjXo3LP0bNpZz5O5CkVvrfoQIduOSOd6VdMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41c44da7so477029739f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Apr 2024 15:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343728; x=1714948528;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMIv9xHavZypaGzX7F87Hk5huAY3FS4SvdQBRrW3QXE=;
        b=B2E7b+JcmEmqFi5rPbnOz0MC+P6CzVdUDIrrzRko3yZKgkoBgAE438mRx7sdANylwB
         iXwdnBTOoOI9fBQrQsXf77/9cNSuGd+TLZwWS9d2uIoHZh/V+VRZ3PyfhTYZRKcyQVLZ
         mEXh+eKptWUiLoBYhPeJAkx0xBn9WchuuOCjtJ4soy/fW/9cwGK7zQRE+RaC62SVTasN
         eIjReMNmLiP0G0f4XDaO1HcJMAaC0qzOephhz9tWkeJwckDUVVxe/mdg4NhB2b2GkC3v
         tSafBZlWxMCG2pzNyVqon9PPdeV/W0iLGjKpGTEEgivogFftE7Qw6q3dOS9KLs/RbSdg
         AfiA==
X-Forwarded-Encrypted: i=1; AJvYcCVyX1mYikjTLFaXBCq7S+Y1D/87dP/t0jj3FX1MmmxjDPopC4ytnzZD0EEdczWidxWpYXNgAW3FfpGBXTFLB0BqIiA8CY1c1a2zlV9l8h/7
X-Gm-Message-State: AOJu0Yzt8ka6sy/NUx25aLYjAD+TNaVB0crsQAmUW08gcfajN8aEY3Aa
	wdlMsg568QlKuthzRdoQHQqsAIR2jiQxxFnvcv1BofZSlbD2Y0mab8aDui5QJZVRm+jkASsw5X9
	QSWHBZxPDuoeglwR5P3xNA7xa7LtcWGH5ZnbQA8d4BZ1c/hiYIb4K4cw=
X-Google-Smtp-Source: AGHT+IETouaKHH/n4AvjJCt4Dsf7WQMcpa/O6j55qJ3B+sOdMAk+12aSPdVFKe2xKuOooxKLV+ZZ6nVzWsyl1Vg+oecaYnahZRR2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:36c:2976:3012 with SMTP id
 j14-20020a056e02154e00b0036c29763012mr358151ilu.2.1714343727960; Sun, 28 Apr
 2024 15:35:27 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:35:27 -0700
In-Reply-To: <0000000000007e812306170008d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eda1e806172fc058@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
From: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b60228980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=c55f7bc8d4809b2bad59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1590bcf8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349ee9b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5175af7dda64/disk-bb7a2467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70db0462e868/vmlinux-bb7a2467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3217fb825698/bzImage-bb7a2467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com

Bluetooth: hci0: Opcode 0x0c1a failed: -110
Bluetooth: hci0: Error when powering off device on rfkill (-110)
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-next-20240426-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor143/5093 is trying to acquire lock:
ffff88807643c8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
ffff88807643c8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
ffff88807643c8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4113 [inline]
ffff88807643c8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

but task is already holding lock:
ffff88807643d060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x28/0x90 net/bluetooth/hci_core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->req_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:309
       process_one_work kernel/workqueue.c:3222 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3303
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3384
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
       start_flush_work kernel/workqueue.c:4139 [inline]
       __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
       hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
       hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
       hci_dev_do_close+0x30/0x90 net/bluetooth/hci_core.c:561
       hci_rfkill_set_block+0x232/0x300 net/bluetooth/hci_core.c:992
       rfkill_set_block+0x1f1/0x440 net/rfkill/core.c:346
       rfkill_fop_write+0x5bb/0x790 net/rfkill/core.c:1305
       do_loop_readv_writev fs/read_write.c:764 [inline]
       vfs_writev+0x733/0xbe0 fs/read_write.c:973
       do_writev+0x1b1/0x350 fs/read_write.c:1018
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->cmd_sync_work));
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->cmd_sync_work));

 *** DEADLOCK ***

3 locks held by syz-executor143/5093:
 #0: ffffffff8f8b13e8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1a9/0x790 net/rfkill/core.c:1297
 #1: ffff88807643d060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x28/0x90 net/bluetooth/hci_core.c:559
 #2: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4113 [inline]
 #2: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

stack backtrace:
CPU: 0 PID: 5093 Comm: syz-executor143 Not tainted 6.9.0-rc5-next-20240426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
 start_flush_work kernel/workqueue.c:4139 [inline]
 __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
 hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
 hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
 hci_dev_do_close+0x30/0x90 net/bluetooth/hci_core.c:561
 hci_rfkill_set_block+0x232/0x300 net/bluetooth/hci_core.c:992
 rfkill_set_block+0x1f1/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x5bb/0x790 net/rfkill/core.c:1305
 do_loop_readv_writev fs/read_write.c:764 [inline]
 vfs_writev+0x733/0xbe0 fs/read_write.c:973
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22b080b5d9
Code: 48 83 c4 28 c3 e8 47 1d 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7aee1ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f22b085b468 RCX: 00007f22b080b5d9
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007fff7aee20f0 R08: 00007f2200000001 R09: 00007f2200000001
R10: 00007f2200000001 R11: 0000000000000246 R12: 0000000000000003
R13: 00007fff7aee20c0 R14: 0000000000000001 R15: 00007fff7aee20f0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
