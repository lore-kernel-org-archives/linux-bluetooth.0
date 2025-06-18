Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89F8635D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234155; cv=none; b=Trfn9r/lKGgUJNnBqL9CBfH59Vw9CmKpFyGtdAZYcEKIoilA7CP36X03foPbaWruJAuurFK4ZdYOvVo2wJLBYU5FFYjs1RSQWlraaKQ8ItpexOK97z+VJaeyeqxRaw3n1BiputYOJ94wMpt3DtLHrU1hlIf8yDmuzuq20UAUSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234155; c=relaxed/simple;
	bh=dkqfmdAE54tr45xNG+ITjMXQwWQBdWMK+ky8j2nH02Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LluQmqTMlOQjsfjUriO3q+TwnS1J3ACeDC5bf5VLk7XzijHYhDgzop/9YWE/SnsDgi5AkYamK2F+Ig+Z88JujQJp/lriDsqfNjGQtQl6hEDi4SVRiKeZ9TPKM6CpA9LqXJ8hn+86WId1UzflKrsCJgxpVOOx/gWL5zGN81srYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C65C442B2;
	Wed, 18 Jun 2025 08:09:09 +0000 (UTC)
Message-ID: <d57fedd0a0889309c217e9e145d302ba8a5bac83.camel@hadess.net>
Subject: Re: [PATCH bluez] device: Add bearer info to Connected/Disconnected
 signals
From: Bastien Nocera <hadess@hadess.net>
To: ye.he@amlogic.com, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 18 Jun 2025 10:09:09 +0200
In-Reply-To: <20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
References: 
	<20250618-device-bearer-level-conn-state-v1-1-dca5df09c0bd@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedtheffveefffevtdehtefhjeevleejheehleejhfekveffheeifefhueduudeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeihvgdrhhgvsegrmhhlohhgihgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Wed, 2025-06-18 at 10:39 +0800, Ye He via B4 Relay wrote:
> From: Ye He <ye.he@amlogic.com>
>=20
> This patch add a new Connected(string bearer) signal to indicate
> which transport
> (LE or BR/EDR) has connected. Also extend the Disconnected signal to
> include
> a bearer argument.
>=20
> This allows applications to distinguish transport-specific connection
> events in dual-mode scenarios.
>=20
> Fixes: https://github.com/bluez/bluez/issues/1350

This is an API change, the commit needs to explain when the
Disconnected signal API was introduced, and probably mention that the
because it was introduced in 5.82, it didn't have time to be used.

It might also be a better idea for both signals to send out a
dictionary of values, so that the "bearer" can be added without an API
change, and further info can also be passed without an API change.

Cheers

>=20
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> =C2=A0doc/org.bluez.Device.rst | 33 ++++++++++++++++++++++++++++++++-
> =C2=A0src/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 34 ++++++++++++++++++++++++++--------
> =C2=A02 files changed, 58 insertions(+), 9 deletions(-)
>=20
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index
> 646e2c77ec2ddcbf7e6897336165d228c349fe00..1022402d95a1cd34dea88103ba6
> 6fb06f3007de7 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -157,7 +157,26 @@ Possible errors:
> =C2=A0Signals
> =C2=A0-------
> =C2=A0
> -void Disconnected(string reason, string message)
> +void Connected(string bearer)
> +````````````````````````````````````````````````
> +
> +This signal is emitted when a device establishes a connection,
> indicating the
> +bearer (transport type) over which the connection occurred.
> +
> +Client applications may use this signal to take actions such as
> stopping discovery
> +or advertising, depending on their internal policy.
> +
> +Possible bearer:
> +
> +:"le":
> +
> +	LE transport is cconnected.
> +
> +:"bredr":
> +
> +	BR/EDR transport is connected.
> +
> +void Disconnected(string reason, string message, string bearer)
> =C2=A0````````````````````````````````````````````````
> =C2=A0
> =C2=A0This signal is launched when a device is disconnected, with the
> reason of the
> @@ -208,6 +227,18 @@ Possible reasons:
> =C2=A0
> =C2=A0	Connection terminated by local host for suspend.
> =C2=A0
> +The additional 'bearer' field indicates which transport was
> disconnected.
> +
> +Possible bearer:
> +
> +:"le":
> +
> +	LE transport is disconnected.
> +
> +:"bredr":
> +
> +	BR/EDR transport is disconnected.
> +
> =C2=A0Properties
> =C2=A0----------
> =C2=A0
> diff --git a/src/device.c b/src/device.c
> index
> 902c4aa44d21eb89076eff3a47ffa727420967a8..ae6196eb2e5b6eca10a8e1c3360
> b85023dcddec2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3491,8 +3491,10 @@ static const GDBusMethodTable device_methods[]
> =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const GDBusSignalTable device_signals[] =3D {
> +	{ GDBUS_SIGNAL("Connected",
> +			GDBUS_ARGS({ "bearer", "s" })) },
> =C2=A0	{ GDBUS_SIGNAL("Disconnected",
> -			GDBUS_ARGS({ "name", "s" }, { "message", "s"
> })) },
> +			GDBUS_ARGS({ "name", "s" }, { "message", "s"
> }, { "bearer", "s" })) },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0
> @@ -3676,6 +3678,7 @@ void device_add_connection(struct btd_device
> *dev, uint8_t bdaddr_type,
> =C2=A0							uint32_t
> flags)
> =C2=A0{
> =C2=A0	struct bearer_state *state =3D get_state(dev, bdaddr_type);
> +	const char *bearer;
> =C2=A0
> =C2=A0	device_update_last_seen(dev, bdaddr_type, true);
> =C2=A0	device_update_last_used(dev, bdaddr_type);
> @@ -3691,14 +3694,22 @@ void device_add_connection(struct btd_device
> *dev, uint8_t bdaddr_type,
> =C2=A0	dev->conn_bdaddr_type =3D dev->bdaddr_type;
> =C2=A0
> =C2=A0	/* If this is the first connection over this bearer */
> -	if (bdaddr_type =3D=3D BDADDR_BREDR)
> +	if (bdaddr_type =3D=3D BDADDR_BREDR) {
> =C2=A0		device_set_bredr_support(dev);
> -	else
> +		bearer =3D "bredr";
> +	} else {
> =C2=A0		device_set_le_support(dev, bdaddr_type);
> +		bearer =3D "le";
> +	}
> =C2=A0
> =C2=A0	state->connected =3D true;
> =C2=A0	state->initiator =3D flags & BIT(3);
> =C2=A0
> +	g_dbus_emit_signal(dbus_conn, dev->path, DEVICE_INTERFACE,
> +				"Connected",
> +				DBUS_TYPE_STRING, &bearer,
> +				DBUS_TYPE_INVALID);
> +
> =C2=A0	if (dev->le_state.connected && dev->bredr_state.connected)
> =C2=A0		return;
> =C2=A0
> @@ -3747,7 +3758,7 @@ static void set_temporary_timer(struct
> btd_device *dev, unsigned int timeout)
> =C2=A0								dev,
> NULL);
> =C2=A0}
> =C2=A0
> -static void device_disconnected(struct btd_device *device, uint8_t
> reason)
> +static void device_disconnected(struct btd_device *device, uint8_t
> reason, const char *bearer)
> =C2=A0{
> =C2=A0	const char *name;
> =C2=A0	const char *message;
> @@ -3787,6 +3798,7 @@ static void device_disconnected(struct
> btd_device *device, uint8_t reason)
> =C2=A0						"Disconnected",
> =C2=A0						DBUS_TYPE_STRING,
> &name,
> =C2=A0						DBUS_TYPE_STRING,
> &message,
> +						DBUS_TYPE_STRING,
> &bearer,
> =C2=A0						DBUS_TYPE_INVALID);
> =C2=A0}
> =C2=A0
> @@ -3798,10 +3810,16 @@ void device_remove_connection(struct
> btd_device *device, uint8_t bdaddr_type,
> =C2=A0	DBusMessage *reply;
> =C2=A0	bool remove_device =3D false;
> =C2=A0	bool paired_status_updated =3D false;
> +	const char *bearer;
> =C2=A0
> =C2=A0	if (!state->connected)
> =C2=A0		return;
> =C2=A0
> +	if (bdaddr_type =3D=3D BDADDR_BREDR)
> +		bearer =3D "bredr";
> +	else
> +		bearer =3D "le";
> +
> =C2=A0	state->connected =3D false;
> =C2=A0	state->initiator =3D false;
> =C2=A0	device->general_connect =3D FALSE;
> @@ -3854,15 +3872,15 @@ void device_remove_connection(struct
> btd_device *device, uint8_t bdaddr_type,
> =C2=A0						DEVICE_INTERFACE,
> =C2=A0						"Paired");
> =C2=A0
> -	if (device->bredr_state.connected || device-
> >le_state.connected)
> -		return;
> -
> =C2=A0	device_update_last_seen(device, bdaddr_type, true);
> =C2=A0
> =C2=A0	g_slist_free_full(device->eir_uuids, g_free);
> =C2=A0	device->eir_uuids =3D NULL;
> =C2=A0
> -	device_disconnected(device, reason);
> +	device_disconnected(device, reason, bearer);
> +
> +	if (device->bredr_state.connected || device-
> >le_state.connected)
> +		return;
> =C2=A0
> =C2=A0	g_dbus_emit_property_changed(dbus_conn, device->path,
> =C2=A0						DEVICE_INTERFACE,
> "Connected");
>=20
> ---
> base-commit: dc8db3601001de9a085da063e0c5e456074b8963
> change-id: 20250618-device-bearer-level-conn-state-3e29d56bda88
>=20
> Best regards,
