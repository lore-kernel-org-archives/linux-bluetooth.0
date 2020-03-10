Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C72AC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7F020637
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rf7+fK1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJSxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:53:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42659 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCJSxt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:53:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so11816828lfe.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JfwtY3rkRmm7ZnZcwC7Gg+rLqTwd+n5YM++K590c5U=;
        b=Rf7+fK1mlHKOaxhSjhYodbGHJWWDco5W4k9W4GB1rvL3a1wfDKUHurddGyTEjqvEWr
         7j4m3cbLYPCTyvXeE7kafqCZ3rGHvGdWho875/QxJCKwIa5DW0+WqydORWfo1TZWqjmp
         jDz2yR2V3qBVVe5JesUdNP4U4LWwPoC1n3mbbg1ZOyuYRBOhUm13N76eUOYapesiBiHv
         SD7Zs91xwyZ6Fg9WQIMLJhEAWpBptmQMcnRZxPO6GrO2iVQ46oO0gua19SYRoPcJkPxf
         AIZJKcrdQjG4VzdnxvCaG+YKSi/WzE8UmmVMj+C9vm4Ba/QPF/UcuXK9chXF0gQK2aiy
         Z6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JfwtY3rkRmm7ZnZcwC7Gg+rLqTwd+n5YM++K590c5U=;
        b=Ya9rtMHFjgT28RU4YgVJ6CNAhfu0Ewixy51ag8qcqILfJuu8Nd1hLAC9SuHvBMm46M
         DUL8y9Dq0xlsljA5XMTIhSXZz515aTc7QagJXPanqZyCtPXpEShC+Q+JDEoysibwW6Dy
         pEnJSZj5EL+MuHWgP4vF6JUKdaGcijI08whe0dBnaA+Dz870GKkA3a5Hwn11TDHRJBv+
         uxc3HVJknbdRdq/dPinalJ3gJ6kc7a9CZuqvFceJlwI8xstl3ZC8NlBtclW+iSoWXUrB
         0zDcCcZfYlv+opQjWEwY9zun9eGluaaXnVMELHst0bhM2kqjye7mHNfzQT6Lk5p8oNS4
         0RLg==
X-Gm-Message-State: ANhLgQ0eegzrGbN610SnDY5wsiVlZws5ZO2KAGQh88w5RfexN4giybfw
        xI4b8OjgBG9+HE2lm7Xs+NNGHowmP7osZpEpmHZYDA==
X-Google-Smtp-Source: ADFU+vtOgXHDiE/9EqyhBAZwlBKEWu6cEeuCJWsotQunl4pJXRXOO5OfSPUn99r0PupcpGbN1ZM7aAo/zuV+nDeojCg=
X-Received: by 2002:a05:6512:49e:: with SMTP id v30mr4306447lfq.158.1583866425601;
 Tue, 10 Mar 2020 11:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
 <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com> <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com>
In-Reply-To: <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 14:53:31 -0400
Message-ID: <CALWDO_UBgHxtaO8U8kLpAdXaL7B1HMXVhbGANKf3Fnk9G9Hwcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Mar 10, 2020 at 2:46 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Tue, Mar 10, 2020 at 11:37 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Alain,
> > >
> > > On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@google.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This attempts to set the security if the device is not bonded, the
> > > > > kernel will block any communication on the ATT socket while bumping
> > > > > the security and if that fails the device will be disconnected which
> > > > > is better than having the device dangling around without being able to
> > > > > communicate with it until it is properly bonded.
> > > > > ---
> > > > >  profiles/input/hog.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > > > > index dfac68921..f0226ebbd 100644
> > > > > --- a/profiles/input/hog.c
> > > > > +++ b/profiles/input/hog.c
> > > > > @@ -49,6 +49,8 @@
> > > > >  #include "src/shared/util.h"
> > > > >  #include "src/shared/uhid.h"
> > > > >  #include "src/shared/queue.h"
> > > > > +#include "src/shared/att.h"
> > > > > +#include "src/shared/gatt-client.h"
> > > > >  #include "src/plugin.h"
> > > > >
> > > > >  #include "suspend.h"
> > > > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
> > > > >         }
> > > > >
> > > > >         /* HOGP 1.0 Section 6.1 requires bonding */
> > > > > -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> > > > > -               return -ECONNREFUSED;
> > > > > +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> > > > > +               struct bt_gatt_client *client;
> > > > > +
> > > > > +               client = btd_device_get_gatt_client(device);
> > > > > +               if (!bt_gatt_client_set_security(client,
> > > > > +                                               BT_ATT_SECURITY_MEDIUM)) {
> > > > > +                       return -ECONNREFUSED;
> > > > > +               }
> > > > > +       }
> > > > I wonder if this is really necessary.  For example, this may cause a
> > > > device the user has not deliberately bonded to suddenly expose a HOG
> > > > Service which will trigger the user to pair (most users are known to
> > > > blindly accept the pairing).  I believe the previous posture is more
> > > > secure by having the user deliberately pair HID devices as opposed to
> > > > on demand.
> > >
> > > There are dedicated APIs to connect specific profiles, so if
> > > hog_accept is reached it means the user/application does want to
> > > connect HoG and in that case it should trigger bonding, so this only
> > > automate the process, like Ive commented for legacy HID we already
> > > attempt to bump the security in a similar way. Having the user
> > > deliberately pair may cause breakage since in most cases the GATT
> > > services do that on demand, in fact HoG is possibly the only exception
> > > to that since it appear to mandate encryption at connection level
> > > rather than on attribute level, so if the user had a peripheral that
> > > used to not require bonding it will suddenly stop working but if we do
> > > have this change it would possible still work after the pairing
> > > procedure is complete.
> > The outgoing contract where the user somehow asked for the profile to
> > be connected and would result in pairing, I'm ok with.  However, this
> > being in the accept path, it doesn't seem to always be client side
> > initiated, so that still seems like a concern to me.
>
> Since this is a profile so we are always acting as GATT client here,
> so it is either initiated by the client when setting up a new
> peripheral or it has been previously setup with Add Device and is
> marked to auto connect, the later is exactly the problem I described
> that there could be existing peripheral not requiring bonding that
> suddenly stop working.
My understanding is that the HOG service can get added to any other
device through a service change notification or other means, so I
don't think it is a safe assumption that this code will only execute
if a user explicitly requested it.

You are correct that the change may cause a device to stop working if
it was using HOGP without bonding, but this would also be a non
compliant device and one that compromises the system's security.  I'm
ok if we make this a configuration in case you believe the
compatibility with these sorts of scenarios must be maintained.

>
> > >
> > > >
> > > > >
> > > > >         /* TODO: Replace GAttrib with bt_gatt_client */
> > > > >         bt_hog_attach(dev->hog, attrib);
> > > > > --
> > > > > 2.21.1
> > > > >
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
