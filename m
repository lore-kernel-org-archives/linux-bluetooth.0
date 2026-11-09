Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196718;
	b=PZiO03GO2XfWy71Za9XBzlxoKcxIYH2VJ1DF/paEaKAjlGhSu7GHMVGH5AEtvg4b+C2k
	 73QCfGeP/WkIvElFcbauclGllzwf0quSdA8MpUo5eLdi1Bj9opDQjGPeGFujIOZD6siyZ
	 j2ulnCsPo5nHSkDwr5ujQTHS87Z3l2uz+iKdM+LiKD785dfBSGX0v5oFrLj8bvN1vHI2O
	 k5u0mgC/2cimJ+dRJHEn0vyAaDp/phqECbh5ChHT5mtL0NwYyeE61MJjX/7WzdjCVLgEA
	 U0IWzc/SXZ0FM9i5SNsgLABZs4+v2ldIZxqsThWcE2/4IAhEiEAfjUfsjZoQV20orZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196718;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=FmcI/wMjxKRabbUMuhYcTv6IrsP0rncRUcBSJiu7240=;
	b=F4Z1hENbCiT4RkvwZ80H/IuA6S7If1tGUmZilwpJWRX66PC9E9aQJviqCCIhQWa2mSqM
	 VnBH6h57bgR8bYIr/QGiSyu7JAuR6S7/O2MOVCxGdF1zLXmoJQ4sc56/ADoT3josdpLom
	 aMPmrnyt0Jv7Gq9SI5Qq5WBqIKQGNNfCJqkq/x13jnQlupX4ZClK5SethL3BYoX36X876
	 hDNgxsq0Lej31dQj2Gx32luXpF5Mev9sdyJT2QDPJ7Jh+Y+AL2rU2JekcsmINmjA7Ofj1
	 pwjQb99XEt4yrj2oGDgEMccgczxEAl8EuuyB0RPms9FzcBaJvJF3jgmApsrfygw9BZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F904606A321
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 03:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F904606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4dc57e2a3f2so726069b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 19:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794196717; x=1794801517;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmcI/wMjxKRabbUMuhYcTv6IrsP0rncRUcBSJiu7240=;
        b=1md4fY1AoZJ+srvvYGNz1w/+8RWuH3InPboKJf9oxyDrZiSDiBAoSbDK5lCRc3XAOz
         3Bpf3OC2mftvRpF9Avf/6lScSDPPcDHk82ZOsxB14KsLBThzQPBOIFbPSStvEYVgyh21
         BOBnUDDmbUfllHlLy8f/6D4gWkB2HpX4Emlr+nWoAy0Wrr1ld0VB/rhes2/h+8w+6Pnu
         N8pVfsr3Ay7Y0+XetE6uclk9YcPnDBJu61Rb/ltKUXTRD1uIRWZQzqPJV2wmzYSUN48h
         k3BPkMiONunW/vY6m19IrE61ehSUM/7t+FrS0l0pAaZtGLLLMMOnNpGOgj5xE89V1H56
         MaOQ==
X-Forwarded-Encrypted: i=1; AL+hErH+BpZsY2dnvLCtQ0G5LRwNn19pans+fqjvfzRLAibpuqnTAbvYnkG4OKi50pAfS1eHSOpHxvZNCBOy84JTPD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z983AcyFRDrHh38U+KjVqxTCtMN3N8+//vwfNrWbr2iF8ZFsLiT
	r5tcJXw61hevBkk/0izn/qF6/EoPLOaveHoHvirxyLRXrB9tLNJt1nBqqftKr+1S8syPMEb+xXX
	Ta87W0PCFw+fi3yRTCeqcIJoEyiSIGCs05tG8juVlTEgyJxPt1+gB5tJtNeQ=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:318b:b0:4e6:9390:e153 with SMTP id
 5614622812f47-568145f2896mr2071786b6e.24.1794196717188; Sun, 08 Nov 2026
 19:58:37 -0800 (PST)
Date: Sun, 08 Nov 2026 19:58:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af144ed.f50b2b3a.2c0de7.0010.GAE@google.com>
Subject: [syzbot] [mm?] [bluetooth?] BUG: unable to handle kernel NULL pointer
 dereference in __refill_objects_node
From: syzbot <syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bsegall@google.com, david@kernel.org, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, kees@kernel.org, 
	kprateek.nayak@amd.com, liam@infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58c1eb84e977 arm64: sdei: Preserve the interrupted context..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12d1d369580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a58b6b4d667e7a61
dashboard link: https://syzkaller.appspot.com/bug?extid=73e34786d639a8eb1324
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255c1a1580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1ec47537e12/disk-58c1eb84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bca0c2b1169/vmlinux-58c1eb84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a7c49594d5a/Image-58c1eb84.gz.xz

AI-generated root cause summary:
In mm/slub.c, __refill_objects_node() replenishes percpu sheaves by detaching a
freelist from a partial slab via get_freelist_nofreeze() and iterating through
the freelist pointers in a while (count && refilled < max) loop. Because the
loop condition only checks count and refilled rather than validating that object
is non-NULL, a prematurely terminated or corrupted freelist (where fewer objects
are linked in slab->freelist than the expected count = slab->objects -
slab->inuse) causes object to become NULL before count reaches zero. On the
subsequent iteration, get_freepointer() dereferences NULL + s->offset (offset
0x400 for kmalloc-2k), resulting in an immediate kernel NULL pointer dereference
crash at address 0x0000000000000400.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=73e34786d639a8eb1324

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 00000000000004e8
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011857f000
[00000000000004e8] pgd=080000011cba0403, p4d=080000011cba0403, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4870 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : get_freepointer mm/slub.c:596 [inline]
pc : __refill_objects_node+0x308/0x510 mm/slub.c:7413
lr : get_freelist_nofreeze mm/slub.c:4494 [inline]
lr : __refill_objects_node+0x2b8/0x510 mm/slub.c:7409
sp : ffff800094587600
x29: ffff800094587690 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000006 x25: fffffdffc3256e00 x24: 0000000000000003
x23: 0000000000000006 x22: 000000000000000c x21: 0000000000000001
x20: ffff0000c0022138 x19: 0000000000000004 x18: ffff800123625000
x17: ffff0001ace953a6 x16: ffff0000db9cd894 x15: 00000000000c8000
x14: 00000000005c615b x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000000 x10: fffffdffc3256e20 x9 : ffff0000c0022120
x8 : 00000000000004e8 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : 00000002000c000c
x2 : 0000000000000000 x1 : 00000002000c0003 x0 : 0000000000000001
Call trace:
 get_freepointer mm/slub.c:595 [inline] (P)
 __refill_objects_node+0x308/0x510 mm/slub.c:7413 (P)
 refill_objects+0x78/0x320 mm/slub.c:7526
 refill_sheaf+0x44/0x6c mm/slub.c:2917
 __pcs_replace_empty_main+0x22c/0x4f4 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 kmem_cache_alloc_noprof+0x35c/0x5d4 mm/slub.c:5047
 dup_mm kernel/fork.c:1532 [inline]
 copy_mm+0xb8/0x328 kernel/fork.c:1594
 copy_process+0x1698/0x35a0 kernel/fork.c:2320
 kernel_clone+0x234/0x8e8 kernel/fork.c:2790
 __do_sys_clone kernel/fork.c:2932 [inline]
 __se_sys_clone kernel/fork.c:2900 [inline]
 __arm64_sys_clone+0x168/0x1d4 kernel/fork.c:2900
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
Code: f9401fe8 f900029b 2a1a03f7 b9402908 (f87b691c) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f9401fe8 	ldr	x8, [sp, #56]
   4:	f900029b 	str	x27, [x20]
   8:	2a1a03f7 	mov	w23, w26
   c:	b9402908 	ldr	w8, [x8, #40]
* 10:	f87b691c 	ldr	x28, [x8, x27] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
