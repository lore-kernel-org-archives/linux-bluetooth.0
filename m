Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FA18455B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266127; cv=pass; b=jqMiQbSZkP14yLHRLShWGr3QwEBXXisNVpUANJLC/LFzk8PDxzNAbj0lAfAFoqjmvLYYzvr8kx2VyZ59WIDt5vY60te8B0fLwCHN4JQNA/4I/Kbj6NXeKkPfEGcoV9hX4WRkiNM1azQtOe/QUvAdofqjfDqSFUSL/LLoasE+MMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266127; c=relaxed/simple;
	bh=ipAwt3byg0KVijRKR9j1fkdmm4qh4DHawQ1XqVY3NY4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVdx3HnftqMTh5kSBYtN1RfEOXgUZcH19iP9hAr4glSA5gq28F1D6zG4zBko8AFilGh7MQ5BPeqCxZdY4oZ77JNt43EkkPqbhNjiGKU09+Mt5LAmz7SdM6NZFhOMY09PW2NBVbIZo7lD5FNJyYUnpH6dzb/bzg4VPeZpCtBoO8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iMRH7+Fk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iMRH7+Fk"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Y2wmn0RJtz49Q9L;
	Wed,  4 Dec 2024 00:48:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1733266121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=enAhh8caf0OlITuYVmRpoJLVXk+5OypyXsTvgb0QlFI=;
	b=iMRH7+Fk84o31rxTr58exF6fbldfqySLmEe/VkZDpeID6Ig2zB2gLBu1jxGpBSN9T/jpnK
	C6mTt2XRGDMdZ3pxGeiGbzW7SzKml3CTUDMKJPEXzAKeqYFi5Y4RCoKUN5skbcEZF0oDIh
	qmUvgFRc+hXCmEP1ry0fHPt9x6Kt5EJ/U5QpvQgG4bGxXIq3ztRISemGc9BrTogoLGs8KP
	ai6gmHVhN3+E1NTOjMhIQZ+LTOBwWGZJFPAfYXJJVnb48p87wRFF7iuQAOoj3wVKUz9FmW
	ERTza9RTIxyt6i5bM2SQwgPMcLNXLVd+Pu95bGmOrZ0Xed7Vogb1npX2kH74sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1733266121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=enAhh8caf0OlITuYVmRpoJLVXk+5OypyXsTvgb0QlFI=;
	b=XspGIQab3F63w+4GIkf3x8DzSZVQKoUg7UOooO+TPeswhrjc5q9YJn1RUJMKVBWoJndOjz
	afUhKu2lnNs3n7F4ei0hkOVvA7TKOBAlwmv7hTnd5yibgEu4Q08hdrt2a3Pn6vHRT7nvEN
	H0Z8oLxKzYDlrvKsUMyJeJdWhyh4II4ZCUQGc26B1PIu6D/1qE+rTM3h4mXph6+dOUQoR7
	oezHajG0mArC9e/LocJuG5doq/47Shh9dBG0AQYRHAd/6qZpQno4TYM2xuJJJ8NGNnRagp
	qjdZ5RCA9AMI9RQEsHrI9OMihvQ7Y0l4egsKuWgz9/QI8CtPJ5IIuwPIQbW1Mg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1733266121; a=rsa-sha256;
	cv=none;
	b=W1lrNz0MNc3SsNvm6qZvD8S85S5GV6NZnKaueoY/+h/BN+jED9iBbuGCgcd0idapr5vLRP
	GyzQWIV22IkVBmv+41kCCV4EhL3jVwTSOqhqWCr2tofFreHX39P7r8zp7hRi4D8JUD19YY
	xVhQsetJz64v7NFh6DIq3OSrPS97RthpYdUpR2rUfbAzC8gjAqSvHVpjn8ksGMWBMQCbns
	wyOCvIIyXZgHFS8SIIlgKAFHqMl0yBwYFielf0NdPD/vBU+GIOgiH7BQaJISC1zbYY8tp7
	Ni1DxQbnuDHZhsiV5xBXUtihhxlOmcBIgpNx1jCTg5mR7+WFIn8q1qjMWGdMhw==
Message-ID: <0b897a445022f99bb812c811135fdbc8bf73bbba.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called
 from invalid context
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 04 Dec 2024 00:48:39 +0200
In-Reply-To: <20241203211435.194301-1-luiz.dentz@gmail.com>
References: <20241203211435.194301-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-12-03 kello 16:14 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
> like the bellow:
>=20
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:585
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworke=
r/u9:2
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by kworker/u9:2/5070:
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_on=
e_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_sc=
heduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_co=
mplete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:298 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:750 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_=
complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g48=
0e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
>  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:693=
9
>  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
>  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
>  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
>=20
> Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2fb0835e0c9cefc34614
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
>  net/bluetooth/hci_core.c         |  9 ++--
>  2 files changed, 65 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index ea798f07c5a2..95f11f04e24a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -804,7 +804,6 @@ struct hci_conn_params {
>  extern struct list_head hci_dev_list;
>  extern struct list_head hci_cb_list;
>  extern rwlock_t hci_dev_list_lock;
> -extern struct mutex hci_cb_list_lock;
> =20
>  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev=
_flags)
>  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->d=
ev_flags)
> @@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_con=
n *conn, __u8 status)
>  {
>  	struct hci_cb *cb;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->connect_cfm)
> -			cb->connect_cfm(conn, status);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +		if (cb->connect_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.connect_cfm(conn, status);
> +			rcu_read_lock();

This looks like incorrect RCU usage

[CPU 1] rcu_read_unlock()
[CPU 2] hci_unregister_cb(cb)
[CPU 2] hci_unregister_cb(next cb)
[CPU 1] rcu_read_lock()
[CPU 1] list_for_each_entry_rcu -> iterates to "next cb" not in list

If all hci_cb weren't static, it'd also UAF (maybe it is for rfcomm?).


hci_le_create_big_complete_evt() also does this (and maybe crashes if
ev->status !=3D 0 ?), so maybe it is simples to fix it.


> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
> =20
>  	if (conn->connect_cfm_cb)
>  		conn->connect_cfm_cb(conn, status);
> @@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_con=
n *conn, __u8 reason)
>  {
>  	struct hci_cb *cb;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> +	rcu_read_lock();
>  	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->disconn_cfm)
> -			cb->disconn_cfm(conn, reason);
> +		if (cb->disconn_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.disconn_cfm(conn, reason);
> +			rcu_read_lock();
> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
> =20
>  	if (conn->disconn_cfm_cb)
>  		conn->disconn_cfm_cb(conn, reason);
> @@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn *=
conn, __u8 status)
> =20
>  	encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> +	rcu_read_lock();
>  	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->security_cfm)
> -			cb->security_cfm(conn, status, encrypt);
> +		if (cb->security_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.security_cfm(conn, status, encrypt);
> +			rcu_read_lock();
> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
> =20
>  	if (conn->security_cfm_cb)
>  		conn->security_cfm_cb(conn, status);
> @@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>  			conn->sec_level =3D conn->pending_sec_level;
>  	}
> =20
> -	mutex_lock(&hci_cb_list_lock);
> +	rcu_read_lock();
>  	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->security_cfm)
> -			cb->security_cfm(conn, status, encrypt);
> +		if (cb->security_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.security_cfm(conn, status, encrypt);
> +			rcu_read_lock();
> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
> =20
>  	if (conn->security_cfm_cb)
>  		conn->security_cfm_cb(conn, status);
> @@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hci_=
conn *conn, __u8 status)
>  {
>  	struct hci_cb *cb;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> +	rcu_read_lock();
>  	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->key_change_cfm)
> -			cb->key_change_cfm(conn, status);
> +		if (cb->key_change_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.key_change_cfm(conn, status);
> +			rcu_read_lock();
> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
>  }
> =20
>  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 statu=
s,
> @@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct hci=
_conn *conn, __u8 status,
>  {
>  	struct hci_cb *cb;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->role_switch_cfm)
> -			cb->role_switch_cfm(conn, status, role);
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +		if (cb->role_switch_cfm) {
> +			struct hci_cb cpy =3D *cb;
> +
> +			/* Callback may block so release RCU read lock */
> +			rcu_read_unlock();
> +			cpy.role_switch_cfm(conn, status, role);
> +			rcu_read_lock();
> +		}
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> +	rcu_read_unlock();
>  }
> =20
>  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f9e19f9cb5a3..25d180d225c1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
>  {
>  	BT_DBG("%p name %s", cb, cb->name);
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_add_tail(&cb->list, &hci_cb_list);
> -	mutex_unlock(&hci_cb_list_lock);
> +	list_add_tail_rcu(&cb->list, &hci_cb_list);
> =20
>  	return 0;
>  }
> @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
>  {
>  	BT_DBG("%p name %s", cb, cb->name);
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_del(&cb->list);
> -	mutex_unlock(&hci_cb_list_lock);
> +	list_del_rcu(&cb->list);
> +	synchronize_rcu();
> =20
>  	return 0;
>  }

