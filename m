Return-Path: <SRS0=2Gsy=OW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F779C65BAE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Dec 2018 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C2720851
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Dec 2018 23:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nestlabs.com header.i=@nestlabs.com header.b="Pe+unJua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nestlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeLMXNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:13:39 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37262 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLMXNj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Dec 2018 18:13:39 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so6614140iti.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Dec 2018 15:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nestlabs.com; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=MSCAsnhrA6JtQOilm5SULhh9LF4MdKjYnVO9EpUYO7Y=;
        b=Pe+unJuaNDhBvGldCnZLRh9Ev7Fl7M9b0dI0ytyZF2C8Q/zIxKfiIXrj3B7Sj8i8v5
         tq1t+LyaD/t0IUcE4oczXLe+rDheA3QPPkBkSVQyCdoJIexKt+yq2cJQqZxPhivKeJrR
         YUO7t3UiBJooDzY30RvlZs/hpmLJV/mwk8jUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=MSCAsnhrA6JtQOilm5SULhh9LF4MdKjYnVO9EpUYO7Y=;
        b=ujbalXJzlGSOs/MYP+PMlVeTiqoCHv/UFTWlTsWQ8nFbDCMVxhWyHFx1qRgSA7p2Ae
         TDnLrZxOrSXtMf+R3zzMX2iXbBecTL5u/rnA36gEbDKA4FelrCsQUDrGtjwGSpXNWWlM
         xVr06BpS0yhfxK8RlEbbpuY4YPeD3OJvxWsCyJhmXKUe46AgSSHnWGBceD2kPTvkptHm
         gS+/4pDNBkTU+CYlxYSsGFcXxEbw+sgbIC9CjwQaWGBt//t67vcLRKn+h/MqCyhxk8ZP
         WGyq6TP7hxib/GzCIT89XhrG5HHGu3kJg+kpJ+/ovopHcwjpOhqxsRjpDCMhHeXv43rQ
         WI1Q==
X-Gm-Message-State: AA+aEWbNn6UbP9b6omVB4pn8lj1WZO+THaNO8ZWYYSbu8EdnqYZXJlY1
        /pPvN39mqMOwSiKQhQxxh05l3jUzVLMo5nOW5v4nBA==
X-Google-Smtp-Source: AFSGD/VYXLn5tbqQyt5BZgvlI4a+UEgZm6/XyJC0CY59pZxAkQ88mvnIIqG5C3KyRtSg5hsq6vSns3WFG+LwZH24qoc=
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr1202898ite.72.1544742817825;
 Thu, 13 Dec 2018 15:13:37 -0800 (PST)
MIME-Version: 1.0
References: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
 <CALvjcs9iYvgxN4YWzirw_Fxx30cDKYCyir+ZmpgsuBvcTJN+Zg@mail.gmail.com>
 <CABBYNZLPeHRWcG78USDYHL6zzw392JuefRaD9S_+RuXhDQ9ZCw@mail.gmail.com>
 <CAOOu1=BiJ9VjiMXiiPuXb=4cu-62OYmT+h1Z83ip440KwSpeAw@mail.gmail.com> <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com>
In-Reply-To: <CALvjcs8wE7ntp6F23ALKU_3=CziqHgQ1OGgqdqO299sMoeKamQ@mail.gmail.com>
Reply-To: yunhanw@nestlabs.com
From:   Yunhan Wang <yunhanw@nestlabs.com>
Date:   Thu, 13 Dec 2018 15:13:26 -0800
Message-ID: <CALvjcs9jRvfb6uFN5BZx26Nh3ojwL5S_Bt08Q72aHPjZUZTtUA@mail.gmail.com>
Subject: Re: BLE advertisement re-enabling after ble connection goes away
To:     Martin Turon <mturon@google.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz

Rephrasing a little bit..

From what you describes, it seems Bluez is taking the responsibility
to reenable the advertisement in peripheral side after the previous
ble connection goes
away.

When I did local test, the ble peripheral is using bluez, I create
gatt server and ble advertisment using Bluez DBus API,  when remote
connection in central disconnects, I see kernel in Bluez in peripheral
side do receive
HCI_EV_DISCONN_COMPLETE event, and trigger
hci_req_reenable_advertising.

Maybe you can share the code location where Bluez is reenabling the
advertisement after ble connection goes away?

Thanks
Best wishes
On Thu, Dec 13, 2018 at 3:10 PM Yunhan Wang <yunhanw@nestlabs.com> wrote:
>
> Hi, Luiz
>
> From what you describes, it seems Bluez is taking the responsibility
> to reenable the advertisement after the previous ble connection goes
> away.
>
> When I did local test, the ble peripheral is using bluez, I create
> gatt server and ble advertisment using Bluez DBus API,  when remote
> connection in central disconnects, I see kernel in Bluez do receive
> HCI_EV_DISCONN_COMPLETE event, and trigger
> hci_req_reenable_advertising.
>
> Maybe you can share the code location where Bluez is reenabling the
> advertisement after ble connection goes away?
>
> Thanks
> Best wishes
> Yunhan
>
> On Thu, Dec 13, 2018 at 2:30 PM Martin Turon <mturon@google.com> wrote:
> >
> > Hi Luiz,
> >
> > Is this behavior also expected on raw hci sockets?  Because my observat=
ion is that when working with raw hci over such sockets, auto-reenable does=
 not occur.
> >
> >     #define BTPROTO_HCI                 1
> >     #define HCI_CHANNEL_USER         1
> >
> >     struct sockaddr_hci shci;
> >     shci.hci_family =3D AF_BLUETOOTH;
> >     shci.hci_dev =3D s_ble_hci_device;
> >     shci.hci_channel =3D HCI_CHANNEL_USER;
> >
> >     s =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> >     rc =3D bind(s, (struct sockaddr *)&shci, sizeof(shci));
> >
> > Also, which API allows the user to control the advertising instances yo=
u describe?  Are they automatically created by the kernel when HCI is sent =
to a raw socket to enable advertising?
> >
> > Thanks,
> > Martin
> >
> > _____________________________
> > Martin Turon  |  Google
> >
> >
> >
> > On Thu, Dec 13, 2018 at 1:49 PM Luiz Augusto von Dentz <luiz.dentz@gmai=
l.com> wrote:
> >>
> >> Hi Yunhan,
> >>
> >> The BlueZ API operates a bit different than HCI, it keeps re-enabling =
the advertisement if there is any instance active, but the user can stop th=
is by removing its instance once a connection is made, this is considered m=
ore convenient than having the user to reprogram the advertisement on every=
 disconnection.
> >>
> >> On Thu, 13 Dec 2018, 18:38 Yunhan Wang <yunhanw@nestlabs.com wrote:
> >>>
> >>> +Martin
> >>>
> >>> Hi, Luiz and Marcel
> >>>
> >>> When I take a look at the bluetooth code, it seems it is re-enabling
> >>> ble advertisement after ble connection goes away. Any idea?
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/tree/net/bluetooth/hci_event.c#n2634
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/tree/net/bluetooth/hci_event.c#n2712
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/tree/net/bluetooth/hci_request.c#n1386
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/tree/net/bluetooth/hci_request.c#n1734
> >>>
> >>> Thanks
> >>> Best wishes
> >>> Yunhan
> >>> On Wed, Dec 5, 2018 at 6:54 PM Yunhan Wang <yunhanw@nestlabs.com> wro=
te:
> >>> >
> >>> > Hi, Luiz and Marcel
> >>> >
> >>> > May I have a question on ble behavior on BLE re-advertisement?
> >>> >
> >>> > According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2, "The
> >>> > device shall remain in general discoverable mode until a connection=
 is
> >>> > established or the Host terminates the mode."
> >>> >
> >>> > There is no description on re-enabling the advertising "after"
> >>> > disconnection, so the responsibility for re-enabling the advertisin=
g
> >>> > is bluez or kernel or application code? In other words, does kernel=
 or
> >>> > bluez or application would re-enable the ble advertisement after bl=
e
> >>> > disconnection happens?
> >>> >
> >>> > Thanks
> >>> > Best wishes
> >>> > Yunhan.
