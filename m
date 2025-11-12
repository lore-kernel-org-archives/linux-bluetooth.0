Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433033E368
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964720; cv=none; b=SQmNjjuG7AyKMpotDfMZgvtJRlY9KNEOfn63whV3k/z2ByR7R2O+GdzgJYAb+YqCu5piverLMhGg/e03/mrNtgTl09jA200ppa3di2CWs26tbEavhjvvXZxjqX2kkxjQ0Q73x6c2nx4eSMtKtnwOMMdN1pa+3adCPDRToVeZFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964720; c=relaxed/simple;
	bh=elUixBlmX2IuoSjMzkA3nW4jGQ2FNPVY10PH/Vl6L1I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwg3Tu6V4Z0lijnb64YeeFa7u6sTS1WcMA+/MyNitekJDku6bzZ2UBU4OqwpMcHM+3LZOcD92lw0av27xhPpqYXZqLYkc/uOSBXvQOguQEFo3f8jwWWckPutuXtw1dYOasAlJpNr3kOu8iLOQM+iZ1BQllnNZ368rkA+jIaUCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 47E3A584331
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 16:20:29 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 801E8201DA;
	Wed, 12 Nov 2025 16:20:21 +0000 (UTC)
Message-ID: <39b1f43a75ce022a52bbcf2ae82723c79b1d63b5.camel@hadess.net>
Subject: Re: [PATCH BlueZ v6 2/2] unit: Add basic unit tests for battery
 charge handling
From: Bastien Nocera <hadess@hadess.net>
To: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Date: Wed, 12 Nov 2025 17:20:21 +0100
In-Reply-To: <20251105132414.82057-2-r.smirnov@omp.ru>
References: <20251105132414.82057-1-r.smirnov@omp.ru>
	 <20251105132414.82057-2-r.smirnov@omp.ru>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhdrshhmihhrnhhovhesohhmphdrrhhupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Wed, 2025-11-05 at 16:23 +0300, Roman Smirnov wrote:
> ---
> V5 -> V6: Add stdlib.h header file.

Great work on the unit tests, thank you.

>=20
> =C2=A0.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A0doc/test-coverage.txt |=C2=A0=C2=A0 3 +-
> =C2=A0unit/test-battery.c=C2=A0=C2=A0 | 224
> ++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 233 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 unit/test-battery.c
>=20
> diff --git a/.gitignore b/.gitignore
> index d23a06af4..784fc77db 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -117,6 +117,7 @@ unit/test-ecc
> =C2=A0unit/test-hog
> =C2=A0unit/test-bap
> =C2=A0unit/test-bass
> +unit/test-battery
> =C2=A0tools/mgmt-tester
> =C2=A0tools/smp-tester
> =C2=A0tools/gap-tester
> diff --git a/Makefile.am b/Makefile.am
> index 4bf859685..deb59fad3 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -701,6 +701,12 @@ unit_test_vcp_SOURCES =3D unit/test-vcp.c
> $(btio_sources)
> =C2=A0unit_test_vcp_LDADD =3D src/libshared-glib.la \
> =C2=A0				lib/libbluetooth-internal.la
> $(GLIB_LIBS)
> =C2=A0
> +unit_tests +=3D unit/test-battery
> +
> +unit_test_battery_SOURCES =3D unit/test-battery.c
> +unit_test_battery_LDADD =3D src/libshared-glib.la \
> +				lib/libbluetooth-internal.la
> $(GLIB_LIBS)
> +
> =C2=A0if MIDI
> =C2=A0unit_tests +=3D unit/test-midi
> =C2=A0unit_test_midi_CPPFLAGS =3D $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TE=
ST
> diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
> index 741492a3e..b92a2ae59 100644
> --- a/doc/test-coverage.txt
> +++ b/doc/test-coverage.txt
> @@ -30,8 +30,9 @@ test-gobex-transfer	=C2=A0 36	OBEX transfer
> handling
> =C2=A0test-gdbus-client	=C2=A0 13	D-Bus client handling
> =C2=A0test-gatt		 180	GATT qualification test cases
> =C2=A0test-hog		=C2=A0=C2=A0 6	HID Over GATT qualification test
> cases
> +test-battery		=C2=A0 10	Battery charge test cases
> =C2=A0			-----
> -			 761
> +			 771
> =C2=A0
> =C2=A0
> =C2=A0Automated end-to-end testing
> diff --git a/unit/test-battery.c b/unit/test-battery.c
> new file mode 100644
> index 000000000..ae574a682
> --- /dev/null
> +++ b/unit/test-battery.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *=C2=A0 BlueZ - Bluetooth protocol stack for Linux
> + *
> + *=C2=A0 Copyright (C) 2025=C2=A0 Open Mobile Platform LLC <community@om=
p.ru>
> + *
> + *
> + */
> +
> +#include <glib.h>
> +#include <stdlib.h>
> +
> +#include "src/shared/battery.h"
> +#include "src/shared/tester.h"
> +
> +#define DATA_SIZE 10
> +
> +static uint8_t calculate_average(const uint8_t *charges)
> +{
> +	uint16_t average =3D 0;
> +
> +	for (int i =3D DATA_SIZE - LAST_CHARGES_SIZE; i < DATA_SIZE;
> i++)
> +		average +=3D charges[i];
> +
> +	return average / LAST_CHARGES_SIZE;
> +}
> +
> +static uint8_t process_data(struct bt_battery *battery, uint8_t
> *charges)
> +{
> +	uint8_t battery_avg;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++)
> +		battery_avg =3D bt_battery_filter(battery,
> charges[i]);
> +
> +	return battery_avg;
> +}
> +
> +static void test_discharging(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 84, 83, 83, 81, 80, 80, 80,
> 79, 79, 78 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_charging(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 48, 48, 48, 49, 49, 50, 51,
> 51, 51, 53 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_discharge_started(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 48, 48, 49, 50, 51, 51, 49,
> 48, 47, 45 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_charge_started(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 57, 57, 56, 56, 55, 54, 55,
> 57, 57, 58 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_fluctuations(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 74, 73, 75, 72, 74, 72, 73,
> 71, 75, 73 };
> +	uint8_t processed_charge, average;
> +
> +	average =3D calculate_average(charges);
> +	processed_charge =3D process_data(battery, charges);
> +
> +	g_assert(processed_charge =3D=3D average);
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_fluctuations_with_anomaly(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 33, 33, 34, 32, 94, 33, 31,
> 33, 34, 32 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_fluctuations_with_old_anomaly(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 94, 22, 22, 21, 21, 20, 21,
> 20, 21, 20 };
> +	uint8_t processed_charge, average;
> +
> +	average =3D calculate_average(charges);
> +	processed_charge =3D process_data(battery, charges);
> +
> +	g_assert(processed_charge =3D=3D average);
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_bad_battery(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 28, 38, 92, 34, 85, 34, 45,
> 41, 29, 40 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_device_report_5_percent(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 55, 55, 50, 50, 50, 55, 55,
> 55, 60, 60 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +static void test_device_report_10_percent(const void *data)
> +{
> +	struct bt_battery *battery =3D bt_battery_new();
> +	uint8_t charges[DATA_SIZE] =3D { 30, 30, 30, 40, 40, 50, 50,
> 50, 50, 60 };
> +	uint8_t processed_charge;
> +
> +	for (int i =3D 0; i < DATA_SIZE; i++) {
> +		processed_charge =3D bt_battery_filter(battery,
> charges[i]);
> +		g_assert(processed_charge =3D=3D charges[i]);
> +	}
> +
> +	bt_battery_free(battery);
> +	free(battery);
> +	tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	tester_init(&argc, &argv);
> +
> +	tester_add("/battery/test_discharging", NULL, NULL,
> +			test_discharging, NULL);
> +	tester_add("/battery/test_charging", NULL, NULL,
> +			test_charging, NULL);
> +	tester_add("/battery/test_discharge_started", NULL, NULL,
> +			test_discharge_started, NULL);
> +	tester_add("/battery/test_charge_started", NULL, NULL,
> +			test_charge_started, NULL);
> +	tester_add("/battery/test_fluctuations", NULL, NULL,
> +			test_fluctuations, NULL);
> +	tester_add("/battery/test_fluctuations_with_anomaly", NULL,
> NULL,
> +			test_fluctuations_with_anomaly, NULL);
> +	tester_add("/battery/test_fluctuations_with_old_anomaly",
> NULL, NULL,
> +			test_fluctuations_with_old_anomaly, NULL);
> +	tester_add("/battery/test_bad_battery", NULL, NULL,
> test_bad_battery, NULL);
> +	tester_add("/battery/test_device_report_5_percent", NULL,
> NULL,
> +			test_device_report_5_percent, NULL);
> +	tester_add("/battery/test_device_report_10_percent", NULL,
> NULL,
> +			test_device_report_10_percent, NULL);
> +
> +	return tester_run();
> +}
