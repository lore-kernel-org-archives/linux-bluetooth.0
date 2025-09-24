Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513B301477
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715172; cv=none; b=nYNLPB7Aj30h9AxXH5jwUZcjp4alQRWiMwMFiLIoZrBBwkIaQ2MAuwXEl3aZuYty235sEP7/5dcBCIsUXIXViQfVRrohJHFdMmSnl9+BhU6BAEVmQTqRSEKZuL0rqJ0z0xneOPMA6owt8JCEKUgyUNA3f2Q/7wRWuoz4p5dkXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715172; c=relaxed/simple;
	bh=RhnZDstkSyn9NCjV5BXAuD2SyORPxGwmKdcF/ZwFcK0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QTYyc0ymQ8D3niOaFpY3SafeXDKKdGB3oVbVKNBfGFyoFDpvqhn3O/UXgJ9NwsIqL9C13+k2F5xM66pawWw9Wg4bmoa3sGaexvZWWvS8smOqSuBrOkCuByJPUHVkVE+rI2fux/k/XfWAOBlKBgACfMsQAvI29tn6GZAc/2gbj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8WGmGFi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8WGmGFi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b674aso45984057b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715165; x=1759319965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UKk+fABFWQAXetRztc6X+KLn2zwUXlziXeAusSSGig4=;
        b=R8WGmGFip7KpjsQDbVoaa2EZF/ZeMNl4/HfSAN6/HtLsPzEOgIWMyCAvoNznizECjD
         Hbb7mW0OgxL4XVnH7agc0etA1Qtu9g6T50FTZtXHIcOlHEKUrMZp/LLTOTs/4qgAaiwd
         dx++Y0c0M5nMjeoHy7v3BbyMVhc+ZyDNlKoHokALHUp8ZsTUatnyiX2pK00nYc4gm0B9
         mspw8gly9JPvgKcC9rbHeE9+62P2cZ7VsDeqHUY/Ci1FmwkJH9Vw/DCwJRDFVvp1S4T0
         oFoQvgIUWhnnpx4qLTXfJ5L09z3bQpsd9jGwaA1uY8y6l32AlqdK01SjowE2Ror3nrUh
         /dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715165; x=1759319965;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKk+fABFWQAXetRztc6X+KLn2zwUXlziXeAusSSGig4=;
        b=eMbq8+phW0Rmm18gKBAH5CaqjoUt+f9VYY5V1K3I1elNnHYr63ljxFez0Bw/WehuEC
         fnO0Vcr906JZxWn7Tzl9G8D2dJU3oZveAL2kIyzckb3dbTk+QQz6LkDm+39lmCDXSRct
         VAWdpRRTOGF11cbQqJS/xFIwhwMm/En3or0VQSeY0kC7zRxN9dw80JN8f75vLVCXMvsY
         4uK9iZ09WSwxCLV3/WUkv+XIYA79U6dJr1Jt5iAXqsyIn0zlacbPRPVIQs/gkhoqMkYA
         uUUuhZeqk+8tlTYuTikaFZCIDXz2/6kg8aGY63iwqek1ptty12f0LcSCull/5p3mosKN
         VQDA==
X-Forwarded-Encrypted: i=1; AJvYcCUohLI/GSTQuWTkviuZj+BKzEUtZ4wuwCk8MtJXf14eDGi3IOqfkxpqXxdmZGRhbCmzTWbq7/WfHfA7fEfhUgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz467ePqQeueXukDWnjnoBq/wClfUY+nfZRW9GRwdlzue4YdUwt
	HUTmvTpOHHuPEcOcKjNdDHyqnabZRfzNlh1uN07j/Dnkf+qocQKnujrhz4igTvAsYHWnjXzdh0h
	QmWE2kCwAd6RNYrcdQFqSg/Y27TS8UX4=
X-Gm-Gg: ASbGncvKrxx5+Qi7A+9szNe3Tq4tgVstchnw9y/smYux4n30WtAGVP4HdS0tkHo/tBg
	L+UyUMHN1m6baFpcSlalb//DRQTXo/zjfvRtcpYLRXKQecfLLSVxO/STzszOoPZILXezADhd+ri
	tlMvjFYbnVn6IDBPD8zv8QR63/tTA/4351TIlDLZ5cdg9z/cYxQ37hJP6iQ7kWR7pmty2yzx3SI
	870Mg==
X-Google-Smtp-Source: AGHT+IGq9gXJm3DdUgOwDnFVgjubj0wrxcJoEjbl0tGpFewKUqC+l6hwMClNtpIpXyR+PClD6Jn5VPhTGcTKhWmoAbU=
X-Received: by 2002:a05:690c:88f:b0:732:41ef:4025 with SMTP id
 00721157ae682-758a5a541cdmr61248997b3.41.1758715165291; Wed, 24 Sep 2025
 04:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 24 Sep 2025 19:59:13 +0800
X-Gm-Features: AS18NWBcb6DXzUV94H3EtOhThJrlFt8J6Cv6Jc4lZR-D2PB6v1LNuhmrfZogChw
Message-ID: <CAFRLqsVv0R282+xQE4sRM+Tkb0=J_s4Xi0N0K2Cvz++T9fHAPw@mail.gmail.com>
Subject: [BUG] Bluetooth: race in hci_cmd_sync_dequeue_once cause list corrup
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

I hit a crash in the Bluetooth subsystem while running syzkaller on
v6.17-rc5 (commit e5bbb70171d1). The problem seems to be a race
in hci_cmd_sync_dequeue_once() that leads to list corruption.

hci_cmd_sync_dequeue_once() does:
  (1) hci_cmd_sync_lookup_entry()  // lock/unlock, return entry
  (2) hci_cmd_sync_cancel_entry()  // re-take lock, list_del()/kfree()

Between (1) and (2), the worker thread (hci_cmd_sync_work()) can:
  lock cmd_sync_work_lock
  list_del() the same entry
  unlock

This leads to a double list_del and wild memory access.

The c reproducer:
https://github.com/zzzcccyyyggg/Syzkaller-log/blob/main/hci_cmd_sync_dequeue_once/repro.c

The detail KASAN report as follows:

==================================================================
BUG: KASAN: slab-use-after-free in
hci_acl_create_conn_sync+0x134a/0x16e0 net/bluetooth/hci_sync.c:6861
Write of size 2 at addr ffff8881199b0038 by task kworker/u17:0/74

CPU: 2 UID: 0 PID: 74 Comm: kworker/u17:0 Not tainted
6.17.0-rc5-ge5bbb70171d1-dirty #20 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x171/0x7f0 mm/kasan/report.c:482
 kasan_report+0x139/0x170 mm/kasan/report.c:595
 hci_acl_create_conn_sync+0x134a/0x16e0 net/bluetooth/hci_sync.c:6861
 hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 60621:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __hci_conn_add+0x647/0x51d0 net/bluetooth/hci_conn.c:949
 hci_conn_add_unset net/bluetooth/hci_conn.c:1061 [inline]
 hci_connect_acl+0x650/0xe60 net/bluetooth/hci_conn.c:1672
 hci_connect_sco+0x61/0x1c90 net/bluetooth/hci_conn.c:1734
 sco_connect net/bluetooth/sco.c:339 [inline]
 sco_sock_connect+0x638/0x1ed0 net/bluetooth/sco.c:658
 __sys_connect_file net/socket.c:2086 [inline]
 __sys_connect+0x277/0x350 net/socket.c:2105
 __do_sys_connect net/socket.c:2111 [inline]
 __se_sys_connect net/socket.c:2108 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2108
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 76:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x189/0x390 mm/slub.c:4900
 bt_link_release+0x49/0x60 net/bluetooth/hci_sysfs.c:16
 device_release+0x9c/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x16f/0x270 lib/kobject.c:737
 hci_conn_del_sysfs+0x1e2/0x380 net/bluetooth/hci_sysfs.c:62
 hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
 hci_conn_del+0x1f91/0x37a0 net/bluetooth/hci_conn.c:1211
 hci_conn_failed+0x662/0x820 net/bluetooth/hci_conn.c:1314
 hci_conn_complete_evt+0xf2b/0x3330 net/bluetooth/hci_event.c:3215
 hci_event_func net/bluetooth/hci_event.c:7569 [inline]
 hci_event_packet+0x17cd/0x2da0 net/bluetooth/hci_event.c:7623
 hci_rx_work+0x982/0x2210 net/bluetooth/hci_core.c:4071
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8881199b0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 56 bytes inside of
 freed 4096-byte region [ffff8881199b0000, ffff8881199b1000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1199b0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100043040 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100043040 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 0200000000000003 ffffea0004666c01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881199aff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881199aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881199b0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff8881199b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881199b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Thanks for taking a look.

Best regards,
Cen Zhang
