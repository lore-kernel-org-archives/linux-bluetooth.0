Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E4C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BC62071B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVR3deuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJXfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:35:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33789 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJXfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 19:35:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so257941ljp.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LsgpEUiUKyrURcXLrkUcl42gnwA2NgJmCnyAYXeLFu0=;
        b=QVR3deuJIjLRnTYG1mHTw1GPQUhkTmo07MXqIrkyGLLHOtFQMkjD4iKR5KgL0c6yQ0
         7e7sGQ+ClJvbbYCK+jFMG0Jrev94G10F/Y0d0cvnInypBtasehEThAK8zsuImNAQHMS/
         Liisd+FauYWfDAyZfw/Cm579N2OvCWrxbrZL5SyBKVVakBlH9lIU84NXz5jZtMYk3NvS
         WZD/Z1MppuTsjC+2QBmjQQlV6TawJbKjGcz/4GnNNIsSF9+6t9F4Td3vOUhznVDnv0A1
         KQ9JA/cNzgYsBiteIbVTk1iU9nnaSjlyhvEkedzSwBCs8ljp1VZSa97Mc52VA5p8VxJW
         VfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LsgpEUiUKyrURcXLrkUcl42gnwA2NgJmCnyAYXeLFu0=;
        b=WDmqKcq0KdsH+2B9/UuaGDCQ/iHB60K+kAiR3BMgivIUyrhLJDcNpCfJ821XiCxLXG
         6AzzJwSxDsGeYFFt3mvA1fU98dMc36tJOZT7SOZG/8AgkNkfCIsgkL9GbXenWOWR4qrW
         38gnPdcXYKPLzN5OHGQUMNJTjwP97tJWgPPT8KIEd3qxaDK2Dv4fc+WpxddqIJrv/MDV
         v5Sc9mqO97MLlkVFtrgGVmzdXjx2uSADnRN2bU2Zfx2tJbCCSAQprClNNB6yPVJRttZo
         fPJ7pnHlws5/g7ZYNCtNhUla9BtpYgRj7oqqG5m8DHvZVEFvH38eKDwxZCF71L2Uxi7P
         P5ag==
X-Gm-Message-State: ANhLgQ1WxAf24UPOjpaAA5yTf7Cg1tsFE0IMY8aa8TscMTvPSnuov+JB
        5nrVlPvcbjVZdI0XWmwWEmSg0tXR4upxU74opfKo6hvN
X-Google-Smtp-Source: ADFU+vsVeABg3lcg1wTwf0Eg8N4K1Opu/2iSalxVOaFl8f2BCqdpWCmxnPimmWAvYFhqc4s6FJ1++Pnij+8tGxb3Gs8=
X-Received: by 2002:a2e:8893:: with SMTP id k19mr331710lji.55.1583883346436;
 Tue, 10 Mar 2020 16:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
 <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
 <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com>
 <CALWDO_UBgHxtaO8U8kLpAdXaL7B1HMXVhbGANKf3Fnk9G9Hwcw@mail.gmail.com>
 <CABBYNZ+H6Tv--z-u9Lr=M_XJ1RUXrRS6nwqxkSpjKpSPMSzK5w@mail.gmail.com>
 <CALWDO_W1G9H5YbBG0v4s94NxN5Jh=mJ2ZJZMhEuvUVSYwt-h9g@mail.gmail.com> <CABBYNZLewocbWMyJCqNYP+7RtbBXirGUFbCxF9ckscHURHcrSA@mail.gmail.com>
In-Reply-To: <CABBYNZLewocbWMyJCqNYP+7RtbBXirGUFbCxF9ckscHURHcrSA@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 19:35:34 -0400
Message-ID: <CALWDO_WNRoEXEuiW2ZgQ_8drmuroTJVRKGgxc+brah00N8+P3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, Mar 10, 2020 at 6:29 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Tue, Mar 10, 2020 at 2:07 PM Alain Michaud <alainmichaud@google.com> w=
rote:
> >
> > Hi Luiz
> >
> > On Tue, Mar 10, 2020 at 4:39 PM Luiz Augusto von Dentz <luiz.dentz@gmai=
l.com> wrote:
> >>
> >> Hi Alain,
> >>
> >> On Tue, Mar 10, 2020 at 11:53 AM Alain Michaud <alainmichaud@google.co=
m> wrote:
> >> >
> >> > Hi Luiz,
> >> >
> >> > On Tue, Mar 10, 2020 at 2:46 PM Luiz Augusto von Dentz
> >> > <luiz.dentz@gmail.com> wrote:
> >> > >
> >> > > Hi Alain,
> >> > >
> >> > > On Tue, Mar 10, 2020 at 11:37 AM Alain Michaud <alainmichaud@googl=
e.com> wrote:
> >> > > >
> >> > > > Hi Luiz,
> >> > > >
> >> > > > On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
> >> > > > <luiz.dentz@gmail.com> wrote:
> >> > > > >
> >> > > > > Hi Alain,
> >> > > > >
> >> > > > > On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@g=
oogle.com> wrote:
> >> > > > > >
> >> > > > > > Hi Luiz,
> >> > > > > >
> >> > > > > > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
> >> > > > > > <luiz.dentz@gmail.com> wrote:
> >> > > > > > >
> >> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> > > > > > >
> >> > > > > > > This attempts to set the security if the device is not bon=
ded, the
> >> > > > > > > kernel will block any communication on the ATT socket whil=
e bumping
> >> > > > > > > the security and if that fails the device will be disconne=
cted which
> >> > > > > > > is better than having the device dangling around without b=
eing able to
> >> > > > > > > communicate with it until it is properly bonded.
> >> > > > > > > ---
> >> > > > > > >  profiles/input/hog.c | 13 +++++++++++--
> >> > > > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> >> > > > > > >
> >> > > > > > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> >> > > > > > > index dfac68921..f0226ebbd 100644
> >> > > > > > > --- a/profiles/input/hog.c
> >> > > > > > > +++ b/profiles/input/hog.c
> >> > > > > > > @@ -49,6 +49,8 @@
> >> > > > > > >  #include "src/shared/util.h"
> >> > > > > > >  #include "src/shared/uhid.h"
> >> > > > > > >  #include "src/shared/queue.h"
> >> > > > > > > +#include "src/shared/att.h"
> >> > > > > > > +#include "src/shared/gatt-client.h"
> >> > > > > > >  #include "src/plugin.h"
> >> > > > > > >
> >> > > > > > >  #include "suspend.h"
> >> > > > > > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_serv=
ice *service)
> >> > > > > > >         }
> >> > > > > > >
> >> > > > > > >         /* HOGP 1.0 Section 6.1 requires bonding */
> >> > > > > > > -       if (!device_is_bonded(device, btd_device_get_bdadd=
r_type(device)))
> >> > > > > > > -               return -ECONNREFUSED;
> >> > > > > > > +       if (!device_is_bonded(device, btd_device_get_bdadd=
r_type(device))) {
> >> > > > > > > +               struct bt_gatt_client *client;
> >> > > > > > > +
> >> > > > > > > +               client =3D btd_device_get_gatt_client(devi=
ce);
> >> > > > > > > +               if (!bt_gatt_client_set_security(client,
> >> > > > > > > +                                               BT_ATT_SEC=
URITY_MEDIUM)) {
> >> > > > > > > +                       return -ECONNREFUSED;
> >> > > > > > > +               }
> >> > > > > > > +       }
> >> > > > > > I wonder if this is really necessary.  For example, this may=
 cause a
> >> > > > > > device the user has not deliberately bonded to suddenly expo=
se a HOG
> >> > > > > > Service which will trigger the user to pair (most users are =
known to
> >> > > > > > blindly accept the pairing).  I believe the previous posture=
 is more
> >> > > > > > secure by having the user deliberately pair HID devices as o=
pposed to
> >> > > > > > on demand.
> >> > > > >
> >> > > > > There are dedicated APIs to connect specific profiles, so if
> >> > > > > hog_accept is reached it means the user/application does want =
to
> >> > > > > connect HoG and in that case it should trigger bonding, so thi=
s only
> >> > > > > automate the process, like Ive commented for legacy HID we alr=
eady
> >> > > > > attempt to bump the security in a similar way. Having the user
> >> > > > > deliberately pair may cause breakage since in most cases the G=
ATT
> >> > > > > services do that on demand, in fact HoG is possibly the only e=
xception
> >> > > > > to that since it appear to mandate encryption at connection le=
vel
> >> > > > > rather than on attribute level, so if the user had a periphera=
l that
> >> > > > > used to not require bonding it will suddenly stop working but =
if we do
> >> > > > > have this change it would possible still work after the pairin=
g
> >> > > > > procedure is complete.
> >> > > > The outgoing contract where the user somehow asked for the profi=
le to
> >> > > > be connected and would result in pairing, I'm ok with.  However,=
 this
> >> > > > being in the accept path, it doesn't seem to always be client si=
de
> >> > > > initiated, so that still seems like a concern to me.
> >> > >
> >> > > Since this is a profile so we are always acting as GATT client her=
e,
> >> > > so it is either initiated by the client when setting up a new
> >> > > peripheral or it has been previously setup with Add Device and is
> >> > > marked to auto connect, the later is exactly the problem I describ=
ed
> >> > > that there could be existing peripheral not requiring bonding that
> >> > > suddenly stop working.
> >> > My understanding is that the HOG service can get added to any other
> >> > device through a service change notification or other means, so I
> >> > don't think it is a safe assumption that this code will only execute
> >> > if a user explicitly requested it.
> >>
> >> I would assume the users would expect that this would trigger pairing
> >> procedure since silently ignoring the change would make this go
> >> completely unnoticed.
> >
> > In this case it may be a device impersonating a device you were just co=
mmunicating with without bonding, manages to connect and expose an HOG Serv=
ice and all of the suddent requests a pairing confirmation.  Data suggests =
users pay little attention to these sorts of notification and tend to blind=
ly accept them leading them to a compromised state.  HOGP is unique in the =
sense that the consequences are higher since it can lead to executing code =
in the user's context by injecting keystrokes.
>
> Sure but this is true regardless of doing pairing automatically or
> requiring the user to pair it manually, or you are suggesting this is
> safer because it would have the go over the setting to start the
> pairing? Im afraid not all user interface would react the same in this
> regard,  or at all,also at this state even if the user pair the device
> it would have to reconnect before it start working again since the
> driver would not be probed again.
The difference is in the context.  In one case, the user is
deliberately trying to add a device and is cognitively within the
right context to be able to make a deliberate choice to choose a
device from the list and pair against it.  In the other, they are
receiving an unsolicited request to pair which they may or may not
understand sufficiently to make the right choice.

I agree, not all user interfaces (or frankly platforms) have the same
requirements.
>
> >>
> >>
> >> > You are correct that the change may cause a device to stop working i=
f
> >> > it was using HOGP without bonding, but this would also be a non
> >> > compliant device and one that compromises the system's security.  I'=
m
> >> > ok if we make this a configuration in case you believe the
> >> > compatibility with these sorts of scenarios must be maintained.
> >>
> >> This gets a bit tricky since the HOGP mandates security but HIDS does =
not:
> >>
> >> Security Permissions of =E2=80=9CNone=E2=80=9D means that this service=
 does not impose
> >> any requirements.
> >>
> >> So my understanding is that a peripheral implementing HIDS does _not_
> >> require bonding and to make matters more confusing none of the
> >> attributes requires security etiher which is perhaps the very reason
> >> HOGP mandates bonding, also afaik peripherals are not mandate to
> >> initiate pairing procedures so it looks like peripherals can in fact
> >> not require bonding and still be compliant.
> >
> >
> > The peripheral yes, but HOGP would not so I'd assert if the device is r=
equired to work without bonding, it likely didn't pass the profile qualific=
ation.
>
> It would have pass it alright, its the PTS side that would exercise
> this requirement of HOGP not the peripheral, the peripheral just have
> to respond to the pairing procedure but it may never inititate it by
> itself. Like I said none of HIDS attributes require any security and
> the TS don't seem to even test authentication errors as it only
> mentions something like:
>
> If the IUT requires a bonding procedure then perform a bonding procedure.
>
> Take for example zephyr hids example:
>
> https://github.com/zephyrproject-rtos/zephyr/blob/master/samples/bluetoot=
h/peripheral_hids/src/hog.c
>
> It never checks for bonding nor it requires any security, so if I attempt=
:
>
> #bluetoothctl> connect
>
> HoG no longer connects.
>
> > As stated before,  it seems acceptable to me if BlueZ would want a more=
 compatible posture here, I would however like to request that a configurat=
ion be available so that HOGP can simply reject as the original patch did.
>
> Well in that case we would have to implement reprobing logic so that
> if the device gets paired hog_accept should be called once again, imo
> triggering bonding seems a better alternative in the sort term until
> we verify all use cases are attended.
I don't think re_probing is necessary in this case since we wouldn't
expect it to be "upgraded" to a bonded state.  For the golden path we
would expect to start bonded.

Again, I respect the different requirements where some platforms may
want to allow this upgrading, what I'm articulating is that some
platforms may also want to take a more secure posture and not allow
this upgrade to take place automatically and instead require that the
user deliberately initiate pairing with HID devices.  The later, more
secure posture, would be my preference for chromium platforms hence
the request to make this conditional to a configuration that can be
applied on some platforms.

>
> >>
> >>
> >> > >
> >> > > > >
> >> > > > > >
> >> > > > > > >
> >> > > > > > >         /* TODO: Replace GAttrib with bt_gatt_client */
> >> > > > > > >         bt_hog_attach(dev->hog, attrib);
> >> > > > > > > --
> >> > > > > > > 2.21.1
> >> > > > > > >
> >> > > > >
> >> > > > >
> >> > > > >
> >> > > > > --
> >> > > > > Luiz Augusto von Dentz
> >> > >
> >> > >
> >> > >
> >> > > --
> >> > > Luiz Augusto von Dentz
> >>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
