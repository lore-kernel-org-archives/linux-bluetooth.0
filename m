Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B63C0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Aug 2023 12:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjHLMK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Aug 2023 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLMK2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Aug 2023 08:10:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9293
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Aug 2023 05:10:31 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::a04d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RNKHR2Gtxz49Q2t;
        Sat, 12 Aug 2023 15:10:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691842227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOtP2rEWG9rhy3tZ1raQlots7HGnqWDmfZbUzukkh2Q=;
        b=gwhbQvM9GjESqXo0zVjupwe4g9iL0uj9i15uQlrWJAqxxOduyoYSVCRF5j4hupAT2O+Hx8
        j2ur8u6KeN7FKAM3iMJ8eJivZpcSQTtd+dPIeyg5oY49ni4u5AMRz57pSR/syO6CupUwKD
        R7QwC8nvuWAQpKEvtAOS+5ZHfQNXfA9VPwo0ixq064lZx1XCAuD5lmwbrsBRbEI6KAIDtK
        3QjzXOVVab6NRS1ZQbw0jP7E/++0Ev3L7CBv9uMeFIix/ZL050sgSq8F8fDeO3RxL7u0oH
        iUEAoFmY8/rK4jCXjmZw3Lbn0Z5KIGYc0I27VKy7OJOeSZwoyQZyqYjzEdUWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691842227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOtP2rEWG9rhy3tZ1raQlots7HGnqWDmfZbUzukkh2Q=;
        b=kDbRl8ZYrK1JBbnIeyV3fHOTpltr5CBE2RUY3sXohlxm/mAKKN9edGeBeSwgDFil5Xq7ip
        V9jPcHmNWs0KHJDjDT9qafvA+Xe9GytPsVpIq1nbbClWioUE5A7+JbvsOOv1Akr6qO+YTz
        YBCCMNij6eNRHxorAl6rWlhiu4MD0bBKyyRTOYTvJpWQsIRJCCnzY7UVRacJNvh2Op2o80
        CdlrQz3qjcKYNQNXN2ing8DMNBBn/7Wf3c43D8Jdq39bCnAlxUNU3c68BRPu8yqrnHMLZb
        mwlLrS7WEFevRBYsUQFlqgWrZq2HH6sJBRmb5DP/VMJ3joiOGWBlel6xeAruIg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691842227; a=rsa-sha256;
        cv=none;
        b=W+9lsep8jth70ba7i5QkALN4EoTYYuVcMEBWU6/6EpCOPxGSzA7v8sNW3LKLHuQy6iX67w
        J8Ki60LXmJP/3eFDMpT0rbgdf2B6mzZJKMKiuqg1r6oIcE9h+Iv7NctPWxB5ItLQgWVGo5
        bD91cXMQuRnPoAoexCpQHD9pJz6QFZ0/Ar8yMU05n9B1luBI6394gZMPfSJanE+DUiusKZ
        w6bqOTxXRzFritcykJOHY/HmCQjBPqCFr16X0jCUivUvfJg1n9iUBA8cD+n5FBIjvaQ4Yp
        J5f3JuC824QvxwOr8dlhZK/5dZ4MKnZBxWl+wjJUBRFxRChqXnLnOeFznjPM7Q==
Message-ID: <cb6ce54a602fb67cdff9dc80360d17a044dc172b.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: hci_sync: Fix UAF in
 hci_disconnect_all_sync
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Sat, 12 Aug 2023 15:10:26 +0300
In-Reply-To: <20230811231610.2025814-1-luiz.dentz@gmail.com>
References: <20230811231610.2025814-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2023-08-11 kello 16:16 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> Use-after-free can occur in hci_disconnect_all_sync if a connection is
> deleted by concurrent processing of a controller event.
>=20
> To prevent this the code now tries to iterate over the list backwards
> to ensure the links are cleanup before its parents, also it no longer
> relies on a cursor, instead it always uses the last element since
> hci_abort_conn_sync is guaranteed to call hci_conn_del.
>=20
> UAF crash log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_set_powered_sync
> (net/bluetooth/hci_sync.c:5424) [bluetooth]
> Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124
>=20
> CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
> 6.5.0-rc1+ #10
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.2-1.fc38 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x5b/0x90
>  print_report+0xcf/0x670
>  ? __virt_addr_valid+0xdd/0x160
>  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  kasan_report+0xa6/0xe0
>  ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
>  hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
>  ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
>  hci_cmd_sync_work+0x137/0x220 [bluetooth]
>  process_one_work+0x526/0x9d0
>  ? __pfx_process_one_work+0x10/0x10
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  ? mark_held_locks+0x1a/0x90
>  worker_thread+0x92/0x630
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x196/0x1e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  </TASK>
>=20
> Allocated by task 1782:
>  kasan_save_stack+0x33/0x60
>  kasan_set_track+0x25/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  hci_conn_add+0xa5/0xa80 [bluetooth]
>  hci_bind_cis+0x881/0x9b0 [bluetooth]
>  iso_connect_cis+0x121/0x520 [bluetooth]
>  iso_sock_connect+0x3f6/0x790 [bluetooth]
>  __sys_connect+0x109/0x130
>  __x64_sys_connect+0x40/0x50
>  do_syscall_64+0x60/0x90
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>=20
> Freed by task 695:
>  kasan_save_stack+0x33/0x60
>  kasan_set_track+0x25/0x30
>  kasan_save_free_info+0x2b/0x50
>  __kasan_slab_free+0x10a/0x180
>  __kmem_cache_free+0x14d/0x2e0
>  device_release+0x5d/0xf0
>  kobject_put+0xdf/0x270
>  hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
>  hci_event_packet+0x579/0x7e0 [bluetooth]
>  hci_rx_work+0x287/0xaa0 [bluetooth]
>  process_one_work+0x526/0x9d0
>  worker_thread+0x92/0x630
>  kthread+0x196/0x1e0
>  ret_from_fork+0x2c/0x50
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 51 ++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5eb30ba21370..86e18e09136e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5370,6 +5370,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struc=
t hci_conn *conn, u8 reason)
>  {
>  	int err =3D 0;
>  	u16 handle =3D conn->handle;
> +	struct hci_conn *c;
> =20
>  	switch (conn->state) {
>  	case BT_CONNECTED:
> @@ -5389,43 +5390,53 @@ int hci_abort_conn_sync(struct hci_dev *hdev, str=
uct hci_conn *conn, u8 reason)
>  		hci_dev_unlock(hdev);
>  		return 0;
>  	default:
> +		hci_dev_lock(hdev);
>  		conn->state =3D BT_CLOSED;
> +		hci_disconn_cfm(conn, reason);
> +		hci_conn_del(conn);
> +		hci_dev_unlock(hdev);
>  		return 0;
>  	}
> =20
> +	/* Check if the connection hasn't been cleanup while waiting
> +	 * commands to complete.
> +	 */
> +	c =3D hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!c || c !=3D conn)
> +		return 0;
> +
>  	/* Cleanup hci_conn object if it cannot be cancelled as it
>  	 * likelly means the controller and host stack are out of sync
>  	 * or in case of LE it was still scanning so it can be cleanup
>  	 * safely.
>  	 */
> -	if (err) {
> -		struct hci_conn *c;
> -
> -		/* Check if the connection hasn't been cleanup while waiting
> -		 * commands to complete.
> -		 */
> -		c =3D hci_conn_hash_lookup_handle(hdev, handle);
> -		if (!c || c !=3D conn)
> -			return 0;
> -
> -		hci_dev_lock(hdev);
> -		hci_conn_failed(conn, err);
> -		hci_dev_unlock(hdev);
> -	}
> +	hci_dev_lock(hdev);
> +	hci_conn_failed(conn, reason);
> +	hci_dev_unlock(hdev);

To me it seems there is a theoretical race here:

task 1 in hci_conn_abort_sync
task 2 in hci_disconn_complete_evt
task 1: c =3D hci_conn_hash_lookup_handle(conn->handle)
task 2: hci_dev_lock(hdev)
task 1: hci_dev_lock(hdev)     /* waits here */
task 2: hci_conn_del(conn)     /* conn deleted the first time */
task 2: hci_dev_unlock(hdev)
task 1: hci_conn_failed(conn, err)   /* conn deleted again */

Moving hci_dev_lock before hci_conn_hash_lookup_handle avoids this.


Another related theoretical race seems to be in e.g.
hci_acl/sco/isodata_packet which do

	hci_dev_lock(hdev);
	conn =3D hci_conn_hash_lookup_handle(hdev, handle);
	hci_dev_unlock(hdev);
	if (conn)
		do_stuff_without_lock(conn);

These tasks run in hdev->workqueue, so it seems like deletion of conn
in hdev->req_workqueue like in hci_conn_abort_sync here could in theory
occur while do_stuff_without_lock is still accessing conn.


I guess in reality it depends on whether the two workqueues are really
running the tasks on different CPU at the same time, and if one can hit
narrow time windows.


> =20
>  	return err;
>  }
> =20
>  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
>  {
> -	struct hci_conn *conn, *tmp;
> -	int err;
> +	struct list_head *head =3D &hdev->conn_hash.list;
> +	struct hci_conn *conn;
> =20
> -	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
> -		err =3D hci_abort_conn_sync(hdev, conn, reason);
> -		if (err)
> -			return err;
> +	rcu_read_lock();
> +	while ((conn =3D list_first_or_null_rcu(head, struct hci_conn, list))) =
{
> +		/* Make sure the connection is not freed while unlocking */
> +		conn =3D hci_conn_get(conn);
> +		rcu_read_unlock();
> +		/* Disregard possible errors since hci_conn_del shall have been
> +		 * called even in case of errors had occurred since it would
> +		 * then cause hci_conn_failed to be called which calls
> +		 * hci_conn_del internally.
> +		 */
> +		hci_abort_conn_sync(hdev, conn, reason);
> +		hci_conn_put(conn);
> +		rcu_read_lock();
>  	}
> +	rcu_read_unlock();
> =20
>  	return 0;
>  }

