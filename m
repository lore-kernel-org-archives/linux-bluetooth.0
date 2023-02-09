Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20072C636D3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 21:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBIVdD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjBIVdC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Feb 2023 16:33:02 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467B9EC4
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Feb 2023 13:33:01 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id o5so3711322ljj.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Feb 2023 13:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MPwh1HcaeT6tE9wnbZohfEmsUMom8zqRLt0WHd7j6w=;
        b=JmzGRG2VsmwlpHwlnpPIcysvJiENqlm0X6/EUqyw7VYAK1290NzStD2uebkSdyMkzM
         KpSw06JNGVmtqjpgRBehcvyhCuc4JEWp+cOTZt2ydOkvIB9Hd97kyXJ07FJeL6HHkM3c
         eSn4E1kDlVCORQGq9EJVw5nAhZtTc2OEicNubnjpftmYPWG3+kxEtbcLfNRBNF5mSl5B
         MlFSieEnlht1tZm19ckGPC2hKxGWaJC67rxVOwiOXYExKkk4ngSUrHD2XwY9zBekUVf8
         NpAH8mRKewYbJ2VsJcF6cb1NFEY9UQla5LP0Bt/Bfc/AiTHiMu3Cn/lN+Vds8drzW9Y6
         JCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MPwh1HcaeT6tE9wnbZohfEmsUMom8zqRLt0WHd7j6w=;
        b=Dd8vYogtMjsrIL0wSsLKowgy/sLhXU7lBcxHlM57kgGUyfddh9HP7P1rfaaYYQZ9Kh
         MFfzLQnMtcz35GhnhGxoQIGWj6w1W5F88lyL0+XwLDoF7lI7CAoNMsaGOnVHxm+t8A1i
         oN//b42TjdoiZ18CsOI+++Oj81V5S9BTda9l9Nj6A7HMaRl70DB9avCmb2f+69oDUySx
         mbIzEgZfsxANcmyd46UtsSpFMsTe0prTvdWMcnJWjpkGgKi4I01kRcKOPdz3hIkAJJN1
         3O8By0IO8xRBHVy+FM3l3C/1T4TYIv4BchW38GgZ8xMaU/+x7QGuQXc/sQG6ldHabjNL
         wCGQ==
X-Gm-Message-State: AO0yUKXU/5RoSfw0PZxMdwPgehw3MIlSChXj20RR8EQg36wEheTSzZta
        cBxL/8BT4JZAK+DuYhzlTE4zrGXXP8/SOyvQnfw=
X-Google-Smtp-Source: AK7set94s0AriNdQmqXGxp4kwUf6Dl1NqbvenPSP9NQYdzPmrC0Heue2FtS25m6a+8p+i8dF1JggdWCSYaiKa9rLAFA=
X-Received: by 2002:a2e:9193:0:b0:293:2d78:ec11 with SMTP id
 f19-20020a2e9193000000b002932d78ec11mr933914ljg.177.1675978379517; Thu, 09
 Feb 2023 13:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
In-Reply-To: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Feb 2023 13:32:47 -0800
Message-ID: <CABBYNZJY97dFQ9cdZR+JimNN+N=cyQ3yohZQW30bM1fQUuY2pQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Do not require hardcoded interface numbers
To:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@nordicsemi.no>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?UTF-8?B?Q2FybGVzIEN1ZsOt?= <carles.cufi@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tomasz,

On Tue, Feb 7, 2023 at 3:58 AM Tomasz Mo=C5=84 <tomasz.mon@nordicsemi.no> w=
rote:
>
> Remove hardcoded interface number check because Bluetooth specification
> since version 4.0 only recommends and no longer requires specific
> interface numbers.
>
> While earlier Bluetooth versions, i.e. 2.1 + EDR and 3.0 + HS, contain
> required configuration table in Volume 4 - Host Controller Interface
> Part B - USB Transport Layer, Bluetooth Core Specification Addendum 2
> changes the table from required to recommended configuration.

Can you give it a little more context, is this supposed to be the case
for LE only controllers? I assume this shouldn't cause any regressions
for other controllers right?

> Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@nordicsemi.no>
> ---
>  drivers/bluetooth/btusb.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2ad4efdd9e40..5110d26cff7a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3830,13 +3830,9 @@ static int btusb_probe(struct usb_interface *intf,
>
>         BT_DBG("intf %p id %p", intf, id);
>
> -       /* interface numbers are hardcoded in the spec */
> -       if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) {
> -               if (!(id->driver_info & BTUSB_IFNUM_2))
> -                       return -ENODEV;
> -               if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
> -                       return -ENODEV;
> -       }
> +       if ((id->driver_info & BTUSB_IFNUM_2) &&
> +           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
> +               return -ENODEV;
>
>         ifnum_base =3D intf->cur_altsetting->desc.bInterfaceNumber;
>
> --
> 2.39.1
>


--=20
Luiz Augusto von Dentz
