Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110F13D501
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619362; cv=none; b=PSzmm8IoRYwBfm/zq2H5wBV6WW0jxWeSO9tfQo0wvHILpA9f9cPFw7IEIYdOIz6QLxFrIJO1BghdFIQbTk0qTmsvLkLMCoDYouZUDacyyAcBoDCyYtUdqMGbmNFc2BjngGYMqUldBOfXm0ar+1Esc3FtKQR1cr+U+cheA19dCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619362; c=relaxed/simple;
	bh=Ic+gqgDwUChwMcSG9fEkMsbq69XSE2/ufEDu0IWgNf0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n0VBVytIKfy/KQN6QnCd6clLe3tBCMvxwhbXXtK7kUmpHVwDEVUpVNMFdvrL2RQOXQyogQE5dBz1Z2G/VdYsAWi0xna06dhI0TfRVnacaBw+IvPOH8jeAbCVAHy9oIYswFMi0RVrcDl1pSaZ5ilSvALl1wpHGPF/+MWRC74Gcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-386a31aca51so52747935ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 06:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619360; x=1721224160;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izg+65yPEecv6UGK5yLFzhHTjabAcTQBYEicnAwokss=;
        b=Gl6QcsFOpy4VqCZouvZ6N44NaB2wNAXV5u6iIyW+0aQeJlr9eBZaV0kAbQcJm/5N11
         03pFKBfyO4Si0buqWzEFBb8FuSTmz181S+5sa1zl4iDpxUfVb88ImWynG9RLUJuD5SVj
         zi+IjMPdK51536tmjnRni62FPE1nrK+8hSRZ4/oxPOuoAVumg2627pFQ75TOkIdN859A
         WRlJeEls85OcAm+avYslkSjPHRNkjhiDLj0JVwNXibl7u+fEH/bjIF+ShSpNLdPx0u7D
         MA4kClHlYYOUm+cMEbSoYQjhP07IXnSSP5IhV1Q++p0R9QNdZ+Olx+SDgVsjIoNFGWpB
         EuUA==
X-Forwarded-Encrypted: i=1; AJvYcCWvZr152FM7SifO6PjVEBB2t5QCdXTFgDX/79OpyuVvFz47i7G2DRt0c8wZbjyN2OThDMyuMRyKSkx/+dGT/QdoMCHCoP82M1Rb3uCfA7fU
X-Gm-Message-State: AOJu0Yx+3I0X8du8lRoL4Skp7vsDmx8z1seS/vuuWvFUMkZSm/645vyf
	X+VFW5gFDfF4bIAw2CHmP+QqkvDOK/WvOetcysiiHhapubcpKBuwsnil/MUAjySGNpuvt6GC1pT
	fVucldVdZkYuEOJSTZ3syTx+/Tfs+XfaVVLlYvjdGnBBjR6RcwWdVqcw=
X-Google-Smtp-Source: AGHT+IG3zd6do+vNXy0cTLbaZ3+letjqvrwczulHDE1YOgYhn4OZfQauZ2qxggIRztU8Ac8fjewItsUxszus5c23vX3tmkb7zhe1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cc42:0:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-38a5407a014mr1222425ab.0.1720619360295; Wed, 10 Jul 2024
 06:49:20 -0700 (PDT)
Date: Wed, 10 Jul 2024 06:49:20 -0700
In-Reply-To: <000000000000fa6583061ccb8e3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3b0fc061ce4e979@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f33371980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=f52b6db1fe57bfb08d49
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12514831980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-34afb82a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b9edcefcae7/vmlinux-34afb82a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b24e5f6f0192/bzImage-34afb82a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 5955 at kernel/workqueue.c:2282 __queue_work+0xc13/0x1020 kernel/workqueue.c:2281
Modules linked in:
CPU: 2 PID: 5955 Comm: syz-executor Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__queue_work+0xc13/0x1020 kernel/workqueue.c:2281
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 76 07 91 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 d7 3f 35 00 85 db 75 2a e8 ce 44 35 00 90 <0f> 0b 90 e9 4d f9 ff ff e8 c0 44 35 00 90 0f 0b 90 e9 fc f8 ff ff
RSP: 0018:ffffc9000b9978f0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81589fb9
RDX: ffff888021b64880 RSI: ffffffff81589fc2 RDI: 0000000000000005
RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880269bcad0
R13: 0000000000000008 R14: ffff888043e61000 R15: ffff888043e61000
FS:  00005555879ee500(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5840efeda0 CR3: 0000000027ff8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2411
 queue_work include/linux/workqueue.h:621 [inline]
 hci_cmd_sync_run net/bluetooth/hci_sync.c:145 [inline]
 __hci_cmd_sync_sk+0x359/0xf80 net/bluetooth/hci_sync.c:167
 __hci_cmd_sync_status_sk net/bluetooth/hci_sync.c:252 [inline]
 __hci_cmd_sync_status+0x3f/0x160 net/bluetooth/hci_sync.c:278
 hci_dev_cmd+0x625/0x9c0 net/bluetooth/hci_core.c:747
 hci_sock_ioctl+0x4f3/0x880 net/bluetooth/hci_sock.c:1150
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5840f757db
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffea3fbfcb0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5840f757db
RDX: 00007ffea3fbfd28 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 00005555879ee4a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000005 R15: 0000000000000009
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
