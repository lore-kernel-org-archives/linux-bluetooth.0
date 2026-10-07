Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45A395243
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349167; cv=none; b=hmjOUfaloJI1rvyagN3jU/vMo1nqKmbBH5LZTuznVlQjWjkLUKTER5of9gsU5/ugmY9BvScUXbLUrTApPXGyZ8gySxfTOWxB6diDmJ2pBiB/z1nKom47YXAvHwuA8nu6Tvk7yHGJEDWU7+TqtYBmd+4u8+HjEqDBKCwRi2JxlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349167; c=relaxed/simple;
	bh=cmv7oI2/bDvRK9WWVgvBoNtGDO0YcNaZHGbrtucTjaw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bafRntmHChF84nsiStqa4qegXYA31bPsOyyAONsplHcOIEorCw+9JgdaWOYYn5+vwr2uXNkt9CAvG2x0yjvsOKKzBKCuEmo0DgS3LH4ea/sLziqTnXKwBT3VYvXgt3gUWkifpBo8nPFLmZxgFQPeXed9joRIdLJIdh3NQpW+qrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-82285c64cacso5468004a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 21:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791349165; x=1791953965;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bx/MgvK5FD8SdM6rN05qOM5Yx2ntRi64Zptl1pPCoQ=;
        b=z+LtyMGxUOc6QiP88EzOyMWLp4XH1LqFS6wJtQgfQr62FlhaliqyWFRexX9LeqTEYy
         e5hM9Cz/1SPA9d9zzmG06hcbnSsG3Yr0L3OUr7LmO/xXDu/MRz9UKj7mqEgnf5C8gkAB
         oiZnJg2EnNyeVI0/5GaXt86AcY1WSCD5wXaB4enqKGqKFWAIfyQUcYvHh1dQqDPJG+7D
         zxyUiHiWGWks7cPwJndIJX6wpbHnzmJ9+e62gddl+AxyyB+oWIjvB3veJDQaxjqvHGTZ
         RfhUkbi3WNYsV5kN0wZzfzu+AufQHplsDUR8XotOPFymMpxC4QeORw5RhObAGlkwHBPj
         M/NA==
X-Gm-Message-State: AFuF++l9ZHO2lxYxp27wpa+zMxlNkE7Rinx/mivQ1R5EClKzNI7oHf3m
	ZqFXeGI15/GB4gkpTnRvJcPOSsZaXBVdXTFVTUy3Yjp8h6Kv7FksSjzbcISXpPZJd1anN5ptSu/
	jZMYGGkso0uPgSFE87XkO0O6+ft1mbjNLvfHaOMjJ2Vxzbt+aKizEgRJapdE=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f2b:b0:4d5:27da:a498 with SMTP id
 5614622812f47-4fc4648102cmr1525192b6e.50.1791349165105; Tue, 06 Oct 2026
 21:59:25 -0700 (PDT)
Date: Tue, 06 Oct 2026 21:59:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac5d1ad.353c8d8e.177895.000d.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_recv_frame (2)
From: syzbot <syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5e0f8396d480 Merge tag 'hid-for-linus-2026100201' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16583b15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b924f079099ba6e
dashboard link: https://syzkaller.appspot.com/bug?extid=2344fb8002f3ef5b1712
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-5e0f8396.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc2553b94d4a/vmlinux-5e0f8396.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a71fb7875957/bzImage-5e0f8396.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_rx_work on wq hci0
WARNING: kernel/workqueue.c:2353 at __queue_work+0xd83/0x10d0 kernel/workqueue.c:2352, CPU#0: syz.0.0/5329
Modules linked in:
CPU: 0 UID: 0 PID: 5329 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__queue_work+0xd9f/0x10d0 kernel/workqueue.c:2352
Code: 49 81 c7 70 01 00 00 4c 8d 35 ad f3 ee 0e 48 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 3b 5a ab 00 49 8b 75 18 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8
RSP: 0018:ffffc9000dddfaf8 EFLAGS: 00010046
RAX: 1ffff11002519978 RBX: dffffc0000000000 RCX: ffff8880003a8000
RDX: ffff88804395a970 RSI: ffffffff8ad8e820 RDI: ffffffff907d5aa0
RBP: 0000000000000000 R08: ffff8880128ccbaf R09: 1ffff11002519975
R10: dffffc0000000000 R11: ffffed1002519976 R12: 0000000000000008
R13: ffff8880128ccba8 R14: ffffffff907d5aa0 R15: ffff88804395a970
FS:  00007f33daf926c0(0000) GS:ffff88808c2bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f33d2a07c00 CR3: 00000000439fd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2501
 queue_work include/linux/workqueue.h:700 [inline]
 hci_recv_frame+0x61e/0x7c0 net/bluetooth/hci_core.c:2946
 vhci_get_user drivers/bluetooth/hci_vhci.c:530 [inline]
 vhci_write+0x35d/0x4a0 drivers/bluetooth/hci_vhci.c:626
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33deb5e98e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f33daf91f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f33daf926c0 RCX: 00007f33deb5e98e
RDX: 0000000000000007 RSI: 0000200000000400 RDI: 00000000000000ca
RBP: 00007f33dec3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33dee26308 R14: 00007f33dee26270 R15: 00007ffd8d2ee0e8
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 81 c7 70 01 00 00 	add    $0x170,%r15
   7:	4c 8d 35 ad f3 ee 0e 	lea    0xeeef3ad(%rip),%r14        # 0xeeef3bb
   e:	48 89 f8             	mov    %rdi,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  19:	74 05                	je     0x20
  1b:	e8 3b 5a ab 00       	call   0xab5a5b
  20:	49 8b 75 18          	mov    0x18(%r13),%rsi
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 89 e8             	mov    %r13,%rax
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  3a:	74 08                	je     0x44
  3c:	4c 89 ef             	mov    %r13,%rdi
  3f:	e8                   	.byte 0xe8


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
