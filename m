Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15773C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjF1TaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF1T3r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 15:29:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3841A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:29:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso3076881fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980584; x=1690572584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw6kjtzzkRHSJzkdUcF4cG0ZocXpt+tev7xLzXlAU00=;
        b=ez1l7uJwJVlqJyDthjfwZ4Eado+s4UI17kmBBcyV/jaRsDHOhH8KY+J0Dbjl1xCogq
         VQ09tpnmxeDpk/cCP9Xsw3RaVkzbt+f7hDhujBNfsWkbukqYupyO5EKauvoUXwG5l1G0
         VJKCYVmn5RGWoZ1zxgYp+zm0gKaqhLBw++JLWQ2SDVPPGdT3cP0CL/gEbKF/51Qb5OI9
         4WuJAX2aHCyWjzwl+dtgqlVfsJOHseFg4ca44qAcK04pErUZQUmi1oBc80fumxlF+8Hm
         PZwxJ/NmrIi9qN2xeW8fZI9iDsuZz+jJKQMx35qJda+xdqep1BsNmZ7LeMmitd3AxRxp
         MQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980584; x=1690572584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw6kjtzzkRHSJzkdUcF4cG0ZocXpt+tev7xLzXlAU00=;
        b=K40Kh+e38Ajy5yHentONZT23u+jtt9Wte82q2Ge3H42UaDYCftv94TdVYlnig+lz6h
         dahBSV8Cueg/elBJtDa+OqUK9O8GNPyOBLOvIg1m00EN2iJFjUjRedxIdbkaAhQ3rftR
         H9gaMbNOfQ5ZzXHXXqx8cSJn5cqMkVOfPvqJl8StTeMHhG4d/21K0WKMW+PRzxYr1ghA
         t/5+zhVBu8Q2NrF9Xf8y5GBYBZfgPsS2sgrN3cNHnTDbIZEJ0O3XgofzsZR1W39l3QKa
         tKoM3c3J6DfZK8I9/W4q/2XZc75jqs93vvk67Y/GoLkvS3m7h7gjex5mFwQIJH4dvCvK
         Ii+A==
X-Gm-Message-State: AC+VfDyi86Wv1ss3zU+Vgni2XE38Cxw0kxaCYT3cQTZ5D8byWWB8zeXp
        cFM9vO0HoN8PjukGOEMBCkPhkWvy7F5aPaV+0dUNHbKalZg=
X-Google-Smtp-Source: ACHHUZ6/2u4Zh3Ydy0J2vDro3FHhsGMWeKBgohCagsuLo5+BHZejTh9hwMbiqkAmOJtRclMWrM78LfWhksgfzz8ssYs=
X-Received: by 2002:a2e:9d0c:0:b0:2b5:8cfd:5223 with SMTP id
 t12-20020a2e9d0c000000b002b58cfd5223mr12679938lji.32.1687980583770; Wed, 28
 Jun 2023 12:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687525956.git.pav@iki.fi> <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
 <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com>
 <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi> <CABBYNZJ1dynMZoRFyAQ3PamECt05qECpre8dXnvJ=tBissL4Jw@mail.gmail.com>
 <100698fb78f60db29c8a180b6f5a2b1e62424568.camel@iki.fi>
In-Reply-To: <100698fb78f60db29c8a180b6f5a2b1e62424568.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jun 2023 12:29:31 -0700
Message-ID: <CABBYNZJAeokBYrgiEvO_T1Ps6bD7tC6nz9CdbHinkBBXnKFRMA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jun 28, 2023 at 9:24=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2023-06-27 kello 16:05 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Fri, Jun 23, 2023 at 3:21=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > pe, 2023-06-23 kello 12:39 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > On Fri, Jun 23, 2023 at 10:37=E2=80=AFAM Pauli Virtanen <pav@iki.fi=
> wrote:
> > > > >
> > > > > A delayed operation such as hci_sync on a given hci_conn needs to=
 take
> > > > > hci_conn_get, so that the hci_conn doesn't get freed in the meant=
ime.
> > > > > This does not guarantee the conn is still alive in a valid state,=
 as it
> > > > > may be cleaned up in the meantime, so one needs to check if it is=
 still
> > > > > in conn_hash to know if it's still alive.
> > > > >
> > > > > Simplify this alive check, using HCI_CONN_DELETED flag. This is a=
lso
> > > > > meaningful with RCU lock only, but with slightly different semant=
ics.
> > > > >
> > > > > If hci_conn_is_alive(conn) returns true inside rcu_read_lock, con=
n was
> > > > > in conn_hash from the point of view of the current task when the =
flag
> > > > > was read. Then its deletion cannot complete before rcu_read_unloc=
k.
> > > > >
> > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     This probably can be done with RCU primitives setting list.pr=
ev, but
> > > > >     that's maybe more magical...
> > > > >
> > > > >  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> > > > >  net/bluetooth/hci_conn.c         | 10 +---------
> > > > >  2 files changed, 19 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluet=
ooth/hci_core.h
> > > > > index 05a9b3ab3f56..cab39bdd0592 100644
> > > > > --- a/include/net/bluetooth/hci_core.h
> > > > > +++ b/include/net/bluetooth/hci_core.h
> > > > > @@ -978,6 +978,7 @@ enum {
> > > > >         HCI_CONN_PER_ADV,
> > > > >         HCI_CONN_BIG_CREATED,
> > > > >         HCI_CONN_CREATE_CIS,
> > > > > +       HCI_CONN_DELETED,
> > > > >  };
> > > > >
> > > > >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> > > > > @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct=
 hci_conn *conn)
> > > > >  static inline void hci_conn_hash_add(struct hci_dev *hdev, struc=
t hci_conn *c)
> > > > >  {
> > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
> > > > >         list_add_tail_rcu(&c->list, &h->list);
> > > > >         switch (c->type) {
> > > > >         case ACL_LINK:
> > > > > @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struc=
t hci_dev *hdev, struct hci_conn *c)
> > > > >  static inline void hci_conn_hash_del(struct hci_dev *hdev, struc=
t hci_conn *c)
> > > > >  {
> > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > +       bool deleted;
> > > > > +
> > > > > +       deleted =3D test_and_set_bit(HCI_CONN_DELETED, &c->flags)=
;
> > > > > +       WARN_ON(deleted);
> > > > >
> > > > >         list_del_rcu(&c->list);
> > > > >         synchronize_rcu();
> > > > > @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struc=
t hci_dev *hdev, struct hci_conn *c)
> > > > >         }
> > > > >  }
> > > > >
> > > > > +/* With hdev->lock: whether hci_conn is in conn_hash.
> > > > > + * With RCU: if true, the hci_conn is valid conn_hash iteration =
cursor and
> > > > > + * hci_conn_hash_del has not completed. (Note that if hci_conn w=
as obtained in
> > > > > + * this critical section it is always valid, but this may return=
 false!)
> > > > > + */
> > > > > +static inline bool hci_conn_is_alive(struct hci_dev *hdev, struc=
t hci_conn *c)
> > > > > +{
> > > > > +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read=
_lock_held(),
> > > > > +                        "suspicious locking");
> > > > > +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> > > > > +}
> > > >
> > > > I think we are better off doing something like
> > > > hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_zero=
,
> > > > that said we need to check if the hci_conn_drop can still set the r=
ef
> > > > below zero, anyway that is probably a bug in itself and we should
> > > > probably WARN_ON if that happens.
> > >
> > > The problem here is that we'd like to have both
> > >
> > > (1) to have hci_conn_del/cleanup delete the item from conn_hash
> > > immediately
> > >
> > > (2) be able to continue iteration from the conn we held, after
> > > releasing and reacquiring RCU or hdev->lock
> > >
> > > If conn is removed from the list, conn->list.next won't be updated an=
y
> > > more, so it is not safe to access after we have left the critical
> > > section. So it seems we'd need some marker on whether it is still in
> > > the list.
> > >
> > > Maybe (1) could be given up instead, something like: hci_conn_cleanup
> > > sets HCI_CONN_DELETED instead of deleting from the list if refcount i=
s
> > > positive, and lookup functions skip items with this flag.
> > >
> > > Something along these lines could work, need to think a bit.
> >
> > Ive end up reworking this logic to use something similar to what
> > mgmt.c was doing:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20230627225915.267=
4812-1-luiz.dentz@gmail.com/
> >
> > That way we just cancel by handle and don't have to make reference
> > left and right, we just lookup by handle if the connection is still
> > there when the work is scheduled we abort otherwise we don't have to
> > do anything.
>
> Does this still rely on the conn not being freed concurrently, maybe to
> be totally sure holding rcu_read_lock/hdev->lock or having refcount
> would be needed around the lookup and *conn access?
>
> Unless there is something else guaranteeing the call sites of
> hci_conn_del cannot occur at the same time?
>
> IIUC, hci_conn_del is called also from several other places that may
> run concurrently if you don't lock, eg. in hci_event.c (seems to run in
> different workqueue than hci_sync), and I guess controller could
> trigger eg. HCI_Disconnection_Complete spontaneously.
>
> I'm not sure if these can be serialized behind hci_sync, if a handle is
> disconnected it probably needs to do some teardown immediately like
> unregistering it from sysfs, so that the same handle value can be
> reused.
>
> This is also problem for using conn->refcnt for keeping it alive: it
> seems we want to do partial cleanup anyway even if someone is holding
> the conn, so it would in the end to boil down to same as hci_conn_get.
> (Having hci_conn_get keep items in list would simplify iteration, but
> other parts seem to become more complex so what was in this RFC is
> maybe simplest in that direction.)

The idea here is that lookup by handle shall always be safe since if
hci_conn_del has already been called the conn shall no longer be in
the hash, now perhaps what you are afraid is that hci_conn_del is not
safe to be called concurrently, which is probably correct, so perhaps
we need a flag or something to check that HCI_CONN_DEL is in progress.

> >
> > > > >  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __=
u8 type)
> > > > >  {
> > > > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > > index 62a7ccfdfe63..d489a4829be7 100644
> > > > > --- a/net/bluetooth/hci_conn.c
> > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_str=
uct *work)
> > > > >         struct hci_conn *conn =3D container_of(work, struct hci_c=
onn,
> > > > >                                              le_scan_cleanup);
> > > > >         struct hci_dev *hdev =3D conn->hdev;
> > > > > -       struct hci_conn *c =3D NULL;
> > > > >
> > > > >         BT_DBG("%s hcon %p", hdev->name, conn);
> > > > >
> > > > >         hci_dev_lock(hdev);
> > > > >
> > > > >         /* Check that the hci_conn is still around */
> > > > > -       rcu_read_lock();
> > > > > -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > > > > -               if (c =3D=3D conn)
> > > > > -                       break;
> > > > > -       }
> > > > > -       rcu_read_unlock();
> > > > > -
> > > > > -       if (c =3D=3D conn) {
> > > > > +       if (hci_conn_is_alive(hdev, conn)) {
> > > >
> > > > Hmm, I don't think this is safe, except if we are doing hci_conn_ge=
t
> > > > we can't really access the conn pointer since it may be freed alrea=
dy,
> > > > anyway this is sort of broken already given that we do access
> > > > conn->hdev already.
> > >
> > > hci_conn_get is held here, there's a hci_conn_put at the end of this
> > > function.
> > >
> > > >
> > > > >                 hci_connect_le_scan_cleanup(conn, 0x00);
> > > > >                 hci_conn_cleanup(conn);
> > > > >         }
> > > > > --
> > > > > 2.41.0
> > > > >
> > > >
> > > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
