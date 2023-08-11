Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77FC04E69
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 23:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjHKXHS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjHKXHB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 19:07:01 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807D47D7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 16:05:05 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RMzs90KT4z49Q1K;
        Sat, 12 Aug 2023 02:05:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691795102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL6Ry6eTXdnKLAQrVba+Aeqe4lCAyYYBTrnqiVMAll4=;
        b=lwSA2rQtLP1/HxXe9MI+xYV1dVnjesrfcDI6AWaPeo5Y2uM96b29lAKhL86a2i5kp3rbEL
        eff92RmUBuDevkC3vJSaM2PcBax2VHoVnyd6hLZZG+zFczEtKUHfIwL0snCRazvqUWqH5c
        Sl1+yVfOyOomwnIxWBtuvCey7JuWpHK2BqMvot+D5tAiRFQbYCElWqvWYdxvSxNh2CF8ff
        Uj91Zdyvib+Ucgd1UOzUYzpL9qljeF9XZ/JC7NWDAH4uLa9QVEzWX3bgCxD6BoEHC4QmlE
        DOduqwduqHpxuUjjuxQRzwjljYD94w0h1VemqZAlpxAxOCWXNWtr9n6jyVDJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691795102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL6Ry6eTXdnKLAQrVba+Aeqe4lCAyYYBTrnqiVMAll4=;
        b=KLpw5l4/K5zydHTkHik+92vcgzg6UBOU3WPj8FziWWaoq8siNB33cPZcwmNhrMB6oAXG3v
        mYbCeQQo2MXalKcdU9Ij079pzEWJ+cdR66SuzbUPBkoWpenWtdgjS6eFn2vnuU9Qe5dLeF
        rdm3lQkjZnlkF2Ypm6YVDRVLXiuk+HnxStN8n9TDE8iG4qdz6RRk64vYiq3sk/nPpYcAw7
        Tv36fZK/EdF1Nlszl69xi6UrfreWRESEX+sTRxwtyvHMBE3Y/1RUfoARx9rTCvHyIl+2pL
        Fkf3dpTn+5dM3rwhTwi5/qlGhnVrdyUtsa1ZdWGv+r3E+sBEv1QgivcGJltaIg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691795102; a=rsa-sha256;
        cv=none;
        b=fuN3U/F+GBLjU2EHz/Di/TUh/w4Me9F00sE2R0nzGxM1EsMjwJBIbQ4sjlwHUHq+I9DUUH
        Y/KKDebsH46I8u33DUCyzA3/5mOBDtYnZLSxzbZE3UJzebWu53tx9qPKzquZvVYIiEtBSM
        uMKNZU4MQXIYI5LaJOdUhCw+/nkwtCS6VrWG1r+X3xgLUMxzT3/k+OwGps46KjSr5PBFuY
        N6PVgA1wUZGnUBbY+AQ/Lk+gKWdczuBAa7eWnvkYy8C1VAviLLmCyNGHWwbQgsLEf/3zUq
        6zkPFrYsWQzFZ3I5TjGeZpzXnp+Qdgcw69afJDrlIug24VL507OfysvSEZIshg==
Message-ID: <874dac566d39d0c33bec6ca96b9ecdf3780bf401.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix UAF in
 hci_disconnect_all_sync
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Sat, 12 Aug 2023 02:04:58 +0300
In-Reply-To: <20230811174633.1818931-1-luiz.dentz@gmail.com>
References: <20230811174633.1818931-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

pe, 2023-08-11 kello 10:46 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> Use-after-free can occur in hci_disconnect_all_sync if a connection is
> deleted by concurrent processing of a controller event.
>=20
> To prevent this the code now tries to iterate over the list backwards
> to ensure the links are cleanup before its parents, also it no longer
> relies on a cursor, instead it always uses the last element since
> hci_abort_conn_sync is guaranteed to call hci_conn_del.

This v2 patch seems to be same as v1. Is it the right one?

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
>  net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5eb30ba21370..c2fa6690c84c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5389,7 +5389,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
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
> @@ -5418,13 +5422,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, str=
uct hci_conn *conn, u8 reason)
> =20
>  static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
>  {
> -	struct hci_conn *conn, *tmp;
> -	int err;
> +	struct list_head *head =3D &hdev->conn_hash.list;
> =20
> -	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
> -		err =3D hci_abort_conn_sync(hdev, conn, reason);
> -		if (err)
> -			return err;
> +	/* Use reverse order so links are cleanup before parents */
> +	while (!list_empty(&hdev->conn_hash.list)) {
> +		struct hci_conn *conn =3D list_last_entry(head, struct hci_conn,
> +							list);
> +
> +		/* Disregard possible errors since hci_conn_del shall have been
> +		 * called even in case of errors had occurred since it would
> +		 * then cause hci_conn_failed to be called which calls
> +		 * hci_conn_del internally.
> +		 */
> +		hci_abort_conn_sync(hdev, conn, reason);
>  	}
> =20
>  	return 0;

--=20
Pauli Virtanen
