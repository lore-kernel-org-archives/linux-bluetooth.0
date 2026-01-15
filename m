Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B90289E06
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519250; cv=none; b=Wvo9SxruLumDC8HY5pvMc3QWei9FAL1Ou9YobZF10pLYT75E5x2Bod4K2OMYT28fmdfwhsg6EaP2Blad+ugJ3aQlMs5WWoG00JM5QqmupANf2x2NN7s2LAFtsSEnNvKRHZBFcMHJM7KXPzwNXg6AjKPsvzDMRSD33vj8lZC2prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519250; c=relaxed/simple;
	bh=uLWZbt0VVZUkAGHWFkBWaHqDdrMQqi/kvgGbonRifK0=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=b6U2waJ0qgv54ZIJrpjusDV8kDlM2Wy77OJgsLqRSXkQBQidSq1NzgGpHL+Ucdlw8zSRtcJRP+nDyDA8l8AdnmdCLYHDX/sIsPniPoQNI7/1BrhIP2/9JxbIYwVdgRwLgRhbDcuGL14JZZUIyxXBQRhlHuk+ud1aJaF0pQGceDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk9L0xaa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk9L0xaa"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f0f875bc5so10143335ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519248; x=1769124048; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLzGIxlKGPDbAsK/1di5fB/zw1hRnchiacUNpFnDkjc=;
        b=fk9L0xaaDNtQ+CpWgQpuB9Pdl+HMR80C8nU5jZyv4dmBSSDv4sXghsTi1Kk6defK5b
         o8RBiLJjtDM8eaVGbCDFd5lK760oAVQXGMXmSqrvvNPvh0H52TwfhobcR3EorlaivYfn
         HxcDb8MjL0m7w7WGE/Se07YKGKRx/hiewb7XszB3pcTc9Uc5E6PFYgVtJX8XS+Yh62DG
         YGJTQDsEyHeX1O90iqIG0yegi4okh8+tWblQI4sTyX8X3v7lEVVaSyLgwlZ1nV6FNV2U
         qe9Rf8Jqrz23Dgo8CVx588It1wtrPz3TTP/PoVGVid67Gk5fRRLx8Fel2B2oU1VG4S+x
         pwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519248; x=1769124048;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLzGIxlKGPDbAsK/1di5fB/zw1hRnchiacUNpFnDkjc=;
        b=lgQFOmkl8jhcrDcT/SvGlu2Fcs9F6arfdZ6fWd71BMeeD8R40X2fjfvvQALFc3qejm
         +xAzhYLHmYc6tuCzJyWW9KQyM6K43cm0SYK7b1pxxj9PxCuLn8n4mvvCrtd5zYk3o0Cu
         90LRubkm+uwqH9G5AXKa6P7po2NLzrRL82+wex/D/bTJwzW1ysmLjPP944jj7jWrhyzw
         dTu5+kRQzfPfrJ/zqi2qv/feQ6N5bN0bk9aAGkBTRDRhh9k+ygraOSPMI0UN4Ob5unlU
         ADn7j8/Pb4MJWxZo4oK2gEoFrQl/SO79cbC2sHe2QqZPoS76Ats+De/vaw0OTFgIs01P
         3JBw==
X-Gm-Message-State: AOJu0YxXQb5/ZqQbCVxdCiqAHUAv106O5YFkk6mCjtDBqT6q/UDlVjI8
	njQuMzvZxBZMKZTc0Rpt0GLv8QUS9OM9rS+1fp52MvdD3K9AbC9QjbsZ
X-Gm-Gg: AY/fxX6UqCjLhv7w8waSfKM03eDzs9Ua5pkHi1DyL+WILFhtk6ofq5+L91eHgY/qs0m
	gGJzVHYfL47Cs6qOabi7uc0Fs5Nn8gFzU5P2ihOzHo8M67aRacteyicSA4aSO4VALW4OtyWxQlZ
	m9B/x2dk8AY/GPJaruzlRI/E7TKOiXFBU9iOHUG60g8hHOawwDTn1jfLzuj0xHo7YcLBDd7ErwA
	9Ekiy7MgiAGM+F3dbfsPAsnIbVEUAps/qh/S5MJ4bZnipJkvAB7hWDMD0AqAuoYGqEM3DfMNI/j
	VYuCFmlplb73RR0MNNZHCah/5yffIfeuZD8dtQGjr135sfZkTF1v++4vMoZYJC9AMLkDHCEfFMZ
	9iOm1sqhEKgXk5Ge5z+kg8WP7XxJDOpvswsQ7e8VLhMRuPSHeJ/pBslhdER3Jh5+BOZNW8zzKGZ
	MztupOjYdebL/B5EkpDE51/1OsvYrnkRr+f+AmIID+oXupKjKO0vuGS0+n7A==
X-Received: by 2002:a17:902:d48c:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a7177da66dmr9690825ad.50.1768519248108;
        Thu, 15 Jan 2026 15:20:48 -0800 (PST)
Received: from DESKTOP-85LD9SI. (118-167-197-253.dynamic-ip.hinet.net. [118.167.197.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa31dsm3486785ad.16.2026.01.15.15.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 15:20:47 -0800 (PST)
Message-ID: <6969764f.170a0220.2b9fc4.35a7@mx.google.com>
X-Google-Original-Message-ID: <aWl2TEIjJXjjvhx9@DESKTOP-85LD9SI.>
Date: Fri, 16 Jan 2026 07:20:44 +0800
From: JiaHong Su <s11242586@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] Bluetooth: Use-after-free in hci_uart_write_work
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XWg1CPvSxNCkOuFR"
Content-Disposition: inline


--XWg1CPvSxNCkOuFR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Found a use-after-free in hci_uart_write_work when running Syzkaller on
Linux 6.19-rc5 (commit 0f61b18).

KASAN reports null-ptr-deref in the workqueue handler, looks like the
work wasn't cancelled before the structure got freed.

C reproducer and dmesg attached.

Thanks,
JiaHong Su

--XWg1CPvSxNCkOuFR
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="repro.c"

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE 

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts))
	exit(1);
	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
	char buf[1024];
	va_list args;
	va_start(args, what);
	vsnprintf(buf, sizeof(buf), what, args);
	va_end(args);
	buf[sizeof(buf) - 1] = 0;
	int len = strlen(buf);
	int fd = open(file, O_WRONLY | O_CLOEXEC);
	if (fd == -1)
		return false;
	if (write(fd, buf, len) != len) {
		int err = errno;
		close(fd);
		errno = err;
		return false;
	}
	close(fd);
	return true;
}

static void kill_and_wait(int pid, int* status)
{
	kill(-pid, SIGKILL);
	kill(pid, SIGKILL);
	for (int i = 0; i < 100; i++) {
		if (waitpid(-1, status, WNOHANG | __WALL) == pid)
			return;
		usleep(1000);
	}
	DIR* dir = opendir("/sys/fs/fuse/connections");
	if (dir) {
		for (;;) {
			struct dirent* ent = readdir(dir);
			if (!ent)
				break;
			if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
				continue;
			char abort[300];
			snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
			int fd = open(abort, O_WRONLY);
			if (fd == -1) {
				continue;
			}
			if (write(fd, abort, 1) < 0) {
			}
			close(fd);
		}
		closedir(dir);
	} else {
	}
	while (waitpid(-1, status, __WALL) != pid) {
	}
}

static void setup_test()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	setpgrp();
	write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
	int iter = 0;
	for (;; iter++) {
		int pid = fork();
		if (pid < 0)
	exit(1);
		if (pid == 0) {
			setup_test();
			execute_one();
			exit(0);
		}
		int status = 0;
		uint64_t start = current_time_ms();
		for (;;) {
			sleep_ms(10);
			if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
				break;
			if (current_time_ms() - start < 5000)
				continue;
			kill_and_wait(pid, &status);
			break;
		}
	}
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void)
{
		intptr_t res = 0;
	if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
//  openat$ttyprintk arguments: [
//    fd: const = 0xffffffffffffff9c (8 bytes)
//    file: ptr[in, buffer] {
//      buffer: {2f 64 65 76 2f 74 74 79 70 72 69 6e 74 6b 00} (length 0xf)
//    }
//    flags: open_flags = 0x1 (4 bytes)
//    mode: const = 0x0 (2 bytes)
//  ]
//  returns fd_tty
memcpy((void*)0x200000003040, "/dev/ttyprintk\000", 15);
	res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200000003040ul, /*flags=O_WRONLY*/1, /*mode=*/0);
	if (res != -1)
		r[0] = res;
//  ioctl$TIOCSETD arguments: [
//    fd: fd_tty (resource)
//    cmd: const = 0x5423 (4 bytes)
//    arg: ptr[in, int32] {
//      int32 = 0x14 (4 bytes)
//    }
//  ]
*(uint32_t*)0x200000000000 = 0x14;
	syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x5423, /*arg=*/0x200000000000ul);
//  ioctl$TIOCVHANGUP arguments: [
//    fd: fd_tty (resource)
//    cmd: const = 0x5437 (4 bytes)
//    arg: const = 0x0 (8 bytes)
//  ]
	syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x5437, /*arg=*/0ul);
//  openat$ttyprintk arguments: [
//    fd: const = 0xffffffffffffff9c (8 bytes)
//    file: ptr[in, buffer] {
//      buffer: {2f 64 65 76 2f 74 74 79 70 72 69 6e 74 6b 00} (length 0xf)
//    }
//    flags: open_flags = 0x1 (4 bytes)
//    mode: const = 0x0 (2 bytes)
//  ]
//  returns fd_tty
memcpy((void*)0x200000003040, "/dev/ttyprintk\000", 15);
	res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200000003040ul, /*flags=O_WRONLY*/1, /*mode=*/0);
	if (res != -1)
		r[1] = res;
//  ioctl$TIOCSETD arguments: [
//    fd: fd_tty (resource)
//    cmd: const = 0x5423 (4 bytes)
//    arg: ptr[in, int32] {
//      int32 = 0xf (4 bytes)
//    }
//  ]
*(uint32_t*)0x200000000080 = 0xf;
	syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x5423, /*arg=*/0x200000000080ul);
//  ioctl$TCFLSH arguments: [
//    fd: fd_tty (resource)
//    cmd: const = 0x400455c8 (4 bytes)
//    arg: intptr = 0xb (8 bytes)
//  ]
	syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x400455c8, /*arg=*/0xbul);

}
int main(void)
{
		syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	const char* reason;
	(void)reason;
	for (procid = 0; procid < 8; procid++) {
		if (fork() == 0) {
			loop();
		}
	}
	sleep(1000000);
	return 0;
}


--XWg1CPvSxNCkOuFR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=report

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 11930 Comm: kworker/0:8 Tainted: G             L      6.19.0-rc5 #11 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events hci_uart_write_work
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 8e a0 37 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc900029ffa60 EFLAGS: 00010082
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b5b2d9d RDI: dffffc0000000007
RBP: 0000000000000038 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff906888d7 R11: 0000000000000002 R12: 0000000000000000
R13: ffffffff8b5b2d9d R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888097d23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e61db0bd8 CR3: 0000000026850000 CR4: 0000000000752ef0
DR0: 00000000000007ff DR1: 0000000000000005 DR2: 0000000000000000
DR3: 00000000000084e9 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 __kasan_check_byte+0x14/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0xfd/0x330 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 skb_dequeue+0x20/0x180 net/core/skbuff.c:3937
 mrvl_dequeue+0x3f/0xb0 drivers/bluetooth/hci_mrvl.c:126
 hci_uart_dequeue drivers/bluetooth/hci_ldisc.c:107 [inline]
 hci_uart_write_work+0x4d5/0x940 drivers/bluetooth/hci_ldisc.c:161
 process_one_work+0x992/0x1b00 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x67e/0xe90 kernel/workqueue.c:3421
 kthread+0x3d0/0x780 kernel/kthread.c:463
 ret_from_fork+0x966/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 8e a0 37 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc900029ffa60 EFLAGS: 00010082
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b5b2d9d RDI: dffffc0000000007
RBP: 0000000000000038 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff906888d7 R11: 0000000000000002 R12: 0000000000000000
R13: ffffffff8b5b2d9d R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888097d23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e61db0bd8 CR3: 0000000026850000 CR4: 0000000000752ef0
DR0: 00000000000007ff DR1: 0000000000000005 DR2: 0000000000000000
DR3: 00000000000084e9 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	e9 8e a0 37 09       	jmpq   0x937a0c5
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

--XWg1CPvSxNCkOuFR--
