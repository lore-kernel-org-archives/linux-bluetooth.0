Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101926AFC
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337876; cv=pass; b=VkuHX081ou0zRqocHiUT7DIUXxoazYF5SLE93zTzqM46POfXPAihDE5rAgFIbYXAAN8jYo5RDEhV3+kvaS6gynT+LKcybQc6gj4ojaV8FbEmBouRmldUDLsf/tH519EcwYRkLKUytZ2dqe39jyPAJ4Y0Ph4yrdjqVSPfYd/QZ34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337876; c=relaxed/simple;
	bh=y8JGQcASYe7+9M8koUojLmyEDwDnjYeQC4OVsk91oCI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+oxexoNJF2NsygvpS0GkBkQZLyM1hNsW+UwRq/4f+ff02qVK7YeY7hYJkXnjrvT4RnFrEa1JuiXNNofc4K11l04i+3k/AiSqvlIksuterwNH+PbhJH9AHWkQO6UvPmF5i+GNQInb8VA2iGLYdt+X21Zk4U0kE7vPplfdpW8BYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=q+0qqe9h; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="q+0qqe9h"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Y3RJS3M5wz49Q5b;
	Wed,  4 Dec 2024 20:44:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1733337864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BKHnwBAa/HYtsdsJHiXptbpHNOhHq3pU2BfrPTcBjs4=;
	b=q+0qqe9hbfP4jTIzR+BD7850L4ro6dthn/BNf4pnZ2W+bQFWI7fMX+kQB00XXvJSZs5Vni
	zSDVsheqPUYiMpEy7X2FtDYHL/zR0lwfUQTUGiCW4QaxP0+4t+e+51VNGnXGbycuoPwpDh
	v6vTcbiIGQvF+rDaVIdVzKmSPs36TonEG0NdhGRyzpfFWnU7lHM02uuq2wHEUoRdzEpHma
	sdSgz4HboX+MJ3WpGtVmb+S5vrvQXzB6KtMkKWwTbtQRykFoZ+kY/cnhGDoKsWhFzJN0U6
	+a/GlC4YHs5ubqW8rABsBQn1RNpPywEcx/dsX8Tcd9n8QVYcWxXs76HHMKITwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1733337864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BKHnwBAa/HYtsdsJHiXptbpHNOhHq3pU2BfrPTcBjs4=;
	b=VxSw3bzRXhSaL6qiMw0oTrUNbG47Hv8wtAssM1iXU1jWhMEaic7OwqU3qqW3doW+/t35q7
	CpfBNFDsll9e82Stn/CCizMvpX/EbdYkaRzJSYsFFx5GwgXnt5QMtD501Fh4W+8BEjEaQw
	QHhdtItZ1QR1QP0lZ+nKCwFNO3tXD6hZefIpcJfMHDE7ckAYrzXlAcrNfruAraFdDSHE4m
	CWf96jkxN2V/VEJOTiGaFkJWMfwRJOrOAXW+fROPdemum42AW7deYb8EONdpesk4bJa60g
	ka0S3wyrk02nbsa0OA33Purf1YN+l2QiD7d2FA1t04xdtJqTDdk/BMw+xUkaOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1733337864; a=rsa-sha256;
	cv=none;
	b=hP0Vs9lPQ2VMrASG8on8oPm4sOjocYG+7vHPi5OcnPfL9zCxUh6fYmEMnLhXPmgYYlgwtt
	4EiYDymC2C+t9OzTztTdvaNT7yyzrEU+TQYR4nLP65zJfW/FbsRAeFNmScYA07F9TMhLk8
	vboPFpbe6DCBGRofwbzu4vxCju6eKF0/An96XmFoeMc8qGmhB3kqy1+LOkq5mEFyYoQbLO
	YZKb2fzeSKGNvXcnlnAhmSGa5+rgIvADX9aPf+bms540x8xMAqUYDlJ7iNsF5zNkgamnUG
	3sMoHwTC2NFGaGXGzubL09pQbHBaxG6LDhprGbPTtZEEhPTWqeB9468DjZbXvA==
Message-ID: <d30bea803c24a8ba63e7f9d217ff61afc302a5b5.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix sleeping function called
 from invalid context
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 04 Dec 2024 20:44:22 +0200
In-Reply-To: <20241204165849.392564-2-luiz.dentz@gmail.com>
References: <20241204165849.392564-1-luiz.dentz@gmail.com>
	 <20241204165849.392564-2-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
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

Hi Luiz,

ke, 2024-12-04 kello 11:58 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
> like the bellow:

This also in principle allows callbacks to be still running on another
CPU when hci_unregister_cb() exits. Not sure if that is unwanted.

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
>  include/net/bluetooth/hci_core.h | 108 ++++++++++++++++++++-----------
>  net/bluetooth/hci_core.c         |   9 +--
>  net/bluetooth/iso.c              |   6 ++
>  net/bluetooth/l2cap_core.c       |  12 ++--
>  net/bluetooth/rfcomm/core.c      |   6 ++
>  net/bluetooth/sco.c              |  12 ++--
>  6 files changed, 97 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index ea798f07c5a2..ca22ead85dbe 100644
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
> @@ -2017,24 +2016,47 @@ struct hci_cb {
> =20
>  	char *name;
> =20
> +	bool (*match)		(struct hci_conn *conn);
>  	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
>  	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
>  	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
> -								__u8 encrypt);
> +				 __u8 encrypt);
>  	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
>  	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role)=
;
>  };
> =20
> +static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head=
 *list)
> +{
> +	struct hci_cb *cb, *cpy;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +		if (cb->match && cb->match(conn)) {
> +			cpy =3D kmalloc(sizeof(*cpy), GFP_ATOMIC);
> +			if (!cpy)
> +				break;
> +
> +			*cpy =3D *cb;
> +			INIT_LIST_HEAD(&cpy->list);
> +			list_add_rcu(&cpy->list, list);
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
>  static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
>  {
> -	struct hci_cb *cb;
> +	struct list_head list;
> +	struct hci_cb *cb, *tmp;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> +	INIT_LIST_HEAD(&list);
> +	hci_cb_lookup(conn, &list);
> +
> +	list_for_each_entry_safe(cb, tmp, &list, list) {
>  		if (cb->connect_cfm)
>  			cb->connect_cfm(conn, status);
> +		kfree(cb);
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> =20
>  	if (conn->connect_cfm_cb)
>  		conn->connect_cfm_cb(conn, status);
> @@ -2042,22 +2064,43 @@ static inline void hci_connect_cfm(struct hci_con=
n *conn, __u8 status)
> =20
>  static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
>  {
> -	struct hci_cb *cb;
> +	struct list_head list;
> +	struct hci_cb *cb, *tmp;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> +	INIT_LIST_HEAD(&list);
> +	hci_cb_lookup(conn, &list);
> +
> +	list_for_each_entry_safe(cb, tmp, &list, list) {
>  		if (cb->disconn_cfm)
>  			cb->disconn_cfm(conn, reason);
> +		kfree(cb);
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
> =20
>  	if (conn->disconn_cfm_cb)
>  		conn->disconn_cfm_cb(conn, reason);
>  }
> =20
> +static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
> +				    __u8 encrypt)
> +{
> +	struct list_head list;
> +	struct hci_cb *cb, *tmp;
> +
> +	INIT_LIST_HEAD(&list);
> +	hci_cb_lookup(conn, &list);
> +
> +	list_for_each_entry_safe(cb, tmp, &list, list) {
> +		if (cb->security_cfm)
> +			cb->security_cfm(conn, status, encrypt);
> +		kfree(cb);
> +	}
> +
> +	if (conn->security_cfm_cb)
> +		conn->security_cfm_cb(conn, status);
> +}
> +
>  static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
>  {
> -	struct hci_cb *cb;
>  	__u8 encrypt;
> =20
>  	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
> @@ -2065,20 +2108,11 @@ static inline void hci_auth_cfm(struct hci_conn *=
conn, __u8 status)
> =20
>  	encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->security_cfm)
> -			cb->security_cfm(conn, status, encrypt);
> -	}
> -	mutex_unlock(&hci_cb_list_lock);
> -
> -	if (conn->security_cfm_cb)
> -		conn->security_cfm_cb(conn, status);
> +	hci_security_cfm(conn, status, encrypt);
>  }
> =20
>  static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>  {
> -	struct hci_cb *cb;
>  	__u8 encrypt;
> =20
>  	if (conn->state =3D=3D BT_CONFIG) {
> @@ -2105,40 +2139,38 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>  			conn->sec_level =3D conn->pending_sec_level;
>  	}
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> -		if (cb->security_cfm)
> -			cb->security_cfm(conn, status, encrypt);
> -	}
> -	mutex_unlock(&hci_cb_list_lock);
> -
> -	if (conn->security_cfm_cb)
> -		conn->security_cfm_cb(conn, status);
> +	hci_security_cfm(conn, status, encrypt);
>  }
> =20
>  static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status=
)
>  {
> -	struct hci_cb *cb;
> +	struct list_head list;
> +	struct hci_cb *cb, *tmp;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> +	INIT_LIST_HEAD(&list);
> +	hci_cb_lookup(conn, &list);
> +
> +	list_for_each_entry_safe(cb, tmp, &list, list) {
>  		if (cb->key_change_cfm)
>  			cb->key_change_cfm(conn, status);
> +		kfree(cb);
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
>  }
> =20
>  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 statu=
s,
>  								__u8 role)
>  {
> -	struct hci_cb *cb;
> +	struct list_head list;
> +	struct hci_cb *cb, *tmp;
> =20
> -	mutex_lock(&hci_cb_list_lock);
> -	list_for_each_entry(cb, &hci_cb_list, list) {
> +	INIT_LIST_HEAD(&list);
> +	hci_cb_lookup(conn, &list);
> +
> +	list_for_each_entry_safe(cb, tmp, &list, list) {
>  		if (cb->role_switch_cfm)
>  			cb->role_switch_cfm(conn, status, role);
> +		kfree(cb);
>  	}
> -	mutex_unlock(&hci_cb_list_lock);
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
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 8ed818254dc8..eccdaa16cba0 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2154,6 +2154,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t=
 *bdaddr, __u8 *flags)
>  	return HCI_LM_ACCEPT;
>  }
> =20
> +static bool iso_match(struct hci_conn *hcon)
> +{
> +	return hcon->type =3D=3D ISO_LINK || hcon->type =3D=3D LE_LINK;
> +}
> +
>  static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
>  {
>  	if (hcon->type !=3D ISO_LINK) {
> @@ -2335,6 +2340,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff=
 *skb, u16 flags)
> =20
>  static struct hci_cb iso_cb =3D {
>  	.name		=3D "ISO",
> +	.match		=3D iso_match,
>  	.connect_cfm	=3D iso_connect_cfm,
>  	.disconn_cfm	=3D iso_disconn_cfm,
>  };
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6544c1ed7143..27b4c4a2ba1f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7217,6 +7217,11 @@ static struct l2cap_chan *l2cap_global_fixed_chan(=
struct l2cap_chan *c,
>  	return NULL;
>  }
> =20
> +static bool l2cap_match(struct hci_conn *hcon)
> +{
> +	return hcon->type =3D=3D ACL_LINK || hcon->type =3D=3D LE_LINK;
> +}
> +
>  static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  {
>  	struct hci_dev *hdev =3D hcon->hdev;
> @@ -7224,9 +7229,6 @@ static void l2cap_connect_cfm(struct hci_conn *hcon=
, u8 status)
>  	struct l2cap_chan *pchan;
>  	u8 dst_type;
> =20
> -	if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> -		return;
> -
>  	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
> =20
>  	if (status) {
> @@ -7291,9 +7293,6 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
> =20
>  static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
>  {
> -	if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> -		return;
> -
>  	BT_DBG("hcon %p reason %d", hcon, reason);
> =20
>  	l2cap_conn_del(hcon, bt_to_errno(reason));
> @@ -7572,6 +7571,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, stru=
ct sk_buff *skb, u16 flags)
> =20
>  static struct hci_cb l2cap_cb =3D {
>  	.name		=3D "L2CAP",
> +	.match		=3D l2cap_match,
>  	.connect_cfm	=3D l2cap_connect_cfm,
>  	.disconn_cfm	=3D l2cap_disconn_cfm,
>  	.security_cfm	=3D l2cap_security_cfm,
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index ad5177e3a69b..4c56ca5a216c 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -2134,6 +2134,11 @@ static int rfcomm_run(void *unused)
>  	return 0;
>  }
> =20
> +static bool rfcomm_match(struct hci_conn *hcon)
> +{
> +	return hcon->type =3D=3D ACL_LINK;
> +}
> +
>  static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 enc=
rypt)
>  {
>  	struct rfcomm_session *s;
> @@ -2180,6 +2185,7 @@ static void rfcomm_security_cfm(struct hci_conn *co=
nn, u8 status, u8 encrypt)
> =20
>  static struct hci_cb rfcomm_cb =3D {
>  	.name		=3D "RFCOMM",
> +	.match		=3D rfcomm_match,
>  	.security_cfm	=3D rfcomm_security_cfm
>  };
> =20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 7eb8d3e04ec4..40c4957cfc0b 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1397,11 +1397,13 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>  	return lm;
>  }
> =20
> +static bool sco_match(struct hci_conn *hcon)
> +{
> +	return hcon->type =3D=3D SCO_LINK || hcon->type =3D=3D ESCO_LINK;
> +}
> +
>  static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
>  {
> -	if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> -		return;
> -
>  	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
> =20
>  	if (!status) {
> @@ -1416,9 +1418,6 @@ static void sco_connect_cfm(struct hci_conn *hcon, =
__u8 status)
> =20
>  static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  {
> -	if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> -		return;
> -
>  	BT_DBG("hcon %p reason %d", hcon, reason);
> =20
>  	sco_conn_del(hcon, bt_to_errno(reason));
> @@ -1444,6 +1443,7 @@ void sco_recv_scodata(struct hci_conn *hcon, struct=
 sk_buff *skb)
> =20
>  static struct hci_cb sco_cb =3D {
>  	.name		=3D "SCO",
> +	.match		=3D sco_match,
>  	.connect_cfm	=3D sco_connect_cfm,
>  	.disconn_cfm	=3D sco_disconn_cfm,
>  };

