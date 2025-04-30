Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0220CCE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026463; cv=none; b=E4I/TkDEHIhgIWmYma9MvWRJPyNQwXyCIUwLmQySYJisbNEC5vLFW671FG3FCXXmvywYxjSRzM1rap4ELx4X0d5VjPhjGTCDNVOaTbH24j6Gg7oW8uBfJyJ8FMpFCmDwpNraDzi0U1dJPnMJPBdwE9ecXwBMHfDOkjDL8tqab3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026463; c=relaxed/simple;
	bh=Nk+Am8/iUytRUaQ4iH0OJmdcUVQtxXScU70G5anafWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOpf+OqYwQKPOLzFWHysoZNkSb4WRz/Q6/orF4v0k4DCGxSOXFSE6t7GPwRe7h/ikDZbr0EkEPHFJ8NLu/3238t6khA73a/mJjDrPBJo8nzm7fl3oZyeBPB3ek6rgMDV2huvUwbkOCZp+aVC+n3mIR+0tunSz3WAyxTNqR66LFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfYIzjrA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfYIzjrA"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d98aa5981so9477434e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746026460; x=1746631260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ4QfWt9dAZxTfomkZ6XpxyfodO3dfGg/qb1ERnDAfI=;
        b=BfYIzjrAYN+uVwZI+EV76milBQLTBG40P7PtpkFwKazVB2oGpWXdAGLTV33HFLUrUv
         0ROGBSxBojSyVA4QePYkHKQ9SUFMwwciSKFFmelV/MG0DA4v18xJrOF66EsA0qIEqo5Q
         7aqgDeVKUqFR28AygK346+M0PS6MsWd7JGI7gVrIorNCwGcQEEZ5ZU2mpTjqLHKbXS6N
         AReFmGfSCtmVUik8dd3ISlU1eK8GDB1fSH7vMm68wtppQU9h2cdfNeg5hIrhkxDwTSuw
         Lh9H4CRQ/h7A8TSdgpS2zSy/jyNnjCuK3rC7iyy56t/nLEb7Z/gnDjfM5jWz1mUVSPIK
         oWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746026460; x=1746631260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ4QfWt9dAZxTfomkZ6XpxyfodO3dfGg/qb1ERnDAfI=;
        b=SHH6Xy2D9OW+vrO14y2RBVGDOSG/2BtAu1Llz9D4M2ZBDLEtwmp5ko8QlDzSD4WMaJ
         GWzWhVQTDpulRzWfBASW/aYAkQMsBPNr6ZG/7UhCb5noHw+lbQ8jyZ7w6bh7dmOuYaw6
         KPjwcR4B9sIRJBVitVGneTG8cpM1Br/3JllPlglkqycQh45S5rnRMNVZ1aSjCbnZb3EL
         MkcFLIRSrpu3hIKkMt2Z0OzGzmnzctc3WrueV+C9QAKpZ6NipelzVilET+u1yfJTMxYW
         ptkAyX/Mgb2C5aHxz8xVzNVr62owVm6gXUiXikb9hNv3wwNbCtE87J4qtOzneKYx2Ci1
         6Fng==
X-Gm-Message-State: AOJu0Yx8Cl7jOBlEfr7Dac8X5n395F6hJs3SoWGnlgI9sh9CyzvrTNtJ
	QJ48pDW0JjpfJkWAyn9dRs2J9cpXjes4XC+zdZ2QMN7PvOqAGWKNGT3jIhzCFUeCRkEYHq4hLJH
	onJB+v5ADxlq1oclCVHCE82gjfKUEvA==
X-Gm-Gg: ASbGnctifXbaFjdmzeuhJ+/Ui3UQoqLesPUCcekuQYwDmZNSZHuYkt3AGpSczlUgWow
	/yQafRgkRwFSrqXfXqb1hIgNHtPM0WezNKBqZe25JE1FhXAOJvGzDjNox7qGMj+2rMjl+nCbkss
	WzuGKOyPBY7WyV5WiKxJMI
X-Google-Smtp-Source: AGHT+IG6bAQqSh/u0rIjiU+nT+ibASiJOsaOlJp8EOe3nUw0IoykEsET5F3F+5lZwpo7eyGm+upT5FjGyKA5aR7jSxY=
X-Received: by 2002:a05:6512:3090:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-54ea33ab4d2mr1056992e87.46.1746026459630; Wed, 30 Apr 2025
 08:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430143610.387300-1-thomas.perale@mind.be> <20250430143610.387300-3-thomas.perale@mind.be>
In-Reply-To: <20250430143610.387300-3-thomas.perale@mind.be>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Apr 2025 11:20:46 -0400
X-Gm-Features: ATxdqUF3lBjW6rDKGZtUl1ZZZixqk054yAQDykTKyGV37Cht3px3SxJpAMVmXfc
Message-ID: <CABBYNZK8wTSAD=4A3Rvc59tLwr7JvC1wWZbSduQCUNonjhk68Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] input: fix HoG compilation w/o HID
To: Thomas Perale <thomas.perale@mind.be>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, Apr 30, 2025 at 10:42=E2=80=AFAM Thomas Perale <thomas.perale@mind.=
be> wrote:
>
> Commit [1] introduced a dependency with the HID plugin in the HoG code
> As a result, building with --disable-hid --enable-hog caused linker
> errors due to undefined references to HID-related functions:
>
> ```
> > ./configure --disable-hid --enable-hog
> > make
> /usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_accept':
> /home/../bluez/profiles/input/hog.c:184:(.text.hog_accept+0xbb): undefine=
d reference to `input_get_auto_sec'
> /usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect=
':
> /home/../bluez/profiles/input/hog.c:205:(.text.hog_disconnect+0x12): unde=
fined reference to `input_get_userspace_hid'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:6344: src/bluetoothd] Error 1
> make: *** [Makefile:4695: all] Error 2
> ```
>
> This patch introduces the HAVE_HID symbol to conditionally call the
> HID-related code in the HoG plugin only when HID is enabled.
>
> Additionally, hog_disconnect() reverts to its pre-[1] behavior when
> the HID plugin is unavailable.
>
> [1] 1782bfd79 input: Add support for UserspaceHID=3Dpersist
>
> Fixes: https://github.com/bluez/bluez/issues/1228
> ---
>  configure.ac         |  3 +++
>  profiles/input/hog.c | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1e089aaa7..aa56b7b81 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -194,6 +194,9 @@ AM_CONDITIONAL(NETWORK, test "${enable_network}" !=3D=
 "no")
>  AC_ARG_ENABLE(hid, AS_HELP_STRING([--disable-hid],
>                 [disable HID profile]), [enable_hid=3D${enableval}])
>  AM_CONDITIONAL(HID, test "${enable_hid}" !=3D "no")
> +if test "${enable_hid}" !=3D "no"; then
> +       AC_DEFINE(HAVE_HID, 1, [Define to 1 if you have HID support.])
> +fi
>
>  AC_ARG_ENABLE(hog, AS_HELP_STRING([--disable-hog],
>                 [disable HoG profile]), [enable_hog=3D${enableval}])
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 97224f0d1..7ad94c474 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -40,13 +40,16 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/plugin.h"
>
> -#include "device.h"
>  #include "suspend.h"
>  #include "attrib/att.h"
>  #include "attrib/gattrib.h"
>  #include "attrib/gatt.h"
>  #include "hog-lib.h"
>
> +#ifdef HAVE_HID
> +#include "device.h"
> +#endif /* HAVE_HID */
> +
>  struct hog_device {
>         struct btd_device       *device;
>         struct bt_hog           *hog;
> @@ -181,8 +184,10 @@ static int hog_accept(struct btd_service *service)
>         if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))=
) {
>                 struct bt_gatt_client *client;
>
> +#ifdef HAVE_HID
>                 if (!input_get_auto_sec())
>                         return -ECONNREFUSED;
> +#endif /* HAVE_HID */

This doesn't look correct, the input.conf is used to configure both
HID and HOG, so why do you think it is a good idea to ignore it if HID
has been disabled? What we probably should do is to move the portion
of input_init that are HOG specific, e.g. LEAutoSecurity, which is
what is being used above.

>                 client =3D btd_device_get_gatt_client(device);
>                 if (!bt_gatt_client_set_security(client,
> @@ -202,10 +207,14 @@ static int hog_disconnect(struct btd_service *servi=
ce)
>  {
>         struct hog_device *dev =3D btd_service_get_user_data(service);
>
> +#ifdef HAVE_HID
>         if (input_get_userspace_hid() =3D=3D UHID_PERSIST)
>                 bt_hog_detach(dev->hog, false);
>         else
>                 bt_hog_detach(dev->hog, true);
> +#else
> +       bt_hog_detach(dev->hog, false);
> +#endif /* HAVE_HID */

This part we will probably have to duplicate the parsing of
UserspaceHID from input_init.

>         btd_service_disconnecting_complete(service, 0);
>
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
