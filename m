Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16113B280
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759711294; cv=none; b=Up9gTGsoNd2Bk57MI8caZGKJiu2nFRYqCgwCSAwsjDm9Kqlhx5+SGUevgMTjYyp1QMKfz5cF3oJnSbKco15tOgwVKqRR6XewnuH9p8TsiKSkrUi2aioxF5BtVGJdKozOBw8dG3TxavPOGuwwp4qyouZtq7VXd93R98AgZbGW0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759711294; c=relaxed/simple;
	bh=kENviifOEPihXOmLhqQ0qvbDcg6Wg68yfn29YEOFpvQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivNmPYcbhBh57DnumKBwlL9TugnAaDvQ6jJhuqcZ+L+8mqVpPjdNRaC3DyFIZA9uFJjwUzRM3EQRxI3zkAds63pM35vQH3H30It2knIWh6TyxoS9yRT+rzatfLX8Zxxh05BWKJHdh/SxBxjFp5f3HOUgpKBCXxi84ZBKpkUvNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CB093240027
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 02:39:33 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cg0lS3pqbz9rxB
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 02:39:32 +0200 (CEST)
Message-ID: <501816a0c5cc19ec7a2f1527cb5aa8012f33210d.camel@iki.fi>
Subject: Re: [PATCH 0/9] Bluetooth: avoid concurrent deletion of hci_conn
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 06 Oct 2025 00:39:33 +0000
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

pe, 2025-10-03 kello 20:08 +0300, Pauli Virtanen kirjoitti:
> This contains the simpler fixes from
> https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/
>=20
> hdev has two workqueues that run concurrently, and both may delete
> hci_conn. hci_conn* pointers then require either (i) hdev/rcu lock
> covering lookup and usage, or (ii) hci_conn_get reference held.
>=20
> If neither is done, it's likely there are corner cases that hit UAF,
> especially if controller misbehaves.

It may be possible to relax the requirements to also allow

(iii) work executing in hdev->workqueue can assume hci_conn* is not
deleted concurrently.

This is possible if something like the following can be made to work.
However, it may be better to just fix the locking without such trick to
keep it simpler, as there are not that many changes needed and we
anyway need to lock & get in hci_sync.


struct hci_conn_del_sync_work {
	struct work_struct work;
	struct hci_conn *conn;
};

void hci_conn_del_sync_work(struct work_struct *work)
{
	struct hci_conn_del_sync_work *del =3D container_of(...);
	struct hci_dev *hdev =3D del->conn->hdev;

	hci_dev_lock(hdev);
	if (hci_conn_valid(hdev, del->conn)
		hci_conn_del(del->conn);
	hci_dev_unlock(hdev);
	hci_conn_put(del->conn);
}

void hci_conn_del_sync(struct hci_dev *hdev, struct hci_conn *conn)
{
	struct hci_conn_del_sync_work del;

	INIT_WORK(&del.work, hci_conn_del_sync_work);
	del.conn =3D hci_conn_get(conn);

	queue_work(hdev->workqueue, &del.work);
	flush_work(&del.work);
}

>=20
> Correct code in several places to follow the patterns (1)
>=20
>     take lock
>     conn =3D hci_conn_hash_lookup(...)
>     if (conn)
> 	do_something(conn)
>     release lock
>=20
> or (2)
>=20
>     take lock
>     conn =3D hci_conn_hash_lookup(...)
>     if (conn)
> 	conn =3D hci_conn_get(conn)
>     release lock
>     do_something_carefully(conn)
>     hci_conn_put(conn)
>=20
> Generally do_something_carefully should do (3)
>=20
>     take lock
>     if (hci_conn_valid(hdev, conn))
> 	do_something(conn)
>     release lock
>=20
> hci_conn_valid() shouldn't be called unless refcount on conn is known to
> be held, as the pointer may otherwise already be freed, and even though
> hci_conn_valid() doesn't dereference the comparison of freed pointer it
> does is strictly speaking undefined behavior (kalloc is not guaranteed
> to not reuse addresses).
>=20
> Some of the code touched here is missing locks for (3), those need to be
> addressed in separate series.
>=20
> Pauli Virtanen (9):
>   Bluetooth: hci_event: extend hdev lock in
>     hci_le_remote_conn_param_req_evt
>   Bluetooth: hci_conn: take hdev lock in set_cig_params_sync
>   Bluetooth: mgmt: take lock and hold reference when handling hci_conn
>   Bluetooth: L2CAP: fix hci_conn_valid() usage
>   Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
>   Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
>   Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if
>     exists
>   Bluetooth: hci_conn: hold reference in abort_conn_sync
>   Bluetooth: hci_sync: hold references in hci_sync callbacks
>=20
>  net/bluetooth/hci_conn.c   |  22 +++++-
>  net/bluetooth/hci_event.c  |  33 +++++----
>  net/bluetooth/hci_sync.c   | 144 ++++++++++++++++++++++++++++++-------
>  net/bluetooth/l2cap_core.c |   8 ++-
>  net/bluetooth/mgmt.c       |  42 +++++++++--
>  5 files changed, 202 insertions(+), 47 deletions(-)
