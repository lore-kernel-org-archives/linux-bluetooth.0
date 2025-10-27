Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247202FF17F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579464; cv=none; b=D4Av9GI0ph35gCnFXlMVRSQj6UEZYLMqUqY2ii6DDYGheApD+2AeVaIc0vDDSqSZ5hMtsBgA0hRSkzL4EoY0ePZVX4/x9qfrGaaexotRfJKJ394Jkz+KmU5vvYdWn3CRBDp4oKb0jHmkWCkoz+Wf6vyLBI+7NO6iUYRv2r+U840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579464; c=relaxed/simple;
	bh=xEE+VeR6NUXdBwqvLTUYtu1B0+bpi8RX14U4ni8LbbM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ma2KvKqD71nfcbUG0bRo4XWui9fjs/N+TPCLmEE98cUvAOk8UirBrJNGGSJg90rv7UTbWTS2IE+k0I1BOHG0gwAKhb22VITsSSKFmvJaCwbqbHawc9mxua8heBsdcscOtjqyZR/lVk8W1h1oITK4NVR8E27aSuoFA2PrjFmbEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0573E438D4;
	Mon, 27 Oct 2025 15:37:37 +0000 (UTC)
Message-ID: <1277128e63487a95c6dcb87210442468aace6ab5.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] battery: improve the display of the charge
 level
From: Bastien Nocera <hadess@hadess.net>
To: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Date: Mon, 27 Oct 2025 16:37:37 +0100
In-Reply-To: <20251027151108.106713-1-r.smirnov@omp.ru>
References: <20251027151108.106713-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedtheffveefffevtdehtefhjeevleejheehleejhfekveffheeifefhueduudeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehrrdhsmhhirhhnohhvsehomhhprdhruhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhor
 hhg
X-GND-Sasl: hadess@hadess.net

On Mon, 2025-10-27 at 18:11 +0300, Roman Smirnov wrote:
> The battery charge level may fluctuate due to uncalibrated
> sensors. Commit smooths out such fluctuations.
>=20
> The algorithm for determining uncalibrated sensors consists of
> finding the number of changes in charge direction (i.e., "spikes").
> If the number of spikes is zero, the device is charging or
> discharging.
> If there is one spike, it may mean that the device has started
> charging
> or has been disconnected from charging. If there are two or more
> spikes, this is a clear indication of an uncalibrated sensor.
>=20
> Check that the battery charge is fluctuating. If the battery charge
> is fluctuating, use the average charge value, otherwise use the
> current
> value.
>=20
> Fixes: https://github.com/bluez/bluez/issues/1612

When sending a v2, it's customary to add a changelog compared to the
first version. What changed since v1?

> ---
> =C2=A0src/battery.c | 62
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 62 insertions(+)
>=20
> diff --git a/src/battery.c b/src/battery.c
> index 59e4fc570..f97d9b8f3 100644
> --- a/src/battery.c
> +++ b/src/battery.c
> @@ -33,10 +33,16 @@
> =C2=A0#define BATTERY_PROVIDER_MANAGER_INTERFACE
> "org.bluez.BatteryProviderManager1"
> =C2=A0
> =C2=A0#define BATTERY_MAX_PERCENTAGE 100
> +#define LAST_CHARGES_SIZE 8
> +#define MAX_CHARGE_STEP 5
> =C2=A0
> =C2=A0struct btd_battery {
> =C2=A0	char *path; /* D-Bus object path */
> =C2=A0	uint8_t percentage; /* valid between 0 to 100 inclusively */
> +	uint8_t *last_charges; /* last charges received */
> +	uint8_t lru_charge_id; /* oldest battery charge */
> +	float avg_charge; /* average battery charge */
> +	bool is_fluctuating; /* true, if the battery sensor
> fluctuates */
> =C2=A0	char *source; /* Descriptive source of the battery info */
> =C2=A0	char *provider_path; /* The provider root path, if any */
> =C2=A0};
> @@ -92,6 +98,11 @@ static struct btd_battery *battery_new(const char
> *path, const char *source,
> =C2=A0	battery =3D new0(struct btd_battery, 1);
> =C2=A0	battery->path =3D g_strdup(path);
> =C2=A0	battery->percentage =3D UINT8_MAX;
> +	battery->last_charges =3D new0(uint8_t, LAST_CHARGES_SIZE);
> +	battery->lru_charge_id =3D 0;
> +	battery->avg_charge =3D 0;
> +	battery->is_fluctuating =3D false;
> +
> =C2=A0	if (source)
> =C2=A0		battery->source =3D g_strdup(source);
> =C2=A0	if (provider_path)
> @@ -105,6 +116,9 @@ static void battery_free(struct btd_battery
> *battery)
> =C2=A0	if (battery->path)
> =C2=A0		g_free(battery->path);
> =C2=A0
> +	if (battery->last_charges)
> +		g_free(battery->last_charges);
> +
> =C2=A0	if (battery->source)
> =C2=A0		g_free(battery->source);
> =C2=A0
> @@ -217,6 +231,39 @@ bool btd_battery_unregister(struct btd_battery
> *battery)
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +static void check_fluctuations(struct btd_battery *battery)
> +{
> +	uint8_t spikes =3D 0;
> +	int8_t step =3D 0;
> +	int8_t direction =3D 0;
> +	int8_t prev_direction;
> +
> +	for (uint8_t id =3D 0; id < LAST_CHARGES_SIZE - 1; id++) {
> +		prev_direction =3D direction;
> +		step =3D battery->last_charges[id] - battery-
> >last_charges[id + 1];
> +
> +		/*
> +		 * The battery charge fluctuates too much,
> +		 * which may indicate a battery problem, so
> +		 * the actual value should be displayed.
> +		 */
> +		if (step > MAX_CHARGE_STEP) {
> +			battery->is_fluctuating =3D false;
> +			return;
> +		}
> +
> +		if (step > 0)
> +			direction =3D 1;
> +		else if (step < 0)
> +			direction =3D -1;
> +
> +		if (direction !=3D prev_direction && !prev_direction)
> +			spikes++;
> +	}
> +
> +	battery->is_fluctuating =3D (spikes > 1) ? true : false;
> +}
> +
> =C2=A0bool btd_battery_update(struct btd_battery *battery, uint8_t
> percentage)
> =C2=A0{
> =C2=A0	DBG("path =3D %s", battery->path);
> @@ -231,6 +278,21 @@ bool btd_battery_update(struct btd_battery
> *battery, uint8_t percentage)
> =C2=A0		return false;
> =C2=A0	}
> =C2=A0
> +	if (!battery->avg_charge)
> +		battery->avg_charge =3D percentage;
> +
> +	/* exponential smoothing */
> +	battery->avg_charge =3D battery->avg_charge * 0.7 + percentage
> * 0.3;
> +	battery->last_charges[battery->lru_charge_id] =3D percentage;
> +
> +	if (battery->lru_charge_id =3D=3D LAST_CHARGES_SIZE - 1)
> +		check_fluctuations(battery);
> +
> +	battery->lru_charge_id =3D (battery->lru_charge_id + 1) %
> LAST_CHARGES_SIZE;
> +
> +	if (battery->is_fluctuating)
> +		percentage =3D battery->avg_charge;
> +
> =C2=A0	if (battery->percentage =3D=3D percentage)
> =C2=A0		return true;
> =C2=A0
