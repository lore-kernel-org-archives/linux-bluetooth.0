Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25852C0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjG0VY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjG0VYR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 17:24:17 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BE1B8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:23:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b97f34239cso21369681fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690493022; x=1691097822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v/h5cCsQrW4ln+fS02QRsQUzam6Cdj4Xv6G23fl90c=;
        b=VLY5vwkX6Vx4h1L/IevhWw9T352QfvprylCpICLBviLzNJsz9Y5pUeyJVYbvLzLYg/
         yYUqCdC3SIsyd03tEOh0x+xNCW4iCY4ed41h1E/vOayTaK/bUiTpYswPUJm6ZO+PetLO
         WLf73SVAPBN4TTHBOj4T+Gi3Ia9XRwvBbrKhhWsnLlsGO9IPc1NBR55HtBTWb2JqRRK8
         u+fCLHoEdig25rD8ik6KyymhpeB+T3wTVjfVItt97OGOoOIAunwRDvygrMmDb1NHiiHa
         TjueUlI8VjlnXly0QR2vUR60I1lI2aV7xo8Nd9dyRINFegUgjXoB913Q6jwrXoAP7Ddk
         q7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493022; x=1691097822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v/h5cCsQrW4ln+fS02QRsQUzam6Cdj4Xv6G23fl90c=;
        b=kLZxlL7JVcHCud2I7FiuntKkeoKRBR+BtT/n4+IN0v4HbCUSBEiWgA56Q2AUeGFJYm
         8HAxI2+mAzXmLC+Bm77KTtkhTlHOS87KJxt8EUfVy94b9r4h5RDSVatQrlWWkznJ2pxe
         PNMvAcMg7WMmifTkR4zsv6RFjsMJnGdKcpV+u3hya85opS3UXX3EumOZrP9R7kjTlQbK
         KdICFHesd+g4PdspyGn6JuqVngi/Qx21ScBLgjulTdR/oPvsTc1fA/nxkiMh3Vv+Shfh
         kl7IEDE52hl7OfTts1JTVv+H7OVWs3VejkYDk/SmC5f3urZzRCMRW2x0szboDQKLzCm9
         QTmA==
X-Gm-Message-State: ABy/qLYj2mCbvtibrWLUKVRYGekLi0Btb4630GyLvUa+UC7l/MimK69L
        YijgTgM9MOxCc3UyLRMdqabaQyeilwxAYWUTXzmBLQWrcWg=
X-Google-Smtp-Source: APBJJlFvU7Z26g/E4zA1hk7fR8NzxdztJpAMDNyo91b0EAAMKuZNClZKDJxg9eJCa3oWu3zuuMWV0DGci9wBtnFGiaA=
X-Received: by 2002:a2e:7013:0:b0:2b9:5b46:2107 with SMTP id
 l19-20020a2e7013000000b002b95b462107mr198648ljc.9.1690493021517; Thu, 27 Jul
 2023 14:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690399379.git.pav@iki.fi> <6d9672c9a1e97b87e823e05ff07576013683979d.1690399379.git.pav@iki.fi>
In-Reply-To: <6d9672c9a1e97b87e823e05ff07576013683979d.1690399379.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 14:23:29 -0700
Message-ID: <CABBYNZLfL0BFoctaCuxp8xwbhk9kWa=FRC7w1Gh7GnTURa1_jg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] Bluetooth: hci_sync: delete CIS in
 BT_OPEN/CONNECT/BOUND when aborting
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jul 26, 2023 at 2:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Dropped CIS that are in state BT_OPEN/BT_BOUND, and in state BT_CONNECT
> with HCI_CONN_CREATE_CIS unset, should be cleaned up immediately.
> Closing CIS ISO sockets should result to the hci_conn be deleted, so
> that potentially pending CIG removal can run.
>
> hci_abort_conn cannot refer to them by handle, since their handle is
> still unset if Set CIG Parameters has not yet completed.
>
> This fixes CIS not being terminated if the socket is shut down
> immediately after connection, so that the hci_abort_conn runs before Set
> CIG Parameters completes. See new BlueZ test "ISO Connect Close - Success=
"
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/hci_sync.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 101548fe81da..3926213c29e6 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5339,6 +5339,10 @@ static int hci_connect_cancel_sync(struct hci_dev =
*hdev, struct hci_conn *conn,
>                 if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
>                         return hci_disconnect_sync(hdev, conn, reason);
>
> +               /* CIS with no Create CIS sent have nothing to cancel */
> +               if (bacmp(&conn->dst, BDADDR_ANY))
> +                       return HCI_ERROR_LOCAL_HOST_TERM;
> +
>                 /* There is no way to cancel a BIS without terminating th=
e BIG
>                  * which is done later on connection cleanup.
>                  */
> @@ -5426,9 +5430,17 @@ int hci_abort_conn_sync(struct hci_dev *hdev, stru=
ct hci_conn *conn, u8 reason)
>         case BT_CONNECT2:
>                 return hci_reject_conn_sync(hdev, conn, reason);
>         case BT_OPEN:
> -               /* Cleanup bises that failed to be established */
> -               if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->f=
lags))
> +               /* Cleanup failed CIS, and BIS that failed to be establis=
hed */
> +               if (bacmp(&conn->dst, BDADDR_ANY) ||
> +                   test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->f=
lags))

bacmp(&conn->dst, BDADDR_ANY) will match connections other than
ISO_LINK as well so I wonder if this is intentional? If it is then we
need to update the commands to reflect that we are going to call
hci_conn_failed, it seems we didn't call it before but perhaps this is
a side effect of the other changes.

> +                       hci_conn_failed(conn, reason);
> +               break;
> +       case BT_BOUND:
> +               /* Bound CIS should be cleaned up */
> +               if (conn->type =3D=3D ISO_LINK && bacmp(&conn->dst, BDADD=
R_ANY))
>                         hci_conn_failed(conn, reason);
> +               else
> +                       conn->state =3D BT_CLOSED;
>                 break;
>         default:
>                 conn->state =3D BT_CLOSED;
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
