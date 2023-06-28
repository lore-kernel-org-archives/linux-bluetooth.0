Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83CFEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjF1SUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF1SUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 14:20:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC619B9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 11:20:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so1615101fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687976413; x=1690568413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxWt9sREMzBIeVyXSuQ1eOFw39XapvP6pXuRBjWTePE=;
        b=jfK0vj0P6wNmcY4gfpKKx+7GV3rq+h+ncmBy1TfjvmIxuINruhN0zH452ahFLaBLLk
         nU9nbT/oJFaI/NMjmiSJyPRiORVkUu1rEn9vF2KtKmbPT6R+SwAnhfpOome5DDXuEP7y
         5PiMIsrbH9INfgVXfI+EyZgWLJjQr9QAK9Ye/1XXAPBVwUenHYOrEIw7yAyt4j0gaBKL
         P/ZWtNRTwrLCW6wf0SlCxusEz0AXOD8+/iJNDSail29tV08aHrXrEtjYa5WKik9iPoYA
         OumOeVf9lnlXXUxuTsUqpB+xwS5dIYc9B5qR19XkzGGf/pUlJMlqXwjOpOTjofwwa7ae
         M4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976413; x=1690568413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxWt9sREMzBIeVyXSuQ1eOFw39XapvP6pXuRBjWTePE=;
        b=hAFR+Cbb/BHJxmHn2oYSIRMTn3Uco5HTwavrGD8ZLoMDhi8FT3IyBRFkbeYHmnxXGq
         v0oxqAfjeCXIc7JCgJeLXbapnR65AGsNYU7lPH1ZJF6MJO8UjteJRPeZpTdI61Cw0NJy
         UhDIDAJVklG2tbyR06qIWHh6dL3uVDBNASWKrBRuDutH8LLnIl7NgO1yueI7toakNP6B
         vIGI6GU/XX454tgMM1wt5oDpBLbE0Mx6/vi9UJyMiCecW9C1Cf2Nivp0MxdH3tVgZJtV
         nc/fwh/6xQawg4iFEcuTFr/FCZQ6SMZ/O8i8Q88Mag8yINPjdXxkO20B+N74wtiHXnCJ
         kPig==
X-Gm-Message-State: AC+VfDzraLX7K+dMm/kI1Za3asKkPN8TyiqAPWKbMPkRoHZ/fJ+UayeH
        +pnQ/vb5B3zOSZwUUP5+pFvckiRib3ninS3kLE0=
X-Google-Smtp-Source: ACHHUZ7aA6VLtDs2pkUZdW4aWlykHvrjqKBtoX+doGCFK6HdR+aJy9eli9IhhPmyPgmhFTBSKhFCq3mfrzvTQXNs6z8=
X-Received: by 2002:a2e:848a:0:b0:2b4:6c76:332f with SMTP id
 b10-20020a2e848a000000b002b46c76332fmr25584410ljh.9.1687976412430; Wed, 28
 Jun 2023 11:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230627215301.2648840-1-luiz.dentz@gmail.com> <0cdefb7f9c3b44ba999a4117dde9a1ac43bb1c42.camel@iki.fi>
In-Reply-To: <0cdefb7f9c3b44ba999a4117dde9a1ac43bb1c42.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jun 2023 11:20:00 -0700
Message-ID: <CABBYNZJnG5z-XVKqOaD7a-xxAm=+yUCprjkPW3_=odrd0cw8pA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Consolidate code for aborting connections
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jun 28, 2023 at 7:49=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2023-06-27 kello 14:53 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This consolidates code for aborting connections using
> > hci_cmd_sync_queue so it is synchronized with other threads, but
> > because of the fact that some commands may block the cmd_sync_queue
> > while waiting specific events this attempt to cancel those requests by
> > using hci_cmd_sync_cancel.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |   2 +-
> >  net/bluetooth/hci_conn.c         | 160 +++++++------------------------
> >  net/bluetooth/hci_sync.c         |  20 ++--
> >  net/bluetooth/mgmt.c             |  15 +--
> >  4 files changed, 48 insertions(+), 149 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 05a9b3ab3f56..094ca3aca15e 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -741,6 +741,7 @@ struct hci_conn {
> >       unsigned long   flags;
> >
> >       enum conn_reasons conn_reason;
> > +     __u8            abort_reason;
> >
> >       __u32           clock;
> >       __u16           clock_accuracy;
> > @@ -760,7 +761,6 @@ struct hci_conn {
> >       struct delayed_work auto_accept_work;
> >       struct delayed_work idle_work;
> >       struct delayed_work le_conn_timeout;
> > -     struct work_struct  le_scan_cleanup;
> >
> >       struct device   dev;
> >       struct dentry   *debugfs;
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 47e7aa4d63a9..88f18f375684 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -178,57 +178,6 @@ static void hci_conn_cleanup(struct hci_conn *conn=
)
> >       hci_conn_put(conn);
> >  }
> >
> > -static void le_scan_cleanup(struct work_struct *work)
> > -{
> > -     struct hci_conn *conn =3D container_of(work, struct hci_conn,
> > -                                          le_scan_cleanup);
> > -     struct hci_dev *hdev =3D conn->hdev;
> > -     struct hci_conn *c =3D NULL;
> > -
> > -     BT_DBG("%s hcon %p", hdev->name, conn);
> > -
> > -     hci_dev_lock(hdev);
> > -
> > -     /* Check that the hci_conn is still around */
> > -     rcu_read_lock();
> > -     list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > -             if (c =3D=3D conn)
> > -                     break;
> > -     }
> > -     rcu_read_unlock();
> > -
> > -     if (c =3D=3D conn) {
> > -             hci_connect_le_scan_cleanup(conn, 0x00);
> > -             hci_conn_cleanup(conn);
> > -     }
> > -
> > -     hci_dev_unlock(hdev);
> > -     hci_dev_put(hdev);
> > -     hci_conn_put(conn);
> > -}
> > -
> > -static void hci_connect_le_scan_remove(struct hci_conn *conn)
> > -{
> > -     BT_DBG("%s hcon %p", conn->hdev->name, conn);
> > -
> > -     /* We can't call hci_conn_del/hci_conn_cleanup here since that
> > -      * could deadlock with another hci_conn_del() call that's holding
> > -      * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_wo=
rk).
> > -      * Instead, grab temporary extra references to the hci_dev and
> > -      * hci_conn and perform the necessary cleanup in a separate work
> > -      * callback.
> > -      */
> > -
> > -     hci_dev_hold(conn->hdev);
> > -     hci_conn_get(conn);
> > -
> > -     /* Even though we hold a reference to the hdev, many other
> > -      * things might get cleaned up meanwhile, including the hdev's
> > -      * own workqueue, so we can't use that for scheduling.
> > -      */
> > -     schedule_work(&conn->le_scan_cleanup);
> > -}
> > -
> >  static void hci_acl_create_connection(struct hci_conn *conn)
> >  {
> >       struct hci_dev *hdev =3D conn->hdev;
> > @@ -679,13 +628,6 @@ static void hci_conn_timeout(struct work_struct *w=
ork)
> >       if (refcnt > 0)
> >               return;
> >
> > -     /* LE connections in scanning state need special handling */
> > -     if (conn->state =3D=3D BT_CONNECT && conn->type =3D=3D LE_LINK &&
> > -         test_bit(HCI_CONN_SCANNING, &conn->flags)) {
> > -             hci_connect_le_scan_remove(conn);
> > -             return;
> > -     }
> > -
> >       hci_abort_conn(conn, hci_proto_disconn_ind(conn));
> >  }
> >
> > @@ -1066,7 +1008,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hde=
v, int type, bdaddr_t *dst,
> >       INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
> >       INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
> >       INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
> > -     INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
> >
> >       atomic_set(&conn->refcnt, 0);
> >
> > @@ -2888,81 +2829,46 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
> >       return phys;
> >  }
> >
> > -int hci_abort_conn(struct hci_conn *conn, u8 reason)
> > +static int abort_conn_sync(struct hci_dev *hdev, void *data)
> >  {
> > -     int r =3D 0;
> > +     struct hci_conn *conn;
> > +     u16 handle =3D PTR_ERR(data);
> >
> > -     if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
> > +     conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> > +     if (!conn)
> >               return 0;
> >
> > -     switch (conn->state) {
> > -     case BT_CONNECTED:
> > -     case BT_CONFIG:
> > -             if (conn->type =3D=3D AMP_LINK) {
> > -                     struct hci_cp_disconn_phy_link cp;
> > +     return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
> > +}
> >
> > -                     cp.phy_handle =3D HCI_PHY_HANDLE(conn->handle);
> > -                     cp.reason =3D reason;
> > -                     r =3D hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY=
_LINK,
> > -                                      sizeof(cp), &cp);
> > -             } else {
> > -                     struct hci_cp_disconnect dc;
> > +int hci_abort_conn(struct hci_conn *conn, u8 reason)
> > +{
> > +     struct hci_dev *hdev =3D conn->hdev;
> >
> > -                     dc.handle =3D cpu_to_le16(conn->handle);
> > -                     dc.reason =3D reason;
> > -                     r =3D hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
> > -                                      sizeof(dc), &dc);
> > +     /* If abort_reason has already been set it means the connection i=
s
> > +      * already being aborted so don't attempt to overwrite it.
> > +      */
> > +     if (conn->abort_reason)
> > +             return 0;
> > +
> > +     bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, r=
eason);
> > +
> > +     conn->abort_reason =3D reason;
> > +
> > +     /* If the connection is pending check the command opcode since th=
at
> > +      * might be blocking on hci_cmd_sync_work while waiting its respe=
ctive
> > +      * event so we need to hci_cmd_sync_cancel to cancel it.
> > +      */
> > +     if (conn->state =3D=3D BT_CONNECT && hdev->req_status =3D=3D HCI_=
REQ_PEND) {
> > +             switch (hci_skb_event(hdev->sent_cmd)) {
> > +             case HCI_EV_LE_CONN_COMPLETE:
> > +             case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> > +             case HCI_EVT_LE_CIS_ESTABLISHED:
> > +                     hci_cmd_sync_cancel(hdev, -ECANCELED);
> > +                     break;
>
> Can this also accidentally cancel connection attempt for a different
> conn?
>
> Eg. start Create CIS conn1, then queue LE Connect conn2, then conn1
> starts waiting for the events, then hci_conn_abort conn2, then here
> conn1 gets canceled with error.

The handles would be different though since in case of CIS we do get
then assigned in CIG response, that said it maybe possible for ACL/LE
where the handles are not assigned until the connection is complete so
we may need to assign unique handles for them as well to prevent this
to happen.

> >               }
> > -
> > -             conn->state =3D BT_DISCONN;
> > -
> > -             break;
> > -     case BT_CONNECT:
> > -             if (conn->type =3D=3D LE_LINK) {
> > -                     if (test_bit(HCI_CONN_SCANNING, &conn->flags))
> > -                             break;
> > -                     r =3D hci_send_cmd(conn->hdev,
> > -                                      HCI_OP_LE_CREATE_CONN_CANCEL, 0,=
 NULL);
> > -             } else if (conn->type =3D=3D ACL_LINK) {
> > -                     if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
> > -                             break;
> > -                     r =3D hci_send_cmd(conn->hdev,
> > -                                      HCI_OP_CREATE_CONN_CANCEL,
> > -                                      6, &conn->dst);
> > -             }
> > -             break;
> > -     case BT_CONNECT2:
> > -             if (conn->type =3D=3D ACL_LINK) {
> > -                     struct hci_cp_reject_conn_req rej;
> > -
> > -                     bacpy(&rej.bdaddr, &conn->dst);
> > -                     rej.reason =3D reason;
> > -
> > -                     r =3D hci_send_cmd(conn->hdev,
> > -                                      HCI_OP_REJECT_CONN_REQ,
> > -                                      sizeof(rej), &rej);
> > -             } else if (conn->type =3D=3D SCO_LINK || conn->type =3D=
=3D ESCO_LINK) {
> > -                     struct hci_cp_reject_sync_conn_req rej;
> > -
> > -                     bacpy(&rej.bdaddr, &conn->dst);
> > -
> > -                     /* SCO rejection has its own limited set of
> > -                      * allowed error values (0x0D-0x0F) which isn't
> > -                      * compatible with most values passed to this
> > -                      * function. To be safe hard-code one of the
> > -                      * values that's suitable for SCO.
> > -                      */
> > -                     rej.reason =3D HCI_ERROR_REJ_LIMITED_RESOURCES;
> > -
> > -                     r =3D hci_send_cmd(conn->hdev,
> > -                                      HCI_OP_REJECT_SYNC_CONN_REQ,
> > -                                      sizeof(rej), &rej);
> > -             }
> > -             break;
> > -     default:
> > -             conn->state =3D BT_CLOSED;
> > -             break;
> >       }
> >
> > -     return r;
> > +     return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->ha=
ndle),
> > +                               NULL);
> >  }
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index afb8e970e62c..ef8297d04a8c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5271,10 +5271,13 @@ static int hci_disconnect_sync(struct hci_dev *=
hdev, struct hci_conn *conn,
> >  }
> >
> >  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> > -                                   struct hci_conn *conn)
> > +                                   struct hci_conn *conn, u8 reason)
> >  {
> > +     /* Return reason if scanning since the connection shall probably =
be
> > +      * cleanup directly.
> > +      */
> >       if (test_bit(HCI_CONN_SCANNING, &conn->flags))
> > -             return 0;
> > +             return reason;
> >
> >       if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
> >               return 0;
> > @@ -5283,10 +5286,11 @@ static int hci_le_connect_cancel_sync(struct hc=
i_dev *hdev,
> >                                    0, NULL, HCI_CMD_TIMEOUT);
> >  }
> >
> > -static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_co=
nn *conn)
> > +static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_co=
nn *conn,
> > +                                u8 reason)
> >  {
> >       if (conn->type =3D=3D LE_LINK)
> > -             return hci_le_connect_cancel_sync(hdev, conn);
> > +             return hci_le_connect_cancel_sync(hdev, conn, reason);
> >
> >       if (hdev->hci_ver < BLUETOOTH_VER_1_2)
> >               return 0;
> > @@ -5339,9 +5343,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, st=
ruct hci_conn *conn, u8 reason)
> >       case BT_CONFIG:
> >               return hci_disconnect_sync(hdev, conn, reason);
> >       case BT_CONNECT:
> > -             err =3D hci_connect_cancel_sync(hdev, conn);
> > +             err =3D hci_connect_cancel_sync(hdev, conn, reason);
> >               /* Cleanup hci_conn object if it cannot be cancelled as i=
t
> > -              * likelly means the controller and host stack are out of=
 sync.
> > +              * likelly means the controller and host stack are out of=
 sync
> > +              * or in case of LE it was still scanning so it can be cl=
eanup
> > +              * safely.
> >                */
> >               if (err) {
> >                       hci_dev_lock(hdev);
> > @@ -6255,7 +6261,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev,=
 struct hci_conn *conn)
> >
> >  done:
> >       if (err =3D=3D -ETIMEDOUT)
> > -             hci_le_connect_cancel_sync(hdev, conn);
> > +             hci_le_connect_cancel_sync(hdev, conn, 0x00);
> >
> >       /* Re-enable advertising after the connection attempt is finished=
. */
> >       hci_resume_advertising_sync(hdev);
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 0f5ba618ceb1..3156bc27088e 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3586,18 +3586,6 @@ static int pair_device(struct sock *sk, struct h=
ci_dev *hdev, void *data,
> >       return err;
> >  }
> >
> > -static int abort_conn_sync(struct hci_dev *hdev, void *data)
> > -{
> > -     struct hci_conn *conn;
> > -     u16 handle =3D PTR_ERR(data);
> > -
> > -     conn =3D hci_conn_hash_lookup_handle(hdev, handle);
> > -     if (!conn)
> > -             return 0;
> > -
> > -     return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM=
);
> > -}
> > -
> >  static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, v=
oid *data,
> >                             u16 len)
> >  {
> > @@ -3648,8 +3636,7 @@ static int cancel_pair_device(struct sock *sk, st=
ruct hci_dev *hdev, void *data,
> >                                             le_addr_type(addr->type));
> >
> >       if (conn->conn_reason =3D=3D CONN_REASON_PAIR_DEVICE)
> > -             hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->h=
andle),
> > -                                NULL);
> > +             hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> >
> >  unlock:
> >       hci_dev_unlock(hdev);
>


--=20
Luiz Augusto von Dentz
