Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2674BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E5C610E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbhKHXAO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKHXAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 18:00:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538FC061570
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 14:57:29 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t13so19440566uad.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8gvudBlq00RPJx0RI3bC28Axhgn2KcupwJb79TPX3AQ=;
        b=I9os+Ykxr3MhVXaStRof8lxye/gpR6HtlZCAL60ZWzhX4tbOaO8lW63nJ0UVOROYjl
         D37r3ieep0ldXj4hX4nXWPWr4LfmzYAVIgiaL1PzQSLsJ3Wz+3S/sEg2UBPej6uu64/A
         IngVSKA2sTFcCGot/T6vdUFW8BKuXQ7uT9D3oqW2SWACmzkD+Zz5UA7N21hAHFxqaGpK
         EZc9SYBpRO2N2TiLUJlxpyS+qdjC2E9Ibxv0uJ5ZeAxq7PWCZLbhqWr4Zk/AuEqD40Sz
         Tb5xpTH5ax4bAETgYcsiivz1aVdJQcF9z/HSGEJyLIuNerW6dt0BiXhjwPQ3Hncm4rkY
         4qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8gvudBlq00RPJx0RI3bC28Axhgn2KcupwJb79TPX3AQ=;
        b=HgD20Yb6bipNcJee3fpSnXA2nC/Dm7locIxDMwRJlCl+0ec59B0V2hiPjLF1F7s3o7
         QxBCH9D9KaEI0dmMaheeiHgfR7N3dNrYVQr+XOh3VI2rKjGnYTdYc8HDTrm0R1tfy3Nz
         WUBh1RMNCPYFqUDcNJETEIRs9fdX4DDhY8q8M3OO074zc2cJa0YM2UYi52P31zaG1kJl
         eYWLIG5ehbjgj7xMw616ujuc7+dBlI0PA0XOajhQqV+ZBWOxe9HFNz8bd/izFwt9pUPt
         k0Ds5x34yURw9XYwXL3pIZxntrOyQSlBC4NS5T2eBx1eHlSQmZPmrZ20japUngcz7qs4
         x7tQ==
X-Gm-Message-State: AOAM533QMp5GGZbRGHPe6qAlHGfJXRfR2C8uq2Fa96d0G+5oEX1yyCHl
        n2B6sVrTCahONJY1FmpAovGYGLb5cQLhFR8C6AI=
X-Google-Smtp-Source: ABdhPJwrsM31MfCPZLsmm31eGTjcnpT58TUXKWsfEnvezXxVHg8BJz+Gx72ME/xLW5FQLwFDTeHFv6TdBrpIGcxAhDg=
X-Received: by 2002:a67:b844:: with SMTP id o4mr111423794vsh.61.1636412248110;
 Mon, 08 Nov 2021 14:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20211025191811.3575708-1-mmandlik@google.com> <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <577458A3-49B9-416B-A35B-58F174CC88F8@holtmann.org> <CAGPPCLBNN+Eg92=GnmbMBfngLEb=BL6sSkx7O19rYOydAkO8HA@mail.gmail.com>
 <BACB0D21-AB8E-47F2-8CAC-B5E574B8A85C@holtmann.org> <CAGPPCLD+pYQtK8G303gr_F7xqTvuSXA+4FTRiVf0OzAEUrDgjw@mail.gmail.com>
In-Reply-To: <CAGPPCLD+pYQtK8G303gr_F7xqTvuSXA+4FTRiVf0OzAEUrDgjw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Nov 2021 14:57:17 -0800
Message-ID: <CABBYNZLnjgizrau7qYWsHfhW+6eg_goSCLubXe13t+zng+GUsw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 1/3] doc: Introduce the Adv Monitor Device
 Found/Lost events
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Sun, Oct 31, 2021 at 10:53 PM Manish Mandlik <mmandlik@google.com> wrote=
:
>
> Hi Marcel,
>
>
> On Tue, Oct 26, 2021 at 4:33 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
>>
>> Hi Manish,
>>
>> > >
>> > > Example
>> > > @@ -4910,3 +4911,50 @@ Controller Resume Event
>> > >       Address_Type. Otherwise, Address and Address_Type will both be=
 zero.
>> > >
>> > >       This event will be sent to all management sockets.
>> > > +
>> > > +
>> > > +Advertisement Monitor Device Found Event
>> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > +
>> > > +     Event code:             0x002f
>> > > +     Controller Index:       <controller_id>
>> > > +     Event Parameters:       Monitor_Handle (2 Octets)
>> > > +                             Address (6 Octets)
>> > > +                             Address_Type (1 Octet)
>> > > +
>> > > +     This event indicates that the controller has started tracking =
a device
>> > > +     matching an Advertisement Monitor with handle Monitor_Handle.
>> > > +
>> > > +     The address of the device being tracked will be shared in Addr=
ess and
>> > > +     Address_Type.
>> > > +
>> > > +     Possible values for the Address_Type parameter:
>> > > +             0       Reserved (not in use)
>> > > +             1       LE Public
>> > > +             2       LE Random
>> > > +
>> > > +     This event will be sent to all management sockets.
>> >
>> > My initial thought was actually to include all the fields from Device =
Found Event here as well. So that in case we are using advertising monitor,=
 we just need to worry about this event only. Thoughts?
>> > The controller sends advertising reports in addition to the MSFT_Monit=
or_Device event. This event is reported only twice per bt-device (at start =
and at end of the monitoring); and it includes only the device addr and add=
r type [1]. To include other fields from the Device Found event, we need to=
 buffer MSFT_Monitor_Device in the kernel and wait for the subsequent adver=
tising report before we can send it to the bluetoothd. I feel this will unn=
ecessarily complicate the logic in the kernel.
>> >
>> > This event will be used to invoke DeviceFound/Lost on the interface on=
ly when we are completely offloading monitoring to the controller (i.e. whe=
n the Sampling_Period is set to 0xFF). When the Sampling_Period is set to 0=
xFF, the controller sends only one advertisement report per monitoring peri=
od [2]. So, we need to rely on the MSFT_Monitor_Device controller event for=
 RSSI and timeouts tracking. In other cases, as the bluetoothd receives mor=
e than one advertisement report, it can perform RSSI and timeouts tracking.
>> >
>> > So, I think it is better to pass on this event as it is to the bluetoo=
thd and let the advertisement monitoring in the bluetoothd handle it. Let m=
e know what you think about this?
>>
>> the kernel has to buffer events related to advertising reports and inqui=
ry results already anyway. That is just the cost of business and it is the =
job of the kernel to do exactly that.
>>
>> I do not want to dumb down the kernel into a vendor extension passthroug=
h since that is always going to come back and bite you. My current thinking=
 is actually that unless Start Discovery triggers a discovery procedure, de=
vice that are monitored, should get its own report out path via mgmt.
>>
>> So the kernel would send Advertising Monitor Device Found Event (most li=
kely with a flag for tracking started) and subsequence events of the same t=
ype whenever it gets updated. I mean, the kernel should track the state whe=
n a device is tracked anyway. It has to keep track of these things. In case=
 of power down or reset or anything, the kernel needs to generate the Devic=
e Lost event to keeps this all in sync. Otherwise userspace is left to figu=
re out what happens. We can not have that. This is similar to when a proces=
s dies, the kernel cleans up all open file descriptors. That is the basic p=
aradigm that we have enforced with mgmt. If bluetoothd dies or restarts, we=
 can get back to a state where we now all the details without having to har=
d reset hardware.
>>
>> One way to lock at this is always from the point of something that is no=
t bluetoothd. Any other user of mgmt API needs to be sound and have a good =
API contract as well. Kernel APIs that are only designed with one daemon in=
 mind are awful and cause major problems along the road.
>>
>> That all said, we can do this as above, but I would explore the option o=
f doing it with my proposal and really focus on completely offload of the m=
onitoring the controller.
>
>
> Thanks for the explanation. I see your point. Based on that I=E2=80=99d l=
ike to propose the following changes to the bluetooth kernel and user space=
 to take all the advantages of the controller offloading whenever available=
. Let me know if it sounds good?
>
> Existing controller behavior (based on the MSFT extension specification):
> - Whenever the controller starts monitoring a device, it first sends the =
MSFT_Monitor_Device event with Monitor_State as 1 and provides the matched =
Monitor_Id and device address.
> - Based on the Sampling_Period configured, it then sends one or more LE A=
dvertisement Reports for that device during the monitoring period.
> - Whenever the controller stops monitoring a device, it again sends the M=
SFT_Monitor_Device event but with Monitor_State as 0 and provides the Monit=
or_Id and device address of the device that was being tracked.
>
> Proposed kernel behavior:
> - Upon receipt of the MSFT_Monitor_Device event with Monitor_State 1, the=
 kernel will buffer this event until it receives the subsequent LE Advertis=
ement Report(s).
> - After receiving the first advertisement report for the monitored device=
, kernel will generate the =E2=80=9CAdv Monitor Device Found=E2=80=9D MGMT =
event which is identical to the =E2=80=9CDevice Found=E2=80=9D MGMT event, =
but will have additional Monitor_Handle information for the matched monitor=
.
> - A separate Device_Tracked flag is not required since this event itself =
indicates that the device is being tracked.
> - If the active scanning is in progress, the existing =E2=80=9CDevice Fou=
nd=E2=80=9D event will also be generated before generating the =E2=80=9CAdv=
 Monitor Device Found=E2=80=9D event.
> - For the subsequent advertisement reports (if any) for the monitored dev=
ice, if the active scanning is in progress, only the existing "Device Found=
" event will be generated; else, only the "Adv Monitor Device Found" event =
will be generated.
> - Upon receipt of the MSFT_Monitor_Device event with Monitor_State 0, the=
 kernel will generate the =E2=80=9CAdv Monitor Device Lost=E2=80=9D MGMT ev=
ent with the Monitor_Handle and device address of the device that was being=
 tracked.
> - Also, in case of power down or reset, the kernel will generate the "Adv=
 Monitor Device Lost" event for the monitored devices.
>
> Proposed user space behavior:
> - Whenever the controller offloading is available, bluetoothd will only u=
se the =E2=80=9CAdv Monitor Device Found=E2=80=9D and =E2=80=9CAdv Monitor =
Device Lost=E2=80=9D event for performing monitoring related functions and =
SW based filtering will be completely disabled as Monitor_Handle will be av=
ailable from the kernel/controller and can be used to notify respective app=
lications on DeviceFound/DeviceLost.
> - Whenever the controller offloading is NOT available, bluetoothd will us=
e the existing =E2=80=9CDevice Found=E2=80=9D event and perform SW based fi=
ltering as it is doing right now.
> - =E2=80=9CAdv Monitor Device Found=E2=80=9D event will also be used to c=
reate/update the found device when active scanning is NOT in progress.

Are you still working on this or are you waiting for some feedback on
the above, at first glance it looks proper. Btw, it would be great if
these changes are accompanied with mgmt-tester tests since vhci has
support for MSFT commands and we can emulate such code paths.


--=20
Luiz Augusto von Dentz
