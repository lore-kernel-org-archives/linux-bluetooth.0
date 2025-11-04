Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC94320387
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262349; cv=none; b=og18KAHIlJ++FdmG9W5+Ed44IWiUqCfx0JRjkB+JgcmzLsvkJf2LFc0MWoOxrBeGPT5Sy5FFFj54Te57Fp6Kgg3gsPpCC1xNqfZXfwiG99HttkKUUEqa0wBN/93p+UYyqtSGlmNX32FSvwVY3bEO2Erwq/DBZdk7UD8+vWCirlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262349; c=relaxed/simple;
	bh=7Q6ncgRAbXJreCEOLQquDjBeczd9LOxPATvaYBPOzGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/TeMRgQhTvE1ZtWlrCfRzGMYezCa0iysyGUC0iXNRRXYJBe+iS7u8+K2FZ5ACftsSVrWEQpBk56Kutrr5SWUdlY5e/jWgq2dw9A6tzdpiPBgyb9wJlXj2fOuyIYtz/2d9zHR68M2T3Zrp6Ajscsnro+SbY16RRFVLFT8OY1bFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AA60431DD;
	Tue,  4 Nov 2025 13:18:57 +0000 (UTC)
Message-ID: <54c761d900342caac13bc15417dc4fa9ad5659cb.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3] battery: improve the display of the charge
 level
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Date: Tue, 04 Nov 2025 14:18:56 +0100
In-Reply-To: <CABBYNZKmU3k6H4AsY-2TUVdFGQ0-rSD4=WRmi2KCKMyjz=vy4g@mail.gmail.com>
References: <20251028144320.104871-1-r.smirnov@omp.ru>
	 <399171165c10f8edc9b39d16e06ec3d59a2beeb7.camel@hadess.net>
	 <CABBYNZKmU3k6H4AsY-2TUVdFGQ0-rSD4=WRmi2KCKMyjz=vy4g@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnheptdfffeehleejueeuvdffkeetuddtjeefudegleetueelieelheevtdejvedvgeffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhtkhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhdrshhmihhrnhhovhesohhmphdrrhhup
 dhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-10-28 at 11:47 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, Oct 28, 2025 at 11:01=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > Hey,
> >=20
> > Going to make a few comments inline. Those would be in addition to
> > Luiz' comments, and not meant to replace them.
> >=20
> > On Tue, 2025-10-28 at 17:43 +0300, Roman Smirnov wrote:
> > > The battery charge level may fluctuate due to uncalibrated
> > > sensors. Commit smooths out such fluctuations.
> > >=20
> > > The algorithm for determining uncalibrated sensors consists of
> > > finding the number of changes in charge direction (i.e.,
> > > "spikes").
> > > If the number of spikes is zero, the device is charging or
> > > discharging.
> > > If there is one spike, it may mean that the device has started
> > > charging
> > > or has been disconnected from charging. If there are two or more
> > > spikes,
> > > this is a clear indication of an uncalibrated sensor.
> > >=20
> > > Check that the battery charge is fluctuating. If the battery
> > > charge
> > > is fluctuating, use the average charge value, otherwise use the
> > > current
> > > value.
> > >=20
> > > Fixes: https://github.com/bluez/bluez/issues/1612
> > > ---
> > > V2 -> V3: A queue is used instead of an array for the last
> > > charges,
> > > a bug with the spikes variable increment has been fixed, and the
> > > fluctuation check is called each time a new battery charge
> > > appears.
> > >=20
> > > V1 -> V2: Smoothing is only applied to uncalibrated sensors, the
> > > last 8 values are saved instead of 4, and the average value is
> > > used
> > > for smoothing instead of the minimum value.
> > >=20
> > > =C2=A0src/battery.c | 70
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A01 file changed, 70 insertions(+)
> > >=20
> > > diff --git a/src/battery.c b/src/battery.c
> > > index 59e4fc570..33079975c 100644
> > > --- a/src/battery.c
> > > +++ b/src/battery.c
> > > @@ -33,10 +33,15 @@
> > > =C2=A0#define BATTERY_PROVIDER_MANAGER_INTERFACE
> > > "org.bluez.BatteryProviderManager1"
> > >=20
> > > =C2=A0#define BATTERY_MAX_PERCENTAGE 100
> > > +#define LAST_CHARGES_SIZE 8
> > > +#define MAX_CHARGE_STEP 5
> > >=20
> > > =C2=A0struct btd_battery {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *path; /* D-Bus object path */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t percentage; /* valid between 0=
 to 100 inclusively
> > > */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct queue *last_charges; /* last charges=
 received */
> >=20
> > Instead of open-coding a queue, I think that a GArray would be
> > better:
> > https://docs.gtk.org/glib/struct.Array.html
>=20
> We don't recommend using glib specific structures on new code, we
> don't want new dependencies even if it is already supported on the
> required version.

OK, that's a shame because that might make some things easier. Are we
looking to replace existing glib data types with more generic C
datatypes, and maybe sprinkle some modern C on top of that, a-la
systemd?

It has FOREACH() loops for a lot of container-types, cleanup functions,
etc.

> > - limit ->len to LAST_CHARGES_SIZE
> > - ability to add items from either side, truncate the queue or
> > remove
> > an arbitrary item
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 float avg_charge; /* average battery charge=
 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 bool is_fluctuating; /* true, if the batter=
y sensor
> > > fluctuates */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *source; /* Descriptive source of=
 the battery info */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *provider_path; /* The provider r=
oot path, if any */
> > > =C2=A0};
> > > @@ -92,6 +97,10 @@ static struct btd_battery *battery_new(const
> > > char
> > > *path, const char *source,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery =3D new0(struct btd_battery, 1=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery->path =3D g_strdup(path);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery->percentage =3D UINT8_MAX;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 battery->last_charges =3D queue_new();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 battery->avg_charge =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 battery->is_fluctuating =3D false;
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (source)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 battery->source =3D g_strdup(source);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (provider_path)
> > > @@ -105,6 +114,9 @@ static void battery_free(struct btd_battery
> > > *battery)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (battery->path)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(battery->path);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (battery->last_charges)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 queue_destroy(battery->last_charges, NULL);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (battery->source)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(battery->source);
> > >=20
> > > @@ -217,8 +229,49 @@ bool btd_battery_unregister(struct
> > > btd_battery
> > > *battery)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > =C2=A0}
> > >=20
> > > +static void check_fluctuations(struct btd_battery *battery)
> >=20
> > Instead of having this function, and quite complicated handling of
> > that
> > same queue of battery levels in btd_battery_update(), it would be
> > great
> > if the code was contained all within a function (or two) and used
> > non-
> > BlueZ specific data types.
> >=20
> > So that the code could be split off into its own battery helper,
> > and
> > could have a unit test showing a few different cases.
>=20
> I guess you are suggesting something to go into src/shared (e.g.
> battery.c:bt_battery) so it can be unit tested, while I think this
> would be nice to have Id leave this to Roman to decide since it may
> require some work to put it together and then generate test cases
> that
> cover fluctuation and other things we might want to check with the
> code.

Testing fluctuations is one thing, testing that we don't access the
array out-of-bounds was what I was really interested in.
7
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct queue_entry *entry;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t spikes =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t step;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t direction =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t prev_direction;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *prev_charge;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *next_charge;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (entry =3D queue_get_entries(battery->l=
ast_charges);
> > > entry->next;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D ent=
ry->next) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 prev_direction =3D direction;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 prev_charge =3D entry->data;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 next_charge =3D entry->next->data;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 step =3D *next_charge - *prev_charge;
>=20
> It might be a good idea to store the values as pointers (using
> UINT_TO_PTR/PTR_TO_UINT), that way we avoid this kind of construct
> above where you have to use pointers and risk having NULL pointers
> bugs for example.
>=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * The battery charge fluctuates too much,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * which may indicate a battery problem, so
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * the actual value should be displayed.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (abs(step) >=3D MAX_CHARGE_STEP) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 battery->is_fluctuat=
ing =3D false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (step > 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 direction =3D 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 else if (step < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 direction =3D -1;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (direction !=3D prev_direction && prev_direction)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spikes++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 battery->is_fluctuating =3D (spikes > 1) ? =
true : false;
> > > +}
> > > +
> > > =C2=A0bool btd_battery_update(struct btd_battery *battery, uint8_t
> > > percentage)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *p_percentage;
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("path =3D %s", battery->path);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!queue_find(batteries, NULL, batte=
ry)) {
> > > @@ -231,6 +284,23 @@ bool btd_battery_update(struct btd_battery
> > > *battery, uint8_t percentage)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!battery->avg_charge)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 battery->avg_charge =3D percentage;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exponential smoothing */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 battery->avg_charge =3D battery->avg_charge=
 * 0.7 +
> > > percentage
> > > * 0.3;
> >=20
> > Magic numbers should be #define's constants.
> >=20
> > As Luiz mentioned, it would be great if there was some prior art
> > referenced, perhaps the reference implementation in another
> > application.
> >=20
> > Or an explanation as to why this could needs to live here instead
> > of,
> > say, upower, which deals with heuristics, dodgy hardware, etc.
>=20
> This is a good question, what is the algorithm upower used for
> handling the battery level?

upower doesn't have any of that sort of thing for device batteries, but
main system batteries have a lot of work-arounds for broken battery
controllers/ECs.
