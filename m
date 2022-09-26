Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28FCC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIZSGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiIZSGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 14:06:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EEB8049E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 10:50:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so12043248lfk.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=NrBk8hm7bNnIcVzcEFgNjF792jKlVo924CszR3mQfdo=;
        b=KyhiPpqoO+I0axuLxxw5pg4FH2FVZ7P/kKGwmnbxAKhLBgG1HadIvwa0Inzfqb4bsd
         itOQXL8Y+tjC0JwM86U+fD5Q7PcoshqbbNZzoIldpLRGPDKid+XQq+U9j4e9by3vmIoS
         sQxezJSoXICz+y/0lsLTiCqoIvK4ufxe0rL2C9h849FIir4canyF/OcaPwttzt9VMCGd
         BFHbaTsY0LgzOUSWfobosKKF8HMM7yDDQ5oHvISGH04JO2Ou8cfL5fQVk+wE824Sfgq+
         YqYpJKgyXG5tlZPsNOnt5XssQH4WpzQXC5nOqL9B4fA9jSY0vWTHsrwIolHSTrntOEIC
         Z5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NrBk8hm7bNnIcVzcEFgNjF792jKlVo924CszR3mQfdo=;
        b=53tmFGyGLAH1gtRlWgkGdE7Dkyu51IqVvblD1rhQhA0voKVP8cxhFkrLMTI87SCbhb
         SieD/ehvVGnGRsB64cVwfaGnYLXx6YvpLRlynpspnO6DaCfdYr8BWIb9qxlb3YPhjRL6
         KNk006Y8cO4LjCUVLy8p5CQxC73uglLWyIX4G/v8Ip0b09qDp78os/uBH7LKSR9fVhb3
         pSPLsJfCFUovbVYH1Uf0IgrceigcXMzzpksAXS5kgmbOJuGePz23rj+4zy4oC4txO5vr
         IG2Fr+kQyHiB0r4WXjJ0VESBf/Q4iX+c5Bqh/oqm2FgTg07/vw90harh00WtEx7IcfAv
         B9Zg==
X-Gm-Message-State: ACrzQf2cquO99yjaqzpXmBLxQwYibZQj4gjZ6KkYuNxVEK0bfMiYejaB
        YrcVKiRabID8xQSKtHwobsIjBIZ2gBUrA7UcWZ4=
X-Google-Smtp-Source: AMsMyM6Bpf1D5MXLAPjMt5rH/7BIiZ9MImREBpJPcH+oK246Tl4PUiNAlEHtpqH46QeHu/XDxn6tLOOfNs40cVindSY=
X-Received: by 2002:a05:6512:104e:b0:49c:c1a8:6777 with SMTP id
 c14-20020a056512104e00b0049cc1a86777mr9597252lfb.57.1664214633664; Mon, 26
 Sep 2022 10:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP96LmN8mMd5e=ddoUHt2w3HvcUF=8EahqGr6OhOJcjd3QwD0w@mail.gmail.com>
In-Reply-To: <CAP96LmN8mMd5e=ddoUHt2w3HvcUF=8EahqGr6OhOJcjd3QwD0w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Sep 2022 10:50:22 -0700
Message-ID: <CABBYNZ+oGLVEFyNcnJa-i-eO-_PnEzmxGrU3onx-2eoCMa-KoQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] obexd: point DBUS service to obex.service directly
To:     =?UTF-8?B?QW5kcsOpIFc=?= <beppe85@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andr=C3=A9,

On Sun, Sep 25, 2022 at 12:08 PM Andr=C3=A9 W <beppe85@gmail.com> wrote:
>
> dbus-org.bluez.obex.service user service is not available until
> obex.service is enabled in systemd. By pointing DBUS service directly
> to obex.service, this step can be avoided. The [Alias] section in
> systemd services then becomes unnecessary.

Can we have some more details here, perhaps quote the systemd
documentation if it states why the Alias is not necessary, also does
this affect how the service is activated? Afaik the dbus- suffix was
used to inform that this service starts a D-Bus name.

> ---
>  obexd/src/obex.service.in        | 3 ---
>  obexd/src/org.bluez.obex.service | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
> index fc0dce993..c3f822f55 100644
> --- a/obexd/src/obex.service.in
> +++ b/obexd/src/obex.service.in
> @@ -5,6 +5,3 @@ Description=3DBluetooth OBEX service
>  Type=3Ddbus
>  BusName=3Dorg.bluez.obex
>  ExecStart=3D@pkglibexecdir@/obexd
> -
> -[Install]
> -Alias=3Ddbus-org.bluez.obex.service
> diff --git a/obexd/src/org.bluez.obex.service b/obexd/src/org.bluez.obex.=
service
> index a53808884..c3917e415 100644
> --- a/obexd/src/org.bluez.obex.service
> +++ b/obexd/src/org.bluez.obex.service
> @@ -1,4 +1,4 @@
>  [D-BUS Service]
>  Name=3Dorg.bluez.obex
>  Exec=3D/bin/false
> -SystemdService=3Ddbus-org.bluez.obex.service
> +SystemdService=3Dobex.service
> --
> 2.37.3



--=20
Luiz Augusto von Dentz
