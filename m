Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA224C10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6022525
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8wNlI0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJShs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:37:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40231 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgCJShr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:37:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so7242630lfe.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9rYewXagKmltkPDj87l6OPcs3d11UpC8i5zsJGFtnY=;
        b=g8wNlI0PYa5gwut35YpnLhZb1SgaRHD/T5E+i2E1jznIyDvM/Ftwwli6xI8txghA//
         FHHjls4h6UKSGYXElUO8kTfSsqVme0a7+1UbFtB/F3PSvktPAM1mQb+IN20SzvT5ZqjC
         Sd6QacW2c/I/mVK9DKEP5BT6k/Z0t36bVw1HRUWCw54gxnVvPAkaRpPzoNsBKD6E+ph3
         PVysZjzgB2rjLD5jYzBvtuwizALi/feNMae93VNZS/LgSp/HelD+sY3xkpr1vWl0GtV1
         EaoFQUgA8Z0qTsDZyeHHiA4ctSwruoBG/q+dMcOsKrX0f+T4KVlnU2oUMgrPsRpUtZ0L
         WxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9rYewXagKmltkPDj87l6OPcs3d11UpC8i5zsJGFtnY=;
        b=sbmCuimdpN65Bp5Tq2gaxdah+UvYuZz9vE580w60urNOsWDoJdnt3AnC86/cwjEmFV
         Y+H9eIB4irJT4WVBd7cxVgD2DiVv0UoWBlmgBgJm8iRakg7rLJFOXrO07tK2X7aRKkRt
         KMZIOPHe6AbxGYwS+PuFkU3a2EldDEbEHAKC36MhAaJGcwbWQwyVOLrU6/095bj8C2SB
         FHtcpxRRN/j3kUMQv9mJD4OopNkHvvRepjH3SLyXMhjIeNIjy8txxWvWspsiwG2n3Cgq
         Ii/Vo4Pnk/2p65NdeQXpBr28tju3DYyxFVeF2ub3QOVGObXxmhRbTmRGu+a7TRt04A3t
         nyGA==
X-Gm-Message-State: ANhLgQ1v1/A6/goChNVRB2rb8uMLLqTVYZ6MdZeaeLG4ohpNpsHFaTAc
        KyzgoXX6I9H8WTFPZG+bEXBwlwptDHbcGszZ+KgalQ==
X-Google-Smtp-Source: ADFU+vtn3Qb9RAIdkRgMVibuUY1WqQ4gIBRvyxS1lVsbwrxgbaGhey1d3sl/Wu75xmm16G/4GS8y69QJAFlAkbJsIlc=
X-Received: by 2002:ac2:5c44:: with SMTP id s4mr9926721lfp.129.1583865464931;
 Tue, 10 Mar 2020 11:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
In-Reply-To: <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 14:37:33 -0400
Message-ID: <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This attempts to set the security if the device is not bonded, the
> > > kernel will block any communication on the ATT socket while bumping
> > > the security and if that fails the device will be disconnected which
> > > is better than having the device dangling around without being able to
> > > communicate with it until it is properly bonded.
> > > ---
> > >  profiles/input/hog.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > > index dfac68921..f0226ebbd 100644
> > > --- a/profiles/input/hog.c
> > > +++ b/profiles/input/hog.c
> > > @@ -49,6 +49,8 @@
> > >  #include "src/shared/util.h"
> > >  #include "src/shared/uhid.h"
> > >  #include "src/shared/queue.h"
> > > +#include "src/shared/att.h"
> > > +#include "src/shared/gatt-client.h"
> > >  #include "src/plugin.h"
> > >
> > >  #include "suspend.h"
> > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
> > >         }
> > >
> > >         /* HOGP 1.0 Section 6.1 requires bonding */
> > > -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> > > -               return -ECONNREFUSED;
> > > +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> > > +               struct bt_gatt_client *client;
> > > +
> > > +               client = btd_device_get_gatt_client(device);
> > > +               if (!bt_gatt_client_set_security(client,
> > > +                                               BT_ATT_SECURITY_MEDIUM)) {
> > > +                       return -ECONNREFUSED;
> > > +               }
> > > +       }
> > I wonder if this is really necessary.  For example, this may cause a
> > device the user has not deliberately bonded to suddenly expose a HOG
> > Service which will trigger the user to pair (most users are known to
> > blindly accept the pairing).  I believe the previous posture is more
> > secure by having the user deliberately pair HID devices as opposed to
> > on demand.
>
> There are dedicated APIs to connect specific profiles, so if
> hog_accept is reached it means the user/application does want to
> connect HoG and in that case it should trigger bonding, so this only
> automate the process, like Ive commented for legacy HID we already
> attempt to bump the security in a similar way. Having the user
> deliberately pair may cause breakage since in most cases the GATT
> services do that on demand, in fact HoG is possibly the only exception
> to that since it appear to mandate encryption at connection level
> rather than on attribute level, so if the user had a peripheral that
> used to not require bonding it will suddenly stop working but if we do
> have this change it would possible still work after the pairing
> procedure is complete.
The outgoing contract where the user somehow asked for the profile to
be connected and would result in pairing, I'm ok with.  However, this
being in the accept path, it doesn't seem to always be client side
initiated, so that still seems like a concern to me.
>
> >
> > >
> > >         /* TODO: Replace GAttrib with bt_gatt_client */
> > >         bt_hog_attach(dev->hog, attrib);
> > > --
> > > 2.21.1
> > >
>
>
>
> --
> Luiz Augusto von Dentz
