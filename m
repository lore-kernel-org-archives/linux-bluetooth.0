Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B1C83000
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 01:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6E0208E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 01:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDyMUGkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3BJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgD3BJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 21:09:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59729C035494
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 18:09:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b2so4682573ljp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vS7IgAh56fVAdz4aXAUi3aaH4svNCUZRitQLqXsmPK0=;
        b=EDyMUGkhm4bYEJWkSnTok/wNKfbKZrBQyvBvOr78jQN7i3swNxxhi5L/DKfT0ys3WL
         LmBrLrRMNpGerhIWNrdqG/pjMo5oxGnZ6qGZMJPo7AgTgQOG9d2jmb/UJT0u+VnYWAEl
         IzmydC3jXtLVm9GI8LGOMqFNZyRt/3lUC5WeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vS7IgAh56fVAdz4aXAUi3aaH4svNCUZRitQLqXsmPK0=;
        b=gUv5f164cBYHrXqHF1pNYpIKL4sTIXsZrk00RoaRbusCdweNy3hJrhU+4GTS0vlDKL
         6Ok3oGQ4g+iyuj4/bTJWKiMRVJsQ7tdxTMoqqDldnAyGO6/rE7WqRNKtrZgzJ95acTus
         5AjoanQ0FD3OHNeVAL88xahszKfKmK5GPEe6/YmKEV4vy7iPQK/ZkGI5tNELLr8ySCfP
         GuUHb6Y2Vd4YW1eiQ3gWvuyqY0veVoQW+hkkcFd1vQ5AXIvMwJ2PcvD+2d1EicLGg62x
         Tn0OHaGvDQnT3bZl34l5UxhIl8UIbOiJL2qlX39kuyPDrz5OapjHaCQ7yEFVDMWudtKZ
         i/DA==
X-Gm-Message-State: AGi0PuZRl97H0kg3s4iYaLQY+DZ3Pb8Or909rxHqIGxK+D4Z0nrscDAA
        zcBG8i4vRUGlQ96p6OyTHkxKlu7KhVxYYa2dmF4LjA==
X-Google-Smtp-Source: APiQypIGtRIiaVCz/tgzHuLEwnuFrhAr08ieTQfLzxB0LyI2Dqfsw3Iu6p7CdN1CIlnhk8HBVDt09KfR4/d0nzH9AiY=
X-Received: by 2002:a2e:a37b:: with SMTP id i27mr531172ljn.36.1588208988603;
 Wed, 29 Apr 2020 18:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200427131208.BlueZ.v4.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <D989C44F-A240-4129-8EF6-513645E5DFE6@holtmann.org> <CACumGO+Ss4s=tcaosXMRfVkccRZ_42Hh3YCr1bgFaUz5a6SUBw@mail.gmail.com>
In-Reply-To: <CACumGO+Ss4s=tcaosXMRfVkccRZ_42Hh3YCr1bgFaUz5a6SUBw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 29 Apr 2020 18:09:37 -0700
Message-ID: <CABmPvSHfRHaJB4YQqOC3yq3S6j6hm4zdE3fqsXp-BaSJxiX6aQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4] doc: Add Advertisement Monitoring API
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 29, 2020 at 10:11 AM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Marcel,
>
> On Wed, Apr 29, 2020 at 1:13 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
>>
>> Hi Miao-chen,
>>
>> > This patch proposes an Advertisement Monitoring API for an application=
 to
>> > register a job of monitoring ADV reports with content filter and RSSI
>> > thresholds.
>> > ---
>> >
>> > Changes in v4:
>> > - Change the signature of SupportedMonitorTypes to be array of strings=
.
>> > - Fix document formatting.
>> >
>> > Changes in v3:
>> > - Introduce SupportedFeatures to reflect the features based on
>> > controller's capabilities.
>> > - Modify SupportedMonitorTypes to list available types of monitors.
>> >
>> > Changes in v2:
>> > - Rename the interfaces and functions.
>> > - Adopt the object manager mechanism so that a client can expose
>> > multiple monitor objects and expect to get notified on whether the
>> > monitor has been activated or not.
>> > - Change the contract of DeviceFound so that it is called to indicate
>> > the starting point of monitoring on a device instead of reporting ever=
y
>> > ADV. In other words, the client is expected to monitor corresponding
>> > device events.
>> >
>> > doc/advertisement-monitor-api.txt | 137 ++++++++++++++++++++++++++++++
>> > 1 file changed, 137 insertions(+)
>> > create mode 100644 doc/advertisement-monitor-api.txt
>> >
>> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-mon=
itor-api.txt
>> > new file mode 100644
>> > index 000000000..012fce420
>> > --- /dev/null
>> > +++ b/doc/advertisement-monitor-api.txt
>> > @@ -0,0 +1,137 @@
>> > +BlueZ D-Bus Advertisement Monitor API Description
>> > +*************************************************
>> > +
>> > +This API allows an client to specify a job of monitoring advertisemen=
ts by
>> > +registering the root of hierarchy and then exposing advertisement mon=
itors
>> > +under the root with filtering conditions, thresholds of RSSI and time=
rs
>> > +of RSSI thresholds.
>> > +
>> > +Once a monitoring job is activated by BlueZ, the client can expect to=
 get
>> > +notified on the targeted advertisements no matter if there is an ongo=
ing
>> > +discovery session (a discovery session is started/stopped with method=
s in
>> > +org.bluez.Adapter1 interface).
>> > +
>> > +Advertisement Monitor hierarchy
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> > +Service              org.bluez
>> > +Interface    org.bluez.AdvertisementMonitor1 [experimental]
>> > +Object path  freely definable
>>
>> can you please at least roughly follow the style regarding the empty lin=
es from the other documents.
>>
>> > +
>> > +Methods              void Release() [noreply]
>> > +
>> > +                     This gets called as a signal for a client to per=
form
>> > +                     clean-up when (1)a monitor cannot be activated a=
fter it
>> > +                     was exposed or (2)a monitor has been deactivated=
.
>> > +
>> > +             void Activate() [noreply]
>> > +
>> > +                     After a monitor was exposed, this gets called as=
 a
>> > +                     signal for client to get acknowledged when a mon=
itor
>> > +                     has been activated, so the client can expect to =
receive
>> > +                     calls on DeviceFound() or DeviceLost().
>>
>> Do we actually need this? As noted by Szymon we would expect RegisterMon=
itor to only return when it successfully active a monitor.
If we go with the direction where a client is allowed to expose
multiple monitor objects at a time, then we need a way for the client
to get notified once the monitors are activated. We don't need this if
we only allow a client to register one monitor at a time.
>>
>> > +
>> > +             void DeviceFound(object device) [noreply]
>> > +
>> > +                     This gets called to notify the client of finding=
 the
>> > +                     targeted device. Once receiving the call, the cl=
ient
>> > +                     should start to monitor the corresponding device=
 to
>> > +                     retrieve the changes on RSSI and advertisement c=
ontent.
>> > +
>> > +             void DeviceLost(object device) [noreply]
>> > +
>> > +                     This gets called to notify the client of losing =
the
>> > +                     targeted device. Once receiving this call, the c=
lient
>> > +                     should stop monitoring the corresponding device.
>> > +
>> > +Properties   uint8 Type [read-only]
>> > +
>> > +                     The type of the monitor. See SupportedMonitorTyp=
es in
>> > +                     org.bluez.AdvertisementMonitorManager1 for the a=
vailable
>> > +                     options.
>> > +
>> > +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers =
[read-only, optional]
>> > +
>> > +                     This contains HighRSSIThreshold, HighRSSIThresho=
ldTimer,
>> > +                     LowRSSIThreshold, LowRSSIThresholdTimer in order=
. The
>> > +                     unit of HighRSSIThreshold and LowRSSIThreshold i=
s dBm.
>> > +                     The unit of HighRSSIThresholdTimer and
>> > +                     LowRSSIThresholdTimer is second.
>> > +
>> > +                     If these are provided, RSSI would be used as a f=
actor to
>> > +                     notify the client of whether a device stays in r=
ange or
>> > +                     move out of range. A device is considered in-ran=
ge when
>> > +                     the RSSIs of the received advertisement(s) durin=
g
>> > +                     HighRSSIThresholdTimer seconds exceed HighRSSITh=
reshold.
>> > +                     Likewise, a device is considered out-of-range wh=
en the
>> > +                     RSSIs of the received advertisement(s) during
>> > +                     LowRSSIThresholdTimer do not reach LowRSSIThresh=
old.
>> > +
>> > +             array{(uint8, uint8, string)} Patterns [read-only, optio=
nal]
>> > +
>> > +                     If Type is set to 0x01, this must exist and has =
at least
>> > +                     one entry in the array.
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
>> This part we really need to discuss and come to an agreement. I am not i=
n favor of doing these as properties on the monitor object. I would give th=
em as dict to the RegisterMonitor.
>>
>
> That was actually my recommendation to do go this way since we do want to=
 support registering multiple objects at once which is usually done with th=
e likes of ObjectManager to list the whole tree of objects, if we go with g=
iven this direction to RegisterMonitor this might have to be an array e.g a=
{oa{sv}} which would require custom code to extract the objects and create =
proper proxies for them, so I rather keep this simple and just use ObjectMa=
nager to list the objects.
>
>>
>> > +
>> > +Advertisement Monitor Manager hierarchy
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +Service              org.bluez
>> > +Interface    org.bluez.AdvertisementMonitorManager1 [experimental]
>> > +Object path  /org/bluez/{hci0,hci1,...}
>> > +
>> > +Methods              void RegisterApplication(object application)
>> > +
>> > +                     This registers a hierarchy of advertisement moni=
tors.
>> > +                     The application object path together with the D-=
Bus
>> > +                     system bus connection ID define the identificati=
on of
>> > +                     the application registering advertisement monito=
rs.
>> > +
>> > +                     Possible errors: org.bluez.Error.InvalidArgument=
s
>> > +                                      org.bluez.Error.AlreadyExists
>> > +
>> > +             void UnregisterApplication(object application)
>> > +
>> > +                     This unregisters advertisement monitors that hav=
e been
>> > +                     previously registered. The object path parameter=
 must
>> > +                     match the same value that has been used on
>> > +                     registration.
>> > +
>> > +                     Possible errors: org.bluez.Error.InvalidArgument=
s
>> > +                                      org.bluez.Error.DoesNotExist
>>
>> My choice of method naming would be RegisterMonitor and UnregisterMonito=
r.
>>
>> > +
>> > +Properties   array{string} SupportedMonitorTypes [read-only]
>> > +
>> > +                     This lists the supported types of advertisement
>> > +                     monitors. An application should check this befor=
e
>> > +                     instantiate and expose an object of
>> > +                     org.bluez.AdvertisementMonitor1.
>> > +
>> > +                     Possible values for monitor types:
>> > +
>> > +                     "patterns_with_logic_or"
>> > +                             Patterns with logic OR applied. With thi=
s type,
>> > +                             property "Patterns" must exist and has a=
t least
>> > +                             one pattern.
>>
>> To be consistent they need to be =E2=80=9Cpatterns-with-or-logic=E2=80=
=9D. And maybe =E2=80=9Cor-patterns=E2=80=9D is just enough.
ack
>>
>> > +
>> > +             array{string} SupportedFeatures [read-only]
>> > +
>> > +                     This lists the features of advertisement monitor=
ing
>> > +                     supported by BlueZ.
>> > +
>> > +                     Possible values for features:
>> > +
>> > +                     "controller-based-monitor-by-patterns"
>> > +                             If the controller is capable of performi=
ng
>> > +                             advertisement monitoring by patterns, Bl=
ueZ
>> > +                             would offload the patterns to the contro=
ller to
>> > +                             reduce power consumption.
>>
>> I would consider shortening this to =E2=80=9Ccontroller-patterns=E2=80=
=9D.
Ack.
>>
>> Regards
>>
>> Marcel
>>
