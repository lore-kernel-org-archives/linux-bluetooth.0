Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D549EE14C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 19:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbjIFTwn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjIFTwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 15:52:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5801990
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 12:52:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007c8308c3so270274e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694029953; x=1694634753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu67ueEA1lsDoB5SVNSMXVY1VZr+2PoxdrAVtDHjP6c=;
        b=V8E3Pog9neOVGEYyYPrkz73SE/ewYh0SMtvMlldGzwq86LxluP5uZrnZFqfg0q8lTF
         t3yaZz4OFTbMnB2kpeUHpIkN/q1Fa8qIL/cCLbsVIUhAX9pC2b/EX5Y/6nxE0Itd25eM
         bNeLiBAuAAXR669XBGMzWdIvlqhOcwXqABjrfeWhqhytoL/Sp7ZPOS5omRAOkoVlRLbv
         3AXICSL7jJAQ/657s7cIwbfZtY7U9xw0mFxUcFFLVP4hN8KNOJoRVk88ONz9aU45S+Tp
         Fs/yGNtrYpxi9yEe9sWdvgvyub2QnGVnsFmPOfP6QhO/UTkKxM2rVyC/wscOhla0LW3A
         AwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694029953; x=1694634753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu67ueEA1lsDoB5SVNSMXVY1VZr+2PoxdrAVtDHjP6c=;
        b=F3ebIVjogPcoEsdItFxyspg2N4ytk5pVBP5RVSyaLT4279ic9Rt0DjgND/mlS+8/QX
         O9/0vOWH7lYUpnh9EQcEqaL+Y+F615zbfo8kDYk1tvoSpCbzXztcwgSmZup6lYiBq4dk
         r+awC57eTR024sxW76Dzbcl+8/OXsF+51RvNedjjKDyqLyJr0fJXwm0DyxpNzsPLwqIC
         C1eUu3UMO+n3xxwKzOPLA0xjrHVuKzajhzaKx1lD2VSqIjYvdJ+VLJwNYVhV/FCOPSat
         1KqOgcXYffh5yDk57nW+FHIzog6vzt2yDdhC9Y5fBEfPtYesWWbdRkVsdC592y/rFeol
         33Wg==
X-Gm-Message-State: AOJu0YzgCxFOZ+/AkFoEq8QsoQ8HDGd9zYwNbh8f4xhI0McXREuJWWYZ
        tqOFk4y0S+AHhn3P5Ig0PFqUosNZM79hDjI4NyQIi/NP
X-Google-Smtp-Source: AGHT+IHh8Xm6IGI66bfWtOZ/i60ZNM2Fa3xzVP82N1sFwN8x6fHji5M7qb6jIZ9SBQwiJIQV9YfSlaWfm1+vYo1mlNU=
X-Received: by 2002:a05:651c:1050:b0:2b9:ed84:b2bf with SMTP id
 x16-20020a05651c105000b002b9ed84b2bfmr3096932ljm.33.1694029952649; Wed, 06
 Sep 2023 12:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230906135954.9165-1-iulia.tanasescu@nxp.com> <20230906135954.9165-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230906135954.9165-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Sep 2023 12:52:20 -0700
Message-ID: <CABBYNZKvoxonv97aGfT8=9K_riFPaXKLVuuaVca+ox3heSV6_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Fix BIS cleanup
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Wed, Sep 6, 2023 at 7:00=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
> no HCI disconnect command should be issued. A master BIS should only be
> terminated by disabling periodic and extended advertising, and terminatin=
g
> the BIG.
>
> In case of a Broadcast Receiver, all BIS and PA connections can be
> cleaned up by calling hci_conn_failed, since it contains all function
> calls that are necessary for successful cleanup.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_sync.h |  2 ++
>  net/bluetooth/hci_conn.c         |  7 +++++++
>  net/bluetooth/hci_sync.c         | 28 ++++++++++++----------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index 57eeb07aeb25..6efbc2152146 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -80,6 +80,8 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 ins=
tance, u8 data_len,
>                            u8 *data, u32 flags, u16 min_interval,
>                            u16 max_interval, u16 sync_interval);
>
> +int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
> +
>  int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
>                                 u8 instance, bool force);
>  int hci_disable_advertising_sync(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9d5057cef30a..7c8a5cc72e89 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -759,6 +759,7 @@ static int terminate_big_sync(struct hci_dev *hdev, v=
oid *data)
>
>         bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", d->big, d->bis);
>
> +       hci_disable_per_advertising_sync(hdev, d->bis);
>         hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
>
>         /* Only terminate BIG if it has been created */
> @@ -1247,6 +1248,12 @@ void hci_conn_failed(struct hci_conn *conn, u8 sta=
tus)
>                 break;
>         }
>
> +       /* In case of BIG/PA sync failed, clear conn flags so that
> +        * the conns will be correctly cleaned up by ISO layer
> +        */
> +       test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags);
> +       test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags);
> +

I guess we can just use clear_bit here since we won't be using their return=
.

>         conn->state =3D BT_CLOSED;
>         hci_connect_cfm(conn, status);
>         hci_conn_del(conn);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index fd7c5d902856..ec4dfc4c5749 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1312,7 +1312,7 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8=
 instance)
>         return hci_enable_ext_advertising_sync(hdev, instance);
>  }
>
> -static int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 ins=
tance)
> +int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
>  {
>         struct hci_cp_le_set_per_adv_enable cp;
>         struct adv_info *adv =3D NULL;
> @@ -5231,6 +5231,17 @@ static int hci_disconnect_sync(struct hci_dev *hde=
v, struct hci_conn *conn,
>         if (conn->type =3D=3D AMP_LINK)
>                 return hci_disconnect_phy_link_sync(hdev, conn->handle, r=
eason);
>
> +       if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
> +               /* This is a BIS connection, hci_conn_del will
> +                * do the necessary cleanup.
> +                */
> +               hci_dev_lock(hdev);
> +               hci_conn_failed(conn, reason);
> +               hci_dev_unlock(hdev);
> +
> +               return 0;
> +       }
> +
>         memset(&cp, 0, sizeof(cp));
>         cp.handle =3D cpu_to_le16(conn->handle);
>         cp.reason =3D reason;
> @@ -5382,21 +5393,6 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
>                 err =3D hci_reject_conn_sync(hdev, conn, reason);
>                 break;
>         case BT_OPEN:
> -               hci_dev_lock(hdev);
> -
> -               /* Cleanup bis or pa sync connections */
> -               if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->f=
lags) ||
> -                   test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->fl=
ags)) {
> -                       hci_conn_failed(conn, reason);
> -               } else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
> -                          test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
> -                       conn->state =3D BT_CLOSED;
> -                       hci_disconn_cfm(conn, reason);
> -                       hci_conn_del(conn);
> -               }
> -
> -               hci_dev_unlock(hdev);
> -               return 0;
>         case BT_BOUND:
>                 hci_dev_lock(hdev);
>                 hci_conn_failed(conn, reason);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
