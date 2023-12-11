Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pTqbAsjZ"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34683F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:42:12 -0800 (PST)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SppwJ08zSz49Q2C;
	Mon, 11 Dec 2023 19:42:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1702316528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+VMrEC/8j+D/VaQKfMY50tCY2/e2V8Yc7wWcD8Ua9oI=;
	b=pTqbAsjZy3vHuPPKbTQ4NpeBb371+uj8TCf/kZEme1G7iapwAgYg+Qcr0dyaNuw//z7J2e
	qH8LgRl2gluXCfEE7I+2kKRO6aEL9MTdbIfm92Hle3Ad4assn8D4PMJZfOWYUKxmPC5enB
	BSil0EyZJFQDsCuU6tWdBN7+yC/ulZ46mLUx9oTP63S+tospsJfqmZV96E53sy3rftuzCz
	PuGoaSkIAgGqMV2iMEPC7VwMrGcyZrKLnp66vbKrDoQXqL4pG8VZ0OVh5ibb4i6jLT8080
	gmeXN9lcIu4YhDiNGmuKlC/gGecvlsjI7eb8HLoNAomEWuJ3my1e88bQ2EpLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1702316528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+VMrEC/8j+D/VaQKfMY50tCY2/e2V8Yc7wWcD8Ua9oI=;
	b=E+lFwnP7ORC75i2c2AKG6EGTSfnexJlowkDdigAHySOE5dVnC5zxLSYlc09n5hUx7EhXOd
	wUgLZBPZ76qo6KjguQqogMVxkmHlL8PGeb6ozwIlLgbDgC6lIjgxDxH3/ss2VU98OqpSkV
	ICKGLpECUSRJjA1/4hZ4hvOUS/22OZESkqBUkmxj0j/pXvDoFpv1/YrkLr1cn8bRZeCsVv
	F+zqfdmcbBVtIl6URbotXiM7pHzokHdWZvGRHfyGjTFkfc1KRpsHeB9amrbsSyEeY9ZRE9
	7TPxu/ragi7Qa0g4P12RdJn3NX23sL7VBBDY9lFTFZwrKcCcAfVqkcpwlyXSLQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1702316528; a=rsa-sha256;
	cv=none;
	b=sjMx5ebTdVMwo5IqjU0eEHJ+x47IRFAJnFnnB6kBsE/IoueCn9minY9NqbOQhaGrkvguR0
	bLbZXS4maQTIW3N7GCFQQGPuLXcEnp+D2Fy8S9qwM6YO0Gdok5C0ZHtq5/hvHMEtLMthno
	C02ff447cxgTd7mIHYm+tPr8aKETrUCMFTNPt4mWR49QC3dAIxpX6D3JsTku6rzHRMeDPx
	IwWCEk9hpzNC+3HXSPGL/80Lb5IYvJ4q8EMyA+mviI4+kJ6V/HhliO1jAqHQWkhtZgT97+
	XlN9MkTLoSepxFSopBri6Su2SfLLjKv/FDIxqXTlqDEKebqJUN3TT4MZToAWDw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <8670b8b74d8ff0550fe7325a2ca834f2007d552a.camel@iki.fi>
Subject: Re: [PATCH 1/1] Bluetooth: Fix UAF in __sco_sock_close
From: Pauli Virtanen <pav@iki.fi>
To: Chaoyuan Peng <hedonistsmith@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 11 Dec 2023 19:42:06 +0200
In-Reply-To: <20231211144037.2039209-1-hedonistsmith@gmail.com>
References: <20231211144037.2039209-1-hedonistsmith@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2023-12-11 kello 22:40 +0800, Chaoyuan Peng kirjoitti:
> In __sco_sock_close(), the sco_conn_lock doesn't properly guard the acces=
s
> to 'conn'. This leads to the UAF where __sco_sock_close() access the free=
d
> 'sco_pi(sk)->conn' which is destroyed by hci_abort_conn_sync() on another
> thread.
>=20
> Such is the case in the following call trace:
>=20
> BUG: KASAN: slab-use-after-free in __sco_sock_close+0x2d7/0x6b0 net/bluet=
ooth/sco.c:444
> Write of size 4 at addr ffff88801c47a010 by task syz-executor402/10616

What branch is this crash seen in?

sco_disconn_cfm and sco_conn_del should have been called from
hci_abort_conn_sync. In particular sco_conn_del should set
sco_pi(sk)->conn =3D NULL.

Now, it's possible those are racing here, and maybe it's possible to
make the locking is correct if it's not.

It's also possible there's still some bug that hci_abort_conn_sync gets
called with reason =3D=3D 0.=C2=A0Most of these should have been fixed by
181a42edddf51d5d9697ec

Adding WARN_ON(!reason) in hci_abort_conn_sync should tell if it's
still that bug.

>=20
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  check_region_inline mm/kasan/generic.c:181 [inline]
>  kasan_check_range+0xf0/0x190 mm/kasan/generic.c:187
>  instrument_atomic_read_write ./include/linux/instrumented.h:96 [inline]
>  atomic_dec_and_test ./include/linux/atomic/atomic-instrumented.h:1375 [i=
nline]
>  hci_conn_drop ./include/net/bluetooth/hci_core.h:1523 [inline]
>  __sco_sock_close+0x2d7/0x6b0 net/bluetooth/sco.c:444
>  sco_sock_close net/bluetooth/sco.c:469 [inline]
>  sco_sock_release+0x7b/0x2d0 net/bluetooth/sco.c:1246
>  __sock_release+0xae/0x260 net/socket.c:659
>  sock_close+0x1c/0x20 net/socket.c:1419
>  __fput+0x406/0xa70 fs/file_table.c:384
>  __fput_sync+0x45/0x50 fs/file_table.c:465
>  __do_sys_close fs/open.c:1572 [inline]
>  __se_sys_close fs/open.c:1557 [inline]
>  __x64_sys_close+0x8b/0x110 fs/open.c:1557
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f338be5659b
> Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0=
c e8 d3 eb 02 00 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 35 44 89 c7 89 44 24 0c e8 21 ec 02 00 8b 44
> RSP: 002b:00007ffd1c844f50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f338be5659b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> RBP: 0000000000000032 R08: 0000000000000000 R09: 000000000487598e
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007f338bef32fc
> R13: 00007ffd1c844fa0 R14: 00007ffd1c844fc0 R15: 00007f338be0a5f0
>  </TASK>
>=20
> Allocated by task 10619:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:333 [inline]
>  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>  kmalloc ./include/linux/slab.h:599 [inline]
>  kzalloc ./include/linux/slab.h:720 [inline]
>  hci_conn_add+0xc2/0x1850 net/bluetooth/hci_conn.c:957
>  hci_connect_sco+0x3bb/0x1050 net/bluetooth/hci_conn.c:1701
>  sco_connect net/bluetooth/sco.c:266 [inline]
>  sco_sock_connect+0x2df/0xa90 net/bluetooth/sco.c:591
>  __sys_connect_file+0x15f/0x1a0 net/socket.c:2050
>  __sys_connect+0x165/0x1a0 net/socket.c:2067
>  __do_sys_connect net/socket.c:2077 [inline]
>  __se_sys_connect net/socket.c:2074 [inline]
>  __x64_sys_connect+0x72/0xb0 net/socket.c:2074
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Freed by task 8146:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x15e/0x1c0 mm/kasan/common.c:200
>  kasan_slab_free ./include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1800 [inline]
>  slab_free_freelist_hook+0x95/0x1d0 mm/slub.c:1826
>  slab_free mm/slub.c:3809 [inline]
>  __kmem_cache_free+0xb8/0x2e0 mm/slub.c:3822
>  device_release+0xa3/0x240 drivers/base/core.c:2484
>  kobject_cleanup lib/kobject.c:682 [inline]
>  kobject_release lib/kobject.c:716 [inline]
>  kref_put ./include/linux/kref.h:65 [inline]
>  kobject_put+0x1a2/0x3e0 lib/kobject.c:733
>  put_device+0x1f/0x30 drivers/base/core.c:3732
>  hci_abort_conn_sync+0x566/0xde0 net/bluetooth/hci_sync.c:5428
>  abort_conn_sync+0x188/0x3a0 net/bluetooth/hci_conn.c:2910
>  hci_cmd_sync_work+0x1c5/0x430 net/bluetooth/hci_sync.c:306
>  process_one_work+0x876/0x15a0 kernel/workqueue.c:2630
>  process_scheduled_works kernel/workqueue.c:2703 [inline]
>  worker_thread+0x855/0x11f0 kernel/workqueue.c:2784
>  kthread+0x346/0x450 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>=20
> The buggy address belongs to the object at ffff88801c47a000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 16 bytes inside of
>  freed 4096-byte region [ffff88801c47a000, ffff88801c47b000)
>=20
> The buggy address belongs to the physical page:
> page:ffffea0000711e00 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x1c478
> head:ffffea0000711e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> anon flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7=
ff)
> page_type: 0xffffffff()
> raw: 00fff00000000840 ffff888012843040 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(=
__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), =
pid 1, tgid 1 (swapper/0), ts 6803836749, free_ts 0
>  set_page_owner ./include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2d8/0x350 mm/page_alloc.c:1536
>  prep_new_page mm/page_alloc.c:1543 [inline]
>  get_page_from_freelist+0xf09/0x2c50 mm/page_alloc.c:3170
>  __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4426
>  alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2130
>  alloc_pages+0x233/0x270 mm/mempolicy.c:2292
>  alloc_slab_page mm/slub.c:1870 [inline]
>  allocate_slab+0x261/0x390 mm/slub.c:2017
>  new_slab mm/slub.c:2070 [inline]
>  ___slab_alloc+0xbda/0x15e0 mm/slub.c:3223
>  __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
>  __slab_alloc_node mm/slub.c:3375 [inline]
>  slab_alloc_node mm/slub.c:3468 [inline]
>  __kmem_cache_alloc_node+0x13a/0x350 mm/slub.c:3517
>  kmalloc_node_trace+0x21/0xd0 mm/slab_common.c:1130
>  kmalloc_node ./include/linux/slab.h:615 [inline]
>  kzalloc_node ./include/linux/slab.h:731 [inline]
>  bdi_alloc+0x47/0x180 mm/backing-dev.c:932
>  __alloc_disk_node+0xa2/0x650 block/genhd.c:1337
>  __blk_alloc_disk+0x37/0x90 block/genhd.c:1393
>  brd_alloc.part.0+0x256/0x770 drivers/block/brd.c:338
>  brd_alloc drivers/block/brd.c:458 [inline]
>  brd_init+0x1b5/0x2a0 drivers/block/brd.c:425
>  do_one_initcall+0x105/0x620 init/main.c:1232
> page_owner free stack trace missing
>=20
> Memory state around the buggy address:
>  ffff88801c479f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801c479f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff88801c47a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff88801c47a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801c47a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Signed-off-by: Chaoyuan Peng <hedonistsmith@gmail.com>
> ---
>  net/bluetooth/sco.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index c736186ab..46e158bdd 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -296,6 +296,7 @@ static int sco_connect(struct sock *sk)
>  		sco_sock_set_timer(sk, sk->sk_sndtimeo);
>  	}
> =20
> +	hci_conn_get(hcon);
>  	release_sock(sk);
> =20
>  unlock:
> @@ -438,12 +439,13 @@ static void __sco_sock_close(struct sock *sk)
>  	case BT_CONNECTED:
>  	case BT_CONFIG:
>  		if (sco_pi(sk)->conn->hcon) {
> +			struct hci_conn *hcon =3D sco_pi(sk)->conn->hcon;
>  			sk->sk_state =3D BT_DISCONN;
>  			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
>  			sco_conn_lock(sco_pi(sk)->conn);
> -			hci_conn_drop(sco_pi(sk)->conn->hcon);
>  			sco_pi(sk)->conn->hcon =3D NULL;
>  			sco_conn_unlock(sco_pi(sk)->conn);
> +			hci_conn_put(hcon);

I think this reference is leaked if sco_conn_del gets called first,
which occurs when the hcon is being deleted.

>  		} else
>  			sco_chan_del(sk, ECONNRESET);
>  		break;

--=20
Pauli Virtanen
