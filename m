Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFFC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjEVS4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEVS4T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 14:56:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D61CA
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:56:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so25160631fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684781773; x=1687373773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1gsl5gsQwhLK6V6M+qoxSTNog7cnLfbHC3DN7I//Uc=;
        b=jV0zRuC3DBAxvubJG5IgoPrNlYjT8wFziD5/4uGJyrVCqJxipv2lwfUUe8rW4W0lHW
         Sj3zYgVcALwgK/QAn0leEg35jqwhhmPDRSXNKWRogehB1qbRxRbN/YBTPpiCKzwXWkKo
         pxbJcxocVxeAG65oaDIv+QzI59ofxwGu1wiTOOToPNrra5Zztzzg/hc3w6Q9fizLyjXL
         OUOCW4Ane2iJweMb7i6JfpO8iQbenMCzpL5R7V6wrAbdO9+ho9vp/7GdlZUAIa/0r7vk
         v/pj3X/RhJIBd0F1RCqa92ZrOqL1lRBAVxK4vcrGQld/EhxSIHHL0RU9BFVf+6Uoh8Bn
         XTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781773; x=1687373773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1gsl5gsQwhLK6V6M+qoxSTNog7cnLfbHC3DN7I//Uc=;
        b=DptscoACPE47Of1Bze69+avTcSL6KaOWeUwxVSnJGx0IQ4HXnohSXEJaUkhPI46KSW
         0sHu0dGN+0o4OlwCGo1QhzBsbYsP0/17VTfjzKc3yLUHAlhtobZxaoiD5WLwu/Cb9Wff
         yCjvmSPxQ4PG4Kms31J0uTizl3VmdBf4Jch4YeFZTDfPfBzJqqmTCneIhY9xVEi7MTjO
         K8jLZtNqQFWYp9n4C2i6/0mndUYO+6vSGSlDtrpuKv9AsfcjI/exr3McIWxtNuUxTzXI
         4Z1cxT8jP6JO/Y6mOP5xOdq02t2qzbtA0ue79Z8gi7YuhPHswLtKyKU6PN1gLiQuRj5J
         bokQ==
X-Gm-Message-State: AC+VfDx+pFFdBiSq5bqELHBv2fwSy4dMn2g6kyVR5+ajr9wMm9tQl4nF
        43awgtc5ANtOV+iR3A3p0hFsa6EvcfkS7kUdLks=
X-Google-Smtp-Source: ACHHUZ4xLirSpas+Of1PtO9WuH9mEb1qHNq8ixxu4c2bogLAVSWVG6EUpcnZMm/2eoV9+FGzUHIrqhcz25qvpqm6t/Y=
X-Received: by 2002:a2e:3a08:0:b0:2ac:8000:1ea0 with SMTP id
 h8-20020a2e3a08000000b002ac80001ea0mr4533229lja.26.1684781772329; Mon, 22 May
 2023 11:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
In-Reply-To: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 May 2023 11:56:00 -0700
Message-ID: <CABBYNZLbXfJsS7BJVjqy-V8uSY4hvpCfeh6y+zqqwO13xrr0gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: ISO: consider right CIS when removing CIG
 at cleanup
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, May 21, 2023 at 8:52=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> When looking for CIS blocking CIG removal, consider only the CIS with
> the right CIG ID. Don't try to remove CIG with unset CIG ID.

You forgot to add Signed-off-by, also we should probably add Fixes tag
as well since we might want to backport these changes.

> ---
>  net/bluetooth/hci_conn.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index f75ef12f18f7..2363477af89d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -950,6 +950,8 @@ static void find_cis(struct hci_conn *conn, void *dat=
a)
>         /* Ignore broadcast */
>         if (!bacmp(&conn->dst, BDADDR_ANY))
>                 return;
> +       if (d->cig !=3D conn->iso_qos.ucast.cig)
> +               return;
>
>         d->count++;
>  }
> @@ -963,6 +965,9 @@ static void cis_cleanup(struct hci_conn *conn)
>         struct hci_dev *hdev =3D conn->hdev;
>         struct iso_list_data d;
>
> +       if (conn->iso_qos.ucast.cig =3D=3D BT_ISO_QOS_CIG_UNSET)
> +               return;
> +
>         memset(&d, 0, sizeof(d));
>         d.cig =3D conn->iso_qos.ucast.cig;
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
