Return-Path: <cyrus@holtmann.org>
From: "Gu, Chao Jie" <chao.jie.gu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>, Arman Uguray
	<armansito@chromium.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
Subject: RE: [RFC v1 0/1] doc/gatt-api: New API properties and methods for
 the GATT D-Bus API.
Date: Thu, 24 Jul 2014 04:11:23 +0000
Message-ID: <3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
 <20140722085507.GA29664@t440s.lan>
 <CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
 <3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
 <CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
 <D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
In-Reply-To: <D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,=20

> Explain to me how, using only the InterfacesAdded signal, an=20
> application can know that all characteristic objects under a service=20
> hierarchy have been added? The only way is if the external application=20
> already knows about service it's interacting with, which is not the=20
> case if you're building a generic application API on top of=20
> bluetoothd. Without what I'm proposing, you can't build a generic GATT=20
> application API without requiring cumbersome event handling for each=20
> service, characteristic, and descriptor object as they get added and=20
> have only partial access to these objects in the handlers as the=20
> objects are getting processed. This might be fine for low-level=20
> applications that interact with D-Bus directly, but for higher level=20
> app developers this is a real issue that we want to handle properly=20
> and make their lives easier.

You are right, we work on Tizen Bluetooth-frwk which is low-level service/a=
pplication in system . Bluetooth-frwk can take a role to handle D-Bus infor=
maiton and give defined API to application such as characteristic discovery=
 method, so we refer to different level application indeed.
>From your aspect, I understood that you consider that high level app develo=
per how to get characteristic array directly from bluetoothd. .=20

Thanks
Chaojie
-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Thursday, July 24, 2014 12:33 AM
To: Arman Uguray
Cc: Gu, Chao Jie; BlueZ development; Johan Hedberg
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for =
the GATT D-Bus API.

Hi Arman,

>> Of course if DBus has these array object of characteristic property, the=
re is more clear and easy for client to get. However, in my opinion, bluez =
just put out least but enough information in DBus Hierarchy for application=
 to use. Just you said, to add array object property , this could even be a=
 simple boolean property such as "DiscoveryComplete". That would be add mor=
e property in DBus, so on the contrary it would not let DBus Hierarchy look=
 simple and clear.
>> Through the objectAdded and InterfaceAdded Signal, application can acqui=
re this subset of object in fact.
>=20
> Explain to me how, using only the InterfacesAdded signal, an=20
> application can know that all characteristic objects under a service=20
> hierarchy have been added? The only way is if the external application=20
> already knows about service it's interacting with, which is not the=20
> case if you're building a generic application API on top of=20
> bluetoothd. Without what I'm proposing, you can't build a generic GATT=20
> application API without requiring cumbersome event handling for each=20
> service, characteristic, and descriptor object as they get added and=20
> have only partial access to these objects in the handlers as the=20
> objects are getting processed. This might be fine for low-level=20
> applications that interact with D-Bus directly, but for higher level=20
> app developers this is a real issue that we want to handle properly=20
> and make their lives easier.

since InterfacesAdded is per object path, the extra Characteristics array m=
akes sense. However that really only applies to application passively monit=
oring the bus objects and properties. The initiator of service discovery sh=
ould only return from that method call when all other object signals have b=
een send out. Similar to what we are doing with pairing or other potential =
long run asynchronous method calls.

Regards

Marcel
