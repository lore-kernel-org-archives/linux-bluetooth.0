Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34782322C79
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781968; cv=none; b=Y2yRH9K+I9yF+tc/3Fzmu956TEhjdIKhzXHqwQZis46YexaCVapbZfvRRCdVMOPUhz7APUhQaetQoj9gKGdG+dbDW3t0jHPsba13MfUDbjZvhZjZu4UWstw4iBJPbMElcT22/buTz+YNr7Rlen/kbm38tkovddp8CCUlHUPnRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781968; c=relaxed/simple;
	bh=+VOnKp+//1C9pak4191cpaEjWiPbhzQhCWmz9/alIRQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIb25I0ka5aT0AGlmGAxIzVZgeRqAWSdc8uZhVc5NJ/b6U9o1FrvNthTlLQFODd4gcOUJaX6QlTEB/U3OgH+sFSpUupsWNAGD7ABSqoiCz4y/234BPNJ5s8+lIsjAvAQ7TsuANcU2EAB3Y8LFr1SUmmW7Rd9niPC040wZW4i2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1535F4385D;
	Thu, 21 Aug 2025 13:12:43 +0000 (UTC)
Message-ID: <760b9a8f9875d88d37e7af2943cb18d1429a9fad.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for
 DualSense
From: Bastien Nocera <hadess@hadess.net>
To: Egor Vorontsov <sdoregor@sdore.me>, linux-bluetooth@vger.kernel.org
Date: Thu, 21 Aug 2025 15:12:43 +0200
In-Reply-To: <20250603095617.92785-3-sdoregor@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
	 <20250603095617.92785-3-sdoregor@sdore.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehsughorhgvghhorhesshguohhrvgdrmhgvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-06-03 at 12:56 +0300, Egor Vorontsov wrote:
> The code is very similar to that for DS4, but I found it's better
> to separate the matters instead of generalizing it via constants.

I don't think there was a need to mention it that way, the code is
already setup in such a way that it has separate code paths for each
supported type of hardware. Maybe:
"The protocol used by the DualSense cable pairing is similar to that
used by the DualShock4 controllers, but different enough that using
separate code paths is more legible."

> Also added a request to enable Bluetooth on the controller to initiate
> pairing without the need to disconnect it and power on again wirelessly,
> basically emulating what PS itself does. Only for DualSense family now,
> but can be expanded to DS4 too (I don't have one at hand to test this).

The fact that you wrote "also" in this commit message is a good
indicator that this should probably have been a separate commit.

> ---
> =C2=A0plugins/sixaxis.c | 107
> ++++++++++++++++++++++++++++++++++++++++++++--
> =C2=A01 file changed, 104 insertions(+), 3 deletions(-)
>=20
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 1fab8ae59..a583c8b82 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -131,12 +131,36 @@ static int ds4_get_device_bdaddr(int fd,
> bdaddr_t *bdaddr)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int dualsense_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +	uint8_t buf[20];
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	buf[0] =3D 0x09;
> +
> +	ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	if (ret < 0) {
> +		error("sixaxis: failed to read DualSense device
> address (%s)",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(errno));
> +		return ret;
> +	}
> +
> +	/* address is little-endian on DualSense */
> +	bacpy(bdaddr, (bdaddr_t*) (buf + 1));
> +
> +	return 0;
> +}
> +
> =C2=A0static int get_device_bdaddr(int fd, bdaddr_t *bdaddr,
> CablePairingType type)
> =C2=A0{
> =C2=A0	if (type =3D=3D CABLE_PAIRING_SIXAXIS)
> =C2=A0		return sixaxis_get_device_bdaddr(fd, bdaddr);
> =C2=A0	else if (type =3D=3D CABLE_PAIRING_DS4)
> =C2=A0		return ds4_get_device_bdaddr(fd, bdaddr);
> +	else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +		return dualsense_get_device_bdaddr(fd, bdaddr);
> =C2=A0	return -1;
> =C2=A0}
> =C2=A0
> @@ -183,12 +207,36 @@ static int ds4_get_central_bdaddr(int fd,
> bdaddr_t *bdaddr)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int dualsense_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
> +{
> +	uint8_t buf[20];
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	buf[0] =3D 0x09;
> +
> +	ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> +	if (ret < 0) {
> +		error("sixaxis: failed to read DualSense central
> address (%s)",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(errno));
> +		return ret;
> +	}
> +
> +	/* address is little-endian on DualSense */
> +	bacpy(bdaddr, (bdaddr_t*) (buf + 10));
> +
> +	return 0;
> +}
> +
> =C2=A0static int get_central_bdaddr(int fd, bdaddr_t *bdaddr,
> CablePairingType type)
> =C2=A0{
> =C2=A0	if (type =3D=3D CABLE_PAIRING_SIXAXIS)
> =C2=A0		return sixaxis_get_central_bdaddr(fd, bdaddr);
> =C2=A0	else if (type =3D=3D CABLE_PAIRING_DS4)
> =C2=A0		return ds4_get_central_bdaddr(fd, bdaddr);
> +	else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +		return dualsense_get_central_bdaddr(fd, bdaddr);
> =C2=A0	return -1;
> =C2=A0}
> =C2=A0
> @@ -230,6 +278,26 @@ static int ds4_set_central_bdaddr(int fd, const
> bdaddr_t *bdaddr)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static int dualsense_set_central_bdaddr(int fd, const bdaddr_t
> *bdaddr)
> +{
> +	uint8_t buf[27];
> +	int ret;
> +
> +	buf[0] =3D 0x0A;
> +	bacpy((bdaddr_t*) (buf + 1), bdaddr);
> +	/* TODO: we could put the key here but
> +	=C2=A0=C2=A0 there is no way to force a re-loading
> +	=C2=A0=C2=A0 of link keys to the kernel from here. */
> +	memset(buf + 7, 0, 16);
> +
> +	ret =3D ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
> +	if (ret < 0)
> +		error("sixaxis: failed to write DualSense central
> address (%s)",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(errno));
> +
> +	return ret;
> +}
> +
> =C2=A0static int set_central_bdaddr(int fd, const bdaddr_t *bdaddr,
> =C2=A0					CablePairingType type)
> =C2=A0{
> @@ -237,6 +305,32 @@ static int set_central_bdaddr(int fd, const
> bdaddr_t *bdaddr,
> =C2=A0		return sixaxis_set_central_bdaddr(fd, bdaddr);
> =C2=A0	else if (type =3D=3D CABLE_PAIRING_DS4)
> =C2=A0		return ds4_set_central_bdaddr(fd, bdaddr);
> +	else if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +		return dualsense_set_central_bdaddr(fd, bdaddr);
> +	return -1;
> +}
> +
> +static int dualsense_set_bluetooth_state(int fd, bool state)
> +{
> +	uint8_t buf[48];
> +	int ret;
> +
> +	buf[0] =3D 0x08;
> +	buf[1] =3D state?1:2;

buf[1] =3D state ? 0x1 : 0x2;

> +
> +	ret =3D ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
> +	if (ret < 0)
> +		error("sixaxis: failed to set DualSense Bluetooth
> state (%s)",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(errno));
> +
> +	return ret;
> +}
> +
> +static int set_bluetooth_state(int fd, CablePairingType type,
> +					bool state)
> +{
> +	if (type =3D=3D CABLE_PAIRING_DUALSENSE)
> +		return dualsense_set_bluetooth_state(fd, state);
> =C2=A0	return -1;
> =C2=A0}
> =C2=A0
> @@ -297,12 +391,13 @@ static void agent_auth_cb(DBusError *derr, void
> *user_data)
> =C2=A0	remove_device =3D false;
> =C2=A0	btd_device_set_temporary(closure->device, false);
> =C2=A0
> -	if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS) {
> +	if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS)

It's a multi-line conditional, we still want the braces.

> =C2=A0		btd_device_set_record(closure->device, HID_UUID,
> =C2=A0					=09
> SIXAXIS_HID_SDP_RECORD);
> =C2=A0
> +	if (closure->type =3D=3D CABLE_PAIRING_SIXAXIS ||
> +				closure->type =3D=3D
> CABLE_PAIRING_DUALSENSE) {
> =C2=A0		device_set_cable_pairing(closure->device, true);
> -

No white space changes please.

> =C2=A0		server_set_cable_pairing(adapter_bdaddr, true);
> =C2=A0	}

device_set_cable_pairing() and server_set_cable_pairing() are supposed
to be called for DS4 as well. I've fixed that in another patchset,
which you'll probably need to rebase on top of.

> =C2=A0
> @@ -312,6 +407,11 @@ static void agent_auth_cb(DBusError *derr, void
> *user_data)
> =C2=A0	DBG("remote %s old_central %s new_central %s",
> =C2=A0				device_addr, central_addr,
> adapter_addr);
> =C2=A0
> +	if (closure->type =3D=3D CABLE_PAIRING_DUALSENSE) {
> +		DBG("Enabling Bluetooth connection on the device");
> +		set_bluetooth_state(closure->fd, closure->type,
> true);
> +	}
> +
> =C2=A0out:
> =C2=A0	g_hash_table_steal(pending_auths, closure->sysfs_path);
> =C2=A0
> @@ -432,7 +532,8 @@ static void device_added(struct udev_device
> *udevice)
> =C2=A0
> =C2=A0	cp =3D get_pairing_type_for_device(udevice, &bus,
> &sysfs_path);
> =C2=A0	if (!cp || (cp->type !=3D CABLE_PAIRING_SIXAXIS &&
> -				cp->type !=3D CABLE_PAIRING_DS4)) {
> +				cp->type !=3D CABLE_PAIRING_DS4 &&
> +				cp->type !=3D
> CABLE_PAIRING_DUALSENSE)) {
> =C2=A0		g_free(sysfs_path);
> =C2=A0		return;
> =C2=A0	}
