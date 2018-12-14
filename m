Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CCC65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D220879
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 02:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nestlabs.com header.i=@nestlabs.com header.b="SEAGXT1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705D220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nestlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeLNCGf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:06:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53502 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeLNCGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 21:06:34 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so6821407ita.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nestlabs.com; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FOp8BCzmS1cZ1jZTllPz62tuGB6nDZj+BhCPx/tA05Q=;
        b=SEAGXT1i6ecxIVh5qe7F1HkZ7MLhKID7AZ1fMexwamvblJkKxyyzC7c7W8Dut6aKZp
         xXgNx4TUIDjc23qs4xNjJeUwYSYiXZTRyOXtyR0dSm6A3euSaceHc+qqO1SODI/JJsHw
         GT4OdW+15uD+gMrdXN3bJSd8f3eVu0YdtnN6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FOp8BCzmS1cZ1jZTllPz62tuGB6nDZj+BhCPx/tA05Q=;
        b=DQTCGsoA7OHc4VsNliIdLAIQf8VvvFzzDgNdHqOnL/XT6P6cgMjsYWkh8ip2OguTE5
         ZqWY3dr6HDWgkhYAHq29i/LrjOwQIaX1h1PjX60AwYk7R5rVUln85AKdK5qfuROkshZW
         ePtv70BMEjsRZhhtlBEmuRhLmdqklSSKWdUJnH7NeybnGtl6aCPNpb1txs2CxDI3OLyo
         LRFyB3y3n40hzIwC+YPA20a4cO5+peOeWnCb0CpzXC3mzTmxH7tcM0eyR//f64XovJwp
         FKbggRVQF5HoimGbQuh+uMtxoGqmqHhJX/d5j0D3kF0hdgs4A0DVw+GchxkfBvL49zFE
         jbOA==
X-Gm-Message-State: AA+aEWYL2Ycs1B9BV1b9KnDhMRg9bDcMhSpBUrgehxpt3gYSxhdoMLWV
        pctQwCk/+aMEdoFiX9rH4o2cjvH7DzaQSwHCKdelUg==
X-Google-Smtp-Source: AFSGD/UEeAHvcLvJoRyF8Ie02yvtFx+VIi3srYNfXBRll+z8IMfdpE52gww0OwvkD84P//NkZUiYmCahU85jwacKOVs=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr1587909ite.72.1544753193254;
 Thu, 13 Dec 2018 18:06:33 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
 <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
 <CABBYNZLPeHRWcG78USDYHL6zzw392JuefRaD9S_+RuXhDQ9ZCw@mail.gmail.com>
 <CAOOu1=BiJ9VjiMXiiPuXb=4cu-62OYmT+h1Z83ip440KwSpeAw@mail.gmail.com>
 <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com>
 <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com> <CABBYNZ+-jWMU4-AKt-90WMtzMs0sasefrZnf2ZZ1Ev7vTjbb8Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+-jWMU4-AKt-90WMtzMs0sasefrZnf2ZZ1Ev7vTjbb8Q@mail.gmail.com>
Reply-To: yunhanw@nestlabs.com
From:   Yunhan Wang <yunhanw@nestlabs.com>
Date:   Thu, 13 Dec 2018 18:06:22 -0800
Message-ID: <CALvjcs8izKVNN73855WSdJFJWD0gKjuxZ4SHC=ZvW-Ptxvj5qQ@mail.gmail.com>
Subject: Re: BLE advertisement re-enabling after ble connection goes away
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Martin Turon <mturon@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz

Thanks for your reply. A little bit confused here.

There is no code in bluez that directly re-enable advertisement, if
there is, could you show the code location in bluez?

Bluetooth in kernel is responsible for re-enabling advertisement? The
responsibility for re-enabling the advertising is kernel instead of
bluez and user application code.

Thanks
Best wishes
Yunhan



On Thu, Dec 13, 2018 at 5:21 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
>
> You already answered your question, it is reenabled by
> hci_req_reenable_advertising
>
>
> On Fri, Dec 14, 2018 at 1:13 AM Yunhan Wang <yunhanw@nestlabs.com> wrote:
> >
> > Hi, Luiz
> >
> > Rephrasing a little bit..
> >
> > From what you describes, it seems Bluez is taking the responsibility
> > to reenable the advertisement in peripheral side after the previous
> > ble connection goes
> > away.
> >
> > When I did local test, the ble peripheral is using bluez, I create
> > gatt server and ble advertisment using Bluez DBus API,  when remote
> > connection in central disconnects, I see kernel in Bluez in peripheral
> > side do receive
> > HCI_EV_DISCONN_COMPLETE event, and trigger
> > hci_req_reenable_advertising.
> >
> > Maybe you can share the code location where Bluez is reenabling the
> > advertisement after ble connection goes away?
> >
> > Thanks
> > Best wishes
> > On Thu, Dec 13, 2018 at 3:10 PM Yunhan Wang <yunhanw@nestlabs.com> wrot=
e:
> > >
> > > Hi, Luiz
> > >
> > > From what you describes, it seems Bluez is taking the responsibility
> > > to reenable the advertisement after the previous ble connection goes
> > > away.
> > >
> > > When I did local test, the ble peripheral is using bluez, I create
> > > gatt server and ble advertisment using Bluez DBus API,  when remote
> > > connection in central disconnects, I see kernel in Bluez do receive
> > > HCI_EV_DISCONN_COMPLETE event, and trigger
> > > hci_req_reenable_advertising.
> > >
> > > Maybe you can share the code location where Bluez is reenabling the
> > > advertisement after ble connection goes away?
> > >
> > > Thanks
> > > Best wishes
> > > Yunhan
> > >
> > > On Thu, Dec 13, 2018 at 2:30 PM Martin Turon <mturon@google.com> wrot=
e:
> > > >
> > > > Hi Luiz,
> > > >
> > > > Is this behavior also expected on raw hci sockets?  Because my obse=
rvation is that when working with raw hci over such sockets, auto-reenable =
does not occur.
> > > >
> > > >     #define BTPROTO_HCI                 1
> > > >     #define HCI_CHANNEL_USER         1
> > > >
> > > >     struct sockaddr_hci shci;
> > > >     shci.hci_family =3D AF_BLUETOOTH;
> > > >     shci.hci_dev =3D s_ble_hci_device;
> > > >     shci.hci_channel =3D HCI_CHANNEL_USER;
> > > >
> > > >     s =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > > >     rc =3D bind(s, (struct sockaddr *)&shci, sizeof(shci));
>
> Raw socket commands might actually work but here you are using it with
> a user channel which afaik disables the stack processing.
>
> > > > Also, which API allows the user to control the advertising instance=
s you describe?  Are they automatically created by the kernel when HCI is s=
ent to a raw socket to enable advertising?
>
> Nope you need to use the management interface to use the advertising
> instances, or better yet use the D-Bus API:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-a=
pi.txt
>
> > > > Thanks,
> > > > Martin
> > > >
> > > > _____________________________
> > > > Martin Turon  |  Google
> > > >
> > > >
> > > >
> > > > On Thu, Dec 13, 2018 at 1:49 PM Luiz Augusto von Dentz <luiz.dentz@=
gmail.com> wrote:
> > > >>
> > > >> Hi Yunhan,
> > > >>
> > > >> The BlueZ API operates a bit different than HCI, it keeps re-enabl=
ing the advertisement if there is any instance active, but the user can sto=
p this by removing its instance once a connection is made, this is consider=
ed more convenient than having the user to reprogram the advertisement on e=
very disconnection.
> > > >>
> > > >> On Thu, 13 Dec 2018, 18:38 Yunhan Wang <yunhanw@nestlabs.com wrote=
:
> > > >>>
> > > >>> +Martin
> > > >>>
> > > >>> Hi, Luiz and Marcel
> > > >>>
> > > >>> When I take a look at the bluetooth code, it seems it is re-enabl=
ing
> > > >>> ble advertisement after ble connection goes away. Any idea?
> > > >>>
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/tree/net/bluetooth/hci_event.c#n2634
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/tree/net/bluetooth/hci_event.c#n2712
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/tree/net/bluetooth/hci_request.c#n1386
> > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/tree/net/bluetooth/hci_request.c#n1734
> > > >>>
> > > >>> Thanks
> > > >>> Best wishes
> > > >>> Yunhan
> > > >>> On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.com>=
 wrote:
> > > >>> >
> > > >>> > Hi, Luiz and Marcel
> > > >>> >
> > > >>> > May I have a question on ble behavior on BLE re-advertisement?
> > > >>> >
> > > >>> > According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2, =
"The
> > > >>> > device shall remain in general discoverable mode until a connec=
tion is
> > > >>> > established or the Host terminates the mode."
> > > >>> >
> > > >>> > There is no description on re-enabling the advertising "after"
> > > >>> > disconnection, so the responsibility for re-enabling the advert=
ising
> > > >>> > is bluez or kernel or application code? In other words, does ke=
rnel or
> > > >>> > bluez or application would re-enable the ble advertisement afte=
r ble
> > > >>> > disconnection happens?
> > > >>> >
> > > >>> > Thanks
> > > >>> > Best wishes
> > > >>> > Yunhan.
>
>
>
> --
> Luiz Augusto von Dentz
