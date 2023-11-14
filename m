Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BD26AF0
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968F112
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 12:10:27 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5c1b986082eso1106188a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 12:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992626; x=1700597426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OmEtRgexLuao6rUTYjJiY3r0edSaCvPRTeIf9Q3x4Y=;
        b=jEyzSbxF5GRAQugfvcKqjPoN9vdEJ2EpvTeZH59qK32XRypY+pcXdVN9tHVwLbWYm0
         to/pZcBCf9OrthOI3EqvWVQqWkIcwUQKwQUMpQ3YhNwqZpA6H61Q37TsfX2TPSPDMwWM
         WNNTFfAPVAwjsiHMlRbOfYTOmK54rocMqxXQn5KmCn6tUVqX9o7k9EJrloTj2l468ZB5
         ugVK5EUBkXu0PhUMgGXx+KsAVbWAvc516WNcKxMsmdovNXqhHlStZvvRGc7pVFOwvZfJ
         1KZx6+qX1GpJng1wE34NVFabnsdD6IlvrdzyPZ2rS0mTf7W0eS8iTUJxC4uCflBxIsVw
         BeEw==
X-Gm-Message-State: AOJu0YxT7jxUzam5AUL0oeAs2hmBI4zSkmngNr4Et2biIHTzk63uJoNH
	F6thT3gYL4/YyjOv/U4a6uzw20I0H3obdBgymSrTWlFhymz4
X-Google-Smtp-Source: AGHT+IETYdbtUIRvCyXXpYa3AFqr3GveSx+wlGUsWoZqM5BQf1q0ceXvYVfxWA/DSQfm4ey42OtxaYOEc06BLy+8Nm0V40d2HsgW
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:6702:0:b0:5bd:579:c5bb with SMTP id
 u2-20020a656702000000b005bd0579c5bbmr893745pgf.4.1699992626605; Tue, 14 Nov
 2023 12:10:26 -0800 (PST)
Date: Tue, 14 Nov 2023 12:10:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a135c0060a2260b3@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1121f91f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8889f0a9f059/disk-9bacdd89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f78cb4c03467/vmlinux-9bacdd89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb88d4b4f745/bzImage-9bacdd89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
Read of size 8 at addr 0000000000000050 by task kworker/u5:2/5100

CPU: 0 PID: 5100 Comm: kworker/u5:2 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: hci4 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ida_free+0x218/0x2e0 lib/idr.c:511
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1182
 hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2615
 hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
==================================================================


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
