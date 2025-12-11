Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20073B8D64
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493416; cv=none; b=Sumha+ONmFG+KMBJUz5P+jLd3UofWfiRrMIz+HnmyMyzpC31SGDmok33sR0dFWI94WDauI05fGDV57dRNXI8v9u7ZbFpUMwKhjP1tPhfRtFYgXNGruye6mCQvc0wq4eTjdUUPDdqTsfOoHYdTxscdijZTJZxY5b09e9cH6fS7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493416; c=relaxed/simple;
	bh=kcU9SyvA6WXuTNIHNe2BjrRkK/jgcjvsjijTh7qaXaE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EH6Dzfq0KAWRqqnNFVOTq49rQGUQlib0//OT55TkTBBh+LaszR7VvJ0VhOgLSSLIqW71ltXAxtbZtyeuOsJLIBOqVMMb3/NR+ENcwqGS4ZiZreVGvli9iXrWNuHCtoOEUQ8cU5QgODhBMGgg6WnaLnm5nCaZyH/b+DlvRVNtg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EE326240027
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 23:48:04 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dS75t3Gybz9rwn;
	Thu, 11 Dec 2025 23:48:02 +0100 (CET)
Message-ID: <081f864de65d00f024fd2418cafd2309eef5dc67.camel@iki.fi>
Subject: Re: [PATCH BlueZ v5 4/7] shared/uinput-util: extract uinput utility
 function from AVCTP
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 11 Dec 2025 22:48:04 +0000
In-Reply-To: <CABBYNZLBEhEeHb7U77WreFguqZefPkPzebRMz0mR-ErJT79BLw@mail.gmail.com>
References: <cover.1765484150.git.pav@iki.fi>
	 <e8fd07e902ad1fbc00113ef57eb89b8970d29a84.1765484150.git.pav@iki.fi>
	 <CABBYNZLBEhEeHb7U77WreFguqZefPkPzebRMz0mR-ErJT79BLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

to, 2025-12-11 kello 17:05 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Extract uinput utility function from AVCTP to src/shared so that it can
> > be reused for MCS.
> > ---
> >  Makefile.am              |   4 +-
> >  src/shared/uinput-util.c | 191 +++++++++++++++++++++++++++++++++++++++
> >  src/shared/uinput-util.h |  31 +++++++
> >  3 files changed, 225 insertions(+), 1 deletion(-)
> >  create mode 100644 src/shared/uinput-util.c
> >  create mode 100644 src/shared/uinput-util.h
> >=20
> > diff --git a/Makefile.am b/Makefile.am
> > index ba0262d5f..4c7177886 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -247,7 +247,9 @@ shared_sources =3D src/shared/io.h src/shared/timeo=
ut.h \
> >                         src/shared/lc3.h src/shared/tty.h \
> >                         src/shared/bap-defs.h \
> >                         src/shared/asha.h src/shared/asha.c \
> > -                       src/shared/battery.h src/shared/battery.c
> > +                       src/shared/battery.h src/shared/battery.c \
> > +                       src/shared/uinput-util.h \
> > +                       src/shared/uinput-util.c
> >=20
> >  if READLINE
> >  shared_sources +=3D src/shared/shell.c src/shared/shell.h
> > diff --git a/src/shared/uinput-util.c b/src/shared/uinput-util.c
> > new file mode 100644
> > index 000000000..4e9644661
> > --- /dev/null
> > +++ b/src/shared/uinput-util.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2006-2010  Nokia Corporation
> > + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> > + *  Copyright (C) 2011  Texas Instruments, Inc.
> > + *
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <sys/ioctl.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <stdio.h>
> > +#include <stdarg.h>
> > +#include <linux/uinput.h>
> > +
> > +#include "bluetooth/bluetooth.h"
> > +
> > +#include "src/shared/util.h"
> > +#include "src/shared/uinput-util.h"
> > +
> > +
> > +#define DBG(uinput, fmt, arg...) \
> > +       uinput_debug(uinput->debug_func, uinput->debug_data, "%s:%s() "=
 fmt, \
> > +                                               __FILE__, __func__, ## =
arg)
> > +
> > +struct bt_uinput {
> > +       int fd;
> > +       bt_uinput_debug_func_t debug_func;
> > +       void *debug_data;
> > +};
> > +
> > +static void uinput_debug(bt_uinput_debug_func_t debug_func, void *debu=
g_data,
> > +                                                       const char *for=
mat, ...)
> > +{
> > +       va_list ap;
> > +
> > +       if (!debug_func || !format)
> > +               return;
> > +
> > +       va_start(ap, format);
> > +       util_debug_va(debug_func, debug_data, format, ap);
> > +       va_end(ap);
> > +}
> > +
> > +static int send_event(int fd, uint16_t type, uint16_t code, int32_t va=
lue)
> > +{
> > +       struct input_event event;
> > +
> > +       memset(&event, 0, sizeof(event));
> > +       event.type      =3D type;
> > +       event.code      =3D code;
> > +       event.value     =3D value;
> > +
> > +       return write(fd, &event, sizeof(event));
> > +}
> > +
> > +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool p=
ressed)
> > +{
> > +       if (!uinput)
> > +               return;
> > +
> > +       DBG(uinput, "%d", key);
> > +
> > +       send_event(uinput->fd, EV_KEY, key, pressed ? 1 : 0);
> > +       send_event(uinput->fd, EV_SYN, SYN_REPORT, 0);
> > +}
> > +
> > +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
> > +                                       const bdaddr_t *addr,
> > +                                       const struct input_id *dev_id,
> > +                                       const struct bt_uinput_key_map =
*key_map,
> > +                                       bt_uinput_debug_func_t debug,
> > +                                       void *user_data)
> > +{
> > +       struct bt_uinput *uinput;
> > +       struct uinput_user_dev dev;
> > +       int fd, err, i;
> > +       char src[18];
> > +
> > +       uinput =3D new0(struct bt_uinput, 1);
> > +       uinput->debug_func =3D debug;
> > +       uinput->debug_data =3D user_data;
> > +
> > +       fd =3D open("/dev/uinput", O_RDWR);
> > +       if (fd < 0) {
> > +               fd =3D open("/dev/input/uinput", O_RDWR);
> > +               if (fd < 0) {
> > +                       fd =3D open("/dev/misc/uinput", O_RDWR);
> > +                       if (fd < 0) {
> > +                               err =3D errno;
> > +                               DBG(uinput, "Can't open input device: %=
s (%d)",
> > +                                                       strerror(err), =
err);
> > +                               free(uinput);
>=20
> It is probably worth reordering the uinput allocation so it is after
> the open, that way we don't need to free on bail out.

This is on purpose for the DBG macro, so I'd not change it.

> > +                               errno =3D err;
> > +                               return NULL;
> > +                       }
> > +               }
> > +       }
> > +
> > +       memset(&dev, 0, sizeof(dev));
> > +
> > +       if (name)
> > +               snprintf(dev.name, UINPUT_MAX_NAME_SIZE, "%s", name);
> > +
> > +       if (suffix) {
> > +               int len, slen;
> > +
> > +               len =3D strlen(dev.name);
> > +               slen =3D strlen(suffix);
> > +
> > +               /* If name + suffix don't fit, truncate the name, then =
add the
> > +                * suffix.
> > +                */
> > +               if (slen >=3D UINPUT_MAX_NAME_SIZE)
> > +                       slen =3D UINPUT_MAX_NAME_SIZE - 1;
> > +               if (len > UINPUT_MAX_NAME_SIZE - slen - 1)
> > +                       len =3D UINPUT_MAX_NAME_SIZE - slen - 1;
> > +
> > +               snprintf(dev.name + len, UINPUT_MAX_NAME_SIZE - len,
> > +                                                               "%s", s=
uffix);
> > +       }
> > +
> > +       if (dev_id) {
> > +               dev.id.bustype =3D dev_id->bustype;
> > +               dev.id.vendor =3D dev_id->vendor;
> > +               dev.id.product =3D dev_id->product;
> > +               dev.id.version =3D dev_id->version;
> > +       } else {
> > +               dev.id.bustype =3D BUS_VIRTUAL;
> > +       }
> > +
> > +       if (write(fd, &dev, sizeof(dev)) < 0) {
> > +               err =3D errno;
> > +               DBG(uinput, "Can't write device information: %s (%d)",
> > +                                                       strerror(err), =
err);
> > +               close(fd);
> > +               free(uinput);
> > +               errno =3D err;
> > +               return NULL;
> > +       }
> > +
> > +       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > +       ioctl(fd, UI_SET_EVBIT, EV_REL);
> > +       ioctl(fd, UI_SET_EVBIT, EV_REP);
> > +       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> > +
> > +       ba2strlc(addr, src);
> > +       ioctl(fd, UI_SET_PHYS, src);
> > +
> > +       for (i =3D 0; key_map[i].name !=3D NULL; i++)
> > +               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> > +
> > +       if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
> > +               err =3D errno;
> > +               DBG(uinput, "Can't create uinput device: %s (%d)",
> > +                                                       strerror(err), =
err);
> > +               close(fd);
> > +               free(uinput);
> > +               errno =3D err;
> > +               return NULL;
> > +       }
> > +
> > +       send_event(fd, EV_REP, REP_DELAY, 300);
> > +
> > +       DBG(uinput, "%p", uinput);
> > +
> > +       uinput->fd =3D fd;
> > +       return uinput;
> > +}
> > +
> > +void bt_uinput_destroy(struct bt_uinput *uinput)
> > +{
> > +       if (!uinput)
> > +               return;
> > +
> > +       DBG(uinput, "%p", uinput);
> > +
> > +       ioctl(uinput->fd, UI_DEV_DESTROY);
> > +       close(uinput->fd);
> > +       free(uinput);
> > +}
> > diff --git a/src/shared/uinput-util.h b/src/shared/uinput-util.h
> > new file mode 100644
> > index 000000000..fb8f7e6bd
> > --- /dev/null
> > +++ b/src/shared/uinput-util.h
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>=20
> In theory we should only place LGPL code into src/shared, now I see we
> are copying some code thus it should continue using the same license
> as the original code, but perhaps it is worth reworking the copied
> code since it is quite simple and I think it is worth it to not
> contaminate shared library with GPL.

That, or decide it's small enough to not be copyrightable, given it's
anyway partly rewritten already.

> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2006-2010  Nokia Corporation
> > + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> > + *  Copyright (C) 2011  Texas Instruments, Inc.
> > + *
> > + *
> > + */
> > +
> > +struct bt_uinput;
> > +
> > +struct bt_uinput_key_map {
> > +       const char *name;
> > +       unsigned int code;
> > +       uint16_t uinput;
> > +};
> > +
> > +typedef void (*bt_uinput_debug_func_t)(const char *str, void *user_dat=
a);
> > +
> > +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
> > +                                       const bdaddr_t *addr,
> > +                                       const struct input_id *dev_id,
> > +                                       const struct bt_uinput_key_map =
*key_map,
> > +                                       bt_uinput_debug_func_t debug,
> > +                                       void *user_data);
>=20
> I'd leave the debug function to be initialized with its own function
> (e.g. bt_uinput_set_debug).
>=20
> > +void bt_uinput_destroy(struct bt_uinput *uinput);
> > +
> > +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool p=
ressed);
> > --
> > 2.51.1
> >=20
> >=20
>=20

--=20
Pauli Virtanen

