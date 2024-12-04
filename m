Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796342AA3
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286713; cv=none; b=RiDGyQ4cIsuobTQNcUCf/0+QQKqcSubp2KPjkU3Pk6UTOpu9BgsDffigrxbNmQuaKCvzPoZOoF6mCcGq9ga54XtFfHLvc5Vnc3u7kyVq8RDsrjuMxdhxHohAkUp/eaj3fu9WFjEsNGig8lOffCzhJoEGT2d7mEZkkHOANOB5MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286713; c=relaxed/simple;
	bh=hNWhclPgUQd8xw/js6K6aBYFeqyAgw4iZInE7NJKJsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGr2oJrsWgPttJwYPlEyyAeXo8FaS3M+01TFTo4dRkOOOba5iGVLv+P0N6qxCszU0nPl5NxFb8T3VzU2f/qg1cELveHhDjwKyO/fIMD6LMqMDkq4MgF0K5VlQKU4OWdjXf8MjeY5e0qfXgWys7U9FI/POBROaCPiaywq2S4/JSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCmqWIAj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCmqWIAj"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso80399951fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2024 20:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733286710; x=1733891510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVRsjKfsqYzzdbmYoHobOjbUGfW29cS5qxrdV8v7xzg=;
        b=CCmqWIAj+5V9EBhrzMAolmYkDAqe8GdtopMFwgQtANkMCjVgj8lsbPlZ5J23G8CBw6
         xxqgV/yZ5nIlkpv+u7EDj+B2SIjfrNh9+f0XB4k6A6s6apw8n5MApFOFRgeAIS23L1iz
         EUdag14FehV3IwaRQ4W+25G+61wFQAcJcH9oL9bsBv3Ji+xuVzLV5qLpsLbUNNQvfL2I
         P4ojP5ge1QoEhZ0VdCF6ttiSWUJxJL1eNy8bcDW/1hW/PFkOF5gls6jd9rxBvHIzdWWH
         +BxSsXUWueuvqY1pxo7O8n9u7hlE9KdcVZZdfDLJ/H9Vg56BB2yJAyj4/YRlRusImy2v
         Lvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733286710; x=1733891510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVRsjKfsqYzzdbmYoHobOjbUGfW29cS5qxrdV8v7xzg=;
        b=cHQet3AUdIm3yXw8Z8g6KfXmAP87qXv8RRj8kTFtKNA6mAHBoD8S0l0eSB7RSrjLfD
         PbJjqRtaOAH4TgqfswdUotI/wfkbJgKp10Z5/NXI97Tzm+G61iEPC1vXC+XbMVv6oqwj
         bNFPXgCmKUYYHiykX2wSdoBo6AtutrEXCEgbKX9d3Pw0Jti8zUVDq1kNfejdkq8QL+/W
         ch0n+BvB8ey8vYoPz5YPvx0OLyEJIDzwIPT+GbI0BbhmOq9CnZjJe4QNGJNkukozK8oP
         qtK3Y4wF3anQdrulXFHDT+seyBS3GqHZHF4G5ZqZ6Mxmjj+QAGOqdzkkSFCZvNdrddWo
         8hqg==
X-Gm-Message-State: AOJu0Yxph4EBTASJTNHfBu1xip+tVAaFVqMyMIe1t8m/aBaig/8A3bb6
	tyc//ofuFChuajkAiLuA0f1dyVkw9OjUtnxY+VniBl9AJjn9N3k3VSPdZnMsQzBtyg5MgMjlFkC
	UT5C8DPVfKAn1mT5vPHxJIzhDslQ=
X-Gm-Gg: ASbGncsBexbNBZw5XHe5uqDQuJVxU2alEN5Z/Kv4NSNzo91XrM74qj9pUgpwUp2eYyr
	E47l6xN7a8P+lReHtoXLaLur394NMgS2V
X-Google-Smtp-Source: AGHT+IEt/TSDoatfVZuPr/PjeK9/dohucFInzS1gxpDTsjZr9sls3pYkYlJwgeiX6CQ3WW5U/L6s2lpvtuW/Wjl5jnI=
X-Received: by 2002:a2e:80c7:0:b0:300:1889:633a with SMTP id
 38308e7fff4ca-300188965ffmr1398421fa.4.1733286709510; Tue, 03 Dec 2024
 20:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203211435.194301-1-luiz.dentz@gmail.com> <0b897a445022f99bb812c811135fdbc8bf73bbba.camel@iki.fi>
In-Reply-To: <0b897a445022f99bb812c811135fdbc8bf73bbba.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Dec 2024 23:31:37 -0500
Message-ID: <CABBYNZ+KcZ13SF2yksP3su2kY4sSCJgiF_o0OfrXTomFigmKbQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called from
 invalid context
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Dec 3, 2024 at 5:48=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2024-12-03 kello 16:14 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bug=
s
> > like the bellow:
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
> >  include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
> >  net/bluetooth/hci_core.c         |  9 ++--
> >  2 files changed, 65 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index ea798f07c5a2..95f11f04e24a 100644
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
> > @@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_c=
onn *conn, __u8 status)
> >  {
> >       struct hci_cb *cb;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->connect_cfm)
> > -                     cb->connect_cfm(conn, status);
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> > +             if (cb->connect_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.connect_cfm(conn, status);
> > +                     rcu_read_lock();
>
> This looks like incorrect RCU usage
>
> [CPU 1] rcu_read_unlock()
> [CPU 2] hci_unregister_cb(cb)
> [CPU 2] hci_unregister_cb(next cb)
> [CPU 1] rcu_read_lock()
> [CPU 1] list_for_each_entry_rcu -> iterates to "next cb" not in list
>
> If all hci_cb weren't static, it'd also UAF (maybe it is for rfcomm?).
>
>
> hci_le_create_big_complete_evt() also does this (and maybe crashes if
> ev->status !=3D 0 ?), so maybe it is simples to fix it.

I guess you are right, it seems incorrect to have
rcu_read_unlock/relock inside list_for_each_entry_rcu, that said I
wonder why the entry is not accessed via rcu_dereference, anyway the
only alternative I can think of is to copy to a local stack list which
we can then run with list_for_each_entry_safe, or we create some
mechanism to differ actions that otherwise could block/sleep while
holding rcu_read_lock.

>
>
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
> >
> >       if (conn->connect_cfm_cb)
> >               conn->connect_cfm_cb(conn, status);
> > @@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_c=
onn *conn, __u8 reason)
> >  {
> >       struct hci_cb *cb;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > +     rcu_read_lock();
> >       list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->disconn_cfm)
> > -                     cb->disconn_cfm(conn, reason);
> > +             if (cb->disconn_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.disconn_cfm(conn, reason);
> > +                     rcu_read_lock();
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
> >
> >       if (conn->disconn_cfm_cb)
> >               conn->disconn_cfm_cb(conn, reason);
> > @@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn=
 *conn, __u8 status)
> >
> >       encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x0=
0;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > +     rcu_read_lock();
> >       list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->security_cfm)
> > -                     cb->security_cfm(conn, status, encrypt);
> > +             if (cb->security_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.security_cfm(conn, status, encrypt);
> > +                     rcu_read_lock();
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
> >
> >       if (conn->security_cfm_cb)
> >               conn->security_cfm_cb(conn, status);
> > @@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_c=
onn *conn, __u8 status)
> >                       conn->sec_level =3D conn->pending_sec_level;
> >       }
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > +     rcu_read_lock();
> >       list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->security_cfm)
> > -                     cb->security_cfm(conn, status, encrypt);
> > +             if (cb->security_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.security_cfm(conn, status, encrypt);
> > +                     rcu_read_lock();
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
> >
> >       if (conn->security_cfm_cb)
> >               conn->security_cfm_cb(conn, status);
> > @@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hc=
i_conn *conn, __u8 status)
> >  {
> >       struct hci_cb *cb;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > +     rcu_read_lock();
> >       list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->key_change_cfm)
> > -                     cb->key_change_cfm(conn, status);
> > +             if (cb->key_change_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.key_change_cfm(conn, status);
> > +                     rcu_read_lock();
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
> >  }
> >
> >  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 sta=
tus,
> > @@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct h=
ci_conn *conn, __u8 status,
> >  {
> >       struct hci_cb *cb;
> >
> > -     mutex_lock(&hci_cb_list_lock);
> > -     list_for_each_entry(cb, &hci_cb_list, list) {
> > -             if (cb->role_switch_cfm)
> > -                     cb->role_switch_cfm(conn, status, role);
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> > +             if (cb->role_switch_cfm) {
> > +                     struct hci_cb cpy =3D *cb;
> > +
> > +                     /* Callback may block so release RCU read lock */
> > +                     rcu_read_unlock();
> > +                     cpy.role_switch_cfm(conn, status, role);
> > +                     rcu_read_lock();
> > +             }
> >       }
> > -     mutex_unlock(&hci_cb_list_lock);
> > +     rcu_read_unlock();
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
>


--=20
Luiz Augusto von Dentz
