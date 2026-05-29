Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E9408032
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078920; cv=none; b=oAUuSX7DR6uuRoTdRskEtCcizHhPMiGdKYAymJpZch9TxQbvx4hZKXEVED9ms2yZXuTzLPLQC9r8FrDwX/NDJOyrfEoxRemOuRxKSdrnv1sNCe6Q7WunEfMub6wWRKqtitg5lHSVzUOZ8IA5Vmd/Up1Oe2sCRHxj9UTKPXOnorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078920; c=relaxed/simple;
	bh=+0opIASvA6kmwebmwZmCyU1ilTIyanf2hXpZrHmMwxQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rs9IQzI+1Ctpjhwbr3KhiuyZ80IwH6wueEKMX8ujWMzLjK92O2RQkadbYsz7kXdEOquU24dInSVoKHZs0HpTpqLAMrik0X/JDyYuV+/R+Z5dm36nbarou3QQUnfGUV2bdIreEv14NIMqrXEmZFijCVxcjWlp0lW3qVAwxv6gUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqvH45MT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqvH45MT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-913cc4d7c71so1562732485a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780078917; x=1780683717; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dl6FOaCGRVJ4DVlZ9g7qt9qvWvEv/24DeNAmdGnBzr4=;
        b=kqvH45MTCeSKcvwWBSD8r8vncNHs1LnbV4SuTFYjhSciCQjDIhQgc/bUZhlfS1d+RL
         OWEGItlx68expx9UQVAxspUrbbJ7SOEDIJQP4gP8fK8XPH9V3DfsYYhZBH7pk9B8puhC
         yw//Qc0EsV0qRsbYrL1iXg4dZ54Hug/wL3lnmwokUwSQU7qCofWcdVICiCF+SnD4DaLV
         ru0I4sGbD4RodpesTywemOsYbEHEgaXHj6sl5WLnq/4x6dFYDWHuzZ8a0dtiZxJCCTx8
         Mqxv3fS9/cmuPJ3/yTQ1rEYnwyZFY06gGK8hRw774SICO6NDbSIYxCY2GOcTwlnoak7K
         YHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780078917; x=1780683717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl6FOaCGRVJ4DVlZ9g7qt9qvWvEv/24DeNAmdGnBzr4=;
        b=DFSqcmE+PgLHKNv/RLUVThKWnaNRh8ytTO3aEMBF4Ilys7F9ZY3wnBC+RVrQJs9LNR
         8LhrYf+XWsTK1A1ZHDc/N3UpyrhLshx/doruxw/6fp8P8oEl6wDBmtiL/qySuo7ktzGx
         6ckZMU2MpLE+Dkhs/R02GWLPLteg8TQPpeGYiCM/hnpoIwv16VOwXqXcXYYtMHcCo7N3
         LpOBxzY5CzJ2Km46jikK8stJE27b0wGC5dHT2atKXpmth/w5SR9N9dPKuuPGRCy+05Vd
         Xr5Z5WOp/7h5EHhCIdr8aiKQTlDMZ+a4xSYZMb81+scJtJq4L9Ri/3tZqqz26KIEWSke
         Qb2w==
X-Gm-Message-State: AOJu0Yx/mz0Fes+0gSqMtvayWS0RewKGDmfGhidyS0RTphGwD1U9DCjG
	eZV7XTL0vCtcv55HAT3z+//O9wq8ZjzjBYvcYjTYmHvfsy3JM0aFsSWcqCkxLiMN
X-Gm-Gg: Acq92OH2lnP610pV3viEmGyOZq3/11oRfJnZGG9kth+2c6FZ6CeM+oal3UgdKfzCY12
	TCCZ6ZX71POFRubNcqu1XO1DAFGSwFakpkYYoMWLKn8T93XvSibbKqUHaHNCGvVLz5Pce6e4VGJ
	sD5zTQiv8x/Xmxr/u2KQbSPQ5Cx0ObXQrobv1hJeItjKeN563gTK/r1zkwNKVkfrpWv1ocCPp6x
	c6lT2oYlCa+4/XkW/ZHuomD5uDMmG852LwB+7CKvBG/vF5o28GOdJ5O2DWQoTMraJZKM0MLh25X
	VEERfcTtuFELFPyG37hp+0odOWdiaxZVU/WlNVPHTturthzyEMeVOOHZcagNkdqsxqsL1BwQbGx
	gsFajnXHVXY9zzkvrP6cVroJlXB6GZoPnQiXrUHvIjnoh4TjEHoHxYcDFnYzfgav8lpCwlOR4mW
	dAB/cTXCNiYBWS22/b+xsNWjwbs5FtWvd4zBsJFpU=
X-Received: by 2002:a05:620a:a0cc:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9153d9703c3mr105292185a.20.1780078916549;
        Fri, 29 May 2026 11:21:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.210.0.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532650e85sm259058085a.42.2026.05.29.11.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:21:56 -0700 (PDT)
Message-ID: <6a19d944.d5c1a6d7.11742.b500@mx.google.com>
Date: Fri, 29 May 2026 11:21:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4016278968487065903=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260529165449.3553936-2-oss@fourdim.xyz>
References: <20260529165449.3553936-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4016278968487065903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103029

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.47 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      26.54 seconds
BuildKernel32                 PASS      24.52 seconds
TestRunnerSetup               PASS      530.14 seconds
TestRunner_l2cap-tester       FAIL      55.83 seconds
TestRunner_smp-tester         FAIL      23.82 seconds
TestRunner_6lowpan-tester     FAIL      22.93 seconds
IncrementalBuild              PASS      25.60 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
WARNING: held lock freed!
7.1.0-rc1-g5f2fcd0833d0 #1 Not tainted
-------------------------
memcheck-amd64-/34 is freeing memory ffff888002762000-ffff8880027627ff, with a lock still held there!
ffff888002762508 (&chan->lock#4){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660
5 locks held by memcheck-amd64-/34:
 #0: ffff8880026e0e80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x5d/0x90
 #1: ffff8880026e00b0 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x2ca/0xfa0
 #2: ffffffffb92bc278 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xed/0x230
 #3: ffff8880022ec2f0 (&conn->lock){+.+.}-{4:4}, at: l2cap_conn_del+0x9b/0x660
 #4: ffff888002762508 (&chan->lock#4){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660

stack backtrace:
CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 debug_check_no_locks_freed+0x102/0x140
 ? l2cap_chan_del+0x220/0x770
 kfree+0x22b/0x4c0
 ? _raw_write_unlock+0x1e/0x40
 l2cap_chan_del+0x220/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002db9d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
...
BUG: KASAN: slab-use-after-free in l2cap_chan_del+0x6ee/0x770
Write of size 8 at addr ffff888002762000 by task memcheck-amd64-/34

CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 print_report+0x108/0x5c0
 ? __virt_addr_valid+0x21c/0x3f0
 ? l2cap_chan_del+0x6ee/0x770
 kasan_report+0x94/0xc0
 ? l2cap_chan_del+0x6ee/0x770
 l2cap_chan_del+0x6ee/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002db9d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000005229e80 R09: 0000000000000040
R10: 00000000000002fa R11: 0000000000000206 R12: 0000001002386e20
R13: 0000001002008360 R14: 0000000000000003 R15: 0000001002db9d70
Total: 96, Passed: 96 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: held lock freed!
7.1.0-rc1-g5f2fcd0833d0 #1 Not tainted
-------------------------
memcheck-amd64-/34 is freeing memory ffff8880021b6000-ffff8880021b67ff, with a lock still held there!
ffff8880021b6508 (&chan->lock#3){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660
5 locks held by memcheck-amd64-/34:
 #0: ffff8880024e4e80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x5d/0x90
 #1: ffff8880024e40b0 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x2ca/0xfa0
 #2: ffffffffb6ebc278 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xed/0x230
 #3: ffff8880022fb2f0 (&conn->lock){+.+.}-{4:4}, at: l2cap_conn_del+0x9b/0x660
 #4: ffff8880021b6508 (&chan->lock#3){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660

stack backtrace:
CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 debug_check_no_locks_freed+0x102/0x140
 ? l2cap_chan_del+0x220/0x770
 kfree+0x22b/0x4c0
 ? _raw_write_unlock+0x1e/0x40
 l2cap_chan_del+0x220/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002db5d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
...
BUG: KASAN: slab-use-after-free in l2cap_chan_del+0x6ee/0x770
Write of size 8 at addr ffff8880021b6000 by task memcheck-amd64-/34

CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 print_report+0x108/0x5c0
 ? __virt_addr_valid+0x21c/0x3f0
 ? l2cap_chan_del+0x6ee/0x770
 kasan_report+0x94/0xc0
 ? l2cap_chan_del+0x6ee/0x770
 l2cap_chan_del+0x6ee/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002db5d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
RBP: 0000000000000001 R08: 0000000004c198e0 R09: 0000000000000040
R10: 0000000000000002 R11: 0000000000000206 R12: 0000001002386e20
R13: 0000001002008360 R14: 0000000000000003 R15: 0000001002db5d70
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: held lock freed!
7.1.0-rc1-g5f2fcd0833d0 #1 Not tainted
-------------------------
memcheck-amd64-/34 is freeing memory ffff8880026af000-ffff8880026af7ff, with a lock still held there!
ffff8880026af508 (&chan->lock#4){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660
5 locks held by memcheck-amd64-/34:
 #0: ffff8880025ece80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x5d/0x90
 #1: ffff8880025ec0b0 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x2ca/0xfa0
 #2: ffffffff84ebc278 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flush+0xed/0x230
 #3: ffff888001fcbaf0 (&conn->lock){+.+.}-{4:4}, at: l2cap_conn_del+0x9b/0x660
 #4: ffff8880026af508 (&chan->lock#4){+.+.}-{4:4}, at: l2cap_conn_del+0x33b/0x660

stack backtrace:
CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 debug_check_no_locks_freed+0x102/0x140
 ? l2cap_chan_del+0x220/0x770
 kfree+0x22b/0x4c0
 ? _raw_write_unlock+0x1e/0x40
 l2cap_chan_del+0x220/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002cb5d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
...
BUG: KASAN: slab-use-after-free in l2cap_chan_del+0x6ee/0x770
Write of size 8 at addr ffff8880026af000 by task memcheck-amd64-/34

CPU: 0 UID: 0 PID: 34 Comm: memcheck-amd64- Not tainted 7.1.0-rc1-g5f2fcd0833d0 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 print_report+0x108/0x5c0
 ? __virt_addr_valid+0x21c/0x3f0
 ? l2cap_chan_del+0x6ee/0x770
 kasan_report+0x94/0xc0
 ? l2cap_chan_del+0x6ee/0x770
 l2cap_chan_del+0x6ee/0x770
 l2cap_conn_del+0x346/0x660
 hci_conn_hash_flush+0x135/0x230
 hci_dev_close_sync+0x4f8/0xfa0
 hci_dev_do_close+0x65/0x90
 hci_unregister_dev+0x254/0x510
 vhci_release+0x183/0x240
 __fput+0x356/0x9c0
 ? lock_is_held_type+0x9b/0x110
 fput_close_sync+0xd6/0x180
 ? __pfx_fput_close_sync+0x10/0x10
 __x64_sys_close+0x78/0xd0
 do_syscall_64+0x9f/0x560
 entry_SYSCALL_64_after_hwframe+0x74/0x7c
RIP: 0033:0x5805ccc9
Code: 00 e8 eb a4 fe ff 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 8d 87 ff 0f 00 00 89 fa 89 ff 3d
RSP: 002b:0000001002cb5d08 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000001002386d90 RCX: 000000005805ccc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000004c205f0 R09: 0000000000000040
R10: 0000000000000002 R11: 0000000000000206 R12: 0000001002386e20
R13: 0000001002008360 R14: 0000000000000003 R15: 0000001002cb5d70
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


https://github.com/bluez/bluetooth-next/pull/256

---
Regards,
Linux Bluetooth


--===============4016278968487065903==--
