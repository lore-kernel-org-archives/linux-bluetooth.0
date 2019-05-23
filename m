Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12DFC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945CA20863
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx4LOv53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfEWOyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 10:54:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33596 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWOyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 10:54:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id q186so4609259oia.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2019 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGlDdZYHbLETNOc2j6kT+g7SBEF3Vd2G57qOzjA/ix0=;
        b=qx4LOv531Anr/a7C6YY5AT2tj9+EpFsyrFVDD63XCHNS/PVfZu4Slhh5KgOpPjrWEW
         CSlclzgRm301x3vAy68V06bRgsTVGlnQUSZJNpcEczSQjehx1vBa87UeQM2cIFYLhWfF
         HKbABZDhiuRaJsf5lg5u6Swke3OUqhGh+37gfXaocSAgrbvTzLhm1NEAlAygCo0Bs6qa
         fHvxyU3y5pDQ1nhEr/DQoO1wlGvcaz4gGx5K4ByT/DGPRxBK0qSsnKfWS8RoMG96NiFA
         uZfxEOHQjsSusFhS3JzildIQJDiEqUZX743PSir+aNYMpOsCQUQVXO1KXh7Xdpy2sB4R
         oAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGlDdZYHbLETNOc2j6kT+g7SBEF3Vd2G57qOzjA/ix0=;
        b=TkU1eY8G6DDKgdAgdJ6mExDa1DWhSFel0DP3QU0VxzPvskm7M0ZDIjxV5zCaYUrtTI
         yuvCJEt0Z88e+QnTUa2fOusKM/UvUriHozgZ/hvRwXSJj3BKrXs0m6A/J1nzhNZPmTf9
         M+I8aDaigI3g6oa2z0T8o1XJzFziTEOnmOPT0t2U1oD+T7vvdGqdcnIgTYF715/FQZMo
         nR5IF2r+spEvZQQalkWjkalwBVBJqYODLZIXbLWIcju1aoERY1jaa23xKIAK9RaIkkCN
         qgrTJZsdFf9dTGEr6p5o75TltgS5e20eDHu0Jmn28sQpmfnpzTgMcUuawKrL5g0Jxmsf
         YlgA==
X-Gm-Message-State: APjAAAUjv5vPAcEZO+R6PxEvsmTuLU3aS9LtXMGN7q0Bd1mrKlEO/zBs
        p0U99DYQHepNU1tvBM7b4MeCXOR190lDLbUzspDbJaf8
X-Google-Smtp-Source: APXvYqzKrvREBIrZtbv/UdF8tf57/k+BDZGRb06yXe+CdZuqh/fYdi0Gg7L8DbGAtaspDPkc6G3w8zwmQTULMGDUEXQ=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3015793oif.98.1558623253329;
 Thu, 23 May 2019 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190522070540.48895-1-marcel@holtmann.org>
In-Reply-To: <20190522070540.48895-1-marcel@holtmann.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 23 May 2019 07:53:47 -0700
Message-ID: <CA+E=qVcW0aQ=D_0bvEbTL9VA5P_2iykbZpNr2xH8P-eHB3FSog@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Check key sizes only when Secure Simple Pairing
 is enabled
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, May 22, 2019 at 12:05 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> The encryption is only mandatory to be enforced when both sides are using
> Secure Simple Pairing and this means the key size check makes only sense
> in that case.
>
> On legacy Bluetooth 2.0 and earlier devices like mice the encryption was
> optional and thus causing an issue if the key size check is not bound to
> using Secure Simple Pairing.
>
> Fixes: d5bb334a8e17 ("Bluetooth: Align minimum encryption key size for LE and BR/EDR connections")
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  net/bluetooth/hci_conn.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3cf0764d5793..7516cdde3373 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1272,8 +1272,13 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
>                         return 0;
>         }
>
> -       if (hci_conn_ssp_enabled(conn) &&
> -           !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
> +       /* If Secure Simple Pairing is not enabled, then legacy connection
> +        * setup is used and no encryption or key sizes can be enforced.
> +        */
> +       if (!hci_conn_ssp_enabled(conn))
> +               return 1;
> +
> +       if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
>                 return 0;
>
>         /* The minimum encryption key size needs to be enforced by the
> --
> 2.20.1
>
