Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F4C83000
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BFE2074A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 00:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC524M/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2AhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2AhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 20:37:25 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD69C03C1AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 17:37:24 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id h23so41203oos.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2020 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9rUKVHl4xjKGYwze0rnQKpPtIaz3uLVO2hFNKy8toPs=;
        b=nC524M/9cw0kko1BVw/3dv7egaJxU7ORKTcLbrzsOU8QgvBEbDIlsseRZNihVqq7Rm
         5GP3m2MfGz3FYxA3YlJr9pQkeEdodsmF87w7XCMRBm198GsaJsm7H3z+e5cvOlz1KJuy
         /k4U98i+lH2rr04rD9dAo7F+BCAdq+vdrr1pdC4GNoOSgnyHENInQal8Zzxc8/pC1ssT
         8iiSXK4lDRTrB8KwvmyCs9uxgLzcnIyJeUwJTfkfBGbakrKmEhkgdpf/3MvPAzpxN8FA
         6rzfz/MIiu9q0RLf1YmQAeK7EWzQzZRSSwr6M71y3+C3YCKJa+IMP7Tdm+SVYk92gG1C
         KA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9rUKVHl4xjKGYwze0rnQKpPtIaz3uLVO2hFNKy8toPs=;
        b=h25eBOOyuJ8wV8Acnc5dKUXwD4+7aJEfg0XVHW1MUv6Gt7Smt5ylT3iDWDZ4YuoEHz
         JgiAYCrGV/ZRzlItH3JfDwmc2dRAAycROrnCY/MTG+5tHFpCSoJ+zJEPg01dPuqLdgW/
         WOeRBeU7Y6htx1MRyJ0aksx+pcPxQ2a7WP6yDOutlv9biNq8OZRsOKyfKJ52J+fi3SrW
         VjzqxFSru2YJOLYJdWLM0lUR3XX/I1LIHxyHvt6QAVCd5mswNKzKWT1FYtnNCBdWpbTI
         c8OgM3K1LhFR++rrhGbfwoXMmS5E2EEAdO8G2s19tY8URS6b+jBv1a1hDvmg6HqlCVZL
         Ufmw==
X-Gm-Message-State: AGi0PuYxykoSRZvXGgfPh5xQgQfmPWSbNsI3dN8iSdZi47+Sv6azheau
        qRmlE+SH6E6PXQaGvchzuYlA2RGlp0jLW+MpKgY2Na0U
X-Google-Smtp-Source: APiQypIytPC5w8l76NGd7YSTCDnug/9RB0ZsddBOJMtSmuVpdLIafciIJDVzJfjitFrMWD+ewNevnz1Fm6xAElkf/h4=
X-Received: by 2002:a4a:3445:: with SMTP id n5mr10962542oof.91.1588120644247;
 Tue, 28 Apr 2020 17:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200426210202.700-1-pali@kernel.org> <CABBYNZKJUw2PL3vK5xLq9RDQ+V8sW4D9dP-Eh9m=0SXgChcagQ@mail.gmail.com>
 <20200427180707.62igtkaz255viyj6@pali>
In-Reply-To: <20200427180707.62igtkaz255viyj6@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Apr 2020 17:37:11 -0700
Message-ID: <CABBYNZJVTV4KjYWm=L3U26YyQzaMe+ntq=MzHtsW_nGRp+j0iw@mail.gmail.com>
Subject: Re: [PATCH] device: Fix calling DisconnectProfile DBus call with
 disconnected profile UUID
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 27, 2020 at 11:07 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 27 April 2020 09:37:39 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Sun, Apr 26, 2020 at 2:05 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > When DisconnectProfile is called with disconnected UUID, bluetooth da=
emon
> > > often returned error "Operation already in progress". This change fix=
ed it
> > > and no error message is returned for this case.
> > > ---
> > >  src/device.c  | 5 +++++
> > >  src/service.c | 3 ++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index 149c45160..229579378 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -2054,6 +2054,9 @@ static DBusMessage *disconnect_profile(DBusConn=
ection *conn, DBusMessage *msg,
> > >         if (dev->disconnect)
> > >                 return btd_error_in_progress(msg);
> > >
> > > +       if (btd_service_get_state(service) =3D=3D BTD_SERVICE_STATE_D=
ISCONNECTED)
> > > +               return dbus_message_new_method_return(msg);
> > > +
> > >         dev->disconnect =3D dbus_message_ref(msg);
> > >
> > >         err =3D btd_service_disconnect(service);
> > > @@ -2065,6 +2068,8 @@ static DBusMessage *disconnect_profile(DBusConn=
ection *conn, DBusMessage *msg,
> > >
> > >         if (err =3D=3D -ENOTSUP)
> > >                 return btd_error_not_supported(msg);
> > > +       else if (err =3D=3D -EALREADY)
> > > +               return dbus_message_new_method_return(msg);
> > >
> > >         return btd_error_failed(msg, strerror(-err));
> > >  }
> > > diff --git a/src/service.c b/src/service.c
> > > index c14ee0aca..e4d747a6e 100644
> > > --- a/src/service.c
> > > +++ b/src/service.c
> > > @@ -281,8 +281,9 @@ int btd_service_disconnect(struct btd_service *se=
rvice)
> > >         case BTD_SERVICE_STATE_UNAVAILABLE:
> > >                 return -EINVAL;
> > >         case BTD_SERVICE_STATE_DISCONNECTED:
> > > -       case BTD_SERVICE_STATE_DISCONNECTING:
> > >                 return -EALREADY;
> > > +       case BTD_SERVICE_STATE_DISCONNECTING:
> > > +               return 0;
> >
> > Have you checked if there are no side effects of this change? Since
> > you have a call to btd_service_get_service I wonder if this is really
> > necessary or you want to change the behavior to not return an error
> > even in case of disconnecting state? But even in that case you are
> > checking if for -EALREADY and returning no error.
>
> Same logic is used in btd_service_connect() function. When service is in
> disconnecting state then it will receive state change to disconnected.
> So returning zero is should same as issuing disconnect request again.
>
> > >         case BTD_SERVICE_STATE_CONNECTING:
> > >         case BTD_SERVICE_STATE_CONNECTED:
> > >                 break;
> > > --
> > > 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
