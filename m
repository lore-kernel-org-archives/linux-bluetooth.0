Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2B21A44B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411590; cv=none; b=k3Y5FRCSEEFY7/l2djjhb3UqX49WpOX76nxWhx7G14+ijoNDl33g5B80PBqntomnwKfVSGb7T5ottYSoet6s5snofoGmZfZuE4LBahP7sDbwXLp1b6iVNVZOI2A6oa71iz+U2ayPuh8+E5fe6yFTvDtBdiK1iMnfe5L1Kg5JlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411590; c=relaxed/simple;
	bh=pEaYAr5LEaqsmV8fkSrliCRx2D/bpiVhGAOOgIdlUQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxJdMS4lK4hGtDUHjTSSRslb0kR4tLEFV/nR7+RiRWEjxd96mheWfK/b1Nt2Q/+YzGmzPkSDmzXNXy0S52uGGHTS/zAqOGPaJWQcKYfKdZB/PW00YT0js4WyhCyjKNuatAPWTExXrwQe6oW++Z8J/3tVNEFrfVuVRaueaqmg8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7C1bkIv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7C1bkIv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc93152edcso971754a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733411587; x=1734016387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhNbQNHf96mur2pDWqF0EMERQRLVZGZUXIDvgzhkx6g=;
        b=Y7C1bkIviY7FxkUEoPkfOMulq7tYECUNN/LeYpsczxMspjkbuZMWAVIANKJpshF1Qa
         0ypNrqi9fRDf2xlnnMKl5HAkyp4xrVlacrzzpgFGWplJ3BgTCchFYJoKNSeXPP/OX+ZL
         rNWFiWMjnNz3CvRtybGtNH98NsBOyzx8fTKPlwBbwylBw4YbiHj2lA27K83VQSyurr+h
         0HSRYunzAcjVEu1Ob1q2Ux3GQLkAhGpPIr2/wevxW+YelMnJU3aFOeYAiWFRpqHMJFqt
         GQMkCLkjdcDsu2LXiNIumah3TeWrpYHlBT2KOA+8Hf0uVyvZDgeje+kns1NA9I8B596Z
         8yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411587; x=1734016387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhNbQNHf96mur2pDWqF0EMERQRLVZGZUXIDvgzhkx6g=;
        b=sc4G+GFDqsfyqtOF2fvIpoWX69Ld+B78HEEyOD4lTqEt+b45ypob9Fz3jRyq2I8Cxb
         oaLgMND2h3kXKol5b14r5L9sRQgPpo/5rcW697KSfEMjnLjf1c3yf4Bi/j0PDfs9t78w
         nz+Z8wHdRm4IgLe7snhBqgoQ6dhuGbzJi9oABOYLu/zHVB6zAzHrpVyDCerIj0PPs7lo
         qU52xyxPm0fWuZ0waQ7230Y1SEfhmXtdK/JLbEcQ+RfOL8wKzou0Ii5Ajum7Sbxtjrza
         xBfMciap+dwiS4nl1TUoSfU0OmMMryZCuffeQSg8ZKTIcFCNRX79CFkgehy6KultmcEA
         4x0A==
X-Gm-Message-State: AOJu0Yz4qKvgnh1tyVY7yWGV0JT1HvUGtuq5PnwClWJxFkMH0mu/VzBD
	vMIEWbnE2Nr9nuZkarWwHoZ36RyKJYHxxo+vK3WtfAodIqrhSa5cF7//9DVkQulTtOMCjdQMNtz
	flTSAeD6+ypCMvT3+1KK2onyoIyCj8w==
X-Gm-Gg: ASbGncv+6DoNZL2CzWs1mXG5+zZPOGbn8iWUMK7EZbpUVXUNDmVToCloxTVW4z/20XG
	3x94m6HCNa4xn0eXu5T0fe4ZCKAnjHizc
X-Google-Smtp-Source: AGHT+IGffasCSQeR2CLbWGWpXXDKcgQIwbb//2QiJ369oCXKFSRKfCirG91qdA1UXhFRpmyHQe8kJGo25KEhes4L0lU=
X-Received: by 2002:a17:90b:510c:b0:2ee:94a0:255c with SMTP id
 98e67ed59e1d1-2ef41c3ca6dmr5838642a91.13.1733411587158; Thu, 05 Dec 2024
 07:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204165849.392564-1-luiz.dentz@gmail.com> <20241204165849.392564-2-luiz.dentz@gmail.com>
 <d30bea803c24a8ba63e7f9d217ff61afc302a5b5.camel@iki.fi> <CABBYNZJZ_0uKZGSgzEja+_HtZS6BffSd0tyTgsTq5ibtZ_oiFA@mail.gmail.com>
In-Reply-To: <CABBYNZJZ_0uKZGSgzEja+_HtZS6BffSd0tyTgsTq5ibtZ_oiFA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Dec 2024 10:12:50 -0500
Message-ID: <CABBYNZKEK9QXBbtopROD=94h7suNA_UbXUJp=H+7q_2n3OhO4g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix sleeping function called from
 invalid context
To: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e78b6606288755c1"

--000000000000e78b6606288755c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Wed, Dec 4, 2024 at 1:59=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Wed, Dec 4, 2024 at 1:44=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >
> > Hi Luiz,
> >
> > ke, 2024-12-04 kello 11:58 -0500, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid b=
ugs
> > > like the bellow:
> >
> > This also in principle allows callbacks to be still running on another
> > CPU when hci_unregister_cb() exits. Not sure if that is unwanted.
>
> Well hci_unregister_cb is only called if you unload the whole module
> e.g bt_exit, but you can't do that if the interface is not down afaik,
> so I don't think it is possible to hit the case where the copied
> entries would be invalid due to module being unloaded.
>
> > >
> > > BUG: sleeping function called from invalid context at kernel/locking/=
mutex.c:585
> > > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kw=
orker/u9:2
> > > preempt_count: 0, expected: 0
> > > RCU nest depth: 1, expected: 0
> > > 4 locks held by kworker/u9:2/5070:
> > >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3229 [inline]
> > >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
> > >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}=
, at: process_one_work kernel/workqueue.c:3230 [inline]
> > >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}=
, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
> > >  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_bi=
g_complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
> > >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:298 [inline]
> > >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock =
include/linux/rcupdate.h:750 [inline]
> > >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_=
big_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> > > CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073=
-g480e035fc4c7 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/27/2024
> > > Workqueue: hci0 hci_rx_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > >  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
> > >  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
> > >  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
> > >  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
> > >  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c=
:6939
> > >  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
> > >  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
> > >  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
> > >  process_one_work kernel/workqueue.c:3254 [inline]
> > >  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
> > >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
> > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > >  </TASK>
> > >
> > > Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D2fb0835e0c9cefc3461=
4
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  include/net/bluetooth/hci_core.h | 108 ++++++++++++++++++++---------=
--
> > >  net/bluetooth/hci_core.c         |   9 +--
> > >  net/bluetooth/iso.c              |   6 ++
> > >  net/bluetooth/l2cap_core.c       |  12 ++--
> > >  net/bluetooth/rfcomm/core.c      |   6 ++
> > >  net/bluetooth/sco.c              |  12 ++--
> > >  6 files changed, 97 insertions(+), 56 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index ea798f07c5a2..ca22ead85dbe 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -804,7 +804,6 @@ struct hci_conn_params {
> > >  extern struct list_head hci_dev_list;
> > >  extern struct list_head hci_cb_list;
> > >  extern rwlock_t hci_dev_list_lock;
> > > -extern struct mutex hci_cb_list_lock;
> > >
> > >  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)-=
>dev_flags)
> > >  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev=
)->dev_flags)
> > > @@ -2017,24 +2016,47 @@ struct hci_cb {
> > >
> > >       char *name;
> > >
> > > +     bool (*match)           (struct hci_conn *conn);
> > >       void (*connect_cfm)     (struct hci_conn *conn, __u8 status);
> > >       void (*disconn_cfm)     (struct hci_conn *conn, __u8 status);
> > >       void (*security_cfm)    (struct hci_conn *conn, __u8 status,
> > > -                                                             __u8 en=
crypt);
> > > +                              __u8 encrypt);
> > >       void (*key_change_cfm)  (struct hci_conn *conn, __u8 status);
> > >       void (*role_switch_cfm) (struct hci_conn *conn, __u8 status, __=
u8 role);
> > >  };
> > >
> > > +static inline void hci_cb_lookup(struct hci_conn *conn, struct list_=
head *list)
> > > +{
> > > +     struct hci_cb *cb, *cpy;
> > > +
> > > +     rcu_read_lock();
> > > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> > > +             if (cb->match && cb->match(conn)) {
> > > +                     cpy =3D kmalloc(sizeof(*cpy), GFP_ATOMIC);
> > > +                     if (!cpy)
> > > +                             break;
> > > +
> > > +                     *cpy =3D *cb;
> > > +                     INIT_LIST_HEAD(&cpy->list);
> > > +                     list_add_rcu(&cpy->list, list);
> > > +             }
> > > +     }
> > > +     rcu_read_unlock();
> > > +}
> > > +
> > >  static inline void hci_connect_cfm(struct hci_conn *conn, __u8 statu=
s)
> > >  {
> > > -     struct hci_cb *cb;
> > > +     struct list_head list;
> > > +     struct hci_cb *cb, *tmp;
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > +     INIT_LIST_HEAD(&list);
> > > +     hci_cb_lookup(conn, &list);
> > > +
> > > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > >               if (cb->connect_cfm)
> > >                       cb->connect_cfm(conn, status);
> > > +             kfree(cb);
> > >       }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > >
> > >       if (conn->connect_cfm_cb)
> > >               conn->connect_cfm_cb(conn, status);
> > > @@ -2042,22 +2064,43 @@ static inline void hci_connect_cfm(struct hci=
_conn *conn, __u8 status)
> > >
> > >  static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reaso=
n)
> > >  {
> > > -     struct hci_cb *cb;
> > > +     struct list_head list;
> > > +     struct hci_cb *cb, *tmp;
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > +     INIT_LIST_HEAD(&list);
> > > +     hci_cb_lookup(conn, &list);
> > > +
> > > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > >               if (cb->disconn_cfm)
> > >                       cb->disconn_cfm(conn, reason);
> > > +             kfree(cb);
> > >       }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > >
> > >       if (conn->disconn_cfm_cb)
> > >               conn->disconn_cfm_cb(conn, reason);
> > >  }
> > >
> > > +static inline void hci_security_cfm(struct hci_conn *conn, __u8 stat=
us,
> > > +                                 __u8 encrypt)
> > > +{
> > > +     struct list_head list;
> > > +     struct hci_cb *cb, *tmp;
> > > +
> > > +     INIT_LIST_HEAD(&list);
> > > +     hci_cb_lookup(conn, &list);
> > > +
> > > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > > +             if (cb->security_cfm)
> > > +                     cb->security_cfm(conn, status, encrypt);
> > > +             kfree(cb);
> > > +     }
> > > +
> > > +     if (conn->security_cfm_cb)
> > > +             conn->security_cfm_cb(conn, status);
> > > +}
> > > +
> > >  static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
> > >  {
> > > -     struct hci_cb *cb;
> > >       __u8 encrypt;
> > >
> > >       if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
> > > @@ -2065,20 +2108,11 @@ static inline void hci_auth_cfm(struct hci_co=
nn *conn, __u8 status)
> > >
> > >       encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0=
x00;
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > -             if (cb->security_cfm)
> > > -                     cb->security_cfm(conn, status, encrypt);
> > > -     }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > > -
> > > -     if (conn->security_cfm_cb)
> > > -             conn->security_cfm_cb(conn, status);
> > > +     hci_security_cfm(conn, status, encrypt);
> > >  }
> > >
> > >  static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 statu=
s)
> > >  {
> > > -     struct hci_cb *cb;
> > >       __u8 encrypt;
> > >
> > >       if (conn->state =3D=3D BT_CONFIG) {
> > > @@ -2105,40 +2139,38 @@ static inline void hci_encrypt_cfm(struct hci=
_conn *conn, __u8 status)
> > >                       conn->sec_level =3D conn->pending_sec_level;
> > >       }
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > -             if (cb->security_cfm)
> > > -                     cb->security_cfm(conn, status, encrypt);
> > > -     }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > > -
> > > -     if (conn->security_cfm_cb)
> > > -             conn->security_cfm_cb(conn, status);
> > > +     hci_security_cfm(conn, status, encrypt);
> > >  }
> > >
> > >  static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 st=
atus)
> > >  {
> > > -     struct hci_cb *cb;
> > > +     struct list_head list;
> > > +     struct hci_cb *cb, *tmp;
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > +     INIT_LIST_HEAD(&list);
> > > +     hci_cb_lookup(conn, &list);
> > > +
> > > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > >               if (cb->key_change_cfm)
> > >                       cb->key_change_cfm(conn, status);
> > > +             kfree(cb);
> > >       }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > >  }
> > >
> > >  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 s=
tatus,
> > >                                                               __u8 ro=
le)
> > >  {
> > > -     struct hci_cb *cb;
> > > +     struct list_head list;
> > > +     struct hci_cb *cb, *tmp;
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > > +     INIT_LIST_HEAD(&list);
> > > +     hci_cb_lookup(conn, &list);
> > > +
> > > +     list_for_each_entry_safe(cb, tmp, &list, list) {
> > >               if (cb->role_switch_cfm)
> > >                       cb->role_switch_cfm(conn, status, role);
> > > +             kfree(cb);
> > >       }
> > > -     mutex_unlock(&hci_cb_list_lock);
> > >  }
> > >
> > >  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index f9e19f9cb5a3..25d180d225c1 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
> > >  {
> > >       BT_DBG("%p name %s", cb, cb->name);
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_add_tail(&cb->list, &hci_cb_list);
> > > -     mutex_unlock(&hci_cb_list_lock);
> > > +     list_add_tail_rcu(&cb->list, &hci_cb_list);
> > >
> > >       return 0;
> > >  }
> > > @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
> > >  {
> > >       BT_DBG("%p name %s", cb, cb->name);
> > >
> > > -     mutex_lock(&hci_cb_list_lock);
> > > -     list_del(&cb->list);
> > > -     mutex_unlock(&hci_cb_list_lock);
> > > +     list_del_rcu(&cb->list);
> > > +     synchronize_rcu();
> > >
> > >       return 0;
> > >  }
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index 8ed818254dc8..eccdaa16cba0 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -2154,6 +2154,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdad=
dr_t *bdaddr, __u8 *flags)
> > >       return HCI_LM_ACCEPT;
> > >  }
> > >
> > > +static bool iso_match(struct hci_conn *hcon)
> > > +{
> > > +     return hcon->type =3D=3D ISO_LINK || hcon->type =3D=3D LE_LINK;
> > > +}
> > > +
> > >  static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
> > >  {
> > >       if (hcon->type !=3D ISO_LINK) {
> > > @@ -2335,6 +2340,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_=
buff *skb, u16 flags)
> > >
> > >  static struct hci_cb iso_cb =3D {
> > >       .name           =3D "ISO",
> > > +     .match          =3D iso_match,
> > >       .connect_cfm    =3D iso_connect_cfm,
> > >       .disconn_cfm    =3D iso_disconn_cfm,
> > >  };
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 6544c1ed7143..27b4c4a2ba1f 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -7217,6 +7217,11 @@ static struct l2cap_chan *l2cap_global_fixed_c=
han(struct l2cap_chan *c,
> > >       return NULL;
> > >  }
> > >
> > > +static bool l2cap_match(struct hci_conn *hcon)
> > > +{
> > > +     return hcon->type =3D=3D ACL_LINK || hcon->type =3D=3D LE_LINK;
> > > +}
> > > +
> > >  static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> > >  {
> > >       struct hci_dev *hdev =3D hcon->hdev;
> > > @@ -7224,9 +7229,6 @@ static void l2cap_connect_cfm(struct hci_conn *=
hcon, u8 status)
> > >       struct l2cap_chan *pchan;
> > >       u8 dst_type;
> > >
> > > -     if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> > > -             return;
> > > -
> > >       BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, statu=
s);
> > >
> > >       if (status) {
> > > @@ -7291,9 +7293,6 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
> > >
> > >  static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> > >  {
> > > -     if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> > > -             return;
> > > -
> > >       BT_DBG("hcon %p reason %d", hcon, reason);
> > >
> > >       l2cap_conn_del(hcon, bt_to_errno(reason));
> > > @@ -7572,6 +7571,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, =
struct sk_buff *skb, u16 flags)
> > >
> > >  static struct hci_cb l2cap_cb =3D {
> > >       .name           =3D "L2CAP",
> > > +     .match          =3D l2cap_match,
> > >       .connect_cfm    =3D l2cap_connect_cfm,
> > >       .disconn_cfm    =3D l2cap_disconn_cfm,
> > >       .security_cfm   =3D l2cap_security_cfm,
> > > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.=
c
> > > index ad5177e3a69b..4c56ca5a216c 100644
> > > --- a/net/bluetooth/rfcomm/core.c
> > > +++ b/net/bluetooth/rfcomm/core.c
> > > @@ -2134,6 +2134,11 @@ static int rfcomm_run(void *unused)
> > >       return 0;
> > >  }
> > >
> > > +static bool rfcomm_match(struct hci_conn *hcon)
> > > +{
> > > +     return hcon->type =3D=3D ACL_LINK;
> > > +}
> > > +
> > >  static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8=
 encrypt)
> > >  {
> > >       struct rfcomm_session *s;
> > > @@ -2180,6 +2185,7 @@ static void rfcomm_security_cfm(struct hci_conn=
 *conn, u8 status, u8 encrypt)
> > >
> > >  static struct hci_cb rfcomm_cb =3D {
> > >       .name           =3D "RFCOMM",
> > > +     .match          =3D rfcomm_match,
> > >       .security_cfm   =3D rfcomm_security_cfm
> > >  };
> > >
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index 7eb8d3e04ec4..40c4957cfc0b 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -1397,11 +1397,13 @@ int sco_connect_ind(struct hci_dev *hdev, bda=
ddr_t *bdaddr, __u8 *flags)
> > >       return lm;
> > >  }
> > >
> > > +static bool sco_match(struct hci_conn *hcon)
> > > +{
> > > +     return hcon->type =3D=3D SCO_LINK || hcon->type =3D=3D ESCO_LIN=
K;
> > > +}
> > > +
> > >  static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
> > >  {
> > > -     if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> > > -             return;
> > > -
> > >       BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, statu=
s);
> > >
> > >       if (!status) {
> > > @@ -1416,9 +1418,6 @@ static void sco_connect_cfm(struct hci_conn *hc=
on, __u8 status)
> > >
> > >  static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
> > >  {
> > > -     if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> > > -             return;
> > > -
> > >       BT_DBG("hcon %p reason %d", hcon, reason);
> > >
> > >       sco_conn_del(hcon, bt_to_errno(reason));
> > > @@ -1444,6 +1443,7 @@ void sco_recv_scodata(struct hci_conn *hcon, st=
ruct sk_buff *skb)
> > >
> > >  static struct hci_cb sco_cb =3D {
> > >       .name           =3D "SCO",
> > > +     .match          =3D sco_match,
> > >       .connect_cfm    =3D sco_connect_cfm,
> > >       .disconn_cfm    =3D sco_disconn_cfm,
> > >  };
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--000000000000e78b6606288755c1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-Bluetooth-hci_core-Fix-sleeping-function-called-f.patch"
Content-Disposition: attachment; 
	filename="v2-0001-Bluetooth-hci_core-Fix-sleeping-function-called-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4bghq610>
X-Attachment-Id: f_m4bghq610

RnJvbSBkOTg0ZmNiODMxNzhlNzNiOTk1MTlkNGUyY2NiZWZiYmNhY2I1N2IyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMyBEZWMgMjAyNCAxNjowNzozMiAtMDUwMApTdWJqZWN0
OiBbUEFUQ0ggdjJdIEJsdWV0b290aDogaGNpX2NvcmU6IEZpeCBzbGVlcGluZyBmdW5jdGlvbiBj
YWxsZWQgZnJvbQogaW52YWxpZCBjb250ZXh0CgpUaGlzIHJld29ya3MgaGNpX2NiX2xpc3QgdG8g
bm90IHVzZSBtdXRleCBoY2lfY2JfbGlzdF9sb2NrIHRvIGF2b2lkIGJ1Z3MKbGlrZSB0aGUgYmVs
bG93OgoKQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQg
YXQga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo1ODUKaW5fYXRvbWljKCk6IDAsIGlycXNfZGlzYWJs
ZWQoKTogMCwgbm9uX2Jsb2NrOiAwLCBwaWQ6IDUwNzAsIG5hbWU6IGt3b3JrZXIvdTk6MgpwcmVl
bXB0X2NvdW50OiAwLCBleHBlY3RlZDogMApSQ1UgbmVzdCBkZXB0aDogMSwgZXhwZWN0ZWQ6IDAK
NCBsb2NrcyBoZWxkIGJ5IGt3b3JrZXIvdTk6Mi81MDcwOgogIzA6IGZmZmY4ODgwMTViZTM5NDgg
KCh3cV9jb21wbGV0aW9uKWhjaTAjMil7Ky4rLn0tezA6MH0sIGF0OiBwcm9jZXNzX29uZV93b3Jr
IGtlcm5lbC93b3JrcXVldWUuYzozMjI5IFtpbmxpbmVdCiAjMDogZmZmZjg4ODAxNWJlMzk0OCAo
KHdxX2NvbXBsZXRpb24paGNpMCMyKXsrLisufS17MDowfSwgYXQ6IHByb2Nlc3Nfc2NoZWR1bGVk
X3dvcmtzKzB4OGUwLzB4MTc3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMzNQogIzE6IGZmZmZjOTAw
MDNiNmZkMDAgKCh3b3JrX2NvbXBsZXRpb24pKCZoZGV2LT5yeF93b3JrKSl7Ky4rLn0tezA6MH0s
IGF0OiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVldWUuYzozMjMwIFtpbmxpbmVdCiAj
MTogZmZmZmM5MDAwM2I2ZmQwMCAoKHdvcmtfY29tcGxldGlvbikoJmhkZXYtPnJ4X3dvcmspKXsr
LisufS17MDowfSwgYXQ6IHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4OTFiLzB4MTc3MCBrZXJu
ZWwvd29ya3F1ZXVlLmM6MzMzNQogIzI6IGZmZmY4ODgwNjY1ZDAwNzggKCZoZGV2LT5sb2NrKXsr
LisufS17MzozfSwgYXQ6IGhjaV9sZV9jcmVhdGVfYmlnX2NvbXBsZXRlX2V2dCsweGNmLzB4YWUw
IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NjkxNAogIzM6IGZmZmZmZmZmOGUxMzIwMjAgKHJj
dV9yZWFkX2xvY2spey4uLi59LXsxOjJ9LCBhdDogcmN1X2xvY2tfYWNxdWlyZSBpbmNsdWRlL2xp
bnV4L3JjdXBkYXRlLmg6Mjk4IFtpbmxpbmVdCiAjMzogZmZmZmZmZmY4ZTEzMjAyMCAocmN1X3Jl
YWRfbG9jayl7Li4uLn0tezE6Mn0sIGF0OiByY3VfcmVhZF9sb2NrIGluY2x1ZGUvbGludXgvcmN1
cGRhdGUuaDo3NTAgW2lubGluZV0KICMzOiBmZmZmZmZmZjhlMTMyMDIwIChyY3VfcmVhZF9sb2Nr
KXsuLi4ufS17MToyfSwgYXQ6IGhjaV9sZV9jcmVhdGVfYmlnX2NvbXBsZXRlX2V2dCsweGRiLzB4
YWUwIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NjkxNQpDUFU6IDAgUElEOiA1MDcwIENvbW06
IGt3b3JrZXIvdTk6MiBOb3QgdGFpbnRlZCA2LjguMC1zeXprYWxsZXItMDgwNzMtZzQ4MGUwMzVm
YzRjNyAjMApIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2ds
ZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMDMvMjcvMjAyNApXb3JrcXVldWU6IGhjaTAg
aGNpX3J4X3dvcmsKQ2FsbCBUcmFjZToKIDxUQVNLPgogX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0
YWNrLmM6ODggW2lubGluZV0KIGR1bXBfc3RhY2tfbHZsKzB4MjQxLzB4MzYwIGxpYi9kdW1wX3N0
YWNrLmM6MTE0CiBfX21pZ2h0X3Jlc2NoZWQrMHg1ZDQvMHg3ODAga2VybmVsL3NjaGVkL2NvcmUu
YzoxMDE4NwogX19tdXRleF9sb2NrX2NvbW1vbiBrZXJuZWwvbG9ja2luZy9tdXRleC5jOjU4NSBb
aW5saW5lXQogX19tdXRleF9sb2NrKzB4YzEvMHhkNzAga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo3
NTIKIGhjaV9jb25uZWN0X2NmbSBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaDoyMDA0
IFtpbmxpbmVdCiBoY2lfbGVfY3JlYXRlX2JpZ19jb21wbGV0ZV9ldnQrMHgzZDkvMHhhZTAgbmV0
L2JsdWV0b290aC9oY2lfZXZlbnQuYzo2OTM5CiBoY2lfZXZlbnRfZnVuYyBuZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jOjc1MTQgW2lubGluZV0KIGhjaV9ldmVudF9wYWNrZXQrMHhhNTMvMHgxNTQw
IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NzU2OQogaGNpX3J4X3dvcmsrMHgzZTgvMHhjYTAg
bmV0L2JsdWV0b290aC9oY2lfY29yZS5jOjQxNzEKIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dv
cmtxdWV1ZS5jOjMyNTQgW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YTAwLzB4
MTc3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMzNQogd29ya2VyX3RocmVhZCsweDg2ZC8weGQ3MCBr
ZXJuZWwvd29ya3F1ZXVlLmM6MzQxNgoga3RocmVhZCsweDJmMC8weDM5MCBrZXJuZWwva3RocmVh
ZC5jOjM4OAogcmV0X2Zyb21fZm9yaysweDRiLzB4ODAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3Mu
YzoxNDcKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82
NC5TOjI0MwogPC9UQVNLPgoKUmVwb3J0ZWQtYnk6IHN5emJvdCsyZmIwODM1ZTBjOWNlZmMzNDYx
NEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20vYnVnP2V4dGlkPTJmYjA4MzVlMGM5Y2VmYzM0NjE0ClNpZ25lZC1vZmYtYnk6IEx1
aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4KLS0tCiBpbmNs
dWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCB8IDEwOCArKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tCiBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmMgICAgICAgICB8ICAgOSArLS0KIG5l
dC9ibHVldG9vdGgvaXNvLmMgICAgICAgICAgICAgIHwgICA2ICsrCiBuZXQvYmx1ZXRvb3RoL2wy
Y2FwX2NvcmUuYyAgICAgICB8ICAxMiArKy0tCiBuZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMg
ICAgICB8ICAgNiArKwogbmV0L2JsdWV0b290aC9zY28uYyAgICAgICAgICAgICAgfCAgMTIgKyst
LQogNiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCA1NiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCBiL2luY2x1ZGUvbmV0
L2JsdWV0b290aC9oY2lfY29yZS5oCmluZGV4IGVhNzk4ZjA3YzVhMi4uY2EyMmVhZDg1ZGJlIDEw
MDY0NAotLS0gYS9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaAorKysgYi9pbmNsdWRl
L25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaApAQCAtODA0LDcgKzgwNCw2IEBAIHN0cnVjdCBoY2lf
Y29ubl9wYXJhbXMgewogZXh0ZXJuIHN0cnVjdCBsaXN0X2hlYWQgaGNpX2Rldl9saXN0OwogZXh0
ZXJuIHN0cnVjdCBsaXN0X2hlYWQgaGNpX2NiX2xpc3Q7CiBleHRlcm4gcndsb2NrX3QgaGNpX2Rl
dl9saXN0X2xvY2s7Ci1leHRlcm4gc3RydWN0IG11dGV4IGhjaV9jYl9saXN0X2xvY2s7CiAKICNk
ZWZpbmUgaGNpX2Rldl9zZXRfZmxhZyhoZGV2LCBucikgICAgICAgICAgICAgc2V0X2JpdCgobnIp
LCAoaGRldiktPmRldl9mbGFncykKICNkZWZpbmUgaGNpX2Rldl9jbGVhcl9mbGFnKGhkZXYsIG5y
KSAgICAgICAgICAgY2xlYXJfYml0KChuciksIChoZGV2KS0+ZGV2X2ZsYWdzKQpAQCAtMjAxNywy
NCArMjAxNiw0NyBAQCBzdHJ1Y3QgaGNpX2NiIHsKIAogCWNoYXIgKm5hbWU7CiAKKwlib29sICgq
bWF0Y2gpCQkoc3RydWN0IGhjaV9jb25uICpjb25uKTsKIAl2b2lkICgqY29ubmVjdF9jZm0pCShz
dHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKTsKIAl2b2lkICgqZGlzY29ubl9jZm0p
CShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKTsKIAl2b2lkICgqc2VjdXJpdHlf
Y2ZtKQkoc3RydWN0IGhjaV9jb25uICpjb25uLCBfX3U4IHN0YXR1cywKLQkJCQkJCQkJX191OCBl
bmNyeXB0KTsKKwkJCQkgX191OCBlbmNyeXB0KTsKIAl2b2lkICgqa2V5X2NoYW5nZV9jZm0pCShz
dHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKTsKIAl2b2lkICgqcm9sZV9zd2l0Y2hf
Y2ZtKQkoc3RydWN0IGhjaV9jb25uICpjb25uLCBfX3U4IHN0YXR1cywgX191OCByb2xlKTsKIH07
CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBoY2lfY2JfbG9va3VwKHN0cnVjdCBoY2lfY29ubiAqY29u
biwgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKK3sKKwlzdHJ1Y3QgaGNpX2NiICpjYiwgKmNweTsK
KworCXJjdV9yZWFkX2xvY2soKTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShjYiwgJmhjaV9j
Yl9saXN0LCBsaXN0KSB7CisJCWlmIChjYi0+bWF0Y2ggJiYgY2ItPm1hdGNoKGNvbm4pKSB7CisJ
CQljcHkgPSBrbWFsbG9jKHNpemVvZigqY3B5KSwgR0ZQX0FUT01JQyk7CisJCQlpZiAoIWNweSkK
KwkJCQlicmVhazsKKworCQkJKmNweSA9ICpjYjsKKwkJCUlOSVRfTElTVF9IRUFEKCZjcHktPmxp
c3QpOworCQkJbGlzdF9hZGRfcmN1KCZjcHktPmxpc3QsIGxpc3QpOworCQl9CisJfQorCXJjdV9y
ZWFkX3VubG9jaygpOworfQorCiBzdGF0aWMgaW5saW5lIHZvaWQgaGNpX2Nvbm5lY3RfY2ZtKHN0
cnVjdCBoY2lfY29ubiAqY29ubiwgX191OCBzdGF0dXMpCiB7Ci0Jc3RydWN0IGhjaV9jYiAqY2I7
CisJc3RydWN0IGxpc3RfaGVhZCBsaXN0OworCXN0cnVjdCBoY2lfY2IgKmNiLCAqdG1wOwogCi0J
bXV0ZXhfbG9jaygmaGNpX2NiX2xpc3RfbG9jayk7Ci0JbGlzdF9mb3JfZWFjaF9lbnRyeShjYiwg
JmhjaV9jYl9saXN0LCBsaXN0KSB7CisJSU5JVF9MSVNUX0hFQUQoJmxpc3QpOworCWhjaV9jYl9s
b29rdXAoY29ubiwgJmxpc3QpOworCisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGNiLCB0bXAs
ICZsaXN0LCBsaXN0KSB7CiAJCWlmIChjYi0+Y29ubmVjdF9jZm0pCiAJCQljYi0+Y29ubmVjdF9j
Zm0oY29ubiwgc3RhdHVzKTsKKwkJa2ZyZWUoY2IpOwogCX0KLQltdXRleF91bmxvY2soJmhjaV9j
Yl9saXN0X2xvY2spOwogCiAJaWYgKGNvbm4tPmNvbm5lY3RfY2ZtX2NiKQogCQljb25uLT5jb25u
ZWN0X2NmbV9jYihjb25uLCBzdGF0dXMpOwpAQCAtMjA0MiwyMiArMjA2NCw0MyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgaGNpX2Nvbm5lY3RfY2ZtKHN0cnVjdCBoY2lfY29ubiAqY29ubiwgX191OCBz
dGF0dXMpCiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBoY2lfZGlzY29ubl9jZm0oc3RydWN0IGhjaV9j
b25uICpjb25uLCBfX3U4IHJlYXNvbikKIHsKLQlzdHJ1Y3QgaGNpX2NiICpjYjsKKwlzdHJ1Y3Qg
bGlzdF9oZWFkIGxpc3Q7CisJc3RydWN0IGhjaV9jYiAqY2IsICp0bXA7CiAKLQltdXRleF9sb2Nr
KCZoY2lfY2JfbGlzdF9sb2NrKTsKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNiLCAmaGNpX2NiX2xp
c3QsIGxpc3QpIHsKKwlJTklUX0xJU1RfSEVBRCgmbGlzdCk7CisJaGNpX2NiX2xvb2t1cChjb25u
LCAmbGlzdCk7CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2IsIHRtcCwgJmxpc3QsIGxp
c3QpIHsKIAkJaWYgKGNiLT5kaXNjb25uX2NmbSkKIAkJCWNiLT5kaXNjb25uX2NmbShjb25uLCBy
ZWFzb24pOworCQlrZnJlZShjYik7CiAJfQotCW11dGV4X3VubG9jaygmaGNpX2NiX2xpc3RfbG9j
ayk7CiAKIAlpZiAoY29ubi0+ZGlzY29ubl9jZm1fY2IpCiAJCWNvbm4tPmRpc2Nvbm5fY2ZtX2Ni
KGNvbm4sIHJlYXNvbik7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBoY2lfc2VjdXJpdHlfY2Zt
KHN0cnVjdCBoY2lfY29ubiAqY29ubiwgX191OCBzdGF0dXMsCisJCQkJICAgIF9fdTggZW5jcnlw
dCkKK3sKKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7CisJc3RydWN0IGhjaV9jYiAqY2IsICp0bXA7
CisKKwlJTklUX0xJU1RfSEVBRCgmbGlzdCk7CisJaGNpX2NiX2xvb2t1cChjb25uLCAmbGlzdCk7
CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2IsIHRtcCwgJmxpc3QsIGxpc3QpIHsKKwkJ
aWYgKGNiLT5zZWN1cml0eV9jZm0pCisJCQljYi0+c2VjdXJpdHlfY2ZtKGNvbm4sIHN0YXR1cywg
ZW5jcnlwdCk7CisJCWtmcmVlKGNiKTsKKwl9CisKKwlpZiAoY29ubi0+c2VjdXJpdHlfY2ZtX2Ni
KQorCQljb25uLT5zZWN1cml0eV9jZm1fY2IoY29ubiwgc3RhdHVzKTsKK30KKwogc3RhdGljIGlu
bGluZSB2b2lkIGhjaV9hdXRoX2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVz
KQogewotCXN0cnVjdCBoY2lfY2IgKmNiOwogCV9fdTggZW5jcnlwdDsKIAogCWlmICh0ZXN0X2Jp
dChIQ0lfQ09OTl9FTkNSWVBUX1BFTkQsICZjb25uLT5mbGFncykpCkBAIC0yMDY1LDIwICsyMTA4
LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBoY2lfYXV0aF9jZm0oc3RydWN0IGhjaV9jb25uICpj
b25uLCBfX3U4IHN0YXR1cykKIAogCWVuY3J5cHQgPSB0ZXN0X2JpdChIQ0lfQ09OTl9FTkNSWVBU
LCAmY29ubi0+ZmxhZ3MpID8gMHgwMSA6IDB4MDA7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlz
dF9sb2NrKTsKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNiLCAmaGNpX2NiX2xpc3QsIGxpc3QpIHsK
LQkJaWYgKGNiLT5zZWN1cml0eV9jZm0pCi0JCQljYi0+c2VjdXJpdHlfY2ZtKGNvbm4sIHN0YXR1
cywgZW5jcnlwdCk7Ci0JfQotCW11dGV4X3VubG9jaygmaGNpX2NiX2xpc3RfbG9jayk7Ci0KLQlp
ZiAoY29ubi0+c2VjdXJpdHlfY2ZtX2NiKQotCQljb25uLT5zZWN1cml0eV9jZm1fY2IoY29ubiwg
c3RhdHVzKTsKKwloY2lfc2VjdXJpdHlfY2ZtKGNvbm4sIHN0YXR1cywgZW5jcnlwdCk7CiB9CiAK
IHN0YXRpYyBpbmxpbmUgdm9pZCBoY2lfZW5jcnlwdF9jZm0oc3RydWN0IGhjaV9jb25uICpjb25u
LCBfX3U4IHN0YXR1cykKIHsKLQlzdHJ1Y3QgaGNpX2NiICpjYjsKIAlfX3U4IGVuY3J5cHQ7CiAK
IAlpZiAoY29ubi0+c3RhdGUgPT0gQlRfQ09ORklHKSB7CkBAIC0yMTA1LDQwICsyMTM5LDM4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBoY2lfZW5jcnlwdF9jZm0oc3RydWN0IGhjaV9jb25uICpjb25u
LCBfX3U4IHN0YXR1cykKIAkJCWNvbm4tPnNlY19sZXZlbCA9IGNvbm4tPnBlbmRpbmdfc2VjX2xl
dmVsOwogCX0KIAotCW11dGV4X2xvY2soJmhjaV9jYl9saXN0X2xvY2spOwotCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoY2IsICZoY2lfY2JfbGlzdCwgbGlzdCkgewotCQlpZiAoY2ItPnNlY3VyaXR5X2Nm
bSkKLQkJCWNiLT5zZWN1cml0eV9jZm0oY29ubiwgc3RhdHVzLCBlbmNyeXB0KTsKLQl9Ci0JbXV0
ZXhfdW5sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKLQotCWlmIChjb25uLT5zZWN1cml0eV9jZm1f
Y2IpCi0JCWNvbm4tPnNlY3VyaXR5X2NmbV9jYihjb25uLCBzdGF0dXMpOworCWhjaV9zZWN1cml0
eV9jZm0oY29ubiwgc3RhdHVzLCBlbmNyeXB0KTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGhj
aV9rZXlfY2hhbmdlX2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKQogewot
CXN0cnVjdCBoY2lfY2IgKmNiOworCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsKKwlzdHJ1Y3QgaGNp
X2NiICpjYiwgKnRtcDsKIAotCW11dGV4X2xvY2soJmhjaV9jYl9saXN0X2xvY2spOwotCWxpc3Rf
Zm9yX2VhY2hfZW50cnkoY2IsICZoY2lfY2JfbGlzdCwgbGlzdCkgeworCUlOSVRfTElTVF9IRUFE
KCZsaXN0KTsKKwloY2lfY2JfbG9va3VwKGNvbm4sICZsaXN0KTsKKworCWxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZShjYiwgdG1wLCAmbGlzdCwgbGlzdCkgewogCQlpZiAoY2ItPmtleV9jaGFuZ2Vf
Y2ZtKQogCQkJY2ItPmtleV9jaGFuZ2VfY2ZtKGNvbm4sIHN0YXR1cyk7CisJCWtmcmVlKGNiKTsK
IAl9Ci0JbXV0ZXhfdW5sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKIH0KIAogc3RhdGljIGlubGlu
ZSB2b2lkIGhjaV9yb2xlX3N3aXRjaF9jZm0oc3RydWN0IGhjaV9jb25uICpjb25uLCBfX3U4IHN0
YXR1cywKIAkJCQkJCQkJX191OCByb2xlKQogewotCXN0cnVjdCBoY2lfY2IgKmNiOworCXN0cnVj
dCBsaXN0X2hlYWQgbGlzdDsKKwlzdHJ1Y3QgaGNpX2NiICpjYiwgKnRtcDsKIAotCW11dGV4X2xv
Y2soJmhjaV9jYl9saXN0X2xvY2spOwotCWxpc3RfZm9yX2VhY2hfZW50cnkoY2IsICZoY2lfY2Jf
bGlzdCwgbGlzdCkgeworCUlOSVRfTElTVF9IRUFEKCZsaXN0KTsKKwloY2lfY2JfbG9va3VwKGNv
bm4sICZsaXN0KTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShjYiwgdG1wLCAmbGlzdCwg
bGlzdCkgewogCQlpZiAoY2ItPnJvbGVfc3dpdGNoX2NmbSkKIAkJCWNiLT5yb2xlX3N3aXRjaF9j
Zm0oY29ubiwgc3RhdHVzLCByb2xlKTsKKwkJa2ZyZWUoY2IpOwogCX0KLQltdXRleF91bmxvY2so
JmhjaV9jYl9saXN0X2xvY2spOwogfQogCiBzdGF0aWMgaW5saW5lIGJvb2wgaGNpX2JkYWRkcl9p
c19ycGEoYmRhZGRyX3QgKmJkYWRkciwgdTggYWRkcl90eXBlKQpkaWZmIC0tZ2l0IGEvbmV0L2Js
dWV0b290aC9oY2lfY29yZS5jIGIvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jCmluZGV4IGY5ZTE5
ZjljYjVhMy4uMjVkMTgwZDIyNWMxIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3Jl
LmMKKysrIGIvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jCkBAIC0yOTkzLDkgKzI5OTMsNyBAQCBp
bnQgaGNpX3JlZ2lzdGVyX2NiKHN0cnVjdCBoY2lfY2IgKmNiKQogewogCUJUX0RCRygiJXAgbmFt
ZSAlcyIsIGNiLCBjYi0+bmFtZSk7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsK
LQlsaXN0X2FkZF90YWlsKCZjYi0+bGlzdCwgJmhjaV9jYl9saXN0KTsKLQltdXRleF91bmxvY2so
JmhjaV9jYl9saXN0X2xvY2spOworCWxpc3RfYWRkX3RhaWxfcmN1KCZjYi0+bGlzdCwgJmhjaV9j
Yl9saXN0KTsKIAogCXJldHVybiAwOwogfQpAQCAtMzAwNSw5ICszMDAzLDggQEAgaW50IGhjaV91
bnJlZ2lzdGVyX2NiKHN0cnVjdCBoY2lfY2IgKmNiKQogewogCUJUX0RCRygiJXAgbmFtZSAlcyIs
IGNiLCBjYi0+bmFtZSk7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKLQlsaXN0
X2RlbCgmY2ItPmxpc3QpOwotCW11dGV4X3VubG9jaygmaGNpX2NiX2xpc3RfbG9jayk7CisJbGlz
dF9kZWxfcmN1KCZjYi0+bGlzdCk7CisJc3luY2hyb25pemVfcmN1KCk7CiAKIAlyZXR1cm4gMDsK
IH0KZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaXNvLmMgYi9uZXQvYmx1ZXRvb3RoL2lzby5j
CmluZGV4IDhlZDgxODI1NGRjOC4uZWNjZGFhMTZjYmEwIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRv
b3RoL2lzby5jCisrKyBiL25ldC9ibHVldG9vdGgvaXNvLmMKQEAgLTIxNTQsNiArMjE1NCwxMSBA
QCBpbnQgaXNvX2Nvbm5lY3RfaW5kKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBiZGFkZHJfdCAqYmRh
ZGRyLCBfX3U4ICpmbGFncykKIAlyZXR1cm4gSENJX0xNX0FDQ0VQVDsKIH0KIAorc3RhdGljIGJv
b2wgaXNvX21hdGNoKHN0cnVjdCBoY2lfY29ubiAqaGNvbikKK3sKKwlyZXR1cm4gaGNvbi0+dHlw
ZSA9PSBJU09fTElOSyB8fCBoY29uLT50eXBlID09IExFX0xJTks7Cit9CisKIHN0YXRpYyB2b2lk
IGlzb19jb25uZWN0X2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIF9fdTggc3RhdHVzKQogewog
CWlmIChoY29uLT50eXBlICE9IElTT19MSU5LKSB7CkBAIC0yMzM1LDYgKzIzNDAsNyBAQCB2b2lk
IGlzb19yZWN2KHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTE2
IGZsYWdzKQogCiBzdGF0aWMgc3RydWN0IGhjaV9jYiBpc29fY2IgPSB7CiAJLm5hbWUJCT0gIklT
TyIsCisJLm1hdGNoCQk9IGlzb19tYXRjaCwKIAkuY29ubmVjdF9jZm0JPSBpc29fY29ubmVjdF9j
Zm0sCiAJLmRpc2Nvbm5fY2ZtCT0gaXNvX2Rpc2Nvbm5fY2ZtLAogfTsKZGlmZiAtLWdpdCBhL25l
dC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIGIvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMKaW5k
ZXggNjU0NGMxZWQ3MTQzLi4yN2I0YzRhMmJhMWYgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgv
bDJjYXBfY29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jCkBAIC03MjE3LDYg
KzcyMTcsMTEgQEAgc3RhdGljIHN0cnVjdCBsMmNhcF9jaGFuICpsMmNhcF9nbG9iYWxfZml4ZWRf
Y2hhbihzdHJ1Y3QgbDJjYXBfY2hhbiAqYywKIAlyZXR1cm4gTlVMTDsKIH0KIAorc3RhdGljIGJv
b2wgbDJjYXBfbWF0Y2goc3RydWN0IGhjaV9jb25uICpoY29uKQoreworCXJldHVybiBoY29uLT50
eXBlID09IEFDTF9MSU5LIHx8IGhjb24tPnR5cGUgPT0gTEVfTElOSzsKK30KKwogc3RhdGljIHZv
aWQgbDJjYXBfY29ubmVjdF9jZm0oc3RydWN0IGhjaV9jb25uICpoY29uLCB1OCBzdGF0dXMpCiB7
CiAJc3RydWN0IGhjaV9kZXYgKmhkZXYgPSBoY29uLT5oZGV2OwpAQCAtNzIyNCw5ICs3MjI5LDYg
QEAgc3RhdGljIHZvaWQgbDJjYXBfY29ubmVjdF9jZm0oc3RydWN0IGhjaV9jb25uICpoY29uLCB1
OCBzdGF0dXMpCiAJc3RydWN0IGwyY2FwX2NoYW4gKnBjaGFuOwogCXU4IGRzdF90eXBlOwogCi0J
aWYgKGhjb24tPnR5cGUgIT0gQUNMX0xJTksgJiYgaGNvbi0+dHlwZSAhPSBMRV9MSU5LKQotCQly
ZXR1cm47Ci0KIAlCVF9EQkcoImhjb24gJXAgYmRhZGRyICVwTVIgc3RhdHVzICVkIiwgaGNvbiwg
Jmhjb24tPmRzdCwgc3RhdHVzKTsKIAogCWlmIChzdGF0dXMpIHsKQEAgLTcyOTEsOSArNzI5Myw2
IEBAIGludCBsMmNhcF9kaXNjb25uX2luZChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24pCiAKIHN0YXRp
YyB2b2lkIGwyY2FwX2Rpc2Nvbm5fY2ZtKHN0cnVjdCBoY2lfY29ubiAqaGNvbiwgdTggcmVhc29u
KQogewotCWlmIChoY29uLT50eXBlICE9IEFDTF9MSU5LICYmIGhjb24tPnR5cGUgIT0gTEVfTElO
SykKLQkJcmV0dXJuOwotCiAJQlRfREJHKCJoY29uICVwIHJlYXNvbiAlZCIsIGhjb24sIHJlYXNv
bik7CiAKIAlsMmNhcF9jb25uX2RlbChoY29uLCBidF90b19lcnJubyhyZWFzb24pKTsKQEAgLTc1
NzIsNiArNzU3MSw3IEBAIHZvaWQgbDJjYXBfcmVjdl9hY2xkYXRhKHN0cnVjdCBoY2lfY29ubiAq
aGNvbiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTE2IGZsYWdzKQogCiBzdGF0aWMgc3RydWN0IGhj
aV9jYiBsMmNhcF9jYiA9IHsKIAkubmFtZQkJPSAiTDJDQVAiLAorCS5tYXRjaAkJPSBsMmNhcF9t
YXRjaCwKIAkuY29ubmVjdF9jZm0JPSBsMmNhcF9jb25uZWN0X2NmbSwKIAkuZGlzY29ubl9jZm0J
PSBsMmNhcF9kaXNjb25uX2NmbSwKIAkuc2VjdXJpdHlfY2ZtCT0gbDJjYXBfc2VjdXJpdHlfY2Zt
LApkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jIGIvbmV0L2JsdWV0b290
aC9yZmNvbW0vY29yZS5jCmluZGV4IGFkNTE3N2UzYTY5Yi4uNGM1NmNhNWEyMTZjIDEwMDY0NAot
LS0gYS9uZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMKKysrIGIvbmV0L2JsdWV0b290aC9yZmNv
bW0vY29yZS5jCkBAIC0yMTM0LDYgKzIxMzQsMTEgQEAgc3RhdGljIGludCByZmNvbW1fcnVuKHZv
aWQgKnVudXNlZCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGJvb2wgcmZjb21tX21hdGNoKHN0
cnVjdCBoY2lfY29ubiAqaGNvbikKK3sKKwlyZXR1cm4gaGNvbi0+dHlwZSA9PSBBQ0xfTElOSzsK
K30KKwogc3RhdGljIHZvaWQgcmZjb21tX3NlY3VyaXR5X2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmNv
bm4sIHU4IHN0YXR1cywgdTggZW5jcnlwdCkKIHsKIAlzdHJ1Y3QgcmZjb21tX3Nlc3Npb24gKnM7
CkBAIC0yMTgwLDYgKzIxODUsNyBAQCBzdGF0aWMgdm9pZCByZmNvbW1fc2VjdXJpdHlfY2ZtKHN0
cnVjdCBoY2lfY29ubiAqY29ubiwgdTggc3RhdHVzLCB1OCBlbmNyeXB0KQogCiBzdGF0aWMgc3Ry
dWN0IGhjaV9jYiByZmNvbW1fY2IgPSB7CiAJLm5hbWUJCT0gIlJGQ09NTSIsCisJLm1hdGNoCQk9
IHJmY29tbV9tYXRjaCwKIAkuc2VjdXJpdHlfY2ZtCT0gcmZjb21tX3NlY3VyaXR5X2NmbQogfTsK
IApkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9zY28uYyBiL25ldC9ibHVldG9vdGgvc2NvLmMK
aW5kZXggN2ViOGQzZTA0ZWM0Li40MGM0OTU3Y2ZjMGIgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9v
dGgvc2NvLmMKKysrIGIvbmV0L2JsdWV0b290aC9zY28uYwpAQCAtMTM5NywxMSArMTM5NywxMyBA
QCBpbnQgc2NvX2Nvbm5lY3RfaW5kKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBiZGFkZHJfdCAqYmRh
ZGRyLCBfX3U4ICpmbGFncykKIAlyZXR1cm4gbG07CiB9CiAKK3N0YXRpYyBib29sIHNjb19tYXRj
aChzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24pCit7CisJcmV0dXJuIGhjb24tPnR5cGUgPT0gU0NPX0xJ
TksgfHwgaGNvbi0+dHlwZSA9PSBFU0NPX0xJTks7Cit9CisKIHN0YXRpYyB2b2lkIHNjb19jb25u
ZWN0X2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmhjb24sIF9fdTggc3RhdHVzKQogewotCWlmIChoY29u
LT50eXBlICE9IFNDT19MSU5LICYmIGhjb24tPnR5cGUgIT0gRVNDT19MSU5LKQotCQlyZXR1cm47
Ci0KIAlCVF9EQkcoImhjb24gJXAgYmRhZGRyICVwTVIgc3RhdHVzICV1IiwgaGNvbiwgJmhjb24t
PmRzdCwgc3RhdHVzKTsKIAogCWlmICghc3RhdHVzKSB7CkBAIC0xNDE2LDkgKzE0MTgsNiBAQCBz
dGF0aWMgdm9pZCBzY29fY29ubmVjdF9jZm0oc3RydWN0IGhjaV9jb25uICpoY29uLCBfX3U4IHN0
YXR1cykKIAogc3RhdGljIHZvaWQgc2NvX2Rpc2Nvbm5fY2ZtKHN0cnVjdCBoY2lfY29ubiAqaGNv
biwgX191OCByZWFzb24pCiB7Ci0JaWYgKGhjb24tPnR5cGUgIT0gU0NPX0xJTksgJiYgaGNvbi0+
dHlwZSAhPSBFU0NPX0xJTkspCi0JCXJldHVybjsKLQogCUJUX0RCRygiaGNvbiAlcCByZWFzb24g
JWQiLCBoY29uLCByZWFzb24pOwogCiAJc2NvX2Nvbm5fZGVsKGhjb24sIGJ0X3RvX2Vycm5vKHJl
YXNvbikpOwpAQCAtMTQ0NCw2ICsxNDQzLDcgQEAgdm9pZCBzY29fcmVjdl9zY29kYXRhKHN0cnVj
dCBoY2lfY29ubiAqaGNvbiwgc3RydWN0IHNrX2J1ZmYgKnNrYikKIAogc3RhdGljIHN0cnVjdCBo
Y2lfY2Igc2NvX2NiID0gewogCS5uYW1lCQk9ICJTQ08iLAorCS5tYXRjaAkJPSBzY29fbWF0Y2gs
CiAJLmNvbm5lY3RfY2ZtCT0gc2NvX2Nvbm5lY3RfY2ZtLAogCS5kaXNjb25uX2NmbQk9IHNjb19k
aXNjb25uX2NmbSwKIH07Ci0tIAoyLjQ3LjEKCg==
--000000000000e78b6606288755c1--
