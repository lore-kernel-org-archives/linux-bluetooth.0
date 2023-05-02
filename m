Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72520C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 16:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjEBQSX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjEBQSW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 12:18:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BBC1984
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 09:18:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ab25e8a4a7so39674261fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683044295; x=1685636295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWvsqDOsA3cc53eqEMTqO0Umsf+DzK5drqWkHB4m/4o=;
        b=qNEK5tIipJNrkEtGDdEo9T1W2ntjbW25tCK28xLU2cRJl4quIta71fsj6zAlgUO1fx
         3gu6GB4opc7IaW33WcWLCv9DDmR8OWeVp9G9E7V3OY8mpGlltRom5dV4AuL1myRM9q1R
         5tRRYrMyNYQvbbKb5Uq57s/GAaB+4m8oDIOTcqMzs83IIlePKwxQUR3uovQEf3otRMaU
         YHsgf031s1VGRzdx22zL8QtCpEu16ztu94aS56CQOTiyIjdPREQpuTnVKCvQeFgR4ffL
         2XFxnfGPdMvwNc7+n4r/LoreXTmvi10xjse9y2L9ftfMRunZzWURQiJ5IzgA72VeofR6
         /lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044295; x=1685636295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWvsqDOsA3cc53eqEMTqO0Umsf+DzK5drqWkHB4m/4o=;
        b=mAYS6aapYD3eHj0wcogsA8rvcZ+MC4OW9z81xe7kxn3NBVqxafznG9i+TtYKpFmJgI
         WXFkJxwvcfC36tjGLDZzqXtKycjyJsKj3g0PPG0R+RwWP3nUfEiaXMhsf7LMbi/VHG8E
         xW61mFwulOyHuDz/gEesujc5W7VWTrH8W8AOLW7d5kJYZULoVFxlTGJqFk/O17p2GOHC
         LfR6/cyGU7gPaHRi6F2n3h77/kYXlw8uAPU8p1QtpA5/ffEcmdl+Y5On6KWU3lVialsC
         09z87HG9nV6vtZitmSwPkhFYBnJLQaH+W0EvveS+Z2yzo0GEKCgkclfsR26Fke0ShOkN
         rH+A==
X-Gm-Message-State: AC+VfDyYKuOR8s0JfOyRPVRXbJZuP88O0papdQ0vLJgpQISH5vi7t9sW
        1NTRZGDl/AVFljr+DsXcmTQnoATyE4rAkhdD0bpDXtX0
X-Google-Smtp-Source: ACHHUZ7SDwm++I42qUZpB+3FcjyzfUTzuzHY9fWtabSYZO9RfLIfm9fKm8I68NLsK2iY88oGVMBh6By0EMmb55LbVgU=
X-Received: by 2002:a2e:97c4:0:b0:2a8:ca28:e4e with SMTP id
 m4-20020a2e97c4000000b002a8ca280e4emr4871599ljj.24.1683044294683; Tue, 02 May
 2023 09:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230502145737.140856-1-lrh2000@pku.edu.cn> <20230502145737.140856-7-lrh2000@pku.edu.cn>
In-Reply-To: <20230502145737.140856-7-lrh2000@pku.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 May 2023 09:18:02 -0700
Message-ID: <CABBYNZJS3QLbCPizwaTaKmy13+34vNLFo2YMy2cMS3zwvVeZsw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] Bluetooth: Avoid recursion in hci_conn_unlink
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ruihan,

On Tue, May 2, 2023 at 7:57=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> wrote=
:
>
> Previously, hci_conn_unlink was implemented as a recursion function. To
> unlink physical connections (e.g. ACL/LE), it calls itself to unlink all
> its logical channels (e.g. SCO/eSCO/ISO).
>
> Recursion is not required. This patch refactors hci_conn_unlink into two
> functions, where hci_conn_unlink_parent takes a physical connection,
> checks out all its logical channels, and calls hci_conn_unlink_child for
> each logical channel to unlink it.
>
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
>  net/bluetooth/hci_conn.c | 55 +++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index de553e062..243d68a64 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1074,34 +1074,13 @@ struct hci_conn *hci_conn_add(struct hci_dev *hde=
v, int type, bdaddr_t *dst,
>         return conn;
>  }
>
> -static void hci_conn_unlink(struct hci_conn *conn)
> +static void hci_conn_unlink_parent(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
>
>         bt_dev_dbg(hdev, "hcon %p", conn);
>
> -       if (!conn->parent) {
> -               struct hci_link *link, *t;
> -
> -               list_for_each_entry_safe(link, t, &conn->link_list, list)=
 {
> -                       struct hci_conn *child =3D link->conn;
> -
> -                       hci_conn_unlink(child);
> -
> -                       /* Due to race, SCO connection might be not estab=
lished
> -                        * yet at this point. Delete it now, otherwise it=
 is
> -                        * possible for it to be stuck and can't be delet=
ed.
> -                        */
> -                       if ((child->type =3D=3D SCO_LINK ||
> -                            child->type =3D=3D ESCO_LINK) &&
> -                           child->handle =3D=3D HCI_CONN_HANDLE_UNSET)
> -                               hci_conn_del(child);
> -               }
> -
> -               return;
> -       }
> -
> -       if (!conn->link)
> +       if (WARN_ON(!conn->link))
>                 return;
>
>         list_del_rcu(&conn->link->list);
> @@ -1115,6 +1094,36 @@ static void hci_conn_unlink(struct hci_conn *conn)
>         conn->link =3D NULL;
>  }
>
> +static void hci_conn_unlink_children(struct hci_conn *conn)
> +{
> +       struct hci_dev *hdev =3D conn->hdev;
> +       struct hci_link *link, *t;
> +
> +       bt_dev_dbg(hdev, "hcon %p", conn);
> +
> +       list_for_each_entry_safe(link, t, &conn->link_list, list) {
> +               struct hci_conn *child =3D link->conn;
> +
> +               hci_conn_unlink_parent(child);
> +
> +               /* Due to race, SCO connection might be not established
> +                * yet at this point. Delete it now, otherwise it is
> +                * possible for it to be stuck and can't be deleted.
> +                */
> +               if (child->type =3D=3D SCO_LINK || child->type =3D=3D ESC=
O_LINK)
> +                       if (child->handle =3D=3D HCI_CONN_HANDLE_UNSET)
> +                               hci_conn_del(child);
> +       }

This is not quite right, when we are unlinking the children's hci_conn
it shall only unlink itself from the parent not everything.

> +}
> +
> +static void hci_conn_unlink(struct hci_conn *conn)
> +{
> +       if (conn->parent)
> +               hci_conn_unlink_parent(conn);
> +       else
> +               hci_conn_unlink_children(conn);
> +}
> +
>  void hci_conn_del(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> --
> 2.40.0
>


--=20
Luiz Augusto von Dentz
