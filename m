Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF9C001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 20:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHJU4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJU4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 16:56:09 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DC2737
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 13:56:04 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RMK2Y0Fcwz49Pyt;
        Thu, 10 Aug 2023 23:55:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691700949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=376tI/qnaZXK4CK2c3qzb2ySvHYkwSTC1R7hqxERe78=;
        b=rN3O/GzoMyMTTCtAZaamDiCGp7zlavMwKYMIfN2Lyglo96f0gTItvM1YiUvoiedKBsE/Xi
        fZFmPvy4NzegLRF6LXKuYbeZUY4p1YAai2od51Tsc0hEZuRrHpptKHYTst+grd5D65oMCT
        8sHy2JoOKgwHEgTfB/5A08OSf9BEG+PajY24O3+R3UVXUWoX5DUBJEyIvbp1YlSdmCJ8W7
        7jRsY4SRMmBQY6EFQS/NF4EIXrYF5ceGs0OHakFHuUrwfzLbMoKfqbHVXAcAFsn7SAucfE
        ILZdm2cZowvEvD71FSBPrEHMJarcN/T5byyDc/uzlvXxJ6dGsk+SxsHizYjwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691700949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=376tI/qnaZXK4CK2c3qzb2ySvHYkwSTC1R7hqxERe78=;
        b=HHC2hPbgwPHIzqB8BIkrHNxfU7lTbP5CV5D760DZHFsJe2wjsKsovrU+iIdtWKjj0N8O2f
        j2liThso97P0avo+xVdZEoNPqvrFnDhHqdFHOJDmTXowRPoeDlznkVXFkj9O/wAvEaQIDA
        C9Q6Xt8eN61mnN7W0ND6l9jn5psL3C4IFmOlh8zgc3nhDAJKo2P1ucz6u8691O7sNGffGV
        U51aqwSUZmTmtee4xl1qNVNg6TwkpKXgGw/o9lDa0oD4MFLoQMi2FPihPm9sZnCijuxceM
        qyDgd1LF/p6HaAbpdCmGZNcS46+7a/32Aa6N1zzpUJqXCKIJJvW7CkIct3mbGQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691700949; a=rsa-sha256;
        cv=none;
        b=FFG3nAn1fxCKDOpDk4kL3mqKCglrfuQWhukVxJLwkOM6wq2E+R9DmBf993UNDK8VHBb6og
        d/AAwZS71YvywFlalEM/1mX1jHra+Q9OFfwjI1UF2MRwFRuNHukLw8+96am5VxdHs/CpcI
        PFlseCbmG/IVl+76emqFZpWp8DJG6GkjP6JNLxCJmX90AF1NAsVe3ay7l8k+qwpuZj2Rxs
        H4i+lSWKjQeUvqeT/NQu1Lohs3qNOPO7ZisOEUJjOKR4k1WWh/iS9DkAAQi7F+2sHhy3Nn
        tmf5xtk7+ivdD3H+fKQPaZopdcLi8Si3oqKcUjnBntmkUK/sZ9tuHZLe7OzHYg==
Message-ID: <912e0cae83b4349c6cb91abced44e9687929d2b5.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 10 Aug 2023 23:55:47 +0300
In-Reply-To: <20230809235622.1664227-1-luiz.dentz@gmail.com>
References: <20230809235622.1664227-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-08-09 kello 16:56 -0700, Luiz Augusto von Dentz kirjoitti:
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
>  net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 32fa9006f381..234da30292a4 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5429,7 +5429,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
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

When powering off we do not wait for the Disconnection_Complete=C2=A0or
Connection_Complete events from disconnect/cancel, but only the command
status.

In these cases it looks like hci_abort_conn_sync returns while the conn
still exists. Then the command may get sent again. If the controller
rejects the second disconnect/cancel command with error status then
conn probably gets deleted on second round (kprinting errors),
otherwise it loops here waiting until the conn goes away.

LE connection cancel maybe busy-loops here forever until the connection
completion event arrives, because of the HCI_CONN_CANCEL flag test,
negating the point of not waiting for that event.

Maybe hci_conn_abort_conn_sync should do the "if (err) { ..." cleanup
unconditionally also when err =3D 0? This might get the state out of sync
with controller when powering off, if the power off gets canceled after
this. OTOH, we probably would be deleting the conns anyway when the
connection completion events from the successful commands arrive, so
maybe this doesn't matter and one can think it through.

Tests would indeed be nice here...

> =20
> @@ -5458,13 +5462,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, str=
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

I suspect the ordering may be either way: you can have a pre-existing
ACL connection when ISO is connected, or use something like ISO
BT_DEFER_SETUP and then hci_connect_cis may create the ACL after ISO.

In iso-tester tests it's probably the latter and with real BAP the
former (but didn't actually check it now, too late for today).

Maybe iterating the struct hci_link is OK here, it's probably still
fairly simple.

A big simplification came from having hci_abort_conn delete always and
not bailing out from disconnect_all_sync loop on errors.

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

I think to be UAF-safe the list iteration must either hold
rcu_read_lock and use RCU primitives, or, hold hdev->lock and use usual
list primitives.

In both cases it should take hci_conn_get to prevent concurrent
hci_conn_del freeing the conn before hci_abort_conn_sync is finished
accessing its fields.

rcu_read_lock();
while ((conn =3D list_first_or_null_rcu(...)) {
	conn =3D /* one of conn->links if any, otherwise conn */
	hci_conn_get(conn);
	rcu_read_unlock();
	hci_abort_conn_sync(hdev, conn, reason);
	hci_conn_put(conn);  /* must be before rcu_read_lock */
	rcu_read_lock();
}
rcu_read_unlock();

or with *rcu* -> hdev->lock.

Not using RCU primitives or hdev->lock is probably not safe even if
hci_conn_del is prevented from running concurrently by future changes
in hci_sync,=C2=A0because there may be concurrent list_add_rcu and you can'=
t
know if compiler generated concurrency safe code from the non-RCU list
iteration primitives here.

> =20
>  	return 0;

--=20
Pauli Virtanen
