Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76CEE3F09
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjILS3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjILS3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 14:29:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEF189
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:29:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcc331f942so1625431fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694543346; x=1695148146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBhQ9qOAt6jcxWqQxJRGLV08DPG1cn/4qLbmtM7lNXM=;
        b=MrVTn3yRMW+2jdKjTXcp8D/gDziBU5pJAoEpxUNGrZ1lkhzbdTbHqHlBuF6U7fbZLv
         idBFuDJz11c3u5CuUGXUAeKeh8z5ImdqBPhKLwtacpNxi/ICZNsQ5p5dZh4+oKZvqs2n
         73C1D93DIvqIw+M4DgO96CX8Hmomy/Fmqh2dlgpltF0fyYgEg/fOMALilGBelTMHsU/R
         hzF+cnmXXvCn8d5K44BlZ7PmZvIL5BbbvqDHHy435pf4HhlbvtMNqoPfajcN0iOd94zr
         DNgT+KoCGrm8pBo5qqsozIUwHMrhUo2t3ZKvqYZTEjpJmJpJ41gxH+DIvKXUw6AK4k+E
         6Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543346; x=1695148146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBhQ9qOAt6jcxWqQxJRGLV08DPG1cn/4qLbmtM7lNXM=;
        b=Xbn4jQdteUk87I0G181u392kmnWeKCuQXdf8DdEovxNcfQuLthBzTgemVRc796xduj
         CeBlrlRMmCrrIer3bqaW1L2i74VsNFJn+p/svrFs7FphPhavn5OuSlDhmubcPIm3lqbc
         rnE6cx9ImSncWDKjqzIvrtZwsL07Y90JCUIxk8NeOS/OHf5EEfLTqeSG/WEbNS3vtBee
         IR9rdh1s9mGG1OmluM2NbkP2JackiTKmk4mdg04Z4KbFozLt8e8sYJ6tFvxMCj0bGiC0
         ug+lNT3yX7vfMJKEwqyRK0oi9wKXkAutT5Cib0GpjKleTedrib8+IeEecAmLCGujMzBq
         sZHQ==
X-Gm-Message-State: AOJu0Ywc0xbYHrh0xGwYfliZhGqWvZ/c5js2G/lHGuHZS48Zs1zomzEt
        WP35oJ8BV1tHDNqt0OWQFrM08gpSOuolhDB+Z2M=
X-Google-Smtp-Source: AGHT+IFbCTgzLgsRS/2TiolhQK3v1u+YWQxABj2lQhzgsMN4j6agkLp65aF38tvJlDD4GFpr4sYTAMOVkTn+zfaU+hQ=
X-Received: by 2002:a2e:380b:0:b0:2bc:bc6f:e296 with SMTP id
 f11-20020a2e380b000000b002bcbc6fe296mr140090lja.13.1694543345495; Tue, 12 Sep
 2023 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230912064026.1203509-1-vlad.pruteanu@nxp.com> <20230912064026.1203509-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20230912064026.1203509-2-vlad.pruteanu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Sep 2023 11:28:53 -0700
Message-ID: <CABBYNZLKx0_4w5uBuchqCVHL2bubev3bMcq7L-QOFE50DPZpzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client/player: Add command for control of BIS encryption
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vlad,

On Mon, Sep 11, 2023 at 11:44=E2=80=AFPM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> Currently there is no way to set the BIS encryption from
> the bluetoothctl application. This commit adds support
> for one.
>
> Usage:
>         encryption [on/off]

Don't really like the idea of having encryption here, I'd prompt the
user asking if he wants encryption as part of endpoint.config when we
detect it is for broadcast and if he responds yes then we can prompt
for the key as well.

> ---
>  client/player.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/client/player.c b/client/player.c
> index 42721c210..b1da5e839 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -3196,6 +3196,28 @@ done:
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> +static void cmd_encryption_endpoint(int argc, char *argv[])
> +{
> +
> +       uint8_t value;
> +
> +       if (argc < 2) {
> +               bt_shell_printf("Encryption: %s\n",
> +                               bcast_qos.bcast.encryption ? "on" : "off"=
);
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes"))
> +               value =3D 1;
> +       else if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no"))
> +               value =3D 0;
> +       else
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       bcast_qos.bcast.encryption =3D value;
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  static const struct bt_shell_menu endpoint_menu =3D {
>         .name =3D "endpoint",
>         .desc =3D "Media Endpoint Submenu",
> @@ -3221,6 +3243,10 @@ static const struct bt_shell_menu endpoint_menu =
=3D {
>                                                 cmd_presets_endpoint,
>                                                 "List available presets",
>                                                 uuid_generator },
> +       { "encryption",    "[on/off]",
> +                                               cmd_encryption_endpoint,
> +                                               "Enable/disable BIS encry=
ption (mode 3 security)",
> +                                               NULL },
>         {} },
>  };
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
