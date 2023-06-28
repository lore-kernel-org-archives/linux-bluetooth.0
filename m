Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EAEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjF1VW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjF1VWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 17:22:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DA3AA1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 14:18:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a152a933so4511571fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687987087; x=1690579087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo3tcvUgVDQm7lZcRHa+ixaZ6t4zExFDoVbDjcIeelw=;
        b=d1JTnEz4CK/m7rFXVniAnhedG3i4OSOeTDCx1Jr82rolusVhd6AZhcPBmrPWE12/ZW
         9ATrAp3Of9Fs993dz92PyahmESFB+pJdMKTYJ1BFUU0+MnLnpRT7rDRCxQT+i2CnQJZj
         nXK6ne3/gd5MZ6U/M6vYlSsgAF3chrC0tS++ifsFriezwjuxjsX2ZUUdYXOY8S1YBqhw
         N36Um1Wko5vrlczMRH6WTtxB+s0hk9BqyhkC5F2wY0qwX3pzmNTJdECKwqw/ehkA/ja+
         yISRFhHxklzzMksBSyEkfVTz2n2uYuWYuqlDYUUpjdRIvHMRdV5aFZEjfkH+BTxSYpn9
         G7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987087; x=1690579087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo3tcvUgVDQm7lZcRHa+ixaZ6t4zExFDoVbDjcIeelw=;
        b=ldavMxl3M5u7X82AG6B1gHcYhiEh+qtmnIeExWJkWbH4qq9lo0QiB/8I+7bb1KOdnQ
         WxNy6DulD6e6iNy02zUmk/ObQ1Y2/TzKeaTl7lGZvERm70awjZME04SSGdc6FlkUcsXU
         n4n/MGrPodYKfbxAiqxcvcwT1T7JJjF0DM7vIdjMaQutUU8Xq+fDYO5W/4ZuVUlBg6+/
         z2lnu5esJnubJwWRKmaF8ZWxrH6B7+ymH8I1SV+bRI+pCmQnB16Q+F7+JG3fhPFrfU9f
         46ho7lNof5MHK1sQaWuCOEDC4onrOP4MtKTNAD2qWRE3d7evsf+eNM9DO2gd3ydzeexL
         zmPw==
X-Gm-Message-State: AC+VfDywdNO0vi6dqGv7uScwyLjoryhnbvqLVCUs4Wx3nGHw5y4SJ+Qo
        imPaolofa9dqxQcr5Jstkw0RO7jbYZofinrkhPo=
X-Google-Smtp-Source: ACHHUZ5049kTrs6QSOzDY+0RsZxSBX3LE3Ty3kgJxEHJE578fZPcB5i/qTLKvEkVAThF7pTEALATTFLJNCmEGFD2urM=
X-Received: by 2002:a2e:b0d4:0:b0:2b6:3652:87d with SMTP id
 g20-20020a2eb0d4000000b002b63652087dmr9300917ljl.43.1687987086803; Wed, 28
 Jun 2023 14:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687525956.git.pav@iki.fi> <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
 <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
 <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi> <CABBYNZJ1dynMZoRFyAQ3PamECt05qECpre8dXnvJ=tBissL4Jw@mail.gmail.com>
 <100698fb78f60db29c8a180b6f5a2b1e62424568.camel@iki.fi> <CABBYNZJAeokBYrgiEvO_T1Ps6bD7tC6nz9CdbHinkBBXnKFRMA@mail.gmail.com>
 <d2c6d4487e447e450c1fb282e988e3facc6562ca.camel@iki.fi>
In-Reply-To: <d2c6d4487e447e450c1fb282e988e3facc6562ca.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jun 2023 14:17:53 -0700
Message-ID: <CABBYNZLYfEZshBE9LvaUs-5gPY49qev2DVXuNW7jtG0b29v5fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jun 28, 2023 at 1:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ke, 2023-06-28 kello 12:29 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Jun 28, 2023 at 9:24=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > ti, 2023-06-27 kello 16:05 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > Hi Pauli,
> > > >
> > > > On Fri, Jun 23, 2023 at 3:21=E2=80=AFPM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > pe, 2023-06-23 kello 12:39 -0700, Luiz Augusto von Dentz kirjoitt=
i:
> > > > > > On Fri, Jun 23, 2023 at 10:37=E2=80=AFAM Pauli Virtanen <pav@ik=
i.fi> wrote:
> > > > > > >
> > > > > > > A delayed operation such as hci_sync on a given hci_conn need=
s to take
> > > > > > > hci_conn_get, so that the hci_conn doesn't get freed in the m=
eantime.
> > > > > > > This does not guarantee the conn is still alive in a valid st=
ate, as it
> > > > > > > may be cleaned up in the meantime, so one needs to check if i=
t is still
> > > > > > > in conn_hash to know if it's still alive.
> > > > > > >
> > > > > > > Simplify this alive check, using HCI_CONN_DELETED flag. This =
is also
> > > > > > > meaningful with RCU lock only, but with slightly different se=
mantics.
> > > > > > >
> > > > > > > If hci_conn_is_alive(conn) returns true inside rcu_read_lock,=
 conn was
> > > > > > > in conn_hash from the point of view of the current task when =
the flag
> > > > > > > was read. Then its deletion cannot complete before rcu_read_u=
nlock.
> > > > > > >
> > > > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     This probably can be done with RCU primitives setting lis=
t.prev, but
> > > > > > >     that's maybe more magical...
> > > > > > >
> > > > > > >  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> > > > > > >  net/bluetooth/hci_conn.c         | 10 +---------
> > > > > > >  2 files changed, 19 insertions(+), 9 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/b=
luetooth/hci_core.h
> > > > > > > index 05a9b3ab3f56..cab39bdd0592 100644
> > > > > > > --- a/include/net/bluetooth/hci_core.h
> > > > > > > +++ b/include/net/bluetooth/hci_core.h
> > > > > > > @@ -978,6 +978,7 @@ enum {
> > > > > > >         HCI_CONN_PER_ADV,
> > > > > > >         HCI_CONN_BIG_CREATED,
> > > > > > >         HCI_CONN_CREATE_CIS,
> > > > > > > +       HCI_CONN_DELETED,
> > > > > > >  };
> > > > > > >
> > > > > > >  static inline bool hci_conn_ssp_enabled(struct hci_conn *con=
n)
> > > > > > > @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(st=
ruct hci_conn *conn)
> > > > > > >  static inline void hci_conn_hash_add(struct hci_dev *hdev, s=
truct hci_conn *c)
> > > > > > >  {
> > > > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > > > +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
> > > > > > >         list_add_tail_rcu(&c->list, &h->list);
> > > > > > >         switch (c->type) {
> > > > > > >         case ACL_LINK:
> > > > > > > @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(s=
truct hci_dev *hdev, struct hci_conn *c)
> > > > > > >  static inline void hci_conn_hash_del(struct hci_dev *hdev, s=
truct hci_conn *c)
> > > > > > >  {
> > > > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > > > +       bool deleted;
> > > > > > > +
> > > > > > > +       deleted =3D test_and_set_bit(HCI_CONN_DELETED, &c->fl=
ags);
> > > > > > > +       WARN_ON(deleted);
> > > > > > >
> > > > > > >         list_del_rcu(&c->list);
> > > > > > >         synchronize_rcu();
> > > > > > > @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(s=
truct hci_dev *hdev, struct hci_conn *c)
> > > > > > >         }
> > > > > > >  }
> > > > > > >
> > > > > > > +/* With hdev->lock: whether hci_conn is in conn_hash.
> > > > > > > + * With RCU: if true, the hci_conn is valid conn_hash iterat=
ion cursor and
> > > > > > > + * hci_conn_hash_del has not completed. (Note that if hci_co=
nn was obtained in
> > > > > > > + * this critical section it is always valid, but this may re=
turn false!)
> > > > > > > + */
> > > > > > > +static inline bool hci_conn_is_alive(struct hci_dev *hdev, s=
truct hci_conn *c)
> > > > > > > +{
> > > > > > > +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_=
read_lock_held(),
> > > > > > > +                        "suspicious locking");
> > > > > > > +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> > > > > > > +}
> > > > > >
> > > > > > I think we are better off doing something like
> > > > > > hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_=
zero,
> > > > > > that said we need to check if the hci_conn_drop can still set t=
he ref
> > > > > > below zero, anyway that is probably a bug in itself and we shou=
ld
> > > > > > probably WARN_ON if that happens.
> > > > >
> > > > > The problem here is that we'd like to have both
> > > > >
> > > > > (1) to have hci_conn_del/cleanup delete the item from conn_hash
> > > > > immediately
> > > > >
> > > > > (2) be able to continue iteration from the conn we held, after
> > > > > releasing and reacquiring RCU or hdev->lock
> > > > >
> > > > > If conn is removed from the list, conn->list.next won't be update=
d any
> > > > > more, so it is not safe to access after we have left the critical
> > > > > section. So it seems we'd need some marker on whether it is still=
 in
> > > > > the list.
> > > > >
> > > > > Maybe (1) could be given up instead, something like: hci_conn_cle=
anup
> > > > > sets HCI_CONN_DELETED instead of deleting from the list if refcou=
nt is
> > > > > positive, and lookup functions skip items with this flag.
> > > > >
> > > > > Something along these lines could work, need to think a bit.
> > > >
> > > > Ive end up reworking this logic to use something similar to what
> > > > mgmt.c was doing:
> > > >
> > > > https://patchwork.kernel.org/project/bluetooth/patch/20230627225915=
.2674812-1-luiz.dentz@gmail.com/
> > > >
> > > > That way we just cancel by handle and don't have to make reference
> > > > left and right, we just lookup by handle if the connection is still
> > > > there when the work is scheduled we abort otherwise we don't have t=
o
> > > > do anything.
> > >
> > > Does this still rely on the conn not being freed concurrently, maybe =
to
> > > be totally sure holding rcu_read_lock/hdev->lock or having refcount
> > > would be needed around the lookup and *conn access?
> > >
> > > Unless there is something else guaranteeing the call sites of
> > > hci_conn_del cannot occur at the same time?
> > >
> > > IIUC, hci_conn_del is called also from several other places that may
> > > run concurrently if you don't lock, eg. in hci_event.c (seems to run =
in
> > > different workqueue than hci_sync), and I guess controller could
> > > trigger eg. HCI_Disconnection_Complete spontaneously.
> > >
> > > I'm not sure if these can be serialized behind hci_sync, if a handle =
is
> > > disconnected it probably needs to do some teardown immediately like
> > > unregistering it from sysfs, so that the same handle value can be
> > > reused.
> > >
> > > This is also problem for using conn->refcnt for keeping it alive: it
> > > seems we want to do partial cleanup anyway even if someone is holding
> > > the conn, so it would in the end to boil down to same as hci_conn_get=
.
> > > (Having hci_conn_get keep items in list would simplify iteration, but
> > > other parts seem to become more complex so what was in this RFC is
> > > maybe simplest in that direction.)
> >
> > The idea here is that lookup by handle shall always be safe since if
> > hci_conn_del has already been called the conn shall no longer be in
> > the hash, now perhaps what you are afraid is that hci_conn_del is not
> > safe to be called concurrently, which is probably correct, so perhaps
> > we need a flag or something to check that HCI_CONN_DEL is in progress.
>
> For clarification, I mean here that constructs like
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (!conn)
>                 return 0;
>         do_something(conn);
>
> might not be safe if e.g. hci_event.c is doing hci_conn_del on another
> CPU at the same time (it appears to be in hdev->workqueue, cmd_sync in
> req_workqueue so I'm not sure they are serialized), and frees conn
> after hci_conn_hash_lookup_handle exits the critical section,
> before/during do_something runs. Something like
>
>         rcu_read_lock();
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (conn)
>                 handle =3D conn->handle;
>         rcu_read_unlock();
>         if (!conn)
>                 return 0;
>         do_something(handle)

Perhaps we need some tests that cover these scenarios, for the most
part all commands shall be serialized, so if the cmd_sync is doing
hci_conn_del while the receive/event work is doing it as well then we
have a bug in the code path. Btw, hci_conn_hash_lookup_handle does
rcu_read_lock already.

> could avoid that, or holding hdev->lock (IIUC in hci_sync callbacks it
> is not automatically held).
>
> Or, maybe there is some other guarantee that can be assumed here, and
> I'm missing something about how the locking/scheduling works here
> (don't know this well enough).
>
> The other comment was about if
>
>         hci_cmd_sync_cancel(hdev, -ECANCELED);
>
> could cancel the wrong command. Note conn->state is set to BT_CONNECT
> in hci_connect_le, before hci_connect_le_sync sends its command, so if
> there was already another command in the hci_sync queue belonging to a
> different connection, it seems hci_cmd_sync_cancel might here cancel
> the wrong one.

Right, Im planning to introduce the following changes:

https://gist.github.com/Vudentz/1dd1525980c200bf9617ae002e0eb1ea

> >
> > > >
> > > > > > >  static inline unsigned int hci_conn_num(struct hci_dev *hdev=
, __u8 type)
> > > > > > >  {
> > > > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_con=
n.c
> > > > > > > index 62a7ccfdfe63..d489a4829be7 100644
> > > > > > > --- a/net/bluetooth/hci_conn.c
> > > > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > > > @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work=
_struct *work)
> > > > > > >         struct hci_conn *conn =3D container_of(work, struct h=
ci_conn,
> > > > > > >                                              le_scan_cleanup)=
;
> > > > > > >         struct hci_dev *hdev =3D conn->hdev;
> > > > > > > -       struct hci_conn *c =3D NULL;
> > > > > > >
> > > > > > >         BT_DBG("%s hcon %p", hdev->name, conn);
> > > > > > >
> > > > > > >         hci_dev_lock(hdev);
> > > > > > >
> > > > > > >         /* Check that the hci_conn is still around */
> > > > > > > -       rcu_read_lock();
> > > > > > > -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, lis=
t) {
> > > > > > > -               if (c =3D=3D conn)
> > > > > > > -                       break;
> > > > > > > -       }
> > > > > > > -       rcu_read_unlock();
> > > > > > > -
> > > > > > > -       if (c =3D=3D conn) {
> > > > > > > +       if (hci_conn_is_alive(hdev, conn)) {
> > > > > >
> > > > > > Hmm, I don't think this is safe, except if we are doing hci_con=
n_get
> > > > > > we can't really access the conn pointer since it may be freed a=
lready,
> > > > > > anyway this is sort of broken already given that we do access
> > > > > > conn->hdev already.
> > > > >
> > > > > hci_conn_get is held here, there's a hci_conn_put at the end of t=
his
> > > > > function.
> > > > >
> > > > > >
> > > > > > >                 hci_connect_le_scan_cleanup(conn, 0x00);
> > > > > > >                 hci_conn_cleanup(conn);
> > > > > > >         }
> > > > > > > --
> > > > > > > 2.41.0
> > > > > > >
> > > > > >
> > > > > >
> > > > >
> > > >
> > > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
