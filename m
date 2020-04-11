Return-Path: <SRS0=Wpeu=53=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61246C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 00:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175C52083E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 00:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsGaXqOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDKAGU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:06:20 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39515 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKAGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Apr 2020 20:06:20 -0400
Received: by mail-lf1-f41.google.com with SMTP id m2so2439252lfo.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2020 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZRoiGeP4ck8jIPDqlzMlbeCuvWjw8O+v/5o4WjmefvU=;
        b=lsGaXqOxsGPhLRs8Sl8a8pgr2W2bMdafUuZBP6eJWI3hcfXOLPn6y2HLYo3AKARVbt
         oi+6wVc2rGA8Ti/LwKq5ZvoRx7D6rvBgXHrpY9E/AOQYjTqbbfekAVqi4w43wS4a04Sc
         0iflu/j9bJhColF0oBUVdz1a1jWdKqH56MM1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZRoiGeP4ck8jIPDqlzMlbeCuvWjw8O+v/5o4WjmefvU=;
        b=Y4ST+f77z8uyjfEh/v0spl3gU2TrYpFRclGRZock4sBEVW89/Dz0Kw3BjwYNE30rxI
         srmju7/57tXlZvqm5XYIcs5qKjnC8dxM2Yzj+f/DgjxmfQnT9Z5GdQaEZbazjdx7BwtF
         RGQIY34ODnPHGOwjKuri0TyWCEcGU5T6wFQUWbCauh5r4txBKrtfpEXLCzcWW+1xBdnI
         ECpLbhtUqeBM+xsqjEv84it9Sf2r1NtWOGv5bunlJ3TFUNOSfOcaObYyn2sMUZxCsVwE
         EjFJoxMjVDkDCh3Nv77t7zFJ3Bz2K1rFreQvVSYpp//0YNWv+YR0cgfhe4YxwFEpIdJc
         RNPQ==
X-Gm-Message-State: AGi0PuZNE9Hcz3ltrps1suChKxnlAGJUWL3usbo727D69CrgIn327kEr
        WKHJG6o1r9SVrYoRloKRk+UOjUYLGaWH82y6HUpB6A==
X-Google-Smtp-Source: APiQypILFSEphAX1D6KxKJ6bGeUmJx9FH5tYsNbszD6UfrYF93hXU51bfvt5nBkG1T6c+l0j0lp9JBeu2fgecR6l1cw=
X-Received: by 2002:a19:c385:: with SMTP id t127mr3882126lff.117.1586563576746;
 Fri, 10 Apr 2020 17:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org>
In-Reply-To: <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 10 Apr 2020 17:06:05 -0700
Message-ID: <CABmPvSFGshTsCu1BVwC4RW+xE2dW7to9iXnRaAne-L+WSKxvrA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc: Add Advertisement Monitoring API
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Apr 10, 2020 at 12:47 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Miao-chen,
>
> > This patch proposes an Advertisement Monitoring API for an application =
to
> > register a job of monitoring ADV reports with content filter and RSSI
> > thresholds.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > doc/advertisement-monitoring-api.txt | 163 +++++++++++++++++++++++++++
> > 1 file changed, 163 insertions(+)
> > create mode 100644 doc/advertisement-monitoring-api.txt
> >
> > diff --git a/doc/advertisement-monitoring-api.txt b/doc/advertisement-m=
onitoring-api.txt
> > new file mode 100644
> > index 000000000..070487481
> > --- /dev/null
> > +++ b/doc/advertisement-monitoring-api.txt
> > @@ -0,0 +1,163 @@
> > +BlueZ D-Bus Advertisement Monitoring API Description
> > +****************************************************
>
> I would name it =E2=80=9CAdvertisement Monitor=E2=80=9D
>
> > +
> > +This API allows an application to specify a job of monitoring advertis=
ements
> > +by providing a filter with filtering conditions, thresholds of RSSI an=
d timers
> > +of RSSI thresholds.
> > +
> > +Once an application registers a monitoring job, it can expect to get n=
otified
> > +on its targeted advertisements no matter if there is an ongoing discov=
ery
> > +session (a discovery session is started/stopped with methods in
> > +org.bluez.Adapter1 interface).
>
> Just for readability two empty lines here. See the other docs for an exam=
ple. They should be mostly consistent in their style.
>
> > +
> > +Advertisement Filter hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +Service              org.bluez
> > +Interface    org.bluez.AdvertisementFilter1
> > +Object path  freely definable
> > +
> > +Methods              void Release() [noreply]
> > +
> > +                     This gets called as a signal for a client to perf=
orm
> > +                     clean-up when BlueZ has invalidated the filter.
> > +
> > +             void DeviceInRange(object device, int16 RSSI, int16 TX_po=
wer,
> > +                                array{dict} ADV_data,
> > +                                array{uint8} ADV_raw_data)
>
> Actually looking at what the device object already gives you for free, I =
think you just need this:
>
>                 void DeviceInRange(object device)
>
> You will have the RSSI and TxPower fields and also the advertising data c=
onsidered for consumption by the application. If you really really need the=
 raw advertising report data, then we might include them as extra property =
type, but only if asked for. With advertising extensions these can get rath=
er large.
>
> Just to explain this reasoning to only use the object device here. Don=E2=
=80=99t see it as a full object, since it is just a reference and more prec=
ise a filter to find your object in the list of all objects. So an applicat=
ion can ignore everything else, but just has to filter the device object pa=
th out from all objects to find the information of the device it was lookin=
g for.
My concern is that adopting DeviceInRange(object device) will require
an application to issue following D-Bus calls to read properties
including AdvertisingData, RSSI, Tx power(it may be included in
AdvertisingData) and perhaps a new property RawAdvertisingData. Given
these calls reach bluetoothd, the values of these properties may have
changed, so the reading no longer presents the exact values associated
with the DeviceInRange() event. How do we get around this without
providing the actual values along with DeviceInRange?
>
> > +
> > +                     If RSSIThreshholdsAndTimers exists, this gets cal=
led to
> > +                     notify the client on finding the targeted device =
when
> > +                     RSSI(s) of the matched advertisement(s) exceed th=
e
> > +                     HighRSSIThreshold at least HighRSSIThresholdTimer=
.
> > +                     If RSSIThreshholdsAndTimers does not exist, this =
does
> > +                     not get called.
> > +
> > +                     Parameters:
> > +                     device          The device object path associated=
 with
> > +                                     the advertisement.
> > +                     RSSI            The RSSI comes along with the
> > +                                     advertisement.
> > +                     TX_power        The TX power AD data provided in =
the
> > +                                     advertisement. 127 indicates the =
absence
> > +                                     of TX power AD data.
> > +                     ADV_data        The signature of adv_data is a{yv=
} where
> > +                                     =E2=80=9Cy=E2=80=9D is the AD dat=
a type value and =E2=80=9Cv=E2=80=9D is
> > +                                     the value of the AD data where th=
e type
> > +                                     may vary depending on the AD data=
. For
> > +                                     instance, if "y" is 0x16, "v" wou=
ld be
> > +                                     an array of bytes.
> > +                     ADV_raw_data    The raw bytes of AD data from the
> > +                                     advertisement packet.
> > +
> > +             void AdvertisementReceived(object device, int16 RSSI,
> > +                                        int16 TX_power, array{dict} AD=
V_data,
> > +                                        array{uint8} ADV_raw_data)
> > +
> > +                     If RSSIThreshholdsAndTimers exists, this gets cal=
led
> > +                     every time except for the first time when receivi=
ng the
> > +                     matched advertisement(s) exceeding the
> > +                     HighRSSIThreshold. Once DeviceOutOfRange() gets c=
alled,
> > +                     this no longer gets called until DeviceInRange() =
gets
> > +                     called again.
> > +                     If RSSIThreshholdsAndTimers does not exist, this =
gets
> > +                     called whenever receiving the matched advertiseme=
nts.
> > +
> > +                     Parameters:
> > +                     device          The device object path associated=
 with
> > +                                     the advertisement.
> > +                     RSSI            The RSSI comes along with the
> > +                                     advertisement.
> > +                     TX_power        The TX power AD data provided in =
the
> > +                                     advertisement. 127 indicates the =
absence
> > +                                     of TX power AD data.
> > +                     ADV_data        The signature of adv_data is a{yv=
} where
> > +                                     =E2=80=9Cy=E2=80=9D is the AD dat=
a type value and =E2=80=9Cv=E2=80=9D is
> > +                                     the value of the AD data where th=
e type
> > +                                     may vary depending on the AD data=
. For
> > +                                     instance, if "y" is 0x16, "v" wou=
ld be
> > +                                     an array of bytes.
> > +                     ADV_raw_data    The raw bytes of AD data from the
> > +                                     advertisement packet.
>
> This differentiation rubs me a bit the wrong way. I think it makes things=
 a bit too complicated.
>
> In case you don=E2=80=99t specify any RSSI thresholds, I would still like=
 to use DeviceInRange and DeviceOutOfRange notifications. We have always us=
ed timeouts to indicate that devices are no longer valid and removed them. =
They needed to be found again. And even without RSSI this will be the case =
since you have device moving around. So it would be good to indicate that a=
 device is gone.
>
> Now the question is what we do for updates of a device that is currently =
in range and has been found. I think we don=E2=80=99t have to do anything. =
Since a client that cares about that device, can just monitor the object pr=
operties that we will keep updating as we find the device again. So if the =
RSSI, TxPower or even the advertising data changes, the client will be info=
rmed by a PropertiesChanged signal.
In the case where RSSIs thresholds are not enforced, my original
thought was that DeviceInRange and DeviceOutOfRange do not make lots
of sense, since the terms "InRange" and "OutOfRange" implies RSSI
checks. Also DeviceOutOfRange won't be called in this case, since no
timer was given. Unless you see this differently?
In the case where RSSIs thresholds are provided, using only
DeviceInRange and DeviceOutOfRange makes sense.
>
> > +
> > +             void DeviceOutOfRange(device object)
> > +
> > +                     If RSSIThreshholdsAndTimers exists, this gets cal=
led
> > +                     when RSSIs of the matched advertisements are lowe=
r than
> > +                     LowRSSIThreshold for at least LowRSSIThresholdTim=
er to
> > +                     notify the client on losing the targeted device.
> > +                     If RSSIThreshholdsAndTimers does not exist, this =
won=E2=80=99t
> > +                     get called.
>
> We could consider doing a pair of DeviceFound + DeviceLost.
>
> And of course we have to split the callback handling with filter properti=
es. When you read the full method name it needs to make sense. So org.bluez=
.AdvertisementFilter1.DeviceInRange is not really logical.
>
> I would have something like org.bluez.AdvertismentMonitor.DeviceFound for=
 example.
>
DeviceFound() and DeviceLost() sound good to me. Are you suggesting
having two properties, one for HighRSSIThreshold and
HighRSSIThresholdTimer and one for LowRSSIThreshold and
LowRSSIThresholdTimer, so that DeviceFound() is called only if
HighRSSIThresholdAndTimer exists, and DeviceLost() is called only if
LowRSSIThresholdAndTimer exists?
> > +
> > +Properties   uint8 FilterType [read-only]
> > +
> > +                     This can be the following values. More will be ad=
ded.
> > +                     0x01 - Patterns with OR logic relation
> > +
> > +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [=
read-only, optional]
> > +
> > +                     The contains HighRSSIThreshold, HighRSSIThreshold=
Timer,
> > +                     LowRSSIThreshold, LowRSSIThresholdTimer in order.=
 The
> > +                     unit of HighRSSIThreshold and LowRSSIThreshold is=
 dBm.
> > +                     The unit of HighRSSIThresholdTimer and
> > +                     LowRSSIThresholdTimer is second.
> > +
> > +                     A device is considered in-range when the RSSIs of=
 the
> > +                     received advertisement(s) during HighRSSIThreshol=
dTimer
> > +                     seconds exceed HighRSSIThreshold. Likewise, a dev=
ice is
> > +                     considered out-of-range when the RSSIs of the rec=
eived
> > +                     advertisement(s) during LowRSSIThresholdTimer do =
not
> > +                     reach LowRSSIThreshold.
> > +
> > +             array{(uint8, uint8, string)} Patterns [read-only, option=
al]
> > +
> > +                     If =E2=80=9CPatternsWithORLogicRelation=E2=80=9D =
is supported, this must
> > +                     exist and has at least one entry in the array.
> > +
> > +                     The structure of a pattern contains the following=
.
> > +                     uint8 start_position
> > +                             The index in an AD data field where the s=
earch
> > +                             should start. The beginning of an AD data=
 field
> > +                             is index 0.
> > +                     uint8 AD_data_type
> > +                             See https://www.bluetooth.com/specificati=
ons/
> > +                             assigned-numbers/generic-access-profile/ =
for
> > +                             the possible allowed value.
> > +                     string content_of_pattern
> > +                             This is the value of the pattern.
>
> This part I would provide as dict to the RegisterMonitor method (see belo=
w).
>
> > +
> > +Advertisement Monitor hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > +Service              org.bluez
> > +Interface    org.bluez.AdvertisementMonitor1
> > +Object path  /org/bluez/{hci0,hci1,...}
>
> If we follow our current style then it would be org.bluez.AdvertismentMon=
itorManager.
>
> While writing this email so far, I am kinda tempted to call it org.bluez.=
DeviceMonitorManager and org.bluez.DeviceMonitor. It is just a temptation a=
t this point and it is good to sleep about it for a bit.
>
> > +
> > +Methods              void RegisterApplication(object filter)
> > +
> > +                     This registers a job of monitoring advertisement =
in a
> > +                     power efficient way. Based on the content of the =
filter
> > +                     upon registration, the filter object can expect t=
o
> > +                     receive the matched advertisements via DeviceInRa=
nge()
> > +                     and AdvertisementReceived().
>
> RegisterMonitor(object monitor, dict thresholds, dict filter)
>
> Having the thresholds and the filters as dicts here make it clear that yo=
u have to destroy the monitor and create a new one of you want to change th=
em. I think that is acceptable and in the end an easy task, since you still=
 can reuse the object monitor that you have already set up. It also make th=
e code for bluetoothd simpler since it doesn=E2=80=99t have to track life c=
hanges to the filters and act on them.
>
This was close to what I proposed earlier where the thresholds and the
filtering conditions are provided upon function calls, and Luiz
suggested adopting advertising API's way. Given that we may want to
provide what Android provides at some point, having a dict to host
filtering conditions may not be sufficient. If we'd like to have AND
logical relation applied among filtering conditions within a filter,
we basically need to change the signature here. For instance, an
application would like to look for advertisements matching service
UUID 0x1234 AND 0x5678 in Manufacturer data. Having filtering
conditions defined as properties make this possible by adding another
property later without changing the function signature.

I'd like to raise the same concern that I had in previous meetings.
Given that we plan to have SW filtering first and then offload the
filtering to the BT controller, there may be  logical relations
infeasible by HCI extensions. Should we influence this API by the
capabilities of HCI extensions? I guess the answer is not, and that
means bluetoothd needs to be sophisticated enough to determined the
filtering conditions send to kernel for the first tier filtering and
performs the second tier filtering itself.
> > +
> > +             void UnregisterApplication(filter object)
> > +
> > +                     This unregisters the job of monitoring advertisem=
ent.
> > +                     The filter object can expect to be called on Rele=
ase()
> > +                     once the removal is done.
> > +
> > +             void UnregisterAllApplications()
> > +
> > +                     This unregisters all jobs of monitoring advertise=
ment.
> > +                     All filter objects can expect to be called on Rel=
ease()
> > +                     once the removals are done.
>
> I would rather not have an UnregisterAll. We didn=E2=80=99t need it until=
 now and the object monitor was always bound to the lifetime of the applica=
tion.
Ack.
>
> > +
> > +Properties   array{string} SupportedFilteringFeatures [read-only]
> > +
> > +                     This reflects the supported features of advertise=
ment
> > +                     monitoring. An application should check this befo=
re
> > +                     instantiate an object of org.bluez.AdvertisementF=
ilter1.
> > +
> > +                     Here are the potential features. More will be add=
ed.
> > +                     "SoftwareBasedFiltering"
> > +                     "PatternsWithORLogicRelation"
> > +                     =E2=80=9CRSSIMonitoring=E2=80=9D
>
> So all our string values are lower-case and if needed we use - to separat=
e words or logical details.
>
> I think exposing a good interface for selecting the filter patterns will =
take a bit. I would like to focus on getting the surrounding framework figu=
red out first.
>
> Before finalizing an API, my test was always to write a simple client and=
 check if it meets the requirement for being simple enough. If it becomes c=
umbersome for the client, then we need to consider putting some of the more=
 complicated parts into bluetoothd.
>
> Let me try to give an example. If the majority of the clients just want t=
o find a device with UUID 0xFE23, then we should have a special casing for =
that.
>
>         RegisterMonitor(monitor, dict{MatchUUID=3D0xFE23}).
>
> Done. That they have to differentiate between one vendors way of doing th=
is compared to another on how to provide the information should be up to bl=
uetoothd to figure it out (and yes, I know it is not as simple when the AD =
type is a list).
Again, this was close to what I proposed earlier where the thresholds
and the filtering conditions are provided upon function call. Please
see my above comments on why I think this may not be sufficient.

Thanks,
Miao
