Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E11A8F76
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338777; cv=none; b=ehnJZG4hGfH0N5eNm1Hv2RXHTxtqdbEG2w5f3Qq8F6U7SlA9o/NB1D5Ze+su0QH0njJh8h/xOfLzIoAVhwpXfqCeXk5UDbyIwyllksS5JNBuvBBJ4uTUOTr+QRAXrsOhCxJ9/zu7WutCQ+D+wGbR+vP/PLO6zApKgoinjyyO8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338777; c=relaxed/simple;
	bh=6m2WvGSF404pqwdIQrbWv43Z+OxG5jk4HSx0LQdNW6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBseXZS37On0Xg2P+hVgU3iURgUqgI9bLdct5g1HbSHWpV0jvzGLV3Qpjk1D0yQwA7k2fCc66tYrAN5QFI3nRdEr9NpRnFmC6Va8Qak4jUOml6dbeIun7y7NNoEA8vlUeq/dQq3oZCplyCU6IWq1v5aQ1YtEKEhI9rSQ8YzC0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu8qfVkM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu8qfVkM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso292091fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733338773; x=1733943573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1FrUelpn1ocmE/UqAH6ENJHKwy4ACUKufQnH76h3lQ=;
        b=Cu8qfVkMDNGeQD+25vu+on9j7DUqpFCtvt3J+22KDEqJyZokzbgHlDkTi6bLlbNQjk
         Zh/qnLHtsdfmtaguhT///OAiqUkQSG63lekUbYguWAel8BR+bSG4UqutK/2TA++hwhrh
         Q17Bt6O/m2yh9bAJ8/tG81H1YHR11KwbQettNJLbc68aoxvA+RuiO8JIc9ULZvF16BJE
         tTwjfheY75O6Oqcf2ALiXuFfgOesZWF8UnD2aTvySchYYHnguCWsOJ5RufRCGPik+2mN
         FQDKUFeu7b1JPK78sMe809CI68KF0YTE0M+s28S0DJaKdY3Z2q+v+l3CPAe+1WRpMGVG
         qrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338773; x=1733943573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1FrUelpn1ocmE/UqAH6ENJHKwy4ACUKufQnH76h3lQ=;
        b=oNvtUcXK2pZNTdjdyFjhwFGX868jXCJDRZU7x9zqegizhBeJp63yYljcnSjUfzLyRp
         0dj65+ByTG5yC5a2oXAFB306G6oTCNoyThsrR/vPFmvFGQ6Ia6xFmLXkXd7+R56TNr3V
         7zCF5aS0Dl3XJIYnnWy5qbQLJTxR7t8O5k5Xgl79smN0UgZGxg86U1FkG8pf/5tpLucu
         06r2XH9KrVBgr3GuLcFryDfbEP9ncBFvQJNyziZ84uJwR0Wx/OXXv2k++kwHGtZkE3bV
         B+nlhzlmrxCmSn+VSgHa8fNgYkgreoiqEbhq8O70Q1/1HsjmNwo60try0jFRqkrWfv+N
         6m2w==
X-Gm-Message-State: AOJu0YxEqUMrWNmt19z2yDcDqzAirLUk328rtlO3WO1QBgUm2KusF4wy
	xua76mgy17z6OOzQKGC2d4CiE4pZaq7Q51KZsl5f+k+n+tCK+K1OOEgoDqV5/LXaNqY61jZcoi5
	uGRLRWhW4Ay228R3HyjK86HdE8RtJt8P2
X-Gm-Gg: ASbGncsHUOzF2/xUUT3Urh6gAyXov51zw3K9oy01xJ2AgFVja6bxl8GtsUedcJznWTL
	fkqdSIyclicABSvPRY5mfaoXklkBynBCj
X-Google-Smtp-Source: AGHT+IE+xLL8zKJBcLRbxxVtryhiMU5GO/yDH1E2L6jbTl+4uohAgYlXjlMne+LxOk+X/jk59FgK2YNlgqaVTv3H4xk=
X-Received: by 2002:a05:651c:503:b0:2ff:d410:6974 with SMTP id
 38308e7fff4ca-30009c2e272mr49690591fa.15.1733338772054; Wed, 04 Dec 2024
 10:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204165849.392564-1-luiz.dentz@gmail.com> <20241204165849.392564-2-luiz.dentz@gmail.com>
 <d30bea803c24a8ba63e7f9d217ff61afc302a5b5.camel@iki.fi>
In-Reply-To: <d30bea803c24a8ba63e7f9d217ff61afc302a5b5.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 13:59:19 -0500
Message-ID: <CABBYNZJZ_0uKZGSgzEja+_HtZS6BffSd0tyTgsTq5ibtZ_oiFA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix sleeping function called from
 invalid context
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Dec 4, 2024 at 1:44=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2024-12-04 kello 11:58 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bug=
s
> > like the bellow:
>
> This also in principle allows callbacks to be still running on another
> CPU when hci_unregister_cb() exits. Not sure if that is unwanted.

Well hci_unregister_cb is only called if you unload the whole module
e.g bt_exit, but you can't do that if the interface is not down afaik,
so I don't think it is possible to hit the case where the copied
entries would be invalid due to module being unloaded.

> >
> > BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:585
> > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kwor=
ker/u9:2
> > preempt_count: 0, expected: 0
> > RCU nest depth: 1, expected: 0
> > 4 locks held by kworker/u9:2/5070:
> >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3229 [inline]
> >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_=
scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
> >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3230 [inline]
> >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, =
at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
> >  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_=
complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire=
 include/linux/rcupdate.h:298 [inline]
> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock in=
clude/linux/rcupdate.h:750 [inline]
> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_bi=
g_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> > CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g=
480e035fc4c7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > Workqueue: hci0 hci_rx_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
> >  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
> >  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
> >  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
> >  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:6=
939
> >  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
> >  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
> >  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
> >  process_one_work kernel/workqueue.c:3254 [inline]
> >  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
> >  kthread+0x2f0/0x390 kernel/kthread.c:388
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> >
> > Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2fb0835e0c9cefc34614
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h | 108 ++++++++++++++++++++-----------
> >  net/bluetooth/hci_core.c         |   9 +--
> >  net/bluetooth/iso.c              |   6 ++
> >  net/bluetooth/l2cap_core.c       |  12 ++--
> >  net/bluetooth/rfcomm/core.c      |   6 ++
> >  net/bluetooth/sco.c              |  12 ++--
> >  6 files changed, 97 insertions(+), 56 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index ea798f07c5a2..ca22ead85dbe 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -804,7 +804,6 @@ struct hci_conn_params {
> >  extern struct list_head hci_dev_list;
> >  extern struct list_head hci_cb_list;
> >  extern rwlock_t hci_dev_list_lock;
> > -extern struct mutex hci_cb_list_lock;
> >
> >  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->d=
ev_flags)
> >  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)-=
>dev_flags)
> > @@ -2017,24 +2016,47 @@ struct hci_cb {
> >
> >       char *name;
> >
> > +     bool (*match)           (struct hci_conn *conn);
> >       void (*connect_cfm)     (struct hci_conn *conn, __u8 status);
> >       void (*disconn_cfm)     (struct hci_conn *conn, __u8 status);
> >       void (*security_cfm)    (struct hci_conn *conn, __u8 status,
> > -                                                             __u8 encr=
ypt);
> > +                              __u8 encrypt);
> >       void (*key_change_cfm)  (struct hci_conn *conn, __u8 status);
> >       void (*role_switch_cfm) (struct hci_conn *conn, __u8 status, __u8=
 role);
> >  };
> >
> > +static inline void hci_cb_lookup(struct hci_conn *conn, struct list_he=
ad *list)
> > +{
> > +     struct hci_cb *cb, *cpy;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> > +             if (cb->match && cb->match(conn)) {
> > +                     cpy =3D kmalloc(sizeof(*cpy), GFP_ATOMIC);
> > +                     if (!cpy)
> > +                             break;
> > +
> > +                     *cpy =3D *cb;
> > +                     INIT_LIST_HEAD(&cpy->list);
> > +                     list_add_rcu(&cpy->list, list);
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +}
> > +
> >  static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
> >  {
> > -     struct hci_cb *cb;
> > +     struct list_head list;
> > +     struct hci_cb *cb, *tmp;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > +     INIT_LIST_HEAD(&list);
> > +     hci_cb_lookup(conn, &list);
> > +
> > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> >               if (cb->connect_cfm)
> >                       cb->connect_cfm(conn, status);
> > +             kfree(cb);
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> >
> >       if (conn->connect_cfm_cb)
> >               conn->connect_cfm_cb(conn, status);
> > @@ -2042,22 +2064,43 @@ static inline void hci_connect_cfm(struct hci_c=
onn *conn, __u8 status)
> >
> >  static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
> >  {
> > -     struct hci_cb *cb;
> > +     struct list_head list;
> > +     struct hci_cb *cb, *tmp;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > +     INIT_LIST_HEAD(&list);
> > +     hci_cb_lookup(conn, &list);
> > +
> > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> >               if (cb->disconn_cfm)
> >                       cb->disconn_cfm(conn, reason);
> > +             kfree(cb);
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> >
> >       if (conn->disconn_cfm_cb)
> >               conn->disconn_cfm_cb(conn, reason);
> >  }
> >
> > +static inline void hci_security_cfm(struct hci_conn *conn, __u8 status=
,
> > +                                 __u8 encrypt)
> > +{
> > +     struct list_head list;
> > +     struct hci_cb *cb, *tmp;
> > +
> > +     INIT_LIST_HEAD(&list);
> > +     hci_cb_lookup(conn, &list);
> > +
> > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > +             if (cb->security_cfm)
> > +                     cb->security_cfm(conn, status, encrypt);
> > +             kfree(cb);
> > +     }
> > +
> > +     if (conn->security_cfm_cb)
> > +             conn->security_cfm_cb(conn, status);
> > +}
> > +
> >  static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
> >  {
> > -     struct hci_cb *cb;
> >       __u8 encrypt;
> >
> >       if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
> > @@ -2065,20 +2108,11 @@ static inline void hci_auth_cfm(struct hci_conn=
 *conn, __u8 status)
> >
> >       encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x0=
0;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->security_cfm)
> > -                     cb->security_cfm(conn, status, encrypt);
> > -     }
> > -     mutex_unlock(&hci_cb_list_lock);
> > -
> > -     if (conn->security_cfm_cb)
> > -             conn->security_cfm_cb(conn, status);
> > +     hci_security_cfm(conn, status, encrypt);
> >  }
> >
> >  static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
> >  {
> > -     struct hci_cb *cb;
> >       __u8 encrypt;
> >
> >       if (conn->state =3D=3D BT_CONFIG) {
> > @@ -2105,40 +2139,38 @@ static inline void hci_encrypt_cfm(struct hci_c=
onn *conn, __u8 status)
> >                       conn->sec_level =3D conn->pending_sec_level;
> >       }
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->security_cfm)
> > -                     cb->security_cfm(conn, status, encrypt);
> > -     }
> > -     mutex_unlock(&hci_cb_list_lock);
> > -
> > -     if (conn->security_cfm_cb)
> > -             conn->security_cfm_cb(conn, status);
> > +     hci_security_cfm(conn, status, encrypt);
> >  }
> >
> >  static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 stat=
us)
> >  {
> > -     struct hci_cb *cb;
> > +     struct list_head list;
> > +     struct hci_cb *cb, *tmp;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > +     INIT_LIST_HEAD(&list);
> > +     hci_cb_lookup(conn, &list);
> > +
> > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> >               if (cb->key_change_cfm)
> >                       cb->key_change_cfm(conn, status);
> > +             kfree(cb);
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> >  }
> >
> >  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 sta=
tus,
> >                                                               __u8 role=
)
> >  {
> > -     struct hci_cb *cb;
> > +     struct list_head list;
> > +     struct hci_cb *cb, *tmp;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > +     INIT_LIST_HEAD(&list);
> > +     hci_cb_lookup(conn, &list);
> > +
> > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> >               if (cb->role_switch_cfm)
> >                       cb->role_switch_cfm(conn, status, role);
> > +             kfree(cb);
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> >  }
> >
> >  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index f9e19f9cb5a3..25d180d225c1 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
> >  {
> >       BT_DBG("%p name %s", cb, cb->name);
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_add_tail(&cb->list, &hci_cb_list);
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     list_add_tail_rcu(&cb->list, &hci_cb_list);
> >
> >       return 0;
> >  }
> > @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
> >  {
> >       BT_DBG("%p name %s", cb, cb->name);
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_del(&cb->list);
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     list_del_rcu(&cb->list);
> > +     synchronize_rcu();
> >
> >       return 0;
> >  }
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 8ed818254dc8..eccdaa16cba0 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -2154,6 +2154,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr=
_t *bdaddr, __u8 *flags)
> >       return HCI_LM_ACCEPT;
> >  }
> >
> > +static bool iso_match(struct hci_conn *hcon)
> > +{
> > +     return hcon->type =3D=3D ISO_LINK || hcon->type =3D=3D LE_LINK;
> > +}
> > +
> >  static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
> >  {
> >       if (hcon->type !=3D ISO_LINK) {
> > @@ -2335,6 +2340,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
> >
> >  static struct hci_cb iso_cb =3D {
> >       .name           =3D "ISO",
> > +     .match          =3D iso_match,
> >       .connect_cfm    =3D iso_connect_cfm,
> >       .disconn_cfm    =3D iso_disconn_cfm,
> >  };
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 6544c1ed7143..27b4c4a2ba1f 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7217,6 +7217,11 @@ static struct l2cap_chan *l2cap_global_fixed_cha=
n(struct l2cap_chan *c,
> >       return NULL;
> >  }
> >
> > +static bool l2cap_match(struct hci_conn *hcon)
> > +{
> > +     return hcon->type =3D=3D ACL_LINK || hcon->type =3D=3D LE_LINK;
> > +}
> > +
> >  static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> >  {
> >       struct hci_dev *hdev =3D hcon->hdev;
> > @@ -7224,9 +7229,6 @@ static void l2cap_connect_cfm(struct hci_conn *hc=
on, u8 status)
> >       struct l2cap_chan *pchan;
> >       u8 dst_type;
> >
> > -     if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> > -             return;
> > -
> >       BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status)=
;
> >
> >       if (status) {
> > @@ -7291,9 +7293,6 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
> >
> >  static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> >  {
> > -     if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> > -             return;
> > -
> >       BT_DBG("hcon %p reason %d", hcon, reason);
> >
> >       l2cap_conn_del(hcon, bt_to_errno(reason));
> > @@ -7572,6 +7571,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, st=
ruct sk_buff *skb, u16 flags)
> >
> >  static struct hci_cb l2cap_cb =3D {
> >       .name           =3D "L2CAP",
> > +     .match          =3D l2cap_match,
> >       .connect_cfm    =3D l2cap_connect_cfm,
> >       .disconn_cfm    =3D l2cap_disconn_cfm,
> >       .security_cfm   =3D l2cap_security_cfm,
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index ad5177e3a69b..4c56ca5a216c 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -2134,6 +2134,11 @@ static int rfcomm_run(void *unused)
> >       return 0;
> >  }
> >
> > +static bool rfcomm_match(struct hci_conn *hcon)
> > +{
> > +     return hcon->type =3D=3D ACL_LINK;
> > +}
> > +
> >  static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 e=
ncrypt)
> >  {
> >       struct rfcomm_session *s;
> > @@ -2180,6 +2185,7 @@ static void rfcomm_security_cfm(struct hci_conn *=
conn, u8 status, u8 encrypt)
> >
> >  static struct hci_cb rfcomm_cb =3D {
> >       .name           =3D "RFCOMM",
> > +     .match          =3D rfcomm_match,
> >       .security_cfm   =3D rfcomm_security_cfm
> >  };
> >
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 7eb8d3e04ec4..40c4957cfc0b 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -1397,11 +1397,13 @@ int sco_connect_ind(struct hci_dev *hdev, bdadd=
r_t *bdaddr, __u8 *flags)
> >       return lm;
> >  }
> >
> > +static bool sco_match(struct hci_conn *hcon)
> > +{
> > +     return hcon->type =3D=3D SCO_LINK || hcon->type =3D=3D ESCO_LINK;
> > +}
> > +
> >  static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
> >  {
> > -     if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> > -             return;
> > -
> >       BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status)=
;
> >
> >       if (!status) {
> > @@ -1416,9 +1418,6 @@ static void sco_connect_cfm(struct hci_conn *hcon=
, __u8 status)
> >
> >  static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
> >  {
> > -     if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> > -             return;
> > -
> >       BT_DBG("hcon %p reason %d", hcon, reason);
> >
> >       sco_conn_del(hcon, bt_to_errno(reason));
> > @@ -1444,6 +1443,7 @@ void sco_recv_scodata(struct hci_conn *hcon, stru=
ct sk_buff *skb)
> >
> >  static struct hci_cb sco_cb =3D {
> >       .name           =3D "SCO",
> > +     .match          =3D sco_match,
> >       .connect_cfm    =3D sco_connect_cfm,
> >       .disconn_cfm    =3D sco_disconn_cfm,
> >  };
>


--=20
Luiz Augusto von Dentz
