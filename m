Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D521ABBB
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529058; cv=pass; b=JyMgMRQMkq8/NYjSSLfSTwz6RKi8PBSlFv7skTlND1GvF9SsiM8MiSgXLJOt9Fz2p5sqsNa/8EbArq8MAKlVCYzNZEHkq+KRX13v7nEGYN+MXWUN7XL1UG2ymV2XcsztCJTv2cXca2Zi+21dWv809E74YbV6J85smiX+cQBkt+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529058; c=relaxed/simple;
	bh=3869gLbkYRzqtB4PQ+v0PE1k6zL5s5gGCrHC4imbXFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ik6hp+rp5HUzUkRFrjtlSU5MG71H+esKAkuPy9eyRqOacdVORF01dFg9r9fHXpBcCR+OH42rULamn1Y8WC4j7nWDhy7qEEUsdQwKZaRcp4b8fJ39XHofS/wdbJ3bYBTDfXJNYDV5rKmzliW/yQd1pttsJttlnSNH0e46LRcSDpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rVT+CvjZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rVT+CvjZ"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4b7T7r12ymz49Pwm;
	Thu, 29 May 2025 17:21:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1748528488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LcQfLJbfbhsCo5F5xRRWr74PeAmQ3OHSJxH/Oj3uDxI=;
	b=rVT+CvjZYHR86MH6Ele5vwG0ZCGHsWkgiYYWk8i8vZF7l3b13Stn2Yv++y/HrGoWZMLBVK
	FGH2e+w75H37Ya+K9iXwDoNu5Q2khLIVps6ZULHK8QHgtBzZOc9J619A4Dpzqf5ltvVrPL
	PCEciNVel/LG/ILRtjW4TH8Peb7Ee+bIvFkDHKwUxYQkMB852YUu2UiSQ8sXZVfqIZY48M
	P/7mGiE19SzSju8aMSoeiRcm3AQVta99Z8SRXODlJoxYh8yz71D8iiK3L43tlFLe8/3HaX
	zXH8ey+6p76QK76gfkmYr+X4yQ07SnAXSq/veO3MMA2/AGb/Qp4hz2etpZoBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1748528488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LcQfLJbfbhsCo5F5xRRWr74PeAmQ3OHSJxH/Oj3uDxI=;
	b=HrT057dtixhzmO8EWsgNRu9twarEfSCPwapZfC5qlHp7b4any2OZXkEFyBcMOUXu46bxF5
	7j/Gz58ielMVXFc2+FbZ/EFC5iK60cje1T4p4xXYyONKUOcPwKIvcHx8qsGT9leSAcs6g6
	KURGO8oBkSxOqpX+XCbpc/uJwDh+LBkwiVgRnGhsBNilKAQ2wRdZfpyYvLzlYRJSEtXwq2
	tHlc8zQ2rCOS2QTO5pw8Q5vA1PB8TaPFRzSEL2xfkPriO91Za0jJr6P5KrcEni7UVwj13M
	JTP+w/pKdmg/VpcGtFagg+Y1TE5eWWV9BPJbjN0ON3ePNNlyOlU6ulAePE1+DQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1748528488; a=rsa-sha256;
	cv=none;
	b=GJGBXPkfKTIJPtojFO/IAjFffESFhw5iJqfrnoZC0Suh4F+Xj+RCu9B2QLDForlVKRUfFC
	KJVZ8LH/tYXaOfzux352i6ZCztIxwYjckSLqcM5NDzyqYo6SYOpGN3pUVcH2qdnAwIZqU8
	1qxAVssndLyJ4Ng47jJsegyfbDWFQD5n9ojlXa4eA4MoqRhIQqUaJbYtE+Eju6sCuU9K/c
	W9AOq/PY7Xpux20L8YILt9RmY09Ss+7FlbXkCAQzi42d+ugF3V8zfWnMh0jdIIP91GyqqI
	4aWgf5whplqT/jFGpfVEUmwp1DoJ1Iwr0CQq5AL3msnifjxGPXiO+Gz6ioP7Ug==
Message-ID: <8b0bd8c9380eba6a0b511212f5a187f663fab0d7.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: MGMT: Use RCU-protected in mgmt_pending
 list
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: dmantipov@yandex.ru
Date: Thu, 29 May 2025 17:21:26 +0300
In-Reply-To: <20250528210718.100679-1-luiz.dentz@gmail.com>
References: <20250528210718.100679-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-05-28 kello 17:07 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This uses RCU procedures to protect from concurrent access of
> mgmt_pending list which can cause crashes like:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/=
0x540 net/bluetooth/mgmt.c:5405
> Read of size 8 at addr ffff888048891a18 by task kworker/u5:8/5333
>=20
> CPU: 0 UID: 0 PID: 5333 Comm: kworker/u5:8 Not tainted 6.15.0-rc5-syzkall=
er-00197-gea34704d6ad7 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xb4/0x290 mm/kasan/report.c:521
>  kasan_report+0x118/0x150 mm/kasan/report.c:634
>  mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
>  hci_cmd_sync_work+0x25e/0x3a0 net/bluetooth/hci_sync.c:334
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>=20
> Allocated by task 5702:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  mgmt_pending_new+0x65/0x240 net/bluetooth/mgmt_util.c:252
>  mgmt_pending_add+0x34/0x120 net/bluetooth/mgmt_util.c:279
>  remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5453
>  hci_mgmt_cmd+0x9c6/0xef0 net/bluetooth/hci_sock.c:1712
>  hci_sock_sendmsg+0x6ca/0xee0 net/bluetooth/hci_sock.c:1832
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  sock_write_iter+0x258/0x330 net/socket.c:1131
>  new_sync_write fs/read_write.c:591 [inline]
>  vfs_write+0x548/0xa90 fs/read_write.c:684
>  ksys_write+0x145/0x250 fs/read_write.c:736
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 5700:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2380 [inline]
>  slab_free mm/slub.c:4642 [inline]
>  kfree+0x193/0x440 mm/slub.c:4841
>  mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
>  mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9362
>  hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1307
>  __sys_bind_socket net/socket.c:1810 [inline]
>  __sys_bind+0x2c3/0x3e0 net/socket.c:1841
>  __do_sys_bind net/socket.c:1846 [inline]
>  __se_sys_bind net/socket.c:1844 [inline]
>  __x64_sys_bind+0x7a/0x90 net/socket.c:1844
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Fixes: a380b6cff1a2 ("Bluetooth: Add generic mgmt helper API")
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfeb0dc579bbe30a13190
> Closes: https://syzkaller.appspot.com/bug?extid=3D0a7039d5d9986ff4ececi
> Closes: https://syzkaller.appspot.com/bug?extid=3Dcc0cc52e7f43dc9e6df1
> Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
> Tested-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
> Tested-by: syzbot+0a7039d5d9986ff4ecec@syzkaller.appspotmail.com
> Tested-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/mgmt_util.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 3713ff490c65..c2dc8ddf5f78 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -219,13 +219,20 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned=
 short channel, u16 opcode,
>  {
>  	struct mgmt_pending_cmd *cmd;
> =20
> -	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
>  		if (hci_sock_get_channel(cmd->sk) !=3D channel)
>  			continue;
> -		if (cmd->opcode =3D=3D opcode)
> +
> +		if (cmd->opcode =3D=3D opcode) {
> +			rcu_read_unlock();
>  			return cmd;

RCU does not guarantee the returned pointer is not already freed when
this returns. AFAIK this is exactly the "BUG!!!" mentioned in
https://docs.kernel.org/RCU/whatisRCU.html#rcu-dereference

Instead of calling rcu_read_lock/unlock here, maybe instead

	list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list,
				lockdep_is_held(&hdev->lock))

to force caller to either hold rcu_read_lock() or hdev->lock to protect
the return value for the time it needs it.

> +		}
>  	}
> =20
> +	rcu_read_unlock();
> +
>  	return NULL;
>  }
> =20
> @@ -233,14 +240,11 @@ void mgmt_pending_foreach(u16 opcode, struct hci_de=
v *hdev,
>  			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
>  			  void *data)
>  {
> -	struct mgmt_pending_cmd *cmd, *tmp;
> -
> -	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
> -		if (opcode > 0 && cmd->opcode !=3D opcode)
> -			continue;
> +	struct mgmt_pending_cmd *cmd;
> =20
> +	cmd =3D mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
> +	if (cmd)
>  		cb(cmd, data);

Hence, this is potential UAF, so caller probably shall hold locks as
above.

With the change in list_for_each_entry_rcu(), you'd then get lockdep
splats if caller doesn't hold right locks.

E.g. the UAF in

	struct mgmt_pending_cmd *cmd =3D data;
	if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
		return -ECANCELED;

	hci_dev_lock(hdev);
	/* operate on cmd */
	hci_dev_unlock(hdev);

should be found directly by the assert.

Note that such pattern of checking if a pointer in the "data" of a
delayed callback corresponds to an "alive" object in principle also has
ABA problem (mgmt_pending_free(cmd) + mgmt_pending_add() allocating at
same address -> operates on wrong item). Also hci_conn_valid() has this
issue.

> -	}
>  }
> =20
>  struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
> @@ -280,7 +284,7 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock=
 *sk, u16 opcode,
>  	if (!cmd)
>  		return NULL;
> =20
> -	list_add_tail(&cmd->list, &hdev->mgmt_pending);
> +	list_add_tail_rcu(&cmd->list, &hdev->mgmt_pending);
> =20
>  	return cmd;
>  }
> @@ -294,7 +298,8 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
> =20
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
>  {
> -	list_del(&cmd->list);
> +	list_del_rcu(&cmd->list);
> +	synchronize_rcu();

Maybe it would be useful to add lockdep_assert_held(&hdev->lock)=C2=A0here
and in mgmt_pending_add() to make sure callers hold right lock?

These compile to nothing with !CONFIG_LOCKDEP so IIUC could be used
more.

>  	mgmt_pending_free(cmd);
>  }
> =20

--=20
Pauli Virtanen
