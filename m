Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42FC65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 02:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9264720879
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 02:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt/SgTj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeLNCcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:32:42 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38995 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbeLNCcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 21:32:41 -0500
Received: by mail-ot1-f48.google.com with SMTP id n8so4028728otl.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 18:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EMoUWBm6fZvqNkIGcw79HLXyUQvjlMafEQM6E2nEeJQ=;
        b=Tt/SgTj/dWOek8Kgg/lm/3vj5pJZ9Q1DaL7XtqslVU6NNQ9S/XFuxjYS8ec7JonZBZ
         5dMp6igS3D1fxK1SdJ+8lF9TZUNVIXfLVnggTqJVtzLHShgQ3/qKOxnQ4WfhRWykw8Ut
         0c9TxIFI0hU/WLl2+EDbAMgTiKkIkCxy9TvjakPuvwfMRAe5OtawOgMgduRT8mS6QUOa
         c77z6hR47uINYXeiArXvfeEIqaOVIc72c57gouae8L4UB20ep3XlwTK8tqJoAj6xGxtA
         Q60zp3JURqFRjgOTNNFHQd19JjLU/Cgx01yshpz/gCSezSQH+v3i2GxGhGysJntV1D7O
         qd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EMoUWBm6fZvqNkIGcw79HLXyUQvjlMafEQM6E2nEeJQ=;
        b=rLP+kFCG3qqSc2gNK7TLwqbAVTQ4Q7+9ZJaeHeEu/Bzzm1+cyIH7JWCMo7LrTcUyoP
         UZ4yjHVCkR9483mo6CFVc460armxHnQIOeap51XYEETY/CvV+poqkpf/z7/ILFjs0im2
         k4pX76BqjIqDDejBggicZmSpo1+eiZG/qlf+cSycsAWscRZSzAXAjl+z/TCrXdF3HT1v
         aiRKXFf6V+pu3BI9HhJH4PiZiAqGnWmzd9AbiJIhDeRrzq3fald5S5g/cdlv1TD3V/4l
         MEKWwwyJN7mXmwwzAA2uAYGpkqguWsLF5qlmfp5nURzotYtqtWKmj+x26AyDw+Zri/d2
         fMCw==
X-Gm-Message-State: AA+aEWZLtSa8kg/iIWOkH19DIujrPah4W8nz7J0FZf0EluXnyY6U3phl
        i5Ys8llOyou7h+hcjJG67XUFARhUMA57RKkKcF4=
X-Google-Smtp-Source: AFSGD/UFhGgTbclzgafMuelX3JGrkKkKkRmmjzFTj1jLkk5GcCwt+gwkMSwUPvdw1KLQm96jyHdZsJBMGIkA5kn4G68=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr871349otp.254.1544754760063;
 Thu, 13 Dec 2018 18:32:40 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
 <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
 <CABBYNZLPeHRWcG78USDYHL6zzw392JuefRaD9S_+RuXhDQ9ZCw@mail.gmail.com>
 <CAOOu1=BiJ9VjiMXiiPuXb=4cu-62OYmT+h1Z83ip440KwSpeAw@mail.gmail.com>
 <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com>
 <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com>
 <CABBYNZ+-jWMU4-AKt-90WMtzMs0sasefrZnf2ZZ1Ev7vTjbb8Q@mail.gmail.com> <CALvjcs8izKVNN73855WSdJFJWD0gKjuxZ4SHC=ZvW-Ptxvj5qQ@mail.gmail.com>
In-Reply-To: <CALvjcs8izKVNN73855WSdJFJWD0gKjuxZ4SHC=ZvW-Ptxvj5qQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Dec 2018 04:32:26 +0200
Message-ID: <CABBYNZLvBAyOc_6NPCghDAqGV+uW-=2Y8uEcWnjAOQb1UmD36w@mail.gmail.com>
Subject: Re: BLE advertisement re-enabling after ble connection goes away
To:     Yunhan Wang <yunhanw@nestlabs.com>
Cc:     mturon@google.com, Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yunhan,

On Fri, Dec 14, 2018 at 4:06 AM Yunhan Wang <yunhanw@nestlabs.com> wrote:
>
> Hi, Luiz
>
> Thanks for your reply. A little bit confused here.
>
> There is no code in bluez that directly re-enable advertisement, if
> there is, could you show the code location in bluez?

Isn't that what the following code does:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tre=
e/net/bluetooth/hci_request.c#n1386

> Bluetooth in kernel is responsible for re-enabling advertisement? The
> responsibility for re-enabling the advertising is kernel instead of
> bluez and user application code.

Yes it is the kernel which re-enables it and it has been doing this
for a long while so I wonder why all of the a sudden we are discussing
about it. Is there a bug related to it?

> Thanks
> Best wishes
> Yunhan
>
>
>
> On Thu, Dec 13, 2018 at 5:21 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yunhan,
> >
> > You already answered your question, it is reenabled by
> > hci_req_reenable_advertising
> >
> >
> > On Fri, Dec 14, 2018 at 1:13 AM Yunhan Wang <yunhanw@nestlabs.com> wrot=
e:
> > >
> > > Hi, Luiz
> > >
> > > Rephrasing a little bit..
> > >
> > > From what you describes, it seems Bluez is taking the responsibility
> > > to reenable the advertisement in peripheral side after the previous
> > > ble connection goes
> > > away.
> > >
> > > When I did local test, the ble peripheral is using bluez, I create
> > > gatt server and ble advertisment using Bluez DBus API,  when remote
> > > connection in central disconnects, I see kernel in Bluez in periphera=
l
> > > side do receive
> > > HCI_EV_DISCONN_COMPLETE event, and trigger
> > > hci_req_reenable_advertising.
> > >
> > > Maybe you can share the code location where Bluez is reenabling the
> > > advertisement after ble connection goes away?
> > >
> > > Thanks
> > > Best wishes
> > > On Thu, Dec 13, 2018 at 3:10 PM Yunhan Wang <yunhanw@nestlabs.com> wr=
ote:
> > > >
> > > > Hi, Luiz
> > > >
> > > > From what you describes, it seems Bluez is taking the responsibilit=
y
> > > > to reenable the advertisement after the previous ble connection goe=
s
> > > > away.
> > > >
> > > > When I did local test, the ble peripheral is using bluez, I create
> > > > gatt server and ble advertisment using Bluez DBus API,  when remote
> > > > connection in central disconnects, I see kernel in Bluez do receive
> > > > HCI_EV_DISCONN_COMPLETE event, and trigger
> > > > hci_req_reenable_advertising.
> > > >
> > > > Maybe you can share the code location where Bluez is reenabling the
> > > > advertisement after ble connection goes away?
> > > >
> > > > Thanks
> > > > Best wishes
> > > > Yunhan
> > > >
> > > > On Thu, Dec 13, 2018 at 2:30 PM Martin Turon <mturon@google.com> wr=
ote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > Is this behavior also expected on raw hci sockets?  Because my ob=
servation is that when working with raw hci over such sockets, auto-reenabl=
e does not occur.
> > > > >
> > > > >     #define BTPROTO_HCI                 1
> > > > >     #define HCI_CHANNEL_USER         1
> > > > >
> > > > >     struct sockaddr_hci shci;
> > > > >     shci.hci_family =3D AF_BLUETOOTH;
> > > > >     shci.hci_dev =3D s_ble_hci_device;
> > > > >     shci.hci_channel =3D HCI_CHANNEL_USER;
> > > > >
> > > > >     s =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > > > >     rc =3D bind(s, (struct sockaddr *)&shci, sizeof(shci));
> >
> > Raw socket commands might actually work but here you are using it with
> > a user channel which afaik disables the stack processing.
> >
> > > > > Also, which API allows the user to control the advertising instan=
ces you describe?  Are they automatically created by the kernel when HCI is=
 sent to a raw socket to enable advertising?
> >
> > Nope you need to use the management interface to use the advertising
> > instances, or better yet use the D-Bus API:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising=
-api.txt
> >
> > > > > Thanks,
> > > > > Martin
> > > > >
> > > > > _____________________________
> > > > > Martin Turon  |  Google
> > > > >
> > > > >
> > > > >
> > > > > On Thu, Dec 13, 2018 at 1:49 PM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
> > > > >>
> > > > >> Hi Yunhan,
> > > > >>
> > > > >> The BlueZ API operates a bit different than HCI, it keeps re-ena=
bling the advertisement if there is any instance active, but the user can s=
top this by removing its instance once a connection is made, this is consid=
ered more convenient than having the user to reprogram the advertisement on=
 every disconnection.
> > > > >>
> > > > >> On Thu, 13 Dec 2018, 18:38 Yunhan Wang <yunhanw@nestlabs.com wro=
te:
> > > > >>>
> > > > >>> +Martin
> > > > >>>
> > > > >>> Hi, Luiz and Marcel
> > > > >>>
> > > > >>> When I take a look at the bluetooth code, it seems it is re-ena=
bling
> > > > >>> ble advertisement after ble connection goes away. Any idea?
> > > > >>>
> > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git/tree/net/bluetooth/hci_event.c#n2634
> > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git/tree/net/bluetooth/hci_event.c#n2712
> > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git/tree/net/bluetooth/hci_request.c#n1386
> > > > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git/tree/net/bluetooth/hci_request.c#n1734
> > > > >>>
> > > > >>> Thanks
> > > > >>> Best wishes
> > > > >>> Yunhan
> > > > >>> On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.co=
m> wrote:
> > > > >>> >
> > > > >>> > Hi, Luiz and Marcel
> > > > >>> >
> > > > >>> > May I have a question on ble behavior on BLE re-advertisement=
?
> > > > >>> >
> > > > >>> > According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2=
, "The
> > > > >>> > device shall remain in general discoverable mode until a conn=
ection is
> > > > >>> > established or the Host terminates the mode."
> > > > >>> >
> > > > >>> > There is no description on re-enabling the advertising "after=
"
> > > > >>> > disconnection, so the responsibility for re-enabling the adve=
rtising
> > > > >>> > is bluez or kernel or application code? In other words, does =
kernel or
> > > > >>> > bluez or application would re-enable the ble advertisement af=
ter ble
> > > > >>> > disconnection happens?
> > > > >>> >
> > > > >>> > Thanks
> > > > >>> > Best wishes
> > > > >>> > Yunhan.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
