Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5BCE56B6-FE77-4CD3-ADC1-BC40DD39DA56@holtmann.org>
References: <1418305513-4327-1-git-send-email-jpawlowski@google.com>
	<CAHrH25RzOXdJ9es+PZ+PAvjn3kUYFdQ1nvsxStuLLmpso9f73g@mail.gmail.com>
	<5BCE56B6-FE77-4CD3-ADC1-BC40DD39DA56@holtmann.org>
Date: Fri, 12 Dec 2014 11:47:32 +0100
Message-ID: <CAD0=r8zLHD=L_VDQNgTn0S-zBbyHSsL2WLM8NS3A9492_s3nig@mail.gmail.com>
Subject: Re: [PATCH v2] doc/adapter-api.txt: StartServiceDiscovery method.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 11, 2014 at 5:07 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arman,
>
>>> On Thu, Dec 11, 2014 at 5:45 AM, Jakub Pawlowski <jpawlowski@google.com=
> wrote:
>>> This patch proposes new method, StartServiceDiscovery to D-Bus Adapter =
API for
>>> desktop bluetoothd. It will allow for rapid discovery of nearby devices=
 that
>>> advertise services.
>>>
>>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>>
>> Omit "signed-off by" please.
>>
>>> ---
>>> doc/adapter-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 38 insertions(+)
>>>
>>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>>> index 74d235a..198a35a 100644
>>> --- a/doc/adapter-api.txt
>>> +++ b/doc/adapter-api.txt
>>> @@ -22,6 +22,44 @@ Methods              void StartDiscovery()
>>>                        Possible errors: org.bluez.Error.NotReady
>>>                                         org.bluez.Error.Failed
>>>
>>> +               void StartServiceDiscovery(string mode, dict filter)
>>> +
>>
>> I mentioned this before during the mgmt API patches (though I didn't
>> feel strongly about it) and I'm mentioning it now (this time I feel
>> more strongly) that I don't like the term "ServiceDiscovery" here. It
>> makes me immediately think of ATT/SDP, which is not what this API
>> doing. What's more, I can easily imagine that we potentially extend
>> this API to filter by other types of parameters, such as the
>> manufacturer data field for instance, so maybe it's better to rename
>> this to something more generic like "RequestDevice" or
>> "ScanDevicesWithFilter" (or something along those lines).
>>
>> The behavior of this API with respect to simultaneous use by multiple
>> applications should be defined here as well. When more than one
>> application calls this, is the behavior basically "adding a new UUID
>> filter to the ongoing scan"?
>>
>> Also, earlier we were talking about a one-shot API that would return
>> the object paths of devices that the application is particularly
>> concerned with. Is that the approach we should take here? Or are we
>> basically saying that applications should rely on InterfacesAdded
>> signals and then do their additional filtering on top of that based on
>> Device properties?
>
> I think that can be achieved by something simple like DiscoverDevices whi=
ch will return an array of device objects. It is more for the simple applic=
ation that knows exactly what it is looking for.
>
> The only real difference is that StartDiscovery and alike will keep runni=
ng until it is stopped, while a one-shot trigger will just stop once device=
s are found or when it has been cancelled.
>
> If a DiscoverDevices is enough for your use case, then I say, lets go tha=
t direction. It is simpler and a lot easier. Per each application we could =
allow one DiscoverDevices running at the same time. When called from multip=
le application then bluetoothd will take care of combining the filter and m=
ultiplexing it. The DiscoverDevices will run until it finds at least one de=
vice with the matching filter parameters or CancelDiscoverDevices is called=
. Then the caller can decide to run it again or connect to that found devic=
e.
>


So let's name this new method StartFilteredDiscovery

Here's how I want this method to work and why:

You call StartFilteredDiscovery, and it returns immediately, devices
are returned just like when running StartDiscovery - by creating or
updating Device1 object.
Then the caller will stop the filtered scan by running StopDiscovery.

I don't want to have this method block on call and return a device or
array of devices because:
* how do I decide wether to stop after one or n devices being
discovered ? If we use same approach as with StartDiscovery you can
just call StopDiscovery, and each app might decide when it's happy
with results
* if I decide to stop after one device, and then restart scan how do I
make sure that the scan would return next, not same device ?
* when we filter by RSSI or Pathloss, we might want to do something
fancy in the future to smooth the values a little bit, because raw
RSSI values sometimes have noises and spikes that we want to get rid
of. If we have Start/Stop approach, we have peroid in which we monitor
RSSI values and feed them to 'smoothing' algorithm. If we restart scan
multiple times it all get compilcated.



>>> +                       This method starts the device discovery session=
 with
>>> +                       filtering by uuids, and rssi or pathloss value.=
 Use
>>> +                       StopDiscovery to release the sessions acquired.
>>> +
>>
>> You should document the behavior of this method if StartDiscovery was
>> called earlier. Does it just fail in that case or is it a no-op?
>>
>>> +                       mode parameter:
>>> +                               "LE" - le only scan
>>> +                               "BR/EDR" - br/edr inquiry
>>> +                               "INTERLEAVED" - interleaved scan
>>
>> This parameter looks to MGMT-like. Why do we need an "interlaved"
>> flag? Should an application care about which technology is being used?
>> Should this just be automatically determined by bluetoothd?

Yes we care alot. If we i.e. want to discover LE only devices, using
interleaved scan like in StartDiscovery will scan LE for 10 seconds,
then do Classic inquiry for 10 seconds and repeat until StopDiscovery
is called.

That will leave you with 10 second where you don't report LE devices,
and that's very bad for my use case. If you specify you want LE only,
you'll scan all the times.

>
> I think we want to call it Bearer or Transport. And it should essentially=
 be specified "le" or "bredr" or "auto" as possible modes. The interleaved =
/ auto should be assumed by just leaving the parameter out.
>
>>
>>> +
>>> +                       Parameters that can be set in filter dictionary=
 include
>>> +                       the following:
>>> +
>>> +                               string UUID : filtered service UUID (re=
quired)
>
> We obviously want a list of UUIDs so this should be an array{string}.
>
>>> +                               string RSSI : RSSI threshold value (opt=
ional)
>
> RSSI should be a int16 like we have with the other properties.
>
>>> +                               string pathloss : Pathloss threshold va=
lue
>>> +                                                   (optional)
>
> And Pathloss should also be int16 if it needs to be signed or uint8/byte =
if it doesn't. I would need to look this up again.
>
It needs to be uint8, but there's no uint8 in D-Bus so I'll leave it as uin=
t16

>>> +
>>> +                       When a device is found that advertise UUID, it =
will be
>>> +                       reported if:
>>> +                       - pathloss and RSSI are both empty
>>> +                       - only pathloss param is set, device advertise =
TX pwer,
>>> +                         and computed pathloss is less than pathloss p=
aram,
>>> +                       - only RSSI param is set, and received RSSI is =
higher
>>> +                         than RSSI param,
>>> +                       - both pathloss and RSSI is set. Then if TX pow=
er is
>>> +                         advertised, pathloss condition must be met, o=
therwise
>>> +                         RSSI condition must be met.
>
> Personally I would say either RSSI or Pathloss can be specified. If both =
are specified, then an error will be returned. Obviously devices without TX=
 Power field will be ignored.
>
>>> +
>>> +                       This process will start creating Device objects=
 as new
>>> +                       devices matching criteria are discovered. It wi=
ll also
>>> +                       emit PropertiesChanged signal for already exist=
ing
>>> +                       Device objects, with updated RSSI value.
>>> +
>>> +                       Possible errors: org.bluez.Error.NotReady
>>> +                                        org.bluez.Error.Failed
>>> +
>>>                void StopDiscovery()
>>>
>>>                        This method will cancel any previous StartDiscov=
ery
>
> Regards
>
> Marcel
>
