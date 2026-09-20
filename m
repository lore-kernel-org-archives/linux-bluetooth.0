Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D4449EA4
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920515; cv=none; b=lAGPelwmerIMOGrU+45d+VyU9yGIQijyUCNOSvlQQCRV283mbqffHQEbhbqRjQ1HY9lDU2A+tR6pQp3W3ebRlooKhp74h10dtg/u8Z3fCKDfwloyw/POZnKvRz15cTfSuHsuamnOEQ0i+TovL6+vNM6Yd2K/2ngC5gAICM+ed5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920515; c=relaxed/simple;
	bh=MyZJM2s0md5g5nU7jqiRA+LaVbZsPvw5V4RaKGI4+Zg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s1GFkExscTYSreeGszZ61rGej8yHD1fEMwwm9vgaZU1RoXwYJbkL4kHWODctg4hhDqKN73jdVClO6UBIQydS4EKyV7S88/eWRGbzoZw5XjHQQCC/iVpLreGWMG7potSvfRTIDVXBUHVgYDk+jL58sQr5ico0ylxMQ/9TXcJFLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f9.google.com with SMTP id 46e09a7af769-7f4e9ec63a7so591932a34.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 09:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789920512; x=1790525312;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5fee2tv0IEtrMhAl5f2wQUWwWw9Ak89uv8tCH2ya5U=;
        b=kU2LT/cW0UdKRcb1YUyyGJUxKcmx+ZGVfSXTMP1YvLM7zlHuEBpPeA+UCSQDk5tfHn
         gZiU5e85r9ZQ+LJAHWBfqMRUmNwwMdHCBrnOb2dyFdkQg2JDWuP3IgLwqgcvc0e4mTf9
         6S2RFe2lVts4sHZktqtm2tS4L2tI9gY9s4n0OnTiuKY2UNN4iLTtLpmwjyKbgHb0Y3KK
         34csZPu9P3+BqLZZ+sk0TbpTXEpY1oOeWjs6T9EHkvcqIci0tpnJhbZ7qICPN9TvidMi
         cVvWDGNBSR50C1f/ImykONa1Lr7nWpyzDgbkylEtuBgAJ8L8r/ptNTCkKLFh5C2La6ac
         RW2g==
X-Gm-Message-State: AFuF++nty3vuySpcsBIM/BiurkDW5qss/ZdN7d11Ry5lgshQcJctt4hF
	zhbo1RcL4umwNYt/eFhforN8Px5VTaVDjkdbGyGrQM9mkwz/oj4MjXQNehT7sexOOlbjfSv1pbO
	my6aX/vkSd9kprR3EgxAjxoeDJwSOxmWXHwHe/uwCdSyRqV3C2z8TCb2+sXmrvg==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2012:b0:6b9:542c:8650 with SMTP id
 006d021491bc7-6ca9aa400f9mr6955504eaf.23.1789920512408; Sun, 20 Sep 2026
 09:08:32 -0700 (PDT)
Date: Sun, 20 Sep 2026 09:08:32 -0700
In-Reply-To: <6a92fadc.08e933ee.dbf97.008f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab00500.e548f532.1ca396.000d.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_security_cfm
From: syzbot <syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, mikhail.v.gavrilov@gmail.com, 
	nicoyip.dev@gmail.com, pav@iki.fi, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    518e5b794c06 Merge tag 'for-7.3-rc3-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137ba4c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=74071deb72339c215b2e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14809525580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a3ff9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e68973061b3/disk-518e5b79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a77cf97afca/vmlinux-518e5b79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70ecbc754c60/bzImage-518e5b79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u9:1/4919 is trying to acquire lock:
ffffffff90f828c0 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222

but task is already holding lock:
ffffffff90f55cc0 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_encrypt_cfm+0x11b/0x740 include/net/bluetooth/hci_core.h:2239

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       hci_connect_cfm include/net/bluetooth/hci_core.h:2163 [inline]
       hci_remote_features_evt+0x485/0x9b0 net/bluetooth/hci_event.c:3786
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4053
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&hdev->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       l2cap_chan_connect+0xac/0x2110 net/bluetooth/l2cap_core.c:7281
       l2cap_sock_connect+0x37a/0x770 net/bluetooth/l2cap_sock.c:255
       kernel_connect+0x107/0x160 net/socket.c:3755
       rfcomm_session_create net/bluetooth/rfcomm/core.c:808 [inline]
       __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:385 [inline]
       rfcomm_dlc_open+0x838/0xac0 net/bluetooth/rfcomm/core.c:428
       rfcomm_sock_connect+0x42c/0x690 net/bluetooth/rfcomm/sock.c:419
       connect_socket net/socket.c:2141 [inline]
       connect_socket net/socket.c:2131 [inline]
       __sys_connect_file+0x146/0x1a0 net/socket.c:2166
       __sys_connect+0x141/0x170 net/socket.c:2183
       __do_sys_connect net/socket.c:2189 [inline]
       __se_sys_connect net/socket.c:2186 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2186
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rfcomm_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222
       hci_encrypt_cfm+0x18e/0x740 include/net/bluetooth/hci_core.h:2242
       hci_encrypt_change_evt+0x3e1/0xfb0 net/bluetooth/hci_event.c:3715
       hci_event_func net/bluetooth/hci_event.c:7887 [inline]
       hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
       hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4053
       process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
       process_scheduled_works kernel/workqueue.c:3479 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(rfcomm_mutex);

 *** DEADLOCK ***

locks held by kworker/u9:1/4919: 4, last CPU#1:
 #0: ffff88807ad07140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc90002657d08 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff8880700480b8 (&hdev->lock){+.+.}-{4:4}, at: hci_encrypt_change_evt+0x83/0xfb0 net/bluetooth/hci_event.c:3627
 #3: ffffffff90f55cc0 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_encrypt_cfm+0x11b/0x740 include/net/bluetooth/hci_core.h:2239

stack backtrace:
CPU: 1 UID: 0 PID: 4919 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2026
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 rfcomm_security_cfm+0x3f/0x4b0 net/bluetooth/rfcomm/core.c:2222
 hci_encrypt_cfm+0x18e/0x740 include/net/bluetooth/hci_core.h:2242
 hci_encrypt_change_evt+0x3e1/0xfb0 net/bluetooth/hci_event.c:3715
 hci_event_func net/bluetooth/hci_event.c:7887 [inline]
 hci_event_packet+0x8e9/0xcd0 net/bluetooth/hci_event.c:7938
 hci_rx_work+0x451/0xfc0 net/bluetooth/hci_core.c:4053
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
