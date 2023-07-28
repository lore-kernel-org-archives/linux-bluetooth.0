Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011EC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjG1A1g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 20:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG1A1g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 20:27:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE15913D
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 17:27:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so24265721fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690504053; x=1691108853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaCd3ZwlyFMxOCDT17dwQUVAbJgSO0M5JlSsKyEfgOA=;
        b=CRxun/03znoA7qD0I/o165zAS0QtBYkRcs0bgOanxV+X2C+eBFgCLnHyN/R73XnWjj
         WyH3oLddvso4FgJpgbpnKSZFzNeOiShKllmIX/Fon4EI1I442mt3wDTKtL/YMuTnHVm4
         BBXe1AFdG48EhhqVzKLFjUampN9g+c5lj3f2IuuJ/fEolATh1WoC9UPJU18IN6Lmh4yZ
         RRLLME4Vkon1La0JW/u2lsovkfbAtwbQslUBOiSYxMDcMWdrTRTB2tH4PWctD1F4mOAw
         YEOIjoHPwZNp0MddoGQmmRrSnuv19mA1GdD5VBgQAbgwLcSkkZRCrWAoy966MvamDJts
         VX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690504053; x=1691108853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaCd3ZwlyFMxOCDT17dwQUVAbJgSO0M5JlSsKyEfgOA=;
        b=D5UuHmiWtSl0LzAx/muOOVWn+JqMmuTvqDEKDTnwMCWqHgy9+OTbzOhPY7eMLu1+Ti
         kr2H+6JwAT9p4WWBUZaWDWd4YTEj+nZo4Up/jrJO69IrKeAX3WslFpbHnBJUyZ1HldfS
         qRN37oDSKpKPhpi2MGZGpphpKK0+9r/pqD1cboGeSzk9CCmFaCP6EdvoVlI8TG6WE7EB
         bjKrO3YWqXiOTYn1Q4pw89VsZxIs/PgJDAi+FxVxKh/lGVDYyxMqAMkUHn7QE+fI28mz
         W3zmOv+AcBweXE1tJ2MECWsbzlBUh95kaKt5EGDLwbHxkqIJKfgUOFVSmNlMrXnkNbpT
         LLuQ==
X-Gm-Message-State: ABy/qLZ9S7z5KL0k5TG94CN1BuVJsuQa3MgmMeSbzI51rV2h7NlxcAnx
        S6d3FDV6Wd5a0oJDboVfTxAH/Xu3RojxPFsCna5E2Tf+
X-Google-Smtp-Source: APBJJlFAmWolUmJoVTWgayHOHuKy6wGnYjFViBZXGynSqHbXti06GQnnE4N4jaPHP6cdgmXDyU0v0q2votEaQjHf6G8=
X-Received: by 2002:a2e:3e17:0:b0:2b9:412a:1117 with SMTP id
 l23-20020a2e3e17000000b002b9412a1117mr471253lja.1.1690504052583; Thu, 27 Jul
 2023 17:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690399379.git.pav@iki.fi> <f02203d5565bbe78c2406ca45a5a72336a1315ea.1690399379.git.pav@iki.fi>
 <CABBYNZK-im2S7KnbBuP7Bq4V8yvJa-KZ5fZkW7zySepDY9DNTA@mail.gmail.com> <15a7a714e1f16a2b215accf451927378417c0929.camel@iki.fi>
In-Reply-To: <15a7a714e1f16a2b215accf451927378417c0929.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 17:27:20 -0700
Message-ID: <CABBYNZ+9-dxfumDqnQyx7Rd3dUsNiKk-jVsxAkgdgN=xjNF4Rw@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] Bluetooth: ISO: handle bound CIS cleanup via hci_conn
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Jul 27, 2023 at 2:35=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-07-27 kello 14:14 -0700, Luiz Augusto von Dentz kirjoitti:
> > On Wed, Jul 26, 2023 at 2:37=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Calling hci_conn_del in __iso_sock_close is invalid. It needs
> > > hdev->lock, but it cannot be acquired there due to lock ordering.
> > >
> > > Fix this by doing cleanup via hci_conn_drop.
> > >
> > > Return hci_conn with refcount 1 from hci_bind_cis and hci_connect_cis=
,
> > > so that the iso_conn always holds one reference.  This also fixes
> > > refcounting when error handling.
> > >
> > > Since hci_conn_abort shall handle termination of connections in any
> > > state properly, we can handle BT_CONNECT socket state in the same way=
 as
> > > BT_CONNECTED.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  net/bluetooth/hci_conn.c |  5 +++++
> > >  net/bluetooth/iso.c      | 14 +-------------
> > >  2 files changed, 6 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index ba339a0eb851..33fbdc8e0748 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1901,6 +1901,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *h=
dev, bdaddr_t *dst,
> > >                 return ERR_PTR(-EINVAL);
> > >         }
> > >
> > > +       hci_conn_hold(cis);
> > > +
> > >         cis->iso_qos =3D *qos;
> > >         cis->state =3D BT_BOUND;
> > >
> > > @@ -2254,6 +2256,9 @@ struct hci_conn *hci_connect_cis(struct hci_dev=
 *hdev, bdaddr_t *dst,
> > >                 return ERR_PTR(-ENOLINK);
> > >         }
> > >
> > > +       /* Link takes the refcount */
> > > +       hci_conn_drop(cis);
> > > +
> > >         cis->state =3D BT_CONNECT;
> > >
> > >         hci_le_create_cis_pending(hdev);
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > index cbe3299b4a41..358954bfbb32 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -628,6 +628,7 @@ static void __iso_sock_close(struct sock *sk)
> > >                 iso_sock_cleanup_listen(sk);
> > >                 break;
> > >
> > > +       case BT_CONNECT:
> > >         case BT_CONNECTED:
> > >         case BT_CONFIG:
> > >                 if (iso_pi(sk)->conn->hcon) {
> > > @@ -643,19 +644,6 @@ static void __iso_sock_close(struct sock *sk)
> > >                 break;
> > >
> > >         case BT_CONNECT2:
> > > -               iso_chan_del(sk, ECONNRESET);
> > > -               break;
> > > -       case BT_CONNECT:
> > > -               /* In case of DEFER_SETUP the hcon would be bound to =
CIG which
> > > -                * needs to be removed so just call hci_conn_del so t=
he cleanup
> > > -                * callback do what is needed.
> > > -                */
> > > -               if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
> > > -                   iso_pi(sk)->conn->hcon) {
> > > -                       hci_conn_del(iso_pi(sk)->conn->hcon);
> > > -                       iso_pi(sk)->conn->hcon =3D NULL;
> > > -               }
> > > -
> > >                 iso_chan_del(sk, ECONNRESET);
> > >                 break;
> > >         case BT_DISCONN:
> > > --
> > > 2.41.0
> >
> > I guess this sort of fix can be sent separately which I guess helps
> > here since we can prioritize the ones that don't have side effects.
>
> Right, I can send these separately in the actual patch series.
>
> This one requires hci_conn_abort deletes conns with no handle yet
> though, otherwise it introduces failure to cleanup in a race condition.

I thought we need to lookup by handle to avoid races as well, or are
you doing that because the handle could be updated in the meantime?
Perhaps we could store the temporary handles in case the connection
handles get updated then it can still be looked up by its temporary
handle, either that or we disregard updates to handle when they're in
the process of being aborted.


--=20
Luiz Augusto von Dentz
