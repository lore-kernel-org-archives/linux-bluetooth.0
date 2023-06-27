Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C781EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 23:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjF0XFj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0XFh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 19:05:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFF296D
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:05:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso55099111fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687907134; x=1690499134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTZ26WcACaw0GzEPu+ZwuOuXZEphvyPlAFHWgUn/z8E=;
        b=G8hxGxM4PLb/nitU123HMYXKfkUBkDOPtjQX2bLnsWszdSmrvzkvUiVRq+cqK6NR7Y
         LaWj6JXhD7UJ/p5I8tIBaa4kF9qMqtIVnfKeh8TJQnOhBK90/J8fWFItvNbRopIfVIjB
         DtxWsiFXHx+b1a5LFdfxeQoZklHtY11H9AMg1k4dBqEdcNwlaeK8pHPcVhQRnVtLpMl9
         KmkCJJivQI4qeLZXWBbeKifj5eDjAetu9i5iGtB7YuUxVFF3s0LEkAi3E6qcz4eBojOw
         APLlgvqhplbReeTZjI0E3TOj9QszwHOFH+Kb9C2LJbPY0TTJ/prP/7bbAkyb7PR9NfG1
         7L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687907134; x=1690499134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTZ26WcACaw0GzEPu+ZwuOuXZEphvyPlAFHWgUn/z8E=;
        b=Pz5Z7bZ6VQVvVODIdP9IXEnHqz4v7sCyW62z1mUxCgE+KFuJM8oyN/YpjhPaRHsKIj
         zHqZSAuIOVMDpgkHd1KBHpswhnGaN2RJ8cdhYwFs0eaUwy+TVC73BgpyQ8X6Z6y2Bj4n
         cG5rgX3NJRrrrfURTbcMgpdcGUHARxRFqgNK1U9EMk1F9y5VDLdUNBmQaEjRns/+SbGs
         jSpODfG0R1t6VaI0lTLYlmfjeMTokqo1+HvHGy7GBJNjbOHcSxWpxgme1gIoJaJaT0Ae
         6s1VgHCoIIWlgXwhGF16LINLBIbmAOtkTMOAKjpEodQ9FLw7UMTG9bacx2JvZPrOCotz
         ki0A==
X-Gm-Message-State: AC+VfDw1CciZUw5lNLo8yHP2OCtZBwxOpqg0rjuyaXeR+4tgQUGGqrYh
        5a5qs5C4EEqXmLamJU66mjK6fIILCgQ8tXHiWtQyu571T1q7Dw==
X-Google-Smtp-Source: ACHHUZ7n/RLCon0pc3SdYGknfwjOtbiZvc1z1HDHyNgGshgJpLLru6zwjA32GebdU2r5eketoDoXCGA7+62lpuQmBbg=
X-Received: by 2002:a2e:a314:0:b0:2b6:b2bf:ab4d with SMTP id
 l20-20020a2ea314000000b002b6b2bfab4dmr2308111lje.14.1687907133526; Tue, 27
 Jun 2023 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687525956.git.pav@iki.fi> <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
 <CABBYNZK_3aOVYgf6LiFXvkdGbju2UgU4WuEKRSrpuTdwv=BbFg@mail.gmail.com> <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi>
In-Reply-To: <5930c316c248f6326bd47078ebbc289798c249ce.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jun 2023 16:05:21 -0700
Message-ID: <CABBYNZJ1dynMZoRFyAQ3PamECt05qECpre8dXnvJ=tBissL4Jw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Jun 23, 2023 at 3:21=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> pe, 2023-06-23 kello 12:39 -0700, Luiz Augusto von Dentz kirjoitti:
> > On Fri, Jun 23, 2023 at 10:37=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wr=
ote:
> > >
> > > A delayed operation such as hci_sync on a given hci_conn needs to tak=
e
> > > hci_conn_get, so that the hci_conn doesn't get freed in the meantime.
> > > This does not guarantee the conn is still alive in a valid state, as =
it
> > > may be cleaned up in the meantime, so one needs to check if it is sti=
ll
> > > in conn_hash to know if it's still alive.
> > >
> > > Simplify this alive check, using HCI_CONN_DELETED flag. This is also
> > > meaningful with RCU lock only, but with slightly different semantics.
> > >
> > > If hci_conn_is_alive(conn) returns true inside rcu_read_lock, conn wa=
s
> > > in conn_hash from the point of view of the current task when the flag
> > > was read. Then its deletion cannot complete before rcu_read_unlock.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >     This probably can be done with RCU primitives setting list.prev, =
but
> > >     that's maybe more magical...
> > >
> > >  include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
> > >  net/bluetooth/hci_conn.c         | 10 +---------
> > >  2 files changed, 19 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index 05a9b3ab3f56..cab39bdd0592 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -978,6 +978,7 @@ enum {
> > >         HCI_CONN_PER_ADV,
> > >         HCI_CONN_BIG_CREATED,
> > >         HCI_CONN_CREATE_CIS,
> > > +       HCI_CONN_DELETED,
> > >  };
> > >
> > >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> > > @@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct hci=
_conn *conn)
> > >  static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hc=
i_conn *c)
> > >  {
> > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > +       WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
> > >         list_add_tail_rcu(&c->list, &h->list);
> > >         switch (c->type) {
> > >         case ACL_LINK:
> > > @@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struct hc=
i_dev *hdev, struct hci_conn *c)
> > >  static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hc=
i_conn *c)
> > >  {
> > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > +       bool deleted;
> > > +
> > > +       deleted =3D test_and_set_bit(HCI_CONN_DELETED, &c->flags);
> > > +       WARN_ON(deleted);
> > >
> > >         list_del_rcu(&c->list);
> > >         synchronize_rcu();
> > > @@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struct hc=
i_dev *hdev, struct hci_conn *c)
> > >         }
> > >  }
> > >
> > > +/* With hdev->lock: whether hci_conn is in conn_hash.
> > > + * With RCU: if true, the hci_conn is valid conn_hash iteration curs=
or and
> > > + * hci_conn_hash_del has not completed. (Note that if hci_conn was o=
btained in
> > > + * this critical section it is always valid, but this may return fal=
se!)
> > > + */
> > > +static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hc=
i_conn *c)
> > > +{
> > > +       RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read_loc=
k_held(),
> > > +                        "suspicious locking");
> > > +       return !test_bit(HCI_CONN_DELETED, &c->flags);
> > > +}
> >
> > I think we are better off doing something like
> > hci_conn_hold_unless_zero like we do in l2cap_chan_hold_unless_zero,
> > that said we need to check if the hci_conn_drop can still set the ref
> > below zero, anyway that is probably a bug in itself and we should
> > probably WARN_ON if that happens.
>
> The problem here is that we'd like to have both
>
> (1) to have hci_conn_del/cleanup delete the item from conn_hash
> immediately
>
> (2) be able to continue iteration from the conn we held, after
> releasing and reacquiring RCU or hdev->lock
>
> If conn is removed from the list, conn->list.next won't be updated any
> more, so it is not safe to access after we have left the critical
> section. So it seems we'd need some marker on whether it is still in
> the list.
>
> Maybe (1) could be given up instead, something like: hci_conn_cleanup
> sets HCI_CONN_DELETED instead of deleting from the list if refcount is
> positive, and lookup functions skip items with this flag.
>
> Something along these lines could work, need to think a bit.

Ive end up reworking this logic to use something similar to what
mgmt.c was doing:

https://patchwork.kernel.org/project/bluetooth/patch/20230627225915.2674812=
-1-luiz.dentz@gmail.com/

That way we just cancel by handle and don't have to make reference
left and right, we just lookup by handle if the connection is still
there when the work is scheduled we abort otherwise we don't have to
do anything.

> > >  static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 t=
ype)
> > >  {
> > >         struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index 62a7ccfdfe63..d489a4829be7 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_struct =
*work)
> > >         struct hci_conn *conn =3D container_of(work, struct hci_conn,
> > >                                              le_scan_cleanup);
> > >         struct hci_dev *hdev =3D conn->hdev;
> > > -       struct hci_conn *c =3D NULL;
> > >
> > >         BT_DBG("%s hcon %p", hdev->name, conn);
> > >
> > >         hci_dev_lock(hdev);
> > >
> > >         /* Check that the hci_conn is still around */
> > > -       rcu_read_lock();
> > > -       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > > -               if (c =3D=3D conn)
> > > -                       break;
> > > -       }
> > > -       rcu_read_unlock();
> > > -
> > > -       if (c =3D=3D conn) {
> > > +       if (hci_conn_is_alive(hdev, conn)) {
> >
> > Hmm, I don't think this is safe, except if we are doing hci_conn_get
> > we can't really access the conn pointer since it may be freed already,
> > anyway this is sort of broken already given that we do access
> > conn->hdev already.
>
> hci_conn_get is held here, there's a hci_conn_put at the end of this
> function.
>
> >
> > >                 hci_connect_le_scan_cleanup(conn, 0x00);
> > >                 hci_conn_cleanup(conn);
> > >         }
> > > --
> > > 2.41.0
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
