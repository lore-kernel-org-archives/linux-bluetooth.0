Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBA346E42;
	Thu, 18 Dec 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076103; cv=pass; b=HDw2HW5zCGSq19ubKcRkQF/XVZ2xg19dRHBwD99lk6WMNXwcniNPZoBAGXoUq2PuzwbtdXwOScI5hZvGMtgNJzYHv/51cO8GHhZal/OIW0CnoLDrz050D5fbpm/+sg+TSpM/OtbQ7MTLXe7R6ahZplJFof2/25bfzRPvLEHzrSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076103; c=relaxed/simple;
	bh=dDBdmrMo12kN+1NhkRXAI9GwWKWYvc5+0+mH+WXEN9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9vV659rK/+fRWp7hBiQIsGGTEoMAPViyKD4A65s551e6OOOyCuQDQBVNGZZy5sC/5T3Js3O3osLTb4leLW0FHuNaWYq6KVdwLWp6AlMZeGR0S7BVp3RLsjr/omhn1Oprevd3wgMGFw7L7HP8B+pwPuOHsC5261u3LBfCvKMmnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=EO1rF5aG; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="EO1rF5aG"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dXGRs1jJpz49Q4Z;
	Thu, 18 Dec 2025 18:32:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766075579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PqhkczpkmSATRl25OYlOkvsh9illEiUCxejuR+2Nd2U=;
	b=EO1rF5aGy63wBA3RNx+zBusPj+EjukN9+tDbyteF4ShqIGAALMv9dCw0ThxxPtc28c6U0l
	ZtxFoOSujThjl1WBxk5gwGVCuAjwl8qXujjGl0vyUXP5ikpPB7Ik1MsyjrCrE2ut0DyOgH
	hBNDE/95xoR/LemxFn8oCS9g496AmBQ4kuTkMADggjLxrmgJRCEEfcx9Ffz63Lwp//pEgW
	ladmGixibQHSuZvPq2DVWQZthw89qPEwjn+BT2HY6QCgybBs5J8Gflumr37ZlpMBTg4IOt
	9AyUWGl4NmGzK/J/XKcPJ+LgRUxvsTiqxfzx2YL9f35aEj/PnJSUGzxUEBs1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766075579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PqhkczpkmSATRl25OYlOkvsh9illEiUCxejuR+2Nd2U=;
	b=jJ1VHqwi5Rg2uj4H61XjQO+vZNx1YrVeBZnmnd7z3gilUVwMXxS4v1I0sGbWzAzv8JSzc6
	gqkba5HdGNs7z7bQevI1gjE4X6YgdfOah2TxGkrcdD+ISMqRi4pAKv1tMe3kEh9Odre3IY
	6sikbGHFaptAhUqX9jG9GGgBQSgCPdVrNR3lDnMVCTN2UZNJSuYBP1jqLAYfJ7JnL6eXA3
	DHEnv6hSKcJST6Dx0TXTDp9iUUJB48Kk1Ezly3GSQSIsLn6kuiFhhFTMH8SBaLgBNRz0rm
	ZdldcjGZbZCM/dDHsi64FB9BHPj/DSJn/drAniNHtMaFL4GFpoHJ55/VRSHNAQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766075579;
	b=D5vgI67ec5A03G9LYNhh92HtlJes3GTiXs1DBRu7OYSD+rtMgcdbHbw8Ua0UhSS0bClKnJ
	uRYe06n2pGR4BLXx7EDzjIbGcddaKippad5ZacmCwlJ59Xpvxvdv10aWo3LkHNVSKHOnk/
	uRF6c7nR6c4wceQGpH8J8g2CjUP9OejITn+C9jAsBTyIilCGukjXOWGkXYQ//vmoK9ukY7
	GvkfDNndBn5pdWFubXyhPpKPjM+2dP8NR+1bFlTYc9BT7zxpASFI3fNxHDPnbmEwZ1qI9j
	LefYUVTa9MPCH2xR0/YiadrKPOtDOEH1l4xtWPKrJGvw4aV8aB7uKe2G1e2lAQ==
Message-ID: <8e9f289c294e66881323ee7f8f785a64e2e7ae8e.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci: fix refcounts in LE remote features
 command
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Cihangir Akturk
	 <cakturk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org, 
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Date: Thu, 18 Dec 2025 18:32:55 +0200
In-Reply-To: <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
References: <20251216191255.882653-1-cakturk@gmail.com>
	 <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-12-17 kello 16:36 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Cihangir,
>=20
> On Tue, Dec 16, 2025 at 2:13=E2=80=AFPM Cihangir Akturk <cakturk@gmail.co=
m> wrote:
> >=20
> > KASAN reported a slab-use-after-free in le_read_features_complete()
> > running from hci_cmd_sync_work.  le_read_features_complete() can run
> > after hci_rx_work/hci_conn_del() has removed the link, so the destroy
> > callback may touch a freed hci_conn and trigger a KASAN use-after-free.
> > Duplicate submissions also need to drop the references to avoid leaking
> > the hold and blocking teardown.
> >=20
> > Fix this by taking hci_conn_get() before queueing, passing the conn
> > directly as work data, and balancing hci_conn_hold()/drop() and
> > hci_conn_get()/put() in the completion and all error/-EEXIST paths so
> > the connection stays referenced while the work runs and is released
> > afterwards.
> >=20
> > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> > ---
> >  net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >=20
> > I am not entirely sure that removing the err =3D=3D -ECANCELED early re=
turn
> > is strictly correct. My assumption is that, with the changes in this
> > patch, there does not appear to be another cancellation path that
> > reliably balances hci_conn_drop() and hci_conn_put() for this command.
> > Based on that assumption, keeping the early return could leave the
> > references taken before queuing unbalanced on cancellation, so I opted
> > to remove it to keep the lifetime handling consistent.
> >=20
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index a9f5b1a68356..5a3d288e7015 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hdev, =
hci_cmd_sync_work_func_t func,
> >   * - Lookup if an entry already exist and only if it doesn't creates a=
 new entry
> >   *   and queue it.
> >   */
> > -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_fu=
nc_t func,
> > +static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_syn=
c_work_func_t func,
> >                             void *data, hci_cmd_sync_work_destroy_t des=
troy)
> >  {
> >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > -               return 0;
> > +               return -EEXIST;
> >=20
> >         return hci_cmd_sync_queue(hdev, func, data, destroy);
> >  }
> > +
> > +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_fu=
nc_t func,
> > +                           void *data, hci_cmd_sync_work_destroy_t des=
troy)
> > +{
> > +       int ret;
> > +
> > +       ret =3D __hci_cmd_sync_queue_once(hdev, func, data, destroy);
> > +       return ret =3D=3D -EEXIST ? 0 : ret;
> > +}
> >  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
> >=20
> >  /* Run HCI command:
> > @@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct hci=
_dev *hdev, void *data, int err)
> >=20
> >         bt_dev_dbg(hdev, "err %d", err);
> >=20
> > -       if (err =3D=3D -ECANCELED)
> > -               return;
> > -
> >         hci_conn_drop(conn);
> > +       hci_conn_put(conn);
> >  }
> >=20
> >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
> > @@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_conn=
 *conn)
> >          * role is possible. Otherwise just transition into the
> >          * connected state without requesting the remote features.
> >          */
> > -       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEAT=
URES))
> > -               err =3D hci_cmd_sync_queue_once(hdev,
> > -                                             hci_le_read_remote_featur=
es_sync,
> > -                                             hci_conn_hold(conn),
> > -                                             le_read_features_complete=
);
> > -       else
> > +       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEAT=
URES)) {
> > +               hci_conn_get(conn);
> > +               hci_conn_hold(conn);
> > +               err =3D __hci_cmd_sync_queue_once(hdev,
> > +                                               hci_le_read_remote_feat=
ures_sync,
> > +                                               conn,
> > +                                               le_read_features_comple=
te);
> > +               if (err) {
> > +                       hci_conn_drop(conn);
> > +                       hci_conn_put(conn);
> > +                       if (err =3D=3D -EEXIST)
> > +                               err =3D 0;
> > +               }
> > +       } else
>=20
> Sort of overkill, why do we have to use 2 references? Also we do have
> code for dequeuing callbacks using conn as user_data so either that is
> not working or there is something else at play here. Maybe we need to
> change the order so that dequeue happens before hci_conn_cleanup:
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index dc085856f5e9..b64c0e53d9cd 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
>         skb_queue_purge(&conn->data_q);
>         skb_queue_purge(&conn->tx_q.queue);
>=20
> +       /* Dequeue callbacks using connection pointer as data */
> +       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> +

hci_cmd_sync_dequeue() does not (i) cancel + wait for a job that is
already running, (ii) prevent further jobs for this conn from being
queued. So it's not guaranteed to work here AFAICS.

For (i): note running hci_sync job may be blocked on taking hdev->lock,
which is held here, so trying to cancel + wait deadlocks. Does not seem
straightforward to fix.

For (ii): one would need to audit the places where these jobs are
queued, and make sure they are all done with hdev->lock held, to avoid
racing with the code here. Maybe doable with separate queueing function
that has lockdep asserts.

I suggested some time ago to always hold either refcount or lock to
keep the hci_conn alive everywhere, also in these hci_sync callbacks:

https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/

with similar changes as suggested in this patch. This may be the
simpler fix.

>         /* Remove the connection from the list and cleanup its remaining
>          * state. This is a separate function since for some cases like
>          * BT_CONNECT_SCAN we *only* want the cleanup part without the
>          * rest of hci_conn_del.
>          */
>         hci_conn_cleanup(conn);
> -
> -       /* Dequeue callbacks using connection pointer as data */
> -       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
>  }
>  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_=
type)
>=20
>=20
> >                 err =3D -EOPNOTSUPP;
> >=20
> >         return err;
> > --
> > 2.52.0
> >=20
>=20

--=20
Pauli Virtanen
