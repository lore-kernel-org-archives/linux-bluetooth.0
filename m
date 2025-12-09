Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042727C162
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765307315; cv=none; b=FdCIj3Pj+CtavnKl6BQg67R2+pCiDRxMdbLY0k4tgvDKwPhmdAh5yhfKRIVknQxrmapSmo0yFJ3UI0azUNacoURIkYUrEbzj9888gPAH6TeQ/96rR44QBKTKVVerfP2aLWmFs7Jf4BDyHm8RreqaP/DFK5bQhF8kruoh4aIsDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765307315; c=relaxed/simple;
	bh=PqcpJcPkdaTCHmiWhSGtvaITLjhhNKU4Mgjs/cZBYRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA6E1AYSR00RGMiGnKtjIdtcRyVYBWKOddy8G/Vk+AxDtryti/Z91x3weI3ZXG0qycFOajSoLlU3P7WY1tb05UB0oBjfnh7dZGt+/Gitm+JpYesFOUecOgonya2hSAnsYYUL55FGsPRuXSS/dLT/Mj2rLLW4LQSGo1fOgIc6RF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Te5fxL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Te5fxL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37b495ce059so45672011fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765307311; x=1765912111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPjhg3QHtg0SLQ8RHjSY9PbsO9VcSBc5G6NBbY5nUhw=;
        b=b0Te5fxLNtcbQXAPtEi02/tjZZ2F2Sf1Y/oq3gXKkMcHC22LrgYgd5aycJRC37ZfJu
         W/UgUU6GWHq6ZR35+PPusIclu5Ucq62bh5hpJg5/jxHxz4NreCsCl5hqacFqsAt9v0+p
         OZiG3+yRYKzAWaN/U4M9VdZJpHGVaCMT1xsBMqds3gdli7pCXF628w/G14t6zyGH67oI
         3wQaVplu+3cKnLflXS2TAx8dhO+hZ1bz9xkt0EjYVzjJ8GpTjTjPJrZxpKVhYb6BN7ye
         UxqGv2Wc4qzlLVAp627rNrXOndzNiKgJRoHeA4DhEOPjGYYx8hCQ41fTylgzE3klTNsB
         azrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765307311; x=1765912111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iPjhg3QHtg0SLQ8RHjSY9PbsO9VcSBc5G6NBbY5nUhw=;
        b=gxuJfb/ptP6dc8zCOEoxqOufPpOGxKr4CK6UzUFl3iw5UhJq8ZVrxMcMiGzitAWRsh
         zh0r6peHbF/E2Rkhu/NuCavQ0o3aoq+LPqxDkiVr9CMNx4OVBK6rDuBo9u3JcKd07PCo
         hSpUHnxDnozwYdlXMQ1d7t3VYSgcIU4CYr/k8/xc732I1nkyWW4a9xHu9GECIE1MT317
         d5CN8CBlxCEcwLHe3KpMvyPVSPD9zjMKQrtkvyyoJVp7vwuaNavAV0Ji0m7yFVBSb7P7
         wHrGzozlmjd4wcH0bQQT3VWXEAO/QM42ZsYiFjeAG5wivZL6ZK+UUI5RMEpXBS85J6NE
         n8og==
X-Gm-Message-State: AOJu0YxNw8C8uSYaXdGL0sbMOC+VOHmuU+UCeObmnStehxzU1z+/mG+c
	FHs7Pny6VjP2OlAns4wAXLCCcexG//GznvIJXYdjUG5Oou6Xpwd9C2xNHOfsaRclBc0rwuAHtA9
	DsANMrO0069t773CV2WwFekAapGrWYmQ=
X-Gm-Gg: ASbGncuLkPOSnt70B7Ue9OnJ7LslJe+npJuKo5eXGiS1xRLhy1d/Gyyg6BgGmwhqiGB
	oLsjkiF3A3TC7J2TfoLTOSuV1bDhBSPfXdJ9jCf6SR/4T2mjzhrU1NEBgC6vDg5WpAWJeBCoWUX
	w+nsOthuzr2Wk1Ld7kNh0cjw389iKxK/hp8m5uia0nFOxPyE4Qr44MaWEnV23n3XV/R1vkRDewl
	NNQb61xTSmSheXbL6wnuXjSN4rwaTxRPoR/8YSuqAZhMOegqFiLLiLG/P0QAYZmBtUcBA==
X-Google-Smtp-Source: AGHT+IFcYzbJyWvttesUygFLJnFQbMJBOUodv5d3YIA2wJxJhE5L6yBgp5C7/DRO7aN7yVf7m0RnUwNYsBnNyFHmxCw=
X-Received: by 2002:a05:651c:2122:b0:37a:2e32:3200 with SMTP id
 38308e7fff4ca-37ed206e537mr37171861fa.33.1765307310008; Tue, 09 Dec 2025
 11:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <118c61c95ad4deab0e08d3a3c8b92910bc271281.1765297112.git.pav@iki.fi>
 <e5fe44b227f8fd3b249c7f83903e15d0d4e0c5aa.1765297112.git.pav@iki.fi>
In-Reply-To: <e5fe44b227f8fd3b249c7f83903e15d0d4e0c5aa.1765297112.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Dec 2025 14:08:16 -0500
X-Gm-Features: AQt7F2opVwKyA146hCmQ4Skvz1TECyVTUc9eWu8MsYBueOS8P3mJ1vMu3WgEXPs
Message-ID: <CABBYNZKf69VJqE9gw3vvd-5rjFU0MPHHrX9L+Yyq_2G0ZdAYSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] Bluetooth: SCO: make locking more systematic
 and fix missing locks
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, Cen Zhang <rollkingzzc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Dec 9, 2025 at 11:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> hci_conn::sco_data does not own a refcount to sco_conn and the field is
> updated also without hdev->lock, so it cannot be safely accessed in
> sco_connect_cfm(). UAF observed due to wrong refcounting is reported.
>
> Revise the sco_conn ownership and locking:
>
> - hci_conn::sco_data owns refcount; field protected by hdev->lock
> - sco_pi(sk)::conn owns refcount; field protected by lock_sock()
> - sco_conn::hcon and sk own no refcount; fields protected by conn->lock

Im afraid our locking itself needs an overhaul, since it seems we fix
one thing just to discover another so operation on sk shall not be
intermixed with hcon to prevent locking reacquire scenarios.

> Use lockdep + Sparse to try to enforce proper locking.  Add locks where
> they were missing.
>
> Use separate functions that detach sco_conn from hcon and sk. Don't do
> operations that take locks in sco_conn_free() so that sco_conn_put() is
> safe to use with locks.
>
> Handle the race when hcon obtains locked sk via sco_conn, which requires
> sco_conn_unlock due to lock ordering.
>
> In sco_conn_ready() fix calling sleeping functions under spinlock.
>
> Fixes: ecb9a843be4d ("Bluetooth: SCO: Fix UAF on sco_conn_free")
> Reported-by: Cen Zhang <rollkingzzc@gmail.com>
> Closes: https://lore.kernel.org/linux-bluetooth/44091d60.3570.19a40a89dd8=
.Coremail.zzzccc427@163.com/
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     These two patches are pending some further testing in practice, but
>     lockdep is now happy about how this works.
>
>  include/net/bluetooth/hci_core.h |   2 +-
>  net/bluetooth/sco.c              | 372 ++++++++++++++++++++-----------
>  2 files changed, 239 insertions(+), 135 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 4263e71a23ef..d9da4f3ecc1f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -769,7 +769,7 @@ struct hci_conn {
>
>         struct hci_dev  *hdev;
>         void            *l2cap_data;
> -       void            *sco_data;
> +       void            *__private sco_data;
>         void            *iso_data;
>
>         struct list_head link_list;
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 87ba90336e80..272a3facbd50 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -43,10 +43,10 @@ static struct bt_sock_list sco_sk_list =3D {
>
>  /* ---- SCO connections ---- */
>  struct sco_conn {
> -       struct hci_conn *hcon;
> +       struct hci_conn *__private hcon;
>
>         spinlock_t      lock;
> -       struct sock     *sk;
> +       struct sock     *__private sk;
>
>         struct delayed_work     timeout_work;
>
> @@ -70,9 +70,69 @@ struct sco_pinfo {
>         __u32           flags;
>         __u16           setting;
>         struct bt_codec codec;
> -       struct sco_conn *conn;
> +       struct sco_conn *__private conn;
>  };
>
> +static inline struct sco_conn *sco_sk_conn(struct sock *sk)
> +{
> +       lockdep_assert(lockdep_sock_is_held(sk));
> +
> +       /* sco_pi(sk) owns a reference, if non-NULL */
> +       return ACCESS_PRIVATE(sco_pi(sk), conn);

Not sure if the usage of ACCESS_PRIVATE is recommended outside the
core mm internals? At least I don't see it being used often, also we
probably need a more generic solution that can also handle the likes
of iso_data and l2cap_data as well.

> +}
> +
> +static inline struct sco_conn *sco_hcon_conn(struct hci_conn *hcon)
> +{
> +       lockdep_assert_held(&hcon->hdev->lock);
> +
> +       /* hcon owns a reference, if non-NULL */
> +       return ACCESS_PRIVATE(hcon, sco_data);
> +}
> +
> +static inline struct sock *sco_conn_sk(struct sco_conn *conn)
> +{
> +       lockdep_assert_held(&conn->lock);
> +
> +       /* conn does not own a reference, may be NULL */
> +       return ACCESS_PRIVATE(conn, sk);
> +}
> +
> +static inline struct hci_conn *sco_conn_hcon(struct sco_conn *conn)
> +{
> +       lockdep_assert_held(&conn->lock);
> +
> +       /* conn does not own reference, may be NULL.
> +        * hci_conn_hold owned when sk !=3D NULL.
> +        */
> +       return ACCESS_PRIVATE(conn, hcon);
> +}
> +
> +static struct sock *sco_conn_get_sk_locked(struct sco_conn *conn)
> +{
> +       struct sock *sk;
> +
> +       if (!conn)
> +               return NULL;
> +
> +       sco_conn_lock(conn);
> +       sk =3D sco_conn_sk(conn);
> +       if (!sk) {
> +               sco_conn_unlock(conn);
> +               return NULL;
> +       }
> +       sock_hold(sk);
> +       sco_conn_unlock(conn);
> +
> +       lock_sock(sk);
> +       if (sco_sk_conn(sk) !=3D conn) {
> +               release_sock(sk);
> +               sock_put(sk);
> +               return NULL;
> +       }
> +
> +       return sk;
> +}
> +
>  /* ---- SCO timers ---- */
>  #define SCO_CONN_TIMEOUT       (HZ * 40)
>  #define SCO_DISCONN_TIMEOUT    (HZ * 2)
> @@ -83,16 +143,14 @@ static void sco_conn_free(struct kref *ref)
>
>         BT_DBG("conn %p", conn);
>
> -       if (conn->sk)
> -               sco_pi(conn->sk)->conn =3D NULL;
> +#ifdef CONFIG_PROVE_LOCKING
> +       WARN_ON(ACCESS_PRIVATE(conn, sk));
> +       WARN_ON(ACCESS_PRIVATE(conn, hcon));
>
> -       if (conn->hcon) {
> -               conn->hcon->sco_data =3D NULL;
> -               hci_conn_drop(conn->hcon);
> -       }
> -
> -       /* Ensure no more work items will run since hci_conn has been dro=
pped */
> -       disable_delayed_work_sync(&conn->timeout_work);
> +       /* Timeout shall have been disabled when detaching hcon */
> +       disable_delayed_work(&conn->timeout_work);
> +       WARN_ON(enable_delayed_work(&conn->timeout_work));
> +#endif
>
>         kfree(conn);
>  }
> @@ -109,33 +167,56 @@ static void sco_conn_put(struct sco_conn *conn)
>
>  static struct sco_conn *sco_conn_hold(struct sco_conn *conn)
>  {
> +       if (!conn)
> +               return NULL;
> +
>         BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
>
>         kref_get(&conn->ref);
>         return conn;
>  }
>
> -static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *conn)
> +static void sco_detach_sk_conn(struct sock *sk)
>  {
> +       struct sco_conn *conn =3D sco_sk_conn(sk);
> +       struct hci_conn *hcon;
> +
>         if (!conn)
> -               return NULL;
> +               return;
>
> -       BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
> +       sco_conn_lock(conn);
> +       ACCESS_PRIVATE(conn, sk) =3D NULL;
> +       hcon =3D sco_conn_hcon(conn);
> +       if (hcon)
> +               hci_conn_drop(hcon);
> +       sco_conn_unlock(conn);
>
> -       if (!kref_get_unless_zero(&conn->ref))
> -               return NULL;
> +       /* Cancel sync not ok if sk lock held; full disable on hcon detac=
h */
> +       cancel_delayed_work(&conn->timeout_work);
>
> -       return conn;
> +       sco_conn_put(conn);
> +
> +       ACCESS_PRIVATE(sco_pi(sk), conn) =3D NULL;
>  }
>
> -static struct sock *sco_sock_hold(struct sco_conn *conn)
> +static void sco_detach_hcon_conn(struct hci_conn *hcon)
>  {
> -       if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
> -               return NULL;
> +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
>
> -       sock_hold(conn->sk);
> +       if (!conn)
> +               return;
>
> -       return conn->sk;
> +       sco_conn_lock(conn);
> +       ACCESS_PRIVATE(conn, hcon) =3D NULL;
> +       lockdep_assert(!ACCESS_PRIVATE(conn, sk) ||
> +                      !lockdep_sock_is_held(ACCESS_PRIVATE(conn, sk)));
> +       sco_conn_unlock(conn);
> +
> +       disable_delayed_work_sync(&conn->timeout_work);
> +
> +       sco_conn_put(conn);
> +
> +       ACCESS_PRIVATE(hcon, sco_data) =3D NULL;
>  }
>
>  static void sco_sock_timeout(struct work_struct *work)
> @@ -144,26 +225,12 @@ static void sco_sock_timeout(struct work_struct *wo=
rk)
>                                              timeout_work.work);
>         struct sock *sk;
>
> -       conn =3D sco_conn_hold_unless_zero(conn);
> -       if (!conn)
> -               return;
> -
> -       sco_conn_lock(conn);
> -       if (!conn->hcon) {
> -               sco_conn_unlock(conn);
> -               sco_conn_put(conn);
> -               return;
> -       }
> -       sk =3D sco_sock_hold(conn);
> -       sco_conn_unlock(conn);
> -       sco_conn_put(conn);
> -
> +       sk =3D sco_conn_get_sk_locked(conn);
>         if (!sk)
>                 return;
>
>         BT_DBG("sock %p state %d", sk, sk->sk_state);
>
> -       lock_sock(sk);
>         sk->sk_err =3D ETIMEDOUT;
>         sk->sk_state_change(sk);
>         release_sock(sk);
> @@ -172,37 +239,36 @@ static void sco_sock_timeout(struct work_struct *wo=
rk)
>
>  static void sco_sock_set_timer(struct sock *sk, long timeout)
>  {
> -       if (!sco_pi(sk)->conn)
> +       struct sco_conn *conn =3D sco_sk_conn(sk);
> +
> +       if (!conn)
>                 return;
>
>         BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout)=
;
> -       cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
> -       schedule_delayed_work(&sco_pi(sk)->conn->timeout_work, timeout);
> +       cancel_delayed_work(&conn->timeout_work);
> +       schedule_delayed_work(&conn->timeout_work, timeout);
>  }
>
>  static void sco_sock_clear_timer(struct sock *sk)
>  {
> -       if (!sco_pi(sk)->conn)
> +       struct sco_conn *conn =3D sco_sk_conn(sk);
> +
> +       if (!conn)
>                 return;
>
>         BT_DBG("sock %p state %d", sk, sk->sk_state);
> -       cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
> +       cancel_delayed_work(&conn->timeout_work);
>  }
>
>  /* ---- SCO connections ---- */
>  static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
>  {
> -       struct sco_conn *conn =3D hcon->sco_data;
> +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
>
> -       conn =3D sco_conn_hold_unless_zero(conn);
> -       if (conn) {
> -               if (!conn->hcon) {
> -                       sco_conn_lock(conn);
> -                       conn->hcon =3D hcon;
> -                       sco_conn_unlock(conn);
> -               }
> +       lockdep_assert_held(&hcon->hdev->lock);
> +
> +       if (conn)
>                 return conn;
> -       }
>
>         conn =3D kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
>         if (!conn)
> @@ -212,8 +278,8 @@ static struct sco_conn *sco_conn_add(struct hci_conn =
*hcon)
>         spin_lock_init(&conn->lock);
>         INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
>
> -       hcon->sco_data =3D conn;
> -       conn->hcon =3D hcon;
> +       ACCESS_PRIVATE(hcon, sco_data) =3D conn;
> +       ACCESS_PRIVATE(conn, hcon) =3D hcon;
>         conn->mtu =3D hcon->mtu;
>
>         if (hcon->mtu > 0)
> @@ -230,19 +296,9 @@ static struct sco_conn *sco_conn_add(struct hci_conn=
 *hcon)
>   * Must be called on the locked socket. */
>  static void sco_chan_del(struct sock *sk, int err)
>  {
> -       struct sco_conn *conn;
> +       BT_DBG("sk %p, conn %p, err %d", sk, sco_sk_conn(sk), err);
>
> -       conn =3D sco_pi(sk)->conn;
> -       sco_pi(sk)->conn =3D NULL;
> -
> -       BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
> -
> -       if (conn) {
> -               sco_conn_lock(conn);
> -               conn->sk =3D NULL;
> -               sco_conn_unlock(conn);
> -               sco_conn_put(conn);
> -       }
> +       sco_detach_sk_conn(sk);
>
>         sk->sk_state =3D BT_CLOSED;
>         sk->sk_err   =3D err;
> @@ -253,31 +309,29 @@ static void sco_chan_del(struct sock *sk, int err)
>
>  static void sco_conn_del(struct hci_conn *hcon, int err)
>  {
> -       struct sco_conn *conn =3D hcon->sco_data;
> +       struct sco_conn *conn =3D sco_hcon_conn(hcon);
>         struct sock *sk;
>
> -       conn =3D sco_conn_hold_unless_zero(conn);
>         if (!conn)
>                 return;
>
>         BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
>
> -       sco_conn_lock(conn);
> -       sk =3D sco_sock_hold(conn);
> -       sco_conn_unlock(conn);
> -       sco_conn_put(conn);
> +       sco_conn_hold(conn);
>
> -       if (!sk) {
> -               sco_conn_put(conn);
> -               return;
> +       /* Detach first so no new sk can be added any more */
> +       sco_detach_hcon_conn(hcon);
> +
> +       sk =3D sco_conn_get_sk_locked(conn);
> +       if (sk) {
> +               /* Kill socket */
> +               sco_sock_clear_timer(sk);
> +               sco_chan_del(sk, err);
> +               release_sock(sk);
> +               sock_put(sk);
>         }
>
> -       /* Kill socket */
> -       lock_sock(sk);
> -       sco_sock_clear_timer(sk);
> -       sco_chan_del(sk, err);
> -       release_sock(sk);
> -       sock_put(sk);
> +       sco_conn_put(conn);
>  }
>
>  static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
> @@ -285,8 +339,16 @@ static void __sco_chan_add(struct sco_conn *conn, st=
ruct sock *sk,
>  {
>         BT_DBG("conn %p", conn);
>
> -       sco_pi(sk)->conn =3D conn;
> -       conn->sk =3D sk;
> +       /* With parent sk is not visible elsewhere yet; lock not needed a=
nd
> +        * bt_accept_enqueue() acquires it
> +        */
> +       lockdep_assert(parent || lockdep_sock_is_held(sk));
> +       lockdep_assert_held(&conn->lock);
> +
> +       ACCESS_PRIVATE(sco_pi(sk), conn) =3D sco_conn_hold(conn);
> +       ACCESS_PRIVATE(conn, sk) =3D sk;
> +
> +       hci_conn_hold(sco_conn_hcon(conn));
>
>         if (parent)
>                 bt_accept_enqueue(parent, sk, true);
> @@ -298,8 +360,11 @@ static int sco_chan_add(struct sco_conn *conn, struc=
t sock *sk,
>         int err =3D 0;
>
>         sco_conn_lock(conn);
> -       if (conn->sk)
> +
> +       if (sco_conn_sk(conn) || ACCESS_PRIVATE(sco_pi(sk), conn))
>                 err =3D -EBUSY;
> +       else if (!sco_conn_hcon(conn))
> +               err =3D -EIO;
>         else
>                 __sco_chan_add(conn, sk, parent);
>
> @@ -354,6 +419,7 @@ static int sco_connect(struct sock *sk)
>         lock_sock(sk);
>
>         err =3D sco_chan_add(conn, sk, NULL);
> +       hci_conn_drop(hcon);
>         if (err) {
>                 release_sock(sk);
>                 goto unlock;
> @@ -381,7 +447,8 @@ static int sco_connect(struct sock *sk)
>  static int sco_send_frame(struct sock *sk, struct sk_buff *skb,
>                           const struct sockcm_cookie *sockc)
>  {
> -       struct sco_conn *conn =3D sco_pi(sk)->conn;
> +       struct sco_conn *conn =3D sco_sk_conn(sk);
> +       struct hci_conn *hcon;
>         int len =3D skb->len;
>
>         /* Check outgoing MTU */
> @@ -391,18 +458,21 @@ static int sco_send_frame(struct sock *sk, struct s=
k_buff *skb,
>         BT_DBG("sk %p len %d", sk, len);
>
>         hci_setup_tx_timestamp(skb, 1, sockc);
> -       hci_send_sco(conn->hcon, skb);
> +
> +       sco_conn_lock(conn);
> +       hcon =3D sco_conn_hcon(conn);
> +       if (hcon)
> +               hci_send_sco(hcon, skb);
> +       else
> +               len =3D -ENOTCONN;
> +       sco_conn_unlock(conn);
>
>         return len;
>  }
>
>  static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
>  {
> -       struct sock *sk;
> -
> -       sco_conn_lock(conn);
> -       sk =3D conn->sk;
> -       sco_conn_unlock(conn);
> +       struct sock *sk =3D sco_conn_sk(conn);
>
>         if (!sk)
>                 goto drop;
> @@ -466,7 +536,9 @@ static void sco_sock_destruct(struct sock *sk)
>  {
>         BT_DBG("sk %p", sk);
>
> -       sco_conn_put(sco_pi(sk)->conn);
> +       lock_sock(sk);
> +       sco_detach_sk_conn(sk);
> +       release_sock(sk);
>
>         skb_queue_purge(&sk->sk_receive_queue);
>         skb_queue_purge(&sk->sk_write_queue);
> @@ -498,12 +570,9 @@ static void sco_sock_kill(struct sock *sk)
>
>         BT_DBG("sk %p state %d", sk, sk->sk_state);
>
> -       /* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
> -       if (sco_pi(sk)->conn) {
> -               sco_conn_lock(sco_pi(sk)->conn);
> -               sco_pi(sk)->conn->sk =3D NULL;
> -               sco_conn_unlock(sco_pi(sk)->conn);
> -       }
> +       lock_sock(sk);
> +       sco_detach_sk_conn(sk);
> +       release_sock(sk);
>
>         /* Kill poor orphan */
>         bt_sock_unlink(&sco_sk_list, sk);
> @@ -884,7 +953,6 @@ static int sco_sock_recvmsg(struct socket *sock, stru=
ct msghdr *msg,
>                             size_t len, int flags)
>  {
>         struct sock *sk =3D sock->sk;
> -       struct sco_pinfo *pi =3D sco_pi(sk);
>
>         if (unlikely(flags & MSG_ERRQUEUE))
>                 return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
> @@ -894,7 +962,15 @@ static int sco_sock_recvmsg(struct socket *sock, str=
uct msghdr *msg,
>
>         if (sk->sk_state =3D=3D BT_CONNECT2 &&
>             test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> -               sco_conn_defer_accept(pi->conn->hcon, pi->setting);
> +               struct sco_conn *conn =3D sco_sk_conn(sk);
> +               struct hci_conn *hcon;
> +
> +               sco_conn_lock(conn);
> +               hcon =3D sco_conn_hcon(conn);
> +               if (hcon)
> +                       sco_conn_defer_accept(hcon, sco_pi(sk)->setting);
> +               sco_conn_unlock(conn);
> +
>                 sk->sk_state =3D BT_CONFIG;
>
>                 release_sock(sk);
> @@ -1047,6 +1123,8 @@ static int sco_sock_getsockopt_old(struct socket *s=
ock, int optname,
>                                    char __user *optval, int __user *optle=
n)
>  {
>         struct sock *sk =3D sock->sk;
> +       struct sco_conn *conn;
> +       struct hci_conn *hcon;
>         struct sco_options opts;
>         struct sco_conninfo cinfo;
>         int err =3D 0;
> @@ -1059,16 +1137,19 @@ static int sco_sock_getsockopt_old(struct socket =
*sock, int optname,
>
>         lock_sock(sk);
>
> +       conn =3D sco_sk_conn(sk);
> +
>         switch (optname) {
>         case SCO_OPTIONS:
> -               if (sk->sk_state !=3D BT_CONNECTED &&
> -                   !(sk->sk_state =3D=3D BT_CONNECT2 &&
> -                     test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) {
> +               if ((sk->sk_state !=3D BT_CONNECTED &&
> +                    !(sk->sk_state =3D=3D BT_CONNECT2 &&
> +                      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) |=
|
> +                   !conn) {
>                         err =3D -ENOTCONN;
>                         break;
>                 }
>
> -               opts.mtu =3D sco_pi(sk)->conn->mtu;
> +               opts.mtu =3D conn->mtu;
>
>                 BT_DBG("mtu %u", opts.mtu);
>
> @@ -1079,16 +1160,28 @@ static int sco_sock_getsockopt_old(struct socket =
*sock, int optname,
>                 break;
>
>         case SCO_CONNINFO:
> -               if (sk->sk_state !=3D BT_CONNECTED &&
> -                   !(sk->sk_state =3D=3D BT_CONNECT2 &&
> -                     test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) {
> +               if ((sk->sk_state !=3D BT_CONNECTED &&
> +                    !(sk->sk_state =3D=3D BT_CONNECT2 &&
> +                      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) |=
|
> +                   !conn) {
>                         err =3D -ENOTCONN;
>                         break;
>                 }
>
> +               sco_conn_lock(conn);
> +
> +               hcon =3D sco_conn_hcon(conn);
> +               if (!hcon) {
> +                       err =3D -ENOTCONN;
> +                       sco_conn_unlock(conn);
> +                       break;
> +               }
> +
>                 memset(&cinfo, 0, sizeof(cinfo));
> -               cinfo.hci_handle =3D sco_pi(sk)->conn->hcon->handle;
> -               memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class=
, 3);
> +               cinfo.hci_handle =3D hcon->handle;
> +               memcpy(cinfo.dev_class, hcon->dev_class, 3);
> +
> +               sco_conn_unlock(conn);
>
>                 len =3D min(len, sizeof(cinfo));
>                 if (copy_to_user(optval, (char *)&cinfo, len))
> @@ -1118,6 +1211,8 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>         struct hci_dev *hdev;
>         struct hci_codec_caps *caps;
>         struct bt_codec codec;
> +       struct sco_conn *conn;
> +       struct hci_conn *hcon;
>
>         BT_DBG("sk %p", sk);
>
> @@ -1129,6 +1224,8 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>
>         lock_sock(sk);
>
> +       conn =3D sco_sk_conn(sk);
> +
>         switch (optname) {
>
>         case BT_DEFER_SETUP:
> @@ -1153,12 +1250,21 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
>                 break;
>
>         case BT_PHY:
> -               if (sk->sk_state !=3D BT_CONNECTED) {
> +               if (sk->sk_state !=3D BT_CONNECTED || !conn) {
>                         err =3D -ENOTCONN;
>                         break;
>                 }
>
> -               phys =3D hci_conn_get_phy(sco_pi(sk)->conn->hcon);
> +               sco_conn_lock(conn);
> +               hcon =3D sco_conn_hcon(conn);
> +               if (hcon)
> +                       phys =3D hci_conn_get_phy(hcon);
> +               else
> +                       err =3D -ENOTCONN;
> +               sco_conn_unlock(conn);
> +
> +               if (err)
> +                       break;
>
>                 if (put_user(phys, (u32 __user *) optval))
>                         err =3D -EFAULT;
> @@ -1177,7 +1283,7 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                         break;
>                 }
>
> -               if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval)=
)
> +               if (put_user(conn->mtu, (u32 __user *)optval))
>                         err =3D -EFAULT;
>                 break;
>
> @@ -1344,29 +1450,28 @@ static int sco_sock_release(struct socket *sock)
>  static void sco_conn_ready(struct sco_conn *conn)
>  {
>         struct sock *parent;
> -       struct sock *sk =3D conn->sk;
> +       struct sock *sk;
>
>         BT_DBG("conn %p", conn);
>
> +       sk =3D sco_conn_get_sk_locked(conn);
>         if (sk) {
> -               lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sk->sk_state =3D BT_CONNECTED;
>                 sk->sk_state_change(sk);
>                 release_sock(sk);
> +               sock_put(sk);
>         } else {
> -               sco_conn_lock(conn);
> +               struct hci_conn *hcon;
>
> -               if (!conn->hcon) {
> -                       sco_conn_unlock(conn);
> +               /* hdev lock held */
> +               hcon =3D ACCESS_PRIVATE(conn, hcon);
> +               if (!hcon)
>                         return;
> -               }
>
> -               parent =3D sco_get_sock_listen(&conn->hcon->src);
> -               if (!parent) {
> -                       sco_conn_unlock(conn);
> +               parent =3D sco_get_sock_listen(&hcon->src);
> +               if (!parent)
>                         return;
> -               }
>
>                 lock_sock(parent);
>
> @@ -1374,18 +1479,18 @@ static void sco_conn_ready(struct sco_conn *conn)
>                                     BTPROTO_SCO, GFP_ATOMIC, 0);
>                 if (!sk) {
>                         release_sock(parent);
> -                       sco_conn_unlock(conn);
>                         return;
>                 }
>
>                 sco_sock_init(sk, parent);
>
> -               bacpy(&sco_pi(sk)->src, &conn->hcon->src);
> -               bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
> +               bacpy(&sco_pi(sk)->src, &hcon->src);
> +               bacpy(&sco_pi(sk)->dst, &hcon->dst);
>
> -               sco_conn_hold(conn);
> -               hci_conn_hold(conn->hcon);
> -               __sco_chan_add(conn, sk, parent);
> +               if (sco_chan_add(conn, sk, parent)) {
> +                       release_sock(parent);
> +                       return;
> +               }
>
>                 if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
>                         sk->sk_state =3D BT_CONNECT2;
> @@ -1396,8 +1501,6 @@ static void sco_conn_ready(struct sco_conn *conn)
>                 parent->sk_data_ready(parent);
>
>                 release_sock(parent);
> -
> -               sco_conn_unlock(conn);
>         }
>  }
>
> @@ -1440,10 +1543,8 @@ static void sco_connect_cfm(struct hci_conn *hcon,=
 __u8 status)
>                 struct sco_conn *conn;
>
>                 conn =3D sco_conn_add(hcon);
> -               if (conn) {
> +               if (conn)
>                         sco_conn_ready(conn);
> -                       sco_conn_put(conn);
> -               }
>         } else
>                 sco_conn_del(hcon, bt_to_errno(status));
>  }
> @@ -1472,7 +1573,7 @@ int sco_recv_scodata(struct hci_dev *hdev, u16 hand=
le, struct sk_buff *skb)
>                 return -ENOENT;
>         }
>
> -       conn =3D sco_conn_hold_unless_zero(hcon->sco_data);
> +       conn =3D sco_conn_hold(sco_hcon_conn(hcon));
>         hcon =3D NULL;
>
>         hci_dev_unlock(hdev);
> @@ -1484,11 +1585,14 @@ int sco_recv_scodata(struct hci_dev *hdev, u16 ha=
ndle, struct sk_buff *skb)
>
>         BT_DBG("conn %p len %u", conn, skb->len);
>
> +       sco_conn_lock(conn);
> +
>         if (skb->len)
>                 sco_recv_frame(conn, skb);
>         else
>                 kfree_skb(skb);
>
> +       sco_conn_unlock(conn);
>         sco_conn_put(conn);
>         return 0;
>  }
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
