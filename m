Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53DC001DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjHEAat (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 20:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEAas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 20:30:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8714694
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 17:30:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso42018881fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691195445; x=1691800245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZEZIUPKs3wiLixVNlH1oDxndyOHWGTbpRR1ihKExKc=;
        b=Ol8pptZ0oDsdKH891QzIlXap7zbwjg6IkH1aI/qbx+zjQayz0OPhHW+iH5BeDthDD5
         T6Wjpldt9B2CCTcLLmQ2XSeoMyG7hdXBON1upwgYkM6/KmKTb5H8hKl0sPF1UrzmbU14
         34xyWz2xXb4JLS8FoDdXrG4LQSKLL8+MvkGgwgoge2tfOYNBplWlbsKAuU4kubZ0juEA
         UmdyPIFY9Dsrei7slKcSiTu4S2VrCjW4609NE2JEd0kLC2qBjzr9Z2dYFA9aIfmxfylA
         5guDCSoM13WvdMGeo3Ui7aAixwqLcXi+/L90NRxpcTylSvrfyy+3ODYmrhiIoyefCTCk
         1QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691195445; x=1691800245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZEZIUPKs3wiLixVNlH1oDxndyOHWGTbpRR1ihKExKc=;
        b=NT4mbwj16UPJtvd0Txc+IUCTR3ppgVZ35xoPiGZl6Kmzk7oxvIZWfKsGWDJMVEATNa
         Iu/XwZzvvXvjP4c945XpQaLMvsi0m/ZBgtjNJmPBRs5u9O/23xBh2PQ2L7NX9Pjd5b7t
         T470YqtgTWOjiKsXzZB3wnFBZ6xIcMXj2rr2ZPfxfvbLrSzwMOCo90t3T/kqFh7pESiE
         xJbvupC7ed9O1d6lGIH6ErWPdQGQhG0kUN0DOqDtO9/OywKwNaEWu+o1tq5JTkduxgAF
         hbHXsy6+e7y08IdozvUP3yTtlV93j9vfX1Z1NArThBERc6UE1fQFv8DYSkxKs/fLJGQL
         KTRQ==
X-Gm-Message-State: AOJu0YxKDjKfnUK1xU+zSANIWrzWdWZU15qAJ/yGtsA28toKFvxtiYNp
        GYTm6GdrMExBGDRHb8abQ8O9pnoGONvjNlQE85KLi/Bj
X-Google-Smtp-Source: AGHT+IGljdRcQROZ2OZHJCPZ8OChcB7M1m+4U3YFJs/UMwedBy5jkcEkaJ9ki1urMe9T9DpswEmUagV7OUBKDhODMo4=
X-Received: by 2002:a2e:9815:0:b0:2ba:cbb:47b7 with SMTP id
 a21-20020a2e9815000000b002ba0cbb47b7mr2535722ljj.21.1691195444816; Fri, 04
 Aug 2023 17:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230804001115.907885-1-luiz.dentz@gmail.com> <20230804001115.907885-4-luiz.dentz@gmail.com>
 <4c5eadaa0e013bced982050038de97435ad2881f.camel@iki.fi>
In-Reply-To: <4c5eadaa0e013bced982050038de97435ad2881f.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Aug 2023 17:30:32 -0700
Message-ID: <CABBYNZLXhO84HdA8vzLqpEHyBQiH9QdHWEzOBYJfMeFYmofV0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Bluetooth: hci_conn: Fix modifying handle while aborting
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Aug 4, 2023 at 9:28=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-08-03 kello 17:11 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This introduces hci_conn_set_handle which takes care of verifying the
> > conditions where the hci_conn handle can be modified, including when
> > hci_conn_abort has been called and also checks that the handles is
> > valid as well.
>
> It looks there could still be problem vs. sequences of the type
>
> [kernel] hci_acl_create_connection(AA:AA:AA:AA:AA:AA)
> [controller] < Create Connection AA:AA:AA:AA:AA:AA
> [controller] > Connection Complete handle X
> [kernel] hci_conn_complete_evt(handle X)
> [kernel] hci_acl_create_connection(BB:BB:BB:BB:BB:BB)
> [kernel] hci_abort_conn(handle X)
> [controller] > Disconnect Complete handle X (from remote)
> [kernel] hci_disconn_complete_evt(handle X)
> [controller] < Create Connection BB:BB:BB:BB:BB:BB
> [controller] > Connection Complete handle X  (same handle value)
> [kernel] hci_conn_complete_evt(handle X)
> ...
> [kernel] hci_abort_conn_sync(handle X)
>
> This would seem to terminate the wrong connection.

Perhaps we need a test for it, it shall also be possible to cancel the call=
back.

> Some flag/abort_reason could be checked to see if the looked up conn is
> to be aborted before doing it. This can also be used to make
> hci_disconnect_all_sync iteration UAF-safe.

Yep, I am also thinking of introducing some functions to lookup on the
cmd_sync_queue to avoid submitting duplicated commands, or for example
if we want to cancel a callback.

> It's unclear to me if you agree that tasks from hdev->workqueue and
> hdev->req_workqueue can run concurrently, so that locking is needed.

I think what we should do is to check if we can have a more clear
separation, because the workqueue is used for example by the likes of
rx_work which does process everything we receive from the controller,
which perhaps is not the best idea given in case of HCI events it
might be better to process them in the same context of commands for
example, to ensure that HCI states is not being modified concurrently
which seems to be what causes the most problems.

> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_conn.c         | 30 ++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_event.c        | 29 +++++++++++------------------
> >  3 files changed, 42 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 8200a6689b39..d2a3a2a9fd7d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1425,6 +1425,7 @@ int hci_conn_switch_role(struct hci_conn *conn, _=
_u8 role);
> >  void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_acti=
ve);
> >
> >  void hci_conn_failed(struct hci_conn *conn, u8 status);
> > +u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
> >
> >  /*
> >   * hci_conn_get() and hci_conn_put() are used to control the life-time=
 of an
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 923bb7e7be2b..13bd2753abbb 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1231,6 +1231,36 @@ void hci_conn_failed(struct hci_conn *conn, u8 s=
tatus)
> >       hci_conn_del(conn);
> >  }
> >
> > +/* This function requires the caller holds hdev->lock */
> > +u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
> > +{
> > +     struct hci_dev *hdev =3D conn->hdev;
> > +
> > +     bt_dev_dbg(hdev, "hcon %p handle 0x%4.4x", conn, handle);
> > +
> > +     if (conn->handle =3D=3D handle)
> > +             return 0;
> > +
> > +     if (handle > HCI_CONN_HANDLE_MAX) {
> > +             bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
> > +                        handle, HCI_CONN_HANDLE_MAX);
> > +             return HCI_ERROR_INVALID_PARAMETERS;
> > +     }
> > +
> > +     /* If abort_reason has been sent it means the connection is being
> > +      * aborted and the handle shall not be changed.
> > +      */
> > +     if (conn->abort_reason) {
> > +             bt_dev_err(hdev, "hcon %p abort_reason 0x%2.2x", conn,
> > +                        conn->abort_reason);
> > +             return conn->abort_reason;
> > +     }
> > +
> > +     conn->handle =3D handle;
> > +
> > +     return 0;
> > +}
> > +
> >  static void create_le_conn_complete(struct hci_dev *hdev, void *data, =
int err)
> >  {
> >       struct hci_conn *conn;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index f1fcece29e7d..218da9b0fe8f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3179,13 +3179,9 @@ static void hci_conn_complete_evt(struct hci_dev=
 *hdev, void *data,
> >       }
> >
> >       if (!status) {
> > -             conn->handle =3D __le16_to_cpu(ev->handle);
> > -             if (conn->handle > HCI_CONN_HANDLE_MAX) {
> > -                     bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.=
4x",
> > -                                conn->handle, HCI_CONN_HANDLE_MAX);
> > -                     status =3D HCI_ERROR_INVALID_PARAMETERS;
> > +             status =3D hci_conn_set_handle(conn, __le16_to_cpu(ev->ha=
ndle));
> > +             if (status)
> >                       goto done;
> > -             }
> >
> >               if (conn->type =3D=3D ACL_LINK) {
> >                       conn->state =3D BT_CONFIG;
> > @@ -3849,11 +3845,9 @@ static u8 hci_cc_le_set_cig_params(struct hci_de=
v *hdev, void *data,
> >               if (conn->state !=3D BT_BOUND && conn->state !=3D BT_CONN=
ECT)
> >                       continue;
> >
> > -             conn->handle =3D __le16_to_cpu(rp->handle[i]);
> > +             if (hci_conn_set_handle(conn, __le16_to_cpu(rp->handle[i]=
)))
> > +                     continue;
> >
> > -             bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
> > -                        conn->handle, conn->parent);
> > -
> >               if (conn->state =3D=3D BT_CONNECT)
> >                       pending =3D true;
> >       }
> > @@ -5039,11 +5033,8 @@ static void hci_sync_conn_complete_evt(struct hc=
i_dev *hdev, void *data,
> >
> >       switch (status) {
> >       case 0x00:
> > -             conn->handle =3D __le16_to_cpu(ev->handle);
> > -             if (conn->handle > HCI_CONN_HANDLE_MAX) {
> > -                     bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.=
4x",
> > -                                conn->handle, HCI_CONN_HANDLE_MAX);
> > -                     status =3D HCI_ERROR_INVALID_PARAMETERS;
> > +             status =3D hci_conn_set_handle(conn, __le16_to_cpu(ev->ha=
ndle));
> > +             if (status) {
> >                       conn->state =3D BT_CLOSED;
> >                       break;
> >               }
> > @@ -6978,7 +6969,7 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
> >  {
> >       struct hci_evt_le_create_big_complete *ev =3D data;
> >       struct hci_conn *conn;
> > -     __u8 bis_idx =3D 0;
> > +     __u8 i =3D 0;
> >
> >       BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
> >
> > @@ -6996,7 +6987,9 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
> >                   conn->iso_qos.bcast.big !=3D ev->handle)
> >                       continue;
> >
> > -             conn->handle =3D __le16_to_cpu(ev->bis_handle[bis_idx++])=
;
> > +             if (hci_conn_set_handle(conn,
> > +                                     __le16_to_cpu(ev->bis_handle[i++]=
)))
> > +                     continue;
> >
> >               if (!ev->status) {
> >                       conn->state =3D BT_CONNECTED;
> > @@ -7015,7 +7008,7 @@ static void hci_le_create_big_complete_evt(struct=
 hci_dev *hdev, void *data,
> >               rcu_read_lock();
> >       }
> >
> > -     if (!ev->status && !bis_idx)
> > +     if (!ev->status && !i)
> >               /* If no BISes have been connected for the BIG,
> >                * terminate. This is in case all bound connections
> >                * have been closed before the BIG creation
>


--=20
Luiz Augusto von Dentz
