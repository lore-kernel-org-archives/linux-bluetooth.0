Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED1CC65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6320879
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nestlabs.com header.i=@nestlabs.com header.b="LmNTazNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nestlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLNDJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:09:08 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:53024 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNDJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 22:09:07 -0500
Received: by mail-it1-f173.google.com with SMTP id g76so6993108itg.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 19:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nestlabs.com; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oMcTET68KSzFWfrVIoQ/3IWjWFOkT82k/hMdzbkHZ+I=;
        b=LmNTazNr2xjQ8MVB2zk4AWnRLPB/77gMYG6/4gjAgtRiGrHu4sl4ElTw+NKssRMYiR
         vnUm654i5juS7DOxjDy3tLJctZOs7IkGNKGMOSlLt587ExipvF91HQyl+p9SspvKsfxr
         zXkJl4vso9fjoHdqjhBoc2amgII0zfibjVf9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oMcTET68KSzFWfrVIoQ/3IWjWFOkT82k/hMdzbkHZ+I=;
        b=aXELcxg+zk7GAOKMWPjK1YyzVncmXQ043Y7M9m8DABXh84idwOSFYGWcW7UxBKUYqh
         tFr8l3Z9eUIAlDwrOHtHtfca2tx4LDJFdPuhIVE1fUj8ZQCruVM2s9EGIp1Dvda3p76e
         b9w7ElKv070J6JgZ/Kclg4gkgiVCYCCR/J8miQ3ro9NhvG1oaNCd4vyPDSEILfsYqaD7
         ZHxM9FglU9x4syuda5ycO/dua4qzAKXWyeaZMWTkfFBpdvLpYLVAHHu0Z2FAp561hxE1
         fJ4hWYzPiJ/Eapwv4rUedE+BV8FCw/1wFZ+Ja6CNpXPIoU5fIdV5NyyAPE8ryWpQyaMo
         iZGg==
X-Gm-Message-State: AA+aEWbaEfzguENdN3VyNsEnv/EQQ+PIWby+BfnhdAofsLzIILxF6ZTz
        0RC9oN7lgNAC84qiyNHrMpBoMzZP6PZfDjypLs/rMA==
X-Google-Smtp-Source: AFSGD/UA8o66Xo//TEPrTxoBmgmBr+/aL1CN7vwJ0pJ0povbR1i/J1yZz0Jca55BjrkJSb7KShLAN4NUX2AqpIqvmDs=
X-Received: by 2002:a24:3842:: with SMTP id b63mr2013402ita.19.1544756946240;
 Thu, 13 Dec 2018 19:09:06 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
 <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
 <CABBYNZLPeHRWcG78USDYHL6zzw392JuefRaD9S_+RuXhDQ9ZCw@mail.gmail.com>
 <CAOOu1=BiJ9VjiMXiiPuXb=4cu-62OYmT+h1Z83ip440KwSpeAw@mail.gmail.com>
 <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com>
 <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com>
 <CABBYNZ+-jWMU4-AKt-90WMtzMs0sasefrZnf2ZZ1Ev7vTjbb8Q@mail.gmail.com>
 <CALvjcs8izKVNN73855WSdJFJWD0gKjuxZ4SHC=ZvW-Ptxvj5qQ@mail.gmail.com> <CABBYNZLvBAyOc_6NPCghDAqGV+uW-=2Y8uEcWnjAOQb1UmD36w@mail.gmail.com>
In-Reply-To: <CABBYNZLvBAyOc_6NPCghDAqGV+uW-=2Y8uEcWnjAOQb1UmD36w@mail.gmail.com>
Reply-To: yunhanw@nestlabs.com
From:   Yunhan Wang <yunhanw@nestlabs.com>
Date:   Thu, 13 Dec 2018 19:08:54 -0800
Message-ID: <CALvjcs8gu1d4Z7Bic37wZeDjHevLmL_dZH=AHvv5iuRG9khj+A@mail.gmail.com>
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

Thanks for the clarification.

On Thu, Dec 13, 2018 at 6:32 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yunhan,
>
> On Fri, Dec 14, 2018 at 4:06 AM Yunhan Wang <yunhanw@nestlabs.com> wrote:
> >
> > Hi, Luiz
> >
> > Thanks for your reply. A little bit confused here.
> >
> > There is no code in bluez that directly re-enable advertisement, if
> > there is, could you show the code location in bluez?
>
> Isn't that what the following code does:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/t=
ree/net/bluetooth/hci_request.c#n1386
>

I think this link is bluetooth code in kernel, and it is not bluez
code. Now I understand you think this bluetooth code is part of
bluez..

> > Bluetooth in kernel is responsible for re-enabling advertisement? The
> > responsibility for re-enabling the advertising is kernel instead of
> > bluez and user application code.
>
> Yes it is the kernel which re-enables it and it has been doing this
> for a long while so I wonder why all of the a sudden we are discussing
> about it. Is there a bug related to it?
>
I am seeing chrome os bluetooth kernel doesn't re-enable
advertisement, so I wanna figure out if bluetooth in kernel or bluez
user space or user application needs take this responsibility to
re-enable the advertisement. Clearly you mention bluetooth kernel
needs to re-enable the advertisement, I would further figure out the
root cause in chrome os kernel...

Thanks
Best wishes
Yunhan
> > Thanks
> > Best wishes
> > Yunhan
> >
> >
> >
> > On Thu, Dec 13, 2018 at 5:21 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Yunhan,
> > >
> > > You already answered your question, it is reenabled by
> > > hci_req_reenable_advertising
> > >
> > >
> > > On Fri, Dec 14, 2018 at 1:13 AM Yunhan Wang <yunhanw@nestlabs.com> wr=
ote:
> > > >
> > > > Hi, Luiz
> > > >
> > > > Rephrasing a little bit..
> > > >
> > > > From what you describes, it seems Bluez is taking the responsibilit=
y
> > > > to reenable the advertisement in peripheral side after the previous
> > > > ble connection goes
> > > > away.
> > > >
> > > > When I did local test, the ble peripheral is using bluez, I create
> > > > gatt server and ble advertisment using Bluez DBus API,  when remote
> > > > connection in central disconnects, I see kernel in Bluez in periphe=
ral
> > > > side do receive
> > > > HCI_EV_DISCONN_COMPLETE event, and trigger
> > > > hci_req_reenable_advertising.
> > > >
> > > > Maybe you can share the code location where Bluez is reenabling the
> > > > advertisement after ble connection goes away?
> > > >
> > > > Thanks
> > > > Best wishes
> > > > On Thu, Dec 13, 2018 at 3:10 PM Yunhan Wang <yunhanw@nestlabs.com> =
wrote:
> > > > >
> > > > > Hi, Luiz
> > > > >
> > > > > From what you describes, it seems Bluez is taking the responsibil=
ity
> > > > > to reenable the advertisement after the previous ble connection g=
oes
> > > > > away.
> > > > >
> > > > > When I did local test, the ble peripheral is using bluez, I creat=
e
> > > > > gatt server and ble advertisment using Bluez DBus API,  when remo=
te
> > > > > connection in central disconnects, I see kernel in Bluez do recei=
ve
> > > > > HCI_EV_DISCONN_COMPLETE event, and trigger
> > > > > hci_req_reenable_advertising.
> > > > >
> > > > > Maybe you can share the code location where Bluez is reenabling t=
he
> > > > > advertisement after ble connection goes away?
> > > > >
> > > > > Thanks
> > > > > Best wishes
> > > > > Yunhan
> > > > >
> > > > > On Thu, Dec 13, 2018 at 2:30 PM Martin Turon <mturon@google.com> =
wrote:
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > Is this behavior also expected on raw hci sockets?  Because my =
observation is that when working with raw hci over such sockets, auto-reena=
ble does not occur.
> > > > > >
> > > > > >     #define BTPROTO_HCI                 1
> > > > > >     #define HCI_CHANNEL_USER         1
> > > > > >
> > > > > >     struct sockaddr_hci shci;
> > > > > >     shci.hci_family =3D AF_BLUETOOTH;
> > > > > >     shci.hci_dev =3D s_ble_hci_device;
> > > > > >     shci.hci_channel =3D HCI_CHANNEL_USER;
> > > > > >
> > > > > >     s =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > > > > >     rc =3D bind(s, (struct sockaddr *)&shci, sizeof(shci));
> > >
> > > Raw socket commands might actually work but here you are using it wit=
h
> > > a user channel which afaik disables the stack processing.
> > >
> > > > > > Also, which API allows the user to control the advertising inst=
ances you describe?  Are they automatically created by the kernel when HCI =
is sent to a raw socket to enable advertising?
> > >
> > > Nope you need to use the management interface to use the advertising
> > > instances, or better yet use the D-Bus API:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertisi=
ng-api.txt
> > >
> > > > > > Thanks,
> > > > > > Martin
> > > > > >
> > > > > > _____________________________
> > > > > > Martin Turon  |  Google
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Thu, Dec 13, 2018 at 1:49 PM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> > > > > >>
> > > > > >> Hi Yunhan,
> > > > > >>
> > > > > >> The BlueZ API operates a bit different than HCI, it keeps re-e=
nabling the advertisement if there is any instance active, but the user can=
 stop this by removing its instance once a connection is made, this is cons=
idered more convenient than having the user to reprogram the advertisement =
on every disconnection.
> > > > > >>
> > > > > >> On Thu, 13 Dec 2018, 18:38 Yunhan Wang <yunhanw@nestlabs.com w=
rote:
> > > > > >>>
> > > > > >>> +Martin
> > > > > >>>
> > > > > >>> Hi, Luiz and Marcel
> > > > > >>>
> > > > > >>> When I take a look at the bluetooth code, it seems it is re-e=
nabling
> > > > > >>> ble advertisement after ble connection goes away. Any idea?
> > > > > >>>
> > > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth.git/tree/net/bluetooth/hci_event.c#n2634
> > > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth.git/tree/net/bluetooth/hci_event.c#n2712
> > > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth.git/tree/net/bluetooth/hci_request.c#n1386
> > > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth.git/tree/net/bluetooth/hci_request.c#n1734
> > > > > >>>
> > > > > >>> Thanks
> > > > > >>> Best wishes
> > > > > >>> Yunhan
> > > > > >>> On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.=
com> wrote:
> > > > > >>> >
> > > > > >>> > Hi, Luiz and Marcel
> > > > > >>> >
> > > > > >>> > May I have a question on ble behavior on BLE re-advertiseme=
nt?
> > > > > >>> >
> > > > > >>> > According to Bluetooth spec Vol. 3 (the host volume), 9.2.4=
.2, "The
> > > > > >>> > device shall remain in general discoverable mode until a co=
nnection is
> > > > > >>> > established or the Host terminates the mode."
> > > > > >>> >
> > > > > >>> > There is no description on re-enabling the advertising "aft=
er"
> > > > > >>> > disconnection, so the responsibility for re-enabling the ad=
vertising
> > > > > >>> > is bluez or kernel or application code? In other words, doe=
s kernel or
> > > > > >>> > bluez or application would re-enable the ble advertisement =
after ble
> > > > > >>> > disconnection happens?
> > > > > >>> >
> > > > > >>> > Thanks
> > > > > >>> > Best wishes
> > > > > >>> > Yunhan.
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
