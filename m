Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28314D280
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814334; cv=none; b=dZqWpi13eveLHAzx0amNiHU6GqGZmLvqhBp9D3etcEAT5UAfYCwkAM8mlYq8VHwDByHYJlZk1rbEMFi7rcF5vL13BYbkGHWyLZWRoraNfjMztflwkRF8NKIoSV6e2zW6tWHsXmbNbRiyg2bTtHILE3NatnGtEdZq1GWO/ILFVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814334; c=relaxed/simple;
	bh=KJ4EV7Ij4/KhnXn1Vd3te6lugb/6olUABTrG+aSBD2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I9GwLjdAyzpS5AHLSam1WaZjwhbtzUHOTdCiQcYwnXoDNbBwkaoiMJ81Nwk4YZ4QYgiAssMcVnWMa0OxlT0fYmm+w5of+K1oTOnqJgSdq3HPUhY9patgJa4KS4eMouVCeylVD/slwAy8sIXHnOfhqUvv+XQ7J1xrSiW3qlEXtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39835205d20so91248065ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 02:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814331; x=1722419131;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H1QMb10fXl/AS1Cemdq0KR84AfifuBRStWO6Ij5oDA=;
        b=lyzL4qezLgY1Rvg7fnnI93ALcj/6kQGyQ8nJO++IIS5VLTrV9rpg4jyz2XQ298WTcD
         roQ+0saBnZ8jDl+ylfLmkfheWgihZhBCLV2VTIW0VERQp6m6LxJvNiL+kxJekXH6ryD9
         sK+WJ91J87Uv1maTv1PcLsxyZEllISFOonBeD6MNx9bKLq4/rvZCQSQnelQ1hvOfiOjF
         5IqmNOnwdHYbjbhKwsa2SWwtMj9ZPuF7VzpeiHD/ZIY1UCVPPnwGRyWDhMndB2BCkxtG
         hdbGhIXqbRTjOHSCyTv3Ed6pjDya1ptNgzQBQ5mpoXy9leCGXqn3qL9CbuM6ahSX8NcS
         hRYw==
X-Forwarded-Encrypted: i=1; AJvYcCW8sVB2B1vSqP1B31wVlr2gOhtRo7R3bkq8WNYQzH3ltwCarKoV4wDHxGb2sQwDJVyjh3Xmzd8DTFD6TKZByIsjb9xHhTh7bwlnGj2Wi/k/
X-Gm-Message-State: AOJu0YwmXN5fljv5DFy4T6NkOBX+p3G1eJxz7Qx+ZHrumD5LOuKMPLf6
	D0vcR0VYUTJEXkkhR6HEU+zmz6Q6usluk94ZfXvR49dgFoGbBxJzdHh4sQ1xx+6TYx68jaN5qJF
	kQCEyVXC3MrcJWr2M6BU/IaLRL6qyPXudiVoNq0BBpOyEE+7h6s9NJO4=
X-Google-Smtp-Source: AGHT+IFD1uOfY7dHKPxj/jTyil5SRoJ/EyB8EbVqCx/NoonVveSec2Q54tDDJkKLggclpJNJOQqVTRng0BXpK0xpASgp5Ju09hMr
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:397:7dd7:bea5 with SMTP id
 e9e14a558f8ab-39a16b83f38mr2574995ab.0.1721814331001; Wed, 24 Jul 2024
 02:45:31 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000919a9b061dfb239a@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_send_cmd
From: syzbot <syzbot+d87defb553e002cd88a5@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1052d5c3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc5806b0bf399dd9
dashboard link: https://syzkaller.appspot.com/bug?extid=d87defb553e002cd88a5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-93306970.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/669de3c5a584/vmlinux-93306970.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6fb52aed0488/bzImage-93306970.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d87defb553e002cd88a5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8 at kernel/workqueue.c:2259 __queue_work+0xc2b/0x1070 kernel/workqueue.c:2258
Modules linked in:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.10.0-syzkaller-11840-g933069701c1b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xc2b/0x1070 kernel/workqueue.c:2258
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 be 59 93 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 8f c1 34 00 85 db 75 60 e8 86 c6 34 00 90 <0f> 0b 90 e9 08 f8 ff ff e8 78 c6 34 00 90 0f 0b 90 e9 b7 f7 ff ff
RSP: 0018:ffffc900003a7a20 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff8880154a0000 RCX: ffffffff8158184a
RDX: ffff888015f22440 RSI: ffffffff8156553a RDI: ffff8880154a0008
RBP: ffff888020da0b10 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 000000000000000f R12: 0000000000000000
R13: 0000000000000008 R14: ffff888011aba000 R15: ffff888011aba000
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f331a0f8 CR3: 000000001d234000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
 l2cap_send_cmd+0x6db/0x920 net/bluetooth/l2cap_core.c:973
 l2cap_send_disconn_req+0x1f4/0x410 net/bluetooth/l2cap_core.c:1487
 l2cap_chan_close+0x2df/0xa30 net/bluetooth/l2cap_core.c:826
 l2cap_chan_timeout+0x196/0x310 net/bluetooth/l2cap_core.c:435
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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
