Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68830649D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309421; cv=pass; b=ol0ceEM+PNIoHErLO0KHz1oEBHTMiitQuYuO7ZJfEdjOmNDymUCV0nLmBog5V0aFysB3OSEC9VlF//VOdxVkoqvc4NpNoL2p+epnASy8I6V9fZaM6xjhPnSmBBeeMELVH0HWPhiRMd1MLuPC9gZtmysNPLObYMUrsVhDEDTRgmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309421; c=relaxed/simple;
	bh=msindAjBaKlYUEeSZ6fUiN3H8oCzam1OH2xofgU99cI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVcXpszmbJ4gEz8USpPcCmsL7CznriPiXPLP3gN5pM2vgsWDi1jiWOy7eHzpKQJEfH7j9b5cUe5m+DLYE2ERyeRKDGpCLiv4WguG0iAz/TMqFfI3IZAVK9UqQfnnOrpe/gFyllnVC/FyiHIRH/x0670BwCNXKWGhkFC0CtF/w/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WrpaiwHz; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WrpaiwHz"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dQq5m6mnhz49Pxd;
	Tue, 09 Dec 2025 21:43:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1765309405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y89uMhc5NJ+ow++KV/Yb3n6MPK7I1VU7tlyg6NI0HL0=;
	b=WrpaiwHzstWUq0xHUPM6UWhxMC6yVSRSdR4XV9F4cJjhy6ezuqHVIQBSnX7Jc6HT0/Q0ue
	3RBJn2Dywi/BfuJC6BvfliItSzGjR8xlXT6eFVFd2Jy8O5Cprn/d5WaM9OYkCYVqtGXVzM
	1lb0C1U7S5ozn6nUGvFs+nO1SXCkqwEo6oi7G0nLDYQ8p46KZoiTn2BkXduTtp2utlb/ul
	WHN+4ti9UGxbs0PuyCMjnywCVxgUrF50K4Csk1mYf+ZwszvLvuXgmJmpAWAOQOR/VikJ63
	DYgBQCLOoYJu7kjNqH08Ilf9+EWOCM1+uTyietc7z+13fXYzuCP4mDvVEDytPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1765309405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y89uMhc5NJ+ow++KV/Yb3n6MPK7I1VU7tlyg6NI0HL0=;
	b=hJPoqqhCLWQUMXpulUJLssR6uYq1ynFinCcCSuXQpzpDN/y8ua6ySW1PRQ2xaZYjYwT3SZ
	GpmdTMZySiJBRDDWiJGM0cSlphbeEGiW6gHkefaZRpeC913pfQcS4q9l8NQSNt4xNKqqgQ
	PQKQCspFhtzxse1dpjy6td0u25wuk5xYJxZ0o/W1DrCi4yFViU2C/9S/thAuKOTJ4R8Gl6
	HYeSAaGVFEKTc+ECRM2rBlPFoD4rAUQ1PHvHfv5TA4oy3ga43nC2p2wCBjEAoIZKVJtUL3
	lWvS915ZVGOdyx/fHEU71ERcNZNGLJpYSJ5AAjqQZ1uJ1mqdYca3+y7Jw1jORg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1765309405;
	b=nT+uW+x7PADpFqnyMi9jMCNU6dZB48P2LEZNocXTz9z7KaRBvQpEhtbBfiMS1HyaSFJ1O9
	U+A5SGucOnXtiZEzOAj1x+Z80v1QZ6+YObA2TbR8teFPUnP4caBW3mLMQ8i2GyoHXQ1eel
	PeQA8vHIGorXuEAh48MrOktbCiWgt/hqviFCPUTyP5mnvbruowFh9bKazbXWib7vWAhqZW
	8hHVsOpxQYgQm+aaadA0DevqBmvB4bF05qSkSPFECFiOGE9oidhS+GhBlR9yVASjGJw5UQ
	95puBbjrbcdEhMnrrLeIU1/XqN195eU9few5LTpL/xTFQuTvgIpIJhb9cfYIWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <df6abe5844d028707e31489dfd18a3505e1154ec.camel@iki.fi>
Subject: Re: [RFC PATCH v2 2/2] Bluetooth: SCO: make locking more systematic
 and fix missing locks
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 09 Dec 2025 21:43:22 +0200
In-Reply-To: <CABBYNZKf69VJqE9gw3vvd-5rjFU0MPHHrX9L+Yyq_2G0ZdAYSg@mail.gmail.com>
References: 
	<118c61c95ad4deab0e08d3a3c8b92910bc271281.1765297112.git.pav@iki.fi>
	 <e5fe44b227f8fd3b249c7f83903e15d0d4e0c5aa.1765297112.git.pav@iki.fi>
	 <CABBYNZKf69VJqE9gw3vvd-5rjFU0MPHHrX9L+Yyq_2G0ZdAYSg@mail.gmail.com>
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

ti, 2025-12-09 kello 14:08 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, Dec 9, 2025 at 11:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > hci_conn::sco_data does not own a refcount to sco_conn and the field is
> > updated also without hdev->lock, so it cannot be safely accessed in
> > sco_connect_cfm(). UAF observed due to wrong refcounting is reported.
> >=20
> > Revise the sco_conn ownership and locking:
> >=20
> > - hci_conn::sco_data owns refcount; field protected by hdev->lock
> > - sco_pi(sk)::conn owns refcount; field protected by lock_sock()
> > - sco_conn::hcon and sk own no refcount; fields protected by conn->lock
>=20
> Im afraid our locking itself needs an overhaul, since it seems we fix
> one thing just to discover another so operation on sk shall not be
> intermixed with hcon to prevent locking reacquire scenarios.

I agree, same problems are on ISO / L2CAP side.

I think if the locking scheme is kept simple and correctness is forced
with lockdep and any other tools available, it's possible to get it
right. Lockdep requires test coverage of the different code paths,
though.

As far as I see, this patch should be more solid than before as the
rules are not so complex, and lockdep checks the locking rules are
followed (doesn't check refcounting). I was hoping this could be the
last patch needed...

I guess another option is to try to simplify it. Maybe sco_conn can be
removed, sk <-> hcon is 1-to-1 for SCO. Eg. set SOCK_RCU_FREE, and
refer to sco_pi(sk) <-> hcon via __rcu pointers. Using this here
probably would require using sock_hold() and hci_conn_get() in many
places so this is not necessarily much simpler in the end.

With locks, I don't see how to make it simpler right now.

> > Use lockdep + Sparse to try to enforce proper locking.  Add locks where
> > they were missing.
> >=20
> > Use separate functions that detach sco_conn from hcon and sk. Don't do
> > operations that take locks in sco_conn_free() so that sco_conn_put() is
> > safe to use with locks.
> >=20
> > Handle the race when hcon obtains locked sk via sco_conn, which require=
s
> > sco_conn_unlock due to lock ordering.
> >=20
> > In sco_conn_ready() fix calling sleeping functions under spinlock.
> >=20
> > Fixes: ecb9a843be4d ("Bluetooth: SCO: Fix UAF on sco_conn_free")
> > Reported-by: Cen Zhang <rollkingzzc@gmail.com>
> > Closes: https://lore.kernel.org/linux-bluetooth/44091d60.3570.19a40a89d=
d8.Coremail.zzzccc427@163.com/
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     These two patches are pending some further testing in practice, but
> >     lockdep is now happy about how this works.
> >=20
> >  include/net/bluetooth/hci_core.h |   2 +-
> >  net/bluetooth/sco.c              | 372 ++++++++++++++++++++-----------
> >  2 files changed, 239 insertions(+), 135 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 4263e71a23ef..d9da4f3ecc1f 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -769,7 +769,7 @@ struct hci_conn {
> >=20
> >         struct hci_dev  *hdev;
> >         void            *l2cap_data;
> > -       void            *sco_data;
> > +       void            *__private sco_data;
> >         void            *iso_data;
> >=20
> >         struct list_head link_list;
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 87ba90336e80..272a3facbd50 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -43,10 +43,10 @@ static struct bt_sock_list sco_sk_list =3D {
> >=20
> >  /* ---- SCO connections ---- */
> >  struct sco_conn {
> > -       struct hci_conn *hcon;
> > +       struct hci_conn *__private hcon;
> >=20
> >         spinlock_t      lock;
> > -       struct sock     *sk;
> > +       struct sock     *__private sk;
> >=20
> >         struct delayed_work     timeout_work;
> >=20
> > @@ -70,9 +70,69 @@ struct sco_pinfo {
> >         __u32           flags;
> >         __u16           setting;
> >         struct bt_codec codec;
> > -       struct sco_conn *conn;
> > +       struct sco_conn *__private conn;
> >  };
> >=20
> > +static inline struct sco_conn *sco_sk_conn(struct sock *sk)
> > +{
> > +       lockdep_assert(lockdep_sock_is_held(sk));
> > +
> > +       /* sco_pi(sk) owns a reference, if non-NULL */
> > +       return ACCESS_PRIVATE(sco_pi(sk), conn);
>=20
> Not sure if the usage of ACCESS_PRIVATE is recommended outside the
> core mm internals? At least I don't see it being used often, also we
> probably need a more generic solution that can also handle the likes
> of iso_data and l2cap_data as well.

Good question, I don't know if __private is recommended or seen as
overkill. The same Sparse noderef feature is widely used for the __rcu
pointers though.

If we'd use ACCESS_PRIVATE(), it would be used in the same way for
sco_data, iso_data, l2cap_data.

>=20
> > +}
> > +
> > +static inline struct sco_conn *sco_hcon_conn(struct hci_conn *hcon)
> > +{
> > +       lockdep_assert_held(&hcon->hdev->lock);
> > +
> > +       /* hcon owns a reference, if non-NULL */
> > +       return ACCESS_PRIVATE(hcon, sco_data);
> > +}
> > +
> > +static inline struct sock *sco_conn_sk(struct sco_conn *conn)
> > +{
> > +       lockdep_assert_held(&conn->lock);
> > +
> > +       /* conn does not own a reference, may be NULL */
> > +       return ACCESS_PRIVATE(conn, sk);
> > +}
> > +
> > +static inline struct hci_conn *sco_conn_hcon(struct sco_conn *conn)
> > +{
> > +       lockdep_assert_held(&conn->lock);
> > +
> > +       /* conn does not own reference, may be NULL.
> > +        * hci_conn_hold owned when sk !=3D NULL.
> > +        */
> > +       return ACCESS_PRIVATE(conn, hcon);
> > +}
> > +
> > +static struct sock *sco_conn_get_sk_locked(struct sco_conn *conn)
> > +{
> > +       struct sock *sk;
> > +
> > +       if (!conn)
> > +               return NULL;
> > +
> > +       sco_conn_lock(conn);
> > +       sk =3D sco_conn_sk(conn);
> > +       if (!sk) {
> > +               sco_conn_unlock(conn);
> > +               return NULL;
> > +       }
> > +       sock_hold(sk);
> > +       sco_conn_unlock(conn);
> > +
> > +       lock_sock(sk);
> > +       if (sco_sk_conn(sk) !=3D conn) {
> > +               release_sock(sk);
> > +               sock_put(sk);
> > +               return NULL;
> > +       }
> > +
> > +       return sk;
> > +}
> > +
> >  /* ---- SCO timers ---- */
> >  #define SCO_CONN_TIMEOUT       (HZ * 40)
> >  #define SCO_DISCONN_TIMEOUT    (HZ * 2)
> > @@ -83,16 +143,14 @@ static void sco_conn_free(struct kref *ref)
> >=20
> >         BT_DBG("conn %p", conn);
> >=20
> > -       if (conn->sk)
> > -               sco_pi(conn->sk)->conn =3D NULL;
> > +#ifdef CONFIG_PROVE_LOCKING
> > +       WARN_ON(ACCESS_PRIVATE(conn, sk));
> > +       WARN_ON(ACCESS_PRIVATE(conn, hcon));
> >=20
> > -       if (conn->hcon) {
> > -               conn->hcon->sco_data =3D NULL;
> > -               hci_conn_drop(conn->hcon);
> > -       }
> > -
> > -       /* Ensure no more work items will run since hci_conn has been d=
ropped */
> > -       disable_delayed_work_sync(&conn->timeout_work);
> > +       /* Timeout shall have been disabled when detaching hcon */
> > +       disable_delayed_work(&conn->timeout_work);
> > +       WARN_ON(enable_delayed_work(&conn->timeout_work));
> > +#endif
> >=20
> >         kfree(conn);
> >  }
> > @@ -109,33 +167,56 @@ static void sco_conn_put(struct sco_conn *conn)
> >=20
> >  static struct sco_conn *sco_conn_hold(struct sco_conn *conn)
> >  {
> > +       if (!conn)
> > +               return NULL;
> > +
> >         BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
> >=20
> >         kref_get(&conn->ref);
> >         return conn;
> >  }
> >=20
> > -static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *con=
n)
> > +static void sco_detach_sk_conn(struct sock *sk)
> >  {
> > +       struct sco_conn *conn =3D sco_sk_conn(sk);
> > +       struct hci_conn *hcon;
> > +
> >         if (!conn)
> > -               return NULL;
> > +               return;
> >=20
> > -       BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
> > +       sco_conn_lock(conn);
> > +       ACCESS_PRIVATE(conn, sk) =3D NULL;
> > +       hcon =3D sco_conn_hcon(conn);
> > +       if (hcon)
> > +               hci_conn_drop(hcon);
> > +       sco_conn_unlock(conn);
> >=20
> > -       if (!kref_get_unless_zero(&conn->ref))
> > -               return NULL;
> > +       /* Cancel sync not ok if sk lock held; full disable on hcon det=
ach */
> > +       cancel_delayed_work(&conn->timeout_work);
> >=20
> > -       return conn;
> > +       sco_conn_put(conn);
> > +
> > +       ACCESS_PRIVATE(sco_pi(sk), conn) =3D NULL;
> >  }
> >=20
> > -static struct sock *sco_sock_hold(struct sco_conn *conn)
> > +static void sco_detach_hcon_conn(struct hci_conn *hcon)
> >  {
> > -       if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
> > -               return NULL;
> > +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
> >=20
> > -       sock_hold(conn->sk);
> > +       if (!conn)
> > +               return;
> >=20
> > -       return conn->sk;
> > +       sco_conn_lock(conn);
> > +       ACCESS_PRIVATE(conn, hcon) =3D NULL;
> > +       lockdep_assert(!ACCESS_PRIVATE(conn, sk) ||
> > +                      !lockdep_sock_is_held(ACCESS_PRIVATE(conn, sk)))=
;
> > +       sco_conn_unlock(conn);
> > +
> > +       disable_delayed_work_sync(&conn->timeout_work);
> > +
> > +       sco_conn_put(conn);
> > +
> > +       ACCESS_PRIVATE(hcon, sco_data) =3D NULL;
> >  }
> >=20
> >  static void sco_sock_timeout(struct work_struct *work)
> > @@ -144,26 +225,12 @@ static void sco_sock_timeout(struct work_struct *=
work)
> >                                              timeout_work.work);
> >         struct sock *sk;
> >=20
> > -       conn =3D sco_conn_hold_unless_zero(conn);
> > -       if (!conn)
> > -               return;
> > -
> > -       sco_conn_lock(conn);
> > -       if (!conn->hcon) {
> > -               sco_conn_unlock(conn);
> > -               sco_conn_put(conn);
> > -               return;
> > -       }
> > -       sk =3D sco_sock_hold(conn);
> > -       sco_conn_unlock(conn);
> > -       sco_conn_put(conn);
> > -
> > +       sk =3D sco_conn_get_sk_locked(conn);
> >         if (!sk)
> >                 return;
> >=20
> >         BT_DBG("sock %p state %d", sk, sk->sk_state);
> >=20
> > -       lock_sock(sk);
> >         sk->sk_err =3D ETIMEDOUT;
> >         sk->sk_state_change(sk);
> >         release_sock(sk);
> > @@ -172,37 +239,36 @@ static void sco_sock_timeout(struct work_struct *=
work)
> >=20
> >  static void sco_sock_set_timer(struct sock *sk, long timeout)
> >  {
> > -       if (!sco_pi(sk)->conn)
> > +       struct sco_conn *conn =3D sco_sk_conn(sk);
> > +
> > +       if (!conn)
> >                 return;
> >=20
> >         BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeou=
t);
> > -       cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
> > -       schedule_delayed_work(&sco_pi(sk)->conn->timeout_work, timeout)=
;
> > +       cancel_delayed_work(&conn->timeout_work);
> > +       schedule_delayed_work(&conn->timeout_work, timeout);
> >  }
> >=20
> >  static void sco_sock_clear_timer(struct sock *sk)
> >  {
> > -       if (!sco_pi(sk)->conn)
> > +       struct sco_conn *conn =3D sco_sk_conn(sk);
> > +
> > +       if (!conn)
> >                 return;
> >=20
> >         BT_DBG("sock %p state %d", sk, sk->sk_state);
> > -       cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
> > +       cancel_delayed_work(&conn->timeout_work);
> >  }
> >=20
> >  /* ---- SCO connections ---- */
> >  static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
> >  {
> > -       struct sco_conn *conn =3D hcon->sco_data;
> > +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
> >=20
> > -       conn =3D sco_conn_hold_unless_zero(conn);
> > -       if (conn) {
> > -               if (!conn->hcon) {
> > -                       sco_conn_lock(conn);
> > -                       conn->hcon =3D hcon;
> > -                       sco_conn_unlock(conn);
> > -               }
> > +       lockdep_assert_held(&hcon->hdev->lock);
> > +
> > +       if (conn)
> >                 return conn;
> > -       }
> >=20
> >         conn =3D kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
> >         if (!conn)
> > @@ -212,8 +278,8 @@ static struct sco_conn *sco_conn_add(struct hci_con=
n *hcon)
> >         spin_lock_init(&conn->lock);
> >         INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
> >=20
> > -       hcon->sco_data =3D conn;
> > -       conn->hcon =3D hcon;
> > +       ACCESS_PRIVATE(hcon, sco_data) =3D conn;
> > +       ACCESS_PRIVATE(conn, hcon) =3D hcon;
> >         conn->mtu =3D hcon->mtu;
> >=20
> >         if (hcon->mtu > 0)
> > @@ -230,19 +296,9 @@ static struct sco_conn *sco_conn_add(struct hci_co=
nn *hcon)
> >   * Must be called on the locked socket. */
> >  static void sco_chan_del(struct sock *sk, int err)
> >  {
> > -       struct sco_conn *conn;
> > +       BT_DBG("sk %p, conn %p, err %d", sk, sco_sk_conn(sk), err);
> >=20
> > -       conn =3D sco_pi(sk)->conn;
> > -       sco_pi(sk)->conn =3D NULL;
> > -
> > -       BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
> > -
> > -       if (conn) {
> > -               sco_conn_lock(conn);
> > -               conn->sk =3D NULL;
> > -               sco_conn_unlock(conn);
> > -               sco_conn_put(conn);
> > -       }
> > +       sco_detach_sk_conn(sk);
> >=20
> >         sk->sk_state =3D BT_CLOSED;
> >         sk->sk_err   =3D err;
> > @@ -253,31 +309,29 @@ static void sco_chan_del(struct sock *sk, int err=
)
> >=20
> >  static void sco_conn_del(struct hci_conn *hcon, int err)
> >  {
> > -       struct sco_conn *conn =3D hcon->sco_data;
> > +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
> >         struct sock *sk;
> >=20
> > -       conn =3D sco_conn_hold_unless_zero(conn);
> >         if (!conn)
> >                 return;
> >=20
> >         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
> >=20
> > -       sco_conn_lock(conn);
> > -       sk =3D sco_sock_hold(conn);
> > -       sco_conn_unlock(conn);
> > -       sco_conn_put(conn);
> > +       sco_conn_hold(conn);
> >=20
> > -       if (!sk) {
> > -               sco_conn_put(conn);
> > -               return;
> > +       /* Detach first so no new sk can be added any more */
> > +       sco_detach_hcon_conn(hcon);
> > +
> > +       sk =3D sco_conn_get_sk_locked(conn);
> > +       if (sk) {
> > +               /* Kill socket */
> > +               sco_sock_clear_timer(sk);
> > +               sco_chan_del(sk, err);
> > +               release_sock(sk);
> > +               sock_put(sk);
> >         }
> >=20
> > -       /* Kill socket */
> > -       lock_sock(sk);
> > -       sco_sock_clear_timer(sk);
> > -       sco_chan_del(sk, err);
> > -       release_sock(sk);
> > -       sock_put(sk);
> > +       sco_conn_put(conn);
> >  }
> >=20
> >  static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
> > @@ -285,8 +339,16 @@ static void __sco_chan_add(struct sco_conn *conn, =
struct sock *sk,
> >  {
> >         BT_DBG("conn %p", conn);
> >=20
> > -       sco_pi(sk)->conn =3D conn;
> > -       conn->sk =3D sk;
> > +       /* With parent sk is not visible elsewhere yet; lock not needed=
 and
> > +        * bt_accept_enqueue() acquires it
> > +        */
> > +       lockdep_assert(parent || lockdep_sock_is_held(sk));
> > +       lockdep_assert_held(&conn->lock);
> > +
> > +       ACCESS_PRIVATE(sco_pi(sk), conn) =3D sco_conn_hold(conn);
> > +       ACCESS_PRIVATE(conn, sk) =3D sk;
> > +
> > +       hci_conn_hold(sco_conn_hcon(conn));
> >=20
> >         if (parent)
> >                 bt_accept_enqueue(parent, sk, true);
> > @@ -298,8 +360,11 @@ static int sco_chan_add(struct sco_conn *conn, str=
uct sock *sk,
> >         int err =3D 0;
> >=20
> >         sco_conn_lock(conn);
> > -       if (conn->sk)
> > +
> > +       if (sco_conn_sk(conn) || ACCESS_PRIVATE(sco_pi(sk), conn))
> >                 err =3D -EBUSY;
> > +       else if (!sco_conn_hcon(conn))
> > +               err =3D -EIO;
> >         else
> >                 __sco_chan_add(conn, sk, parent);
> >=20
> > @@ -354,6 +419,7 @@ static int sco_connect(struct sock *sk)
> >         lock_sock(sk);
> >=20
> >         err =3D sco_chan_add(conn, sk, NULL);
> > +       hci_conn_drop(hcon);
> >         if (err) {
> >                 release_sock(sk);
> >                 goto unlock;
> > @@ -381,7 +447,8 @@ static int sco_connect(struct sock *sk)
> >  static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
> >                           const struct sockcm_cookie *sockc)
> >  {
> > -       struct sco_conn *conn =3D sco_pi(sk)->conn;
> > +       struct sco_conn *conn =3D sco_sk_conn(sk);
> > +       struct hci_conn *hcon;
> >         int len =3D skb->len;
> >=20
> >         /* Check outgoing MTU */
> > @@ -391,18 +458,21 @@ static int sco_send_frame(struct sock *sk, struct=
 sk_buff *skb,
> >         BT_DBG("sk %p len %d", sk, len);
> >=20
> >         hci_setup_tx_timestamp(skb, 1, sockc);
> > -       hci_send_sco(conn->hcon, skb);
> > +
> > +       sco_conn_lock(conn);
> > +       hcon =3D sco_conn_hcon(conn);
> > +       if (hcon)
> > +               hci_send_sco(hcon, skb);
> > +       else
> > +               len =3D -ENOTCONN;
> > +       sco_conn_unlock(conn);
> >=20
> >         return len;
> >  }
> >=20
> >  static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
> >  {
> > -       struct sock *sk;
> > -
> > -       sco_conn_lock(conn);
> > -       sk =3D conn->sk;
> > -       sco_conn_unlock(conn);
> > +       struct sock *sk =3D sco_conn_sk(conn);
> >=20
> >         if (!sk)
> >                 goto drop;
> > @@ -466,7 +536,9 @@ static void sco_sock_destruct(struct sock *sk)
> >  {
> >         BT_DBG("sk %p", sk);
> >=20
> > -       sco_conn_put(sco_pi(sk)->conn);
> > +       lock_sock(sk);
> > +       sco_detach_sk_conn(sk);
> > +       release_sock(sk);
> >=20
> >         skb_queue_purge(&sk->sk_receive_queue);
> >         skb_queue_purge(&sk->sk_write_queue);
> > @@ -498,12 +570,9 @@ static void sco_sock_kill(struct sock *sk)
> >=20
> >         BT_DBG("sk %p state %d", sk, sk->sk_state);
> >=20
> > -       /* Sock is dead, so set conn->sk to NULL to avoid possible UAF =
*/
> > -       if (sco_pi(sk)->conn) {
> > -               sco_conn_lock(sco_pi(sk)->conn);
> > -               sco_pi(sk)->conn->sk =3D NULL;
> > -               sco_conn_unlock(sco_pi(sk)->conn);
> > -       }
> > +       lock_sock(sk);
> > +       sco_detach_sk_conn(sk);
> > +       release_sock(sk);
> >=20
> >         /* Kill poor orphan */
> >         bt_sock_unlink(&sco_sk_list, sk);
> > @@ -884,7 +953,6 @@ static int sco_sock_recvmsg(struct socket *sock, st=
ruct msghdr *msg,
> >                             size_t len, int flags)
> >  {
> >         struct sock *sk =3D sock->sk;
> > -       struct sco_pinfo *pi =3D sco_pi(sk);
> >=20
> >         if (unlikely(flags & MSG_ERRQUEUE))
> >                 return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
> > @@ -894,7 +962,15 @@ static int sco_sock_recvmsg(struct socket *sock, s=
truct msghdr *msg,
> >=20
> >         if (sk->sk_state =3D=3D BT_CONNECT2 &&
> >             test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> > -               sco_conn_defer_accept(pi->conn->hcon, pi->setting);
> > +               struct sco_conn *conn =3D sco_sk_conn(sk);
> > +               struct hci_conn *hcon;
> > +
> > +               sco_conn_lock(conn);
> > +               hcon =3D sco_conn_hcon(conn);
> > +               if (hcon)
> > +                       sco_conn_defer_accept(hcon, sco_pi(sk)->setting=
);
> > +               sco_conn_unlock(conn);
> > +
> >                 sk->sk_state =3D BT_CONFIG;
> >=20
> >                 release_sock(sk);
> > @@ -1047,6 +1123,8 @@ static int sco_sock_getsockopt_old(struct socket =
*sock, int optname,
> >                                    char __user *optval, int __user *opt=
len)
> >  {
> >         struct sock *sk =3D sock->sk;
> > +       struct sco_conn *conn;
> > +       struct hci_conn *hcon;
> >         struct sco_options opts;
> >         struct sco_conninfo cinfo;
> >         int err =3D 0;
> > @@ -1059,16 +1137,19 @@ static int sco_sock_getsockopt_old(struct socke=
t *sock, int optname,
> >=20
> >         lock_sock(sk);
> >=20
> > +       conn =3D sco_sk_conn(sk);
> > +
> >         switch (optname) {
> >         case SCO_OPTIONS:
> > -               if (sk->sk_state !=3D BT_CONNECTED &&
> > -                   !(sk->sk_state =3D=3D BT_CONNECT2 &&
> > -                     test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) =
{
> > +               if ((sk->sk_state !=3D BT_CONNECTED &&
> > +                    !(sk->sk_state =3D=3D BT_CONNECT2 &&
> > +                      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)))=
 ||
> > +                   !conn) {
> >                         err =3D -ENOTCONN;
> >                         break;
> >                 }
> >=20
> > -               opts.mtu =3D sco_pi(sk)->conn->mtu;
> > +               opts.mtu =3D conn->mtu;
> >=20
> >                 BT_DBG("mtu %u", opts.mtu);
> >=20
> > @@ -1079,16 +1160,28 @@ static int sco_sock_getsockopt_old(struct socke=
t *sock, int optname,
> >                 break;
> >=20
> >         case SCO_CONNINFO:
> > -               if (sk->sk_state !=3D BT_CONNECTED &&
> > -                   !(sk->sk_state =3D=3D BT_CONNECT2 &&
> > -                     test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) =
{
> > +               if ((sk->sk_state !=3D BT_CONNECTED &&
> > +                    !(sk->sk_state =3D=3D BT_CONNECT2 &&
> > +                      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)))=
 ||
> > +                   !conn) {
> >                         err =3D -ENOTCONN;
> >                         break;
> >                 }
> >=20
> > +               sco_conn_lock(conn);
> > +
> > +               hcon =3D sco_conn_hcon(conn);
> > +               if (!hcon) {
> > +                       err =3D -ENOTCONN;
> > +                       sco_conn_unlock(conn);
> > +                       break;
> > +               }
> > +
> >                 memset(&cinfo, 0, sizeof(cinfo));
> > -               cinfo.hci_handle =3D sco_pi(sk)->conn->hcon->handle;
> > -               memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_cla=
ss, 3);
> > +               cinfo.hci_handle =3D hcon->handle;
> > +               memcpy(cinfo.dev_class, hcon->dev_class, 3);
> > +
> > +               sco_conn_unlock(conn);
> >=20
> >                 len =3D min(len, sizeof(cinfo));
> >                 if (copy_to_user(optval, (char *)&cinfo, len))
> > @@ -1118,6 +1211,8 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >         struct hci_dev *hdev;
> >         struct hci_codec_caps *caps;
> >         struct bt_codec codec;
> > +       struct sco_conn *conn;
> > +       struct hci_conn *hcon;
> >=20
> >         BT_DBG("sk %p", sk);
> >=20
> > @@ -1129,6 +1224,8 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >=20
> >         lock_sock(sk);
> >=20
> > +       conn =3D sco_sk_conn(sk);
> > +
> >         switch (optname) {
> >=20
> >         case BT_DEFER_SETUP:
> > @@ -1153,12 +1250,21 @@ static int sco_sock_getsockopt(struct socket *s=
ock, int level, int optname,
> >                 break;
> >=20
> >         case BT_PHY:
> > -               if (sk->sk_state !=3D BT_CONNECTED) {
> > +               if (sk->sk_state !=3D BT_CONNECTED || !conn) {
> >                         err =3D -ENOTCONN;
> >                         break;
> >                 }
> >=20
> > -               phys =3D hci_conn_get_phy(sco_pi(sk)->conn->hcon);
> > +               sco_conn_lock(conn);
> > +               hcon =3D sco_conn_hcon(conn);
> > +               if (hcon)
> > +                       phys =3D hci_conn_get_phy(hcon);
> > +               else
> > +                       err =3D -ENOTCONN;
> > +               sco_conn_unlock(conn);
> > +
> > +               if (err)
> > +                       break;
> >=20
> >                 if (put_user(phys, (u32 __user *) optval))
> >                         err =3D -EFAULT;
> > @@ -1177,7 +1283,7 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >                         break;
> >                 }
> >=20
> > -               if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optva=
l))
> > +               if (put_user(conn->mtu, (u32 __user *)optval))
> >                         err =3D -EFAULT;
> >                 break;
> >=20
> > @@ -1344,29 +1450,28 @@ static int sco_sock_release(struct socket *sock=
)
> >  static void sco_conn_ready(struct sco_conn *conn)
> >  {
> >         struct sock *parent;
> > -       struct sock *sk =3D conn->sk;
> > +       struct sock *sk;
> >=20
> >         BT_DBG("conn %p", conn);
> >=20
> > +       sk =3D sco_conn_get_sk_locked(conn);
> >         if (sk) {
> > -               lock_sock(sk);
> >                 sco_sock_clear_timer(sk);
> >                 sk->sk_state =3D BT_CONNECTED;
> >                 sk->sk_state_change(sk);
> >                 release_sock(sk);
> > +               sock_put(sk);
> >         } else {
> > -               sco_conn_lock(conn);
> > +               struct hci_conn *hcon;
> >=20
> > -               if (!conn->hcon) {
> > -                       sco_conn_unlock(conn);
> > +               /* hdev lock held */
> > +               hcon =3D ACCESS_PRIVATE(conn, hcon);
> > +               if (!hcon)
> >                         return;
> > -               }
> >=20
> > -               parent =3D sco_get_sock_listen(&conn->hcon->src);
> > -               if (!parent) {
> > -                       sco_conn_unlock(conn);
> > +               parent =3D sco_get_sock_listen(&hcon->src);
> > +               if (!parent)
> >                         return;
> > -               }
> >=20
> >                 lock_sock(parent);
> >=20
> > @@ -1374,18 +1479,18 @@ static void sco_conn_ready(struct sco_conn *con=
n)
> >                                     BTPROTO_SCO, GFP_ATOMIC, 0);
> >                 if (!sk) {
> >                         release_sock(parent);
> > -                       sco_conn_unlock(conn);
> >                         return;
> >                 }
> >=20
> >                 sco_sock_init(sk, parent);
> >=20
> > -               bacpy(&sco_pi(sk)->src, &conn->hcon->src);
> > -               bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
> > +               bacpy(&sco_pi(sk)->src, &hcon->src);
> > +               bacpy(&sco_pi(sk)->dst, &hcon->dst);
> >=20
> > -               sco_conn_hold(conn);
> > -               hci_conn_hold(conn->hcon);
> > -               __sco_chan_add(conn, sk, parent);
> > +               if (sco_chan_add(conn, sk, parent)) {
> > +                       release_sock(parent);
> > +                       return;
> > +               }
> >=20
> >                 if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
> >                         sk->sk_state =3D BT_CONNECT2;
> > @@ -1396,8 +1501,6 @@ static void sco_conn_ready(struct sco_conn *conn)
> >                 parent->sk_data_ready(parent);
> >=20
> >                 release_sock(parent);
> > -
> > -               sco_conn_unlock(conn);
> >         }
> >  }
> >=20
> > @@ -1440,10 +1543,8 @@ static void sco_connect_cfm(struct hci_conn *hco=
n, __u8 status)
> >                 struct sco_conn *conn;
> >=20
> >                 conn =3D sco_conn_add(hcon);
> > -               if (conn) {
> > +               if (conn)
> >                         sco_conn_ready(conn);
> > -                       sco_conn_put(conn);
> > -               }
> >         } else
> >                 sco_conn_del(hcon, bt_to_errno(status));
> >  }
> > @@ -1472,7 +1573,7 @@ int sco_recv_scodata(struct hci_dev *hdev, u16 ha=
ndle, struct sk_buff *skb)
> >                 return -ENOENT;
> >         }
> >=20
> > -       conn =3D sco_conn_hold_unless_zero(hcon->sco_data);
> > +       conn =3D sco_conn_hold(sco_hcon_conn(hcon));
> >         hcon =3D NULL;
> >=20
> >         hci_dev_unlock(hdev);
> > @@ -1484,11 +1585,14 @@ int sco_recv_scodata(struct hci_dev *hdev, u16 =
handle, struct sk_buff *skb)
> >=20
> >         BT_DBG("conn %p len %u", conn, skb->len);
> >=20
> > +       sco_conn_lock(conn);
> > +
> >         if (skb->len)
> >                 sco_recv_frame(conn, skb);
> >         else
> >                 kfree_skb(skb);
> >=20
> > +       sco_conn_unlock(conn);
> >         sco_conn_put(conn);
> >         return 0;
> >  }
> > --
> > 2.51.1
> >=20
> >=20
>=20
