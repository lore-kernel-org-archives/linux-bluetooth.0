Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 06:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA74360F4B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhKIGe5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 01:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhKIGe4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 01:34:56 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D0C061764
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 22:32:11 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id d128so9470200vkf.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 22:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8LkVbf7Qz+nfDocsjC44BU9UQQZoI90SxiIeryZmLVE=;
        b=gOrUOMlB1597rubKcZx/jzn7UMFY5F9AGUtZD8GjHaHzXb/gKl0QNZ5IZlQY7tSpDk
         kno4ykt3JmTbcuH5QrttBaRHr1pUt7x6+Sx3iHa5U1SivgKSN1fBo9IV7HM9iUIwiplB
         FWPk/5OZ+0vz8xYOGZxT7VbstmlbiHJV5ycmk+NzTW+dqsPYsl8BYhv5pqu99NMGA4hM
         /J6Je/AKvb78I0OhKzW3gqnIWvqQFG52OhcyNALW/+Ufeeadh/J8LLKnbcFLEKurA6bN
         Zy8gY09OX2SYMtcx2UIIPWvi52aBSgKKP6tiZIsmPTu3hVNRfugJSpds/bHq5IC6mEKM
         gJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8LkVbf7Qz+nfDocsjC44BU9UQQZoI90SxiIeryZmLVE=;
        b=CvqJXXvzERKtMnsaR6xCY7AV1PlV6zKr5uFtOEGV+ndw7xslZFU2/3/Burud8xojQT
         WF31mMhyHPdxpTBeXVDlzTniULrMvCcDjmGyQebPhvwxoOLv9ry8gIpTclXUaqELmT3W
         FapUyj1x2qQMFji2XHF7XPc/+EXv9a5zO1xIYU6FoCjnkaYg2yjuW14W8k9l+431nWy7
         4lNzn6nYEk7iF0aAjPpYqrBzVEYCXh1VKi6Hr6PImu8yzSIEv7K9HJsfX9DJcKClC9N/
         54JWXlr1aoY01KYcrohGHspqSA7QPU+M4JVifavbSP0GAthp9x8cV67ndsMhGcLn4wZM
         Y9Qg==
X-Gm-Message-State: AOAM532DM27v+gLHkRb4u7kGZj2BMSCieBw4KNUUzl9RhD3FdKrqQvoj
        d0u733DJgV7KYozgJKZIvRFiXF3BdIOxoQbYVkpVnnao
X-Google-Smtp-Source: ABdhPJzCFAGp9yHYNGVeaKA05PjKRBJlFzojDzfpH6yN0heyBPP3X70cg96Qe+4kSjpV8fEPh0xpvJ0nX+5egP7yZ3Q=
X-Received: by 2002:a05:6122:d05:: with SMTP id az5mr30100651vkb.9.1636439529749;
 Mon, 08 Nov 2021 22:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20211025191811.3575708-1-mmandlik@google.com> <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <577458A3-49B9-416B-A35B-58F174CC88F8@holtmann.org> <CAGPPCLBNN+Eg92=GnmbMBfngLEb=BL6sSkx7O19rYOydAkO8HA@mail.gmail.com>
 <BACB0D21-AB8E-47F2-8CAC-B5E574B8A85C@holtmann.org> <CAGPPCLD+pYQtK8G303gr_F7xqTvuSXA+4FTRiVf0OzAEUrDgjw@mail.gmail.com>
 <CABBYNZLnjgizrau7qYWsHfhW+6eg_goSCLubXe13t+zng+GUsw@mail.gmail.com> <CAGPPCLBAwp=64hysCeagLQDrwK5b7_nUGS73XB0eDgsGL7yAsQ@mail.gmail.com>
In-Reply-To: <CAGPPCLBAwp=64hysCeagLQDrwK5b7_nUGS73XB0eDgsGL7yAsQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Nov 2021 22:31:58 -0800
Message-ID: <CABBYNZKEYLOy0XKhf=yzyUwEA6ASBRhMBrc8Z8QP4qHs+yff0Q@mail.gmail.com>
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

On Mon, Nov 8, 2021 at 9:30 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Hi Luiz,
>
> On Mon, Nov 8, 2021 at 5:57 PM Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
>>
>> Hi Manish,
>>
>> On Sun, Oct 31, 2021 at 10:53 PM Manish Mandlik <mmandlik@google.com> wr=
ote:
>> >
>> > Hi Marcel,
>> >
>> >
>> > On Tue, Oct 26, 2021 at 4:33 AM Marcel Holtmann <marcel@holtmann.org> =
wrote:
>> >>
>> >> Hi Manish,
>> >>
>> >> > >
>> >> > > Example
>> >> > > @@ -4910,3 +4911,50 @@ Controller Resume Event
>> >> > >       Address_Type. Otherwise, Address and Address_Type will both=
 be zero.
>> >> > >
>> >> > >       This event will be sent to all management sockets.
>> >> > > +
>> >> > > +
>> >> > > +Advertisement Monitor Device Found Event
>> >> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > > +
>> >> > > +     Event code:             0x002f
>> >> > > +     Controller Index:       <controller_id>
>> >> > > +     Event Parameters:       Monitor_Handle (2 Octets)
>> >> > > +                             Address (6 Octets)
>> >> > > +                             Address_Type (1 Octet)
>> >> > > +
>> >> > > +     This event indicates that the controller has started tracki=
ng a device
>> >> > > +     matching an Advertisement Monitor with handle Monitor_Handl=
e.
>> >> > > +
>> >> > > +     The address of the device being tracked will be shared in A=
ddress and
>> >> > > +     Address_Type.
>> >> > > +
>> >> > > +     Possible values for the Address_Type parameter:
>> >> > > +             0       Reserved (not in use)
>> >> > > +             1       LE Public
>> >> > > +             2       LE Random
>> >> > > +
>> >> > > +     This event will be sent to all management sockets.
>> >> >
>> >> > My initial thought was actually to include all the fields from Devi=
ce Found Event here as well. So that in case we are using advertising monit=
or, we just need to worry about this event only. Thoughts?
>> >> > The controller sends advertising reports in addition to the MSFT_Mo=
nitor_Device event. This event is reported only twice per bt-device (at sta=
rt and at end of the monitoring); and it includes only the device addr and =
addr type [1]. To include other fields from the Device Found event, we need=
 to buffer MSFT_Monitor_Device in the kernel and wait for the subsequent ad=
vertising report before we can send it to the bluetoothd. I feel this will =
unnecessarily complicate the logic in the kernel.
>> >> >
>> >> > This event will be used to invoke DeviceFound/Lost on the interface=
 only when we are completely offloading monitoring to the controller (i.e. =
when the Sampling_Period is set to 0xFF). When the Sampling_Period is set t=
o 0xFF, the controller sends only one advertisement report per monitoring p=
eriod [2]. So, we need to rely on the MSFT_Monitor_Device controller event =
for RSSI and timeouts tracking. In other cases, as the bluetoothd receives =
more than one advertisement report, it can perform RSSI and timeouts tracki=
ng.
>> >> >
>> >> > So, I think it is better to pass on this event as it is to the blue=
toothd and let the advertisement monitoring in the bluetoothd handle it. Le=
t me know what you think about this?
>> >>
>> >> the kernel has to buffer events related to advertising reports and in=
quiry results already anyway. That is just the cost of business and it is t=
he job of the kernel to do exactly that.
>> >>
>> >> I do not want to dumb down the kernel into a vendor extension passthr=
ough since that is always going to come back and bite you. My current think=
ing is actually that unless Start Discovery triggers a discovery procedure,=
 device that are monitored, should get its own report out path via mgmt.
>> >>
>> >> So the kernel would send Advertising Monitor Device Found Event (most=
 likely with a flag for tracking started) and subsequence events of the sam=
e type whenever it gets updated. I mean, the kernel should track the state =
when a device is tracked anyway. It has to keep track of these things. In c=
ase of power down or reset or anything, the kernel needs to generate the De=
vice Lost event to keeps this all in sync. Otherwise userspace is left to f=
igure out what happens. We can not have that. This is similar to when a pro=
cess dies, the kernel cleans up all open file descriptors. That is the basi=
c paradigm that we have enforced with mgmt. If bluetoothd dies or restarts,=
 we can get back to a state where we now all the details without having to =
hard reset hardware.
>> >>
>> >> One way to lock at this is always from the point of something that is=
 not bluetoothd. Any other user of mgmt API needs to be sound and have a go=
od API contract as well. Kernel APIs that are only designed with one daemon=
 in mind are awful and cause major problems along the road.
>> >>
>> >> That all said, we can do this as above, but I would explore the optio=
n of doing it with my proposal and really focus on completely offload of th=
e monitoring the controller.
>> >
>> >
>> > Thanks for the explanation. I see your point. Based on that I=E2=80=99=
d like to propose the following changes to the bluetooth kernel and user sp=
ace to take all the advantages of the controller offloading whenever availa=
ble. Let me know if it sounds good?
>> >
>> > Existing controller behavior (based on the MSFT extension specificatio=
n):
>> > - Whenever the controller starts monitoring a device, it first sends t=
he MSFT_Monitor_Device event with Monitor_State as 1 and provides the match=
ed Monitor_Id and device address.
>> > - Based on the Sampling_Period configured, it then sends one or more L=
E Advertisement Reports for that device during the monitoring period.
>> > - Whenever the controller stops monitoring a device, it again sends th=
e MSFT_Monitor_Device event but with Monitor_State as 0 and provides the Mo=
nitor_Id and device address of the device that was being tracked.
>> >
>> > Proposed kernel behavior:
>> > - Upon receipt of the MSFT_Monitor_Device event with Monitor_State 1, =
the kernel will buffer this event until it receives the subsequent LE Adver=
tisement Report(s).
>> > - After receiving the first advertisement report for the monitored dev=
ice, kernel will generate the =E2=80=9CAdv Monitor Device Found=E2=80=9D MG=
MT event which is identical to the =E2=80=9CDevice Found=E2=80=9D MGMT even=
t, but will have additional Monitor_Handle information for the matched moni=
tor.
>> > - A separate Device_Tracked flag is not required since this event itse=
lf indicates that the device is being tracked.
>> > - If the active scanning is in progress, the existing =E2=80=9CDevice =
Found=E2=80=9D event will also be generated before generating the =E2=80=9C=
Adv Monitor Device Found=E2=80=9D event.
>> > - For the subsequent advertisement reports (if any) for the monitored =
device, if the active scanning is in progress, only the existing "Device Fo=
und" event will be generated; else, only the "Adv Monitor Device Found" eve=
nt will be generated.
>> > - Upon receipt of the MSFT_Monitor_Device event with Monitor_State 0, =
the kernel will generate the =E2=80=9CAdv Monitor Device Lost=E2=80=9D MGMT=
 event with the Monitor_Handle and device address of the device that was be=
ing tracked.
>> > - Also, in case of power down or reset, the kernel will generate the "=
Adv Monitor Device Lost" event for the monitored devices.
>> >
>> > Proposed user space behavior:
>> > - Whenever the controller offloading is available, bluetoothd will onl=
y use the =E2=80=9CAdv Monitor Device Found=E2=80=9D and =E2=80=9CAdv Monit=
or Device Lost=E2=80=9D event for performing monitoring related functions a=
nd SW based filtering will be completely disabled as Monitor_Handle will be=
 available from the kernel/controller and can be used to notify respective =
applications on DeviceFound/DeviceLost.
>> > - Whenever the controller offloading is NOT available, bluetoothd will=
 use the existing =E2=80=9CDevice Found=E2=80=9D event and perform SW based=
 filtering as it is doing right now.
>> > - =E2=80=9CAdv Monitor Device Found=E2=80=9D event will also be used t=
o create/update the found device when active scanning is NOT in progress.
>>
>> Are you still working on this or are you waiting for some feedback on
>> the above, at first glance it looks proper. Btw, it would be great if
>> these changes are accompanied with mgmt-tester tests since vhci has
>> support for MSFT commands and we can emulate such code paths.
>
>
> Yes, I was waiting for the feedback. I wanted to run the above proposal b=
y you and Marcel before making the code changes. Thanks for the feedback, I=
'll also include the mgmt-tester tests.

Great, next time just send a reminder that you are waiting for
feedback since we may have just assume you had started working
already, or hadn't been following the exact progress on the mailing
list. Another alternative is to change the status on patchwork to
something like Needs ACK so we can perhaps run some scripts that
generate email or something.

>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Thanks,
> Manish.
>
>



--=20
Luiz Augusto von Dentz
