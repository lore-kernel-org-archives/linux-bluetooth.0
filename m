Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <81C91E2D-16C2-429D-90CC-E4B1BE1E3FC5@holtmann.org>
References: <1422471136-18575-1-git-send-email-jamuraa@chromium.org>
	<1422471136-18575-2-git-send-email-jamuraa@chromium.org>
	<81C91E2D-16C2-429D-90CC-E4B1BE1E3FC5@holtmann.org>
Date: Wed, 28 Jan 2015 15:34:48 -0800
Message-ID: <CAJLTA8gF9pNA26dtNR7-HHQA9pHQjWvmgowdmL9HVZNKaqfrYA@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/1] doc: Add Advertising API documentation
From: Michael Janssen <jamuraa@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015 at 1:10 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Michael,
>
>> doc/advertising-api.txt | 124 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>> 1 file changed, 124 insertions(+)
>> create mode 100644 doc/advertising-api.txt
>>
>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>> new file mode 100644
>> index 0000000..6a325c7
>> --- /dev/null
>> +++ b/doc/advertising-api.txt
>> @@ -0,0 +1,124 @@
>> +LE Advertising Manager
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +LE Advertising Manager allows external applications to control the acti=
vity and
>> +the content of LE Advertising Events.  Applications may use the propert=
ies of
>> +this object to modify the advertising data elements included in Adverti=
sing
>> +Events, and enable and disable advertising.
>> +
>
> I was looking into this the other day. And what we really want is multipl=
e advertising instances. So that if you have hardware support, the kernel c=
an map it to a hardware feature, if you don't, then the kernel will emulate=
 it with rotating the advertising information.
>
> From a low-level LE link layer that is all valid since you can have multi=
ple LL state machines active at the same time. It is just currently there i=
s not HCI to actually handle this.
>
> Where I am sitting right now, this should be done with the API that provi=
des the support for GATT service application.
>
> What this means is that when you want to use the D-Bus GATT API to write =
a GATT service in an application, then this service should be able to say, =
I want to advertise with these settings. And then bluetoothd and the kernel=
 will manage this for the lifetime of this GATT service application.

I'm not opposed to this, but how would we deal with advertising data
that is not tied to a specific GATT service, i.e. iBeacon or similar?
Also if we are rotating between all the advertising packets, having a
lot of services may be a problem for rotating.  I'm also unclear on
what receivers of the advertisement data will do if they are from the
same address (non-random).  The idea behind having a single manager
was that the bytes in the advertising data are limited, so managed
through a single point to ensure exact data is in there.

> From the kernel side this means we just allow multiple combinations of ad=
vertising type, interval, address, advertising data, scan response data and=
 something new I can not talk about in public yet.

This sounds good to me, I was also considering to have scan response
data, since it is related and similar.

> I want to include advertising type here since you might want to use ADV_N=
ONCONN_IND with a non-resolvable random address for some broadcast details =
every 10 minutes, but that should interfere with the details you might want=
 to broadcast for your weight scale application that is looking for a maste=
r to reconnect.
>
> While the kernel always has the default advertising data and scan respons=
e data as it does right now (which I would call application/service 0), we =
want to allow for multiple application/services in addition to that. And I =
do have a basic idea on how to do this from a mgmt API point of view. Howev=
er there is some new Bluetooth SIG work ongoing that I might want to be pre=
pared for before posting this.

I'd rather not wait for BT SIG work to land before we do something
here.  Advertisement has been in the spec for a long time and BlueZ
can't do anything but the basic flags and TX power (advertisement) and
name (scan response).
Yes, looking at this closer there's nothing an app can control, and
it's doubly mandatory so probably remove this and just tack it on the
front of any advertising data that gets sent when it's required.

>> +
>> +             array(array{byte}) ManufacturerSpecificData
>> +
>> +                     Manufacturer specific data.  Each entry is transmi=
tted
>> +                     as a a separate advertisement data type.
>
> You need to define the manufacturer ID here as well.

The array is meant to include the Manufacturer ID placed in the first
two bytes of each entry.

>> +
>> +             array(string) SolicitUUIDs
>> +
>> +                     List of UUIDs to include in the
>> +                     "service-solicitation" advertisement data.
>> +
>> +             dict(string,array{byte}) ServiceData
>> +
>> +                     Dictionary of Service UUIDs attached to data assoc=
iated
>> +                     with that service to include in the "service-data"
>> +                     advertisement data.
>
> If I remember this correctly, then this allows multiple instances for the=
 same UUID.

array(struct(string,array{byte})) then

>> +
>> +             array{byte} TargetAddress
>> +
>> +                     Target Address to use in the "random-target-addres=
s" or
>> +                     "public-target-address"
>
> The reason why the AD types have two here is that you need to worry about=
 the actual address type in LE. And honestly I would not worry about this a=
t all since it is not used in anywhere at the moment.

I was confused by these two Advertising Types anyway because why
wouldn't you just use ADV_DIRECT_IND instead.  I'm okay with removing
them.

>> +
>> +             int AdvertisingInterval
>> +
>> +                     The interval to advertise at, in 0.625ms units.  M=
inimum
>> +                     is 32 (20ms), maximum is 16384 (10.24s)
>> +
>> +                     Possible Errors: org.bluez.Error.InvalidArgument
>
> This is something that should be fundamentally taken from the basic input=
. If we are running multiple instances of advertising, then providing the m=
in and max values are important. However this one has a big problem. The HC=
I side takes an interval so that they controller can move it. The AD expect=
s to give you the exact one. This is not something that can be used success=
ful.
>
> And actually this has a technical change coming that I can not talk about=
 in public.
>
> However what we do want to provide is the slave connection interval (in c=
ase we want to allow connections with this instance), but right now we are =
not even utilizing this from the central side. Which is something we should=
 be doing. However it means that we need to scan before calling LE connect.=
 Hint hint hint ;)
>
>> +
>> +             array{byte} LEAddress
>> +
>> +                     Address to advertise as the LE Address for this de=
vice.
>
> This is for LE out-of-band pairing and has nothing to do with advertising=
.
>
>> +
>> +             string LEPreferred
>> +
>> +                     The preferred role of this device if it supports b=
oth
>> +                     Central and Peripheral roles.  One of "central" or
>> +                     "peripheral".  This influences the advertised valu=
e of
>> +                     the "le-role" advertising data type when both mode=
s are
>> +                     supported.
>
> Same here. This is for LE out-of-band pairing.

Both of these aren't prohibited (like the other OOB data fields) from
being in the advertisement / scan response.  I included them for
completeness. If they aren't going to be used in practice (like the
target address fields) we can remove them.

>> +
>> +             int AdvertisingLength (read-only)
>> +
>> +                     Calculated length of the Advertising Data packet.
>
> Seems rather useless information. Also does not really factor in the case=
 that some data might be in the scan response packet.

This would be useful to see whether the packet is too long with
current data in it.  I guess it would be clarified that it is the
calculated response length if everything was included.  As for scan
response, this wasn't meant to handle that but it does have close ties
to this doesn't it.

Cheers,

Mike
