Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64234405E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666458; cv=none; b=ES0YI4wyzTCl0HYDcUdKbd8v5f1jmesUQCfNRLOpSyrbi+QX0rZdnk6yvx+IDmyD4/X3VyQykmYCuG6FY9b+uh0cpvNAhOnxqRpzAuKlyrfAU9UM+qFEeNDukXrTSKZZ3bPn9+a3PAt+ly+rb5Q2fm02oKJNJDRrbbJ4GFSuL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666458; c=relaxed/simple;
	bh=/bZxqjKt3G4oitur4bs6oRYLq5T05lMGJeOAbq1EPDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVJdEpOx/0/YJPC4lqlpxaABtyJ51KVpP2T7KD0yOZ6kMNDSKqN5ekiP3NE2Xykl/4ltvitKmWekt3noFxOy2kMgLHpzs78G4jxUkG/y8rMV+/jzUnM7wXqXTKX2MuorcpxG1EZGvmiWzA6ckEjlva2DeIG961nxjbSiPUd5CAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoI4A/el; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoI4A/el"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592f7e50da2so26708e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666454; x=1762271254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH1Sox04xP4Y5Q8HSpb9lvGAymzPTUC7LCgKphjdafc=;
        b=MoI4A/elY7Bf+H9UNb4ibqXGostWR8Kl7cnh/ejqwSDbQSiWhFMgFraTA7ap7TeCWJ
         rcUZwTiOsiewKQkOCjh6Nn0bDfnavAcS+QmtOcQ+zkc9mCrVmhzDF6tinmXLpmpcPIcu
         /6c6O+2Auv7AgOdAqp0IdFg1IAr8IEXq4Z1c44D4AyIcHC0ZRf+c8UhkvbJ2lZY5oueW
         R6Vtx4rLKji6ljgao3zcUJZzgQrVQTQwmtbhfqDCauYH6ozCQSJnVAJGxlIQv6PKgHeV
         TRL9p0Eamd1KXghjkDDvHR1OoFRhedRGOVIMwOu6LtX2VxAaYIoMOWk5ApAxBY7R1xgt
         TeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666454; x=1762271254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH1Sox04xP4Y5Q8HSpb9lvGAymzPTUC7LCgKphjdafc=;
        b=bGeMLNfDyxchZPLDF6FpUW7v+dOLCQfA61xOUih9r78BbI1rkuEIT26Bv0GpAVNJdx
         Ctzs2JqT8S6aNutDwxVAtE5NDcl5yJNBykgMicgjIS1L8jHXqiYT35kWJB/1v2vOLcqE
         62JjCH1IbmbfE2WNRHaPsEj8Dsr3Ba9SV7MKYURlo6T7wkDNtB+VT1bQN4ZsbmnJwC6j
         N731PScE3ARvRlOaMhrM9F9abCxy2DB01VdbUp8T8vAYovfFCqkG4FaSnvc5i8c2Z8lz
         vX3eu3Itq+aFFrbiSEsJSY2oxE8iaiJFlpwq/LeeWFHVKk2xf9GjVWW8Qm1OHwIXU6qJ
         SJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnLnPcVgl4t7o8TYGYHiSjAUKJAVrGAsmj62bg5v9Gm7HdJ5OqYmOoSxTi1lXOFtV4xriRIK1MjLN50EyxOP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4IEnhCzMJr1jLi3pKQmxyrYaO44lI1J+jBPOmdDTj3rDSNOY
	X4O2OqCnp3V4hgGL0B3JzfTSbwOtRUWST12j8i6d43lzLc8iUpr1CQU9f1CFztwKOyhkRgDrE5X
	YefHE3iYXhfj9pRjKutwpunCwQLNJwaKWfFskIjY=
X-Gm-Gg: ASbGncvzgMQf1kRnkevIXQ+yxTh/ljgi5aV6oyUCBxjSWwaQDwSCJqrd8NccTi3dtvv
	VGCyz1dRp5DiOLMiJwlyKZ1wSJOgJNX7hXT/g8JVbSVmHNGkabZ9x631OC3W/7eM3fqX78qMFtE
	2juBbRLKiXjvX3fHfRF+1J75vzdbUZPS80ACI1sYCOys8DgMAJir1uSUp0JTZ7717fRQol0Ig3H
	HIdO6BefSmFyoW+HMQzO5+d3LfaE9RJx8hsfdvbsdlA7H72XUAe1WpF47M=
X-Google-Smtp-Source: AGHT+IEDYtNN1GxejYp9gJdKUz0nC+XYC6vz5gfHWzGDBSG5ZFJ7Q88SbtvUNfrvjQ5zP+tI48aGGe1WPhwVaVo7t0g=
X-Received: by 2002:a05:6512:3ca3:b0:55f:6cc3:45a6 with SMTP id
 2adb3069b0e04-5930edf7db4mr1167566e87.13.1761666453685; Tue, 28 Oct 2025
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028144320.104871-1-r.smirnov@omp.ru> <399171165c10f8edc9b39d16e06ec3d59a2beeb7.camel@hadess.net>
In-Reply-To: <399171165c10f8edc9b39d16e06ec3d59a2beeb7.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Oct 2025 11:47:20 -0400
X-Gm-Features: AWmQ_bm_P3oHjXpl7VGH5_W6RlgnA_gE_GQvZ7xkR6kev_gzYGZtwNoFjdAEdVw
Message-ID: <CABBYNZKmU3k6H4AsY-2TUVdFGQ0-rSD4=WRmi2KCKMyjz=vy4g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] battery: improve the display of the charge level
To: Bastien Nocera <hadess@hadess.net>
Cc: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Oct 28, 2025 at 11:01=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> Hey,
>
> Going to make a few comments inline. Those would be in addition to
> Luiz' comments, and not meant to replace them.
>
> On Tue, 2025-10-28 at 17:43 +0300, Roman Smirnov wrote:
> > The battery charge level may fluctuate due to uncalibrated
> > sensors. Commit smooths out such fluctuations.
> >
> > The algorithm for determining uncalibrated sensors consists of
> > finding the number of changes in charge direction (i.e., "spikes").
> > If the number of spikes is zero, the device is charging or
> > discharging.
> > If there is one spike, it may mean that the device has started
> > charging
> > or has been disconnected from charging. If there are two or more
> > spikes,
> > this is a clear indication of an uncalibrated sensor.
> >
> > Check that the battery charge is fluctuating. If the battery charge
> > is fluctuating, use the average charge value, otherwise use the
> > current
> > value.
> >
> > Fixes: https://github.com/bluez/bluez/issues/1612
> > ---
> > V2 -> V3: A queue is used instead of an array for the last charges,
> > a bug with the spikes variable increment has been fixed, and the
> > fluctuation check is called each time a new battery charge appears.
> >
> > V1 -> V2: Smoothing is only applied to uncalibrated sensors, the
> > last 8 values are saved instead of 4, and the average value is used
> > for smoothing instead of the minimum value.
> >
> >  src/battery.c | 70
> > +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/src/battery.c b/src/battery.c
> > index 59e4fc570..33079975c 100644
> > --- a/src/battery.c
> > +++ b/src/battery.c
> > @@ -33,10 +33,15 @@
> >  #define BATTERY_PROVIDER_MANAGER_INTERFACE
> > "org.bluez.BatteryProviderManager1"
> >
> >  #define BATTERY_MAX_PERCENTAGE 100
> > +#define LAST_CHARGES_SIZE 8
> > +#define MAX_CHARGE_STEP 5
> >
> >  struct btd_battery {
> >       char *path; /* D-Bus object path */
> >       uint8_t percentage; /* valid between 0 to 100 inclusively */
> > +     struct queue *last_charges; /* last charges received */
>
> Instead of open-coding a queue, I think that a GArray would be better:
> https://docs.gtk.org/glib/struct.Array.html

We don't recommend using glib specific structures on new code, we
don't want new dependencies even if it is already supported on the
required version.

> - limit ->len to LAST_CHARGES_SIZE
> - ability to add items from either side, truncate the queue or remove
> an arbitrary item
>
> > +     float avg_charge; /* average battery charge */
> > +     bool is_fluctuating; /* true, if the battery sensor
> > fluctuates */
> >       char *source; /* Descriptive source of the battery info */
> >       char *provider_path; /* The provider root path, if any */
> >  };
> > @@ -92,6 +97,10 @@ static struct btd_battery *battery_new(const char
> > *path, const char *source,
> >       battery =3D new0(struct btd_battery, 1);
> >       battery->path =3D g_strdup(path);
> >       battery->percentage =3D UINT8_MAX;
> > +     battery->last_charges =3D queue_new();
> > +     battery->avg_charge =3D 0;
> > +     battery->is_fluctuating =3D false;
> > +
> >       if (source)
> >               battery->source =3D g_strdup(source);
> >       if (provider_path)
> > @@ -105,6 +114,9 @@ static void battery_free(struct btd_battery
> > *battery)
> >       if (battery->path)
> >               g_free(battery->path);
> >
> > +     if (battery->last_charges)
> > +             queue_destroy(battery->last_charges, NULL);
> > +
> >       if (battery->source)
> >               g_free(battery->source);
> >
> > @@ -217,8 +229,49 @@ bool btd_battery_unregister(struct btd_battery
> > *battery)
> >       return true;
> >  }
> >
> > +static void check_fluctuations(struct btd_battery *battery)
>
> Instead of having this function, and quite complicated handling of that
> same queue of battery levels in btd_battery_update(), it would be great
> if the code was contained all within a function (or two) and used non-
> BlueZ specific data types.
>
> So that the code could be split off into its own battery helper, and
> could have a unit test showing a few different cases.

I guess you are suggesting something to go into src/shared (e.g.
battery.c:bt_battery) so it can be unit tested, while I think this
would be nice to have Id leave this to Roman to decide since it may
require some work to put it together and then generate test cases that
cover fluctuation and other things we might want to check with the
code.

> > +{
> > +     const struct queue_entry *entry;
> > +     uint8_t spikes =3D 0;
> > +     int8_t step;
> > +     int8_t direction =3D 0;
> > +     int8_t prev_direction;
> > +     uint8_t *prev_charge;
> > +     uint8_t *next_charge;
> > +
> > +     for (entry =3D queue_get_entries(battery->last_charges);
> > entry->next;
> > +          entry =3D entry->next) {
> > +             prev_direction =3D direction;
> > +             prev_charge =3D entry->data;
> > +             next_charge =3D entry->next->data;
> > +             step =3D *next_charge - *prev_charge;

It might be a good idea to store the values as pointers (using
UINT_TO_PTR/PTR_TO_UINT), that way we avoid this kind of construct
above where you have to use pointers and risk having NULL pointers
bugs for example.

> > +
> > +             /*
> > +              * The battery charge fluctuates too much,
> > +              * which may indicate a battery problem, so
> > +              * the actual value should be displayed.
> > +              */
> > +             if (abs(step) >=3D MAX_CHARGE_STEP) {
> > +                     battery->is_fluctuating =3D false;
> > +                     return;
> > +             }
> > +
> > +             if (step > 0)
> > +                     direction =3D 1;
> > +             else if (step < 0)
> > +                     direction =3D -1;
> > +
> > +             if (direction !=3D prev_direction && prev_direction)
> > +                     spikes++;
> > +     }
> > +
> > +     battery->is_fluctuating =3D (spikes > 1) ? true : false;
> > +}
> > +
> >  bool btd_battery_update(struct btd_battery *battery, uint8_t
> > percentage)
> >  {
> > +     uint8_t *p_percentage;
> > +
> >       DBG("path =3D %s", battery->path);
> >
> >       if (!queue_find(batteries, NULL, battery)) {
> > @@ -231,6 +284,23 @@ bool btd_battery_update(struct btd_battery
> > *battery, uint8_t percentage)
> >               return false;
> >       }
> >
> > +     if (!battery->avg_charge)
> > +             battery->avg_charge =3D percentage;
> > +
> > +     /* exponential smoothing */
> > +     battery->avg_charge =3D battery->avg_charge * 0.7 + percentage
> > * 0.3;
>
> Magic numbers should be #define's constants.
>
> As Luiz mentioned, it would be great if there was some prior art
> referenced, perhaps the reference implementation in another
> application.
>
> Or an explanation as to why this could needs to live here instead of,
> say, upower, which deals with heuristics, dodgy hardware, etc.

This is a good question, what is the algorithm upower used for
handling the battery level?

--=20
Luiz Augusto von Dentz
