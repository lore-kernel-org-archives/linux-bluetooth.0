Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CC67FE10-4698-4AE8-BE33-57F0577B02EA@holtmann.org>
References: <1422471136-18575-1-git-send-email-jamuraa@chromium.org>
	<1422471136-18575-2-git-send-email-jamuraa@chromium.org>
	<81C91E2D-16C2-429D-90CC-E4B1BE1E3FC5@holtmann.org>
	<CAJLTA8gF9pNA26dtNR7-HHQA9pHQjWvmgowdmL9HVZNKaqfrYA@mail.gmail.com>
	<CC67FE10-4698-4AE8-BE33-57F0577B02EA@holtmann.org>
Date: Thu, 29 Jan 2015 11:34:15 +0200
Message-ID: <CABBYNZJnSGAD7i3RUgu8Wu=6oBWF867fnRbvtFVG16uvFg4X0Q@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/1] doc: Add Advertising API documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michael Janssen <jamuraa@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 29, 2015 at 5:03 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Michael,
>
>>>> doc/advertising-api.txt | 124 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> 1 file changed, 124 insertions(+)
>>>> create mode 100644 doc/advertising-api.txt
>>>>
>>>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>>>> new file mode 100644
>>>> index 0000000..6a325c7
>>>> --- /dev/null
>>>> +++ b/doc/advertising-api.txt
>>>> @@ -0,0 +1,124 @@
>>>> +LE Advertising Manager
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +
>>>> +LE Advertising Manager allows external applications to control the ac=
tivity and
>>>> +the content of LE Advertising Events.  Applications may use the prope=
rties of
>>>> +this object to modify the advertising data elements included in Adver=
tising
>>>> +Events, and enable and disable advertising.
>>>> +
>>>
>>> I was looking into this the other day. And what we really want is multi=
ple advertising instances. So that if you have hardware support, the kernel=
 can map it to a hardware feature, if you don't, then the kernel will emula=
te it with rotating the advertising information.
>>>
>>> From a low-level LE link layer that is all valid since you can have mul=
tiple LL state machines active at the same time. It is just currently there=
 is not HCI to actually handle this.
>>>
>>> Where I am sitting right now, this should be done with the API that pro=
vides the support for GATT service application.
>>>
>>> What this means is that when you want to use the D-Bus GATT API to writ=
e a GATT service in an application, then this service should be able to say=
, I want to advertise with these settings. And then bluetoothd and the kern=
el will manage this for the lifetime of this GATT service application.
>>
>> I'm not opposed to this, but how would we deal with advertising data
>> that is not tied to a specific GATT service, i.e. iBeacon or similar?
>> Also if we are rotating between all the advertising packets, having a
>> lot of services may be a problem for rotating.  I'm also unclear on
>> what receivers of the advertisement data will do if they are from the
>> same address (non-random).  The idea behind having a single manager
>> was that the bytes in the advertising data are limited, so managed
>> through a single point to ensure exact data is in there.
>
> iBeacon would be just a special case. We do want reference count an app w=
anting to publish an iBeacon frame. Also keep in mind that with iBeacons we=
 would need the whole AD since it is actually rather large.
>
> And of course it would be optional for service to advertise with special =
entries. Some service might not want to ever advertise. For example battery=
 service or something that is there and can be utilized, but does not reall=
y have a counterpart on the other side that requires it to be discovered. F=
or me this just means that the GATT service/application will tell bluetooth=
d that is requires to include this UUID or service data or something else. =
Or if it is optional. I think what is more important is that if you want to=
 advertise without being connectable like for iBeacons (or broadcaster role=
 in LE speak).
>
> Advertising different data with the same address is valid, but should be =
avoided if we can. However in some cases we might not have a chance since A=
D and scan response fields are tiny.
>
>>> From the kernel side this means we just allow multiple combinations of =
advertising type, interval, address, advertising data, scan response data a=
nd something new I can not talk about in public yet.
>>
>> This sounds good to me, I was also considering to have scan response
>> data, since it is related and similar.
>>
>>> I want to include advertising type here since you might want to use ADV=
_NONCONN_IND with a non-resolvable random address for some broadcast detail=
s every 10 minutes, but that should interfere with the details you might wa=
nt to broadcast for your weight scale application that is looking for a mas=
ter to reconnect.
>>>
>>> While the kernel always has the default advertising data and scan respo=
nse data as it does right now (which I would call application/service 0), w=
e want to allow for multiple application/services in addition to that. And =
I do have a basic idea on how to do this from a mgmt API point of view. How=
ever there is some new Bluetooth SIG work ongoing that I might want to be p=
repared for before posting this.
>>
>> I'd rather not wait for BT SIG work to land before we do something
>> here.  Advertisement has been in the spec for a long time and BlueZ
>> can't do anything but the basic flags and TX power (advertisement) and
>> name (scan response).
>> Yes, looking at this closer there's nothing an app can control, and
>> it's doubly mandatory so probably remove this and just tack it on the
>> front of any advertising data that gets sent when it's required.
>>
>>>> +
>>>> +             array(array{byte}) ManufacturerSpecificData
>>>> +
>>>> +                     Manufacturer specific data.  Each entry is trans=
mitted
>>>> +                     as a a separate advertisement data type.
>>>
>>> You need to define the manufacturer ID here as well.
>>
>> The array is meant to include the Manufacturer ID placed in the first
>> two bytes of each entry.
>
> That would mean exposing little endian data to an application. That is go=
ing to break. Apple already did not figure out on how to encode their own m=
anufacturer id correctly ;)
>
> So you really want a array{struct(uint16,array{byte}} here.
>
>>>> +
>>>> +             array(string) SolicitUUIDs
>>>> +
>>>> +                     List of UUIDs to include in the
>>>> +                     "service-solicitation" advertisement data.
>>>> +
>>>> +             dict(string,array{byte}) ServiceData
>>>> +
>>>> +                     Dictionary of Service UUIDs attached to data ass=
ociated
>>>> +                     with that service to include in the "service-dat=
a"
>>>> +                     advertisement data.
>>>
>>> If I remember this correctly, then this allows multiple instances for t=
he same UUID.
>>
>> array(struct(string,array{byte})) then
>>
>>>> +
>>>> +             array{byte} TargetAddress
>>>> +
>>>> +                     Target Address to use in the "random-target-addr=
ess" or
>>>> +                     "public-target-address"
>>>
>>> The reason why the AD types have two here is that you need to worry abo=
ut the actual address type in LE. And honestly I would not worry about this=
 at all since it is not used in anywhere at the moment.
>>
>> I was confused by these two Advertising Types anyway because why
>> wouldn't you just use ADV_DIRECT_IND instead.  I'm okay with removing
>> them.
>
> Actually they can contain multiple address. So it would be say you use AD=
V_IND and then put 2 or more addresses in the list so you see who these are=
 for. But as I said, I have not seen these used ever.
>
> And HID devices utilize ADV_DIRECT_IND since that makes more sense. In ad=
dition with Bluetooth 4.1 you get low-duty cycle directed advertising. So a=
 lot more value in using ADV_DIRECT_IND.
>
>>>> +
>>>> +             int AdvertisingInterval
>>>> +
>>>> +                     The interval to advertise at, in 0.625ms units. =
Minimum
>>>> +                     is 32 (20ms), maximum is 16384 (10.24s)
>>>> +
>>>> +                     Possible Errors: org.bluez.Error.InvalidArgument
>>>
>>> This is something that should be fundamentally taken from the basic inp=
ut. If we are running multiple instances of advertising, then providing the=
 min and max values are important. However this one has a big problem. The =
HCI side takes an interval so that they controller can move it. The AD expe=
cts to give you the exact one. This is not something that can be used succe=
ssful.
>>>
>>> And actually this has a technical change coming that I can not talk abo=
ut in public.
>>>
>>> However what we do want to provide is the slave connection interval (in=
 case we want to allow connections with this instance), but right now we ar=
e not even utilizing this from the central side. Which is something we shou=
ld be doing. However it means that we need to scan before calling LE connec=
t. Hint hint hint ;)
>>>
>>>> +
>>>> +             array{byte} LEAddress
>>>> +
>>>> +                     Address to advertise as the LE Address for this =
device.
>>>
>>> This is for LE out-of-band pairing and has nothing to do with advertisi=
ng.
>>>
>>>> +
>>>> +             string LEPreferred
>>>> +
>>>> +                     The preferred role of this device if it supports=
 both
>>>> +                     Central and Peripheral roles.  One of "central" =
or
>>>> +                     "peripheral".  This influences the advertised va=
lue of
>>>> +                     the "le-role" advertising data type when both mo=
des are
>>>> +                     supported.
>>>
>>> Same here. This is for LE out-of-band pairing.
>>
>> Both of these aren't prohibited (like the other OOB data fields) from
>> being in the advertisement / scan response.  I included them for
>> completeness. If they aren't going to be used in practice (like the
>> target address fields) we can remove them.
>
> There are prohibited. It is just that the CSS document does not explicitl=
y say it. We most likely should just file an errata against it and get this=
 fixed.
>
>>
>>>> +
>>>> +             int AdvertisingLength (read-only)
>>>> +
>>>> +                     Calculated length of the Advertising Data packet=
.
>>>
>>> Seems rather useless information. Also does not really factor in the ca=
se that some data might be in the scan response packet.
>>
>> This would be useful to see whether the packet is too long with
>> current data in it.  I guess it would be clarified that it is the
>> calculated response length if everything was included.  As for scan
>> response, this wasn't meant to handle that but it does have close ties
>> to this doesn't it.
>
> Personally I would never do it this way. I would do it like this:
>
>         app -> bluetoothd: I need a, b, c fields included
>
>         bluetoothd -> app: Okay, but I can only do b and c at the moment
>
>         app: I am okay with that / I am not okay with that
>

I was thinking about org.bluez.GattManager1.RegisterService taking
that as options e.g.  {"Data", "..."}, {"ManufacturerData", (...)},
etc, or we can have an agent interface with these details which would
help if these can change over time since then the app just need to
emit PropertiesChanged signal so bluetoothd can update them without
having to remove and add them back, we could actually handle the
advertising implicitly if there is any agent with data we advertise
all of them remove we stop advertising. Obviously this goes in
addition to GattService1, GattCharacteristic1, etc. In the other hand
if we have this in GattManager this may look like GATT specific so
perhaps renaming it to ServiceManager or LEServiceManager would be
better, but overall I think it is a much cleaner API to control
Advertisement Data, well cleaner and less error prone because setting
a property + calling Advertise seems prone to races.

--=20
Luiz Augusto von Dentz
