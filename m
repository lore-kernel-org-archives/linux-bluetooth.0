Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1888C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891A561A10
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 21:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZVoI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCZVoG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 17:44:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7FC0613AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 14:44:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so6530019oty.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAYtYUmEaQzLl+/xBvA+ID+AunHjrOPR55DNEco4jAk=;
        b=Mk86NVC5QEpGdGJ/H3QvPqXm6AhDw6O9s4+3dQPYZe6Ti+7UcYOcsm5k65/0ngufT7
         qOQmfN1bZc7FTN7QT0teCK2lCMGxEQo0hzlaTxHAZ0Svo1B0nbDyKnm9kUcodk77MheO
         MdXHe0vS8PP1vE3FJlL9SXhrUT8kNa8/ewkLqcIJjzfpN17T9foVUO2BcR8qXZtzmoz6
         IQnxn3fp6CJdggylfoGnvogmviSrjlwmb1VYd0ehAq5T/6G1nHIy+kc33/cK/Nxzh/fn
         DKr9fUPJxTwwSRjQLKZlJnouaXJFn1E4vxt3dWZ7XEDPfMK2dl97hbDNaXg+7mIYbOjI
         Tknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAYtYUmEaQzLl+/xBvA+ID+AunHjrOPR55DNEco4jAk=;
        b=P9EJfGLJrvu1tuMiX+NwHXJP/zL0J69SvctuBUM7e/fCT2nxkhv/z3swLg+qA5mJhp
         Mo8vF7Gw0+Bv4T/taZfjCjU23Cuug5nKHPVY5VtxUKg8iOU0rK+EddcKQw2Kbqck5IJW
         RmiVZ6McKx5olKMkaat0Okf72GSlXdH4kwqB7KX2jcjIxgkwkeOXZ7I2CNh0mWe8htE9
         8411wo5fOXOw2e+qqwpxRJcMvhUqsvWAKdimu22KcmPL7kF1bm1zs3Mw1Fc/uBOxkhPU
         39gjWdyrHbFofVw0N6/hGoFqGcSHKx8Sw8iUazvTTK7i7TU0yIgzKrng2lnF4SGK8TWf
         HQPg==
X-Gm-Message-State: AOAM531zuH8drwIECRYed/hcIHDFqqyTNYJKHhf52GRbrgPR7p/kkTex
        ZyoGUC+mQLq3/6ZmStoitk9j4RIojZI0x+QpCycammbhhAra2w==
X-Google-Smtp-Source: ABdhPJyZKyyl9Do4zeG4mMJLdImhu5k2HLOnZAZOeUcLJjvG6DdiMVboJ3IC+t6T6PoVZsRnn5NaApYEIA1CTx5RTS0=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr12933378otp.44.1616795044743;
 Fri, 26 Mar 2021 14:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR10MB3265CE91F2AB6FF1F8C8013298619@AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM0PR10MB3265CE91F2AB6FF1F8C8013298619@AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Mar 2021 14:43:54 -0700
Message-ID: <CABBYNZLmKF2x1PdXiqwBZ++DRRk_JrUDMedrg+yLe+sfrpuoOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: allow 'notify' and 'indicate' flags
To:     Alexander Haas <alexander.haas@expleogroup.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alexander,

On Fri, Mar 26, 2021 at 5:44 AM Alexander Haas
<alexander.haas@expleogroup.com> wrote:
>
> It is possible that some characteristics use the Notify as well as Indica=
te property.
> In this case the CCC value is 3 and BlueZ returns BT_ERROR_CCC_IMPROPERLY=
_CONFIGURED.
> This should be the behavior for values > 3.
> ---
>  src/gatt-database.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index be6dfb265..8e16c1d79 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2648,9 +2648,9 @@ static uint8_t ccc_write_cb(struct pending_op *op, =
void *user_data)
>     return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>
>   /* Don't support undefined CCC values yet */
> - if (value > 2 ||
> -   (value =3D=3D 1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
> -   (value =3D=3D 2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
> + if (value > 3 ||
> +   (value & 0x1 && !(chrc->props & BT_GATT_CHRC_PROP_NOTIFY)) ||
> +   (value & 0x2 && !(chrc->props & BT_GATT_CHRC_PROP_INDICATE)))
>     return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
>
>   if (chrc->notify_io) {
> --
> 2.31.0

Looks like your email client has mangled your patch:

Applying: gatt: allow 'notify' and 'indicate' flags
error: corrupt patch at line 11
Patch failed at 0001 gatt: allow 'notify' and 'indicate' flags

I'm also curious about what client does require subscribing to
notification and indication at same time? This would lead to
duplicated data being sent as both notification and indication, also
since indication are queued until a confirmation is received
subscribing to both simultaneously may cause races:

PropertiesChanged: Value: 0xaa
ATT: Notify 0xaa
ATT: Indicate 0xaa

PropertiesChanged: Value: 0xbb
ATT: Notify 0xbb
(queued)[ATT: Indicate 0xaa]

PropertiesChanged: Value: 0xcc
ATT: Notify 0xcc
(queued)[ATT: Indicate 0xcc]

ATT: Confirm
ATT: Indicate 0xbb

ATT: Confirm
ATT: Indicate 0xcc

So the client may perceive the indication as rollbacks, so while this
may be valid according to the spec this can cause issues if not
handled correctly. If this is due different applications having
different subscription types, one wants to be notified and the other
indicated, then only indication shall be used.

> _________________________________________________________________________=
____________
>
> Expleo Germany GmbH
> Sitz der Gesellschaft | Corporate Headquarters: M=C3=BCnchen
> Handelsregister | Commercial Register: Amtsgericht M=C3=BCnchen HRB 83252
> Gesch=C3=A4ftsf=C3=BChrung | Management: Ralph Gillessen, Marcus Ganguin
>
> This message contains information that may be privileged or confidential.=
 It is intended only for the person to whom it is addressed.
> If you are not the intended recipient, you are not authorized to read, pr=
int, retain, copy, disseminate, distribute, or use this message or any part=
 thereof.
> If you receive this message in error, please notify the sender immediatel=
y and delete all copies of this message.
> _________________________________________________________
>
> EMAIL LEGAL MENTION / DISCLAIMER
>
> This message contains information that may be privileged or confidential =
and is the property of the Expleo Services SAS, RCS Versailles 831 178 348,=
 located, 3 avenue des Pr=C3=A9s, 78180 Montigny Le Bretonneux - France. It=
 is intended only for the person to whom it is addressed. If you are not th=
e intended recipient, you are not authorized to read, print, retain, copy, =
disseminate, distribute, or use this message or any part thereof. If you re=
ceive this message in error, please notify the sender immediately and delet=
e all copies of this message.
>
> Ce message contient des informations qui peuvent =C3=AAtre privil=C3=A9gi=
=C3=A9es ou confidentielles et elles sont de la propri=C3=A9t=C3=A9 d'Exple=
o Services SAS, RCS Versailles 831 178 348, situ=C3=A9, 3 avenue des Pr=C3=
=A9s, 78180 Montigny le Bretonneux-France. Il est destin=C3=A9 uniquement =
=C3=A0 la personne =C3=A0 qui est adress=C3=A9. Si vous n'=C3=AAtes pas le =
destinataire vis=C3=A9, vous n'=C3=AAtes pas autoris=C3=A9 =C3=A0 lire, imp=
rimer, conserver, copier, diffuser, distribuer ou utiliser ce message ou to=
ute partie de celui-ci. Si vous recevez ce message par erreur, veuillez en =
avertir imm=C3=A9diatement l'exp=C3=A9diteur et supprimer toutes les copies=
 de ce message.

You probably don't want to include this disclaimer if you are
contributing to a project license under GPL.

--=20
Luiz Augusto von Dentz
