Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79DC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 00:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CAE20775
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 00:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIi2YU2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgDNASQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgDNASP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 20:18:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDBC0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 17:18:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q22so10656850ljg.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SYORaUyzNtGjVUHdp91K5K7+vEpNipDA37lvlEKh3cU=;
        b=TIi2YU2XQDrsprz0Nl+xn0Ny37appYZQRMh33ZCE0IYWWolKXc6nifLNh+lr9dURnM
         G8k4jpnFCj7G7LNOC3RAsOuyHm+PZwfFhi3uMCVL+sjpbguDCghplC1HE2vkqiPDC1Xo
         EBUNy/OwocELpS4LaBmA8ikcHR4EFyoRE9OAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SYORaUyzNtGjVUHdp91K5K7+vEpNipDA37lvlEKh3cU=;
        b=OiXiwuJ5lUw2zbeZR4ssHzPSrjEnx8qGJ0bwXsj5fmLIfaCqVhafHUe3ARI7GU62Tz
         awXeHqay78naUuJ3QO7NfojMVKRa1eCLkhIO30LGkeGOxvCiLx25zAGlUOdoJEBdQTG3
         bipDwSg7FSOIThKM+0OIpnO7PLW1Mau79IDUE6ZODeGL25fi1KpOpvQe8AcDJw6jw/MQ
         qLrCm5eHFl3jIbTWy/etWtpVTwsYSPBG5ezO/M1Lha4s7iPZfsFmU/PtCKdjwMe5VoSd
         VgEUyostGNCRM8mhakWJjBJ3lCLX6vhJmNdBHFWdCnUzH8w1yGv9Ze3GjwI8A7F+wvY5
         o68Q==
X-Gm-Message-State: AGi0PuZZ0hRTTlAqE+fNAbRv4G6f268pSxvld1ikrLkY2IHxQbrp+KCs
        ZWr5WHWbkKv2c8kbpz5sLTL6aQZRhN5G1M5rKvZriQ==
X-Google-Smtp-Source: APiQypLxcVl31d9kh++36aNf83ctCBALAPnFun0gqd7HJi/93Bfb+WveK3CfgwkGEYEglbYb/RedXaY68/+08Ma+cWo=
X-Received: by 2002:a2e:a37b:: with SMTP id i27mr3593131ljn.36.1586823492950;
 Mon, 13 Apr 2020 17:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org> <CACumGOKNb=KMV42QQ6a3hLLpSPZe5HM+xGxVwiU4qYf5pZdwmw@mail.gmail.com>
In-Reply-To: <CACumGOKNb=KMV42QQ6a3hLLpSPZe5HM+xGxVwiU4qYf5pZdwmw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 13 Apr 2020 17:18:01 -0700
Message-ID: <CABmPvSEG-fi09waO5OnovowrXhMR7P1JbBFfbQu8hhgh6bgQww@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc: Add Advertisement Monitoring API
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel and Luiz,

On Sat, Apr 11, 2020 at 12:23 AM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Miao, Marcel,
>
> On Fri, Apr 10, 2020 at 12:47 AM Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>>
>> > +Properties   uint8 FilterType [read-only]
>> > +
>> > +                     This can be the following values. More will be a=
dded.
>> > +                     0x01 - Patterns with OR logic relation
>
>
> We already have Filter in interface name so I guess we can go with just T=
ype.
Sounds good to me.
>
>>
>> > +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers =
[read-only, optional]
>> > +
>> > +                     The contains HighRSSIThreshold, HighRSSIThreshol=
dTimer,
>> > +                     LowRSSIThreshold, LowRSSIThresholdTimer in order=
. The
>> > +                     unit of HighRSSIThreshold and LowRSSIThreshold i=
s dBm.
>> > +                     The unit of HighRSSIThresholdTimer and
>> > +                     LowRSSIThresholdTimer is second.
>> > +
>> > +                     A device is considered in-range when the RSSIs o=
f the
>> > +                     received advertisement(s) during HighRSSIThresho=
ldTimer
>> > +                     seconds exceed HighRSSIThreshold. Likewise, a de=
vice is
>> > +                     considered out-of-range when the RSSIs of the re=
ceived
>> > +                     advertisement(s) during LowRSSIThresholdTimer do=
 not
>> > +                     reach LowRSSIThreshold.
>> > +
>> > +             array{(uint8, uint8, string)} Patterns [read-only, optio=
nal]
>> > +
>> > +                     If =E2=80=9CPatternsWithORLogicRelation=E2=80=9D=
 is supported, this must
>> > +                     exist and has at least one entry in the array.
>> > +
>> > +                     The structure of a pattern contains the followin=
g.
>> > +                     uint8 start_position
>> > +                             The index in an AD data field where the =
search
>> > +                             should start. The beginning of an AD dat=
a field
>> > +                             is index 0.
>> > +                     uint8 AD_data_type
>> > +                             See https://www.bluetooth.com/specificat=
ions/
>> > +                             assigned-numbers/generic-access-profile/=
 for
>> > +                             the possible allowed value.
>> > +                     string content_of_pattern
>> > +                             This is the value of the pattern.
>>
>> This part I would provide as dict to the RegisterMonitor method (see bel=
ow).
>>
>> > +
>> > +Advertisement Monitor hierarchy
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> > +Service              org.bluez
>> > +Interface    org.bluez.AdvertisementMonitor1
>> > +Object path  /org/bluez/{hci0,hci1,...}
>>
>> If we follow our current style then it would be org.bluez.AdvertismentMo=
nitorManager.
>>
>> While writing this email so far, I am kinda tempted to call it org.bluez=
.DeviceMonitorManager and org.bluez.DeviceMonitor. It is just a temptation =
at this point and it is good to sleep about it for a bit.
>>
>> > +
>> > +Methods              void RegisterApplication(object filter)
>> > +
>> > +                     This registers a job of monitoring advertisement=
 in a
>> > +                     power efficient way. Based on the content of the=
 filter
>> > +                     upon registration, the filter object can expect =
to
>> > +                     receive the matched advertisements via DeviceInR=
ange()
>> > +                     and AdvertisementReceived().
>>
>> RegisterMonitor(object monitor, dict thresholds, dict filter)
>>
>> Having the thresholds and the filters as dicts here make it clear that y=
ou have to destroy the monitor and create a new one of you want to change t=
hem. I think that is acceptable and in the end an easy task, since you stil=
l can reuse the object monitor that you have already set up. It also make t=
he code for bluetoothd simpler since it doesn=E2=80=99t have to track life =
changes to the filters and act on them.
>
>
> Actually I rather not do this since there could multiple filters being re=
gistered not just a single object, if is quite a pain if we would need to b=
uild an array that matches the listing of ObjectManagers which might get ve=
ry tricky for the client to do properly since some of them actually use a h=
ash table for the objects which may reorder them, with our dbus client is n=
ot that difficult to update the filters if they change so Id just let the c=
lient change while registered so we don't have to unregister/register the w=
hole object tree if there are updates.
My understanding here is that only one monitor (this is in fact a
filter - which we have been using from the very beginning, and Marcel
suggested to rename it to monitor) can be registered via
RegisterMonitor at a time, and there can be multiple filtering
conditions (such as UUID and other AD data type) within a monitor
depending on the type of the monitor.
My concern with providing filtering conditions as a dictionary is that
it cannot be extended to adopt logical relation among filter
conditions later. For simplicity, we probably don't want to allow an
application to update filter and expect the changes would be reflected
right away (once HCI vendor extensions are in place, this can be
expensive), so we honor whatever filtering conditions read from the
monitor upon RegisterMonitor().
>
>>
>>
>> > +
>> > +             void UnregisterApplication(filter object)
>> > +
>> > +                     This unregisters the job of monitoring advertise=
ment.
>> > +                     The filter object can expect to be called on Rel=
ease()
>> > +                     once the removal is done.
>> > +
>> > +             void UnregisterAllApplications()
>> > +
>> > +                     This unregisters all jobs of monitoring advertis=
ement.
>> > +                     All filter objects can expect to be called on Re=
lease()
>> > +                     once the removals are done.
>>
>> I would rather not have an UnregisterAll. We didn=E2=80=99t need it unti=
l now and the object monitor was always bound to the lifetime of the applic=
ation.
>
>
> Actually we just need one method with ObjectManager which would remove th=
e entire root tree of objects, removing just a single filter is just a matt=
er of emitting InterfacesRemoved, same thing if you want to add another fil=
ter just emit InterfacesAdded with the new filter, we can either use the Re=
lease or a dedicate methot to notify if the filter is malformed or somethin=
g like that.
I'd rather have this interface work the same as the Advertising API,
since we need to report failures upon registering an ADV monitor, e.g.
there may be no resources to allocate HW filtering or maybe the
filtering conditions cannot be fulfilled.
>
>>
>>
>> > +
>> > +Properties   array{string} SupportedFilteringFeatures [read-only]
>> > +
>> > +                     This reflects the supported features of advertis=
ement
>> > +                     monitoring. An application should check this bef=
ore
>> > +                     instantiate an object of org.bluez.Advertisement=
Filter1.
>> > +
>> > +                     Here are the potential features. More will be ad=
ded.
>> > +                     "SoftwareBasedFiltering"
>> > +                     "PatternsWithORLogicRelation"
>> > +                     =E2=80=9CRSSIMonitoring=E2=80=9D
>>
>> So all our string values are lower-case and if needed we use - to separa=
te words or logical details.
>>
>> I think exposing a good interface for selecting the filter patterns will=
 take a bit. I would like to focus on getting the surrounding framework fig=
ured out first.
>>
>> Before finalizing an API, my test was always to write a simple client an=
d check if it meets the requirement for being simple enough. If it becomes =
cumbersome for the client, then we need to consider putting some of the mor=
e complicated parts into bluetoothd.
>>
>> Let me try to give an example. If the majority of the clients just want =
to find a device with UUID 0xFE23, then we should have a special casing for=
 that.
>>
>>         RegisterMonitor(monitor, dict{MatchUUID=3D0xFE23}).
>>
>> Done. That they have to differentiate between one vendors way of doing t=
his compared to another on how to provide the information should be up to b=
luetoothd to figure it out (and yes, I know it is not as simple when the AD=
 type is a list).
>>
>
> Im a little confused here, doesn't there need to match the filter Type? T=
hat would be much simpler for the client then to know what filter it would =
be able to register, then we can go with SupportedFilterTypes which would e=
numerate whatever possible values for filter types.
There are basically two ways how we can register an ADV monitor.
(1) RegisterMonitor(object monitor)
The monitor object would have properties that represent the type of
filter, the filtering conditions, RSSI thresholds and their timers.
It's more flexible to have properties representing criteria for filtering.
(2) RegisterMonitor(object monitor, dict thresholds, dict filter)
The monitor object would not have any property at all. This enforces
the no-reuse policy on an ADV monitor by not providing any property to
update. However, this does not fulfill the future use cases where the
filtering can be more complex.
Other the topic on what parameters we should send along with
DeviceFound(), this is the other blocker for settling the API.
Approach (1) seems to be the right way to go, what do you think?

Thanks,
Miao
