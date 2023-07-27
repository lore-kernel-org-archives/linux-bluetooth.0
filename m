Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC14FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 21:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjG0VOq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjG0VOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 17:14:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133830E8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:14:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so81661fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492480; x=1691097280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiVRTdjFt/Z7OFloTzJqtml5t96Fgi0YT61TCdmMZXM=;
        b=Ssria+1WAr3iKr/pzMblSBcgOg2G3GROqvOXqOXJOefwxDrCYosJ8HHxAWxAwEEZRf
         E7LTbU1bVArcDZU8Am7pcuvfu069V5FA5VOzFHGDZb1f9OdPYvu3T6NRkfoClO6ad2fq
         bVcbohxLK4yFWKpjgRJWw4WVXwPpUBygDA0cR4TGtRCn/mIz2UgbJjTudnbkugcsrKyD
         P2F90lnxle8FRUaT794rQaCQLBT6hV2tk2O8Pyw+pYOGVdcVfyrTkSjiP6wf70yTtoGf
         +Y87VFvai9+ljf2NVrecGdyL8xg+BeEXGuy29YYrJtExgqaDhklz9oyCmMY+kJIJvA9Z
         4TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492480; x=1691097280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiVRTdjFt/Z7OFloTzJqtml5t96Fgi0YT61TCdmMZXM=;
        b=FE7Mp01qoMGWvg2RhVkamG2fH+dVTUnbh3WGamchdJ7waFIekZlF92hZVafssVbwDg
         mfEsH0uy5X/gXEz6ypK6AXhTAXJ7wzT/cFpSU5Sw1QpnntTVSwhxKhj4BvRjsBsZtwUT
         b2Aw7zdnPJzJjH36aT5O1u1R1oP3J1FOqBH8KrGvcm6DREU17HL+yPDMvOuNfnUYuS7R
         5PwPcITUkVywk6MOPsd2LX/t/UXRotiVIyQ7cijBvvuopBpkI4Q/Hu1+e88587sp0J5V
         5nHsO7eiMY8PLpOS0+Py2aEgP1mYSv+sgego4SDD+Ibfb8o0pESQvcLi2D8Lq8qkLqD5
         LjtA==
X-Gm-Message-State: ABy/qLb6MgdvnIf3+y6o2GI5S+ULBY8/dDMen5p+C+5UkmXUXrw6Kn7P
        0J1a57KqrZD8MSBsB5cEcyv7HE2jEize+IeNviI=
X-Google-Smtp-Source: APBJJlHwV6czDBti7UJlX7PnykBGbb6coMa/TsOU70BQFS2+HZrTEsNLaoVqBrz17VxLt69ZJ4kHU6gGDBTssL3B4/M=
X-Received: by 2002:a2e:a486:0:b0:2b9:c2dc:619c with SMTP id
 h6-20020a2ea486000000b002b9c2dc619cmr1186730lji.10.1690492479657; Thu, 27 Jul
 2023 14:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690399379.git.pav@iki.fi> <f02203d5565bbe78c2406ca45a5a72336a1315ea.1690399379.git.pav@iki.fi>
In-Reply-To: <f02203d5565bbe78c2406ca45a5a72336a1315ea.1690399379.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 14:14:27 -0700
Message-ID: <CABBYNZK-im2S7KnbBuP7Bq4V8yvJa-KZ5fZkW7zySepDY9DNTA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] Bluetooth: ISO: handle bound CIS cleanup via hci_conn
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jul 26, 2023 at 2:37=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Calling hci_conn_del in __iso_sock_close is invalid. It needs
> hdev->lock, but it cannot be acquired there due to lock ordering.
>
> Fix this by doing cleanup via hci_conn_drop.
>
> Return hci_conn with refcount 1 from hci_bind_cis and hci_connect_cis,
> so that the iso_conn always holds one reference.  This also fixes
> refcounting when error handling.
>
> Since hci_conn_abort shall handle termination of connections in any
> state properly, we can handle BT_CONNECT socket state in the same way as
> BT_CONNECTED.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/hci_conn.c |  5 +++++
>  net/bluetooth/iso.c      | 14 +-------------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ba339a0eb851..33fbdc8e0748 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1901,6 +1901,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev,=
 bdaddr_t *dst,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       hci_conn_hold(cis);
> +
>         cis->iso_qos =3D *qos;
>         cis->state =3D BT_BOUND;
>
> @@ -2254,6 +2256,9 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hd=
ev, bdaddr_t *dst,
>                 return ERR_PTR(-ENOLINK);
>         }
>
> +       /* Link takes the refcount */
> +       hci_conn_drop(cis);
> +
>         cis->state =3D BT_CONNECT;
>
>         hci_le_create_cis_pending(hdev);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index cbe3299b4a41..358954bfbb32 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -628,6 +628,7 @@ static void __iso_sock_close(struct sock *sk)
>                 iso_sock_cleanup_listen(sk);
>                 break;
>
> +       case BT_CONNECT:
>         case BT_CONNECTED:
>         case BT_CONFIG:
>                 if (iso_pi(sk)->conn->hcon) {
> @@ -643,19 +644,6 @@ static void __iso_sock_close(struct sock *sk)
>                 break;
>
>         case BT_CONNECT2:
> -               iso_chan_del(sk, ECONNRESET);
> -               break;
> -       case BT_CONNECT:
> -               /* In case of DEFER_SETUP the hcon would be bound to CIG =
which
> -                * needs to be removed so just call hci_conn_del so the c=
leanup
> -                * callback do what is needed.
> -                */
> -               if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
> -                   iso_pi(sk)->conn->hcon) {
> -                       hci_conn_del(iso_pi(sk)->conn->hcon);
> -                       iso_pi(sk)->conn->hcon =3D NULL;
> -               }
> -
>                 iso_chan_del(sk, ECONNRESET);
>                 break;
>         case BT_DISCONN:
> --
> 2.41.0

I guess this sort of fix can be sent separately which I guess helps
here since we can prioritize the ones that don't have side effects.

--=20
Luiz Augusto von Dentz
