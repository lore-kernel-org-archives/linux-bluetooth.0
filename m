Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786672605
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966511; cv=pass; b=F5zbo9Ksud2cae9EMMxeqwWsqy+JXtRLw4Dfh8sDjs2QC+POkYcd2ipBn3Lvy6Em0gGdiKNM+mJ3MpUTiOaxkzqmf2K7ec8/WuBLcSKzpA1MPq2i/4wc4qjV0lBxgUV/f7gzFfGv+hn3mqNEn2Ht7De2ycTTd3HiWcG/VH4PeuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966511; c=relaxed/simple;
	bh=3V9/P82tsYrgrGRbXGG41XxGMY8fJQn/Vz8y6DGkHC8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHfwrIYB+5oQmJbcDo5nwc40Z9SHRKPKcMxbFJksP1rz8/DCqTHNH+S9pv+uTYZCj23LOQED2ahEt5QTvO93pmVTHG5XuUjc3dDZSzV2ePA3ltaP4MUutSyuDbcc8IfygRuWIwqfbq82GudfWapqFT89BwnIgBgB2p1+N1s8wF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VJPnBQ6J; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VJPnBQ6J"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bBb7175m0z49Q4L;
	Tue,  3 Jun 2025 19:01:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1748966494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FJWIunzr+HWhn6ZsU3jJsKP+h2ko3vw+aNgNi3DDfGY=;
	b=VJPnBQ6JpRHqy5DwYLxldehfg2UaWudbAoGmVOc5U+4Jjh4VEvGTUJrcwuQDQvUZJf4Ipi
	AN4TJzNUEBDPX9Mj/VfiPo0A/kOmhubh5SAJvn1QszuoyfLUIw2BFNZyH9H6aCxUdWVFmQ
	74wU1f+R1RyyknOPCym0NG5tm3aRvORvuqVJTwsHQlpU7BJGMijsE+El4/62V1G+fX8IE3
	8vVNEsh2yGfQzKpZC7YaSApANdmE2gskiBs+cba/hUf4hrBpyhPolZdacl3Wjnlz/JFGbA
	d+3FcFeKEjWHm8C+tAsM40foUQVyMNpnjhSeptDq13JRB/Ez1gVrEkUUPu0sqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1748966494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FJWIunzr+HWhn6ZsU3jJsKP+h2ko3vw+aNgNi3DDfGY=;
	b=IZQ16gppWOAJJ9iWyKOxceRiGyJzhNQXdVmIqeeISnSHNSXw7/RYYiXlNT8uTQRAtYpUQI
	KtnHA2xYCFNPVC/7je/xI8uoAddTFvXfg3Fz4lnTuEJXbv0uBVCgDmBRx0yNNE4kb0Lf7k
	kQYJKrTjsGv/GMOv052ofFJPxe72NmJs0psSYnwKj2cknp2jfTbfNY7ie0Pv/e4PjNvLG1
	1S3wE307t/YwCw8GyQvo769trX2dVKPujttgEc8KuUPSW3JwKBthsMdr3DPudkCXtxpWR6
	F+gz9qCC+k3OeRfrbbXMxBGavOZRsINfF35Qp5ZpmLkAZPcgbc7f7D+ZP36G1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1748966494; a=rsa-sha256;
	cv=none;
	b=ibueOv/eB+EpyRtzaKgPom9CQlvjEpe63xGY9haRk9pSDUc3xDhR6xO7WZvavdVUmGEr+l
	BPUmyA8j4Xnjk45j6RbvAjZK1R0xVfApA770Ywi4cNCXRmRBV/HjjUo8sKuMuA2nABIY29
	O7lm12lXGH/wEIl+HcVFTYbsemuLU6Dyb/O1Ip1x/XzW0qxXWLt/cp5Qs/Swu0C1pavHt8
	n8Yp4pVN86h3sl99y1MdmJY2evEXPv8J0RSqWqqFpwwoEwb7PXD6O7uMcYqMxZ1YlRr51V
	yPJnUKidQUtosAnQ4LeX8Ex4sQFhPUQf9nQjbRc4mRt+kVJx5lLvx06BH6AgQw==
Message-ID: <46054238d5c35137912fbcb0969ee6358eb8311d.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: MGMT: Protect mgmt_pending list with its
 own lock
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 03 Jun 2025 19:01:31 +0300
In-Reply-To: <20250602174635.831088-1-luiz.dentz@gmail.com>
References: <20250602174635.831088-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-06-02 kello 13:46 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This uses a mutex to protect from concurrent access of mgmt_pending
> list which can cause crashes like:
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
>  include/net/bluetooth/hci_core.h |   1 +
>  net/bluetooth/hci_core.c         |   1 +
>  net/bluetooth/mgmt.c             | 101 +++++++++++++++----------------
>  net/bluetooth/mgmt_util.c        |  32 ++++++++--
>  net/bluetooth/mgmt_util.h        |   4 +-
>  5 files changed, 80 insertions(+), 59 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2b261e74e2c4..b9ff0e825071 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -546,6 +546,7 @@ struct hci_dev {
>  	struct hci_conn_hash	conn_hash;
> =20
>  	struct list_head	mesh_pending;
> +	struct mutex		mgmt_pending_lock;
>  	struct list_head	mgmt_pending;
>  	struct list_head	reject_list;
>  	struct list_head	accept_list;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 04845ff3ad57..f197f5497043 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2487,6 +2487,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
> =20
>  	mutex_init(&hdev->lock);
>  	mutex_init(&hdev->req_lock);
> +	mutex_init(&hdev->mgmt_pending_lock);
> =20
>  	ida_init(&hdev->unset_handle_ida);
> =20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 14a9462fced5..7d9ed7db377f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1447,22 +1447,17 @@ static void settings_rsp(struct mgmt_pending_cmd =
*cmd, void *data)
> =20
>  	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
> =20
> -	list_del(&cmd->list);
> -
>  	if (match->sk =3D=3D NULL) {
>  		match->sk =3D cmd->sk;
>  		sock_hold(match->sk);
>  	}
> -
> -	mgmt_pending_free(cmd);
>  }
> =20
>  static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
>  {
>  	u8 *status =3D data;
> =20
> -	mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
> -	mgmt_pending_remove(cmd);
> +	mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, *status);
>  }
> =20
>  static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
> @@ -1476,8 +1471,6 @@ static void cmd_complete_rsp(struct mgmt_pending_cm=
d *cmd, void *data)
> =20
>  	if (cmd->cmd_complete) {
>  		cmd->cmd_complete(cmd, match->mgmt_status);
> -		mgmt_pending_remove(cmd);
> -
>  		return;
>  	}
> =20
> @@ -1486,13 +1479,13 @@ static void cmd_complete_rsp(struct mgmt_pending_=
cmd *cmd, void *data)
> =20
>  static int generic_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
>  {
> -	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
> +	return mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status,
>  				 cmd->param, cmd->param_len);
>  }
> =20
>  static int addr_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
>  {
> -	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
> +	return mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status,
>  				 cmd->param, sizeof(struct mgmt_addr_info));
>  }
> =20
> @@ -1532,7 +1525,7 @@ static void mgmt_set_discoverable_complete(struct h=
ci_dev *hdev, void *data,
> =20
>  	if (err) {
>  		u8 mgmt_err =3D mgmt_status(err);
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
>  		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
>  		goto done;
>  	}
> @@ -1707,7 +1700,7 @@ static void mgmt_set_connectable_complete(struct hc=
i_dev *hdev, void *data,
> =20
>  	if (err) {
>  		u8 mgmt_err =3D mgmt_status(err);
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
>  		goto done;
>  	}
> =20
> @@ -1943,8 +1936,8 @@ static void set_ssp_complete(struct hci_dev *hdev, =
void *data, int err)
>  			new_settings(hdev, NULL);
>  		}
> =20
> -		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, cmd_status_rsp,
> -				     &mgmt_err);
> +		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true,
> +				     cmd_status_rsp, &mgmt_err);
>  		return;
>  	}
> =20
> @@ -1954,7 +1947,7 @@ static void set_ssp_complete(struct hci_dev *hdev, =
void *data, int err)
>  		changed =3D hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
>  	}
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true, settings_rsp, &match)=
;
> =20
>  	if (changed)
>  		new_settings(hdev, match.sk);
> @@ -2074,12 +2067,12 @@ static void set_le_complete(struct hci_dev *hdev,=
 void *data, int err)
>  	bt_dev_dbg(hdev, "err %d", err);
> =20
>  	if (status) {
> -		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
> -							&status);
> +		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, cmd_status_rsp,
> +				     &status);
>  		return;
>  	}
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, settings_rsp, &match);
> =20
>  	new_settings(hdev, match.sk);
> =20
> @@ -2138,7 +2131,7 @@ static void set_mesh_complete(struct hci_dev *hdev,=
 void *data, int err)
>  	struct sock *sk =3D cmd->sk;
> =20
>  	if (status) {
> -		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
> +		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
>  				     cmd_status_rsp, &status);
>  		return;
>  	}
> @@ -2638,7 +2631,7 @@ static void mgmt_class_complete(struct hci_dev *hde=
v, void *data, int err)
> =20
>  	bt_dev_dbg(hdev, "err %d", err);
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  			  mgmt_status(err), hdev->dev_class, 3);
> =20
>  	mgmt_pending_free(cmd);
> @@ -3427,7 +3420,7 @@ static int pairing_complete(struct mgmt_pending_cmd=
 *cmd, u8 status)
>  	bacpy(&rp.addr.bdaddr, &conn->dst);
>  	rp.addr.type =3D link_to_bdaddr(conn->type, conn->dst_type);
> =20
> -	err =3D mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE,
> +	err =3D mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_PAIR_DEVICE,
>  				status, &rp, sizeof(rp));
> =20
>  	/* So we don't get further callbacks for this connection */
> @@ -5196,7 +5189,7 @@ static void mgmt_add_adv_patterns_monitor_complete(=
struct hci_dev *hdev,
>  		hci_update_passive_scan(hdev);
>  	}
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  			  mgmt_status(status), &rp, sizeof(rp));
>  	mgmt_pending_remove(cmd);
> =20
> @@ -5411,7 +5404,7 @@ static void mgmt_remove_adv_monitor_complete(struct=
 hci_dev *hdev,
>  	if (!status)
>  		hci_update_passive_scan(hdev);
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  			  mgmt_status(status), &rp, sizeof(rp));
>  	mgmt_pending_remove(cmd);
> =20
> @@ -5792,7 +5785,7 @@ static void start_discovery_complete(struct hci_dev=
 *hdev, void *data, int err)
>  	    cmd !=3D pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
>  		return;
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err)=
,
>  			  cmd->param, 1);
>  	mgmt_pending_remove(cmd);
> =20
> @@ -6013,7 +6006,7 @@ static void stop_discovery_complete(struct hci_dev =
*hdev, void *data, int err)
> =20
>  	bt_dev_dbg(hdev, "err %d", err);
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err)=
,
>  			  cmd->param, 1);
>  	mgmt_pending_remove(cmd);
> =20
> @@ -6238,7 +6231,7 @@ static void set_advertising_complete(struct hci_dev=
 *hdev, void *data, int err)
>  	u8 status =3D mgmt_status(err);
> =20
>  	if (status) {
> -		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
> +		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true,
>  				     cmd_status_rsp, &status);
>  		return;
>  	}
> @@ -6248,7 +6241,7 @@ static void set_advertising_complete(struct hci_dev=
 *hdev, void *data, int err)
>  	else
>  		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, settings_rsp,
> +	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true, settings_rsp,
>  			     &match);
> =20
>  	new_settings(hdev, match.sk);
> @@ -6592,7 +6585,7 @@ static void set_bredr_complete(struct hci_dev *hdev=
, void *data, int err)
>  		 */
>  		hci_dev_clear_flag(hdev, HCI_BREDR_ENABLED);
> =20
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
>  	} else {
>  		send_settings_rsp(cmd->sk, MGMT_OP_SET_BREDR, hdev);
>  		new_settings(hdev, cmd->sk);
> @@ -6729,7 +6722,7 @@ static void set_secure_conn_complete(struct hci_dev=
 *hdev, void *data, int err)
>  	if (err) {
>  		u8 mgmt_err =3D mgmt_status(err);
> =20
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
>  		goto done;
>  	}
> =20
> @@ -7176,7 +7169,7 @@ static void get_conn_info_complete(struct hci_dev *=
hdev, void *data, int err)
>  		rp.max_tx_power =3D HCI_TX_POWER_INVALID;
>  	}
> =20
> -	mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status=
,
>  			  &rp, sizeof(rp));
> =20
>  	mgmt_pending_free(cmd);
> @@ -7336,7 +7329,7 @@ static void get_clock_info_complete(struct hci_dev =
*hdev, void *data, int err)
>  	}
> =20
>  complete:
> -	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
> +	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
>  			  sizeof(rp));
> =20
>  	mgmt_pending_free(cmd);
> @@ -8586,10 +8579,10 @@ static void add_advertising_complete(struct hci_d=
ev *hdev, void *data, int err)
>  	rp.instance =3D cp->instance;
> =20
>  	if (err)
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				mgmt_status(err));
>  	else
> -		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				  mgmt_status(err), &rp, sizeof(rp));
> =20
>  	add_adv_complete(hdev, cmd->sk, cp->instance, err);
> @@ -8777,10 +8770,10 @@ static void add_ext_adv_params_complete(struct hc=
i_dev *hdev, void *data,
> =20
>  		hci_remove_adv_instance(hdev, cp->instance);
> =20
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				mgmt_status(err));
>  	} else {
> -		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				  mgmt_status(err), &rp, sizeof(rp));
>  	}
> =20
> @@ -8927,10 +8920,10 @@ static void add_ext_adv_data_complete(struct hci_=
dev *hdev, void *data, int err)
>  	rp.instance =3D cp->instance;
> =20
>  	if (err)
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				mgmt_status(err));
>  	else
> -		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				  mgmt_status(err), &rp, sizeof(rp));
> =20
>  	mgmt_pending_free(cmd);
> @@ -9089,10 +9082,10 @@ static void remove_advertising_complete(struct hc=
i_dev *hdev, void *data,
>  	rp.instance =3D cp->instance;
> =20
>  	if (err)
> -		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				mgmt_status(err));
>  	else
> -		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
>  				  MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
> =20
>  	mgmt_pending_free(cmd);
> @@ -9364,7 +9357,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
>  	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
>  		return;
> =20
> -	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
> +	mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
> =20
>  	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
>  		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
> @@ -9402,7 +9395,8 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
>  		hci_update_passive_scan(hdev);
>  	}
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, true, settings_rsp,
> +			     &match);
> =20
>  	new_settings(hdev, match.sk);
> =20
> @@ -9417,7 +9411,8 @@ void __mgmt_power_off(struct hci_dev *hdev)
>  	struct cmd_lookup match =3D { NULL, hdev };
>  	u8 zero_cod[] =3D { 0, 0, 0 };
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, true, settings_rsp,
> +			     &match);
> =20
>  	/* If the power off is because of hdev unregistration let
>  	 * use the appropriate INVALID_INDEX status. Otherwise use
> @@ -9431,7 +9426,7 @@ void __mgmt_power_off(struct hci_dev *hdev)
>  	else
>  		match.mgmt_status =3D MGMT_STATUS_NOT_POWERED;
> =20
> -	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
> +	mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
> =20
>  	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) !=3D 0) {
>  		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
> @@ -9672,7 +9667,6 @@ static void unpair_device_rsp(struct mgmt_pending_c=
md *cmd, void *data)
>  	device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, cmd->sk);
> =20
>  	cmd->cmd_complete(cmd, 0);
> -	mgmt_pending_remove(cmd);
>  }
> =20
>  bool mgmt_powering_down(struct hci_dev *hdev)
> @@ -9728,8 +9722,8 @@ void mgmt_disconnect_failed(struct hci_dev *hdev, b=
daddr_t *bdaddr,
>  	struct mgmt_cp_disconnect *cp;
>  	struct mgmt_pending_cmd *cmd;
> =20
> -	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
> -			     hdev);
> +	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, true,
> +			     unpair_device_rsp, hdev);
> =20
>  	cmd =3D pending_find(MGMT_OP_DISCONNECT, hdev);
>  	if (!cmd)
> @@ -9922,7 +9916,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev=
, u8 status)
> =20
>  	if (status) {
>  		u8 mgmt_err =3D mgmt_status(status);
> -		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev,
> +		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, true,
>  				     cmd_status_rsp, &mgmt_err);
>  		return;
>  	}
> @@ -9932,8 +9926,8 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev=
, u8 status)
>  	else
>  		changed =3D hci_dev_test_and_clear_flag(hdev, HCI_LINK_SECURITY);
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
> -			     &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, true,
> +			     settings_rsp, &match);
> =20
>  	if (changed)
>  		new_settings(hdev, match.sk);
> @@ -9957,9 +9951,12 @@ void mgmt_set_class_of_dev_complete(struct hci_dev=
 *hdev, u8 *dev_class,
>  {
>  	struct cmd_lookup match =3D { NULL, hdev, mgmt_status(status) };
> =20
> -	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, sk_lookup, &match);
> -	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, sk_lookup, &match);
> -	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
> +	mgmt_pending_foreach(MGMT_OP_SET_DEV_CLASS, hdev, false, sk_lookup,
> +			     &match);
> +	mgmt_pending_foreach(MGMT_OP_ADD_UUID, hdev, false, sk_lookup,
> +			     &match);
> +	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, false, sk_lookup,
> +			     &match);
> =20
>  	if (!status) {
>  		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 3713ff490c65..a88a07da3947 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -217,30 +217,47 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u=
16 cmd, u8 status,
>  struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 o=
pcode,
>  					   struct hci_dev *hdev)
>  {
> -	struct mgmt_pending_cmd *cmd;
> +	struct mgmt_pending_cmd *cmd, *tmp;
> =20
> -	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> +	mutex_lock(&hdev->mgmt_pending_lock);
> +
> +	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
>  		if (hci_sock_get_channel(cmd->sk) !=3D channel)
>  			continue;
> -		if (cmd->opcode =3D=3D opcode)
> +
> +		if (cmd->opcode =3D=3D opcode) {
> +			mutex_unlock(&hdev->mgmt_pending_lock);
>  			return cmd;

Nothing appears to prevent cmd from being freed immediately after
mutex_unlock()

Then, the same UAF as in the stacktrace in the commit message would
still be possible.

Maybe instead:

	lockdep_assert_held(&hdev->mgmt_pending_lock);

here and have the caller hold the lock as long as it uses the cmd?
Looks like callers are not doing something that takes a long time, so
it could work.

> +		}
>  	}
> =20
> +	mutex_unlock(&hdev->mgmt_pending_lock);
> +
>  	return NULL;
>  }
> =20
> -void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
> +void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
>  			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
>  			  void *data)
>  {
>  	struct mgmt_pending_cmd *cmd, *tmp;
> =20
> +	mutex_lock(&hdev->mgmt_pending_lock);
> +
>  	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
>  		if (opcode > 0 && cmd->opcode !=3D opcode)
>  			continue;
> =20
> +		if (remove)
> +			list_del(&cmd->list);
> +
>  		cb(cmd, data);
> +
> +		if (remove)
> +			mgmt_pending_free(cmd);
>  	}
> +
> +	mutex_unlock(&hdev->mgmt_pending_lock);
>  }
> =20
>  struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
> @@ -254,7 +271,7 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock=
 *sk, u16 opcode,
>  		return NULL;
> =20
>  	cmd->opcode =3D opcode;
> -	cmd->index =3D hdev->id;
> +	cmd->hdev =3D hdev;
> =20
>  	cmd->param =3D kmemdup(data, len, GFP_KERNEL);
>  	if (!cmd->param) {
> @@ -280,7 +297,9 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock=
 *sk, u16 opcode,
>  	if (!cmd)
>  		return NULL;
> =20
> +	mutex_lock(&hdev->mgmt_pending_lock);
>  	list_add_tail(&cmd->list, &hdev->mgmt_pending);
> +	mutex_unlock(&hdev->mgmt_pending_lock);
> =20
>  	return cmd;
>  }
> @@ -294,7 +313,10 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
> =20
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
>  {
> +	mutex_lock(&cmd->hdev->mgmt_pending_lock);

I think this deadlocks in mgmt_index_removed() -> mgmt_pending_foreach
-> cmd_complete_rsp -> mgmt_pending_remove

Maybe again lockdep_assert_held(&cmd->hdev->mgmt_pending_lock); and
have caller to hold lock.

>  	list_del(&cmd->list);
> +	mutex_unlock(&cmd->hdev->mgmt_pending_lock);
> +
>  	mgmt_pending_free(cmd);
>  }
> =20
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index f2ba994ab1d8..024e51dd6937 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -33,7 +33,7 @@ struct mgmt_mesh_tx {
>  struct mgmt_pending_cmd {
>  	struct list_head list;
>  	u16 opcode;
> -	int index;
> +	struct hci_dev *hdev;
>  	void *param;
>  	size_t param_len;
>  	struct sock *sk;
> @@ -54,7 +54,7 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 c=
md, u8 status,
> =20
>  struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 o=
pcode,
>  					   struct hci_dev *hdev);
> -void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
> +void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
>  			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
>  			  void *data);
>  struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,

--=20
Pauli Virtanen
