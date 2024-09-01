Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AC7E101
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725176370; cv=none; b=qbRvADGtnyZyi+fXIsfSNrUs+Iswh6oABPsSsM07ZF8WUkmsjf6wUdvpPY9PquSKJp+ISHwQuabjxKbn2WmiU6b2LNJtzqT8onGMZN55EauVTQZI46HX98UTtKwtEN2n5OfXFov6WaGdta8lwS7ECKgtcYiWlA4mbUcePClJeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725176370; c=relaxed/simple;
	bh=aA7PRBVXeURc0y4haGj3b8s3j8jYM8sH8nwHmA2n6zA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OdowVkVQ29gKdGF7SW+Blv+0yQnf9K5ZhDUZzPHJVmzQfmKs9Qemk/ZGMLCOkbhocmrxnDb/rT4sxfiZBfTznMSSnFlSb4qzQgyIrfUDFV5XUHiJ+IksjQNQRqdmddJEydHGDRv8yKbwb7GcumpiMQjtfqpeR+cfzI8PIFVC9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so40230825ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Sep 2024 00:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725176368; x=1725781168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfKU43Y0F3kPZOkwB+JSr6rYJBGPcvBjhYK8OyoDvM=;
        b=bOeuZCGZjwtehygRBIA9iAtLGm0mMzBUbdS55VfpiFZo9xdo+NquSe2rbDTqAzE+JJ
         ud6CBS2d8yJSNdQJh0nCbsMAc0RFtRFPQiJr9Q0ALsj74JU4PvmuboNDsyK5wJIGJJIo
         PMsF5kwh3/diuCXiZSDqy5pvx2i9dsV78E7ndCyU9agvcUICcYMkB6C4NVlmAGRpcAHx
         zeokUrcZeevhdviRIOQ+f0SuAUoR5VqsajlZoRawJEvHlEm+IA4bXLMqoFXu1QpQ08+R
         fLlR57QjzDBFV9bPCJpOSKji00X28y3kmQpoKAKn5ciIwYFBL+LcQVEAf1lwNYx8ygJf
         aAyg==
X-Forwarded-Encrypted: i=1; AJvYcCV2JjcMUWXTv6mkagSrmn1WoX+Mv0wYB20IcCNLB0q6K4SVmTmD6dTC63G+7VCnuTHbf73KZd/OkBlj+qHOlXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygONZsmjq1CRDuLieC8Fbz8ZraYxsH3gVSAevKuTS0pLUYfsX2
	bBO6LaDrnzBEbgNN8+Y9q/tN31mh7Ce1kU6hWqd+1Tlzk0qA8+SCNn0c0CL6L9ahDWhW4drden8
	cDCgg50zJrw62yZw/bZfN40ftzbDD0z2xOcTHrnDUCiOxq7Etq9CRrZw=
X-Google-Smtp-Source: AGHT+IFJmiPebFmp8ZPNjSW7Ap7vhs7XgThHVj2oE0FS1Okr7LH+V8qyPxGD3dp6mkKRZAreo1BmAxxKnczd+OsCPJBAsE5xJVy+
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:39d:3043:1f20 with SMTP id
 e9e14a558f8ab-39f410838a3mr5885555ab.5.1725176367961; Sun, 01 Sep 2024
 00:39:27 -0700 (PDT)
Date: Sun, 01 Sep 2024 00:39:27 -0700
In-Reply-To: <000000000000e43c5106170f2fb4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096680f062109ec63@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
From: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8784b0aef62 Merge tag 'usb-6.11-rc6' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1600ea63980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3e19fd08b312452
dashboard link: https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ba6d1f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dfdadb980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1d3f7f323a8/disk-e8784b0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01c01dcebf01/vmlinux-e8784b0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53cc8ab0ce4d/bzImage-e8784b0a.xz

Bisection is inconclusive: the first bad commit could be any of:

b79e04091010 Bluetooth: btintel: Fix null ptr deref in btintel_read_version
e7b02296fb40 Bluetooth: Remove BT_HS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d8bd73980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in l2cap_conless_channel net/bluetooth/l2cap_core.c:6757 [inline]
BUG: KMSAN: uninit-value in l2cap_recv_frame+0xc9c5/0x18b10 net/bluetooth/l2cap_core.c:6831
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6757 [inline]
 l2cap_recv_frame+0xc9c5/0x18b10 net/bluetooth/l2cap_core.c:6831
 l2cap_recv_acldata+0xdd9/0x2ac0 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xb38/0x1130 net/bluetooth/hci_core.c:4028
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x128/0x910 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5180 Comm: kworker/u9:2 Not tainted 6.11.0-rc5-syzkaller-00310-ge8784b0aef62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_rx_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
