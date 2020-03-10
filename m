Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28AAC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A921655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwzlDyOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJVJh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:09:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36568 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJVJh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 17:09:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so3584923ljj.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0iz4pB2RYDA3s//K/N7JfsdEAOQ2P6MwBJz4BKndr9I=;
        b=WwzlDyOoYaG3CMfV9GNdbRNXnexUpyguhx8tINybapGF5rztyATyjIa0LxmkuFGb6c
         QEql5omP3gm7s41qNjzsQuDALgneYqJ9fUyd4T+oqKApj/FbbPNQ/Lzf9tgNHklJSdsO
         BPPqbvwisgRC9dITGMJW5G1G9zaBSpRF+IKCVGveLow+C8im2nZDB/VMh0tWTP+AGpRC
         EK7xYNqi1YIMiaMPSwwArErk9j57h7TkpVCM4cfMwP3Wv/i9J5H5K5bI+Bxdl2GYZTA9
         NroJcsp2i8drxTS4OHM8Dkxbt3t0JycKBZmROsFenW0CPzlqhQKQ6LQr2ZTQuMqvYfR6
         zGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0iz4pB2RYDA3s//K/N7JfsdEAOQ2P6MwBJz4BKndr9I=;
        b=A9DNdVQjw/qfohWapFs1PTM96u44pDw+xzfpThzQQfMNzzAck/JZDDDpGRtF8oK2Qa
         ce5VFC6jStNF01s9TzD7/bRUrPBtrfs2eIXpvWvSY0GTueTxzoCAzTnxK5TN03bnyigF
         Ai8tAEJ1lQ0MP9MmJ2M5y7A3ZF1dLFjF0xCDh3bHoAgXTHk8QtOehD/tWtEuZbsg+Jzg
         QzGDgIrgdIF7b8J+NVsfdR481m8KDh+RkpkKsWhH5ZJK9w08egt7d/jAoESHLlvaSR4q
         3lu90DHvpfXGQLMQbNipjD8d4VW3lfmw8/olFs+6PMpp09mz6pbVNZXsLLR6o469ZTe7
         61xg==
X-Gm-Message-State: ANhLgQ2lrUN479Yu6TQyeXj9xK8kd6fmqkT4g8iAJUiYyxOul6mougOT
        ZAeVpHuyMZpflhTSorDPTNBYQbWVYzNmvsE0ryiU7w==
X-Google-Smtp-Source: ADFU+vsuoBQmPt9a7KPMa8oX1+PLdgL+QnyAW5Ln9ilL72xkc0AgcSXW8V1/z7ZFW69UkwFDRQzKLfxcFzwdfEre2uw=
X-Received: by 2002:a2e:890b:: with SMTP id d11mr81289lji.79.1583874573980;
 Tue, 10 Mar 2020 14:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com> <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
 <CABBYNZ+6NDnuErRSiUkVacOViCBz1Bieda_KYD_0c3VrveER-A@mail.gmail.com>
 <CALWDO_Ws7=aEuhUU7GiGJ1=x4WREO8K1V=D4iGOABo0_ik9eRA@mail.gmail.com>
 <CABBYNZ+pbPswfY4AGpvL8XQL3JVPPi9srO5qt-8KbKzMDi+W9g@mail.gmail.com>
 <CALWDO_UBgHxtaO8U8kLpAdXaL7B1HMXVhbGANKf3Fnk9G9Hwcw@mail.gmail.com>
 <CABBYNZ+H6Tv--z-u9Lr=M_XJ1RUXrRS6nwqxkSpjKpSPMSzK5w@mail.gmail.com> <CALWDO_W1G9H5YbBG0v4s94NxN5Jh=mJ2ZJZMhEuvUVSYwt-h9g@mail.gmail.com>
In-Reply-To: <CALWDO_W1G9H5YbBG0v4s94NxN5Jh=mJ2ZJZMhEuvUVSYwt-h9g@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 17:09:22 -0400
Message-ID: <CALWDO_XOOGiVZwWi2i14fTkpzajo2q5gg+PJBHF-fAcrZG7q2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resending in plain text :)


On Tue, Mar 10, 2020 at 5:07 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Luiz
>
> On Tue, Mar 10, 2020 at 4:39 PM Luiz Augusto von Dentz <luiz.dentz@gmail.=
com> wrote:
>>
>> Hi Alain,
>>
>> On Tue, Mar 10, 2020 at 11:53 AM Alain Michaud <alainmichaud@google.com>=
 wrote:
>> >
>> > Hi Luiz,
>> >
>> > On Tue, Mar 10, 2020 at 2:46 PM Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> > >
>> > > Hi Alain,
>> > >
>> > > On Tue, Mar 10, 2020 at 11:37 AM Alain Michaud <alainmichaud@google.=
com> wrote:
>> > > >
>> > > > Hi Luiz,
>> > > >
>> > > > On Tue, Mar 10, 2020 at 2:27 PM Luiz Augusto von Dentz
>> > > > <luiz.dentz@gmail.com> wrote:
>> > > > >
>> > > > > Hi Alain,
>> > > > >
>> > > > > On Tue, Mar 10, 2020 at 11:04 AM Alain Michaud <alainmichaud@goo=
gle.com> wrote:
>> > > > > >
>> > > > > > Hi Luiz,
>> > > > > >
>> > > > > > On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
>> > > > > > <luiz.dentz@gmail.com> wrote:
>> > > > > > >
>> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > > > > > >
>> > > > > > > This attempts to set the security if the device is not bonde=
d, the
>> > > > > > > kernel will block any communication on the ATT socket while =
bumping
>> > > > > > > the security and if that fails the device will be disconnect=
ed which
>> > > > > > > is better than having the device dangling around without bei=
ng able to
>> > > > > > > communicate with it until it is properly bonded.
>> > > > > > > ---
>> > > > > > >  profiles/input/hog.c | 13 +++++++++++--
>> > > > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
>> > > > > > >
>> > > > > > > diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> > > > > > > index dfac68921..f0226ebbd 100644
>> > > > > > > --- a/profiles/input/hog.c
>> > > > > > > +++ b/profiles/input/hog.c
>> > > > > > > @@ -49,6 +49,8 @@
>> > > > > > >  #include "src/shared/util.h"
>> > > > > > >  #include "src/shared/uhid.h"
>> > > > > > >  #include "src/shared/queue.h"
>> > > > > > > +#include "src/shared/att.h"
>> > > > > > > +#include "src/shared/gatt-client.h"
>> > > > > > >  #include "src/plugin.h"
>> > > > > > >
>> > > > > > >  #include "suspend.h"
>> > > > > > > @@ -187,8 +189,15 @@ static int hog_accept(struct btd_servic=
e *service)
>> > > > > > >         }
>> > > > > > >
>> > > > > > >         /* HOGP 1.0 Section 6.1 requires bonding */
>> > > > > > > -       if (!device_is_bonded(device, btd_device_get_bdaddr_=
type(device)))
>> > > > > > > -               return -ECONNREFUSED;
>> > > > > > > +       if (!device_is_bonded(device, btd_device_get_bdaddr_=
type(device))) {
>> > > > > > > +               struct bt_gatt_client *client;
>> > > > > > > +
>> > > > > > > +               client =3D btd_device_get_gatt_client(device=
);
>> > > > > > > +               if (!bt_gatt_client_set_security(client,
>> > > > > > > +                                               BT_ATT_SECUR=
ITY_MEDIUM)) {
>> > > > > > > +                       return -ECONNREFUSED;
>> > > > > > > +               }
>> > > > > > > +       }
>> > > > > > I wonder if this is really necessary.  For example, this may c=
ause a
>> > > > > > device the user has not deliberately bonded to suddenly expose=
 a HOG
>> > > > > > Service which will trigger the user to pair (most users are kn=
own to
>> > > > > > blindly accept the pairing).  I believe the previous posture i=
s more
>> > > > > > secure by having the user deliberately pair HID devices as opp=
osed to
>> > > > > > on demand.
>> > > > >
>> > > > > There are dedicated APIs to connect specific profiles, so if
>> > > > > hog_accept is reached it means the user/application does want to
>> > > > > connect HoG and in that case it should trigger bonding, so this =
only
>> > > > > automate the process, like Ive commented for legacy HID we alrea=
dy
>> > > > > attempt to bump the security in a similar way. Having the user
>> > > > > deliberately pair may cause breakage since in most cases the GAT=
T
>> > > > > services do that on demand, in fact HoG is possibly the only exc=
eption
>> > > > > to that since it appear to mandate encryption at connection leve=
l
>> > > > > rather than on attribute level, so if the user had a peripheral =
that
>> > > > > used to not require bonding it will suddenly stop working but if=
 we do
>> > > > > have this change it would possible still work after the pairing
>> > > > > procedure is complete.
>> > > > The outgoing contract where the user somehow asked for the profile=
 to
>> > > > be connected and would result in pairing, I'm ok with.  However, t=
his
>> > > > being in the accept path, it doesn't seem to always be client side
>> > > > initiated, so that still seems like a concern to me.
>> > >
>> > > Since this is a profile so we are always acting as GATT client here,
>> > > so it is either initiated by the client when setting up a new
>> > > peripheral or it has been previously setup with Add Device and is
>> > > marked to auto connect, the later is exactly the problem I described
>> > > that there could be existing peripheral not requiring bonding that
>> > > suddenly stop working.
>> > My understanding is that the HOG service can get added to any other
>> > device through a service change notification or other means, so I
>> > don't think it is a safe assumption that this code will only execute
>> > if a user explicitly requested it.
>>
>> I would assume the users would expect that this would trigger pairing
>> procedure since silently ignoring the change would make this go
>> completely unnoticed.
>
> In this case it may be a device impersonating a device you were just comm=
unicating with without bonding, manages to connect and expose an HOG Servic=
e and all of the suddent requests a pairing confirmation.  Data suggests us=
ers pay little attention to these sorts of notification and tend to blindly=
 accept them leading them to a compromised state.  HOGP is unique in the se=
nse that the consequences are higher since it can lead to executing code in=
 the user's context by injecting keystrokes.
>>
>>
>> > You are correct that the change may cause a device to stop working if
>> > it was using HOGP without bonding, but this would also be a non
>> > compliant device and one that compromises the system's security.  I'm
>> > ok if we make this a configuration in case you believe the
>> > compatibility with these sorts of scenarios must be maintained.
>>
>> This gets a bit tricky since the HOGP mandates security but HIDS does no=
t:
>>
>> Security Permissions of =E2=80=9CNone=E2=80=9D means that this service d=
oes not impose
>> any requirements.
>>
>> So my understanding is that a peripheral implementing HIDS does _not_
>> require bonding and to make matters more confusing none of the
>> attributes requires security etiher which is perhaps the very reason
>> HOGP mandates bonding, also afaik peripherals are not mandate to
>> initiate pairing procedures so it looks like peripherals can in fact
>> not require bonding and still be compliant.
>
>
> The peripheral yes, but HOGP would not so I'd assert if the device is req=
uired to work without bonding, it likely didn't pass the profile qualificat=
ion.
>
> As stated before,  it seems acceptable to me if BlueZ would want a more c=
ompatible posture here, I would however like to request that a configuratio=
n be available so that HOGP can simply reject as the original patch did.
>
>>
>>
>> > >
>> > > > >
>> > > > > >
>> > > > > > >
>> > > > > > >         /* TODO: Replace GAttrib with bt_gatt_client */
>> > > > > > >         bt_hog_attach(dev->hog, attrib);
>> > > > > > > --
>> > > > > > > 2.21.1
>> > > > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > > --
>> > > > > Luiz Augusto von Dentz
>> > >
>> > >
>> > >
>> > > --
>> > > Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
