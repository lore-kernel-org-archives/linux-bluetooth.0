Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C62F60D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250301; cv=none; b=hE8GwD8FadMQBXjR4QtZsfPpNg+JxI/NsdAfSI2KQTJoPN6XGtt+1OP3c3IsfnuTRWeitsLJmjw2768e/IT42eWRqDMKdE1JjuM3no+9EPfWgemaShiBKPNZMmPvfESOuagIk1DPmQ8xeELV0VjwLdeLmEJkvGXVqo/7wuHrTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250301; c=relaxed/simple;
	bh=IGYKOMCOPy50tB61p5POopemwE7hkm7OiPPfqyiuf94=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lRNv06/mDucoQaulmkwzl67ZtqY8n9U9rIljfYEG/dUwGAETO9s3yfWMcImNBeXwmPjAoPuvboKAD9qbFIj3z8ur7Sziwi6pbF76XRXbaQJHLjQit89l7n8TohQCE6RcHW1YffZnuyDPR+vznSS6Is0+cZFcipuKtbH4O476wW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e56fc142e0so22640925ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 02:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250299; x=1755855099;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjffuFg+549n0bUQwtPDIk0AwZ0MovBYe9/6UTrUN54=;
        b=GP4/bZ4xGoAbESM7SjJu6A8odxsxpaG13NDqk/7kXs2DdE/GrDSfCb1Aov4RzpUVVJ
         9WqtKBC+U6CZilxrdJwlbaUgUX3IjLuA/uCQSTikHV6D7ZAri03rchU8EKnVIxu0HIUh
         V0W5lXaVZWA/o3BLzRsNXmsghqmFhjwWjil9OHWxmBKgfjMl4oOJXtx27dvSYwDcf3C4
         DwDCSR7JNUr9IfaJmCJEIr5JlFThGUhTS5f9mgvRF25ZRDfwfJ7e6c9S//Xj4gdOF69Q
         4KuP7d4OnQ3wtYa+tGA4ICaWvNq+cItRMu8n9rtR9Wx9XQnwJSSbFWuJeIiMC4nclDBd
         95+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5svgCFufMlshhOxCL3yRrtNeusRJxJrMvAD3tTSzVRysjUr7C57WMtfqlkN+JfiI2o9Xea29/OSmYuuAGBX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EgN5cksvyL6GCSdwB+T2+bD8B6hYQZa/RR0XHn8orFuTL1Y7
	yeGgab0ptdfVJFtYjZTNcrziGk85VVuAjT0g+iyYdvi0V+Hx2DHcK/G0/Ue+gyMGOXqXomMSD7r
	LNbl6sLEHMVugQjIUHGUaZduvCO0XlqACc79nOoTbmbUHIn7+YXoJiohRhv0=
X-Google-Smtp-Source: AGHT+IHRZl1BXcOslV7/K64TurMPCwVMt7YE6z1F/Rrh+/JqwuomTT/vks8ll3f9DFI9kVuXSoANKS1T1wgaGTVn1RRwrCfpPpks
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:3e5:51bd:b21e with SMTP id
 e9e14a558f8ab-3e57dad2c67mr30714875ab.9.1755250289655; Fri, 15 Aug 2025
 02:31:29 -0700 (PDT)
Date: Fri, 15 Aug 2025 02:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689efe71.050a0220.e29e5.0012.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_devcd_register (2)
From: syzbot <syzbot+5f1a55873cde03ffb993@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8742b2d8935f Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173325a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc3f2c190ebad30b
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1a55873cde03ffb993
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef8eda74e1e8/disk-8742b2d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/193376a0f0a4/vmlinux-8742b2d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fadbd8800c02/bzImage-8742b2d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f1a55873cde03ffb993@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 17040 at kernel/locking/mutex.c:577 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
WARNING: CPU: 0 PID: 17040 at kernel/locking/mutex.c:577 __mutex_lock+0x39f/0x10b0 kernel/locking/mutex.c:760
Modules linked in:
CPU: 0 UID: 0 PID: 17040 Comm: syz.3.2558 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:577 [inline]
RIP: 0010:__mutex_lock+0x39f/0x10b0 kernel/locking/mutex.c:760
Code: d0 7c 08 84 d2 0f 85 40 0c 00 00 8b 3d 5a cb 19 05 85 ff 75 19 90 48 c7 c6 40 55 ad 8b 48 c7 c7 80 54 ad 8b e8 32 2e e8 f5 90 <0f> 0b 90 90 90 e9 b8 fd ff ff 48 8d 85 60 ff ff ff 48 89 df 48 89
RSP: 0018:ffffc90004977a70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888062872050 RCX: ffffc9000ffb6000
RDX: 0000000000080000 RSI: ffffffff817a02d5 RDI: 0000000000000001
RBP: ffffc90004977bc0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 284e4f5f4e524157 R12: dffffc0000000000
R13: 0000000000000000 R14: 1ffff9200092ef5a R15: ffffffff8a99e7b7
FS:  00007f23fca8e6c0(0000) GS:ffff8881246c6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000523fa000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hci_devcd_register+0x47/0x170 net/bluetooth/coredump.c:433
 force_devcd_write+0x16c/0x340 drivers/bluetooth/hci_vhci.c:346
 full_proxy_write+0x131/0x1a0 fs/debugfs/file.c:388
 vfs_write+0x29d/0x11d0 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23fbb8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23fca8e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f23fbdb6180 RCX: 00007f23fbb8ebe9
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f23fbc11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f23fbdb6218 R14: 00007f23fbdb6180 R15: 00007ffc4456d828
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
