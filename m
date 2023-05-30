Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350B1C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjE3Rqp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjE3Rqm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 13:46:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6677A103
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 10:46:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f122ff663eso5347476e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468795; x=1688060795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKrPba1smsBTzj3uioyjMa1UsP+6ITA3b8/sqx9fciw=;
        b=bz1QEpSAAqI93v2o1uHdsWDeEh5D0nq8fs1G/b1NCPCwvbtiVStDFEKvw3brxtQVd3
         Gxxf6K75zQSaJyROerFJ5JW2jZPaYCEib75+t4lVhrK3+5dQ/T9bUWSt89a3ylmVIR87
         9BWbu6gc56km3lJMJ/q74cD6a+QsWwsrbxedzf4+GClNJLJnW1kgGgFsfV7S6Ap0rWgO
         x8+ly3LvU6yPXmK402ITzNOpSdEa6cpONUXVv1kdboIs8N4lxg4J5y9bHIT0NVGsW9IJ
         9r7BOBI3nnIAnodGkHCDVMYBp6gjiRgFrN2j+q5WxxjEmCwnbIBaO2BRH7viiQzonYc7
         u07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468795; x=1688060795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKrPba1smsBTzj3uioyjMa1UsP+6ITA3b8/sqx9fciw=;
        b=RWiOnpIc2KUShSGk1oKpMY3eMgroR/FeYrxskExLclx8Zzn2g4uDn5qhRWkjI4YrrR
         srHFjRGALk/Jox8BydomPZkjiZHUnyg7+Shzh5ktPDt243i9HN2s7noLpCkNv7DA1/ov
         trL6R2pTWj4p6HdeO2Y21p4DP3jDnh43weURZ0jJ59bGpe+u/fHAd8ms7RS64apmpo7/
         83+GajSXkM3g/Ug6rGLG2xY7HNm0p8eiUdIp7BDTKhkAm6oyhJr++qv1wnrkPwJTobEB
         r1roL3jASCnWLX5BTdQceM2vmQSniMHz2GI1xG2nLmYQQb/8OY/TUYP7S8TNpNbsdnUd
         xS/g==
X-Gm-Message-State: AC+VfDwvyGDVQQwpyMfvbcU+tPr/XKmBQcM150TEc2UfcWmwHxoWMJpo
        4d0g6RnHjldmlLWpGiPCZveySWOJZroeKtjH8mQ=
X-Google-Smtp-Source: ACHHUZ61cpdGb+t3XQDIkYbAQVYcvj0jmf/SJmX1gW+yiBWDtKa/fshUGzFEJ9hcq0xdfLkNqR8kfm3eBXtPCLrmLI8=
X-Received: by 2002:a2e:924b:0:b0:2ac:763a:1315 with SMTP id
 v11-20020a2e924b000000b002ac763a1315mr1348443ljg.12.1685468795174; Tue, 30
 May 2023 10:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685294131.git.pav@iki.fi> <bcae59679f7387e6f5f3e6da79827da4cc341870.1685294131.git.pav@iki.fi>
In-Reply-To: <bcae59679f7387e6f5f3e6da79827da4cc341870.1685294131.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 May 2023 10:46:23 -0700
Message-ID: <CABBYNZJMhzXMPtdDgua1=ABKUd6TLCgG2=OFL=Ame9P7WUL_Dg@mail.gmail.com>
Subject: Re: [PATCH 5/6] Bluetooth: ISO: use correct CIS order in Set CIG
 Parameters event
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, May 28, 2023 at 10:49=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> The order of CIS handle array in Set CIG Parameters response shall match
> the order of the CIS_ID array in the command (Core v5.3 Vol 4 Part E Sec
> 7.8.97).  We send CIS_IDs mainly in the order of increasing CIS_ID (but
> with "last" CIS first if it has fixed CIG_ID).  In handling of the
> reply, we currently assume this is also the same as the order of
> hci_conn in hdev->conn_hash, but that is not true.
>
> Match the correct hci_conn to the correct handle by matching them based
> on the CIG+CIS combination.  The CIG+CIS combination shall be unique for
> ISO_LINK hci_conn at state >=3D BT_BOUND, which we maintain in
> hci_le_set_cig_params.
>
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connec=
tions")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/hci_event.c | 66 +++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 16 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d00ef6e3fc45..71d8f1442287 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3804,43 +3804,77 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev=
 *hdev, void *data,
>                                    struct sk_buff *skb)
>  {
>         struct hci_rp_le_set_cig_params *rp =3D data;
> +       struct hci_cp_le_set_cig_params *cp;
>         struct hci_conn *conn;
> -       int i =3D 0;
> +       u16 handles[0x1f];
> +       int num_handles;
> +       u8 status =3D rp->status;
> +       int i;
>
>         bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
>
> +       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
> +       if (!cp || rp->num_handles !=3D cp->num_cis || rp->cig_id !=3D cp=
->cig_id ||
> +           rp->num_handles > ARRAY_SIZE(handles)) {
> +               bt_dev_err(hdev, "unexpected Set CIG Parameters response =
data");
> +               status =3D HCI_ERROR_UNSPECIFIED;
> +       }
> +
>         hci_dev_lock(hdev);
>
> -       if (rp->status) {
> +       if (status) {
>                 while ((conn =3D hci_conn_hash_lookup_cig(hdev, rp->cig_i=
d))) {
>                         conn->state =3D BT_CLOSED;
> -                       hci_connect_cfm(conn, rp->status);
> +                       hci_connect_cfm(conn, status);
>                         hci_conn_del(conn);
>                 }
>                 goto unlock;
>         }
>
> +       /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page =
2553
> +        *
> +        * If the Status return parameter is zero, then the Controller sh=
all
> +        * set the Connection_Handle arrayed return parameter to the conn=
ection
> +        * handle(s) corresponding to the CIS configurations specified in
> +        * the CIS_IDs command parameter, in the same order.
> +        */
> +
> +       num_handles =3D rp->num_handles;
> +       for (i =3D 0; i < rp->num_handles; ++i)
> +               handles[i] =3D __le16_to_cpu(rp->handle[i]);

Using the request is a good idea but the code below sounds a little
too complicated, can we just lookup the hci_conn by cig/cis at this
point using the request parameters and just assign the handle in a
single loop?

>         rcu_read_lock();
>
>         list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> -               if (conn->type !=3D ISO_LINK ||
> -                   conn->iso_qos.ucast.cig !=3D rp->cig_id ||
> -                   conn->state =3D=3D BT_CONNECTED)
> +               if (conn->type !=3D ISO_LINK || !bacmp(&conn->dst, BDADDR=
_ANY) ||
> +                   (conn->state !=3D BT_BOUND && conn->state !=3D BT_CON=
NECT) ||
> +                   conn->iso_qos.ucast.cig !=3D rp->cig_id)
>                         continue;
>
> -               conn->handle =3D __le16_to_cpu(rp->handle[i++]);
> +               for (i =3D 0; i < rp->num_handles; ++i) {
> +                       if (handles[i] =3D=3D HCI_CONN_HANDLE_UNSET)
> +                               continue;
> +                       if (conn->iso_qos.ucast.cis !=3D cp->cis[i].cis_i=
d)
> +                               continue;
>
> -               bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
> -                          conn->handle, conn->parent);
> +                       conn->handle =3D handles[i];
> +                       handles[i] =3D HCI_CONN_HANDLE_UNSET;
> +                       --num_handles;
>
> -               /* Create CIS if LE is already connected */
> -               if (conn->parent && conn->parent->state =3D=3D BT_CONNECT=
ED) {
> -                       rcu_read_unlock();
> -                       hci_le_create_cis(conn);
> -                       rcu_read_lock();
> +                       bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p",
> +                                  conn, conn->handle, conn->parent);
> +
> +                       /* Create CIS if LE is already connected */
> +                       if (conn->parent &&
> +                           conn->parent->state =3D=3D BT_CONNECTED) {
> +                               rcu_read_unlock();
> +                               hci_le_create_cis(conn);
> +                               rcu_read_lock();
> +                       }
> +
> +                       break;
>                 }
> -
> -               if (i =3D=3D rp->num_handles)
> +               if (!num_handles)
>                         break;
>         }
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
