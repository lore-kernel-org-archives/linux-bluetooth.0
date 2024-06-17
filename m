Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A21D953B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659340; cv=none; b=qZ9pM6acQGuplce0QTsV79a1GsPgm3Q3NVREX8qhGC5aozXbZUTlHbnG8NxU497CRYSi8k2KehJvRgOhvtlaAxE1NhRn1GWvwoe2b9fb/pKSndRHvS2IheLYH6ls9c01vOxcjeOTCPclz+RKRbLYyj85GQ8gqwTsPSyCx+8eFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659340; c=relaxed/simple;
	bh=2824SwNDnV12+wJRKJEY2Ms9nRIcpXymsYNudpu8z3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IJuUlSB9LnQCLncAWVd/WSsRfguXnn4hBTLoojQjCpjJil2GLxnwgnf+z9QhfSlXdW57A5RXPk41TUrUmD8Rx9lhf7Gz4/DO9a9nn2EYdoQY96qrQoSjgduzczHr7URfM9/kC0ChN8WISPT/b7/+m6pXm7HJEra0FJvSFx90KK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso589690939f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 14:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718659338; x=1719264138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UL9Eybil0xmtIxbkRiEPXFFmKn9Rw4uLNzk9EnZg04=;
        b=ESJPvEzQNvP+koXFZSnFgUvhi6WX0N1W1EK8gt+igx91gqMP+0WkZAandmp43iZcPv
         a8BpV+O8vqdJpDJfwa249yBboGswyRy3rwR1PBKR+/wmOE6GpSd8dqskxsPu2I/IytZ9
         uN2vq+swPUeNuRlqMYrgOtndNiGtF82k2zAgb57TZ0bWJYUIQH5ZpxgD7YjRdRoqnCSa
         l+dhX0G9KsRVEuOvAearQ+8lLnoOqkNvP5RZL92O6j6mrC9DZUPX8nuKfaouW1E23xTz
         0FtsEUoh0WHcnqABgoCYf5cpVA6lrFvCs/WxX8DlSyZriUG6sMhxUmNUJqYeMFpcJi6e
         XAiA==
X-Forwarded-Encrypted: i=1; AJvYcCV34Iw2uWBSgimzw/nZ2UH8ZLzWsZ+ZTOntJ3pz6pGmHAfUmj78lSM8SfSy2W0eSIT3UCLhubraufKzIseLiKuviHI9YeG7sRxT21q1RSmb
X-Gm-Message-State: AOJu0YxzeVMYD2Q6RJfrzAwClqYf9aKK2P4x/IkqO3Tg6W+FunSK325w
	otYj/uDZ8cLqZuFmAvzXzN30xQPzrNdWAz1xj3tmNCFgqYwkVp0FNOUdY/Acq0TvtkB66nqc+p/
	iTl0oV+3/YNox6B7MPgKypiKNXeGfH1oy5Qe3YOPo1vJjetWHlAEPT3w=
X-Google-Smtp-Source: AGHT+IFWc46TOhDXCRrRCe0ZTZzdtj8jnxjg1X5yF17spIh8MxGmObE6j6A79NTAmEk7jLU0I1fSTM7YMTZKjP+ekHEjKqvAo8wy
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c9:b0:4b9:9084:c7ef with SMTP id
 8926c6da1cb9f-4b99084cfc4mr185258173.2.1718659337892; Mon, 17 Jun 2024
 14:22:17 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:22:17 -0700
In-Reply-To: <0000000000001c0dc8061b1bebf0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005346b4061b1c8f49@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_publish_rx_avail
From: syzbot <syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175822fa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=49092daf3dd0a57f9e73
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f8251980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b077ee980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002e: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000170-0x0000000000000177]
CPU: 0 PID: 5191 Comm: kworker/u33:2 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:l2cap_publish_rx_avail+0x4f/0x1c0 net/bluetooth/l2cap_sock.c:1137
Code: 03 80 3c 02 00 0f 85 86 01 00 00 48 8b ab a0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 74 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a
RSP: 0018:ffffc900032d7978 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88802a115000 RCX: ffffffff88bb942d
RDX: 000000000000002e RSI: ffffffff89e760be RDI: 0000000000000174
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffff88802a114000
R13: ffff8880118868c0 R14: ffff88802a11502e R15: ffff8880118868c0
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555926f16c8 CR3: 0000000022a3c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_sock_recv_cb+0x104/0x3d0 net/bluetooth/l2cap_sock.c:1509
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x20cb/0xa190 net/bluetooth/l2cap_core.c:6833
 l2cap_recv_acldata+0x9ac/0xb60 net/bluetooth/l2cap_core.c:7516
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0xaa7/0x1610 net/bluetooth/hci_core.c:4079
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:l2cap_publish_rx_avail+0x4f/0x1c0 net/bluetooth/l2cap_sock.c:1137
Code: 03 80 3c 02 00 0f 85 86 01 00 00 48 8b ab a0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bd 74 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 3a
RSP: 0018:ffffc900032d7978 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88802a115000 RCX: ffffffff88bb942d
RDX: 000000000000002e RSI: ffffffff89e760be RDI: 0000000000000174
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffff88802a114000
R13: ffff8880118868c0 R14: ffff88802a11502e R15: ffff8880118868c0
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51d7775348 CR3: 000000000d97a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 86 01 00 00 48    	test   %eax,0x48000001(%rsi)
   c:	8b ab a0 04 00 00    	mov    0x4a0(%rbx),%ebp
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 8d bd 74 01 00 00 	lea    0x174(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 3a                	test   %edi,(%rdx)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
