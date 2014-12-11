Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] doc/adapter-api.txt: StartServiceDiscovery method.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RzOXdJ9es+PZ+PAvjn3kUYFdQ1nvsxStuLLmpso9f73g@mail.gmail.com>
Date: Thu, 11 Dec 2014 17:07:09 +0100
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5BCE56B6-FE77-4CD3-ADC1-BC40DD39DA56@holtmann.org>
References: <1418305513-4327-1-git-send-email-jpawlowski@google.com> <CAHrH25RzOXdJ9es+PZ+PAvjn3kUYFdQ1nvsxStuLLmpso9f73g@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> On Thu, Dec 11, 2014 at 5:45 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
>> desktop bluetoothd. It will allow for rapid discovery of nearby devices that
>> advertise services.
>> 
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> 
> Omit "signed-off by" please.
> 
>> ---
>> doc/adapter-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>> 
>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> index 74d235a..198a35a 100644
>> --- a/doc/adapter-api.txt
>> +++ b/doc/adapter-api.txt
>> @@ -22,6 +22,44 @@ Methods              void StartDiscovery()
>>                        Possible errors: org.bluez.Error.NotReady
>>                                         org.bluez.Error.Failed
>> 
>> +               void StartServiceDiscovery(string mode, dict filter)
>> +
> 
> I mentioned this before during the mgmt API patches (though I didn't
> feel strongly about it) and I'm mentioning it now (this time I feel
> more strongly) that I don't like the term "ServiceDiscovery" here. It
> makes me immediately think of ATT/SDP, which is not what this API
> doing. What's more, I can easily imagine that we potentially extend
> this API to filter by other types of parameters, such as the
> manufacturer data field for instance, so maybe it's better to rename
> this to something more generic like "RequestDevice" or
> "ScanDevicesWithFilter" (or something along those lines).
> 
> The behavior of this API with respect to simultaneous use by multiple
> applications should be defined here as well. When more than one
> application calls this, is the behavior basically "adding a new UUID
> filter to the ongoing scan"?
> 
> Also, earlier we were talking about a one-shot API that would return
> the object paths of devices that the application is particularly
> concerned with. Is that the approach we should take here? Or are we
> basically saying that applications should rely on InterfacesAdded
> signals and then do their additional filtering on top of that based on
> Device properties?

I think that can be achieved by something simple like DiscoverDevices which will return an array of device objects. It is more for the simple application that knows exactly what it is looking for.

The only real difference is that StartDiscovery and alike will keep running until it is stopped, while a one-shot trigger will just stop once devices are found or when it has been cancelled.

If a DiscoverDevices is enough for your use case, then I say, lets go that direction. It is simpler and a lot easier. Per each application we could allow one DiscoverDevices running at the same time. When called from multiple application then bluetoothd will take care of combining the filter and multiplexing it. The DiscoverDevices will run until it finds at least one device with the matching filter parameters or CancelDiscoverDevices is called. Then the caller can decide to run it again or connect to that found device.

>> +                       This method starts the device discovery session with
>> +                       filtering by uuids, and rssi or pathloss value. Use
>> +                       StopDiscovery to release the sessions acquired.
>> +
> 
> You should document the behavior of this method if StartDiscovery was
> called earlier. Does it just fail in that case or is it a no-op?
> 
>> +                       mode parameter:
>> +                               "LE" - le only scan
>> +                               "BR/EDR" - br/edr inquiry
>> +                               "INTERLEAVED" - interleaved scan
> 
> This parameter looks to MGMT-like. Why do we need an "interlaved"
> flag? Should an application care about which technology is being used?
> Should this just be automatically determined by bluetoothd?

I think we want to call it Bearer or Transport. And it should essentially be specified "le" or "bredr" or "auto" as possible modes. The interleaved / auto should be assumed by just leaving the parameter out.

> 
>> +
>> +                       Parameters that can be set in filter dictionary include
>> +                       the following:
>> +
>> +                               string UUID : filtered service UUID (required)

We obviously want a list of UUIDs so this should be an array{string}.

>> +                               string RSSI : RSSI threshold value (optional)

RSSI should be a int16 like we have with the other properties.
 
>> +                               string pathloss : Pathloss threshold value
>> +                                                   (optional)

And Pathloss should also be int16 if it needs to be signed or uint8/byte if it doesn't. I would need to look this up again.

>> +
>> +                       When a device is found that advertise UUID, it will be
>> +                       reported if:
>> +                       - pathloss and RSSI are both empty
>> +                       - only pathloss param is set, device advertise TX pwer,
>> +                         and computed pathloss is less than pathloss param,
>> +                       - only RSSI param is set, and received RSSI is higher
>> +                         than RSSI param,
>> +                       - both pathloss and RSSI is set. Then if TX power is
>> +                         advertised, pathloss condition must be met, otherwise
>> +                         RSSI condition must be met.

Personally I would say either RSSI or Pathloss can be specified. If both are specified, then an error will be returned. Obviously devices without TX Power field will be ignored.

>> +
>> +                       This process will start creating Device objects as new
>> +                       devices matching criteria are discovered. It will also
>> +                       emit PropertiesChanged signal for already existing
>> +                       Device objects, with updated RSSI value.
>> +
>> +                       Possible errors: org.bluez.Error.NotReady
>> +                                        org.bluez.Error.Failed
>> +
>>                void StopDiscovery()
>> 
>>                        This method will cancel any previous StartDiscovery

Regards

Marcel

