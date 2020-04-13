Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44161C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155912084D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejWTfhTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgDMQvv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731759AbgDMQvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:51:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4427C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:51:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b7so5326448oic.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BCXg8HwBlX4gedYlSl9xeQqfyIBNVTYnd4Gq8IJ3frc=;
        b=ejWTfhTOu4ee+FrmmjkEW4qUKvR8H/hqxb64EvmtZnJdePfI1x26iDXvMKwCJhvNqv
         o7ClkReHAfV0FgZqcKL9JcXm/Oly67G9+DZzsga1sLNB2hYWWtkUaU7AafAFoVJaqMRT
         /z5/BxjiwEO0xk11k/zqM996SIGbXeypAUb2hRFA4pp1Yhb7pUyv1A2jZCly3AFMRLXW
         Lt9HZBqmMcgKIf5bK/yZiLCadliTzZeB4+oOXyfn4ubOdQsbxGoPxVHQmYEmEYCH0clG
         se/s32rH9pIfUUPx0/DHl6HyHe2m232VHrhEXILmOh4op646ms3DNBqcB7sRF52A30wJ
         arng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BCXg8HwBlX4gedYlSl9xeQqfyIBNVTYnd4Gq8IJ3frc=;
        b=XMJyehE58IshDTXgriQ4yd/8bNNZIE/+a189NhJ1xXV1HX/ILbZiKeWmpPwWkwhMPB
         19rpCqScZRQbY8au8C4DKzddqPtZIyQIDkhjbvg/pPiwu8YNslcsYZb5WHeKaoT4wo5t
         tGEKXwTawb4HVDckCzEjN95bhc10cyk7pLXuYYuwGr2foivygEU9fs4mAwdjsOzZAP9H
         wgSpQXrCn2GRT7hqTP3r4AJrZK8It+sQkEl20PCvninz7hs12dbeml95Nc5+rXoCrmDF
         QUCaLq4Fz/SWwzqj7gPZdwfd/99d1wNn9Cx8+93Uarr2/XZFB3hQAi1TPmCMNlCXGYa8
         J3Ng==
X-Gm-Message-State: AGi0PuYY3kc9n4lHxQx7vNIBY39cZu01HDAup1C5d0yf/Nm5vI8mxyxv
        Zhe9M/qC7P3765U1hYKQKjcNBQfBNwTGWVoN9F53Wp2t
X-Google-Smtp-Source: APiQypKrxpxae7+qwfbBx5wVHMqJnLTPCl68i1aIcbmV1tkKHS8rl+7u2vPUo8C0yPkSHJuLF4g8DtM8/YcZb+B9FpA=
X-Received: by 2002:aca:db8a:: with SMTP id s132mr2404497oig.110.1586796708794;
 Mon, 13 Apr 2020 09:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-4-pali@kernel.org>
In-Reply-To: <20200413162513.2221-4-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 09:51:37 -0700
Message-ID: <CABBYNZLDR-Tztz86qVr3a+Pgtst8XS0uHfP1LwZWopyzwBPXmg@mail.gmail.com>
Subject: Re: [PATCH 3/3] src/profile: Add default SDP record for Headset role
 of HSP 1.2 profile with Erratum 3507
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This would allow DBus agents to implement HS role of HSP profile.
>

We don't use Signed-off-by on userspace, other than that and the
introduction of have_features Im fine with the patches.

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  src/profile.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 3b7e08f26..09627fbbd 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -56,6 +56,7 @@
>
>  #define DUN_DEFAULT_CHANNEL    1
>  #define SPP_DEFAULT_CHANNEL    3
> +#define HSP_HS_DEFAULT_CHANNEL 6
>  #define HFP_HF_DEFAULT_CHANNEL 7
>  #define OPP_DEFAULT_CHANNEL    9
>  #define FTP_DEFAULT_CHANNEL    10
> @@ -155,6 +156,49 @@
>                 </attribute>                                            \
>         </record>"
>
> +/* SDP record for Headset role of HSP 1.2 profile with Erratum 3507 */
> +#define HSP_HS_RECORD                                                  \
> +       "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>                 =
   \
> +       <record>                                                        \
> +               <attribute id=3D\"0x0001\">                              =
 \
> +                       <sequence>                                      \
> +                               <uuid value=3D\"0x1108\" />              =
 \
> +                               <uuid value=3D\"0x1131\" />              =
 \
> +                               <uuid value=3D\"0x1203\" />              =
 \
> +                       </sequence>                                     \
> +               </attribute>                                            \
> +               <attribute id=3D\"0x0004\">                              =
 \
> +                       <sequence>                                      \
> +                               <sequence>                              \
> +                                       <uuid value=3D\"0x0100\" />      =
 \
> +                               </sequence>                             \
> +                               <sequence>                              \
> +                                       <uuid value=3D\"0x0003\" />      =
 \
> +                                       <uint8 value=3D\"0x%02x\" />     =
 \
> +                               </sequence>                             \
> +                       </sequence>                                     \
> +               </attribute>                                            \
> +               <attribute id=3D\"0x0005\">                              =
 \
> +                       <sequence>                                      \
> +                               <uuid value=3D\"0x1002\" />              =
 \
> +                       </sequence>                                     \
> +               </attribute>                                            \
> +               <attribute id=3D\"0x0009\">                              =
 \
> +                       <sequence>                                      \
> +                               <sequence>                              \
> +                                       <uuid value=3D\"0x1108\" />      =
 \
> +                                       <uint16 value=3D\"0x%04x\" />    =
 \
> +                               </sequence>                             \
> +                       </sequence>                                     \
> +               </attribute>                                            \
> +               <attribute id=3D\"0x0100\">                              =
 \
> +                       <text value=3D\"%s\" />                          =
 \
> +               </attribute>                                            \
> +               <attribute id=3D\"0x0302\">                              =
 \
> +                       <boolean value=3D\"%s\" />                       =
 \
> +               </attribute>                                            \
> +       </record>"
> +
>  #define HSP_AG_RECORD                                                  \
>         "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>                 =
   \
>         <record>                                                        \
> @@ -1789,6 +1833,16 @@ static char *get_hfp_ag_record(struct ext_profile =
*ext, struct ext_io *l2cap,
>                                 ext->have_features ? ext->features : 0x9)=
;
>  }
>
> +static char *get_hsp_hs_record(struct ext_profile *ext, struct ext_io *l=
2cap,
> +                                                       struct ext_io *rf=
comm)
> +{
> +       /* HSP 1.2: By default Remote Audio Volume Control is off */
> +       return g_strdup_printf(HSP_HS_RECORD, rfcomm->chan, ext->version,
> +                               ext->name,
> +                               (ext->have_features && (ext->features & 0=
x1))
> +                               ? "true" : "false");
> +}
> +
>  static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l=
2cap,
>                                                         struct ext_io *rf=
comm)
>  {
> @@ -2012,6 +2066,16 @@ static struct default_settings {
>                 .auto_connect   =3D true,
>                 .get_record     =3D get_hfp_ag_record,
>                 .version        =3D 0x0107,
> +       }, {
> +               .uuid           =3D HSP_HS_UUID,
> +               .name           =3D "Headset unit",
> +               .priority       =3D BTD_PROFILE_PRIORITY_HIGH,
> +               .remote_uuid    =3D HSP_AG_UUID,
> +               .channel        =3D HSP_HS_DEFAULT_CHANNEL,
> +               .authorize      =3D true,
> +               .auto_connect   =3D true,
> +               .get_record     =3D get_hsp_hs_record,
> +               .version        =3D 0x0102,
>         }, {
>                 .uuid           =3D HSP_AG_UUID,
>                 .name           =3D "Headset Voice gateway",
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
