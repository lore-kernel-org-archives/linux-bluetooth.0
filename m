Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on
 Device1
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
Date: Wed, 6 Sep 2017 09:55:52 -0400
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz and Emil,

Thanks for your comments!

> On Sep 6, 2017, at 9:01 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
>> I know there were some discussions regarding if it should be called
>> max attribute size or mtu.
>> Maybe I'm a bit late but in my opinion I think mtu is a better =
option.
>>=20
>> "The maximum supported byte size of attributes, as negotiated between
>> this host and the remote device" is a bit misleading/wrong since the
>> BLE spec allows up to 512 byte attribute values no matter of the MTU.
>=20
> Note that the MTU can be in fact even bigger than 512 bytes since it
> can be used by things like discover, etc, which is not bound to a
> single attribute, though for practical reasons BlueZ will always
> request 512 bytes since buffer size is usually not a concern in
> systems running Linux.
>=20
>> You can still perform a Long Write where the attribute value is =
larger
>> than the MTU for example.
>> Also, the max value size for transfer is different depending on
>> method. Max value size for a notification/indication or normal write
>> is ATT_MTU-3 while max value size for a normal read is ATT_MTU-1.
>=20
> Yep, we can't really use the same value for read/write since the
> actual payload changes depending on the opcode.
>=20
>> With the current patch it's not clear (by only looking at the
>> documentation) which value "max attribute size" really means. If it's
>> called MTU it's on the other hand very clear what it is (like it is
>> called in Android's implementation). Even if there is a difference
>> between BD/EDR and LE MTU negotiation, the packet format for ATT and
>> the meaning of MTU is still the same.
>=20
> The fundamental part missing here is that over BR/EDR the MTU can be
> asymmetric meaning we need the MTU value for input and output to be
> separated.

Hm.  BR/EDR isn't even the intended use case here, and (as you point =
out) complicates the API greatly.  And in general, I agree with Emil =
that the MTU is really what many clients of this API are interested in.

What if I reformulate the API as LE-specific, and instead of making the =
API about Maximum Attribute Size, I return to simply making the MTU =
available to dbus clients.  That's all I really want for my use case, =
and I'll make an effort to make the documentation sufficiently =
educational that developers should be able to do the right thing.  What =
about this?

+		int16 LENegotiatedATTMTU [readonly,
+		                          optional,
+		                          experimental]
+
+			The Maximum Transmission Unit of the ATT =
protocol,
+			as negotiated with this device by bluetoothd.  =
This=20
+			property is only available for devices connected =
via=20
+			BTLE, and only after MTU negotiation is =
complete.
+			If this property is not available, clients may
+			only assume a MTU of 23 bytes, as required by =
the=20
+			Bluetooth specification.
+			The maximum GATT attribute data is MTU - 3, =
although
+			some devices may support Long Read and Long =
Write
+			commands, allowing for larger attribute data =
sizes.
+

Best,

Jonah


