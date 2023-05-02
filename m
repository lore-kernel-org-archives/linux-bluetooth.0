Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC81C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 16:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjEBQWo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 12:22:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343410D8
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 09:22:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so40309351fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683044536; x=1685636536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/NXhqQM3SFvQn4lhet+X4fvOmMKReAyLzS7MIS5Ql4=;
        b=ZjkRQlsarJpsbU9NHzhM0OWQtArlbzDDZVFu636WrWBC/E9FkDqG7akU30+XE4TbmM
         xyOjOncjmM5IVfYPzr6WX0xzNj60bEYBTi51Ptw4VgRK7K4f4PU7nimTXtrVVEf1jc61
         tzCjygAFAeFETa71QSj5moUTVt2YYZ5//vDKyjD/bSF/So5O8hsrkA+BOTa6WbdPVtC6
         IP8q1wWOHe0MiEvSq1Y3BJZA2ea3C/orQS3PMcNXsX4JV0kC01EdTriDANJNl0LrZIZ3
         o7RTy+fCMeRn7ARZDjuaMeL/Sj0Ex77PgVVAEfWQGy4nloynUjWE2G5uLgFGffXCgyYy
         49Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044536; x=1685636536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/NXhqQM3SFvQn4lhet+X4fvOmMKReAyLzS7MIS5Ql4=;
        b=a7mhLc06G1FlG28n7In8E+sBdtaV276Ga0MJuxro+ldnBKJORMwZw5lW+AwQGc1EJ2
         rxN/cqZgnsrNJnj3GgNaxNbJFFwzvxD6vRSgj3QgtkrD79wSH4AiaAseMwG/jdu3bC1h
         VhcbDNgfy/Zmjgu/RaMUgoTnsfZ21JLvdD5FMzxhUYgkqMsBemggY5FzYc3dvDXz5pML
         5MdW9/hf0vsj1oubjw/O+vRpD77wczS3Kca7aF7ROLFwz0WFPe8oQNof9wagOeBqrbZC
         yHbbv3XvIbMZCJd5v9sAXYrEr/UQKO1Ro4kby44jWX8pWOCCw+DSqHKC13i7GCdv24lk
         FgTg==
X-Gm-Message-State: AC+VfDyGgNy16l/z1KlJpjQd2t47fSGwOpEv8UDZFk3kE02v8tTl4Ryz
        GWYbGziT+FTip2EAgzEgQnJFVASgny8hsuDpSfM=
X-Google-Smtp-Source: ACHHUZ5aBr2CK2xO+1dFEOETUPN2mKrCQacQ51Lp3arf9YXMz6jJs8KBNUks7eOEeh5OD0AnHbwbDE9HLLvavzw+CnY=
X-Received: by 2002:ac2:5df0:0:b0:4eb:3021:3a8f with SMTP id
 z16-20020ac25df0000000b004eb30213a8fmr110205lfq.61.1683044535527; Tue, 02 May
 2023 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230502145737.140856-1-lrh2000@pku.edu.cn> <20230502145737.140856-5-lrh2000@pku.edu.cn>
In-Reply-To: <20230502145737.140856-5-lrh2000@pku.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 May 2023 09:22:03 -0700
Message-ID: <CABBYNZK=N6kwhpa=v35T8ReyR6-1BEy-yEFtxGbYPJxeOB1S0w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] Bluetooth: Perform hci_conn_drop in hci_conn_unlink
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
> Since hci_conn_link invokes both hci_conn_get and hci_conn_hold,
> hci_conn_unlink should perform both hci_conn_put and hci_conn_drop as
> well. However, currently it performs only hci_conn_put.
>
> This patch makes hci_conn_unlink call hci_conn_drop as well, which
> simplifies the logic in hci_conn_del a bit and may benefit future users
> of hci_conn_unlink. But it is noted that this change additionally
> implies that hci_conn_unlink can queue disc_work on conn itself, with
> the following call stack:
>
>         hci_conn_unlink(conn)  [conn->parent =3D=3D NULL]
>                 -> hci_conn_unlink(child)  [child->parent =3D=3D conn]
>                         -> hci_conn_drop(child->parent)
>                                 -> queue_delayed_work(&conn->disc_work)
>
> Queued disc_work after hci_conn_del can be spurious, so during the
> process of hci_conn_del, it is necessary to make the call to
> cancel_delayed_work(&conn->disc_work) after invoking hci_conn_unlink.
>
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
>  net/bluetooth/hci_conn.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index eef148291..e76ebb50d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1105,6 +1105,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
>         list_del_rcu(&conn->link->list);
>         synchronize_rcu();
>
> +       hci_conn_drop(conn->parent);
>         hci_conn_put(conn->parent);
>         conn->parent =3D NULL;
>
> @@ -1118,7 +1119,6 @@ void hci_conn_del(struct hci_conn *conn)
>
>         BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
>
> -       cancel_delayed_work_sync(&conn->disc_work);
>         cancel_delayed_work_sync(&conn->auto_accept_work);
>         cancel_delayed_work_sync(&conn->idle_work);
>
> @@ -1134,12 +1134,7 @@ void hci_conn_del(struct hci_conn *conn)
>                 else
>                         hdev->acl_cnt +=3D conn->sent;
>         } else {
> -               struct hci_conn *acl =3D conn->parent;
> -
> -               if (acl) {
> -                       hci_conn_unlink(conn);
> -                       hci_conn_drop(acl);
> -               }
> +               hci_conn_unlink(conn);
>
>                 /* Unacked ISO frames */
>                 if (conn->type =3D=3D ISO_LINK) {
> @@ -1152,6 +1147,11 @@ void hci_conn_del(struct hci_conn *conn)
>                 }
>         }
>
> +       /* hci_conn_unlink may trigger additional disc_work, so
> +        * ensure to perform cancelling after that.
> +        */
> +       cancel_delayed_work_sync(&conn->disc_work);

Just merge the change where hci_conn_del calls hci_conn_unlink
unconditionally so we don't have to do this change independently just
to revert later.

>         if (conn->amp_mgr)
>                 amp_mgr_put(conn->amp_mgr);
>
> --
> 2.40.0
>


--=20
Luiz Augusto von Dentz
