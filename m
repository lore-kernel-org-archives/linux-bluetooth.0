Return-Path: <SRS0=8d51=OX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0DC65BAE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 01:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CD820879
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Dec 2018 01:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmDbTsMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CD820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeLNBVk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:21:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45204 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLNBVk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 20:21:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so3861897ota.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 17:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fydq/tOKBTvj6972atheSIrka+aZdpikddvn/rPgw4A=;
        b=rmDbTsMBQGR0+nseEDpPen2alE49fjG6krcVtFeRhJQJSR7TAapElhbdg/N6ey6bGW
         Vr3pqDtfqTJohYBbCIRjgcM0I8AxYcimWmJczVZzSr4tCROJe+tcSU2Tbhm7L0h57pVZ
         RgagDmmz7eENERDq510Bo/eopEx9qE6JwGxW+9QJHzZHPtg5T5v7nvHmqf0I7bXJrrKf
         uEIo6ZN4H2ca/v5j8CWGN3z1b4+rCKpmYqILATXd5/zMDF9+LgJeQC8bqi5QE4w5GK3D
         GbH71k5UFI961l3Naie/iepjvr8fCkFa8jibaFbgftmuk92ADb0VgBMYPC8guPvBgbWS
         jQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fydq/tOKBTvj6972atheSIrka+aZdpikddvn/rPgw4A=;
        b=NVLOzXLAaPnSRd6ygcNAKw3CFL8HFEK6zv07jCuRPftvvhKo+T3GJkyflg+s8Pb0VP
         G53ks9FgkF5PWmeOrA8ZBjfuvgaHSZFN+d+dt3RmscQbddeDkQHEcMWrCxjyaiAoJvxA
         UOzl8pUvW2YrS1Ni9XVF9gYP93FQuxNQoxZoMW6iNZ5WZonmjE+WFShNGXedqXRAcGHD
         4bn15u9Qak5BeWkIVFrGyASDEdaRNQF2mIB7Eq5oJbZjS6JNQH4Eln6BuBAXTT442135
         kxMAqqjFVxg6vko452to1FrzJXruhoEYdtnBTV0IS6t/Gt725et+pj75FDML69AwNEn3
         HZYg==
X-Gm-Message-State: AA+aEWbG6HNDKgtTdm6/6V/v8ZL9GafBHHUrmdyRFCtEw3ga7lshN88n
        I/s+XKGPXkpmQ37soiw/cjZFj4elR2BEvMWWWVY=
X-Google-Smtp-Source: AFSGD/X1v6pMpWGRubFXWDMhwvoTIEKi2YEuNeibbe1Lf6yoLAl+YY1KdO1zUsNOniicrXqu9TGKK33y943PmWYMcas=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr784284otf.242.1544750498980;
 Thu, 13 Dec 2018 17:21:38 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
 <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
 <CABBYNZLPeHRWcG78USDYHL6zzw392JuefRaD9S_+RuXhDQ9ZCw@mail.gmail.com>
 <CAOOu1=BiJ9VjiMXiiPuXb=4cu-62OYmT+h1Z83ip440KwSpeAw@mail.gmail.com>
 <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com> <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com>
In-Reply-To: <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Dec 2018 03:21:24 +0200
Message-ID: <CABBYNZ+-jWMU4-AKt-90WMtzMs0sasefrZnf2ZZ1Ev7vTjbb8Q@mail.gmail.com>
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

You already answered your question, it is reenabled by
hci_req_reenable_advertising


On Fri, Dec 14, 2018 at 1:13 AM Yunhan Wang <yunhanw@nestlabs.com> wrote:
>
> Hi, Luiz
>
> Rephrasing a little bit..
>
> From what you describes, it seems Bluez is taking the responsibility
> to reenable the advertisement in peripheral side after the previous
> ble connection goes
> away.
>
> When I did local test, the ble peripheral is using bluez, I create
> gatt server and ble advertisment using Bluez DBus API,  when remote
> connection in central disconnects, I see kernel in Bluez in peripheral
> side do receive
> HCI_EV_DISCONN_COMPLETE event, and trigger
> hci_req_reenable_advertising.
>
> Maybe you can share the code location where Bluez is reenabling the
> advertisement after ble connection goes away?
>
> Thanks
> Best wishes
> On Thu, Dec 13, 2018 at 3:10 PM Yunhan Wang <yunhanw@nestlabs.com> wrote:
> >
> > Hi, Luiz
> >
> > From what you describes, it seems Bluez is taking the responsibility
> > to reenable the advertisement after the previous ble connection goes
> > away.
> >
> > When I did local test, the ble peripheral is using bluez, I create
> > gatt server and ble advertisment using Bluez DBus API,  when remote
> > connection in central disconnects, I see kernel in Bluez do receive
> > HCI_EV_DISCONN_COMPLETE event, and trigger
> > hci_req_reenable_advertising.
> >
> > Maybe you can share the code location where Bluez is reenabling the
> > advertisement after ble connection goes away?
> >
> > Thanks
> > Best wishes
> > Yunhan
> >
> > On Thu, Dec 13, 2018 at 2:30 PM Martin Turon <mturon@google.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Is this behavior also expected on raw hci sockets?  Because my observ=
ation is that when working with raw hci over such sockets, auto-reenable do=
es not occur.
> > >
> > >     #define BTPROTO_HCI                 1
> > >     #define HCI_CHANNEL_USER         1
> > >
> > >     struct sockaddr_hci shci;
> > >     shci.hci_family =3D AF_BLUETOOTH;
> > >     shci.hci_dev =3D s_ble_hci_device;
> > >     shci.hci_channel =3D HCI_CHANNEL_USER;
> > >
> > >     s =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> > >     rc =3D bind(s, (struct sockaddr *)&shci, sizeof(shci));

Raw socket commands might actually work but here you are using it with
a user channel which afaik disables the stack processing.

> > > Also, which API allows the user to control the advertising instances =
you describe?  Are they automatically created by the kernel when HCI is sen=
t to a raw socket to enable advertising?

Nope you need to use the management interface to use the advertising
instances, or better yet use the D-Bus API:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api=
.txt

> > > Thanks,
> > > Martin
> > >
> > > _____________________________
> > > Martin Turon  |  Google
> > >
> > >
> > >
> > > On Thu, Dec 13, 2018 at 1:49 PM Luiz Augusto von Dentz <luiz.dentz@gm=
ail.com> wrote:
> > >>
> > >> Hi Yunhan,
> > >>
> > >> The BlueZ API operates a bit different than HCI, it keeps re-enablin=
g the advertisement if there is any instance active, but the user can stop =
this by removing its instance once a connection is made, this is considered=
 more convenient than having the user to reprogram the advertisement on eve=
ry disconnection.
> > >>
> > >> On Thu, 13 Dec 2018, 18:38 Yunhan Wang <yunhanw@nestlabs.com wrote:
> > >>>
> > >>> +Martin
> > >>>
> > >>> Hi, Luiz and Marcel
> > >>>
> > >>> When I take a look at the bluetooth code, it seems it is re-enablin=
g
> > >>> ble advertisement after ble connection goes away. Any idea?
> > >>>
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
.git/tree/net/bluetooth/hci_event.c#n2634
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
.git/tree/net/bluetooth/hci_event.c#n2712
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
.git/tree/net/bluetooth/hci_request.c#n1386
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
.git/tree/net/bluetooth/hci_request.c#n1734
> > >>>
> > >>> Thanks
> > >>> Best wishes
> > >>> Yunhan
> > >>> On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.com> w=
rote:
> > >>> >
> > >>> > Hi, Luiz and Marcel
> > >>> >
> > >>> > May I have a question on ble behavior on BLE re-advertisement?
> > >>> >
> > >>> > According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2, "T=
he
> > >>> > device shall remain in general discoverable mode until a connecti=
on is
> > >>> > established or the Host terminates the mode."
> > >>> >
> > >>> > There is no description on re-enabling the advertising "after"
> > >>> > disconnection, so the responsibility for re-enabling the advertis=
ing
> > >>> > is bluez or kernel or application code? In other words, does kern=
el or
> > >>> > bluez or application would re-enable the ble advertisement after =
ble
> > >>> > disconnection happens?
> > >>> >
> > >>> > Thanks
> > >>> > Best wishes
> > >>> > Yunhan.



--=20
Luiz Augusto von Dentz
