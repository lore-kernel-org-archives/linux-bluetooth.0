Return-Path: <linux@rempel-privat.de>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth>
 <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
 Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>,
 NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
Date: Fri, 19 Aug 2016 09:49:11 +0200
MIME-Version: 1.0
In-Reply-To: <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VHxBd5MV1Odhd5N5hhgXIHjOAb6RoHgag"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VHxBd5MV1Odhd5N5hhgXIHjOAb6RoHgag
Content-Type: multipart/mixed; boundary="HRvruFou90EX54O842tJCuXrXN0Tm1W5T"
From: Oleksij Rempel <linux@rempel-privat.de>
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
 Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>,
 NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth>
 <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
In-Reply-To: <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>

--HRvruFou90EX54O842tJCuXrXN0Tm1W5T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo Nikolaus,

do i understand it correctly. This driver is to make kind of interchip
communication and represent uart as a bus to allow use this bus from
multiple kernel driver or expose it to user space?

Correct?

Am 19.08.2016 um 09:29 schrieb H. Nikolaus Schaller:
> Hi,
>=20
>> Am 19.08.2016 um 07:21 schrieb Sebastian Reichel <sre@kernel.org>:
>>
>> Hi,
>>
>> On Thu, Aug 18, 2016 at 06:08:24PM -0500, Rob Herring wrote:
>>> On Thu, Aug 18, 2016 at 3:29 PM, Sebastian Reichel <sre@kernel.org> w=
rote:
>>>> Thanks for going forward and implementing this. I also started,
>>>> but was far from a functional state.
>>>>
>>>> On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
>>>>> Currently, devices attached via a UART are not well supported in
>>>>> the kernel. The problem is the device support is done in tty line
>>>>> disciplines, various platform drivers to handle some sideband, and
>>>>> in userspace with utilities such as hciattach.
>>>>>
>>>>> There have been several attempts to improve support, but they suffe=
r from
>>>>> still being tied into the tty layer and/or abusing the platform bus=
=2E This
>>>>> is a prototype to show creating a proper UART bus for UART devices.=
 It is
>>>>> tied into the serial core (really struct uart_port) below the tty l=
ayer
>>>>> in order to use existing serial drivers.
>>>>>
>>>>> This is functional with minimal testing using the loopback driver a=
nd
>>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the =
slave
>>>>> device). It still needs lots of work and polish.
>>>>>
>>>>> TODOs:
>>>>> - Figure out the port locking. mutex plus spinlock plus refcounting=
? I'm
>>>>>  hoping all that complexity is from the tty layer and not needed he=
re.
>>>>> - Split out the controller for uart_ports into separate driver. Do =
we see
>>>>>  a need for controller drivers that are not standard serial drivers=
?
>>>>> - Implement/test the removal paths
>>>>> - Fix the receive callbacks for more than character at a time (i.e.=
 DMA)
>>>>> - Need better receive buffering than just a simple circular buffer =
or
>>>>>  perhaps a different receive interface (e.g. direct to client buffe=
r)?
>>>>> - Test with other UART drivers
>>>>> - Convert a real driver/line discipline over to UART bus.
>>>>>
>>>>> Before I spend more time on this, I'm looking mainly for feedback o=
n the
>>>>> general direction and structure (the interface with the existing se=
rial
>>>>> drivers in particular).
>>>>
>>>> I had a look at the uart_dev API:
>>>>
>>>> int uart_dev_config(struct uart_device *udev, int baud, int parity, =
int bits, int flow);
>>>> int uart_dev_connect(struct uart_device *udev);
>>>>
>>>>  The flow control configuration should be done separately. e.g.:
>>>>  uart_dev_flow_control(struct uart_device *udev, bool enable);
>>>
>>> No objection, but out of curiosity, why?
>>
>> Nokia's bluetooth uart protocol disables flow control during speed
>> changes.
>>
>>>> int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
>>>> int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
>>>>
>>>>  UART communication does not have to be host-initiated, so this
>>>>  API requires polling. Either some function similar to poll in
>>>>  userspace is needed, or it should be implemented as callback.
>>>
>>> What's the userspace need?
>>
>> I meant "Either some function similar to userspace's poll() is
>> needed, ...". Something like uart_dev_wait_for_rx()
>>
>> Alternatively the rx function could be a callback, that
>> is called when there is new data.
>>
>>> I'm assuming the only immediate consumers are in-kernel.
>>
>> Yes, but the driver should be notified about incoming data.
>=20
> Yes, this is very important.
>=20
> If possible, please do a callback for every character that arrives.
> And not only if the rx buffer becomes full, to give the slave driver
> a chance to trigger actions almost immediately after every character.
> This probably runs in interrupt context and can happen often.
>=20
> In our proposal some months ago we have implemented such
> an rx_notification callback for every character. This allows to work
> without rx buffer and implement one in the driver if needed. This
> gives the driver full control over the rx buffer dimensions.
>=20
> And we have made the callback to return a boolean flag which
> tells if the character is to be queued in the tty layer so that the
> driver can decide for every byte if it is to be hidden from user
> space or passed. Since we pass a pointer, the driver could even
> modify the character passed back, but we have not used this
> feature.
>=20
> This should cover most (but certainly not all) situations of
> implementing protocol engines in uart slave drivers.
>=20
> Our API therefore was defined as:
>=20
> void uart_register_slave(struct uart_port *uport, void *slave);
> void uart_register_rx_notification(struct uart_port *uport,
> 		bool (*function)(void *slave, unsigned int *c),
> 				struct ktermios *termios);
>=20
> Registering a slave appears to be comparable to uart_dev_connect()
> and registering an rx_notification combines uart_dev_config() and
> setting the callback.
>=20
> Unregistration is done by passing a NULL pointer for 'slave' or 'functi=
on'.
>=20
> If there will be a very similar API with a callback like this, we won't=
 have
> to change our driver architecture much.
>=20
> If there is a uart_dev_wait_for_rx() with buffer it is much more diffic=
ult
> to handle.
>=20
> BR,
> Nikolaus
>=20
>=20


--=20
Regards,
Oleksij


--HRvruFou90EX54O842tJCuXrXN0Tm1W5T--

--VHxBd5MV1Odhd5N5hhgXIHjOAb6RoHgag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAle2ugUACgkQHwImuRkmbWljXgD+LpMFZFUZf6b2cYGP89tja2dy
pKhfXdizoURSClkap7AA+wSZvueXe7BG9Z7z+CnwKp7489bX/Bf+Xcjl/w/hrkdN
=y2MV
-----END PGP SIGNATURE-----

--VHxBd5MV1Odhd5N5hhgXIHjOAb6RoHgag--
