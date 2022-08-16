Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A9C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 16:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiHPQ12 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiHPQ11 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 12:27:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F937C189
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 09:27:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l18-20020a6bd112000000b0067cb64ad9b2so6281316iob.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 09:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=L19ReosZ+SutQpLWRA4SjdcE5TxJ42u1htGWgO7oKGk=;
        b=hhZSY1e/UbDpQnA5syg9PeAZ3i3b00eai4E4hvHBNxek2j8cdBGdACW4DzU17xN+uO
         fZgnZzsdM8JvZ8EpP4qxfqYVCIXH+VflfgxgiEJPxNGpy5fyyGsBZvFob1cUMe3BbuW9
         LtAOWAoIo1a1Vm0ImUgCxnpw4NkyArHyht9EHEv6gdx9mQxljdkCXDHlk+8tdddjjTbP
         eIXqikrJpx1bB9cUk40gfSSwLO2nNl9R/rfhCxlwbd7rhvL/3vz1K/4KQmAPoJCxftip
         tQLgWmiMxdjy/ArDqA+72X84kq7BXayTFSos2Su5o0xMs7zpdAuzzXyp37zomDfjSWLf
         8/Kw==
X-Gm-Message-State: ACgBeo0Lgr1UDlcYPvhthmkl262jGsjyEBitNAxMFITMGqlKu6WYs8ts
        uTGMPsYk1Hzzmdsq7Fbohu/CEIio/+NkibLdXr5+wxsLsQRA
X-Google-Smtp-Source: AA6agR59smHEGOnrF9wzSQhMR9WQicPzs+7V1IXpr2eSTMRFRlXxPi1byRyIhux+YhXU6r+Xh6y+y8ZJAxfbl4JyPAkFwIw2eyrR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bae:b0:2e5:aa0f:154a with SMTP id
 n14-20020a056e021bae00b002e5aa0f154amr5133902ili.295.1660667245997; Tue, 16
 Aug 2022 09:27:25 -0700 (PDT)
Date:   Tue, 16 Aug 2022 09:27:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049baa505e65e3939@google.com>
Subject: [syzbot] general protection fault in hci_uart_tty_ioctl
From:   syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14aad4f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15669ae3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156d9b4b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c19afa60d78984711078@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3641 Comm: syz-executor395 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:hci_uart_tty_ioctl+0x23f/0xc20 drivers/bluetooth/hci_ldisc.c:771
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cb 08 00 00 48 8b 9b b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 68 08 00 00 44 8b 23 e9 14 ff
RSP: 0018:ffffc90003b8fd10 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff86978565 RDI: ffff88807902a0b8
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008c07c R12: ffff88801cb1a000
R13: 0000000000000000 R14: ffffffffffffffea R15: ffff888020e03b20
FS:  00007fef078ad700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff911ec960 CR3: 0000000071d89000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 tty_ioctl+0x1045/0x15d0 drivers/tty/tty_io.c:2787
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fef0791cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef078ad318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fef079a53f8 RCX: 00007fef0791cee9
RDX: 0000000000000000 RSI: 00000000800455c9 RDI: 0000000000000003
RBP: 00007fef079a53f0 R08: 00007fef078ad700 R09: 0000000000000000
R10: 00007fef078ad700 R11: 0000000000000246 R12: 6d74702f7665642f
R13: 00007fff911b316f R14: 00007fef078ad400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hci_uart_tty_ioctl+0x23f/0xc20 drivers/bluetooth/hci_ldisc.c:771
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cb 08 00 00 48 8b 9b b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 68 08 00 00 44 8b 23 e9 14 ff
RSP: 0018:ffffc90003b8fd10 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff86978565 RDI: ffff88807902a0b8
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008c07c R12: ffff88801cb1a000
R13: 0000000000000000 R14: ffffffffffffffea R15: ffff888020e03b20
FS:  00007fef078ad700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef079641c0 CR3: 0000000071d89000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 cb 08 00 00    	jne    0x8dd
  12:	48 8b 9b b8 00 00 00 	mov    0xb8(%rbx),%rbx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 68 08 00 00    	jle    0x8a2
  3a:	44 8b 23             	mov    (%rbx),%r12d
  3d:	e9                   	.byte 0xe9
  3e:	14 ff                	adc    $0xff,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
