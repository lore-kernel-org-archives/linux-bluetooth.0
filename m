Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F3AC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 23:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA7F2072D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 23:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1+2+sjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbgDMXd6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727839AbgDMXd6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 19:33:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7DC0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 16:33:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t11so7909589lfe.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiTcSrP9onyF8nUegy72wKGwhZyxGm6qajNrzHFGVfE=;
        b=I1+2+sjU4FwyJOjJgm6iw1BLAlQORSVPimMr3aW6ooV+GKLLXnQaxlOR6D/2+1vNTP
         bEkS4PMSLRjBWGjDYgx/UdCGv3kB2/LiCNlWLB96wz9mdpKedOn00EPcRDusjZcxIfB/
         FUgf5tbA0Hgj8X+wV+PvIGNApHPPa3+RMJyGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiTcSrP9onyF8nUegy72wKGwhZyxGm6qajNrzHFGVfE=;
        b=BP0iRiNc1Wt3giXrtV5CD77+m05TW9c6fj5Mq6dYAiacLrdygZrJ2iDOWiRSRjmZq9
         cad4zqqttZRmnQ/uYaTI1VJqVLHLyKPUc59o9dvDD+wMRY8pWyshGiOje2FD46JhtqQh
         NzDn13QDxWmT3/hANWACUP9ZIBijJVtCgD5GxHWOywEdptTuwa5ElaVSYRViQluDjIml
         wK8xMAXjHldvB+1DbavELDnMzvxEnZYGR3Lq8QZ+e7iW+wPHz8xFj9ovaJN6ZNWa6fvF
         9IbwYVdh14hQMfnkX+bSm57/lDtwf5sbfIMnEuggI367mkmjNFkjOWp2QMGn3POTCdT5
         /5ag==
X-Gm-Message-State: AGi0PuZvspEsVm9zFWT5fEbrWNBUW13pdAUqdxZ89cY3vJAhta+z+4he
        l191YV5SgEBuOkkyMBJOAn/P522RDLnIByJva0pSKA==
X-Google-Smtp-Source: APiQypIIhoVQe5RX0Lmxl9HUBR+MJpwWavPM0sp5hKth+pxV//BsHF+62CCkjYetl7IZuZuKlthtnDnkhb80cpT0iss=
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr12032488lfe.163.1586820835590;
 Mon, 13 Apr 2020 16:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
 <B0EF0AD0-6044-4ABC-87C9-2A540635594D@holtmann.org> <CABmPvSFGshTsCu1BVwC4RW+xE2dW7to9iXnRaAne-L+WSKxvrA@mail.gmail.com>
 <664B85F6-9CD2-45F4-B2AB-5E0C0E2F8717@holtmann.org>
In-Reply-To: <664B85F6-9CD2-45F4-B2AB-5E0C0E2F8717@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 13 Apr 2020 16:33:44 -0700
Message-ID: <CABmPvSFE-owPfiT1nM=wzWijpUvw_Tv8H0SmM0ngHE8wOCLzag@mail.gmail.com>
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

Hi Marcel and Luiz,


On Fri, Apr 10, 2020 at 11:19 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Miao-chen,
>
> >>> This patch proposes an Advertisement Monitoring API for an applicatio=
n to
> >>> register a job of monitoring ADV reports with content filter and RSSI
> >>> thresholds.
> >>>
> >>> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> >>> ---
> >>>
> >>> doc/advertisement-monitoring-api.txt | 163 ++++++++++++++++++++++++++=
+
> >>> 1 file changed, 163 insertions(+)
> >>> create mode 100644 doc/advertisement-monitoring-api.txt
> >>>
> >>> diff --git a/doc/advertisement-monitoring-api.txt b/doc/advertisement=
-monitoring-api.txt
> >>> new file mode 100644
> >>> index 000000000..070487481
> >>> --- /dev/null
> >>> +++ b/doc/advertisement-monitoring-api.txt
> >>> @@ -0,0 +1,163 @@
> >>> +BlueZ D-Bus Advertisement Monitoring API Description
> >>> +****************************************************
> >>
> >> I would name it =E2=80=9CAdvertisement Monitor=E2=80=9D
> >>
> >>> +
> >>> +This API allows an application to specify a job of monitoring advert=
isements
> >>> +by providing a filter with filtering conditions, thresholds of RSSI =
and timers
> >>> +of RSSI thresholds.
> >>> +
> >>> +Once an application registers a monitoring job, it can expect to get=
 notified
> >>> +on its targeted advertisements no matter if there is an ongoing disc=
overy
> >>> +session (a discovery session is started/stopped with methods in
> >>> +org.bluez.Adapter1 interface).
> >>
> >> Just for readability two empty lines here. See the other docs for an e=
xample. They should be mostly consistent in their style.
> >>
> >>> +
> >>> +Advertisement Filter hierarchy
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +Service              org.bluez
> >>> +Interface    org.bluez.AdvertisementFilter1
> >>> +Object path  freely definable
> >>> +
> >>> +Methods              void Release() [noreply]
> >>> +
> >>> +                     This gets called as a signal for a client to pe=
rform
> >>> +                     clean-up when BlueZ has invalidated the filter.
> >>> +
> >>> +             void DeviceInRange(object device, int16 RSSI, int16 TX_=
power,
> >>> +                                array{dict} ADV_data,
> >>> +                                array{uint8} ADV_raw_data)
> >>
> >> Actually looking at what the device object already gives you for free,=
 I think you just need this:
> >>
> >>                void DeviceInRange(object device)
> >>
> >> You will have the RSSI and TxPower fields and also the advertising dat=
a considered for consumption by the application. If you really really need =
the raw advertising report data, then we might include them as extra proper=
ty type, but only if asked for. With advertising extensions these can get r=
ather large.
> >>
> >> Just to explain this reasoning to only use the object device here. Don=
=E2=80=99t see it as a full object, since it is just a reference and more p=
recise a filter to find your object in the list of all objects. So an appli=
cation can ignore everything else, but just has to filter the device object=
 path out from all objects to find the information of the device it was loo=
king for.
> > My concern is that adopting DeviceInRange(object device) will require
> > an application to issue following D-Bus calls to read properties
> > including AdvertisingData, RSSI, Tx power(it may be included in
> > AdvertisingData) and perhaps a new property RawAdvertisingData. Given
> > these calls reach bluetoothd, the values of these properties may have
> > changed, so the reading no longer presents the exact values associated
> > with the DeviceInRange() event. How do we get around this without
> > providing the actual values along with DeviceInRange?
>
> You get them via InterfacesAdded and PropertiesChanged standard signal. S=
imilar to what is done when we are doing discovery.
From a D-Bus client perspective, I'd argue that it requires much more
work for an application to register the monitoring job on one
interface. For the case where the device exists already, the
application needs to listen to the device interface for multiple
PropertiesChanged signals (AdvertisingData, RSSI, TxPower,
ManufacturerData, ServiceData and AdvertisingFlags) where these
signals could arrived earlier than the time DeviceFound() got called.
In the case a new device was created, the application also needs to
listen to InterfacesAdded signal and then reads on multiple
properties; by the time the application reads the values, they could
be changed already.
Instead, if we simply provide the parsed dict containing all valid
fields along with RSSI and TX power(this may not be provided), it
eliminates the needs of all above work for the application. I'd like
to highlight that the intention here is to make the life of the
application easier by providing only the matched AD data without the
above extra work. Another thing that I'd like to highlight here is
that we are introducing a new API whose use case is different from
discovery, reporting a device object and reporting an ADV can be
orthogonal. In fact, the reason for providing the device object path
in DeviceFound is to make it easier for the application to take
further action on the device (such as pairing or connection) so that
it doesn't need to figure out which device is associated with the
received ADV. The only downside that I can think of is the case where
the device exists, and this makes DeviceFound call with AD data where
they are emitted via device interface. In the case where the device is
new, there is no duplicate data passing.
 >
> >>> +
> >>> +                     If RSSIThreshholdsAndTimers exists, this gets c=
alled to
> >>> +                     notify the client on finding the targeted devic=
e when
> >>> +                     RSSI(s) of the matched advertisement(s) exceed =
the
> >>> +                     HighRSSIThreshold at least HighRSSIThresholdTim=
er.
> >>> +                     If RSSIThreshholdsAndTimers does not exist, thi=
s does
> >>> +                     not get called.
> >>> +
> >>> +                     Parameters:
> >>> +                     device          The device object path associat=
ed with
> >>> +                                     the advertisement.
> >>> +                     RSSI            The RSSI comes along with the
> >>> +                                     advertisement.
> >>> +                     TX_power        The TX power AD data provided i=
n the
> >>> +                                     advertisement. 127 indicates th=
e absence
> >>> +                                     of TX power AD data.
> >>> +                     ADV_data        The signature of adv_data is a{=
yv} where
> >>> +                                     =E2=80=9Cy=E2=80=9D is the AD d=
ata type value and =E2=80=9Cv=E2=80=9D is
> >>> +                                     the value of the AD data where =
the type
> >>> +                                     may vary depending on the AD da=
ta. For
> >>> +                                     instance, if "y" is 0x16, "v" w=
ould be
> >>> +                                     an array of bytes.
> >>> +                     ADV_raw_data    The raw bytes of AD data from t=
he
> >>> +                                     advertisement packet.
> >>> +
> >>> +             void AdvertisementReceived(object device, int16 RSSI,
> >>> +                                        int16 TX_power, array{dict} =
ADV_data,
> >>> +                                        array{uint8} ADV_raw_data)
> >>> +
> >>> +                     If RSSIThreshholdsAndTimers exists, this gets c=
alled
> >>> +                     every time except for the first time when recei=
ving the
> >>> +                     matched advertisement(s) exceeding the
> >>> +                     HighRSSIThreshold. Once DeviceOutOfRange() gets=
 called,
> >>> +                     this no longer gets called until DeviceInRange(=
) gets
> >>> +                     called again.
> >>> +                     If RSSIThreshholdsAndTimers does not exist, thi=
s gets
> >>> +                     called whenever receiving the matched advertise=
ments.
> >>> +
> >>> +                     Parameters:
> >>> +                     device          The device object path associat=
ed with
> >>> +                                     the advertisement.
> >>> +                     RSSI            The RSSI comes along with the
> >>> +                                     advertisement.
> >>> +                     TX_power        The TX power AD data provided i=
n the
> >>> +                                     advertisement. 127 indicates th=
e absence
> >>> +                                     of TX power AD data.
> >>> +                     ADV_data        The signature of adv_data is a{=
yv} where
> >>> +                                     =E2=80=9Cy=E2=80=9D is the AD d=
ata type value and =E2=80=9Cv=E2=80=9D is
> >>> +                                     the value of the AD data where =
the type
> >>> +                                     may vary depending on the AD da=
ta. For
> >>> +                                     instance, if "y" is 0x16, "v" w=
ould be
> >>> +                                     an array of bytes.
> >>> +                     ADV_raw_data    The raw bytes of AD data from t=
he
> >>> +                                     advertisement packet.
> >>
> >> This differentiation rubs me a bit the wrong way. I think it makes thi=
ngs a bit too complicated.
> >>
> >> In case you don=E2=80=99t specify any RSSI thresholds, I would still l=
ike to use DeviceInRange and DeviceOutOfRange notifications. We have always=
 used timeouts to indicate that devices are no longer valid and removed the=
m. They needed to be found again. And even without RSSI this will be the ca=
se since you have device moving around. So it would be good to indicate tha=
t a device is gone.
> >>
> >> Now the question is what we do for updates of a device that is current=
ly in range and has been found. I think we don=E2=80=99t have to do anythin=
g. Since a client that cares about that device, can just monitor the object=
 properties that we will keep updating as we find the device again. So if t=
he RSSI, TxPower or even the advertising data changes, the client will be i=
nformed by a PropertiesChanged signal.
> > In the case where RSSIs thresholds are not enforced, my original
> > thought was that DeviceInRange and DeviceOutOfRange do not make lots
> > of sense, since the terms "InRange" and "OutOfRange" implies RSSI
> > checks. Also DeviceOutOfRange won't be called in this case, since no
> > timer was given. Unless you see this differently?
> > In the case where RSSIs thresholds are provided, using only
> > DeviceInRange and DeviceOutOfRange makes sense.
>
> We can fine-tune the naming, but from an API complexity point of view, tw=
o method calls for =E2=80=9Cfound the device=E2=80=9D and =E2=80=9Cdevice n=
o longer available=E2=80=9D that work no matter if RSSI ranges are given ar=
e better.
>
> >>
> >>> +
> >>> +             void DeviceOutOfRange(device object)
> >>> +
> >>> +                     If RSSIThreshholdsAndTimers exists, this gets c=
alled
> >>> +                     when RSSIs of the matched advertisements are lo=
wer than
> >>> +                     LowRSSIThreshold for at least LowRSSIThresholdT=
imer to
> >>> +                     notify the client on losing the targeted device=
.
> >>> +                     If RSSIThreshholdsAndTimers does not exist, thi=
s won=E2=80=99t
> >>> +                     get called.
> >>
> >> We could consider doing a pair of DeviceFound + DeviceLost.
> >>
> >> And of course we have to split the callback handling with filter prope=
rties. When you read the full method name it needs to make sense. So org.bl=
uez.AdvertisementFilter1.DeviceInRange is not really logical.
> >>
> >> I would have something like org.bluez.AdvertismentMonitor.DeviceFound =
for example.
> >>
> > DeviceFound() and DeviceLost() sound good to me. Are you suggesting
> > having two properties, one for HighRSSIThreshold and
> > HighRSSIThresholdTimer and one for LowRSSIThreshold and
> > LowRSSIThresholdTimer, so that DeviceFound() is called only if
> > HighRSSIThresholdAndTimer exists, and DeviceLost() is called only if
> > LowRSSIThresholdAndTimer exists?
>
> I am suggesting that if you have RSSI thresholds or not, we use DeviceFou=
nd and DeviceLost (or whatever naming we finally agree on). For me the RSSI=
 thresholds are just a method to reduce the range of what is reported.
Agreed, I will address the changes in v2.
>
> >>> +
> >>> +Properties   uint8 FilterType [read-only]
> >>> +
> >>> +                     This can be the following values. More will be =
added.
> >>> +                     0x01 - Patterns with OR logic relation
> >>> +
> >>> +             (Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers=
 [read-only, optional]
> >>> +
> >>> +                     The contains HighRSSIThreshold, HighRSSIThresho=
ldTimer,
> >>> +                     LowRSSIThreshold, LowRSSIThresholdTimer in orde=
r. The
> >>> +                     unit of HighRSSIThreshold and LowRSSIThreshold =
is dBm.
> >>> +                     The unit of HighRSSIThresholdTimer and
> >>> +                     LowRSSIThresholdTimer is second.
> >>> +
> >>> +                     A device is considered in-range when the RSSIs =
of the
> >>> +                     received advertisement(s) during HighRSSIThresh=
oldTimer
> >>> +                     seconds exceed HighRSSIThreshold. Likewise, a d=
evice is
> >>> +                     considered out-of-range when the RSSIs of the r=
eceived
> >>> +                     advertisement(s) during LowRSSIThresholdTimer d=
o not
> >>> +                     reach LowRSSIThreshold.
> >>> +
> >>> +             array{(uint8, uint8, string)} Patterns [read-only, opti=
onal]
> >>> +
> >>> +                     If =E2=80=9CPatternsWithORLogicRelation=E2=80=
=9D is supported, this must
> >>> +                     exist and has at least one entry in the array.
> >>> +
> >>> +                     The structure of a pattern contains the followi=
ng.
> >>> +                     uint8 start_position
> >>> +                             The index in an AD data field where the=
 search
> >>> +                             should start. The beginning of an AD da=
ta field
> >>> +                             is index 0.
> >>> +                     uint8 AD_data_type
> >>> +                             See https://www.bluetooth.com/specifica=
tions/
> >>> +                             assigned-numbers/generic-access-profile=
/ for
> >>> +                             the possible allowed value.
> >>> +                     string content_of_pattern
> >>> +                             This is the value of the pattern.
> >>
> >> This part I would provide as dict to the RegisterMonitor method (see b=
elow).
> >>
> >>> +
> >>> +Advertisement Monitor hierarchy
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +Service              org.bluez
> >>> +Interface    org.bluez.AdvertisementMonitor1
> >>> +Object path  /org/bluez/{hci0,hci1,...}
> >>
> >> If we follow our current style then it would be org.bluez.Advertisment=
MonitorManager.
> >>
> >> While writing this email so far, I am kinda tempted to call it org.blu=
ez.DeviceMonitorManager and org.bluez.DeviceMonitor. It is just a temptatio=
n at this point and it is good to sleep about it for a bit.
> >>
> >>> +
> >>> +Methods              void RegisterApplication(object filter)
> >>> +
> >>> +                     This registers a job of monitoring advertisemen=
t in a
> >>> +                     power efficient way. Based on the content of th=
e filter
> >>> +                     upon registration, the filter object can expect=
 to
> >>> +                     receive the matched advertisements via DeviceIn=
Range()
> >>> +                     and AdvertisementReceived().
> >>
> >> RegisterMonitor(object monitor, dict thresholds, dict filter)
> >>
> >> Having the thresholds and the filters as dicts here make it clear that=
 you have to destroy the monitor and create a new one of you want to change=
 them. I think that is acceptable and in the end an easy task, since you st=
ill can reuse the object monitor that you have already set up. It also make=
 the code for bluetoothd simpler since it doesn=E2=80=99t have to track lif=
e changes to the filters and act on them.
> >>
> > This was close to what I proposed earlier where the thresholds and the
> > filtering conditions are provided upon function calls, and Luiz
> > suggested adopting advertising API's way. Given that we may want to
> > provide what Android provides at some point, having a dict to host
> > filtering conditions may not be sufficient. If we'd like to have AND
> > logical relation applied among filtering conditions within a filter,
> > we basically need to change the signature here. For instance, an
> > application would like to look for advertisements matching service
> > UUID 0x1234 AND 0x5678 in Manufacturer data. Having filtering
> > conditions defined as properties make this possible by adding another
> > property later without changing the function signature.
> >
> > I'd like to raise the same concern that I had in previous meetings.
> > Given that we plan to have SW filtering first and then offload the
> > filtering to the BT controller, there may be  logical relations
> > infeasible by HCI extensions. Should we influence this API by the
> > capabilities of HCI extensions? I guess the answer is not, and that
> > means bluetoothd needs to be sophisticated enough to determined the
> > filtering conditions send to kernel for the first tier filtering and
> > performs the second tier filtering itself.
> >>> +
> >>> +             void UnregisterApplication(filter object)
> >>> +
> >>> +                     This unregisters the job of monitoring advertis=
ement.
> >>> +                     The filter object can expect to be called on Re=
lease()
> >>> +                     once the removal is done.
> >>> +
> >>> +             void UnregisterAllApplications()
> >>> +
> >>> +                     This unregisters all jobs of monitoring adverti=
sement.
> >>> +                     All filter objects can expect to be called on R=
elease()
> >>> +                     once the removals are done.
> >>
> >> I would rather not have an UnregisterAll. We didn=E2=80=99t need it un=
til now and the object monitor was always bound to the lifetime of the appl=
ication.
> > Ack.
> >>
> >>> +
> >>> +Properties   array{string} SupportedFilteringFeatures [read-only]
> >>> +
> >>> +                     This reflects the supported features of adverti=
sement
> >>> +                     monitoring. An application should check this be=
fore
> >>> +                     instantiate an object of org.bluez.Advertisemen=
tFilter1.
> >>> +
> >>> +                     Here are the potential features. More will be a=
dded.
> >>> +                     "SoftwareBasedFiltering"
> >>> +                     "PatternsWithORLogicRelation"
> >>> +                     =E2=80=9CRSSIMonitoring=E2=80=9D
> >>
> >> So all our string values are lower-case and if needed we use - to sepa=
rate words or logical details.
> >>
> >> I think exposing a good interface for selecting the filter patterns wi=
ll take a bit. I would like to focus on getting the surrounding framework f=
igured out first.
> >>
> >> Before finalizing an API, my test was always to write a simple client =
and check if it meets the requirement for being simple enough. If it become=
s cumbersome for the client, then we need to consider putting some of the m=
ore complicated parts into bluetoothd.
> >>
> >> Let me try to give an example. If the majority of the clients just wan=
t to find a device with UUID 0xFE23, then we should have a special casing f=
or that.
> >>
> >>        RegisterMonitor(monitor, dict{MatchUUID=3D0xFE23}).
> >>
> >> Done. That they have to differentiate between one vendors way of doing=
 this compared to another on how to provide the information should be up to=
 bluetoothd to figure it out (and yes, I know it is not as simple when the =
AD type is a list).
> > Again, this was close to what I proposed earlier where the thresholds
> > and the filtering conditions are provided upon function call. Please
> > see my above comments on why I think this may not be sufficient.
>
> I fully realize that not all will be possible. Especially when it comes t=
o UUID lists. But for something like match on vendor specific AD with compa=
ny id x it might be.
I am not sure what you refer to by "company id". For now, the known
use cases don't come along with any specific company information.

Thanks,
Miao
