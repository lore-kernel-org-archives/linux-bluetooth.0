Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E1C04A94
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHAATx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 20:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHAATv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 20:19:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD11BC8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 17:19:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso8005906e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690849184; x=1691453984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNHiaxbl+IdZXxFr5Q5+llwfK1P6slQwoZdxikz5rgA=;
        b=lCL2hIZd23y/pmmmph1Cq+KraUd49bsfQg+oYghoM0mET1MqZEU3iakvAheOQgRub2
         GrY+1T+mrfu+TCS8bq/MU6E0OLRDDEfpuQ+QoUxJgTnpKq9EkJeGlZxUdysOykz3KdPq
         N6xY5X7FUoL/6Rn9OrqF+p7LTfpWJgXCE6rPJvPud08uSupmSJukbklrb8WCCompKVNW
         1OqZl1KKWuIDxzoE7TUvpYGMku10MJQZmUwuq+r0XgiJj30UPL+OYA2ie9Iu9B/pwmAE
         nlI6KmUiFrtaU4DCEue5hFNVumztg1I92kddIriQQgqSHONoAOLcTruB1vCBXLZ26GLj
         vPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690849184; x=1691453984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNHiaxbl+IdZXxFr5Q5+llwfK1P6slQwoZdxikz5rgA=;
        b=W1ZU+LoxBtFZpc/RiPcPX2cYDIBzY5aapmV3FVHU5geDxugW5B+1a5qdVgwvVOaLeB
         XqUpWjgopc3QnZdbI7ak8fktU/sfxwA5UoJpUsG67oe/aFS3igVwuNUTCWwpBQz9GQE+
         GZbP+zWLPa158V5VFVU09rfjc6l6+ZdQzdHDfGulxypkw64htl/Vnj9iCGepRnMio2Sn
         DMGBnq7iCX98wdYjc+lB0ntwV7TU1o+ebY+L1sO8gntK44aKQ/2aOlmQ/NEHOEH6bATS
         Lu9bh6cuVG0FZur5wQGlK9EHujnxnoWerHv3QIJnHu0CJ/bhwB4brQFbq+m7fF3TPOJe
         QYUw==
X-Gm-Message-State: ABy/qLZPJJ7DLce5qO/gLFcZkctleQxhzWbH8brvya8DXVUsWGqN8pZd
        WzHkRCGxIvi5i0orkdHF53BmG/bJQLs1RW8H7lfLBsbs6+I=
X-Google-Smtp-Source: APBJJlHWcIRl15wUAD9UQFN09YHkfQ3nbqsiVgMA9nPifpVLqWSQ10ViYaIKoNB7d0mHgYDc44VXax4ZRTOEozTaMgE=
X-Received: by 2002:a2e:3618:0:b0:2b9:c864:9e3f with SMTP id
 d24-20020a2e3618000000b002b9c8649e3fmr1111993lja.39.1690849183860; Mon, 31
 Jul 2023 17:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690405564.git.pav@iki.fi> <15f85f2e419757a2c689e8572ccf7793a931f555.1690405564.git.pav@iki.fi>
 <359925f6573cd19244c86266569a0a3b46b70363.camel@iki.fi>
In-Reply-To: <359925f6573cd19244c86266569a0a3b46b70363.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Jul 2023 17:19:31 -0700
Message-ID: <CABBYNZ+mx+HUMUxdMyVe+qReoxCnC3DPZA_-WqfvSsQWJcS_1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] btdev: check error conditions for HCI_Create_Connection_Cancel
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Jul 27, 2023 at 3:00=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> to, 2023-07-27 kello 00:25 +0300, Pauli Virtanen kirjoitti:
> > Create Connection Cancel shall return Command Complete with error statu=
s
> > when there is no Create Connection that can be canceled.  In these
> > cases, we should not send a (spurious) Connection Complete event.
> >
> > Fix by keeping a list of pending Create Connection commands, and
> > returning command errors if there is none pending at the moment.
> > ---
> >  emulator/btdev.c | 76 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 68 insertions(+), 8 deletions(-)
> >
> > diff --git a/emulator/btdev.c b/emulator/btdev.c
> > index 637f0bb98..0c75e71c0 100644
> > --- a/emulator/btdev.c
> > +++ b/emulator/btdev.c
> > @@ -62,6 +62,7 @@ struct hook {
> >
> >  #define MAX_HOOK_ENTRIES 16
> >  #define MAX_EXT_ADV_SETS 3
> > +#define MAX_PENDING_CONN 16
> >
> >  struct btdev_conn {
> >       uint16_t handle;
> > @@ -223,6 +224,8 @@ struct btdev {
> >       uint8_t  le_rl_enable;
> >       uint16_t le_rl_timeout;
> >
> > +     struct btdev *pending_conn[MAX_PENDING_CONN];
> > +
> >       uint8_t le_local_sk256[32];
> >
> >       uint16_t sync_train_interval;
> > @@ -1211,10 +1214,36 @@ static struct btdev_conn *conn_link_bis(struct =
btdev *dev, struct btdev *remote,
> >       return conn;
> >  }
> >
> > +static void pending_conn_add(struct btdev *btdev, struct btdev *remote=
)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
> > +             if (!btdev->pending_conn[i]) {
> > +                     btdev->pending_conn[i] =3D remote;
> > +                     return;
> > +             }
> > +     }
> > +}
> > +
> > +static bool pending_conn_del(struct btdev *btdev, struct btdev *remote=
)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
> > +             if (btdev->pending_conn[i] =3D=3D remote) {
> > +                     btdev->pending_conn[i] =3D NULL;
> > +                     return true;
> > +             }
> > +     }
> > +     return false;
> > +}
> > +
> >  static void conn_complete(struct btdev *btdev,
> >                                       const uint8_t *bdaddr, uint8_t st=
atus)
> >  {
> >       struct bt_hci_evt_conn_complete cc;
> > +     struct btdev *remote =3D find_btdev_by_bdaddr(bdaddr);
> >
> >       if (!status) {
> >               struct btdev_conn *conn;
> > @@ -1223,6 +1252,8 @@ static void conn_complete(struct btdev *btdev,
> >               if (!conn)
> >                       return;
> >
> > +             pending_conn_del(conn->link->dev, btdev);
> > +
> >               cc.status =3D status;
> >               memcpy(cc.bdaddr, btdev->bdaddr, 6);
> >               cc.encr_mode =3D 0x00;
> > @@ -1240,6 +1271,8 @@ static void conn_complete(struct btdev *btdev,
> >               cc.link_type =3D 0x01;
> >       }
> >
> > +     pending_conn_del(btdev, remote);
> > +
> >       cc.status =3D status;
> >       memcpy(cc.bdaddr, bdaddr, 6);
> >       cc.encr_mode =3D 0x00;
> > @@ -1260,6 +1293,8 @@ static int cmd_create_conn_complete(struct btdev =
*dev, const void *data,
> >               memcpy(cr.dev_class, dev->dev_class, 3);
> >               cr.link_type =3D 0x01;
> >
> > +             pending_conn_add(dev, remote);
> > +
> >               send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(c=
r));
> >       } else {
> >               conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
> > @@ -1296,14 +1331,47 @@ static int cmd_add_sco_conn(struct btdev *dev, =
const void *data, uint8_t len)
> >       cc.encr_mode =3D 0x00;
> >
> >  done:
> > +     pending_conn_del(dev, conn->link->dev);
> > +
> >       send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
> >
> >       return 0;
> >  }
> >
> > +static bool match_bdaddr(const void *data, const void *match_data)
> > +{
> > +     const struct btdev_conn *conn =3D data;
> > +     const uint8_t *bdaddr =3D match_data;
> > +
> > +     return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
> > +}
> > +
> >  static int cmd_create_conn_cancel(struct btdev *dev, const void *data,
> >                                                       uint8_t len)
> >  {
> > +     const struct bt_hci_cmd_create_conn_cancel *cmd =3D data;
> > +     struct btdev *remote =3D find_btdev_by_bdaddr(cmd->bdaddr);
> > +     struct btdev_conn *conn;
> > +
> > +     /* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page =
1848
> > +      *
> > +      * If the connection is already established, and the
> > +      * HCI_Connection_Complete event has been sent, then the Controll=
er
> > +      * shall return an HCI_Command_Complete event with the error code
> > +      * Connection Already Exists (0x0B). If the HCI_Create_Connection=
_Cancel
> > +      * command is sent to the Controller without a preceding
> > +      * HCI_Create_Connection command to the same device, the BR/EDR
> > +      * Controller shall return an HCI_Command_Complete event with the=
 error
> > +      * code Unknown Connection Identifier (0x02).
> > +      */
> > +     if (!pending_conn_del(dev, remote)) {
> > +             conn =3D queue_find(dev->conns, match_bdaddr, cmd->bdaddr=
);
> > +             if (conn)
> > +                     return -EEXIST;
> > +
> > +             return -ENOENT;
> > +     }
> > +
> >       cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN_CANCEL=
);
>
> This should have been Command_Complete not Command_Status.

There is quite a few errors when Ive tried to compile this one:

emulator/btdev.c: In function =E2=80=98pending_conn_add=E2=80=99:
emulator/btdev.c:1221:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1221 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
emulator/btdev.c: In function =E2=80=98pending_conn_del=E2=80=99:
emulator/btdev.c:1233:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1233 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
cc1: all warnings being treated as errors
emulator/btdev.c: In function =E2=80=98pending_conn_add=E2=80=99:
emulator/btdev.c:1221:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1221 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
emulator/btdev.c: In function =E2=80=98pending_conn_del=E2=80=99:
emulator/btdev.c:1233:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1233 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
cc1: all warnings being treated as errors
make[1]: *** [Makefile:8484: emulator/android_android_tester-btdev.o] Error=
 1
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:7648: emulator/btdev.o] Error 1
emulator/btdev.c: In function =E2=80=98pending_conn_add=E2=80=99:
emulator/btdev.c:1221:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1221 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
emulator/btdev.c: In function =E2=80=98pending_conn_del=E2=80=99:
emulator/btdev.c:1233:23: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
 1233 |         for (i =3D 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
      |                       ^
cc1: all warnings being treated as errors


> For v2

Please have the errors fixed as well.

> >
> >       return 0;
> > @@ -1372,14 +1440,6 @@ static int cmd_link_key_reply(struct btdev *dev,=
 const void *data, uint8_t len)
> >       return 0;
> >  }
> >
> > -static bool match_bdaddr(const void *data, const void *match_data)
> > -{
> > -     const struct btdev_conn *conn =3D data;
> > -     const uint8_t *bdaddr =3D match_data;
> > -
> > -     return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
> > -}
> > -
> >  static void auth_complete(struct btdev_conn *conn, uint8_t status)
> >  {
> >       struct bt_hci_evt_auth_complete ev;
>


--=20
Luiz Augusto von Dentz
