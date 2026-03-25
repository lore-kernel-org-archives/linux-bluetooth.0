Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B23E714E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454956; cv=pass; b=DSBHiS99r1qnwvO4Oj3LKExENgA3dB8CBuZM/kzT1YemV3aWQp19dA8oVgAnOZvmbCxN2+4WAA+SCRby4zZEwO2CyHIJL15bue1zYPG1jgbtqYtrH1jwnmc3XlH/IN30XVWL5uQi9TxRKukXoWfKePRMVHRU2EVBheDeO8UGmQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454956; c=relaxed/simple;
	bh=bqk+yoHcnVg90bZp/CCo1FjHElKn7E3AN9kqiz2Li4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GI6QNDOHDgQ0/B5AWe01RS+b1UPLyURfWryXVjDFhkkSSOXK39DpukisNH6u2VWgx5NFr5kQOeD0fE2253YR5zTlq40pFzzvLzZRARBHp5h07fKX0+xFwsyenks7J3c9x9qs7g/VKZT+4JE4EMwiuTmSdRPuixprzLMLID3OY6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YQLD3+Ig; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YQLD3+Ig"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fgsKZ6GdMz49Pvg;
	Wed, 25 Mar 2026 18:09:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774454947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv3A9b4GGaUSD/hYodJVq8WAUud7NyNfr2FMsU/aK6g=;
	b=YQLD3+IgY6zNHdwS+R6+GX1O/tRmEcbCtCw3NufO5XdmrB8olC2WyvEa2kb2TDb1/7Nx8f
	XehM2W2IAS+zpvwyj+ppu/FApiO0TgBu0CVGPP+MWvLvpL71rBnfal+Dd18vIpDnIoxb+s
	DhkDdGaly/jNcgYWWWGovxT6X2XSYK9QqxZb4Frn0OGenLySxZhjYESohL7l4XsPgo7i/S
	ti7ak9StIXYLDPtg7DHOAuV2xXpTFlCUb4kA6skCCWdwiZZztSTvpEq2F5BI4c8p0BdDJV
	kU4+9ANDHrjFQ/yjxdMzjLtpCgJp2NN/vd/iosZtQcgVGdHWGRHl4jdDtv+7ow==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774454947;
	b=eId+vi6SuRADkp19LIop+49PJG0SeGAi7iO/uVMbGUMq9/HYE0VXYn2EECvjrnqWvaSHWs
	/Tr4C/bWWp1nvWBTjadSrNPC3N2JpG9TKMj0e2SH2k4F2Tuptveb2hI5HErIhJDeH0/cvE
	IbS8aZ0cadySxG1c/fxE236Hzi1fRH/yzDCEaXt7WJ+RpRJtRccCCosQjOZkLsdu7zpxyg
	2c79FiMrnQ2QW2hwrE3oEzqWcwUA3wWYL50fZLUB7lFAe5UkuIXtliBwZqQbinLvyHgkpK
	suxO/3yi0j+pnK0Kb8HT0UUmL98bof0xr/oSsCKEc6JyegPeVRMdTEGTA+bmXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774454947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv3A9b4GGaUSD/hYodJVq8WAUud7NyNfr2FMsU/aK6g=;
	b=XZtOJsJVl1MKSc082+jE9JyXKq38dwhMWwtg8/+JmatkWh5qWQx1VzrdqGVl8FI9HBhOt8
	007yjCcL/dMkQA2ZUDSQh7usrYkuPkn3gmPL8ONci8agq0Isma9srLoaFcADGvaNgePVvz
	D/TRzGfvk63/s0eVKicbIUBQRNf/ceHUmFeh2Sqkqjia1drEHxlDp3QjpO2h+mn5Kjmpzi
	muUIqQyMj0hLFaKunMpIhJ6h3awBsK36Q2yehfcqvgLfEGLsDeIR2JR9igSFp4KJ8F4HFJ
	qZrhX1kWdEGX0Q2tu8Vy9Iva5qsjDD09E0YKfIci69pauFbGqCfc8+vjuibqAA==
Message-ID: <f2cd3103ea5154eeaac532c35f8e1f6d41a247ba.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF in
 le_read_features_complete
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Mar 2026 18:09:05 +0200
In-Reply-To: <CABBYNZJv=JO_O-nMr772_zsFVY5SM69aB9E4AQ38-FpeXDwK-A@mail.gmail.com>
References: <20260325151809.235680-1-luiz.dentz@gmail.com>
	 <c986d7b6114540132a9b066dd001275a2c0fd774.camel@iki.fi>
	 <CABBYNZJv=JO_O-nMr772_zsFVY5SM69aB9E4AQ38-FpeXDwK-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-03-25 kello 12:00 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Mar 25, 2026 at 11:56=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Hi Luiz,
> >=20
> > ke, 2026-03-25 kello 11:18 -0400, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > This fixes the following backtrace caused by hci_conn being freed
> > > before le_read_features_complete but after
> > > hci_le_read_remote_features_sync so hci_conn_del -> hci_cmd_sync_dequ=
eue
> > > is not able to prevent it:
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in instrument_atomic_read_write inclu=
de/linux/instrumented.h:96 [inline]
> > > BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/=
atomic/atomic-instrumented.h:1383 [inline]
> > > BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetoot=
h/hci_core.h:1688 [inline]
> > > BUG: KASAN: slab-use-after-free in le_read_features_complete+0x5b/0x3=
40 net/bluetooth/hci_sync.c:7344
> > > Write of size 4 at addr ffff8880796b0010 by task kworker/u9:0/52
> > >=20
> > > CPU: 0 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted syzkaller #0 PRE=
EMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 10/25/2025
> > > Workqueue: hci0 hci_cmd_sync_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:378 [inline]
> > >  print_report+0xcd/0x630 mm/kasan/report.c:482
> > >  kasan_report+0xe0/0x110 mm/kasan/report.c:595
> > >  check_region_inline mm/kasan/generic.c:194 [inline]
> > >  kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
> > >  instrument_atomic_read_write include/linux/instrumented.h:96 [inline=
]
> > >  atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 =
[inline]
> > >  hci_conn_drop include/net/bluetooth/hci_core.h:1688 [inline]
> > >  le_read_features_complete+0x5b/0x340 net/bluetooth/hci_sync.c:7344
> > >  hci_cmd_sync_work+0x1ff/0x430 net/bluetooth/hci_sync.c:334
> > >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> > >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> > >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> > >  kthread+0x3c5/0x780 kernel/kthread.c:463
> > >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > >  </TASK>
> > >=20
> > > Allocated by task 5932:
> > >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
> > >  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
> > >  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
> > >  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
> > >  kmalloc_noprof include/linux/slab.h:957 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> > >  __hci_conn_add+0xf8/0x1c70 net/bluetooth/hci_conn.c:963
> > >  hci_conn_add_unset+0x76/0x100 net/bluetooth/hci_conn.c:1084
> > >  le_conn_complete_evt+0x639/0x1f20 net/bluetooth/hci_event.c:5714
> > >  hci_le_enh_conn_complete_evt+0x23d/0x380 net/bluetooth/hci_event.c:5=
861
> > >  hci_le_meta_evt+0x357/0x5e0 net/bluetooth/hci_event.c:7408
> > >  hci_event_func net/bluetooth/hci_event.c:7716 [inline]
> > >  hci_event_packet+0x685/0x11c0 net/bluetooth/hci_event.c:7773
> > >  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
> > >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> > >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> > >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> > >  kthread+0x3c5/0x780 kernel/kthread.c:463
> > >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > >=20
> > > Freed by task 5932:
> > >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
> > >  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
> > >  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
> > >  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
> > >  poison_slab_object mm/kasan/common.c:252 [inline]
> > >  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
> > >  kasan_slab_free include/linux/kasan.h:234 [inline]
> > >  slab_free_hook mm/slub.c:2540 [inline]
> > >  slab_free mm/slub.c:6663 [inline]
> > >  kfree+0x2f8/0x6e0 mm/slub.c:6871
> > >  device_release+0xa4/0x240 drivers/base/core.c:2565
> > >  kobject_cleanup lib/kobject.c:689 [inline]
> > >  kobject_release lib/kobject.c:720 [inline]
> > >  kref_put include/linux/kref.h:65 [inline]
> > >  kobject_put+0x1e7/0x590 lib/kobject.c:737
> > >  put_device drivers/base/core.c:3797 [inline]
> > >  device_unregister+0x2f/0xc0 drivers/base/core.c:3920
> > >  hci_conn_del_sysfs+0xb4/0x180 net/bluetooth/hci_sysfs.c:79
> > >  hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
> > >  hci_conn_del+0x657/0x1180 net/bluetooth/hci_conn.c:1234
> > >  hci_disconn_complete_evt+0x410/0xa00 net/bluetooth/hci_event.c:3451
> > >  hci_event_func net/bluetooth/hci_event.c:7719 [inline]
> > >  hci_event_packet+0xa10/0x11c0 net/bluetooth/hci_event.c:7773
> > >  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
> > >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> > >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> > >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> > >  kthread+0x3c5/0x780 kernel/kthread.c:463
> > >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > >=20
> > > The buggy address belongs to the object at ffff8880796b0000
> > >  which belongs to the cache kmalloc-8k of size 8192
> > > The buggy address is located 16 bytes inside of
> > >  freed 8192-byte region [ffff8880796b0000, ffff8880796b2000)
> > >=20
> > > The buggy address belongs to the physical page:
> > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x=
796b0
> > > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount=
:0
> > > anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7f=
f)
> > > page_type: f5(slab)
> > > raw: 00fff00000000040 ffff88813ff27280 0000000000000000 0000000000000=
001
> > > raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000=
000
> > > head: 00fff00000000040 ffff88813ff27280 0000000000000000 000000000000=
0001
> > > head: 0000000000000000 0000000000020002 00000000f5000000 000000000000=
0000
> > > head: 00fff00000000003 ffffea0001e5ac01 00000000ffffffff 00000000ffff=
ffff
> > > head: ffffffffffffffff 0000000000000000 00000000ffffffff 000000000000=
0008
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2=
040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5=
657, tgid 5657 (dhcpcd-run-hook), ts 79819636908, free_ts 79814310558
> > >  set_page_owner include/linux/page_owner.h:32 [inline]
> > >  post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
> > >  prep_new_page mm/page_alloc.c:1853 [inline]
> > >  get_page_from_freelist+0xd0b/0x31a0 mm/page_alloc.c:3879
> > >  __alloc_frozen_pages_noprof+0x25f/0x2440 mm/page_alloc.c:5183
> > >  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
> > >  alloc_slab_page mm/slub.c:3075 [inline]
> > >  allocate_slab mm/slub.c:3248 [inline]
> > >  new_slab+0x2c3/0x430 mm/slub.c:3302
> > >  ___slab_alloc+0xe18/0x1c90 mm/slub.c:4651
> > >  __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4774
> > >  __slab_alloc_node mm/slub.c:4850 [inline]
> > >  slab_alloc_node mm/slub.c:5246 [inline]
> > >  __kmalloc_cache_noprof+0x477/0x800 mm/slub.c:5766
> > >  kmalloc_noprof include/linux/slab.h:957 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> > >  tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
> > >  tomoyo_init_log+0xc8a/0x2140 security/tomoyo/audit.c:264
> > >  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
> > >  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> > >  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
> > >  tomoyo_environ security/tomoyo/domain.c:672 [inline]
> > >  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
> > >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
> > >  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
> > >  security_bprm_check+0x1b9/0x1e0 security/security.c:794
> > >  search_binary_handler fs/exec.c:1659 [inline]
> > >  exec_binprm fs/exec.c:1701 [inline]
> > >  bprm_execve fs/exec.c:1753 [inline]
> > >  bprm_execve+0x81e/0x1620 fs/exec.c:1729
> > >  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
> > > page last free pid 5657 tgid 5657 stack trace:
> > >  reset_page_owner include/linux/page_owner.h:25 [inline]
> > >  free_pages_prepare mm/page_alloc.c:1394 [inline]
> > >  __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2901
> > >  discard_slab mm/slub.c:3346 [inline]
> > >  __put_partials+0x130/0x170 mm/slub.c:3886
> > >  qlink_free mm/kasan/quarantine.c:163 [inline]
> > >  qlist_free_all+0x4c/0xf0 mm/kasan/quarantine.c:179
> > >  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
> > >  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
> > >  kasan_slab_alloc include/linux/kasan.h:252 [inline]
> > >  slab_post_alloc_hook mm/slub.c:4948 [inline]
> > >  slab_alloc_node mm/slub.c:5258 [inline]
> > >  __kmalloc_cache_noprof+0x274/0x800 mm/slub.c:5766
> > >  kmalloc_noprof include/linux/slab.h:957 [inline]
> > >  tomoyo_print_header security/tomoyo/audit.c:156 [inline]
> > >  tomoyo_init_log+0x197/0x2140 security/tomoyo/audit.c:255
> > >  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
> > >  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> > >  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
> > >  tomoyo_environ security/tomoyo/domain.c:672 [inline]
> > >  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
> > >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
> > >  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
> > >  security_bprm_check+0x1b9/0x1e0 security/security.c:794
> > >  search_binary_handler fs/exec.c:1659 [inline]
> > >  exec_binprm fs/exec.c:1701 [inline]
> > >  bprm_execve fs/exec.c:1753 [inline]
> > >  bprm_execve+0x81e/0x1620 fs/exec.c:1729
> > >  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
> > >  do_execve fs/exec.c:1933 [inline]
> > >  __do_sys_execve fs/exec.c:2009 [inline]
> > >  __se_sys_execve fs/exec.c:2004 [inline]
> > >  __x64_sys_execve+0x8e/0xb0 fs/exec.c:2004
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> > >=20
> > > Memory state around the buggy address:
> > >  ffff8880796aff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >  ffff8880796aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > ffff8880796b0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >                          ^
> > >  ffff8880796b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff8880796b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Fea=
ture Set")
> > > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > > Closes: https://syzbot.org/bug?extid=3D87badbb9094e008e0685
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/hci_sync.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 45d16639874a..f67a32c1451e 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -7371,7 +7371,7 @@ static void le_read_features_complete(struct hc=
i_dev *hdev, void *data, int err)
> > >       if (err =3D=3D -ECANCELED)
> > >               return;
> > >=20
> > > -     hci_conn_drop(conn);
> > > +     hci_conn_put(conn);
> > >  }
> > >=20
> > >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev=
,
> > > @@ -7441,7 +7441,7 @@ int hci_le_read_remote_features(struct hci_conn=
 *conn)
> > >       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEAT=
URES))
> > >               err =3D hci_cmd_sync_queue_once(hdev,
> > >                                             hci_le_read_remote_featur=
es_sync,
> > > -                                           hci_conn_hold(conn),
> > > +                                           hci_conn_get(conn),
> > >                                             le_read_features_complete=
);
> > >       else
> > >               err =3D -EOPNOTSUPP;
> >=20
> > This looks like it leaks conn refcount if it can happen that the item
> > is already queued, or on queue error.
> >=20
> > The hci_cmd_sync_queue_once() and hci_cmd_sync_run_once() API probably
> > should indicate to caller whether an item was queued:
> >=20
> > https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798=
d9880979d.1762100290.git.pav@iki.fi/T/#m66b153015dc461c5dacc9f4c9ec2805b119=
7d149
>=20
> Interesting. Is there a chance to resend this change? It's a little
> intrusive since we need to verify all call sites handle -EEXIST but I
> guess there is no better option.

I can rebase + resend it. Needs checking the callsites again as there
are new ones since.

--=20
Pauli Virtanen
