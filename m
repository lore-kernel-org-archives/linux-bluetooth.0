Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbiC1SSw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbiC1SSj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898F62BDB
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 11:16:54 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e592e700acso158623827b3.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/fi6mZYDfm0VV6vDZo77jPGFXmDYCwJMMhGPMBdpvWA=;
        b=d3+vr1pSN2rcrvjRel5ATsgXSvQIfoXheYc3q7Dd9FlHk6FZzGZUJFNBFcuswVp79a
         4P3a9tJlNzLztUu2riVxfXONBlFENHJKN67Z0tmpKdtatJbLCPA11PT/AZAue+fxmKOM
         zTimIdCQkibNJZ2M79P28oDtbh873SZvVmMc7g0Ug/Mu4eiRENqM0NcI2hk3qcIqUarQ
         w9dX0lIlZm6IKVp4rRPUSenN1wZuMW0FbrtWWfK2JUjP7/xCqMFErA/PnPoeVvuvqHtk
         iePrJHrBZCLAQ5ULr5gwWuUsXnXnoD+GjztZGKLJKMgnzmVyzl0LqY2Dcpp11q14MKw+
         mUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fi6mZYDfm0VV6vDZo77jPGFXmDYCwJMMhGPMBdpvWA=;
        b=mtIvX/Weh9rGpBX4aInFJso0nODcxgk9w2anVjP/qpKvCVIb39NPUO641zU5P3IIkW
         jNcowK0ILRSsXSxLcFEpkBVIaTvPwkyxuKgvNL7aHk4chLnpZ/LGn2Ny4Wvhl7pAh7+H
         URPSmfuagID1VG4L3q+UXOQMWf7Y/f936jW1j34wOanHfBDhw3QiV0iZcSFExtUOsHOI
         KrbPIJjVLld7sF90knodC2feOhSnAFo6+uSKkjAhocMenymxfZnA+gT0PdbHOmjNFl5Z
         vrWEfioyv93SHivpumvVTj6cgDbqIJZDu4HmeDMgyh5WQudRNUE5MjVpk+r2A5DRPMHr
         ec3g==
X-Gm-Message-State: AOAM531UxAwbGnj9xQB85pU/Zgln78+o+NJNpBXl/FGYDJBCnVpHiWuy
        R+DXGJPj5FsTtQv+4BlhSVJ7hEmadMk0RtMq/tWtPi4Qwkg=
X-Google-Smtp-Source: ABdhPJwJ25BTMHJdO2b4HDlZSk9D1iahttPGARPmGBkB5uWqCzSOs0IxpvpfmtWMDXpYFofT3Giwq4QUkcCWFLDiTb4=
X-Received: by 2002:a81:f0c:0:b0:2d6:83ab:7605 with SMTP id
 12-20020a810f0c000000b002d683ab7605mr26916926ywp.150.1648491413611; Mon, 28
 Mar 2022 11:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220325092706.17135-1-frederic.danis@collabora.com> <CABBYNZJJAN7GeNRm8_UyyE4pBDKn+YWLiqHBxecKcKUJhzDbTQ@mail.gmail.com>
In-Reply-To: <CABBYNZJJAN7GeNRm8_UyyE4pBDKn+YWLiqHBxecKcKUJhzDbTQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Mar 2022 11:16:43 -0700
Message-ID: <CABBYNZ+7nup69rsTsaAhZAFxS3Mc_bMLBZr3vVjbW4D5sG8o7w@mail.gmail.com>
Subject: Re: [PATCH] a2dp: Fix crash when SEP codec has not been initialized
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Mar 25, 2022 at 1:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Fr=C3=A9d=C3=A9ric,
>
> On Fri, Mar 25, 2022 at 12:53 PM Fr=C3=A9d=C3=A9ric Danis
> <frederic.danis@collabora.com> wrote:
> >
> > If SEP has not been properly discovered avdtp_get_codec may return NULL
> > thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
> > AVRCP/TG/RCR/BV-04-C
> > ---
> >  profiles/audio/a2dp.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index f761dbe54..7da008071 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -1995,7 +1995,12 @@ static gboolean get_codec(const GDBusPropertyTab=
le *property,
> >  {
> >         struct a2dp_remote_sep *sep =3D data;
> >         struct avdtp_service_capability *cap =3D avdtp_get_codec(sep->s=
ep);
> > -       struct avdtp_media_codec_capability *codec =3D (void *) cap->da=
ta;
> > +       struct avdtp_media_codec_capability *codec;
> > +
> > +       if (!cap)
> > +               return FALSE;
> > +
> > +       codec =3D (void *) cap->data;
> >
> >         dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> >                                                 &codec->media_codec_typ=
e);
> > @@ -2008,10 +2013,16 @@ static gboolean get_capabilities(const GDBusPro=
pertyTable *property,
> >  {
> >         struct a2dp_remote_sep *sep =3D data;
> >         struct avdtp_service_capability *service =3D avdtp_get_codec(se=
p->sep);
> > -       struct avdtp_media_codec_capability *codec =3D (void *) service=
->data;
> > -       uint8_t *caps =3D codec->data;
> > +       struct avdtp_media_codec_capability *codec;
> > +       uint8_t *caps;
> >         DBusMessageIter array;
> >
> > +       if (!service)
> > +               return FALSE;
> > +
> > +       codec =3D (void *) service->data;
> > +       caps =3D codec->data;
> > +
> >         dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> >                                         DBUS_TYPE_BYTE_AS_STRING, &arra=
y);
> >
> > --
> > 2.25.1
>
> We should either have a .exist callback or not have the endpoint
> registered if its codec is not available, I'm leaning toward the
> latter given that it is useless to have the endpoint if it cannot be
> used without the codec information.

In case you missed my response on slack, here is the suggestion change:

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..28654924b 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2074,6 +2074,11 @@ static struct a2dp_remote_sep
*register_remote_sep(void *data, void *user_data)
        if (sep)
                return sep;

+       if (avdtp_get_codec(rsep)) {
+               error("Unable to get remote sep codec");
+               return NULL;
+       }
+
        sep =3D new0(struct a2dp_remote_sep, 1);
        sep->chan =3D chan;
        sep->sep =3D rsep;


>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
