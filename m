Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD12C10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C76B20873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsG/Mg5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJSqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:46:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33005 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJSqb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:46:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id g15so8109523otr.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXHbLXjDIYQTcYz+S6fQJu2XAM6vU2g6LFoyeuas4Bk=;
        b=ZsG/Mg5amJ5eN4oz7Gs1+47req+YVfu2OcWM/b5XhRvKIZHyFA/cZ3btXKQ7Vm4bpB
         aPbarJzT7a2RNCJhFhsXBmVGjjsZWFpWEYG4OtCtSQNntLExHhgcE5zksXXVdW/ai8dY
         4iv0AigNVojumLQCOq4ictnbA5RwuQPMEex4Waj2LmZEyXphHxXbEhN0sMgVU8vx2S2U
         H5DXvT3sDUqWaFSMko2NaoHMdVF02xt+Sl8kkEx/zLRmaV8mQkN3vo8ORmL1Tgsau0iY
         eczzSPT+E1YRH4K9W+ncGjTnebfq0COuBMJIYGuPIY05bS4Mut3U/uudCNccQRAhZ07e
         ZpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXHbLXjDIYQTcYz+S6fQJu2XAM6vU2g6LFoyeuas4Bk=;
        b=annOWvV+2b5x0eD7DEigjGra5cD7LK9UJqlUhEe+JIM3kLrDPc5Qx99DLMv0fMG6cg
         zA/zKs+nhh89BMd7iT4mmHsD6clB49pbU0Yu/+qMH8SjsUEaLSenVitq2h8W4IaXgjsA
         p5GqOJEEGibWM4s9Y5Zh0lQxNL4f4nEWnBl8X2GvQBeauoVEOnT4KaihZIPIR6xNwOa9
         op9JB7LS7N4KQDF8b1tRNJ4uvySROGyCYdnHUUjT4CGxg4iT5ZMKFctk5dGN4zP8h4lr
         uMl9uEkO/aFi2jrYlfW8bdETztMBUo46PvipKByQfYNg9Tx+cWKFG5Ce1VaOfkqmYZ6q
         x+jA==
X-Gm-Message-State: ANhLgQ2/HHj7h/g1ChSuZdywcr1NO1cCuZvkCgQ1fU+2ZX3TfA7CCJuL
        isBJVdM2KW33LvrHJdwJTt3DdVRndJaea0cZo6ziQfm0
X-Google-Smtp-Source: ADFU+vtJpnBCWNXeuVqVErqKqRkIsAMsYmWFHByuYFkMhXsP4+ugj93Ap6gGMJSsxYzxpsWGmFUAYMwUpj010aWcecY=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr6142000otj.177.1583865989081;
 Tue, 10 Mar 2020 11:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com> <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
In-Reply-To: <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Mar 2020 11:46:17 -0700
Message-ID: <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Mar 10, 2020 at 11:37 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
> On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@google.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This attempts to set the security if the device is not bonded, the
> > > > kernel will block any communication on the ATT socket while bumping
> > > > the security and if that fails the device will be disconnected which
> > > > is better than having the device dangling around without being able to
> > > > communicate with it until it is properly bonded.
> > > > ---
> > > >  profiles/input/hog.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > > > index dfac68921..f0226ebbd 100644
> > > > --- a/profiles/input/hog.c
> > > > +++ b/profiles/input/hog.c
> > > > @@ -49,6 +49,8 @@
> > > >  #include "src/shared/util.h"
> > > >  #include "src/shared/uhid.h"
> > > >  #include "src/shared/queue.h"
> > > > +#include "src/shared/att.h"
> > > > +#include "src/shared/gatt-client.h"
> > > >  #include "src/plugin.h"
> > > >
> > > >  #include "suspend.h"
> > > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
> > > >         }
> > > >
> > > >         /* HOGP 1.0 Section 6.1 requires bonding */
> > > > -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> > > > -               return -ECONNREFUSED;
> > > > +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> > > > +               struct bt_gatt_client *client;
> > > > +
> > > > +               client = btd_device_get_gatt_client(device);
> > > > +               if (!bt_gatt_client_set_security(client,
> > > > +                                               BT_ATT_SECURITY_MEDIUM)) {
> > > > +                       return -ECONNREFUSED;
> > > > +               }
> > > > +       }
> > > I wonder if this is really necessary.  For example, this may cause a
> > > device the user has not deliberately bonded to suddenly expose a HOG
> > > Service which will trigger the user to pair (most users are known to
> > > blindly accept the pairing).  I believe the previous posture is more
> > > secure by having the user deliberately pair HID devices as opposed to
> > > on demand.
> >
> > There are dedicated APIs to connect specific profiles, so if
> > hog_accept is reached it means the user/application does want to
> > connect HoG and in that case it should trigger bonding, so this only
> > automate the process, like Ive commented for legacy HID we already
> > attempt to bump the security in a similar way. Having the user
> > deliberately pair may cause breakage since in most cases the GATT
> > services do that on demand, in fact HoG is possibly the only exception
> > to that since it appear to mandate encryption at connection level
> > rather than on attribute level, so if the user had a peripheral that
> > used to not require bonding it will suddenly stop working but if we do
> > have this change it would possible still work after the pairing
> > procedure is complete.
> The outgoing contract where the user somehow asked for the profile to
> be connected and would result in pairing, I'm ok with.  However, this
> being in the accept path, it doesn't seem to always be client side
> initiated, so that still seems like a concern to me.

Since this is a profile so we are always acting as GATT client here,
so it is either initiated by the client when setting up a new
peripheral or it has been previously setup with Add Device and is
marked to auto connect, the later is exactly the problem I described
that there could be existing peripheral not requiring bonding that
suddenly stop working.

> >
> > >
> > > >
> > > >         /* TODO: Replace GAttrib with bt_gatt_client */
> > > >         bt_hog_attach(dev->hog, attrib);
> > > > --
> > > > 2.21.1
> > > >
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
