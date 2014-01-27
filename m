Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FC28B407-F3B2-4969-A5FD-35AB73316DF5@holtmann.org>
References: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
	<1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
	<1390845656-29880-2-git-send-email-claudio.takahasi@openbossa.org>
	<FC28B407-F3B2-4969-A5FD-35AB73316DF5@holtmann.org>
Date: Mon, 27 Jan 2014 16:54:37 -0200
Message-ID: <CAKT1EBfkLuwMgQbm0TQfuGvWf=w7TN5LnzmMwdP+_zU86e6wmA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 01/18] doc: Add GATT API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel:

On Mon, Jan 27, 2014 at 3:15 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Claudio,
>
>> This patch proposes an unified GATT API for local and remote services.
>> ---
>> doc/gatt-api.txt | 145 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> 1 file changed, 145 insertions(+)
>> create mode 100644 doc/gatt-api.txt
>>
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> new file mode 100644
>> index 0000000..2d92f03
>> --- /dev/null
>> +++ b/doc/gatt-api.txt
>> @@ -0,0 +1,145 @@
>> +BlueZ D-Bus GATT API description
>> +********************************
>> +
>> +GATT local and remote services share the same high-level D-Bus API. Loc=
al
>> +refers to GATT based service exported by a BlueZ plugin or an external
>> +application. Remote refers to GATT services exported by the peer.
>> +
>> +BlueZ acts as a proxy, translating ATT operations to D-Bus method calls=
 and
>> +Properties (or the opposite). Support for D-Bus Object Manager is manda=
tory for
>> +external services to allow seamless GATT declarations (Service, Charact=
eristic
>> +and Descriptors) discovery.
>> +
>> +Service hierarchy
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +GATT remote and local service representation. Object path for local ser=
vices
>> +is freely definable.
>> +
>> +External applications implementing local services must register the ser=
vices
>> +using GattManager1 registration method and must implement the methods a=
nd
>> +properties defined in GattService1 interface.
>> +
>> +Service              org.bluez
>> +Interface    org.bluez.GattService1 [Experimental]
>> +Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/se=
rviceXX
>> +
>> +Methods              void Release()
>> +
>> +                     Release this service. At this point, it will not b=
e
>> +                     used by BlueZ anymore and can be destroyed by the
>> +                     owner. Method applicable to external GATT services
>> +                     implementations only (GATT servers).
>
> so this is the part I do not like that much. We should not define an inte=
rface that has a method that is valid and used only when this is a GATT ser=
ver.
>
> What I am thinking right now (and might need to discuss this a bit furthe=
r), we leave GattService1 without any methods and use it for both GATT clie=
nt and server.
>
> Then we create some GattServiceAgent1 or GattServiceCollection1 or maybe =
even GattServer1 that we can register with GattManager1 for the purpose of =
providing a Release method so that bluetoothd stays in control and can info=
rm applications if it decided to remove a service.
>
> I am even fine with allowing to provide multiple services in a collection=
/server registration. Thoughts?
>
> Regards
>
> Marcel

The "Service Agent" approach was suggested in beginning of our
discussion. I don't remember anymore why we decided to change it.

Unless you think that it is essential, we could implement the
Release() method later. When we start the client implementation we
will have a better understanding of our needs.
Can I remove the Release() and re-send the patchset?

Regards,
Claudio.
