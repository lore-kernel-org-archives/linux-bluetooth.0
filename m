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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C28DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 05:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61661613F0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDOFow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 01:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhDOFow (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 01:44:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EBBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 22:44:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id x16so23081335iob.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 22:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CQ5ZFT2t/Pfw2FTOQ7s5C8V15bRC9VNBT5iwzsvchSM=;
        b=dN/Y0Nc0JbmpEdSsb10QQT41OYHSSgWmUAf1vovReD1R0u4M1sXlODNM8kq7GsknVl
         ILIVkY9kEPgfRhFt4VamSvDMe32lW4Kkp3yZLV/wM8T+mAvR9Thq9xAzkXH4qulNi/jP
         XUQoztCfcuAdqwOEpM1UhYcd6noynV1y+vekrVo172ASPZow8o70bwdt469FpUyAWuY7
         Nz5R7gUAiPllZNSgwWiznXAAcRfzrHWhTSCGASYcDKxX0tlDi4NO8I8Pl32FKv4XcQxB
         AEj0Ric9saHd4RP03l5+gnb6RWUvoudX/yssRaVMht3t+2IXdaRlcHTtMNaNJn/gpnbW
         93VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CQ5ZFT2t/Pfw2FTOQ7s5C8V15bRC9VNBT5iwzsvchSM=;
        b=nWTA0IeCcIZDODVhYGt681t9F6+vUlsdVtJ2nO6addhjqPq1DrCUtUIwSBdpYSAuub
         E7nxb1BngaFvo4M1p/v7A0ZFbvBAYFoLC6A2gTHrpwEphX+ynZUnVmn5MAliYXS0yWRc
         vsFkjj+LSqlmebYjdXflnJ0k1rcsWB7c0HvKv7eaPy6P/zGtffkFtCKqWIzYYOZflsiD
         rgof7sdVS1cf6ZdF0gwAaEyw+euFL5lGb/ZU0HzJPFcdHkYFZkcce7/XTO3GHCyotKr8
         s0Eqs5HpfNlnK89zd3e8YA0BwHTQEK3pwdki36ecAm0rEjrLrjfHmwXpYikGulsFtBqh
         1ICg==
X-Gm-Message-State: AOAM531wlPsduiAGshpFx+ubT6Yf+13V37R0a7lI3lnkff4ZZlCkGzkv
        jOgCzH99bZOC2oChF23vzPlfa+4lf90+9Cp5rbF7/doogOT2
X-Google-Smtp-Source: ABdhPJyrwUOt1yvk4j/yl950FaemckFRuPKw6LvIngGT7JpHGY/KECze3fzLKEf8kFoqKsett+Ee6LZ2WVHqn8nPSa0=
X-Received: by 2002:a6b:4e01:: with SMTP id c1mr1281457iob.107.1618465469601;
 Wed, 14 Apr 2021 22:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
 <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
 <CABBYNZLDgfRarPODF+c2PWvgi1zeUiy5QfmXY5UVkwVkoLJ3zg@mail.gmail.com> <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
In-Reply-To: <CAC9s0Na0h5VRC8dc6sPmuQWOd0v2mvOfAnqq_sO0+BfLcjJAtw@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Wed, 14 Apr 2021 22:44:12 -0700
Message-ID: <CAC9s0NYh+PLLDArNMQxKyjD-DZgS9u_4K1ynt_DxF91Vru+_2A@mail.gmail.com>
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

There is a UI example of nRF Connect which shows the "Service Changed
Indication" is under "Generic
Attribute"(http://forum.espruino.com/conversations/357737/). We're
using BlueZ 5.48. I tried to add it by modifying example-gatt-server:


class ServiceChangedChrc(Characteristic):
    SCI_UUID =3D '00002a05-0000-1000-8000-00805f9b34fb'

    def __init__(self, bus, index, service):
        Characteristic.__init__(
                self, bus, index,
                self.SCI_UUID,
                ['indicate'],
                service)

    def IndicateValue(self, options):
        # This function doesn't exist. Just list it here.
        pass


class ServiceChangedService(Service):
    MY_UUID =3D '00001801-0000-1000-8000-00805f9b34fb'

    def __init__(self, bus, index):
        Service.__init__(self, bus, index, self.MY_UUID, True)
        self.add_characteristic(ServiceChangedChrc(bus, 0, self))


class Application(dbus.service.Object):
    """
    org.bluez.GattApplication1 interface implementation
    """
    def __init__(self, bus):
        self.path =3D '/'
        self.services =3D []
        dbus.service.Object.__init__(self, bus, self.path)
        self.add_service(HeartRateService(bus, 0))
        self.add_service(BatteryService(bus, 1))
        self.add_service(TestService(bus, 2))
        self.add_service(ServiceChangedService(bus, 3))


When I run it, there is "Failed to register application:
org.bluez.Error.Failed: Failed to create entry in database". That is
in the function client_ready_cb() in gatt-database.c in BlueZ code. Do
you know how to fix it?

Thanks!
Kenny

On Tue, Apr 13, 2021 at 9:46 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hi Jamie, Luiz,
>
> Thanks for your info.
>
> Luiz, to answer your questions:
> BlueZ doesn't seem to emit "Service Changed Indication". Or it does
> emit it, but we don't know how to verify it.
> Yes, BlueZ acts as a GATT server which runs on Linux.
>
> So my questions:
> How can I tell if "Service Changed Indication" is working? I need to
> show it to our app developers that the GATT server does send the
> "Service Changed Indication" when there is a service change.
> By disabling the GATT's cache in "/etc/bluetooth/main.conf", the
> "Service Changed Indication" is disabled?
> Can "Service Changed Indication" be enabled in a conf file? Or should
> it be done in the Python code? Could you please help find out that
> info?
> Our GATT server is based on the Python code
> examples(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test).
> I don't know how to enable "Service Changed Indication" or "Robust
> Caching" in Python code on the GATT server side. There is no document
> or code samples about that. Please let me know if there is any
> document or Python code example.
>
> Thanks!
> Kenny
>
> On Tue, Apr 13, 2021 at 2:57 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Jamie, Brian,
> >
> > On Tue, Apr 13, 2021 at 2:03 AM Jamie Mccrae
> > <Jamie.Mccrae@lairdconnect.com> wrote:
> > >
> > > Hi Kenny,
> > > Why not just add the service changed indication as you refer to below=
? It was purposely designed for this specific purpose, you're trying to wor=
k around an issue created because you don't want to use the feature that pr=
events this issue. Any workaround is just that, a workaround, and might not=
 work as intended.
> >
> > Yep, and while at it implement the so called Robust Caching feature so
> > we can detect if anything has changed by reading the DB Hash.
> >
> > > Thanks,
> > > Jamie
> > >
> > > -----Original Message-----
> > > From: Kenny Bian <kennybian@gmail.com>
> > > Sent: 13 April 2021 06:59
> > > To: linux-bluetooth@vger.kernel.org
> > > Subject: Disabled bluetooth cache. But the app still getting wrong da=
ta?
> > >
> > > EXTERNAL EMAIL: Be careful with attachments and links.
> > >
> > > Previously we had an issue: if there is a change of characteristics i=
n the new build of our firmware, then the app will get the wrong data.
> > > By saying changed characteristics, it can be an added or removed char=
acteristic, or adding notification to an existing characteristic.
> > > In order to keep the pairing information, the "/var/lib/bluetooth"
> > > folder is copied over to the new build's partition. We realized that =
there is no "service changed indication". The app can't handle the changed =
services. So we disabled the bluetooth cache by set this in
> > > "/etc/bluetooth/main.conf":
> > > [GATT]
> > > Cache =3D no
> >
> > When you say the app can't handle changed service do you mean BlueZ
> > doesn't emit changes to the attributes (via Service Changed) or is it
> > really the application not being able to handle the changes?
> >
> > > But recently, we saw the problem again even if the bluetooth cache is
> > > disabled: in the build number 101, a characteristic is removed. But w=
hen we upgrade the build from 100 to 101, the app gets the wrong data. We l=
ooked at the log. When the app tries to read temperature by using the tempe=
rature UUID, somehow the bluetooth service we created received the request =
to read the "device name"(device name UUID). So the "device name" is return=
ed to the app as the temperature. This looks like the same behavior as the =
bluetooth cache is not disabled. I looked at the "/var/lib/bluetooth/[BT_MA=
C]/cache" folder. There is no "[Attributes]" section in the files in the fo=
lder. That means the disabled cache seems working.
> >
> > So BlueZ is acting as the server, right? The Cache only applies to the
> > client portion, there is no such thing as disabling the remote cache.
> > I don't see any incoming Read By Group Request from the remote so it
> > is very likely that it has cached the values, there is no Read By Type
> > for the DB Hash either which is quite surprising to me since that is
> > required for stacks supporting Robust Caching which I believe is the
> > case of iOS.
> >
> > Anyway, I would check that the following lines are being triggered:
> >
> > When starting:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-databa=
se.c#n3798
> >
> > On connect:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-databa=
se.c#n3741
> >
> > If those lines are not being triggered it is likely a client problem
> > which for some reason had not subscribed to received service changes
> > for some reason, if it doesn't subscribe to service changes then it
> > shall not cache any attribute and attempt to rediscover on every
> > connection.
> >
> > > The only way to fix this issue is to force exit the mobile app on the=
 phone and "Forget This Device" in iOS or "Unpair" in Android.
> > >
> > > I looked at the btmon(see attached). For the working btmon log, there=
 is "Attribute group list: XX entries" under "ACL Data TX". But there is no=
 "Attribute group list: XX entries" under "ACL Data TX" in the attached pro=
blematic btmon log.
> > >
> > > Questions:
> > > 1. How is it possible that this still happens even if the bluetooth c=
ache is disabled?
> > > 2. Is this the problem on the Linux side which runs the GATT server o=
r on the mobile side?
> > > 3. Is there anything else we should look into?
> > >
> > > We're going to release our product soon. This is a critical issue for=
 us. Please help if you have any suggestions.
> > >
> > > Thanks!
> > > THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN=
 MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND M=
AY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED=
 RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NO=
TIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROP=
ERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT =
THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
