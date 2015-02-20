Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
Date: Fri, 20 Feb 2015 09:09:43 -0800
Message-ID: <CAD0=r8znZBuoMSZmPdUcau7dRNc=-KTZTQCTeCY-EEz+xryj2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 16, 2015 at 12:46 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Tue, Feb 10, 2015 at 2:34 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
>> API for desktop bluetoothd. It will allow for rapid discovery of nearby
>> devices that advertise services.
>>
>> It also adds FilteredDiscovery property, that is set to true when any
>> StartFilteredDiscovery session is active.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>
> We don't use Signed-off-byin userspace, I can fix this myself this
> time but please don't sent patches with it anymore.

Ok, thanks
>
>> ---
>>  doc/adapter-api.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> index 74d235a..b59019d 100644
>> --- a/doc/adapter-api.txt
>> +++ b/doc/adapter-api.txt
>> @@ -22,6 +22,50 @@ Methods              void StartDiscovery()
>>                         Possible errors: org.bluez.Error.NotReady
>>                                          org.bluez.Error.Failed
>>
>> +               void StartFilteredDiscovery(dict filter)
>> +
>> +                       This method starts the device discovery session with
>> +                       filtering by uuids, and rssi or pathloss value. Use
>> +                       StopDiscovery to release the sessions acquired.
>> +
>> +                       Parameters that can be set in filter dictionary include
>> +                       the following:
>> +
>> +                       array{string} UUIDs : filtered service UUIDs (required)
>> +                       int16 RSSI      : RSSI threshold value (optional)
>> +                       uint16 pathloss : Pathloss threshold value (optional)
>> +                       string transport: type of scan to run
>> +
>> +                       When a device is found that advertise any UUID from
>> +                       UUIDs, it will be reported if:
>> +                       - pathloss and RSSI are both empty,
>> +                       - only pathloss param is set, device advertise TX pwer,
>> +                         and computed pathloss is less than pathloss param,
>> +                       - only RSSI param is set, and received RSSI is higher
>> +                         than RSSI param,
>> +
>> +                       transport parameter determines the type of scan:
>> +                               "auto"  - interleaved scan
>> +                               "bredr" - br/edr inquiry
>> +                               "le"    - le only scan, default value
>> +
>> +                       This process will start creating Device objects as new
>> +                       devices matching criteria are discovered. It will also
>> +                       emit PropertiesChanged signal for already existing
>> +                       Device objects, with updated RSSI value.
>> +
>> +                       StartDiscovery (SD) takes precedence over
>> +                       StartFilteredDiscovery (SFD). That means that you should
>> +                       check Discovering property before calling SFD, otherwise
>> +                       it would fail when any SD session is in progress.
>> +                       Calling SD when SFD is in progress pause all SFD
>> +                       sessions, and start them back when all SD sessions are
>> +                       finished. When filtered discovery state is changed,
>> +                       FilteredDiscovery variable is updated accordingly.
>> +
>> +                       Possible errors: org.bluez.Error.NotReady
>> +                                        org.bluez.Error.Failed
>> +
>>                 void StopDiscovery()
>>
>>                         This method will cancel any previous StartDiscovery
>> @@ -144,6 +188,11 @@ Properties string Address [readonly]
>>
>>                         Indicates that a device discovery procedure is active.
>>
>> +               boolean FilteredDiscovery [readonly]
>> +
>> +                       Indicates that a filtered device discovery procedure is
>> +                       active.
>> +
>>                 array{string} UUIDs [readonly]
>>
>>                         List of 128-bit UUIDs that represents the available
>> --
>> 2.2.0.rc0.207.ga3a616c
>
> @Marcel, Johan: Is this API okay for you? We should probably make them
> experimental to begin with.

Ping ?

>
>
> --
> Luiz Augusto von Dentz
