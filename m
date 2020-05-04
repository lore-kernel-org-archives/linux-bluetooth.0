Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED3C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1824D206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 23:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6/gMMwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgEDXie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 19:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgEDXie (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 19:38:34 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9BBC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 16:38:32 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id i9so138090ool.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vS6JWW9MDczOjUW39P5+H6MisbVgxCSbfEgwlLeHxuI=;
        b=a6/gMMwLKXgYmsscTyOn6WUa6+9ytfXjNem7l7dzF568KMwhjLkq8JyRqzCVcZvppj
         B4eS9sJXaL/xwD6DESpxxXqIKNN411ijh69cfRsX/wLkWx4EFk8i6nZiEDgvRHLDxT5E
         3p+CDcITsgVfSRPySL7riGfia5qGV8guR+52rB6ZTAUfWu+8NTRNHIbXpwb4bUOWILJW
         hIHnI2ZQzc91mXUCVzHPsbxRRUm3ScMR7b1OcgsTGw5Or9nY9xyRQAJ0Lu0Rl1xtMBUw
         oiEq9nBEZuxy/K2CU0dzzjQ8jQnpcnDZjm5Oq2Q/amQ0TyUtkHLxRxvRwUa4GsSaEjNO
         Ux/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vS6JWW9MDczOjUW39P5+H6MisbVgxCSbfEgwlLeHxuI=;
        b=ir2qhwcatUfk9y8kLPBIElOOIlD12eZYJaAxwtUmwbOUjVvmlbyUvJnkqeDaErml3Q
         BIk17dNU5UCnBiq2UFMruiLC+pW1xg0FOVaACtk6MBV25tz2RznyqwwrZzgKLDtI3KK5
         V30dnI+X6iklGhFocZvp7zoJEnC0Fe8oZ49XXoVbUwItGBRd/xDOEGc5SJMNrVEF/9Ux
         aXvgwJtjdBlQK1OCAakoAkvTJOuZYh0danZkuQQx71tSbmEGuQvzpV4YebeES1H4en3e
         K+5USDf2lvjSmu6BzMED4NRJ1RLU8vtB+gTIHNReuA4B97knac1eyyfwctrILYQ75G2R
         AYVg==
X-Gm-Message-State: AGi0PuZosJJ742+0CkfoU1M+dFYyUck4Z/ZsJpkTCAM09FmUOaaFaM/H
        owtbH0hNWBy2ALPcPfpP0c2z/cEcuiSqysD6UKGPDlbV
X-Google-Smtp-Source: APiQypIXRDO7PkUzsKls+T17+ADnJCI1MeQKFREXiGAYBxn1ldXNdH7UdMmZ1MM/rc0hto6bPCNEtercy/rvKGDoHxA=
X-Received: by 2002:a4a:3445:: with SMTP id n5mr632358oof.91.1588635512156;
 Mon, 04 May 2020 16:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200426210247.757-1-pali@kernel.org> <20200503111055.11321-1-pali@kernel.org>
In-Reply-To: <20200503111055.11321-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 May 2020 16:38:20 -0700
Message-ID: <CABBYNZJqCcxuUSb83-f5fX1iznkFkzQRci5DT0XbUYndLMJ7Uw@mail.gmail.com>
Subject: Re: [PATCH v2] device: Return error when ConnectProfile DBus method
 fails (second fix)
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, May 3, 2020 at 4:11 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This is fixup of commit 3aa815a31017 ("device: Return error when
> ConnectProfile DBus method fails"). There is another place which needs
> to distinguish between Connect and ConnectProfile DBus method.
> ---
>  src/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 229579378..7b0eb256e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1861,7 +1861,9 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>         dev->pending =3D create_pending_list(dev, uuid);
>         if (!dev->pending) {
>                 if (dev->svc_refreshed) {
> -                       if (find_service_with_state(dev->services,
> +                       if (dbus_message_is_method_call(msg, DEVICE_INTER=
FACE,
> +                                                       "Connect") &&
> +                               find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED))
>                                 return dbus_message_new_method_return(msg=
);
>                         else
> --
> 2.20.1

Applied, thanks.


--=20
Luiz Augusto von Dentz
