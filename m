Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A52E1EE7;
	Thu, 18 Dec 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766081476; cv=pass; b=Oz0FNgU5YoYBDGLsDCBe7pTD1jkj6JHI43SfsOSBUDPvgcye4kE/cJzIgYpQTc+8t7u8jAsuAec6kCfQRL28YHoW6Amh0Pe666kCuXgTgNoBLWRN6rXE0m1NiK+s6k8tsVsEHQ3H1alVUDuvz/PAqOMqLECgiONMHpm3KvSCfFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766081476; c=relaxed/simple;
	bh=YIx+zVA2oi70M5whxlG5BJtZ+kVqLm/zGZm3YtKpBwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUZ9kI6ZC8UFPihFdRM7THf3BKGDIODoI5ZQpsLRmLFC7ns0onns6pyTuxy6jddkOA3ZaCJ6qE3+m1nJ6EWGONYgBOgeaPJ7hN0DPJJqxTJa6jL40YwRTtwYbcSt9jC8a5yyGfKzK4RMCBzkaGxFHITd2DpP2zLytsSSMhY7C0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=uzCokben; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="uzCokben"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dXJd30p39z49PvR;
	Thu, 18 Dec 2025 20:11:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1766081464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGj+3UsfMgN8o21EChgpCmyS9CPJcvEg8pViP7OkHDE=;
	b=uzCokbenzNtWa5xRflirWxMKTUJtsVMttHuhGUQiJQqQkJByZQczTvn0BZb2EX2S+tqeFY
	KymdrFGsHhqztzvvniyOFqWBsIH2H+rcpgL7HxinHVRTPID3J7CW61gzfn6VdDXWYRAc3p
	mNF1iJNT+DCuwmJWhrZWndKG8CumfvuB/ja4rA5BjJc6+gh4SbqFkzw/4DvFGUxEw7wrHz
	Hflr5tHJFmQblYDEnFJCUfzjvMkERcJc1QLzrQ79iulS6yWgnMoMx33yXk8yt+vHNO0siu
	Fq8gw34jddtXXS0VK2jahWdNRpPGf4hpT/Grmm2DnecstiT82vQicD1krphV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1766081464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGj+3UsfMgN8o21EChgpCmyS9CPJcvEg8pViP7OkHDE=;
	b=aqhmsNeNdvgj8Jf4sdtqp5qTiABrnSvUix91dOPS6J4MJi1OOQmSCLQE5lQb5Tj+4pP2M1
	fQfrNtfrQXBQQoar9nBbL6GxzIGxJxak6FwmDew0fLRz0KHpMGOZbA8mibwQioYkzbT6Nz
	FEjG41KMJxPTV4Xen5ls7X1e2hUnXxmEtKRzWHhIMvYsP2SPM2HxUiLJFY59igEq4/y0rP
	5g1qAhYEfqscB183Yz8xsFeDvhgLsol1YAOx7MxoNCl3sA+UgMIv78mrSra2c2i3nz3VxQ
	17o29J/mOUgNFPrxDEQd4ytW+KoeEMOe/pIKbTUXbRcknWd84kbfeZBPb2weaw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1766081464;
	b=vX2d71DWFSTv4lRyLjK6ImjL/hXyapKGD8zrqjg3uJCH/6ZWk8SyloaCQGdOMCyH9iE99m
	TlsG1UFDBVTroOy8i5FTuvs654Lnv4Ru36bPQijZuaHP8/AuGFcDtofCLRYVC5h1btNsDK
	3T1fPEQnC5eB+ccxQbI8f8PA6xHYnY56yAp5JvatXP+87yXLCl0qFSUEqtccnGs/GUUiyl
	yAO1+lNCvUbxPJBtMiaPJF6dxr10gAqZE+zQt6tbirQgVsiffToG+olHtEXKlom2HgRz4/
	juIeHo7GgHoYx8pOAvucPIE6lFvA48gdj2ciAwYdEpZ6/Y9Wpcmn5LbvNRK+GA==
Message-ID: <a4dc4f221a6e1de559e1a24a93e7b13d3fed130e.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci: fix refcounts in LE remote features
 command
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Cihangir Akturk <cakturk@gmail.com>, linux-bluetooth@vger.kernel.org, 
 Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org, 
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Date: Thu, 18 Dec 2025 20:11:00 +0200
In-Reply-To: <CABBYNZLrL9cQSePJMT+ALdav8kV-+oD60Bnf9iZ5dZ27e3ZXCg@mail.gmail.com>
References: <20251216191255.882653-1-cakturk@gmail.com>
	 <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
	 <8e9f289c294e66881323ee7f8f785a64e2e7ae8e.camel@iki.fi>
	 <CABBYNZLrL9cQSePJMT+ALdav8kV-+oD60Bnf9iZ5dZ27e3ZXCg@mail.gmail.com>
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

to, 2025-12-18 kello 12:09 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Dec 18, 2025 at 11:33=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Hi,
> >=20
> > ke, 2025-12-17 kello 16:36 -0500, Luiz Augusto von Dentz kirjoitti:
> > > Hi Cihangir,
> > >=20
> > > On Tue, Dec 16, 2025 at 2:13=E2=80=AFPM Cihangir Akturk <cakturk@gmai=
l.com> wrote:
> > > >=20
> > > > KASAN reported a slab-use-after-free in le_read_features_complete()
> > > > running from hci_cmd_sync_work.  le_read_features_complete() can ru=
n
> > > > after hci_rx_work/hci_conn_del() has removed the link, so the destr=
oy
> > > > callback may touch a freed hci_conn and trigger a KASAN use-after-f=
ree.
> > > > Duplicate submissions also need to drop the references to avoid lea=
king
> > > > the hold and blocking teardown.
> > > >=20
> > > > Fix this by taking hci_conn_get() before queueing, passing the conn
> > > > directly as work data, and balancing hci_conn_hold()/drop() and
> > > > hci_conn_get()/put() in the completion and all error/-EEXIST paths =
so
> > > > the connection stays referenced while the work runs and is released
> > > > afterwards.
> > > >=20
> > > > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > > > Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> > > > ---
> > > >  net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++----------=
-
> > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > >=20
> > > > I am not entirely sure that removing the err =3D=3D -ECANCELED earl=
y return
> > > > is strictly correct. My assumption is that, with the changes in thi=
s
> > > > patch, there does not appear to be another cancellation path that
> > > > reliably balances hci_conn_drop() and hci_conn_put() for this comma=
nd.
> > > > Based on that assumption, keeping the early return could leave the
> > > > references taken before queuing unbalanced on cancellation, so I op=
ted
> > > > to remove it to keep the lifetime handling consistent.
> > > >=20
> > > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > > index a9f5b1a68356..5a3d288e7015 100644
> > > > --- a/net/bluetooth/hci_sync.c
> > > > +++ b/net/bluetooth/hci_sync.c
> > > > @@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hd=
ev, hci_cmd_sync_work_func_t func,
> > > >   * - Lookup if an entry already exist and only if it doesn't creat=
es a new entry
> > > >   *   and queue it.
> > > >   */
> > > > -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_wor=
k_func_t func,
> > > > +static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd=
_sync_work_func_t func,
> > > >                             void *data, hci_cmd_sync_work_destroy_t=
 destroy)
> > > >  {
> > > >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > > > -               return 0;
> > > > +               return -EEXIST;
> > > >=20
> > > >         return hci_cmd_sync_queue(hdev, func, data, destroy);
> > > >  }
> > > > +
> > > > +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_wor=
k_func_t func,
> > > > +                           void *data, hci_cmd_sync_work_destroy_t=
 destroy)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret =3D __hci_cmd_sync_queue_once(hdev, func, data, destroy=
);
> > > > +       return ret =3D=3D -EEXIST ? 0 : ret;
> > > > +}
> > > >  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
> > > >=20
> > > >  /* Run HCI command:
> > > > @@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct=
 hci_dev *hdev, void *data, int err)
> > > >=20
> > > >         bt_dev_dbg(hdev, "err %d", err);
> > > >=20
> > > > -       if (err =3D=3D -ECANCELED)
> > > > -               return;
> > > > -
> > > >         hci_conn_drop(conn);
> > > > +       hci_conn_put(conn);
> > > >  }
> > > >=20
> > > >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hd=
ev,
> > > > @@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_=
conn *conn)
> > > >          * role is possible. Otherwise just transition into the
> > > >          * connected state without requesting the remote features.
> > > >          */
> > > > -       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_=
FEATURES))
> > > > -               err =3D hci_cmd_sync_queue_once(hdev,
> > > > -                                             hci_le_read_remote_fe=
atures_sync,
> > > > -                                             hci_conn_hold(conn),
> > > > -                                             le_read_features_comp=
lete);
> > > > -       else
> > > > +       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_=
FEATURES)) {
> > > > +               hci_conn_get(conn);
> > > > +               hci_conn_hold(conn);
> > > > +               err =3D __hci_cmd_sync_queue_once(hdev,
> > > > +                                               hci_le_read_remote_=
features_sync,
> > > > +                                               conn,
> > > > +                                               le_read_features_co=
mplete);
> > > > +               if (err) {
> > > > +                       hci_conn_drop(conn);
> > > > +                       hci_conn_put(conn);
> > > > +                       if (err =3D=3D -EEXIST)
> > > > +                               err =3D 0;
> > > > +               }
> > > > +       } else
> > >=20
> > > Sort of overkill, why do we have to use 2 references? Also we do have
> > > code for dequeuing callbacks using conn as user_data so either that i=
s
> > > not working or there is something else at play here. Maybe we need to
> > > change the order so that dequeue happens before hci_conn_cleanup:
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index dc085856f5e9..b64c0e53d9cd 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
> > >         skb_queue_purge(&conn->data_q);
> > >         skb_queue_purge(&conn->tx_q.queue);
> > >=20
> > > +       /* Dequeue callbacks using connection pointer as data */
> > > +       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> > > +
> >=20
> > hci_cmd_sync_dequeue() does not (i) cancel + wait for a job that is
> > already running, (ii) prevent further jobs for this conn from being
> > queued. So it's not guaranteed to work here AFAICS.
> >=20
> > For (i): note running hci_sync job may be blocked on taking hdev->lock,
> > which is held here, so trying to cancel + wait deadlocks. Does not seem
> > straightforward to fix.
>=20
> Hmm, there is a lock though that is used when running the callbacks:
>=20
>             hci_req_sync_lock(hdev);
>             err =3D entry->func(hdev, entry->data);
>             if (entry->destroy)
>                 entry->destroy(hdev, entry->data, err);
>             hci_req_sync_unlock(hdev);
>=20
> We could attempt to acquire hci_req_sync_lock on dequeue, but it looks
> like there are code paths that already do call hci_conn_del with that
> lock so the likes of mgmt-tester deadlock, anyway if there are code
> paths already doing with hci_req_sync_lock held then it should be safe
> to already require it when doing hci_conn_del or maybe rename
> hci_conn_del to hci_conn_del_sync and then have hci_conn_del
> performing the hci_req_sync_lock before calling hci_conn_del_sync then
> work out the code paths where hci_req_sync_lock is already held to use
> hci_conn_del_sync.

Taking hci_req_sync() before hci_conn_del() seems to face some issues:

[hdev->req_workqueue] hci_disconnect_sync()
[hdev->req_workqueue]   __hci_cmd_sync_status() -- req_lock still held

[hdev->workqueue] hci_disconn_complete_evt()
[hdev->workqueue]   hci_conn_del() -- blocks on req_lock

since the command may end up waiting for hci_conn_del. The disconnect
may also be spontaneous from controller, so looks like any
__hci_cmd_sync_status() could lock up.

AFAICS, you'd need something like a dedicated hdev->workqueue work that
does the final hci_conn put under req_lock, so that there is no job
running in either workqueue during the final put. And get it also right
in the hdev teardown.

***

For how the other refcount / lock approach would look in practice, iirc
the earlier RFC had all hci_lookup callsites dealt with (aside from
6lowpan)

https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/
=20
> > For (ii): one would need to audit the places where these jobs are
> > queued, and make sure they are all done with hdev->lock held, to avoid
> > racing with the code here. Maybe doable with separate queueing function
> > that has lockdep asserts.
> >=20
> > I suggested some time ago to always hold either refcount or lock to
> > keep the hci_conn alive everywhere, also in these hci_sync callbacks:
> >=20
> > https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi=
/
> >=20
> > with similar changes as suggested in this patch. This may be the
> > simpler fix.
> >=20
> > >         /* Remove the connection from the list and cleanup its remain=
ing
> > >          * state. This is a separate function since for some cases li=
ke
> > >          * BT_CONNECT_SCAN we *only* want the cleanup part without th=
e
> > >          * rest of hci_conn_del.
> > >          */
> > >         hci_conn_cleanup(conn);
> > > -
> > > -       /* Dequeue callbacks using connection pointer as data */
> > > -       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> > >  }
> > >  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t =
src_type)
> > >=20
> > >=20
> > > >                 err =3D -EOPNOTSUPP;
> > > >=20
> > > >         return err;
> > > > --
> > > > 2.52.0
> > > >=20
> > >=20
> >=20
> > --
> > Pauli Virtanen
>=20
>=20
