Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB03074AE
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771704210; cv=none; b=BfgCS/pQXKxYBrcngD1bIrm7poUSoywWF0sHvgCUX+NojJTlNOZyTmYjL2HXtAINd98c0sKWSAf2rRqaMMQMNt2lssuhVGPeHShCtCKESk/NHUslum+B0ZVInH+f0Br00boY1oOnfmZ383uRDKwdXTj33Blknehv54ulxgRckV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771704210; c=relaxed/simple;
	bh=oqZmh17IilL5q9EU+kYhqkvWjQeupDKmPVQZ9xntLnA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JIfdCf4NvOtp6BioLIiUQm4dx+tnv0HtsgzdjyN+/l+EceJOWwiD7bL2K/uZZoGXmO7xWcCfrPzO7tbPuc6MEeMG/cwBUPJVvQ5xbEXycNUKe9ZJZWG4fNlbdZs8q9RF0aBBAqbJ5dA0WfCOCa3mBWijsljSW+SOvy+tHFJDXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d498212845so15086272a34.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 12:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771704208; x=1772309008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVeOluBrE/mIepsp5N9A2vw3i+Y5Ua9q02m2COguD04=;
        b=WbD9+Aj1XK+n54sfuX+l2p9m8XSGpFIJWZfoepEYWSoshXM/cQcaozZ0QnRtsYd10y
         Vpvwc4uWUUFIB5iD33pJThOJ6a4yt1shndo90iOpSuyFTsS1KqNAJpY0/elQp0XU8+ky
         Q0q9FbVjtiy6lEKgPKNiFlpK8/XC6FWuxGrTAlOHjOXO1Rck+S+0HLykPW1FTu27FXyC
         dOAECnDlIlsOKXDtu6ObgrjtDZGhysDdc3gpGTk7dIlCi3ypNyv5RL+cnZAMOHeL5hNa
         XN8grV9jP8nWQF4iB8QRGF0GdBAWUuAVkL7W0YfpxxVxhveeq4Dz5IEuK4RfCVzorRoF
         m/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlV09ipCBCxvb13zJ3/bfTi0jeeuD+aPVIIUatKtJe2G1SpMXvIu0A5CP8YSIQYlJ4Zz10cmSiE489P9LtlXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jNYRd6fFrpLhTKQD5PgUWW5gdOkVvxkyeW5i5NEa3zWQkOCy
	x97xriGX5kxG1chPpQKB2dL91XF9xWRZZDvnxrK72pc8UFh5aZ1RZNJYp3Jq+UOkoHbygPUwUDL
	FaeAgEVExLzTTuUYIJxKj7TgDx4QhI6ARxMWp1k6bl75InPpdwIe8+odvCqY=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:448d:b0:66e:9d89:d8b7 with SMTP id
 006d021491bc7-679c44d33famr1431542eaf.49.1771704208610; Sat, 21 Feb 2026
 12:03:28 -0800 (PST)
Date: Sat, 21 Feb 2026 12:03:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699a0f90.a70a0220.2c38d7.015f.GAE@google.com>
Subject: [syzbot] [bluetooth?] KCSAN: data-race in bacpy / memcmp
From: syzbot <syzbot+dabcf90d3a2acf24b4a3@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72c395024dac Merge tag 'docs-7.0' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b38ae6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c653aa4dc2fe740b
dashboard link: https://syzkaller.appspot.com/bug?extid=dabcf90d3a2acf24b4a3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c143500d000f/disk-72c39502.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/734418a35433/vmlinux-72c39502.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97548c6e5a9b/bzImage-72c39502.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dabcf90d3a2acf24b4a3@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in bacpy / memcmp

write to 0xffff888199203818 of 6 bytes by task 18359 on cpu 1:
 bacpy+0x1e/0x30 include/net/bluetooth/bluetooth.h:380
 l2cap_sock_bind+0x275/0x5b0 net/bluetooth/l2cap_sock.c:132
 __sys_bind_socket net/socket.c:1874 [inline]
 __sys_bind+0x1d0/0x290 net/socket.c:1905
 __do_sys_bind net/socket.c:1910 [inline]
 __se_sys_bind net/socket.c:1908 [inline]
 __x64_sys_bind+0x3f/0x50 net/socket.c:1908
 x64_sys_call+0x2ceb/0x3000 arch/x86/include/generated/asm/syscalls_64.h:50
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88819920381b of 1 bytes by task 18360 on cpu 0:
 memcmp+0x52/0x90 lib/string.c:694
 memcmp include/linux/fortify-string.h:727 [inline]
 bacmp+0x1e/0x30 include/net/bluetooth/bluetooth.h:376
 l2cap_sock_connect+0x25a/0x4c0 net/bluetooth/l2cap_sock.c:218
 __sys_connect_file net/socket.c:2089 [inline]
 __sys_connect+0x1f1/0x2a0 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x3f/0x50 net/socket.c:2111
 x64_sys_call+0x2e09/0x3000 arch/x86/include/generated/asm/syscalls_64.h:43
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0xff

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 18360 Comm: syz.0.12425 Tainted: G        W           syzkaller #0 PREEMPT(voluntary) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
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
