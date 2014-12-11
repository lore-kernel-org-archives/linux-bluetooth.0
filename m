Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CAHrH25SEnX+7+QtmuaAX8jX9ZdZXfV1uvUUo6h8SRK7cD1nfhA@mail.gmail.com>
References: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
	<68E1833E-A428-49C4-9D10-774813152877@holtmann.org>
	<CAHrH25SEnX+7+QtmuaAX8jX9ZdZXfV1uvUUo6h8SRK7cD1nfhA@mail.gmail.com>
Date: Wed, 10 Dec 2014 16:40:17 -0800
Message-ID: <CAHrH25Rb0pBL8USTRrqYZBLsbaPGi_Yt7xmjBjBP5E9X88nxzQ@mail.gmail.com>
Subject: Re: D-Bus API for GATT Connect/Disconnect
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Jonathan Dixon <joth@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Wed, Dec 10, 2014 at 1:38 PM, Arman Uguray <armansito@google.com> wrot=
e:
> Hi Marcel,
>
>> On Wed, Dec 10, 2014 at 1:11 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>> Hi Arman,
>>
>>> For GATT, applications using bluetoothd currently need to use
>>> Device1.Connect and Device1.Disconnect when they want to initiate a
>>> connection to a peripheral, though these functions are really
>>> primarily meant for UI usage. BlueZ already has a D-Bus API for BR/EDR
>>> profiles such as ConnectProfile/DisconnectProfile and the
>>> ProfileManager API which is more geared towards applications and I
>>> think we'll need something for GATT as well. The basic features that
>>> I'm thinking of are:
>>>
>>>   1. Sessions per D-Bus connection that provide a reference count for
>>> the ACL connection.
>>>   2. Correctly handling the reference count if the connection was
>>> initiated via Device1.Connect or via auto-connect.
>>>   3. This would be GATT only at first but it could perhaps expand to
>>> connection-oriented channels eventually?
>>>
>>> I don't really have an RFC API proposal at this point but I wanted to
>>> get this discussion going. What would make most sense here?
>>
>> the basic concept behind ProfileManager API that we used for BR/EDR work=
ed out pretty nicely. So maybe extend the general idea with the agent and c=
allbacks to GattManager.
>>
>> When looking at the difference then we are talking about accessing remot=
e GATT service via a local GATT profile. So what we want is implement that =
profile handling in an application.
>>
>
> Right, though there are some edge cases to consider. I think that if
> I'm implementing the server-role of a GATT profile (some I'm
> registering GATT services via D-Bus), I probably don't care much about
> the status of the connection, since I'll likely be just sitting and
> listening. So the connection mostly makes sense for central-role
> applications, except if I'm implementing the peripheral end of a CoC.
>
>> If we want to avoid overloading we could use GattProfileManager and Gatt=
Profile as terms to implement that. However the general idea that you get t=
he connection status via the callback (in this case it would be an object p=
ath and not a fd of course) seem still valid. Especially with LE we have to=
 handle the auto-connect cases gracefully.
>>
>
> I think this makes sense. What I'm thinking is that if you're in the
> server role, you expose a GattProfile that has all the GattService1
> objects as children of the tree and register with GattProfileManager.
> If you're in the central role, you only register yourself as a profile
> if you want to explicitly initiate a connection. If you don't care
> about the connection (e.g. you're just showing the battery level from
> a secondary Battery Service on already connected peripherals) then you
> can just work with the GattService1 objects already exported under the
> device. Otherwise you register yourself as a GattProfile and get
> updates on the connection.
>
>> And if we have a connection oriented channel assigned with a GATT profil=
e, then that could be just reported via an extra callback. In that case it =
would be exactly like we do within ProfileManager.
>
> Yep, that makes sense.
>
>>
>> Regards
>>
>> Marcel
>>
>
> Cheers,
> Arman

And just following up on my previous response, we would then need
Device1.ConnectGatt and Device1.DisconnectGatt methods that parallel
ConnectProfile/DisconnectProfile? But then ConnectGatt wouldn't accept
a UUID but instead it would invoke the GattProfile callbacks based on
discovered services?

In that case, would the regular Device1.Connect also cause registered
GattProfile's callbacks to be invoked? (This is all while accessing
the remote GATT services).

Thanks,
Arman
