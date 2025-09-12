Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B631A562
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687241; cv=none; b=rr/7a+xa4GYyycYxF/af5mW/HcWH/53Qfp5cw/s3Vv8KIRQDxQrWzv+jzGce2al7hFpObkHnq9D1gSXtiT+CoMqb+oeH8xItwSkDPFteQSQNdit5Q8aIimXsn+7Ib07tAgxS9SgKitTWjv4vJoxu6Fn+J9FCvzJAxSQ17zCyRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687241; c=relaxed/simple;
	bh=YfO+8lPmCQgRLyxxwDDGR2HDFu4sY+/3cO2TGB3SSyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUNSQfTkZMdGXpEKCkRv08XWYLvOoEcWnAyz1ekcRiT0wVfwlHhP8CgAVu8+0hDSF2fUMnPLZ+btBc9p17a0qSM4nN8MxMGLqNsbLKK8jRXZDVBLMaR9L8TAmlxBawOREQNU4VSzb/W4d/Td4zPwmifeIM71ynJhqHrY0Q59hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCKi2Md1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCKi2Md1"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336b88c5362so19236741fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757687237; x=1758292037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp42ptS/lFplJvsLJJ2EZ8uV0IdN+tX3BkgammP2Hc8=;
        b=GCKi2Md11CChQkuwfI0CsJtVdi+0Tb1mAsuoC3ptyV9wS3TMjVmlRtDiyLLk8Qo/83
         oqIJalsohRQ8/4GftsVeKk3fiDgiW4WG3kMOc3UcQXgWMrB6lAMuEerEc3gxIqBnTYxq
         9LUt0w8LgJPxSQ94F5DVg49oVt9odbOnPNfHyt56VzWVPrK4XO/AdlMhQs2YOILg7Egu
         C45Ol42dfWE3TlF+5kHctVnlm20Iwylc0TdcOtUam+kprur4yp77Sly6XS6U7czBCocr
         y7/xOlTLsmpf3VsiO/pfCetVPXyboBWWJapx+DRkrJVG7WpG7brmqbtScWRrWFbQGHZS
         E28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687237; x=1758292037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp42ptS/lFplJvsLJJ2EZ8uV0IdN+tX3BkgammP2Hc8=;
        b=FSpmHBGUw8GEsZf0osGTgf8yPCQSWTEfoCfok3xrHzIO+67H6PTLjqhk/XC7witHlE
         9rR0zANvlgPn+hmld2naa5CaCeJCvT3dl0Bp8urzPzVmgcM1KpwLAhDLKvws7C8hkom/
         II5tT0Enj2dj2BUj7gVS37BE1OypMc1Fn2jGoSryswECnaSj8P2NRb2W5GWqANT7/W2H
         h6Iu7F89ZcZ5AdsGrKAsax2VnobzJiBqjBPAsvb3FhlTjlEYCNpCRfI62OL48X6L89K4
         vpR3p51f82HRVZTMufTn7o1YbJLgNTComBELFeFGw85RgreRowcdGvX9QQec0zbB4Y6w
         hJug==
X-Forwarded-Encrypted: i=1; AJvYcCUXrdDSNOzvEM24pXXLlmuKESxqGDe/ZMI9o7pXRhaYUFZtZINVFYnUw+shxIpERlHZUTMMbwkFGgANSvi4lgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrC7X/30eZs1c9fQpdf2SxGwikD1RDL2aahYMs5crOcCbYVpOf
	h1MtNumap92uwbIKUiVYhvkR3+RFZcGnNSYiR1QcHQcD9auKtnmQTUhqpSXQQ0OXWPbTRSb2lmU
	FprEkfgFaOi+RB+cKEvkzDXf03XH/SqmFrKfL
X-Gm-Gg: ASbGncs5ROKpYDO0Uey8jTgQMKAVypuwicdkl0FFtMsf+u80eXwLQA8e8XWPFZlL6Q9
	j096O8nvo53IcNbA1pWtDFy4Aasl8trBdVC4ylRPT6/SevLFJgWiEelhePoQMzCRqDeK+RPr+m1
	VaYsMRJ+tCWqcL4CCeq/G+ae3XPVhVfPV7Px9Gza2x0BF1NlauGK60wQ3nuS3cYIOWm7OnUtn93
	cYrzbHZCiWIrjlsf8cDn/2Ejh2oiBq5Ro9O31k8+5fVJue2MEAMGmH4
X-Google-Smtp-Source: AGHT+IE9AqO7lLAlGEzJRsI1Fo10o+h9a52upOozBifG9v9zMi6mHWnXyNwlmei0QGg+VKawzJoact0RA2kdcMOqZ20=
X-Received: by 2002:a2e:b8d0:0:b0:353:6628:54b with SMTP id
 38308e7fff4ca-3536628070cmr1419491fa.11.1757687236797; Fri, 12 Sep 2025
 07:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
In-Reply-To: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Sep 2025 10:27:04 -0400
X-Gm-Features: Ac12FXwPS5Z3qlSE9BObNXFTq8EqKEivecdCUDokf2shveg0O2G7aB2OEDOm544
Message-ID: <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: cen zhang <zzzccc427@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Fri, Sep 12, 2025 at 8:34=E2=80=AFAM cen zhang <zzzccc427@gmail.com> wro=
te:
>
> Hello maintainers,
>
> I would like to report  a use-after-free (UAF) vulnerability
> found in the Bluetooth management subsystem using our
> customized syzkaller on 6.17.0-rc5.
> The bug occurs due to a race condition between HCI command completion
> callbacks and HCI socket bind operations that trigger device cleanup.
>
> After my superficial analysis, the situation when race occurs may be as f=
ollows:
>
> PATH 1 - SET_POWERED Command Execution:
> 1. User space application sends MGMT_OP_SET_POWERED command via HCI
> management socket
> 2. set_powered() function creates mgmt_pending_cmd object via mgmt_pendin=
g_add()
> 3. Command is submitted to HCI work queue via
> hci_cmd_sync_submit()/hci_cmd_sync_queue()
> 4. Work queue executes set_powered_sync() followed by
> mgmt_set_powered_complete() callback
> 5. mgmt_set_powered_complete() attempts to access cmd->param (line 1342)
>
> PATH 2 - HCI Socket Bind Cleanup:
> 1. Another process attempts to bind HCI socket with HCI_CHANNEL_USER mode
> 2. hci_sock_bind() calls mgmt_index_removed() to clean up management stat=
e
> 3. mgmt_index_removed() calls mgmt_pending_foreach(0, hdev, true, ...)
> 4. All pending commands are removed and freed, including the
> SET_POWERED command object

It doesn't only do that it also does:

    /* dequeue cmd_sync entries using cmd as data as that is about to be
     * removed/freed.
     */
    hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);

> 5. The mgmt_pending_cmd object and its cmd->param are freed via
> mgmt_pending_free()
>
> RACE CONDITION:
> The issue occurs when PATH 2 executes between the time PATH 1 submits
> the command
> to the work queue and when the completion callback accesses
> cmd->param. The current
> protection mechanism in mgmt_set_powered_complete() has a TOCTOU
> (Time-of-Check-to-Time-of-Use) flaw:
>
>     if (err =3D=3D -ECANCELED || cmd !=3D pending_find(MGMT_OP_SET_POWERE=
D, hdev))
>         return;

i guess you are talking about pending_find not -ECANCELED having
TOCTOU problem, do you have a reproducer that I can test with?

>
>     cp =3D cmd->param;  // <-- USE-AFTER-FREE occurs here
>
> The check allowing the cmd object to be freed between
> the validation and the actual memory access.
>
> The detail KASAN report as follow:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in
> mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
> Read of size 8 at addr ffff88810edd90b0 by task kworker/u17:3/811
>
> CPU: 0 UID: 0 PID: 811 Comm: kworker/u17:3 Not tainted
> 6.17.0-rc5-ge5bbb70171d1 #7 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x171/0x7f0 mm/kasan/report.c:482
>  kasan_report+0x139/0x170 mm/kasan/report.c:595
>  mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
>  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
>  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
>  kthread+0x3d4/0x800 kernel/kthread.c:463
>  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Allocated by task 197:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
>  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
>  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
>  set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1407
>  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
>  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:729
>  sock_write_iter+0x1b7/0x250 net/socket.c:1179
>  do_iter_readv_writev+0x598/0x760
>  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
>  do_writev+0x105/0x270 fs/read_write.c:1103
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 100890:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:243 [inline]
>  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2428 [inline]
>  slab_free mm/slub.c:4701 [inline]
>  kfree+0x189/0x390 mm/slub.c:4900
>  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
>  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
>  mgmt_index_removed+0x164/0x530 net/bluetooth/mgmt.c:9370
>  hci_sock_bind+0x151a/0x1f30 net/bluetooth/hci_sock.c:1314
>  __sys_bind_socket net/socket.c:1858 [inline]
>  __sys_bind+0x229/0x2f0 net/socket.c:1889
>  __do_sys_bind net/socket.c:1894 [inline]
>  __se_sys_bind net/socket.c:1892 [inline]
>  __x64_sys_bind+0x7a/0x90 net/socket.c:1892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff88810edd9080
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 48 bytes inside of
>  freed 96-byte region [ffff88810edd9080, ffff88810edd90e0)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10ed=
d9
> anon flags: 0x200000000000000(node=3D0|zone=3D2)
> page_type: f5(slab)
> raw: 0200000000000000 ffff888100042280 ffffea00041e07c0 dead000000000003
> raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88810edd8f80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>  ffff88810edd9000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >ffff88810edd9080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                      ^
>  ffff88810edd9100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff88810edd9180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Best regards,
> Cen Zhang



--=20
Luiz Augusto von Dentz
