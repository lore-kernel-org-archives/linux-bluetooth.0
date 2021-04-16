Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CEC610FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 00:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhDPAtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhDPAtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:49 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46AC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 17:49:24 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v13so5714206ilj.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTCqvrbXjl7dmSM3OCgMl6j1my5cFtYCCqqfsb4oK3Y=;
        b=kVGa0JHwkWLK0IsvVgAklOnjkp2Yi6nASRahDksF6fpq8DCcsKO09NcAd9SxjrclxO
         Qd6gmpR2OZRkLuUFgnZGLrw4aUYJW6c3OO1r8VFTYIu6kNEI39Leu+FMCzyHwdlztpzS
         Zo8aEUnaRrQvlO7f9e0n+1NwqG5TkdrLp7JT66aAFkHzU4R9HTnHMmnUODI2aZeLHNCp
         6WwMake3sOe/somTLr/8DSt/ytUsa5/zJ5L6MpjEtnET0fJ4FywTd+v67Hpg73YgBG7O
         JVzfr3eEDQQKa3zG1ObEYAiUY5byY4RQvS4jvl+sLlq/RxQ3bA70HVhYGMGTfLRlRIJQ
         GZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTCqvrbXjl7dmSM3OCgMl6j1my5cFtYCCqqfsb4oK3Y=;
        b=AyBAMHeVk2MW4DIMHztfjRwpaSdyCfanSAqns0n7c/gA60RLflTLrKGJsHBRJXmKeS
         BS/xxBzv/03MBx3ny96IcECDmTiyRLFyUDHUdNnTvpgerX2gkl59DW3kztto9ffHABfJ
         V20RwB4FyP6G9r6YAnTwMnXlW5dGMBMl3dsnoAcoMpG185KtUow0WIaXol+V8i3SetZY
         dLL2q+YVPOgRWReWJRXp89lrV9xCpAFJ3+E1aARdpn9ysSWhTgeoaXJNyoiFI4ByVYjs
         K8RyIswNsHD8jV8jH6Lv3F1MN6RdLq6huugZ02vrvEGeW0faemOrcNKAtPETPuzkcMxv
         JTyw==
X-Gm-Message-State: AOAM532g/nOLVH9yUsJ9qswgVqVvccYBw+/2hSFe60ww3JF0OlKJ5sbt
        Zbm7qZbL5NukyWVKefuwmPgrDUyF3Nx8IwA3wSvimG0T4zg=
X-Google-Smtp-Source: ABdhPJyOLTmVWGKNzR09d0WkkyhH4Cy5sgZWs7BKwms2GF/90+muAkx4bxQYHl6lxaxM7ixn/YTXond3mT7g4Nv/Xic=
X-Received: by 2002:a05:6e02:1aaa:: with SMTP id l10mr4959419ilv.29.1618534163630;
 Thu, 15 Apr 2021 17:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
 <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
 <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
 <CABBYNZLzu+subZu5L6FYmrLB=w7hK3_kJ51LDmd3aCufR-UVBQ@mail.gmail.com> <CAC9s0NZtc_8fXQdZn_1USxixSzbaj2d1OcOn=EoJGFHhX75LjQ@mail.gmail.com>
In-Reply-To: <CAC9s0NZtc_8fXQdZn_1USxixSzbaj2d1OcOn=EoJGFHhX75LjQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Apr 2021 17:49:12 -0700
Message-ID: <CABBYNZ+Tdxh+yecJgTLg3m=+QJHBVZqG=TSxF7bbJTAOYkjX8g@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Kenny Bian <kennybian@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Thu, Apr 15, 2021 at 5:21 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> Thank you so much. I appreciate it.
>
> That was my bad. I just checked. Our system is Ubuntu 18.04. The BlueZ
> version is "5.48-0ubuntu3.4" which is different from the versions in
> http://www.bluez.org/. I'm trying to figure out if this version
> includes the version 5.50. Do you know the corresponding BlueZ version
> for "5.48-0ubuntu3.4"?

5.48, which was the version available in 2018, more than 3 years/10
releases ago, a lot of things have been fixed over this time so Id
really recommend to upgrade to the latest if you want to have some
support.

> Thanks!
> Kenny
>
> On Thu, Apr 15, 2021 at 1:31 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Kenny,
> >
> > On Wed, Apr 14, 2021 at 10:44 PM Kenny Bian <kennybian@gmail.com> wrote=
:
> > >
> > > Hi Luiz,
> > >
> > > There is a UI example of nRF Connect which shows the "Service Changed
> > > Indication" is under "Generic
> > > Attribute"(http://forum.espruino.com/conversations/357737/). We're
> > > using BlueZ 5.48. I tried to add it by modifying example-gatt-server:
> >
> >
> > You should have mentioned that you are using 5.48, you need the followi=
ng patch:
> >
> > commit a0b886e26c83ad4dfbf0b2b2e024c8ce9ead9a7d
> > Author: Szymon Janc <szymon.janc@codecoup.pl>
> > Date:   Wed Mar 28 12:10:55 2018 +0200
> >
> >     gatt: Add support for storing Service Changed CCC value
> >
> >     This adds support for storing CCC value of Service Changed
> >     characteristic. Once bluetoothd is restart stored values are read
> >     and any device subscribed to indications will receive Service Chang=
ed
> >     indication with 0x00010-0xffff value. This is to invalidate any
> >     non-core services since there is no way to verify if applications
> >     will register their services in same order (or at all).
> >
> >     This fix accessing invalid handles by stacks that rely only on Serv=
ice
> >     Changed indication for rediscovery ie. Apple iOS.
> >
> > Or upgrade to a BlueZ release that has the above patch, which should be=
 5.50:
> >
> > +ver 5.50:
> > +       Fix issue with GATT and reading long values.
> > +       Fix issue with GATT and reading multiple includes.
> > +       Fix issue with GATT and service changes when offline.
> > +       Fix issue with handling secondary service discovery.
> > +       Fix issue with handling persistency of CCC values.
> >
> > >
> > > class ServiceChangedChrc(Characteristic):
> > >     SCI_UUID =3D '00002a05-0000-1000-8000-00805f9b34fb'
> > >
> > >     def __init__(self, bus, index, service):
> > >         Characteristic.__init__(
> > >                 self, bus, index,
> > >                 self.SCI_UUID,
> > >                 ['indicate'],
> > >                 service)
> > >
> > >     def IndicateValue(self, options):
> > >         # This function doesn't exist. Just list it here.
> > >         pass
> > >
> > >
> > > class ServiceChangedService(Service):
> > >     MY_UUID =3D '00001801-0000-1000-8000-00805f9b34fb'
> > >
> > >     def __init__(self, bus, index):
> > >         Service.__init__(self, bus, index, self.MY_UUID, True)
> > >         self.add_characteristic(ServiceChangedChrc(bus, 0, self))
> > >
> > >
> > > class Application(dbus.service.Object):
> > >     """
> > >     org.bluez.GattApplication1 interface implementation
> > >     """
> > >     def __init__(self, bus):
> > >         self.path =3D '/'
> > >         self.services =3D []
> > >         dbus.service.Object.__init__(self, bus, self.path)
> > >         self.add_service(HeartRateService(bus, 0))
> > >         self.add_service(BatteryService(bus, 1))
> > >         self.add_service(TestService(bus, 2))
> > >         self.add_service(ServiceChangedService(bus, 3))
> > >
> > >
> > > When I run it, there is "Failed to register application:
> > > org.bluez.Error.Failed: Failed to create entry in database". That is
> > > in the function client_ready_cb() in gatt-database.c in BlueZ code. D=
o
> > > you know how to fix it?
> >
> > You don't need to register Service Changed, the daemon already takes
> > care of registering it and there could only be one Service Changed in
> > the database.
> >
> > > Thanks!
> > > Kenny
> > >
> > > On Tue, Apr 13, 2021 at 9:46 PM Kenny Bian <kennybian@gmail.com> wrot=
e:
> > > >
> > > > Hi Jamie, Luiz,
> > > >
> > > > Thanks for your info.
> > > >
> > > > Luiz, to answer your questions:
> > > > BlueZ doesn't seem to emit "Service Changed Indication". Or it does
> > > > emit it, but we don't know how to verify it.
> > > > Yes, BlueZ acts as a GATT server which runs on Linux.
> > > >
> > > > So my questions:
> > > > How can I tell if "Service Changed Indication" is working? I need t=
o
> > > > show it to our app developers that the GATT server does send the
> > > > "Service Changed Indication" when there is a service change.
> > > > By disabling the GATT's cache in "/etc/bluetooth/main.conf", the
> > > > "Service Changed Indication" is disabled?
> > > > Can "Service Changed Indication" be enabled in a conf file? Or shou=
ld
> > > > it be done in the Python code? Could you please help find out that
> > > > info?
> > > > Our GATT server is based on the Python code
> > > > examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/te=
st).
> > > > I don't know how to enable "Service Changed Indication" or "Robust
> > > > Caching" in Python code on the GATT server side. There is no docume=
nt
> > > > or code samples about that. Please let me know if there is any
> > > > document or Python code example.
> > > >
> > > > Thanks!
> > > > Kenny
> > > >
> > > > On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Jamie, Brian,
> > > > >
> > > > > On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> > > > > <Jamie.Mccrae@lairdconnect.com> wrote:
> > > > > >
> > > > > > Hi Kenny,
> > > > > > Why not just add the service changed indication as you refer to=
 below? It was purposely designed for this specific purpose, you're trying =
to work around an issue created because you don't want to use the feature t=
hat prevents this issue. Any workaround is just that, a workaround, and mig=
ht not work as intended.
> > > > >
> > > > > Yep, and while at it implement the so called Robust Caching featu=
re so
> > > > > we can detect if anything has changed by reading the DB Hash.
> > > > >
> > > > > > Thanks,
> > > > > > Jamie
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Kenny Bian <kennybian@gmail.com>
> > > > > > Sent: 13 April 2021 06:59
> > > > > > To: linux-bluetooth@vger.kernel.org
> > > > > > Subject: Disabled bluetooth cache. But the app still getting wr=
ong data?
> > > > > >
> > > > > > EXTERNAL EMAIL: Be careful with attachments and links.
> > > > > >
> > > > > > Previously we had an issue: if there is a change of characteris=
tics in the new build of our firmware, then the app will get the wrong data=
.
> > > > > > By saying changed characteristics, it can be an added or remove=
d characteristic, or adding notification to an existing characteristic.
> > > > > > In order to keep the pairing information, the "/var/lib/bluetoo=
th"
> > > > > > folder is copied over to the new build's partition. We realized=
 that there is no "service changed indication". The app can't handle the ch=
anged services. So we disabled the bluetooth cache by set this in
> > > > > > "/etc/bluetooth/main.conf":
> > > > > > [GATT]
> > > > > > Cache =3D no
> > > > >
> > > > > When you say the app can't handle changed service do you mean Blu=
eZ
> > > > > doesn't emit changes to the attributes (via Service Changed) or i=
s it
> > > > > really the application not being able to handle the changes?
> > > > >
> > > > > > But recently, we saw the problem again even if the bluetooth ca=
che is
> > > > > > disabled: in the build number 101, a characteristic is removed.=
 But when we upgrade the build from 100 to 101, the app gets the wrong data=
. We looked at the log. When the app tries to read temperature by using the=
 temperature UUID, somehow the bluetooth service we created received the re=
quest to read the "device name"(device name UUID). So the "device name" is =
returned to the app as the temperature. This looks like the same behavior a=
s the bluetooth cache is not disabled. I looked at the "/var/lib/bluetooth/=
[BT_MAC]/cache" folder. There is no "[Attributes]" section in the files in =
the folder. That means the disabled cache seems working.
> > > > >
> > > > > So BlueZ is acting as the server, right? The Cache only applies t=
o the
> > > > > client portion, there is no such thing as disabling the remote ca=
che.
> > > > > I don't see any incoming Read By Group Request from the remote so=
 it
> > > > > is very likely that it has cached the values, there is no Read By=
 Type
> > > > > for the DB Hash either which is quite surprising to me since that=
 is
> > > > > required for stacks supporting Robust Caching which I believe is =
the
> > > > > case of iOS.
> > > > >
> > > > > Anyway, I would check that the following lines are being triggere=
d:
> > > > >
> > > > > When starting:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-=
database.c#n3798
> > > > >
> > > > > On connect:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-=
database.c#n3741
> > > > >
> > > > > If those lines are not being triggered it is likely a client prob=
lem
> > > > > which for some reason had not subscribed to received service chan=
ges
> > > > > for some reason, if it doesn't subscribe to service changes then =
it
> > > > > shall not cache any attribute and attempt to rediscover on every
> > > > > connection.
> > > > >
> > > > > > The only way to fix this issue is to force exit the mobile app =
on the phone and "Forget This Device" in iOS or "Unpair" in Android.
> > > > > >
> > > > > > I looked at the btmon(see attached). For the working btmon log,=
 there is "Attribute group list: XX entries" under "ACL Data TX". But there=
 is no "Attribute group list: XX entries" under "ACL Data TX" in the attach=
ed problematic btmon log.
> > > > > >
> > > > > > Questions:
> > > > > > 1. How is it possible that this still happens even if the bluet=
ooth cache is disabled?
> > > > > > 2. Is this the problem on the Linux side which runs the GATT se=
rver or on the mobile side?
> > > > > > 3. Is there anything else we should look into?
> > > > > >
> > > > > > We're going to release our product soon. This is a critical iss=
ue for us. Please help if you have any suggestions.
> > > > > >
> > > > > > Thanks!
> > > > > > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED =
HEREIN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY,=
 AND MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE IN=
TENDED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIAT=
ELY NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE TH=
E PROPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WI=
THOUT THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
