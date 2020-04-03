Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80B0C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3720737
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D66f1K0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCVeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:34:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43677 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVeN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 17:34:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id k5so7453167oiw.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctI9475A8sRuqLMfAJ9sQiA/zqDADVZwrDE+bSG2srs=;
        b=D66f1K0UQreKZGNIgsvyUlhbYHGSZNHlvEPrj1IVpKYAF8w+4rmQK1rzXsFPB67/+U
         CZq85DpIsu3yfDSJQcs3zPeD9DS9Md4NczEFmaGgeJmK3bBSqIdLkVJPvPYEytglWIk4
         ghy2ScyY9AEeVK7eMGMS9IiN0daO+PG7jHNqHfkGq1j4wjHoNl3uO4+HNxGkewSnwWGF
         rKU7XiVNUslYmzn3OIF7jX+FL1dTd3+XEvSpP+cmkthlTMVO0Rib6pzdrP3VqZmpWhJA
         vx+/ICZac6o6fVkD7TI/7peFVEPPVoewK1kf4U8u3JpyAOeVRej4gIhW5g0arPwfmfKn
         duHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctI9475A8sRuqLMfAJ9sQiA/zqDADVZwrDE+bSG2srs=;
        b=j1mdPW/9Ug5XpOiHpQrBf62zUIf/EXmv0V2hzo+o7XZ56fIVK3HicHP4E0lL2ZBtGX
         wsGpXrxC3De7KmXpLZpbU38FiQnRcqLKd/LG03gZcbBtBr5RB40Z7CkCqbb9g5++Whpy
         Zjxupn57IFDdQOQvq46RE6FbxOW08g6k0YPseWpBXlKuIOSXFfoEnLKuwlkc/OSqxmDe
         w+ZRhiNjw1YCfjof7da7NSICnaVMYLC0UrWkUbeN/zf+uLMoswamZa6qEmTdetZ5O6H2
         DV6BYJ4dxAGZIdlTg9k/uc7/K/+M15Za0undP135QRsoc+SMDfm57lMNThJlnKN94XdA
         a9Pg==
X-Gm-Message-State: AGi0PuYNQHwHNwemcoM1EYkxEACti/ptyBCdyZ1/imQLwbn5U1rO4J7w
        ii4t0n2FbhzTx3PO87VYuwZG9AlOErCuPBGmDi0=
X-Google-Smtp-Source: APiQypIxVAGxCD3sjHd1y2PjIu2OtCyPPijKWpIJ7xACXrdVvyEwecbVYlAOMGaCO4FfXPmP9LjY31Op7NotgDSdbWE=
X-Received: by 2002:aca:5345:: with SMTP id h66mr4891653oib.110.1585949652218;
 Fri, 03 Apr 2020 14:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585899568-14564-1-git-send-email-thorsten.klein@bshg.com> <1585899568-14564-2-git-send-email-thorsten.klein@bshg.com>
In-Reply-To: <1585899568-14564-2-git-send-email-thorsten.klein@bshg.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Apr 2020 14:34:00 -0700
Message-ID: <CABBYNZKfkNGPqna6WZ9-11_CqoYZTsudHHBv=zqLjVnUSpe4kA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] fix dbus error code in case of invalid offset (org.bluez.Error.InvalidOffset)
To:     "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Ryll, Jan (BSH)" <jan.ryll@bshg.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thorsten,

You may want to fix the commit message to state that this is for the
client, e.g.

client: Fix not sending InvalidOffset

...<some description why it is needed>

On Fri, Apr 3, 2020 at 12:42 AM Klein, Thorsten (BSH)
<kleinkastel@googlemail.com> wrote:
>
> From: "Ryll, Jan (BSH)" <jan.ryll@bshg.com>
>
> ---
>  client/gatt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 416eda9..cf2cb17 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -2276,6 +2276,10 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>         if (prep_authorize)
>                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>
> +    if (offset >= (chrc->max_val_len))
> +        return g_dbus_create_error(msg,
> +                               "org.bluez.Error.InvalidOffset", NULL);
> +
>         if (write_value(&chrc->value_len, &chrc->value, value, value_len,
>                                                 offset, chrc->max_val_len))
>                 return g_dbus_create_error(msg,
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz
