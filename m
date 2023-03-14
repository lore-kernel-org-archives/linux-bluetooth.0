Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E07C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCNX0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNX0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 19:26:43 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0184D29B
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:26:42 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id g23so8121207uak.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678836401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVZyqyIUuqy3BgFaOemNwDo6SIPH8FXD2W5bfLNvuHU=;
        b=XuNc2vdBfMbScXsOEiDbD+qpzJGEH5jFdLlVIJnwrsqkuEMkUKSvVWkGKwfNzdbwiE
         KKtkiY8fSQgoAK75f9kW8rPi5ZBsg1fsGQyJvEHJWS2hTOwZg+tLpSpLvJBbYXvqoJoW
         60Dgd98GNMAIFHXHdeV22c3LZrjxq5gpCep3qowoXuzSUp1uaM/EDBvIKFoSMKeuu/Ke
         2bvN4dxuD5xRH1D8bBPqXJsBWiJBNder/ss093Ou1Msq/QuXb2b/FE5Rpf++9u0b4m0m
         c6cVHgJH1wmY0h7JwUm0btaKGmP6xxLdkiLwtgYxt1m1O1ICDtIFrVINlFr+0XILiX6x
         pKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678836401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVZyqyIUuqy3BgFaOemNwDo6SIPH8FXD2W5bfLNvuHU=;
        b=VO8yBiulo2H4sabVB0gWNO6gmMeutop8unLuV0AyJlhRTLXm26dTtWEZqnnEtzjfly
         LHWQEFEgCGQqwPbJSQWeUQEeij82c2R9y4FsWj8Mq48n5UEYb/1L2kolOvRgVuNV0G3x
         xlIQLzTnJ/TitMFfiBhrDsjA2Fdm/XBtTij2tHQsWi1G7K9St+rHBDRBjgreIx9SdnU8
         R9Cj4O2WaPLA2CHgRnwv2qnmrGa1rnRiJ6DehQjfaz1ll/JRszEuTZVrwSokio/iXkx9
         pHD/fsqz5EJybnJYJKC+cmtk8h8W9xe0BylLzHuZofN40ctxysq8f9UPKB5Ff13Rqh/F
         F9Xw==
X-Gm-Message-State: AO0yUKX/PPv3iBfIWGRcrgtfZeJzxt4U9ICPw/4kWz74ajwG63pKSq7j
        jCELbdUfj+FDf9CFHBipupFDqqivmYrpTDfR3Pg=
X-Google-Smtp-Source: AK7set8UFjo0PXgaBB5ONXY2OSRSgO5Kociy7QI7Q7gmlHF/Z6SsZ0GK5MWSNPx0ayWLXHZO5TdrOptO6PL2ASPktRk=
X-Received: by 2002:a1f:38d6:0:b0:401:a4bf:210d with SMTP id
 f205-20020a1f38d6000000b00401a4bf210dmr23872263vka.1.1678836401307; Tue, 14
 Mar 2023 16:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230311003826.454858-1-marijn.suijten@somainline.org> <20230311003826.454858-3-marijn.suijten@somainline.org>
In-Reply-To: <20230311003826.454858-3-marijn.suijten@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Mar 2023 16:26:28 -0700
Message-ID: <CABBYNZ+aVLVCVS8=gNfFL_nneJzQWSSZHNCk9NxOU-3mYRBTwA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/3] audio/avrcp: Only allow absolute volume
 call/event on category-2 peers
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Fri, Mar 10, 2023 at 4:39=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Restrict the use of SetAbsoluteVolume and EVENT_VOLUME_CHANGED to peers
> with at least AVRCP version 1.4 and AVRCP_FEATURE_CATEGORY_2 on their
> respective target or controller profiles.

Hmm, couldn't this actually make things even worse since we now are
checking the category as well? I know this is by the spec but as we
already are experiencing some stacks tend to deviate a lot from the
spec, perhaps it would have been better to introduce another config
option e.g. VolumeCategory =3D true so people can roll back to the old
behavior if their devices don't work well with this changes.

> ---
>  profiles/audio/avrcp.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5e6322916..c16f9cfef 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1757,6 +1757,16 @@ static uint8_t avrcp_handle_set_absolute_volume(st=
ruct avrcp *session,
>         if (len !=3D 1)
>                 goto err;
>
> +       /**
> +        * The controller on the remote end is only allowed to call SetAb=
soluteVolume
> +        * on our target if it's at least version 1.4 and a category-2 de=
vice.
> +        */
> +       if (!session->target || session->target->version < 0x0104 ||
> +                       !(session->target->features & AVRCP_FEATURE_CATEG=
ORY_2)) {
> +               error("Remote SetAbsoluteVolume rejected from non-categor=
y-2 peer");
> +               goto err;
> +       }
> +
>         volume =3D pdu->params[0] & 0x7F;
>
>         media_transport_update_device_volume(session->dev, volume);
> @@ -3728,6 +3738,16 @@ static void avrcp_volume_changed(struct avrcp *ses=
sion,
>         struct avrcp_player *player =3D target_get_player(session);
>         int8_t volume;
>
> +       /**
> +        * The target on the remote end is only allowed to reply to EVENT=
_VOLUME_CHANGED
> +        * on our controller if it's at least version 1.4 and a category-=
2 device.
> +        */
> +       if (!session->controller || session->controller->version < 0x0104=
 ||
> +                       !(session->controller->features & AVRCP_FEATURE_C=
ATEGORY_2)) {
> +               error("Remote EVENT_VOLUME_CHANGED rejected from non-cate=
gory-2 peer");
> +               return;
> +       }
> +
>         volume =3D pdu->params[1] & 0x7F;
>
>         /* Always attempt to update the transport volume */
> @@ -3981,7 +4001,7 @@ static gboolean avrcp_get_capabilities_resp(struct =
avctp *conn, uint8_t code,
>                 case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>                 case AVRCP_EVENT_UIDS_CHANGED:
>                 case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> -                       /* These events above requires a player */
> +                       /* These events above require a player */
>                         if (!session->controller ||
>                                                 !session->controller->pla=
yer)
>                                 break;
> @@ -4154,10 +4174,13 @@ static void target_init(struct avrcp *session)
>         if (target->version < 0x0104)
>                 return;
>
> +       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> +               session->supported_events |=3D
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +
>         session->supported_events |=3D
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED) |
> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED);
>
>         /* Only check capabilities if controller is not supported */
>         if (session->controller =3D=3D NULL)
> @@ -4572,8 +4595,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_=
t volume, bool notify)
>                 return -ENOTCONN;
>
>         if (notify) {
> -               if (!session->target)
> +               if (!session->target || session->target->version < 0x0104=
 ||
> +                               !(session->target->features & AVRCP_FEATU=
RE_CATEGORY_2)) {
> +                       error("Can't send EVENT_VOLUME_CHANGED to non-cat=
egory-2 peer");
>                         return -ENOTSUP;
> +               }
>                 return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
>                                                                 &volume);
>         }
> @@ -4583,8 +4609,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_=
t volume, bool notify)
>                                                 AVRCP_EVENT_VOLUME_CHANGE=
D))
>                         return -ENOTSUP;
>         } else {
> -               if (!session->controller || session->controller->version =
< 0x0104)
> +               if (!session->controller || session->controller->version =
< 0x0104 ||
> +                               !(session->controller->features & AVRCP_F=
EATURE_CATEGORY_2)) {
> +                       error("Can't send SetAbsoluteVolume to non-catego=
ry-2 peer");
>                         return -ENOTSUP;
> +               }
>         }
>
>         memset(buf, 0, sizeof(buf));
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
