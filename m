Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FCC12002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4DE61245
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhGUQWf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhGUQWe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 12:22:34 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B93C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 10:03:09 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r135so1177845ybc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XlZdtU+nvlMAAp5qHOT9VWsJ+J7fUvqXuNoKxMEFEcA=;
        b=CaU9WaKmqxzW2pzuQWQiXcetOD3sYkroe/Jr2si6RdqFS9F+HMhndALYfDsyUKGw3B
         ZcbLJnHGNbMrYfxaMeBVTqF/izAF5GByUHanCJoQWBgdxQrSp/TmhvIwjLYnEu4TT9hK
         rPleXlF4xpIoI6lcLE8LmrrpJpR6i3Y3I4lf53EhhdwQEc7Xocjbcwb1pCgkz0jKzCWR
         44mSJyVk5AlWIKfPiXL4wCP2X9NglzN9OsaRGi4cb5rqDyaIi6YJyyKkm0oH1VDsfSeh
         SnIiyT5Fiqc4okJwE5myfiTzrg7Hb9pXaggX4tyEmsw5ycKWomECSlbbliDR9+JqDwhA
         gIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XlZdtU+nvlMAAp5qHOT9VWsJ+J7fUvqXuNoKxMEFEcA=;
        b=NfYEQHNwVkJw47y89tHi1RVGjMCdP7TtnqKzYrn+b0CKUpuM/FqhPg74S+mExPmTlm
         Uitnieba7dNwuEMjuQfO2guP9AgnQAkMM3smee/ekWeiUAjZ36OSFNPN8YiDM9voli2O
         m7dBOudw8ccQRnOZfhks83lfufd0XI6pwgIzjGibehmPCDCcI3IMNlP2XOpDoEmB2HQ2
         HPhOhg0372s0aN38xqgfKTUy4Zxb0adjyyWwRZZePH1CQlXqF9sJd+yuCvzP2O0YSI3G
         qHe+tIXTHb7bNFajynih9U5zmhhq67XLML+aCDzDUluxUZUy4HRjv/3KFE3vGlmaF7Aw
         FbWg==
X-Gm-Message-State: AOAM533+Eu2h/72RyDRgCu7PewxPyR/1RlEWjcHrxh8KNCVg5fqwviNm
        jaaXSPtHhse+cVNJg08WCOhKFOmX/QlfZ4IDNPU=
X-Google-Smtp-Source: ABdhPJwUzCB5iZ7rU24c0qus4VJPvG0NW2/sm86qecpC9kYHodi5uW2wSUT57gBKy3jJLPRSX+dxIKNbHGmGyMJFlSE=
X-Received: by 2002:a25:b741:: with SMTP id e1mr47644650ybm.347.1626886989071;
 Wed, 21 Jul 2021 10:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210721091727.177872-1-sviande@gmail.com>
In-Reply-To: <20210721091727.177872-1-sviande@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Jul 2021 10:02:58 -0700
Message-ID: <CABBYNZL8Zy0UFUYvftzePuMCt_hQ4s9c=HLZVE1EwOKcSv+Hdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] [BlueZ] audio/a2dp: refcount
To:     =?UTF-8?Q?S=C3=A9bastien_Viande?= <sviande@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi S=C3=A9bastien,

On Wed, Jul 21, 2021 at 2:29 AM S=C3=A9bastien Viande <sviande@gmail.com> w=
rote:
>
> Fix a2dp setup.
>
> I'm not the initial author of the code you can find the source on
> https://patches.linaro.org/patch/285268/

If you read the comments we actually made some different changes to
address that, are you still having similar issues even with those
changes? It maybe some configuration not working, so perhaps you can
describe the problem or better yet create a github issue with the
logs.

> This patch fix my problem the a2dp source not available there was only
> HSP/HFP.
> ---
>  profiles/audio/a2dp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 86bc02994..be707edda 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1568,6 +1568,8 @@ static void channel_free(void *data)
>         }
>
>         avdtp_remove_state_cb(chan->state_id);
> +       if (chan->session)
> +               avdtp_unref(chan->session);
>
>         queue_destroy(chan->seps, remove_remote_sep);
>         free(chan->last_used);
> @@ -2149,7 +2151,7 @@ static void avdtp_state_cb(struct btd_device *dev, =
struct avdtp *session,
>                 break;
>         case AVDTP_SESSION_STATE_CONNECTED:
>                 if (!chan->session)
> -                       chan->session =3D session;
> +                       chan->session =3D avdtp_ref(session);
>                 load_remote_seps(chan);
>                 break;
>         }
> @@ -2229,6 +2231,7 @@ found:
>                 channel_remove(chan);
>                 return NULL;
>         }
> +       avdtp_ref(chan->session);
>
>         return avdtp_ref(chan->session);
>  }
> @@ -2249,6 +2252,7 @@ static void connect_cb(GIOChannel *io, GError *err,=
 gpointer user_data)
>                         error("Unable to create AVDTP session");
>                         goto fail;
>                 }
> +               avdtp_ref(chan->session);
>         }
>
>         g_io_channel_unref(chan->io);
> --
> 2.32.0
>


--=20
Luiz Augusto von Dentz
