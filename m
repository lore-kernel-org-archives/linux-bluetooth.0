Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53831289E36
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692762; cv=none; b=DX+Y2gD74WGYOb8M1MLEv6Y8mT4Lafv8KwN6yuwV1Zwe6of8VOpbhXuTFaW971hYIxQslm2w0vnwTVPDL+YI2LEyHJHXA5dKWj3dFOmJRqnIGyr+WzxueaVY6GPVCbBhT4cEWM029TYw5wezTOJOlqshcoWmwep1xOvbbR9BuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692762; c=relaxed/simple;
	bh=TuAzyNPGnwVNiEBJHxM/Ls2i5o0BOH8PQQAsR59WEKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvJY/IxD2oDOL7RRoBZpGHt7+En34HHcLyzzWPOCqaUNttdCgvJC3jqXe+oJa8s7U8AJENYqCXxjaRhMGtA5DAc1sOwXpIEU/0LzkmEA/vIb3NMR8ooMDLt7zdWdloNWuj7I4oXNRDFdstsDnKks+Ffh0ilBQ5ygTXO39OykP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPfpl4LI; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPfpl4LI"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-60f476e97c3so1287359d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692759; x=1758297559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0Cr1L3C1DrWZsQV8RyCWXKMvihSUdo/Iyu9CmnOxbM=;
        b=WPfpl4LIvc1n41EnqMfz0LH705SF2x9Jbo0JhaktJYwKNSaMDQoJfylextHidPKarN
         1toAVBWBB460JkR1wKlrmJCiWEnyZAvRaPdHXPDmfGQzKEteO7dnv09zLphTeDzsSqsw
         rFU+VkXMHK4Pj4wgNMp1bQfglau0PF5tChHcNt7GzDNGDUcSrexPx7pVUDilIhPDfC/z
         HhwnIUyebbTXd7DSN+MvZ2d+AYsuBEmkafaQ+C3QhPSbSgM1MGGf2xUDnF0dNSlKD6S0
         JKOz/9ZgFxYjATLPWEtP1gwpVFm9bWz9/mynxpJgZuoq4XJI3Yo2P8YWCTj4qInVg5eL
         VgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692759; x=1758297559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0Cr1L3C1DrWZsQV8RyCWXKMvihSUdo/Iyu9CmnOxbM=;
        b=W0S/21UzaR+N0ePigMESX/TkGRp+jCWbpOXFFMiqheC472j6Oh2YZD1PCwzYd7Wwv/
         1PjSBgNME6HcOl2AJ/dw07XlWOTldej7syA+Ij98zEltz47rIhYEoiMYv0Rl5DPO0U3F
         VVnCscPhMHR2HJQpjvIUrIHz865HhDmJWi+QB3NWcLE89J2gOp0YIqxWLygXYLz99w2Z
         9d9wmNytWPy+OsRSybMeprKRmKXkQwgWFFiXklKPjo4j6HjseKA8DovIOP9gqTZPa+LD
         z5A2fBIjRqpmr0JBpAGGPO4Y0FwT7HKneZoRlCt+qAB0qKB5eorL3YSozMnslesVQuA5
         35zA==
X-Forwarded-Encrypted: i=1; AJvYcCUuPZIOiv5TwtWRF2/l1o0XnWDACcNVXOAOqGMaKKfe2wFCBm2RJ6rOeC8sS2YnXX/kbRDeHGrbMRuI+xfTnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkd9jGbH/Uzs+GDbwKSBtv1QFPQ3jgKgj4JwNqoAbM9nypUUcl
	EwV2t+5SwWzhf2j3MCRl400qkFKfykWLldCR+WG48Y3+PSrenUx+BScD03dc20IJSK7WOizg7d3
	MxEONG1vPb1eQnFuJO1a4IWYrcjT4lWY=
X-Gm-Gg: ASbGnctmahuMW8ODPCmfaHqQje9Uwe40pgwBsHC5uRdHONWlxioDfVx04XGzoSCjk2W
	u48POJEbhhd+7ry1yGZhtyjkqd3tBpJ8SgxidxN1TjfWGo3yLswAoWY+gIUTfyiz+nlv3cc7Piq
	j6zzmiqrXvUGoCQ9VzSF8SmpicN5GFhpmdx5ZNE2SmTeTH45qgGYGJVNasQXrHwykBX6ukjxUco
	D26hGHA/qKIv3li
X-Google-Smtp-Source: AGHT+IHN4SUZhdnPTVvomHmuEMOMHmI1+MjG0jdorWAdIM7GN744ycMdH7qzyb9hsoNMEsEO0X8VoIyWeQbkBn/YxEM=
X-Received: by 2002:a05:690e:2247:b0:5fc:5d98:3478 with SMTP id
 956f58d0204a3-6271d70d75emr2359769d50.7.1757692758977; Fri, 12 Sep 2025
 08:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
 <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
In-Reply-To: <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
From: cen zhang <zzzccc427@gmail.com>
Date: Fri, 12 Sep 2025 23:59:06 +0800
X-Gm-Features: Ac12FXxqawp43xXlxJUlugCa9sdxcFslfoZfhAPJQvvKeWVdmKhLV7tTq6KxUJQ
Message-ID: <CAFRLqsUE84wW0JKbsh6Lw0USQbnCbokXd3PANc+4i_nsnEUMYA@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thank you for your quick response and the important clarification
about hci_cmd_sync_dequeue().

You are absolutely correct - I was indeed referring to the TOCTOU
problem in pending_find(), not the -ECANCELED check. The
hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a crucial detail
that I initially overlooked in my analysis.

After examining the code more carefully, I can see that while
hci_cmd_sync_dequeue() does attempt to remove pending sync commands
from the queue, but it cannot prevent the race condition we're seeing.
The fundamental issue is that hci_cmd_sync_dequeue() can only remove
work items that are still queued, but cannot stop work items that are
already executing or about to execute their completion callbacks.

The race window occurs when:
1. mgmt_set_powered_complete() is about to execute (work item has been dequ=
eued)
2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_complete_rsp() exe=
cutes
3. hci_cmd_sync_dequeue() removes queued items but cannot affect the
already-running callback
4. mgmt_pending_free() frees the cmd object
5. mgmt_set_powered_complete() still executes and accesses freed cmd->param

I am sorry that I haven't get a reliable reproducer from syzkaller for
this bug may be due to it is timing-sensitive.


Best regards,
Cen Zhang

Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=BA=94 22:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> On Fri, Sep 12, 2025 at 8:34=E2=80=AFAM cen zhang <zzzccc427@gmail.com> w=
rote:
> >
> > Hello maintainers,
> >
> > I would like to report  a use-after-free (UAF) vulnerability
> > found in the Bluetooth management subsystem using our
> > customized syzkaller on 6.17.0-rc5.
> > The bug occurs due to a race condition between HCI command completion
> > callbacks and HCI socket bind operations that trigger device cleanup.
> >
> > After my superficial analysis, the situation when race occurs may be as=
 follows:
> >
> > PATH 1 - SET_POWERED Command Execution:
> > 1. User space application sends MGMT_OP_SET_POWERED command via HCI
> > management socket
> > 2. set_powered() function creates mgmt_pending_cmd object via mgmt_pend=
ing_add()
> > 3. Command is submitted to HCI work queue via
> > hci_cmd_sync_submit()/hci_cmd_sync_queue()
> > 4. Work queue executes set_powered_sync() followed by
> > mgmt_set_powered_complete() callback
> > 5. mgmt_set_powered_complete() attempts to access cmd->param (line 1342=
)
> >
> > PATH 2 - HCI Socket Bind Cleanup:
> > 1. Another process attempts to bind HCI socket with HCI_CHANNEL_USER mo=
de
> > 2. hci_sock_bind() calls mgmt_index_removed() to clean up management st=
ate
> > 3. mgmt_index_removed() calls mgmt_pending_foreach(0, hdev, true, ...)
> > 4. All pending commands are removed and freed, including the
> > SET_POWERED command object
>
> It doesn't only do that it also does:
>
>     /* dequeue cmd_sync entries using cmd as data as that is about to be
>      * removed/freed.
>      */
>     hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
>
> > 5. The mgmt_pending_cmd object and its cmd->param are freed via
> > mgmt_pending_free()
> >
> > RACE CONDITION:
> > The issue occurs when PATH 2 executes between the time PATH 1 submits
> > the command
> > to the work queue and when the completion callback accesses
> > cmd->param. The current
> > protection mechanism in mgmt_set_powered_complete() has a TOCTOU
> > (Time-of-Check-to-Time-of-Use) flaw:
> >
> >     if (err =3D=3D -ECANCELED || cmd !=3D pending_find(MGMT_OP_SET_POWE=
RED, hdev))
> >         return;
>
> i guess you are talking about pending_find not -ECANCELED having
> TOCTOU problem, do you have a reproducer that I can test with?
>
> >
> >     cp =3D cmd->param;  // <-- USE-AFTER-FREE occurs here
> >
> > The check allowing the cmd object to be freed between
> > the validation and the actual memory access.
> >
> > The detail KASAN report as follow:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in
> > mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
> > Read of size 8 at addr ffff88810edd90b0 by task kworker/u17:3/811
> >
> > CPU: 0 UID: 0 PID: 811 Comm: kworker/u17:3 Not tainted
> > 6.17.0-rc5-ge5bbb70171d1 #7 PREEMPT(voluntary)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> >  mgmt_set_powered_complete+0x83d/0xf10 net/bluetooth/mgmt.c:1342
> >  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
> >  process_one_work kernel/workqueue.c:3236 [inline]
> >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> >  kthread+0x3d4/0x800 kernel/kthread.c:463
> >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 197:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> >  kmalloc_noprof include/linux/slab.h:905 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> >  set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1407
> >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> >  sock_sendmsg_nosec net/socket.c:714 [inline]
> >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> >  do_iter_readv_writev+0x598/0x760
> >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> >  do_writev+0x105/0x270 fs/read_write.c:1103
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 100890:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:243 [inline]
> >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2428 [inline]
> >  slab_free mm/slub.c:4701 [inline]
> >  kfree+0x189/0x390 mm/slub.c:4900
> >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> >  mgmt_index_removed+0x164/0x530 net/bluetooth/mgmt.c:9370
> >  hci_sock_bind+0x151a/0x1f30 net/bluetooth/hci_sock.c:1314
> >  __sys_bind_socket net/socket.c:1858 [inline]
> >  __sys_bind+0x229/0x2f0 net/socket.c:1889
> >  __do_sys_bind net/socket.c:1894 [inline]
> >  __se_sys_bind net/socket.c:1892 [inline]
> >  __x64_sys_bind+0x7a/0x90 net/socket.c:1892
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff88810edd9080
> >  which belongs to the cache kmalloc-96 of size 96
> > The buggy address is located 48 bytes inside of
> >  freed 96-byte region [ffff88810edd9080, ffff88810edd90e0)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10=
edd9
> > anon flags: 0x200000000000000(node=3D0|zone=3D2)
> > page_type: f5(slab)
> > raw: 0200000000000000 ffff888100042280 ffffea00041e07c0 dead00000000000=
3
> > raw: 0000000000000000 0000000000200020 00000000f5000000 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff88810edd8f80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
> >  ffff88810edd9000: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >ffff88810edd9080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >                                      ^
> >  ffff88810edd9100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >  ffff88810edd9180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Best regards,
> > Cen Zhang
>
>
>
> --
> Luiz Augusto von Dentz
