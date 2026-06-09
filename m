Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C040759C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006402; cv=pass; b=Bp0B8RzfmzaxZ3jxPuAI4xITbAae44VYJ55eEvWIs6vgqPbkBSvLDAPZaojnkxiP8v0YuefI6Irda063MExRt1v4mLY4iopM5OJOKR93ZljrNa7Bz8fW2zTOmJxf780pNiFXT1wLFdELDAxSHa/wgMT+Ca9ClsMl+ss/CcMAsTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006402; c=relaxed/simple;
	bh=VFZGYEfprjgQPowH16uyybh6ijJ1Gf3urWpm9uvuHSI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ALMNQLdtIB/Z2CugUQ7sgur14sxWgBpUQSU6XUTcA0kdo/S+0nj1dFK2dAfMjDIH/HCrSsqLiRK2tPxRAHL4NLkqIJ53O1HNBFu7k4qGPBfdrrbJM1ZLm57KfAc6AHbbt7kXeiix4dVE/gNDjxAIgsGaT5BeXdN9Kqb621288rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh8OsTvY; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh8OsTvY"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8ce9df4732cso56521856d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 04:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781006394; cv=none;
        d=google.com; s=arc-20240605;
        b=DryOH9oljDjT4cslM6S5D0cffQcrAXrQFkPnaccUgEHMvn8MI9yDagda/PBetZk9fd
         agFW9WX9JpaDxDdBNrWYhjNY5/htfaHunXZqOAxTv6k56ZkHq3lz/kB3be15N8IqIYIA
         A0XWASRyRI14awqo3Bt87lpK9YD6fm/aXMwecCB8wuI+JsX0S3LUL8zz9t0lUYWcvphT
         9/os9BT2aTEx8SXzNj7r/G1inhHQOPYVC3OGbrMyM4FK5THXgt40bVUGU3/MEgMj4tw9
         GcJHryAeMEJSBbs1hiADalviIdskufjwiiCIUfsfr7R+4jLxPPHMCKwB+nOp4ZqZj04i
         8EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sDDgxtE2xASDchtUWm/Z/6NHY75BPRdV815WylY1ZLg=;
        fh=sHzMenK0vU01zRFPQ1a7fx+cDaGbUN4Gthj9BLFNxM8=;
        b=UdpL1rXLRN6xEnszgjlez5aFZtszJrnnAba2xbIFbi3SVNss2a5rDEHYgDa+92ON5G
         CazVC3PJ/HH1mhdXEkW1oSECzbYlF6X/2RdPL5akFhzmt8/UYtHKav6t1qbVv4dm7UA0
         /qMQ0XHPx2UnoXewyaPlnnP98zSzO/1OtVVz8Alt2dJ5te+XN22voVVAihRypAHIUMOo
         SLFtaPibtaQhJjcc0Lb3Daix581XC5DfTHDPg08Zb713qzmax7r+rLlWyxlsZPkr9W2V
         XpiZSgjIpBOUWGOnT5ZLD6LC2970JtgE1aA/HOlTN6X678ryBkZfIIp1cyQ/EHtUd8e3
         DwGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781006394; x=1781611194; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDDgxtE2xASDchtUWm/Z/6NHY75BPRdV815WylY1ZLg=;
        b=Oh8OsTvYxHo8v40tQljn7BlwCqC2V5UR5Vv2Yr/Rs2ffKyboHqbRkSpFg5Q/mp4sw2
         IyZ7i2DSmFeJhu297NiJiC77eul3vZ5kUvEl1a5Mv6mZQbza25gteUvMfd9/fmcgYAZG
         8shtTQ3xkTKifzlik5HSuFDH6c6e7uW0NgQT0SEDqqhSxpZ3aBANFy2q4S3Ac5KJLBWD
         1qqKFYw8GGk3YCoJ4wShyzp90/4ynlVyqJZuOJTD+olZkZY6VbbLkaintMT3HR9JF+S8
         L3GA1DuCa5tHkEWGHq8akeyhiKtgwjSzg7muf2Z/aXk6WsN5cMjkcqF2QuF/xwRTo4mB
         h2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006394; x=1781611194;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDDgxtE2xASDchtUWm/Z/6NHY75BPRdV815WylY1ZLg=;
        b=qjhmZBn28SrTBbsotw7eLGC5NLJlqyZPYMUqw8y4IAlFapYTS1JNssilJcUX5oGMU+
         xHZwUA59qWkVHQ8YN8vsZ2gPNj9QWNisi4CCEk9qssyUFUv30OeeOGnzhUfKaXLAL8zX
         dJubO2mgSyE0OlP3t3CQsKVKLs2bRi9SOPOtphrBxIPV7IMu05QrctSQ97bKLFBHyRye
         I4mzoTovui4d/DPJ4xn0RSUrIL08fco2dcnBVIc7xZIZF8aOqgzqIgx4wg1yryXB6jhC
         2kfkjqJN4i1u916Uzyl/M7v2XhR/MrR721QDpVMVRZm7I5WDygfSzGIX+QsJ5Si2Vjym
         UZOQ==
X-Forwarded-Encrypted: i=1; AFNElJ90l+L7mjnM5FZg1n/zW16ZkoUGOBByWg/KUrNa6Uv8ri8kJXJNt1b/jLOyMaVofPVheMe0thTFfT9D3frcTs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBq7al/7kw74yLid06KpCgKI32Qqsxjx0g3pq5ZjG/pIYx0LH0
	6yMDGVL/gxy2WkOl8Ud1wNu604qfD4JyjxYEU8ptvHfJqGVEijTO/WVx8qGoYlupGJbtEtIpb1E
	qzwd6WvElqvDaqBqjvHlBfYO/+/5ouDXitzJUGBtnDw==
X-Gm-Gg: Acq92OF2ZYQtqOeFYG+SCbF88FTChCZyFVJ3CaUYDswBhAK/mJTCIzs/0xGFZ4BZ6eK
	Czz663UTQc6EaKbY3LX6fd9KciSbc7Ckz0EDGAyi5O5kgSuOSWmSU+sh36jJVgviE6ajbfoQJ19
	RCUq7NhO0w2l695LWiIIpVqWdXmKs2c8lNh+GfQ6Bubb/3QFoEuEmkUzC8VerIQoemf4k237148
	U7/UpOmBwQ53f10Ozd1N3Ja/QKlCSd0m9BKkYO4vfmKFqtNl71dGeLDr6l1d+qMeoUR7wP3r8g5
	0yjfg+MKtprrX08myw==
X-Received: by 2002:a05:6214:27cb:b0:8a1:478a:e58a with SMTP id
 6a1803df08f44-8cee62776admr311546606d6.36.1781006393715; Tue, 09 Jun 2026
 04:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:59:41 +0800
X-Gm-Features: AVVi8CeoEMKbPkWW1bqzUZfNFWHD-Z-cCdhoPuFlr-85LF8ruUMbduj_khDQlwA
Message-ID: <CAHPqNmzmt2SW_gJDacW5EzZowkjBYM7qaMqPaY9anYN5TxrmDg@mail.gmail.com>
Subject: [Kernel Bug] possible deadlock in vhci_send_frame
To: syzkaller@googlegroups.com, marcel@holtmann.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. possible
deadlock in vhci_send_frame. Details are as follows.

Kernel commit: v5.15.189
Kernel config: see attachment
report: see attachment
C repro and Syz repro: see attachment

We are currently analyzing the root cause. We will provide further
updates in this thread as soon as we have more information.

Best regards,
Longxing Li

======================================================
WARNING: possible circular locking dependency detected
5.15.189 #1 Not tainted
------------------------------------------------------
kworker/u3:2/7652 is trying to acquire lock:
ffff88801c5ea518 (&data->open_mutex){+.+.}-{3:3}, at:
vhci_send_frame+0xb0/0x120 drivers/bluetooth/hci_vhci.c:71

but task is already holding lock:
ffffc90001effda0 ((work_completion)(&hdev->cmd_work)){+.+.}-{0:0}, at:
process_one_work+0x8f5/0x1530 kernel/workqueue.c:2285

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&hdev->cmd_work)){+.+.}-{0:0}:
       __flush_work+0x12d/0xc10 kernel/workqueue.c:3090
       hci_dev_do_open+0xab6/0x1b40 net/bluetooth/hci_core.c:1626
       hci_power_on+0x133/0x680 net/bluetooth/hci_core.c:2265
       process_one_work+0x9db/0x1530 kernel/workqueue.c:2310
       worker_thread+0x686/0x1180 kernel/workqueue.c:2457
       kthread+0x3d0/0x4c0 kernel/kthread.c:334
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287

-> #2 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x183/0x1300 kernel/locking/mutex.c:729
       hci_dev_do_close+0x5d/0x1250 net/bluetooth/hci_core.c:1737
       hci_rfkill_set_block+0x1be/0x210 net/bluetooth/hci_core.c:2235
       rfkill_set_block+0x200/0x550 net/rfkill/core.c:345
       rfkill_sync_work+0x8a/0xc0 net/rfkill/core.c:1030
       process_one_work+0x9db/0x1530 kernel/workqueue.c:2310
       worker_thread+0x686/0x1180 kernel/workqueue.c:2457
       kthread+0x3d0/0x4c0 kernel/kthread.c:334
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287

-> #1 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x183/0x1300 kernel/locking/mutex.c:729
       rfkill_register+0x36/0xb00 net/rfkill/core.c:1045
       hci_register_dev+0x440/0xd90 net/bluetooth/hci_core.c:3960
       __vhci_create_device+0x2c8/0x5e0 drivers/bluetooth/hci_vhci.c:129
       vhci_create_device drivers/bluetooth/hci_vhci.c:153 [inline]
       vhci_get_user drivers/bluetooth/hci_vhci.c:210 [inline]
       vhci_write+0x2c0/0x460 drivers/bluetooth/hci_vhci.c:290
       call_write_iter include/linux/fs.h:2172 [inline]
       new_sync_write+0x4b2/0x680 fs/read_write.c:507
       vfs_write+0x7d9/0xb40 fs/read_write.c:594
       ksys_write+0x13a/0x260 fs/read_write.c:647
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x66/0xd0

-> #0 (&data->open_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3053 [inline]
       check_prevs_add kernel/locking/lockdep.c:3172 [inline]
       validate_chain kernel/locking/lockdep.c:3788 [inline]
       __lock_acquire+0x293e/0x5590 kernel/locking/lockdep.c:5012
       lock_acquire kernel/locking/lockdep.c:5623 [inline]
       lock_acquire+0x1a8/0x4c0 kernel/locking/lockdep.c:5588
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x183/0x1300 kernel/locking/mutex.c:729
       vhci_send_frame+0xb0/0x120 drivers/bluetooth/hci_vhci.c:71
       hci_send_frame+0x1c0/0x400 net/bluetooth/hci_core.c:4256
       hci_cmd_work+0x223/0x3b0 net/bluetooth/hci_core.c:5201
       process_one_work+0x9db/0x1530 kernel/workqueue.c:2310
       worker_thread+0x686/0x1180 kernel/workqueue.c:2457
       kthread+0x3d0/0x4c0 kernel/kthread.c:334
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287

other info that might help us debug this:

Chain exists of:
  &data->open_mutex --> &hdev->req_lock --> (work_completion)(&hdev->cmd_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&hdev->cmd_work));
                               lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->cmd_work));
  lock(&data->open_mutex);

 *** DEADLOCK ***

2 locks held by kworker/u3:2/7652:
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888057be9938 ((wq_completion)hci0#3){+.+.}-{0:0}, at:
process_one_work+0x8c1/0x1530 kernel/workqueue.c:2281
 #1: ffffc90001effda0
((work_completion)(&hdev->cmd_work)){+.+.}-{0:0}, at:
process_one_work+0x8f5/0x1530 kernel/workqueue.c:2285

stack backtrace:
CPU: 0 PID: 7652 Comm: kworker/u3:2 Not tainted 5.15.189 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_cmd_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
 check_noncircular+0x277/0x310 kernel/locking/lockdep.c:2133
 check_prev_add kernel/locking/lockdep.c:3053 [inline]
 check_prevs_add kernel/locking/lockdep.c:3172 [inline]
 validate_chain kernel/locking/lockdep.c:3788 [inline]
 __lock_acquire+0x293e/0x5590 kernel/locking/lockdep.c:5012
 lock_acquire kernel/locking/lockdep.c:5623 [inline]
 lock_acquire+0x1a8/0x4c0 kernel/locking/lockdep.c:5588
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x183/0x1300 kernel/locking/mutex.c:729
 vhci_send_frame+0xb0/0x120 drivers/bluetooth/hci_vhci.c:71
 hci_send_frame+0x1c0/0x400 net/bluetooth/hci_core.c:4256
 hci_cmd_work+0x223/0x3b0 net/bluetooth/hci_core.c:5201
 process_one_work+0x9db/0x1530 kernel/workqueue.c:2310
 worker_thread+0x686/0x1180 kernel/workqueue.c:2457
 kthread+0x3d0/0x4c0 kernel/kthread.c:334
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:287
 </TASK>

==================================================================
https://drive.google.com/file/d/13nr1pPRHCrZqYxz08ngNiCvmcRe-d_oK/view?usp=drive_link

https://drive.google.com/file/d/11Ox0bimeaa3r8BaGqhXBBymrs03Haz8o/view?usp=drive_link

https://drive.google.com/file/d/1yA-bbVeMCxS_p7ZjDH97NK4iI_1CLeAz/view?usp=drive_link

https://drive.google.com/file/d/1XqJJtZ0jKV_oFm8M6SuQV2YAuKEqWHbn/view?usp=drive_link
