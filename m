Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F8C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiCYUIe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiCYUI0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 16:08:26 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79541626
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 13:06:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d07ae0b1c4so93824407b3.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h8tP4p9WVKUrN45fwRBffMVFEJ56LowfBUZ8FA8do7I=;
        b=q3KvfYofXvNmYudWBr2vybHaTPKLpaKtoBdTmvCcg4nBQtMneuBOENY+6w47O0bgD7
         wa+F3qF2fweCHWN08zRb4RBmjmxMFWTtknDd4jnfh4YHTL2v2g7XvwYtKDsqAEu6BRud
         S2fNIo7S14TF/oeb2Q1VseYGcf/elaTJVSYM1ddp5ovx41IBy4M/0hzFWKsofTwhrbyo
         sJeB5aOqxHto0wYIiYPIaa3/gmz/YjmQJUrm2Vl5fER+fMZzwiYn+rcDUmJm2nFSIsZi
         6A9GTHu+S/6I+Tyh3wTwcVnyk3S2evaDS9K42BvFr2FAK/un6Qp/9GioFYxg+ZdLpwY9
         CQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h8tP4p9WVKUrN45fwRBffMVFEJ56LowfBUZ8FA8do7I=;
        b=iCJsP/n3Oo26zCKh9Q2jmlfmoQikqTfP4SRMTgpbpSWtPahHPi5V5UXJo4zvHOtdI4
         TSBxpBKPYlB7Bw3CXIDc8xU6tgU/7XMJx0fdm6eba9bNCS0noIfvuLriw5qDMNQw13x6
         zoAaqZSRLYV0hxG3wcL7d7XNmI7AEgtl03I4msXvUByioM6L6ir5T4ftXUWG2BNoI7qM
         9sCdVXiCu3BXYQuVDrxFZk3Qv1v+Fu/DV4B0Tqa1g2PxrELQ+Ev7lwcuT8jSpk9+8IRQ
         9fuGF8uFfVeRpd4sEwIiYrVgbj0Q0KjIJKsTif6glGaAxHXZR0AiZ2VlSNd90kY2zJB/
         6R1Q==
X-Gm-Message-State: AOAM532j/NHbg5alXkiH9ycqNXUXtcyV9RmAym2uVM9hy3uz8Xkl7Qmn
        vKJhBvqQeKNmufT//MgX/uemnv7H+8f83YG9SIdOxfJC
X-Google-Smtp-Source: ABdhPJw4JelmCRaVm8Kjq7syV2NFGQRFff2l68Z15C0dNG4oOCby++jG/vrB4I00/IWzG8D9hgfCMpA3CZ2bC8i2H80=
X-Received: by 2002:a0d:d84f:0:b0:2e5:f8f1:7272 with SMTP id
 a76-20020a0dd84f000000b002e5f8f17272mr12836136ywe.376.1648238771096; Fri, 25
 Mar 2022 13:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220325092706.17135-1-frederic.danis@collabora.com>
In-Reply-To: <20220325092706.17135-1-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 13:06:00 -0700
Message-ID: <CABBYNZJJAN7GeNRm8_UyyE4pBDKn+YWLiqHBxecKcKUJhzDbTQ@mail.gmail.com>
Subject: Re: [PATCH] a2dp: Fix crash when SEP codec has not been initialized
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Mar 25, 2022 at 12:53 PM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> If SEP has not been properly discovered avdtp_get_codec may return NULL
> thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
> AVRCP/TG/RCR/BV-04-C
> ---
>  profiles/audio/a2dp.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index f761dbe54..7da008071 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1995,7 +1995,12 @@ static gboolean get_codec(const GDBusPropertyTable=
 *property,
>  {
>         struct a2dp_remote_sep *sep =3D data;
>         struct avdtp_service_capability *cap =3D avdtp_get_codec(sep->sep=
);
> -       struct avdtp_media_codec_capability *codec =3D (void *) cap->data=
;
> +       struct avdtp_media_codec_capability *codec;
> +
> +       if (!cap)
> +               return FALSE;
> +
> +       codec =3D (void *) cap->data;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
>                                                 &codec->media_codec_type)=
;
> @@ -2008,10 +2013,16 @@ static gboolean get_capabilities(const GDBusPrope=
rtyTable *property,
>  {
>         struct a2dp_remote_sep *sep =3D data;
>         struct avdtp_service_capability *service =3D avdtp_get_codec(sep-=
>sep);
> -       struct avdtp_media_codec_capability *codec =3D (void *) service->=
data;
> -       uint8_t *caps =3D codec->data;
> +       struct avdtp_media_codec_capability *codec;
> +       uint8_t *caps;
>         DBusMessageIter array;
>
> +       if (!service)
> +               return FALSE;
> +
> +       codec =3D (void *) service->data;
> +       caps =3D codec->data;
> +
>         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
>                                         DBUS_TYPE_BYTE_AS_STRING, &array)=
;
>
> --
> 2.25.1

We should either have a .exist callback or not have the endpoint
registered if its codec is not available, I'm leaning toward the
latter given that it is useless to have the endpoint if it cannot be
used without the codec information.



--=20
Luiz Augusto von Dentz
