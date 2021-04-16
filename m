Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD3FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 03:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8516117A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 03:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhDPDHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 23:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbhDPDH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 23:07:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC92C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 20:07:05 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f15so17584706iob.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 20:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2zSYmR1wUtYveCymEgPgKG5pJJc55XqAIDc8cpWGdFE=;
        b=B3lM0Mg2lDM6soulSeVhj8K3YIQ3cp7ERFKMgkZUb00ctzKo9XqcVe43wwl3HNJl4Z
         sJkgY2u+AhfRc6jNm3HGHg/OPtLW/zAMmmKrJUgTta+YpmHzysBWBUwEfOIktSWwQTwB
         A7eqFX7RLjU/oproyCQm4Jom/qNn/kk+bxNGN+0EEmJkGl7Lw9/En44irtQj+yad+CXv
         JbnfJeKnhHbDTgpj7PjYkG8nkoQaGrqhXZgrFaGzTtw49w23XKMM+Esia9iGRLobZyHY
         gjVCz2Sx3tpc25Z1V3zBxCV24DG8YLG7eW15ds1z9uSV5O072Bm7oeY6afRNBNjDUGFd
         H71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2zSYmR1wUtYveCymEgPgKG5pJJc55XqAIDc8cpWGdFE=;
        b=g8I2ctb+X2heVHaDsaY7KDXUyG6cJa3mkslE+pQydJgmOEKdrZ/6NUY1UNZ8ZK3bCt
         YxtFoDzTtOPIZqYZFFH+tsXg0ucf+vLoHJSh56wc52hLwTSMnhO58L0HsSrho3VqLg4P
         gVkhLf6AVXwcAnEBvTuqTNqiADIXxWKamT6A+djIsGjxTTZZhxabeAmkL+WQk6au4KIl
         FJQIuEbirWTP3ArdF+cKtU9mP1FuZlc+VZ2yqGkoM+rZk5UKHZ9l+V5UWqqNhKjtv4Fw
         fK7cEAAyqn3iYXAIeuoY79XTmmxTk4WiZ98Pzk3+BeT8SuhlSlNY5Gi8eYBblNId2aPm
         WZ9w==
X-Gm-Message-State: AOAM530zUA/cZvCaGKDh/L0jRH9SJGQigTXgeaEU5alGBJDO6GJobl1v
        +tbUl23cOVZS3SnKHhCCf3Xvgv/8UDYzH4ecWA==
X-Google-Smtp-Source: ABdhPJymG/2fQVT9Of2Tpg5N/zqPoRYGdBA1pPbV9Oa9KK4fzV8SN+R7V7ilfe89IK17mhwd8iSTNSSCUgCuU9m9+Bg=
X-Received: by 2002:a5e:8304:: with SMTP id x4mr1811011iom.53.1618542424691;
 Thu, 15 Apr 2021 20:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
 <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
 <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
 <CABBYNZLzu+subZu5L6FYmrLB=w7hK3_kJ51LDmd3aCufR-UVBQ@mail.gmail.com>
 <CAC9s0NZtc_8fXQdZn_1USxixSzbaj2d1OcOn=EoJGFHhX75LjQ@mail.gmail.com> <CABBYNZ+Tdxh+yecJgTLg3m=+QJHBVZqG=TSxF7bbJTAOYkjX8g@mail.gmail.com>
In-Reply-To: <CABBYNZ+Tdxh+yecJgTLg3m=+QJHBVZqG=TSxF7bbJTAOYkjX8g@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Thu, 15 Apr 2021 20:06:28 -0700
Message-ID: <CAC9s0NaMX0gZWam498_=r0gwHNrtmxoV00+0P=wLYhyf+3KCuA@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you so much! You're absolutely right.

I'll talk to our team to upgrade our Ubuntu to 20.04 LTS. Then I'll
test the BlueZ 5.53 which is the latest version on Ubuntu 20.04 LTS.

Thanks again!
Kenny

On Thu, Apr 15, 2021 at 5:49 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kenny,
>
> On Thu, Apr 15, 2021 at 5:21 PM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > Thank you so much. I appreciate it.
> >
> > That was my bad. I just checked. Our system is Ubuntu 18.04. The BlueZ
> > version is "5.48-0ubuntu3.4" which is different from the versions in
> > http://www.bluez.org/. I'm trying to figure out if this version
> > includes the version 5.50. Do you know the corresponding BlueZ version
> > for "5.48-0ubuntu3.4"?
>
> 5.48, which was the version available in 2018, more than 3 years/10
> releases ago, a lot of things have been fixed over this time so Id
> really recommend to upgrade to the latest if you want to have some
> support.
>
> > Thanks!
> > Kenny
> >
> > On Thu, Apr 15, 2021 at 1:31 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Kenny,
> > >
> > > On Wed, Apr 14, 2021 at 10:44 PM Kenny Bian <kennybian@gmail.com> wro=
te:
> > > >
> > > > Hi Luiz,
> > > >
> > > > There is a UI example of nRF Connect which shows the "Service Chang=
ed
> > > > Indication" is under "Generic
> > > > Attribute"(http://forum.espruino.com/conversations/357737/). We're
> > > > using BlueZ 5.48. I tried to add it by modifying example-gatt-serve=
r:
> > >
> > >
> > > You should have mentioned that you are using 5.48, you need the follo=
wing patch:
> > >
> > > commit a0b886e26c83ad4dfbf0b2b2e024c8ce9ead9a7d
> > > Author: Szymon Janc <szymon.janc@codecoup.pl>
> > > Date:   Wed Mar 28 12:10:55 2018 +0200
> > >
> > >     gatt: Add support for storing Service Changed CCC value
> > >
> > >     This adds support for storing CCC value of Service Changed
> > >     characteristic. Once bluetoothd is restart stored values are read
> > >     and any device subscribed to indications will receive Service Cha=
nged
> > >     indication with 0x00010-0xffff value. This is to invalidate any
> > >     non-core services since there is no way to verify if applications
> > >     will register their services in same order (or at all).
> > >
> > >     This fix accessing invalid handles by stacks that rely only on Se=
rvice
> > >     Changed indication for rediscovery ie. Apple iOS.
> > >
> > > Or upgrade to a BlueZ release that has the above patch, which should =
be 5.50:
> > >
> > > +ver 5.50:
> > > +       Fix issue with GATT and reading long values.
> > > +       Fix issue with GATT and reading multiple includes.
> > > +       Fix issue with GATT and service changes when offline.
> > > +       Fix issue with handling secondary service discovery.
> > > +       Fix issue with handling persistency of CCC values.
> > >
> > > >
> > > > class ServiceChangedChrc(Characteristic):
> > > >     SCI_UUID =3D '00002a05-0000-1000-8000-00805f9b34fb'
> > > >
> > > >     def __init__(self, bus, index, service):
> > > >         Characteristic.__init__(
> > > >                 self, bus, index,
> > > >                 self.SCI_UUID,
> > > >                 ['indicate'],
> > > >                 service)
> > > >
> > > >     def IndicateValue(self, options):
> > > >         # This function doesn't exist. Just list it here.
> > > >         pass
> > > >
> > > >
> > > > class ServiceChangedService(Service):
> > > >     MY_UUID =3D '00001801-0000-1000-8000-00805f9b34fb'
> > > >
> > > >     def __init__(self, bus, index):
> > > >         Service.__init__(self, bus, index, self.MY_UUID, True)
> > > >         self.add_characteristic(ServiceChangedChrc(bus, 0, self))
> > > >
> > > >
> > > > class Application(dbus.service.Object):
> > > >     """
> > > >     org.bluez.GattApplication1 interface implementation
> > > >     """
> > > >     def __init__(self, bus):
> > > >         self.path =3D '/'
> > > >         self.services =3D []
> > > >         dbus.service.Object.__init__(self, bus, self.path)
> > > >         self.add_service(HeartRateService(bus, 0))
> > > >         self.add_service(BatteryService(bus, 1))
> > > >         self.add_service(TestService(bus, 2))
> > > >         self.add_service(ServiceChangedService(bus, 3))
> > > >
> > > >
> > > > When I run it, there is "Failed to register application:
> > > > org.bluez.Error.Failed: Failed to create entry in database". That i=
s
> > > > in the function client_ready_cb() in gatt-database.c in BlueZ code.=
 Do
> > > > you know how to fix it?
> > >
> > > You don't need to register Service Changed, the daemon already takes
> > > care of registering it and there could only be one Service Changed in
> > > the database.
> > >
> > > > Thanks!
> > > > Kenny
> > > >
> > > > On Tue, Apr 13, 2021 at 9:46 PM Kenny Bian <kennybian@gmail.com> wr=
ote:
> > > > >
> > > > > Hi Jamie, Luiz,
> > > > >
> > > > > Thanks for your info.
> > > > >
> > > > > Luiz, to answer your questions:
> > > > > BlueZ doesn't seem to emit "Service Changed Indication". Or it do=
es
> > > > > emit it, but we don't know how to verify it.
> > > > > Yes, BlueZ acts as a GATT server which runs on Linux.
> > > > >
> > > > > So my questions:
> > > > > How can I tell if "Service Changed Indication" is working? I need=
 to
> > > > > show it to our app developers that the GATT server does send the
> > > > > "Service Changed Indication" when there is a service change.
> > > > > By disabling the GATT's cache in "/etc/bluetooth/main.conf", the
> > > > > "Service Changed Indication" is disabled?
> > > > > Can "Service Changed Indication" be enabled in a conf file? Or sh=
ould
> > > > > it be done in the Python code? Could you please help find out tha=
t
> > > > > info?
> > > > > Our GATT server is based on the Python code
> > > > > examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/=
test).
> > > > > I don't know how to enable "Service Changed Indication" or "Robus=
t
> > > > > Caching" in Python code on the GATT server side. There is no docu=
ment
> > > > > or code samples about that. Please let me know if there is any
> > > > > document or Python code example.
> > > > >
> > > > > Thanks!
> > > > > Kenny
> > > > >
> > > > > On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Jamie, Brian,
> > > > > >
> > > > > > On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> > > > > > <Jamie.Mccrae@lairdconnect.com> wrote:
> > > > > > >
> > > > > > > Hi Kenny,
> > > > > > > Why not just add the service changed indication as you refer =
to below? It was purposely designed for this specific purpose, you're tryin=
g to work around an issue created because you don't want to use the feature=
 that prevents this issue. Any workaround is just that, a workaround, and m=
ight not work as intended.
> > > > > >
> > > > > > Yep, and while at it implement the so called Robust Caching fea=
ture so
> > > > > > we can detect if anything has changed by reading the DB Hash.
> > > > > >
> > > > > > > Thanks,
> > > > > > > Jamie
> > > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Kenny Bian <kennybian@gmail.com>
> > > > > > > Sent: 13 April 2021 06:59
> > > > > > > To: linux-bluetooth@vger.kernel.org
> > > > > > > Subject: Disabled bluetooth cache. But the app still getting =
wrong data?
> > > > > > >
> > > > > > > EXTERNAL EMAIL: Be careful with attachments and links.
> > > > > > >
> > > > > > > Previously we had an issue: if there is a change of character=
istics in the new build of our firmware, then the app will get the wrong da=
ta.
> > > > > > > By saying changed characteristics, it can be an added or remo=
ved characteristic, or adding notification to an existing characteristic.
> > > > > > > In order to keep the pairing information, the "/var/lib/bluet=
ooth"
> > > > > > > folder is copied over to the new build's partition. We realiz=
ed that there is no "service changed indication". The app can't handle the =
changed services. So we disabled the bluetooth cache by set this in
> > > > > > > "/etc/bluetooth/main.conf":
> > > > > > > [GATT]
> > > > > > > Cache =3D no
> > > > > >
> > > > > > When you say the app can't handle changed service do you mean B=
lueZ
> > > > > > doesn't emit changes to the attributes (via Service Changed) or=
 is it
> > > > > > really the application not being able to handle the changes?
> > > > > >
> > > > > > > But recently, we saw the problem again even if the bluetooth =
cache is
> > > > > > > disabled: in the build number 101, a characteristic is remove=
d. But when we upgrade the build from 100 to 101, the app gets the wrong da=
ta. We looked at the log. When the app tries to read temperature by using t=
he temperature UUID, somehow the bluetooth service we created received the =
request to read the "device name"(device name UUID). So the "device name" i=
s returned to the app as the temperature. This looks like the same behavior=
 as the bluetooth cache is not disabled. I looked at the "/var/lib/bluetoot=
h/[BT_MAC]/cache" folder. There is no "[Attributes]" section in the files i=
n the folder. That means the disabled cache seems working.
> > > > > >
> > > > > > So BlueZ is acting as the server, right? The Cache only applies=
 to the
> > > > > > client portion, there is no such thing as disabling the remote =
cache.
> > > > > > I don't see any incoming Read By Group Request from the remote =
so it
> > > > > > is very likely that it has cached the values, there is no Read =
By Type
> > > > > > for the DB Hash either which is quite surprising to me since th=
at is
> > > > > > required for stacks supporting Robust Caching which I believe i=
s the
> > > > > > case of iOS.
> > > > > >
> > > > > > Anyway, I would check that the following lines are being trigge=
red:
> > > > > >
> > > > > > When starting:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gat=
t-database.c#n3798
> > > > > >
> > > > > > On connect:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gat=
t-database.c#n3741
> > > > > >
> > > > > > If those lines are not being triggered it is likely a client pr=
oblem
> > > > > > which for some reason had not subscribed to received service ch=
anges
> > > > > > for some reason, if it doesn't subscribe to service changes the=
n it
> > > > > > shall not cache any attribute and attempt to rediscover on ever=
y
> > > > > > connection.
> > > > > >
> > > > > > > The only way to fix this issue is to force exit the mobile ap=
p on the phone and "Forget This Device" in iOS or "Unpair" in Android.
> > > > > > >
> > > > > > > I looked at the btmon(see attached). For the working btmon lo=
g, there is "Attribute group list: XX entries" under "ACL Data TX". But the=
re is no "Attribute group list: XX entries" under "ACL Data TX" in the atta=
ched problematic btmon log.
> > > > > > >
> > > > > > > Questions:
> > > > > > > 1. How is it possible that this still happens even if the blu=
etooth cache is disabled?
> > > > > > > 2. Is this the problem on the Linux side which runs the GATT =
server or on the mobile side?
> > > > > > > 3. Is there anything else we should look into?
> > > > > > >
> > > > > > > We're going to release our product soon. This is a critical i=
ssue for us. Please help if you have any suggestions.
> > > > > > >
> > > > > > > Thanks!
> > > > > > > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINE=
D HEREIN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PART=
Y, AND MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE =
INTENDED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDI=
ATELY NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE =
THE PROPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED =
WITHOUT THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
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
