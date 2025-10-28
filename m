Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F61176ADE
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663461; cv=none; b=Pm6RBooRghV25VCC/206eUB6fPWJjqPSuqLForkL2Ji4ckSjmVas7j27oBuOZqcGsVkiCzrB7c5o10gGi29VGZ78379JhMLBKXavBTu/Wt+Mx/G0eOEb8pwNRpoNc1iImPQGlvHBg6U2+USiajblpG5TeJ0O2RAWNcFUHViDBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663461; c=relaxed/simple;
	bh=cVDlkIw3PpB+sTR78FVddbrA40p1w/aljX+PuC0a4oI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJQhaxraViSpYHQZW/jr5A3Yd8956UkSpc+ondTD1+qCpJBitnWeVPvCVYtfGic44wZppPPFlX1GA7AMdg6zg6d5xOLzyoeJOX0Ha1Zka2zLxk6RKLajuzt7043vIECnEjYC4sZc8ACL2QMBbi+Na/FlAfwxaFD7EFNrqiooEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 811BC44342;
	Tue, 28 Oct 2025 14:57:29 +0000 (UTC)
Message-ID: <399171165c10f8edc9b39d16e06ec3d59a2beeb7.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3] battery: improve the display of the charge
 level
From: Bastien Nocera <hadess@hadess.net>
To: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Date: Tue, 28 Oct 2025 15:57:29 +0100
In-Reply-To: <20251028144320.104871-1-r.smirnov@omp.ru>
References: <20251028144320.104871-1-r.smirnov@omp.ru>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefgheeiueekhfdtjedujedtvdefkeduveehvdelhfeuheefleegfeehkeeuhfehueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgthhkrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehrrdhsmhhirhhnohhvsehomhhprdhruhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrk
 hgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

Hey,

Going to make a few comments inline. Those would be in addition to
Luiz' comments, and not meant to replace them.

On Tue, 2025-10-28 at 17:43 +0300, Roman Smirnov wrote:
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
> spikes,
> this is a clear indication of an uncalibrated sensor.
>=20
> Check that the battery charge is fluctuating. If the battery charge
> is fluctuating, use the average charge value, otherwise use the
> current
> value.
>=20
> Fixes: https://github.com/bluez/bluez/issues/1612
> ---
> V2 -> V3: A queue is used instead of an array for the last charges,
> a bug with the spikes variable increment has been fixed, and the
> fluctuation check is called each time a new battery charge appears.
>=20
> V1 -> V2: Smoothing is only applied to uncalibrated sensors, the
> last 8 values are saved instead of 4, and the average value is used
> for smoothing instead of the minimum value.
>=20
> =C2=A0src/battery.c | 70
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 70 insertions(+)
>=20
> diff --git a/src/battery.c b/src/battery.c
> index 59e4fc570..33079975c 100644
> --- a/src/battery.c
> +++ b/src/battery.c
> @@ -33,10 +33,15 @@
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
> +	struct queue *last_charges; /* last charges received */

Instead of open-coding a queue, I think that a GArray would be better:
https://docs.gtk.org/glib/struct.Array.html

- limit ->len to LAST_CHARGES_SIZE
- ability to add items from either side, truncate the queue or remove
an arbitrary item

> +	float avg_charge; /* average battery charge */
> +	bool is_fluctuating; /* true, if the battery sensor
> fluctuates */
> =C2=A0	char *source; /* Descriptive source of the battery info */
> =C2=A0	char *provider_path; /* The provider root path, if any */
> =C2=A0};
> @@ -92,6 +97,10 @@ static struct btd_battery *battery_new(const char
> *path, const char *source,
> =C2=A0	battery =3D new0(struct btd_battery, 1);
> =C2=A0	battery->path =3D g_strdup(path);
> =C2=A0	battery->percentage =3D UINT8_MAX;
> +	battery->last_charges =3D queue_new();
> +	battery->avg_charge =3D 0;
> +	battery->is_fluctuating =3D false;
> +
> =C2=A0	if (source)
> =C2=A0		battery->source =3D g_strdup(source);
> =C2=A0	if (provider_path)
> @@ -105,6 +114,9 @@ static void battery_free(struct btd_battery
> *battery)
> =C2=A0	if (battery->path)
> =C2=A0		g_free(battery->path);
> =C2=A0
> +	if (battery->last_charges)
> +		queue_destroy(battery->last_charges, NULL);
> +
> =C2=A0	if (battery->source)
> =C2=A0		g_free(battery->source);
> =C2=A0
> @@ -217,8 +229,49 @@ bool btd_battery_unregister(struct btd_battery
> *battery)
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +static void check_fluctuations(struct btd_battery *battery)

Instead of having this function, and quite complicated handling of that
same queue of battery levels in btd_battery_update(), it would be great
if the code was contained all within a function (or two) and used non-
BlueZ specific data types.

So that the code could be split off into its own battery helper, and
could have a unit test showing a few different cases.

> +{
> +	const struct queue_entry *entry;
> +	uint8_t spikes =3D 0;
> +	int8_t step;
> +	int8_t direction =3D 0;
> +	int8_t prev_direction;
> +	uint8_t *prev_charge;
> +	uint8_t *next_charge;
> +
> +	for (entry =3D queue_get_entries(battery->last_charges);
> entry->next;
> +	=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D entry->next) {
> +		prev_direction =3D direction;
> +		prev_charge =3D entry->data;
> +		next_charge =3D entry->next->data;
> +		step =3D *next_charge - *prev_charge;
> +
> +		/*
> +		 * The battery charge fluctuates too much,
> +		 * which may indicate a battery problem, so
> +		 * the actual value should be displayed.
> +		 */
> +		if (abs(step) >=3D MAX_CHARGE_STEP) {
> +			battery->is_fluctuating =3D false;
> +			return;
> +		}
> +
> +		if (step > 0)
> +			direction =3D 1;
> +		else if (step < 0)
> +			direction =3D -1;
> +
> +		if (direction !=3D prev_direction && prev_direction)
> +			spikes++;
> +	}
> +
> +	battery->is_fluctuating =3D (spikes > 1) ? true : false;
> +}
> +
> =C2=A0bool btd_battery_update(struct btd_battery *battery, uint8_t
> percentage)
> =C2=A0{
> +	uint8_t *p_percentage;
> +
> =C2=A0	DBG("path =3D %s", battery->path);
> =C2=A0
> =C2=A0	if (!queue_find(batteries, NULL, battery)) {
> @@ -231,6 +284,23 @@ bool btd_battery_update(struct btd_battery
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

Magic numbers should be #define's constants.

As Luiz mentioned, it would be great if there was some prior art
referenced, perhaps the reference implementation in another
application.

Or an explanation as to why this could needs to live here instead of,
say, upower, which deals with heuristics, dodgy hardware, etc.

Cheers

> +	p_percentage =3D new0(uint8_t, 1);
> +	*p_percentage =3D percentage;
> +	queue_push_tail(battery->last_charges, p_percentage);
> +
> +	if (queue_length(battery->last_charges) =3D=3D
> LAST_CHARGES_SIZE) {
> +		check_fluctuations(battery);
> +		queue_pop_head(battery->last_charges);
> +	}
> +
> +	if (battery->is_fluctuating)
> +		percentage =3D battery->avg_charge;
> +
> =C2=A0	if (battery->percentage =3D=3D percentage)
> =C2=A0		return true;
> =C2=A0
