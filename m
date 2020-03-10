Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F7C18E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B7521D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaLSVwS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJS1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:27:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45789 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJS1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:27:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so14112249otp.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYcwCOrsXB1F7HlVWxD6tTRn4jhXioACIQXu62kUgfY=;
        b=UaLSVwS8bbvNtbVPDsG0mSjIXSm0IPTdEbTyJaNJl+msW0H0wk6h+edk1NDNVDahqS
         3TRZsa1DIf6XchwhySpddTG/wEhiXbfRbW1FmbkzZEkvdQNoKldCgmbIWQ1+1ZJPCD7i
         7zvl1pmSXXOeCDW1kUl2a0avP5h3OMQiZA5KnnrCHnK4rSkl/y/M9IRN27dD2Z1r7Dqm
         LHK/ypQlf0WDMt645JW7j84CCaZL3Soo7FI07YiUpND07L20fsLh0KEe/V+40ZbWL52E
         YM5QBWklT2JkEvq9D66WZ0M5tBdBcsVmM6CnR+mOegmsBlPVndz/6r29G1F6W2FPlXwl
         dsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYcwCOrsXB1F7HlVWxD6tTRn4jhXioACIQXu62kUgfY=;
        b=YF+5rNzMJgd73l8UO5JaI10nw8SvlqnJ7xtFTdMZ5A+htmbeHOYiktU54w9CtMA5/C
         3GqShyc8suw5TKPujXrhiqZ3I+6kT7IfrXhnFPJ3a2nJ75G4/8G364c3Mvn/uHQ44J61
         zRk5k6hsaH0sGS8lYQljOD+PrJkZs63ihCku5sEQnYp24gg6WNrEEg4PTWpjWwvc4WlY
         3gKy2Z0VNCpmPxbERN5+uyTmYOel3lN5hnDLem0dMkKlapDdGha601geUVQHGqXvncr/
         GouNml/O6EfiKZFRKuO1FmVNOK2aYADx5x3oJwf7SVFRDmDwpLg507sFCRALo1SFpA9S
         eeEg==
X-Gm-Message-State: ANhLgQ2QYg2haNKBp1FCRyf3vJyuI55r87xuAS8986umPEAAh85dyLAK
        JjjreGs6bg3GGTpJEPBywgu7krJr2wBYWyRL/0BoE83p
X-Google-Smtp-Source: ADFU+vtSOiXHxwFHHjoRy/+MC5N8vG1Cs35whs3NkRQtHPlnj7OjDsSM8vIDVfoNleaz4P1bb2dvPXHuWRCGfhxjj5Q=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr5740297otp.79.1583864819663;
 Tue, 10 Mar 2020 11:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
In-Reply-To: <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Mar 2020 11:26:48 -0700
Message-ID: <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
> On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This attempts to set the security if the device is not bonded, the
> > kernel will block any communication on the ATT socket while bumping
> > the security and if that fails the device will be disconnected which
> > is better than having the device dangling around without being able to
> > communicate with it until it is properly bonded.
> > ---
> >  profiles/input/hog.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > index dfac68921..f0226ebbd 100644
> > --- a/profiles/input/hog.c
> > +++ b/profiles/input/hog.c
> > @@ -49,6 +49,8 @@
> >  #include "src/shared/util.h"
> >  #include "src/shared/uhid.h"
> >  #include "src/shared/queue.h"
> > +#include "src/shared/att.h"
> > +#include "src/shared/gatt-client.h"
> >  #include "src/plugin.h"
> >
> >  #include "suspend.h"
> > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
> >         }
> >
> >         /* HOGP 1.0 Section 6.1 requires bonding */
> > -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> > -               return -ECONNREFUSED;
> > +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> > +               struct bt_gatt_client *client;
> > +
> > +               client = btd_device_get_gatt_client(device);
> > +               if (!bt_gatt_client_set_security(client,
> > +                                               BT_ATT_SECURITY_MEDIUM)) {
> > +                       return -ECONNREFUSED;
> > +               }
> > +       }
> I wonder if this is really necessary.  For example, this may cause a
> device the user has not deliberately bonded to suddenly expose a HOG
> Service which will trigger the user to pair (most users are known to
> blindly accept the pairing).  I believe the previous posture is more
> secure by having the user deliberately pair HID devices as opposed to
> on demand.

There are dedicated APIs to connect specific profiles, so if
hog_accept is reached it means the user/application does want to
connect HoG and in that case it should trigger bonding, so this only
automate the process, like Ive commented for legacy HID we already
attempt to bump the security in a similar way. Having the user
deliberately pair may cause breakage since in most cases the GATT
services do that on demand, in fact HoG is possibly the only exception
to that since it appear to mandate encryption at connection level
rather than on attribute level, so if the user had a peripheral that
used to not require bonding it will suddenly stop working but if we do
have this change it would possible still work after the pairing
procedure is complete.

>
> >
> >         /* TODO: Replace GAttrib with bt_gatt_client */
> >         bt_hog_attach(dev->hog, attrib);
> > --
> > 2.21.1
> >



-- 
Luiz Augusto von Dentz
