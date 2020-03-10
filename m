Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570EEC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 20:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7D321655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhp4dBws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCJUjP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:39:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45171 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJUjP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 16:39:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id f21so14525925otp.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sYJByZDuju+FfLOvhRYHnCvioEecIt7yD442OxyUfoA=;
        b=Bhp4dBwsScMf6wnK9YF5bBRuiAwcXXqTh38SyOMCY7wdkLT9GbV6VQehruYKkk7py9
         UPXBXspGesp1k1kFGsPF0/AR5LYa8mUVDzklxlhvCGSu+AEfnAa3kYB3TjeR/bPMKt9r
         1HsQVbmc8iYRIV0lEYW1vu+UkFTlFKAeVLBSvKFds3hI6iouTXsYduaA3kpOln42twj3
         VldI+eGOspzbKM4qMW8dIydN9dGzGEGtRMZssTMheRQ+vz7aXtZxZQ/qKryh/E40XKq2
         nUWLzDCauZ+q8ADC7qp+oTB5NnXFjJHyuPXhbeXd5U+8Cv+91eYyVV8aGEbWa5GFVpAc
         tAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sYJByZDuju+FfLOvhRYHnCvioEecIt7yD442OxyUfoA=;
        b=P3ULOD2V5fHUk50iIBOb/DSZYHXQZtY97j46MKwEWF3BA/Iin8p/1FOM+nvv9jzzJ3
         OE17RsUSPskbmdc3e6KAl6Qr8s0hQWkUGQ+bHGrIfXRugIfZgeeox5g3wDfadtQpP3ws
         /IsRAO3yPEP4ByO294BjLrxtSp7ioFWgP1ANS1bK3/eYOg+aMoVZnM44Lrp1YGFkzfxd
         V+Dm7Z3cv+4NA4gDChAzBywJB92I5Dwy6S7PDjWJiVv1i7lQh8AA009s3VExWozQ8z6L
         aFG/ao1na1azPjxc5BPeOWlM5Q5UIheZhjycsdUdZZALHebPE7SFLUnK/UGjxjk9/MMJ
         Rfag==
X-Gm-Message-State: ANhLgQ2oiIDcE5ksrZl/ZQheSvSelArAIFd0/cDnQAqS+sXEmuycmiM0
        2/zahQzYUZ7ZpjhD9J/+QNf/sxLWtvzCiXJsmAe36vkO4P0=
X-Google-Smtp-Source: ADFU+vtUv+TmfSHpNu7ZhZ/RnfFbZ88hdbtRCEc8FlcbuoRQqZNsnYw3kNcLtiHMgtZialUKGqNYdUWFXCk/HEp1OFk=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr13898179oth.11.1583872754196;
 Tue, 10 Mar 2020 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
 <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
 <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com> <CALWDO_UBgHxtaO8U8kLpAdXaL7B1HMXVhbGANKf3Fnk9G9Hwcw@mail.gmail.com>
In-Reply-To: <CALWDO_UBgHxtaO8U8kLpAdXaL7B1HMXVhbGANKf3Fnk9G9Hwcw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Mar 2020 13:39:02 -0700
Message-ID: <CABBYNZ+H6Tv--z-u9Lr=M_XJ1RUXrRS6nwqxkSpjKpSPMSzK5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Mar 10, 2020 at 11:53 AM Alain Michaud <alainmichaud@google.com> wr=
ote:
>
> Hi Luiz,
>
> On Tue, Mar 10, 2020 at 2:46 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On Tue, Mar 10, 2020 at 11:37 AM Alain Michaud <alainmichaud@google.com=
> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Alain,
> > > >
> > > > On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@google=
.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >
> > > > > > This attempts to set the security if the device is not bonded, =
the
> > > > > > kernel will block any communication on the ATT socket while bum=
ping
> > > > > > the security and if that fails the device will be disconnected =
which
> > > > > > is better than having the device dangling around without being =
able to
> > > > > > communicate with it until it is properly bonded.
> > > > > > ---
> > > > > >  profiles/input/hog.c | 13 +++++++++++--
> > > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> > > > > > index dfac68921..f0226ebbd 100644
> > > > > > --- a/profiles/input/hog.c
> > > > > > +++ b/profiles/input/hog.c
> > > > > > @@ -49,6 +49,8 @@
> > > > > >  #include "src/shared/util.h"
> > > > > >  #include "src/shared/uhid.h"
> > > > > >  #include "src/shared/queue.h"
> > > > > > +#include "src/shared/att.h"
> > > > > > +#include "src/shared/gatt-client.h"
> > > > > >  #include "src/plugin.h"
> > > > > >
> > > > > >  #include "suspend.h"
> > > > > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *=
service)
> > > > > >         }
> > > > > >
> > > > > >         /* HOGP 1.0 Section 6.1 requires bonding */
> > > > > > -       if (!device_is_bonded(device, btd_device_get_bdaddr_typ=
e(device)))
> > > > > > -               return -ECONNREFUSED;
> > > > > > +       if (!device_is_bonded(device, btd_device_get_bdaddr_typ=
e(device))) {
> > > > > > +               struct bt_gatt_client *client;
> > > > > > +
> > > > > > +               client =3D btd_device_get_gatt_client(device);
> > > > > > +               if (!bt_gatt_client_set_security(client,
> > > > > > +                                               BT_ATT_SECURITY=
_MEDIUM)) {
> > > > > > +                       return -ECONNREFUSED;
> > > > > > +               }
> > > > > > +       }
> > > > > I wonder if this is really necessary.  For example, this may caus=
e a
> > > > > device the user has not deliberately bonded to suddenly expose a =
HOG
> > > > > Service which will trigger the user to pair (most users are known=
 to
> > > > > blindly accept the pairing).  I believe the previous posture is m=
ore
> > > > > secure by having the user deliberately pair HID devices as oppose=
d to
> > > > > on demand.
> > > >
> > > > There are dedicated APIs to connect specific profiles, so if
> > > > hog_accept is reached it means the user/application does want to
> > > > connect HoG and in that case it should trigger bonding, so this onl=
y
> > > > automate the process, like Ive commented for legacy HID we already
> > > > attempt to bump the security in a similar way. Having the user
> > > > deliberately pair may cause breakage since in most cases the GATT
> > > > services do that on demand, in fact HoG is possibly the only except=
ion
> > > > to that since it appear to mandate encryption at connection level
> > > > rather than on attribute level, so if the user had a peripheral tha=
t
> > > > used to not require bonding it will suddenly stop working but if we=
 do
> > > > have this change it would possible still work after the pairing
> > > > procedure is complete.
> > > The outgoing contract where the user somehow asked for the profile to
> > > be connected and would result in pairing, I'm ok with.  However, this
> > > being in the accept path, it doesn't seem to always be client side
> > > initiated, so that still seems like a concern to me.
> >
> > Since this is a profile so we are always acting as GATT client here,
> > so it is either initiated by the client when setting up a new
> > peripheral or it has been previously setup with Add Device and is
> > marked to auto connect, the later is exactly the problem I described
> > that there could be existing peripheral not requiring bonding that
> > suddenly stop working.
> My understanding is that the HOG service can get added to any other
> device through a service change notification or other means, so I
> don't think it is a safe assumption that this code will only execute
> if a user explicitly requested it.

I would assume the users would expect that this would trigger pairing
procedure since silently ignoring the change would make this go
completely unnoticed.

> You are correct that the change may cause a device to stop working if
> it was using HOGP without bonding, but this would also be a non
> compliant device and one that compromises the system's security.  I'm
> ok if we make this a configuration in case you believe the
> compatibility with these sorts of scenarios must be maintained.

This gets a bit tricky since the HOGP mandates security but HIDS does not:

Security Permissions of =E2=80=9CNone=E2=80=9D means that this service does=
 not impose
any requirements.

So my understanding is that a peripheral implementing HIDS does _not_
require bonding and to make matters more confusing none of the
attributes requires security etiher which is perhaps the very reason
HOGP mandates bonding, also afaik peripherals are not mandate to
initiate pairing procedures so it looks like peripherals can in fact
not require bonding and still be compliant.

> >
> > > >
> > > > >
> > > > > >
> > > > > >         /* TODO: Replace GAttrib with bt_gatt_client */
> > > > > >         bt_hog_attach(dev->hog, attrib);
> > > > > > --
> > > > > > 2.21.1
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
