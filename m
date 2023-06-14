Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBBCEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjFNQ0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNQ0O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 12:26:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC84ED
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:26:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b39bf8d5faso2915341fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686759971; x=1689351971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgqMOR19zDvGs15lDn9222dEk+6mHvCrjr5/sLKRJ3o=;
        b=iKUOM1nErIKGvdTZqGdpFZmSReoc5FMKYfapdppePrdGHzAU09YEZ0Xt/okxk+QR9e
         3ihG3yfPrJCGXqhhil9TlO4NuQLs9yW9mVRAbYoJ3VLaIAARiLKvn4Mu0Ld/gu+/Qrko
         /PQe8mtN5JBNwR6bDtLB2RFYoddQTjgrcLiS0Obz6mo/DyN1EbIiEGk2RfrdAcAyGw17
         Gyz4JVfE0z4FaN6LbVqyOkO4HrcLQJ6CO9xiTkWFAmO+k8HLYqVJIuHvXf2IQS9paGeR
         9T+LxGmlnd2QwuHvMMHKlkJZeBxhpNcDqAR2R9+hS0s3MidszTbMf4gY9I1sl8uA4+du
         dEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759971; x=1689351971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgqMOR19zDvGs15lDn9222dEk+6mHvCrjr5/sLKRJ3o=;
        b=ZQM89net1T7WsZd0Cy7VOdr1c72i4UuJIwcprnAhJ9jAmJkP0lMjl2GFgyjtWwElnl
         kymsVfj+y2HQr1+9jGi1cMUlCXivn/ShesJg8GHzbrEmX1T3RKaVDsdKDIXXNhYwHz7k
         FCKoaQyCprvk2lNql7UNypyF4Uk6eUX1svui4UiXuBI+R+oXH3YYouhZvVxEFDE9lhEC
         63TsnlKpUlt2RUQCrrJOdIdlHuf2rwqD2P32yVPh6ESHM/krHyQXyW6s88k1ZX7VzStH
         DCKMvfKt5ggdEQ178KgCFT5PLnyJPGVY2L/VX6FzY0Z+fCE/643eBujkD5hVl9H57kdu
         gTvg==
X-Gm-Message-State: AC+VfDzFKjz2fvgXqRFMr7BG0z3uW+rZmEDW5HWAXjcuJzgRflOqZdzn
        37Y/yAkGBJwQwIxOUxYYX9OKGeJ/UL6Rnlcwuvg=
X-Google-Smtp-Source: ACHHUZ6QMeycoDfQJrxcwZcIFFK9tKbsFBiLoMQQAHEeknOGJ8lN+5dpZJvDhsXkydagQCYAamFS936z1qcM6A79cS4=
X-Received: by 2002:a2e:7e09:0:b0:2b1:e725:f4f4 with SMTP id
 z9-20020a2e7e09000000b002b1e725f4f4mr6683127ljc.5.1686759971228; Wed, 14 Jun
 2023 09:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
In-Reply-To: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jun 2023 09:25:58 -0700
Message-ID: <CABBYNZ+5ToeenijZkpRSrQ+wyLPjFSD5S7LWwCWXVoT=m-9Y3g@mail.gmail.com>
Subject: Re: bluez SEGV in current master
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joakim,

On Wed, Jun 14, 2023 at 5:36=E2=80=AFAM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> commit bap: Add broadcast source support, 3030883, in bluez.git
>
> A co-worker see this SEGV when connecting a headset:
>
> Jun 13 13:38:15 systemd-coredump[3941]: Process 1897 (bluetoothd) of user=
 0 dumped core.
>                                         Module bluetoothd without build-i=
d.
>                                         #0  0x0000556bea93277a a2dp_resum=
e_complete (bluetoothd + 0x3e77a)
>                                         #1  0x0000556bea9210a2 finalize_r=
esume (bluetoothd + 0x2d0a2)
>                                         #2  0x0000556bea92afaf avdtp_star=
t_resp (bluetoothd + 0x36faf)
>                                         #6  0x0000556bea9dcc85 mainloop_r=
un (bluetoothd + 0xe8c85)
>                                         #7  0x0000556bea9dd0dc mainloop_r=
un_with_signal (bluetoothd + 0xe90dc)
>                                         #8  0x0000556bea91a4ef main (blue=
toothd + 0x264ef)
>                                         #11 0x0000556bea91ace1 _start (bl=
uetoothd + 0x26ce1)
> Jun 13 13:38:15 systemd[1]: bluetooth.service: Main process exited, code=
=3Ddumped, status=3D11/SEGV
>
>
> Crash seems to be at:
>
> 342     static void a2dp_resume_complete(struct avdtp *session, int err,
> 343                                                             void *use=
r_data)
> 344     {
> 345             struct media_owner *owner =3D user_data;
> 346             struct media_request *req =3D owner->pending;
> 347             struct media_transport *transport =3D owner->transport;
> 348             struct a2dp_sep *sep =3D media_endpoint_get_sep(transport=
->endpoint);
>
> A good start(but does NOT fix the problem) might be:
>
> --- bluez-9999/profiles/audio/transport.c.org   2023-06-13 18:38:14.54213=
7531 +0200
> +++ bluez-9999/profiles/audio/transport.c       2023-06-13 18:48:32.54252=
7882 +0200
> @@ -345,7 +345,7 @@
>         struct media_owner *owner =3D user_data;
>         struct media_request *req =3D owner->pending;
>         struct media_transport *transport =3D owner->transport;
> -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->endpoi=
nt);
> +       struct a2dp_sep *sep;
>         struct avdtp_stream *stream;
>         int fd;
>         uint16_t imtu, omtu;
> @@ -355,7 +355,10 @@
>
>         if (err)
>                 goto fail;
> +       if (!transport)
> +               goto fail;
>
> +       sep =3D media_endpoint_get_sep(transport->endpoint);
>         stream =3D a2dp_sep_get_stream(sep);
>         if (stream =3D=3D NULL)
>                 goto fail;
>
> bluez-5.66 Works fine though.
>
> Headset: WH-1000XM3
>
>   Jocke

Weird, I don't think much has changed for A2DP, but perhaps there is
some BAP related changes affecting A2DP for some reason, any chance to
bisect the patch that introduces this problem? Or it is not always
reproducible?


--=20
Luiz Augusto von Dentz
