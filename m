Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DD13CA9C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505945; cv=none; b=H9unY9q6xL+z86C74KINzaasWfP1YW5CwltHXeJLJBuv5PFdvKy+Buwy+3029OV6RjFf5Up/o6x/ImavT7ZdD6uVvoF8ApBAoYEWl9mp8/vMSH5Kw5aBCWu58XgTfuMWr2EP8TbyqVQUboe3Ih2MiaAnCfHffnarjeukLJuhKHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505945; c=relaxed/simple;
	bh=RbmxpzGz8MCu/QrrYhHYzi9IaQOsqZr9IpKvB0TSPx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlnn8VtEyrheKbkLsSP4tdAi8D1DIPxb33FUeqlhsv/C5BKFAhFLoUJqT1zh/xLkz/g7fjaDxvotMWyTAZz6a49tio8Sfr6ZEa6IVYoWGyIJI9pskHU2lcEKBlVCzOx0P/Vaj9GGJhhk4l0ZYGjuykzM4r9qmcFt/BBZCC2wTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn/J8Au2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn/J8Au2"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548409cd2a8so1299111e87.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505941; x=1746110741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxwapVFuc+wiZNHj7K56hQgEwSxeBSE+ZYXaMNyFRWk=;
        b=Nn/J8Au2iY3bxZwpBxO+wDaFfd7nAdntzPU69EyoS8uCIm0x1SyYqk1fV90bTohNrI
         vZPhcRa2xIOuIFG+gNuNNwGjDZppaPGjm8bCViC1KIyjouFiR9/xA6r/be2jK5BiqlsQ
         aOkxd+L8StCyTn6aD3wMxjlynTExV8l5UDz8tiZUL1nWFtwrsCrolZBEUMlT5fk/zO23
         sXswllp9tnI1onHOtmDmytZSpUAU/SvL129a10zlMuwelRko8cz/e3Jb+zYMLKsG7iIC
         QDbpCni3UIBf2iuqNiWLzaAVW6/KW722IVffiKHRo5OCPwhoHWWeu5oqZdFK6a2sDHYi
         S25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505941; x=1746110741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxwapVFuc+wiZNHj7K56hQgEwSxeBSE+ZYXaMNyFRWk=;
        b=eR7s61Df/z/3EGecXrXGJQO18T18sdAEfPekoe4zVvh485VuIzqFBckink3RdzPyxO
         MGMwG2/ajHKOPXFyaZOU0YL9CsmqofNNGGZLlTgFSoHD+HYPODWUWLeXRU5EhlRRFQUV
         GZTT5ZEA4oyx60oxatAmz6HCsuTVLh6H5uqUvM5WLYK4kECSVJrm+quHeMFpDNDoYlf3
         VhjgkEs8nzymuzUq4AyTgVTlfWtKlkh1m+n5fws9tdHp5eW5wHI1KX0fvTSFnfGoLVqS
         /GUpp70B+d9NSt10IsXmT0tOb6mK8sSJsQZqZYAg9jroejXINzUiVewSM5lvwFXPH4A3
         AfNg==
X-Gm-Message-State: AOJu0Yyq+6aX/goyA9R8VyvqLj3zC1rmw/2lA5oviIAqs7rLdxFalL2F
	DSSOiE8YgctnyI4VUdU+0Yc1JKIzUzJrdr+RQcXk93o4aiHwjB2m4ae40O/nDQeSO+Xq1UXGd4r
	tuQaFLY494W4Fq9jJQKk5Kw/coo/ECQ==
X-Gm-Gg: ASbGncu3DFWIJ/sUQUhBgbiFUef0KCAhcEfc/y3mAbnfAqKnNC0WVkitT4h2V0xL2os
	+ke2/fOcnCEykYNm7Zf5CN2unS1dg5LCKAXhXYuh86j6+ogcbcFxBTXoePyj57ejfGJW7TB1MNj
	8Nr3sSB6VRnokor1EfNkBYtESlSrOHdWU=
X-Google-Smtp-Source: AGHT+IF6KKCAjQVaSNi8nmnlGA9kFrXTSfRnBZqG4yR3UJ7OJpTGC4ArPS35GgtWSvCH1qLeTTVeypQBed2gkb4xnQo=
X-Received: by 2002:a05:651c:1588:b0:30c:3f82:6844 with SMTP id
 38308e7fff4ca-3179ffc076amr12243421fa.34.1745505941118; Thu, 24 Apr 2025
 07:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
 <20250423144020.358828-9-ludovico.denittis@collabora.com> <CABBYNZJ4+=zmArfh6bckzH-9z0HwV9besE1xM3OcjZbSh+b=1A@mail.gmail.com>
 <62ec9d1f-b3ff-4f3d-8e10-e43c50e9920f@collabora.com>
In-Reply-To: <62ec9d1f-b3ff-4f3d-8e10-e43c50e9920f@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 10:45:28 -0400
X-Gm-Features: ATxdqUGg8TXXoaFxqw3z6BnwuLq3a8MI5QhpPD-mpt7Wtpp-6Wn0-BW-8jaAI7w
Message-ID: <CABBYNZLC1C-rFx9NbHdwnAsSuui+WHUVPwELsgHeN3xDkPZW+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 8/8] input: Validate the Sixaxis HID report descriptor
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Thu, Apr 24, 2025 at 10:37=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 4/23/25 4:56 PM, Luiz Augusto von Dentz wrote:
> > Hi Ludovico,
> >
> > On Wed, Apr 23, 2025 at 10:41=E2=80=AFAM Ludovico de Nittis
> > <ludovico.denittis@collabora.com> wrote:
> >> Given that the Sixaxis devices can't work with encryption, i.e. they
> >> only work with BT_IO_SEC_LOW, this makes it harder to notice if the
> >> device we are talking to is the expected Sixaxis gamepad or an imposto=
r.
> >>
> >> To reduce the possible attack surface, we ensure that the report
> >> descriptor that the device provided resembles what a real Sixaxis
> >> gamepad should have. E.g. it should only have Usages for `Joystick`,
> >> `Pointer` etc... and nothing unexpected like `Keyboard`.
> >> ---
> >>   profiles/input/device.c | 71 +++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 71 insertions(+)
> >>
> >> diff --git a/profiles/input/device.c b/profiles/input/device.c
> >> index 9f05757a6..6f538759b 100644
> >> --- a/profiles/input/device.c
> >> +++ b/profiles/input/device.c
> >> @@ -1062,9 +1062,72 @@ static gboolean encrypt_notify(GIOChannel *io, =
GIOCondition condition,
> >>          return FALSE;
> >>   }
> >>
> >> +static bool validate_sixaxis_rd_data(const uint8_t *rd_data, uint16_t=
 rd_size)
> >> +{
> >> +       uint16_t i;
> >> +       size_t data_size =3D 0;
> >> +
> >> +       for (i =3D 0; i < rd_size; i +=3D 1 + data_size) {
> >> +               uint8_t b =3D rd_data[i];
> >> +
> >> +               /* Long items are reserved for future use, HID 1.11 Se=
ction 6.2.2.3 */
> >> +               if (b =3D=3D 0xFE) {
> >> +                       DBG("The sixaxis HID report descriptor has an =
unexpected long item");
> >> +                       return false;
> >> +               }
> >> +
> >> +               /* Extract data following the HID 1.11 Section 6.2.2.2=
 */
> >> +               uint8_t bSize =3D b & 0x03;
> >> +               uint8_t bType =3D (b >> 2) & 0x03;
> >> +               uint8_t bTag =3D (b >> 4) & 0x0F;
> >> +               data_size =3D bSize =3D=3D 3 ? 4 : bSize;
> >> +
> >> +               if ((i + 1 + data_size) > rd_size)
> >> +                       break;
> >> +
> >> +               const uint8_t *data =3D &rd_data[i + 1];
> >> +
> >> +               if (bType =3D=3D 1 && bTag =3D=3D 0x0 && data_size >=
=3D 1) {
> >> +                       /* Usage Page (Generic Desktop) */
> >> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x01)
> >> +                               continue;
> >> +
> >> +                       /* Usage Page (Button) */
> >> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x09)
> >> +                               continue;
> >> +
> >> +                       /* Usage Page (Vendor Defined Page 1) */
> >> +                       if (data_size =3D=3D 2 && data[0] =3D=3D 0x00 =
&& data[1] =3D=3D 0xFF)
> >> +                               continue;
> >> +
> >> +                       DBG("The sixaxis HID report descriptor has an =
unexpected Usage Page: 0x%02X", data[0]);
> >> +                       return false;
> >> +               }
> >> +
> >> +               if (bType =3D=3D 2 && bTag =3D=3D 0x0 && data_size >=
=3D 1) {
> >> +                       /* Usage (Joystick) */
> >> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x04)
> >> +                               continue;
> >> +
> >> +                       /* Usage (Pointer) */
> >> +                       if (data_size =3D=3D 1 && data[0] =3D=3D 0x01)
> >> +                               continue;
> >> +
> >> +                       /* Axis usages, e.g. Usage (X) */
> >> +                       if (data_size =3D=3D 1 && data[0] >=3D 0x30 &&=
 data[0] <=3D 0x35)
> >> +                               continue;
> >> +
> >> +                       DBG("The sixaxis HID report descriptor has an =
unexpected Usage: 0x%02X", data[0]);
> >> +                       return false;
> >> +               }
> >> +       }
> >> +       return true;
> >> +}
> > The code above shall probably be placed in the sixaxis plugin, so it
> > checks if all the reports is proper and only then set cable pairing is
> > complete, so we don't have to check on every connection.
>
> I was under the wrong impression that a device could update its report
> at every connection.
> If this only happens at pairing time, then doing the check there is
> definitely better.
>
> And actually, in that case, it shouldn't be needed at all for the
> sixaxis because apparently
> we manually replace it already with `btd_device_set_record()` if we are
> in the
> `CABLE_PAIRING_SIXAXIS` situation.
>
> I'm gonna follow up with a v3 in a few minutes.

Yeah it looks like the record is created directly by sixaxis plugin,
that said Im not sure what is the actual record if we attempt to
discover it over SDP? In the other hand that means there is nothing
for us to validate the behavior of the device, well it will be limited
to what the kernel driver is capable of but Im not sure if the kernel
driver does limit the inputs, etc.

>
> >>   static int hidp_add_connection(struct input_device *idev)
> >>   {
> >>          struct hidp_connadd_req *req;
> >> +       bool sixaxis_cable_pairing;
> >>          GError *gerr =3D NULL;
> >>          int err;
> >>
> >> @@ -1090,6 +1153,14 @@ static int hidp_add_connection(struct input_dev=
ice *idev)
> >>
> >>          sixaxis_cable_pairing =3D device_is_sixaxis_cable_pairing(ide=
v->device);
> >>
> >> +       /* The Sixaxis devices must use the security level BT_IO_SEC_L=
OW to work. */
> >> +       /* We reduce the attack surface by ensuring that the report de=
scriptor only */
> >> +       /* contains the expected Usages that a real Sixaxis gamepad ha=
s */
> >> +       if (sixaxis_cable_pairing && !validate_sixaxis_rd_data(req->rd=
_data, req->rd_size)) {
> >> +               error("The sixaxis HID SDP record has unexpected entri=
es, rejecting the connection to %s", idev->path);
> >> +               goto cleanup;
> >> +       }
> >> +
> >>          /* Make sure the device is bonded if required */
> >>          if (!sixaxis_cable_pairing && classic_bonded_only && !input_d=
evice_bonded(idev)) {
> >>                  error("Rejected connection from !bonded device %s", i=
dev->path);
> >> --
> >> 2.49.0
> >>
> >>
> >
>


--=20
Luiz Augusto von Dentz
