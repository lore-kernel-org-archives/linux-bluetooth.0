Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D67AC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 18:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201BF2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 18:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GnqcBNum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504334AbgDNSqq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504332AbgDNSqn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 14:46:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACEC061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 11:46:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r17so631917lff.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DjzLnujsvX5jbPSE15VS9CIwkJ0BDQmxShhu0sybmfk=;
        b=GnqcBNumg8IPDp5wRe1s2OY0FqQRfbZRTei8guC5HT3vZDNT6OHWvHB9AZXOm/8DkV
         52d4rYztdpaSlq4umXWyeP1bUL738M16D8s82BLZ7L+qK/sKHKsPA1G/WKYyrA9/gC4T
         UXgPUqFrhyEpsg9I5TBjKguF8GEh4461nEiak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DjzLnujsvX5jbPSE15VS9CIwkJ0BDQmxShhu0sybmfk=;
        b=PlWYTbUQkUN+ahy5pWcEuZl70NBPDh2yClgqO1EjU/IcSDzfPa1V3NNw/qMKUncadp
         2o/sOVu9ILzDMibC+Mz9sRsSh2YKjYq1WqvzVY/kd4dRqxXY9cH09cX8Nbq4aIWtxN1i
         BvBXFcFs/pO5PSh/qt53cYh6a+5p18BSqxlen+9Og0d5MOZlhZ39EebKu0xt1sbX3zn0
         +JID6ZRSQx1clGbgyhAz8LKJ0YnfBOtbPnStA/vW2Mji3xjVR1FHACo4I8ylinKUY2af
         G3/U4+vdAIBrDrlZZlSMa6yvjE0W1GF1FKRvocp3I6BJaGjCJ39SNBo5xCimz2MeWthm
         paVA==
X-Gm-Message-State: AGi0PuZxPWeDIDTLihuxwXrRHABmI/9XRr067IXDWcqCoTm9TcFAfJFF
        eLH9KyFrik/fl+TitxBS+7ZkHLoNqLoUGUlJNFfuBQ==
X-Google-Smtp-Source: APiQypKz3VJbw4WfKuXeVQQyBnYZx0fUD77y6yKXTHM1BN2Ny7X+aFgxIHVsFT1MZPVGk0zgvd5CcW3nZSvPuyACSrk=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr692570lfm.144.1586890001556;
 Tue, 14 Apr 2020 11:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org> <CACumGOKNb=KMV42QQ6a3hLLpSPZe5HM+xGxVwiU4qYf5pZdwmw@mail.gmail.com>
 <CABmPvSEG-fi09waO5OnovowrXhMR7P1JbBFfbQu8hhgh6bgQww@mail.gmail.com> <CACumGOJ5KNU23JUDTkDmOA+ja0omNViUEEMCj_=P8sr9x+VnMQ@mail.gmail.com>
In-Reply-To: <CACumGOJ5KNU23JUDTkDmOA+ja0omNViUEEMCj_=P8sr9x+VnMQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 14 Apr 2020 11:46:30 -0700
Message-ID: <CABmPvSEe6VmRGCdr-Yp-WOJxk1XMqm9_5Td4NHotDg5kW06t4A@mail.gmail.com>
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

Hi Luiz,

Please see my inline replies below.

On Mon, Apr 13, 2020 at 5:55 PM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Miao,
>
> On Mon, Apr 13, 2020 at 5:18 PM Miao-chen Chou <mcchou@chromium.org> wrot=
e:
>>
>> Hi Marcel and Luiz,
>>
>> On Sat, Apr 11, 2020 at 12:23 AM Von Dentz, Luiz
>> <luiz.von.dentz@intel.com> wrote:
>> >
>> > Hi Miao, Marcel,
>> >
>> > On Fri, Apr 10, 2020 at 12:47 AM Marcel Holtmann <marcel@holtmann.org>=
 wrote:
>> >>
>> >> > +Properties   uint8 FilterType [read-only]
>> >> > +
>> >> > +                     This can be the following values. More will b=
e added.
>> >> > +                     0x01 - Patterns with OR logic relation
>> >
>> >
>> > We already have Filter in interface name so I guess we can go with jus=
t Type.
>> Sounds good to me.
>> >
>> >>
>> >> > +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTime=
rs [read-only, optional]
>> >> > +
>> >> > +                     The contains HighRSSIThreshold, HighRSSIThres=
holdTimer,
>> >> > +                     LowRSSIThreshold, LowRSSIThresholdTimer in or=
der. The
>> >> > +                     unit of HighRSSIThreshold and LowRSSIThreshol=
d is dBm.
>> >> > +                     The unit of HighRSSIThresholdTimer and
>> >> > +                     LowRSSIThresholdTimer is second.
>> >> > +
>> >> > +                     A device is considered in-range when the RSSI=
s of the
>> >> > +                     received advertisement(s) during HighRSSIThre=
sholdTimer
>> >> > +                     seconds exceed HighRSSIThreshold. Likewise, a=
 device is
>> >> > +                     considered out-of-range when the RSSIs of the=
 received
>> >> > +                     advertisement(s) during LowRSSIThresholdTimer=
 do not
>> >> > +                     reach LowRSSIThreshold.
>> >> > +
>> >> > +             array{(uint8, uint8, string)} Patterns [read-only, op=
tional]
>> >> > +
>> >> > +                     If =E2=80=9CPatternsWithORLogicRelation=E2=80=
=9D is supported, this must
>> >> > +                     exist and has at least one entry in the array=
.
>> >> > +
>> >> > +                     The structure of a pattern contains the follo=
wing.
>> >> > +                     uint8 start_position
>> >> > +                             The index in an AD data field where t=
he search
>> >> > +                             should start. The beginning of an AD =
data field
>> >> > +                             is index 0.
>> >> > +                     uint8 AD_data_type
>> >> > +                             See https://www.bluetooth.com/specifi=
cations/
>> >> > +                             assigned-numbers/generic-access-profi=
le/ for
>> >> > +                             the possible allowed value.
>> >> > +                     string content_of_pattern
>> >> > +                             This is the value of the pattern.
>> >>
>> >> This part I would provide as dict to the RegisterMonitor method (see =
below).
>> >>
>> >> > +
>> >> > +Advertisement Monitor hierarchy
>> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > +Service              org.bluez
>> >> > +Interface    org.bluez.AdvertisementMonitor1
>> >> > +Object path  /org/bluez/{hci0,hci1,...}
>> >>
>> >> If we follow our current style then it would be org.bluez.Advertismen=
tMonitorManager.
>> >>
>> >> While writing this email so far, I am kinda tempted to call it org.bl=
uez.DeviceMonitorManager and org.bluez.DeviceMonitor. It is just a temptati=
on at this point and it is good to sleep about it for a bit.
>> >>
>> >> > +
>> >> > +Methods              void RegisterApplication(object filter)
>> >> > +
>> >> > +                     This registers a job of monitoring advertisem=
ent in a
>> >> > +                     power efficient way. Based on the content of =
the filter
>> >> > +                     upon registration, the filter object can expe=
ct to
>> >> > +                     receive the matched advertisements via Device=
InRange()
>> >> > +                     and AdvertisementReceived().
>> >>
>> >> RegisterMonitor(object monitor, dict thresholds, dict filter)
>> >>
>> >> Having the thresholds and the filters as dicts here make it clear tha=
t you have to destroy the monitor and create a new one of you want to chang=
e them. I think that is acceptable and in the end an easy task, since you s=
till can reuse the object monitor that you have already set up. It also mak=
e the code for bluetoothd simpler since it doesn=E2=80=99t have to track li=
fe changes to the filters and act on them.
>> >
>> >
>> > Actually I rather not do this since there could multiple filters being=
 registered not just a single object, if is quite a pain if we would need t=
o build an array that matches the listing of ObjectManagers which might get=
 very tricky for the client to do properly since some of them actually use =
a hash table for the objects which may reorder them, with our dbus client i=
s not that difficult to update the filters if they change so Id just let th=
e client change while registered so we don't have to unregister/register th=
e whole object tree if there are updates.
>> My understanding here is that only one monitor (this is in fact a
>> filter - which we have been using from the very beginning, and Marcel
>> suggested to rename it to monitor) can be registered via
>> RegisterMonitor at a time, and there can be multiple filtering
>> conditions (such as UUID and other AD data type) within a monitor
>> depending on the type of the monitor.
>> My concern with providing filtering conditions as a dictionary is that
>> it cannot be extended to adopt logical relation among filter
>> conditions later. For simplicity, we probably don't want to allow an
>> application to update filter and expect the changes would be reflected
>> right away (once HCI vendor extensions are in place, this can be
>> expensive), so we honor whatever filtering conditions read from the
>> monitor upon RegisterMonitor().
>
>
> You mean you can only have 1 filter object per application? I thought you=
 guys suggesting having more than one filter, I recall commenting that with=
 ObjectManager you will be able to register multiple objects at once and if=
 Im not mistaken this is kind a must have filter otherwise you will have to=
 register filter one by one and in each and every case update the filter at=
 HCI layer, meaning not only we have several rounds trips at D-Bus layer bu=
t also at HCI, my impression is that this would not scale well at startup b=
ecause that would make application all try to register their filters at onc=
e making the whole procedure quite slow, this is actually the reason we swi=
tch to use ObjectManager since GetManagedObjects packs every object registe=
red we can then register all filters in 1 single round-trip.
There was a misunderstanding here, and I'd glad you pointed out. Your
impression was correct that we propose to allow a D-Bus client to
register multiple monitors(filters), and my above comments were around
the function RegisterMonitor() where it only allows a client to
register one monitor. Indeed RegisterMonitor has the drawback you
pointed out, so using ObjectManager is better which I also agreed
with. However, I was concerned about how we inform the client about
whether its monitors were honored or not, since there is no existing
example. One option is to introduce an extra function in
org.bluez.AdvertisementMonitor1, perhaps Activate(), to indicate the
monitor was adopted, and Release() should be called to inform the
failures. What do you think?
>
>>
>> >
>> >>
>> >>
>> >> > +
>> >> > +             void UnregisterApplication(filter object)
>> >> > +
>> >> > +                     This unregisters the job of monitoring advert=
isement.
>> >> > +                     The filter object can expect to be called on =
Release()
>> >> > +                     once the removal is done.
>> >> > +
>> >> > +             void UnregisterAllApplications()
>> >> > +
>> >> > +                     This unregisters all jobs of monitoring adver=
tisement.
>> >> > +                     All filter objects can expect to be called on=
 Release()
>> >> > +                     once the removals are done.
>> >>
>> >> I would rather not have an UnregisterAll. We didn=E2=80=99t need it u=
ntil now and the object monitor was always bound to the lifetime of the app=
lication.
>> >
>> >
>> > Actually we just need one method with ObjectManager which would remove=
 the entire root tree of objects, removing just a single filter is just a m=
atter of emitting InterfacesRemoved, same thing if you want to add another =
filter just emit InterfacesAdded with the new filter, we can either use the=
 Release or a dedicate methot to notify if the filter is malformed or somet=
hing like that.
>> I'd rather have this interface work the same as the Advertising API,
>> since we need to report failures upon registering an ADV monitor, e.g.
>> there may be no resources to allocate HW filtering or maybe the
>> filtering conditions cannot be fulfilled.
>> >
>> >>
>> >>
>> >> > +
>> >> > +Properties   array{string} SupportedFilteringFeatures [read-only]
>> >> > +
>> >> > +                     This reflects the supported features of adver=
tisement
>> >> > +                     monitoring. An application should check this =
before
>> >> > +                     instantiate an object of org.bluez.Advertisem=
entFilter1.
>> >> > +
>> >> > +                     Here are the potential features. More will be=
 added.
>> >> > +                     "SoftwareBasedFiltering"
>> >> > +                     "PatternsWithORLogicRelation"
>> >> > +                     =E2=80=9CRSSIMonitoring=E2=80=9D
>> >>
>> >> So all our string values are lower-case and if needed we use - to sep=
arate words or logical details.
>> >>
>> >> I think exposing a good interface for selecting the filter patterns w=
ill take a bit. I would like to focus on getting the surrounding framework =
figured out first.
>> >>
>> >> Before finalizing an API, my test was always to write a simple client=
 and check if it meets the requirement for being simple enough. If it becom=
es cumbersome for the client, then we need to consider putting some of the =
more complicated parts into bluetoothd.
>> >>
>> >> Let me try to give an example. If the majority of the clients just wa=
nt to find a device with UUID 0xFE23, then we should have a special casing =
for that.
>> >>
>> >>         RegisterMonitor(monitor, dict{MatchUUID=3D0xFE23}).
>> >>
>> >> Done. That they have to differentiate between one vendors way of doin=
g this compared to another on how to provide the information should be up t=
o bluetoothd to figure it out (and yes, I know it is not as simple when the=
 AD type is a list).
>> >>
>> >
>> > Im a little confused here, doesn't there need to match the filter Type=
? That would be much simpler for the client then to know what filter it wou=
ld be able to register, then we can go with SupportedFilterTypes which woul=
d enumerate whatever possible values for filter types.
>> There are basically two ways how we can register an ADV monitor.
>> (1) RegisterMonitor(object monitor)
>> The monitor object would have properties that represent the type of
>> filter, the filtering conditions, RSSI thresholds and their timers.
>> It's more flexible to have properties representing criteria for filterin=
g.
>> (2) RegisterMonitor(object monitor, dict thresholds, dict filter)
>> The monitor object would not have any property at all. This enforces
>> the no-reuse policy on an ADV monitor by not providing any property to
>> update. However, this does not fulfill the future use cases where the
>> filtering can be more complex.
>> Other the topic on what parameters we should send along with
>> DeviceFound(), this is the other blocker for settling the API.
>> Approach (1) seems to be the right way to go, what do you think?
>
>
> Well if you do use ObjectManager 2 might not even be possible, so we need=
 to settle on that first, or there was some discussing on that regard that =
made you guys change the idea of using ObjectManager to list the applicatio=
n filters, lake I said that wouldn't escale very else, except if we were to=
 limit the filter each application can register to 1, but I thought that wo=
uldn't go well in Chrome OS given there is a single D-Bus connection all th=
e application filter would need to be combined in one to be registered.
I should have listed (3), which is to adopt ObjectManager which
eliminates the need of registration. As you recalled here, we'd like
to allow one client to have multiple monitors and (3) is a better
option in this case. The only thing that bothers me is how we inform
whether a given monitor was activated or not.
>
>>
>>
>> Thanks,
>> Miao
