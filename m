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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D391A61131
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 20:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhDOUcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOUcQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 16:32:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40EC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 13:31:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e66so10297354oif.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CEDFkr7puy5DxhYD6VtwXpQtJa0KFknShyCNjgdeWuM=;
        b=WAl5Ts4ORfonNk0k/PNles3uATwsMOC9tGmKw3VohmZbm24sGP+3AyVOZJT0ogBuvJ
         3TF9FJUcBZYJ0rKG/R01nRoTCTDnLIyGrlydd+vUTdMXOlbGocXaCH4O1VrDQG7NCk63
         9NYlD1oXg71XX8LYySAJOBunZP2TCd42q4dd6mHBqlpZGcni2Ji+gwZGzHdwzRzZToph
         HS4jAteUVdCV0EyTumz+pYran/OFQI7dcgtKFV48SXSYawcxh8H/TBu+tuMWBGpQyriJ
         lTtkBP2tkCXWVOln0fN8r7cArmrlckYTyCtVMJqVb8NfDfV4hWr2oR5sM1o0lU/jnBrq
         De1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CEDFkr7puy5DxhYD6VtwXpQtJa0KFknShyCNjgdeWuM=;
        b=gMGYRieRBPG0iJOKUDTMv/wldBb1EVDGmISt7roHV3JwK4c9TPI/xmnDWsVT0hkeUq
         MADXfbL0dT0+xFC0fWxjD6UvSMGkxt0KXmDsBHArRHLUwAegJ5G2SnbRXASZgnt0c6zs
         e69rsVm0mjqY3+EbkbWI6NAIQdZOSkAFmmswXRjxVUbtlQFQ+hxiRuDLerPE+BsA3e9n
         Plmb1AZvp1yN86xaJaYILov+8lbscrZXqmR/K0/CshPZjzKpHFfM5nOVFIDysq+kmjUz
         DvWENmklzX1UliFcy2cnQXqYlE1I+QCNe4o4DNx+tJ5+PLXylfEsNs+latFUGgQJyw2A
         FNiw==
X-Gm-Message-State: AOAM530QhqtebGi4n/4dlJ4L03H6BaMDD5EfmmSkoUcyq9Oo8CikytTV
        jiADXXZBZ7ZSSXV7AzxCg9s3yPs2Q5y6l+jpoAvVzUowIIGLcw==
X-Google-Smtp-Source: ABdhPJw1tyASLz8rd1rL2qd+Axu24yBQLt1soVrX45F8y6a7Z+A4w7AjzlQEKdL5xFNzqPOlkbNUgd8Fu7LuOKOg2SU=
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr3799985ois.58.1618518712793;
 Thu, 15 Apr 2021 13:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com>
 <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com> <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
In-Reply-To: <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Apr 2021 13:31:41 -0700
Message-ID: <CABBYNZLzu+subZu5L6FYmrLB=w7hK3_kJ51LDmd3aCufR-UVBQ@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 10:44 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Luiz,
>
> There is a UI example of nRF Connect which shows the "Service Changed
> Indication" is under "Generic
> Attribute"(http://forum.espruino.com/conversations/357737/). We're
> using BlueZ 5.48. I tried to add it by modifying example-gatt-server:


You should have mentioned that you are using 5.48, you need the following p=
atch:

commit a0b886e26c83ad4dfbf0b2b2e024c8ce9ead9a7d
Author: Szymon Janc <szymon.janc@codecoup.pl>
Date:   Wed Mar 28 12:10:55 2018 +0200

    gatt: Add support for storing Service Changed CCC value

    This adds support for storing CCC value of Service Changed
    characteristic. Once bluetoothd is restart stored values are read
    and any device subscribed to indications will receive Service Changed
    indication with 0x00010-0xffff value. This is to invalidate any
    non-core services since there is no way to verify if applications
    will register their services in same order (or at all).

    This fix accessing invalid handles by stacks that rely only on Service
    Changed indication for rediscovery ie. Apple iOS.

Or upgrade to a BlueZ release that has the above patch, which should be 5.5=
0:

+ver 5.50:
+       Fix issue with GATT and reading long values.
+       Fix issue with GATT and reading multiple includes.
+       Fix issue with GATT and service changes when offline.
+       Fix issue with handling secondary service discovery.
+       Fix issue with handling persistency of CCC values.

>
> class ServiceChangedChrc(Characteristic):
>     SCI_UUID =3D '00002a05-0000-1000-8000-00805f9b34fb'
>
>     def __init__(self, bus, index, service):
>         Characteristic.__init__(
>                 self, bus, index,
>                 self.SCI_UUID,
>                 ['indicate'],
>                 service)
>
>     def IndicateValue(self, options):
>         # This function doesn't exist. Just list it here.
>         pass
>
>
> class ServiceChangedService(Service):
>     MY_UUID =3D '00001801-0000-1000-8000-00805f9b34fb'
>
>     def __init__(self, bus, index):
>         Service.__init__(self, bus, index, self.MY_UUID, True)
>         self.add_characteristic(ServiceChangedChrc(bus, 0, self))
>
>
> class Application(dbus.service.Object):
>     """
>     org.bluez.GattApplication1 interface implementation
>     """
>     def __init__(self, bus):
>         self.path =3D '/'
>         self.services =3D []
>         dbus.service.Object.__init__(self, bus, self.path)
>         self.add_service(HeartRateService(bus, 0))
>         self.add_service(BatteryService(bus, 1))
>         self.add_service(TestService(bus, 2))
>         self.add_service(ServiceChangedService(bus, 3))
>
>
> When I run it, there is "Failed to register application:
> org.bluez.Error.Failed: Failed to create entry in database". That is
> in the function client_ready_cb() in gatt-database.c in BlueZ code. Do
> you know how to fix it?

You don't need to register Service Changed, the daemon already takes
care of registering it and there could only be one Service Changed in
the database.

> Thanks!
> Kenny
>
> On Tue, Apr 13, 2021 at 9:46 PM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hi Jamie, Luiz,
> >
> > Thanks for your info.
> >
> > Luiz, to answer your questions:
> > BlueZ doesn't seem to emit "Service Changed Indication". Or it does
> > emit it, but we don't know how to verify it.
> > Yes, BlueZ acts as a GATT server which runs on Linux.
> >
> > So my questions:
> > How can I tell if "Service Changed Indication" is working? I need to
> > show it to our app developers that the GATT server does send the
> > "Service Changed Indication" when there is a service change.
> > By disabling the GATT's cache in "/etc/bluetooth/main.conf", the
> > "Service Changed Indication" is disabled?
> > Can "Service Changed Indication" be enabled in a conf file? Or should
> > it be done in the Python code? Could you please help find out that
> > info?
> > Our GATT server is based on the Python code
> > examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test).
> > I don't know how to enable "Service Changed Indication" or "Robust
> > Caching" in Python code on the GATT server side. There is no document
> > or code samples about that. Please let me know if there is any
> > document or Python code example.
> >
> > Thanks!
> > Kenny
> >
> > On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Jamie, Brian,
> > >
> > > On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> > > <Jamie.Mccrae@lairdconnect.com> wrote:
> > > >
> > > > Hi Kenny,
> > > > Why not just add the service changed indication as you refer to bel=
ow? It was purposely designed for this specific purpose, you're trying to w=
ork around an issue created because you don't want to use the feature that =
prevents this issue. Any workaround is just that, a workaround, and might n=
ot work as intended.
> > >
> > > Yep, and while at it implement the so called Robust Caching feature s=
o
> > > we can detect if anything has changed by reading the DB Hash.
> > >
> > > > Thanks,
> > > > Jamie
> > > >
> > > > -----Original Message-----
> > > > From: Kenny Bian <kennybian@gmail.com>
> > > > Sent: 13 April 2021 06:59
> > > > To: linux-bluetooth@vger.kernel.org
> > > > Subject: Disabled bluetooth cache. But the app still getting wrong =
data?
> > > >
> > > > EXTERNAL EMAIL: Be careful with attachments and links.
> > > >
> > > > Previously we had an issue: if there is a change of characteristics=
 in the new build of our firmware, then the app will get the wrong data.
> > > > By saying changed characteristics, it can be an added or removed ch=
aracteristic, or adding notification to an existing characteristic.
> > > > In order to keep the pairing information, the "/var/lib/bluetooth"
> > > > folder is copied over to the new build's partition. We realized tha=
t there is no "service changed indication". The app can't handle the change=
d services. So we disabled the bluetooth cache by set this in
> > > > "/etc/bluetooth/main.conf":
> > > > [GATT]
> > > > Cache =3D no
> > >
> > > When you say the app can't handle changed service do you mean BlueZ
> > > doesn't emit changes to the attributes (via Service Changed) or is it
> > > really the application not being able to handle the changes?
> > >
> > > > But recently, we saw the problem again even if the bluetooth cache =
is
> > > > disabled: in the build number 101, a characteristic is removed. But=
 when we upgrade the build from 100 to 101, the app gets the wrong data. We=
 looked at the log. When the app tries to read temperature by using the tem=
perature UUID, somehow the bluetooth service we created received the reques=
t to read the "device name"(device name UUID). So the "device name" is retu=
rned to the app as the temperature. This looks like the same behavior as th=
e bluetooth cache is not disabled. I looked at the "/var/lib/bluetooth/[BT_=
MAC]/cache" folder. There is no "[Attributes]" section in the files in the =
folder. That means the disabled cache seems working.
> > >
> > > So BlueZ is acting as the server, right? The Cache only applies to th=
e
> > > client portion, there is no such thing as disabling the remote cache.
> > > I don't see any incoming Read By Group Request from the remote so it
> > > is very likely that it has cached the values, there is no Read By Typ=
e
> > > for the DB Hash either which is quite surprising to me since that is
> > > required for stacks supporting Robust Caching which I believe is the
> > > case of iOS.
> > >
> > > Anyway, I would check that the following lines are being triggered:
> > >
> > > When starting:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-data=
base.c#n3798
> > >
> > > On connect:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-data=
base.c#n3741
> > >
> > > If those lines are not being triggered it is likely a client problem
> > > which for some reason had not subscribed to received service changes
> > > for some reason, if it doesn't subscribe to service changes then it
> > > shall not cache any attribute and attempt to rediscover on every
> > > connection.
> > >
> > > > The only way to fix this issue is to force exit the mobile app on t=
he phone and "Forget This Device" in iOS or "Unpair" in Android.
> > > >
> > > > I looked at the btmon(see attached). For the working btmon log, the=
re is "Attribute group list: XX entries" under "ACL Data TX". But there is =
no "Attribute group list: XX entries" under "ACL Data TX" in the attached p=
roblematic btmon log.
> > > >
> > > > Questions:
> > > > 1. How is it possible that this still happens even if the bluetooth=
 cache is disabled?
> > > > 2. Is this the problem on the Linux side which runs the GATT server=
 or on the mobile side?
> > > > 3. Is there anything else we should look into?
> > > >
> > > > We're going to release our product soon. This is a critical issue f=
or us. Please help if you have any suggestions.
> > > >
> > > > Thanks!
> > > > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HERE=
IN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND=
 MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTEND=
ED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY =
NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PR=
OPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOU=
T THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
