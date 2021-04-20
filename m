Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BFC613F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 21:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhDTVgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhDTVgG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Apr 2021 17:36:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B39C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 14:35:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p8so18639367iol.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zu6mUxlpPFVTRb+hWyoL35fhnJALVF4ZJqNBau8Z0is=;
        b=sdl403zRghymXqyzne1oDb5gAN43dt73ngszwQfGYA002Wq+crOU9oimCCTGOmvKMl
         JBP6gXQ5fj10K/bApBoWYk/zYDXdGSlcJL5+uMCfcaQnV1g010jTCeZ9JQgzGfI/9Tnm
         2WFcXVWwvHNrP5nsNvmM6s8egQNXhhu2mPwffI4v+oeYplQBmF0QT7+Hgnqe5vRjvj44
         5JF8A6sWsH1Frf1oy+2Tiv5FNQ1jfsPAixqRr63iluA6OvzI43DKQ+BzCXUnWgl9j+eJ
         kTX+EN5x1wrcO7TA9vaxZmpMm115ZVh8YykbvTpi5ZRXDqr11+S9Hg5pof9gcCUOIK44
         uHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zu6mUxlpPFVTRb+hWyoL35fhnJALVF4ZJqNBau8Z0is=;
        b=o6CMUWtTYfia6UCM3EdGEpsOnviWMjwmBLFOTqGvV8vclrJ6y2cThi/R83Hg827Xy7
         IjyccaOQ3t4Gw3dnniOj5wxJiOF9f7Y7MgwedZYHyXNHj5FphrCAT1F/Jum9GjS4NC/k
         hQjdXfCZ+rObwC1SWhC/1wQfyCBnEzPFjmHJM7hEz9us90AeAA9EdNaNEzjpAmEwuaYn
         qhfqF2Uya/tPLwwKnr0Q7jJ7DjFoZePBdIJxspltidqTE+HJQyQePkt8LOudkDV5boG/
         LUHrNAJqMZIxKAbGz9hkw2/Vf1W7NuRR43nUN7AhVraePUEQvFDXa2dLs9y+axgtyt7x
         Lt8w==
X-Gm-Message-State: AOAM530BgGBiyNqOQ/hetuGaPdcm+OK6GgC4xfrJzk7U1QmydoOKHGNg
        gmFQfz/LsHEG1nXNeFyEAubadlg6tLISSBr0EA==
X-Google-Smtp-Source: ABdhPJxJoNaObXWA/kJc3M2zJBA+x2jVaGNA5jHJNddCFg9kVidwu2e+jB9Aw640L3/wkxsLOIIei7YoeKNCdgdbwbk=
X-Received: by 2002:a5e:8a0c:: with SMTP id d12mr11453578iok.152.1618954532885;
 Tue, 20 Apr 2021 14:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
 <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
 <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
 <CABBYNZLzu+subZu5L6FYmrLB=w7hK3_kJ51LDmd3aCufR-UVBQ@mail.gmail.com>
 <CAC9s0NZtc_8fXQdZn_1USxixSzbaj2d1OcOn=EoJGFHhX75LjQ@mail.gmail.com>
 <CABBYNZ+Tdxh+yecJgTLg3m=+QJHBVZqG=TSxF7bbJTAOYkjX8g@mail.gmail.com>
 <CAC9s0NaMX0gZWam498_=r0gwHNrtmxoV00+0P=wLYhyf+3KCuA@mail.gmail.com>
 <CAC9s0Nb26NAQ5DO6nB0epLCRHgNgwGOrLxGHe=FLzgrDtnUx8w@mail.gmail.com> <BYAPR14MB2887F71E99ECA046D4A63237E64C9@BYAPR14MB2887.namprd14.prod.outlook.com>
In-Reply-To: <BYAPR14MB2887F71E99ECA046D4A63237E64C9@BYAPR14MB2887.namprd14.prod.outlook.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Tue, 20 Apr 2021 14:35:21 -0700
Message-ID: <CAC9s0NaV_-JAwu9GhGC1AtfFdMcih0-nv0gCritWpM5kNLrkyg@mail.gmail.com>
Subject: Re: Disabled bluetooth cache. But the app still getting wrong data?
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you so much, Jamie. That well explained it.

On Thu, Apr 15, 2021 at 11:34 PM Jamie Mccrae
<Jamie.Mccrae@lairdconnect.com> wrote:
>
> Hi Kenny,
> The way it works is when a device connects (it might just be a normal con=
nection, it might be only if it pairs, it's vender specific) it will genera=
lly cache the GATT table of the remote device, this is so that future conne=
ctions are faster as it won't need to send multiple read commands to get it=
. The easy way for that device to know if the GATT table has changed is it =
uses a specific GATT attribute with a GATT table hash and reads that, if it=
's changed then it needs to clear the cache and re-read the table. That onl=
y works when a device connects and reads it, if the GATT table is updated d=
uring a connection, then an indication can be sent to that device telling i=
t the GATT table hash has changed and it can re-read it and clear it during=
 a connection.
> If you are connecting a phone to your embedded device with the GATT table=
 being on the embedded device then the cache is stored on the phone, there =
doesn't need to be a GATT table hash on the embedded device because the pho=
ne doesn't have a GATT table and iOS/android will create the cache themselv=
es, you cannot disable that from the embedded device side, whatever cache y=
ou enable/disable on the embedded system is for that system only, it does n=
ot propagate that configuration value to other devices.
> Thanks,
> Jamie
>
> -----Original Message-----
> From: Kenny Bian <kennybian@gmail.com>
> Sent: 16 April 2021 05:03
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>; linux-bluetooth@vger.ke=
rnel.org
> Subject: Re: Disabled bluetooth cache. But the app still getting wrong da=
ta?
>
> EXTERNAL EMAIL: Be careful with attachments and links.
>
> Hi Luiz,
>
> One more question. Once we upgrade our device to Ubuntu 20.04 LTS with Bl=
ueZ 5.53, we'll test "Service Changed Indication". Is GATT cache related to=
 "Service Changed Indication"? If they are related, then I guess we should =
turn on the GATT cache in /etc/bluetooth/main.conf?
> Right now, the GATT cache is turned off in our device.
>
> Thanks,
> Kenny
>
> On Thu, Apr 15, 2021 at 8:06 PM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > Thank you so much! You're absolutely right.
> >
> > I'll talk to our team to upgrade our Ubuntu to 20.04 LTS. Then I'll
> > test the BlueZ 5.53 which is the latest version on Ubuntu 20.04 LTS.
> >
> > Thanks again!
> > Kenny
> >
> > On Thu, Apr 15, 2021 at 5:49 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Kenny,
> > >
> > > On Thu, Apr 15, 2021 at 5:21 PM Kenny Bian <kennybian@gmail.com> wrot=
e:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Thank you so much. I appreciate it.
> > > >
> > > > That was my bad. I just checked. Our system is Ubuntu 18.04. The
> > > > BlueZ version is "5.48-0ubuntu3.4" which is different from the
> > > > versions in http://www.bluez.org/. I'm trying to figure out if
> > > > this version includes the version 5.50. Do you know the
> > > > corresponding BlueZ version for "5.48-0ubuntu3.4"?
> > >
> > > 5.48, which was the version available in 2018, more than 3 years/10
> > > releases ago, a lot of things have been fixed over this time so Id
> > > really recommend to upgrade to the latest if you want to have some
> > > support.
> > >
> > > > Thanks!
> > > > Kenny
> > > >
> > > > On Thu, Apr 15, 2021 at 1:31 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Kenny,
> > > > >
> > > > > On Wed, Apr 14, 2021 at 10:44 PM Kenny Bian <kennybian@gmail.com>=
 wrote:
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > There is a UI example of nRF Connect which shows the "Service
> > > > > > Changed Indication" is under "Generic
> > > > > > Attribute"(http://forum.espruino.com/conversations/357737/).
> > > > > > We're using BlueZ 5.48. I tried to add it by modifying example-=
gatt-server:
> > > > >
> > > > >
> > > > > You should have mentioned that you are using 5.48, you need the f=
ollowing patch:
> > > > >
> > > > > commit a0b886e26c83ad4dfbf0b2b2e024c8ce9ead9a7d
> > > > > Author: Szymon Janc <szymon.janc@codecoup.pl>
> > > > > Date:   Wed Mar 28 12:10:55 2018 +0200
> > > > >
> > > > >     gatt: Add support for storing Service Changed CCC value
> > > > >
> > > > >     This adds support for storing CCC value of Service Changed
> > > > >     characteristic. Once bluetoothd is restart stored values are =
read
> > > > >     and any device subscribed to indications will receive Service=
 Changed
> > > > >     indication with 0x00010-0xffff value. This is to invalidate a=
ny
> > > > >     non-core services since there is no way to verify if applicat=
ions
> > > > >     will register their services in same order (or at all).
> > > > >
> > > > >     This fix accessing invalid handles by stacks that rely only o=
n Service
> > > > >     Changed indication for rediscovery ie. Apple iOS.
> > > > >
> > > > > Or upgrade to a BlueZ release that has the above patch, which sho=
uld be 5.50:
> > > > >
> > > > > +ver 5.50:
> > > > > +       Fix issue with GATT and reading long values.
> > > > > +       Fix issue with GATT and reading multiple includes.
> > > > > +       Fix issue with GATT and service changes when offline.
> > > > > +       Fix issue with handling secondary service discovery.
> > > > > +       Fix issue with handling persistency of CCC values.
> > > > >
> > > > > >
> > > > > > class ServiceChangedChrc(Characteristic):
> > > > > >     SCI_UUID =3D '00002a05-0000-1000-8000-00805f9b34fb'
> > > > > >
> > > > > >     def __init__(self, bus, index, service):
> > > > > >         Characteristic.__init__(
> > > > > >                 self, bus, index,
> > > > > >                 self.SCI_UUID,
> > > > > >                 ['indicate'],
> > > > > >                 service)
> > > > > >
> > > > > >     def IndicateValue(self, options):
> > > > > >         # This function doesn't exist. Just list it here.
> > > > > >         pass
> > > > > >
> > > > > >
> > > > > > class ServiceChangedService(Service):
> > > > > >     MY_UUID =3D '00001801-0000-1000-8000-00805f9b34fb'
> > > > > >
> > > > > >     def __init__(self, bus, index):
> > > > > >         Service.__init__(self, bus, index, self.MY_UUID, True)
> > > > > >         self.add_characteristic(ServiceChangedChrc(bus, 0,
> > > > > > self))
> > > > > >
> > > > > >
> > > > > > class Application(dbus.service.Object):
> > > > > >     """
> > > > > >     org.bluez.GattApplication1 interface implementation
> > > > > >     """
> > > > > >     def __init__(self, bus):
> > > > > >         self.path =3D '/'
> > > > > >         self.services =3D []
> > > > > >         dbus.service.Object.__init__(self, bus, self.path)
> > > > > >         self.add_service(HeartRateService(bus, 0))
> > > > > >         self.add_service(BatteryService(bus, 1))
> > > > > >         self.add_service(TestService(bus, 2))
> > > > > >         self.add_service(ServiceChangedService(bus, 3))
> > > > > >
> > > > > >
> > > > > > When I run it, there is "Failed to register application:
> > > > > > org.bluez.Error.Failed: Failed to create entry in database".
> > > > > > That is in the function client_ready_cb() in gatt-database.c
> > > > > > in BlueZ code. Do you know how to fix it?
> > > > >
> > > > > You don't need to register Service Changed, the daemon already
> > > > > takes care of registering it and there could only be one Service
> > > > > Changed in the database.
> > > > >
> > > > > > Thanks!
> > > > > > Kenny
> > > > > >
> > > > > > On Tue, Apr 13, 2021 at 9:46 PM Kenny Bian <kennybian@gmail.com=
> wrote:
> > > > > > >
> > > > > > > Hi Jamie, Luiz,
> > > > > > >
> > > > > > > Thanks for your info.
> > > > > > >
> > > > > > > Luiz, to answer your questions:
> > > > > > > BlueZ doesn't seem to emit "Service Changed Indication". Or
> > > > > > > it does emit it, but we don't know how to verify it.
> > > > > > > Yes, BlueZ acts as a GATT server which runs on Linux.
> > > > > > >
> > > > > > > So my questions:
> > > > > > > How can I tell if "Service Changed Indication" is working? I
> > > > > > > need to show it to our app developers that the GATT server
> > > > > > > does send the "Service Changed Indication" when there is a se=
rvice change.
> > > > > > > By disabling the GATT's cache in "/etc/bluetooth/main.conf",
> > > > > > > the "Service Changed Indication" is disabled?
> > > > > > > Can "Service Changed Indication" be enabled in a conf file?
> > > > > > > Or should it be done in the Python code? Could you please
> > > > > > > help find out that info?
> > > > > > > Our GATT server is based on the Python code
> > > > > > > examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/t=
ree/test).
> > > > > > > I don't know how to enable "Service Changed Indication" or
> > > > > > > "Robust Caching" in Python code on the GATT server side.
> > > > > > > There is no document or code samples about that. Please let
> > > > > > > me know if there is any document or Python code example.
> > > > > > >
> > > > > > > Thanks!
> > > > > > > Kenny
> > > > > > >
> > > > > > > On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Jamie, Brian,
> > > > > > > >
> > > > > > > > On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> > > > > > > > <Jamie.Mccrae@lairdconnect.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Kenny,
> > > > > > > > > Why not just add the service changed indication as you re=
fer to below? It was purposely designed for this specific purpose, you're t=
rying to work around an issue created because you don't want to use the fea=
ture that prevents this issue. Any workaround is just that, a workaround, a=
nd might not work as intended.
> > > > > > > >
> > > > > > > > Yep, and while at it implement the so called Robust
> > > > > > > > Caching feature so we can detect if anything has changed by=
 reading the DB Hash.
> > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Jamie
> > > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Kenny Bian <kennybian@gmail.com>
> > > > > > > > > Sent: 13 April 2021 06:59
> > > > > > > > > To: linux-bluetooth@vger.kernel.org
> > > > > > > > > Subject: Disabled bluetooth cache. But the app still gett=
ing wrong data?
> > > > > > > > >
> > > > > > > > > EXTERNAL EMAIL: Be careful with attachments and links.
> > > > > > > > >
> > > > > > > > > Previously we had an issue: if there is a change of chara=
cteristics in the new build of our firmware, then the app will get the wron=
g data.
> > > > > > > > > By saying changed characteristics, it can be an added or =
removed characteristic, or adding notification to an existing characteristi=
c.
> > > > > > > > > In order to keep the pairing information, the "/var/lib/b=
luetooth"
> > > > > > > > > folder is copied over to the new build's partition. We
> > > > > > > > > realized that there is no "service changed indication".
> > > > > > > > > The app can't handle the changed services. So we
> > > > > > > > > disabled the bluetooth cache by set this in
> > > > > > > > > "/etc/bluetooth/main.conf":
> > > > > > > > > [GATT]
> > > > > > > > > Cache =3D no
> > > > > > > >
> > > > > > > > When you say the app can't handle changed service do you
> > > > > > > > mean BlueZ doesn't emit changes to the attributes (via
> > > > > > > > Service Changed) or is it really the application not being =
able to handle the changes?
> > > > > > > >
> > > > > > > > > But recently, we saw the problem again even if the
> > > > > > > > > bluetooth cache is
> > > > > > > > > disabled: in the build number 101, a characteristic is re=
moved. But when we upgrade the build from 100 to 101, the app gets the wron=
g data. We looked at the log. When the app tries to read temperature by usi=
ng the temperature UUID, somehow the bluetooth service we created received =
the request to read the "device name"(device name UUID). So the "device nam=
e" is returned to the app as the temperature. This looks like the same beha=
vior as the bluetooth cache is not disabled. I looked at the "/var/lib/blue=
tooth/[BT_MAC]/cache" folder. There is no "[Attributes]" section in the fil=
es in the folder. That means the disabled cache seems working.
> > > > > > > >
> > > > > > > > So BlueZ is acting as the server, right? The Cache only
> > > > > > > > applies to the client portion, there is no such thing as di=
sabling the remote cache.
> > > > > > > > I don't see any incoming Read By Group Request from the
> > > > > > > > remote so it is very likely that it has cached the values,
> > > > > > > > there is no Read By Type for the DB Hash either which is
> > > > > > > > quite surprising to me since that is required for stacks
> > > > > > > > supporting Robust Caching which I believe is the case of iO=
S.
> > > > > > > >
> > > > > > > > Anyway, I would check that the following lines are being tr=
iggered:
> > > > > > > >
> > > > > > > > When starting:
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/sr
> > > > > > > > c/gatt-database.c#n3798
> > > > > > > >
> > > > > > > > On connect:
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/sr
> > > > > > > > c/gatt-database.c#n3741
> > > > > > > >
> > > > > > > > If those lines are not being triggered it is likely a
> > > > > > > > client problem which for some reason had not subscribed to
> > > > > > > > received service changes for some reason, if it doesn't
> > > > > > > > subscribe to service changes then it shall not cache any
> > > > > > > > attribute and attempt to rediscover on every connection.
> > > > > > > >
> > > > > > > > > The only way to fix this issue is to force exit the mobil=
e app on the phone and "Forget This Device" in iOS or "Unpair" in Android.
> > > > > > > > >
> > > > > > > > > I looked at the btmon(see attached). For the working btmo=
n log, there is "Attribute group list: XX entries" under "ACL Data TX". But=
 there is no "Attribute group list: XX entries" under "ACL Data TX" in the =
attached problematic btmon log.
> > > > > > > > >
> > > > > > > > > Questions:
> > > > > > > > > 1. How is it possible that this still happens even if the=
 bluetooth cache is disabled?
> > > > > > > > > 2. Is this the problem on the Linux side which runs the G=
ATT server or on the mobile side?
> > > > > > > > > 3. Is there anything else we should look into?
> > > > > > > > >
> > > > > > > > > We're going to release our product soon. This is a critic=
al issue for us. Please help if you have any suggestions.
> > > > > > > > >
> > > > > > > > > Thanks!
> > > > > > > > > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONT=
AINED HEREIN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER =
PARTY, AND MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT =
THE INTENDED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IM=
MEDIATELY NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS =
ARE THE PROPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR U=
SED WITHOUT THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
