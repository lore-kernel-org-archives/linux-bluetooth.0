Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7F23DEB6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555678; cv=none; b=POHjVAixImnt+UJqfa5BBj2WDG2dy9QgX9NgeNg/YtCrF7wQ7e0APHzdq8tIUPXLFy+O4ro95ZdCNcfplG0LX7ZwBOea9yIAo1HXrVNQicmHKoo9O1ov3sucD2TpTqXE61V2tLZrx+GzH5Flo5G74rx3zwo05agRozjlTszqkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555678; c=relaxed/simple;
	bh=8tCsu7PXM3/EnOcvWJFtIzVKWL17kGHFHb4GXQll82Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtuS9mWSpFJepXpafTYb38n7j3lyTpPIAgRldYvmqRKwO41IxEKYZ8I6Z0gNxyZPfmJTnEvg2c/7uH/NhdFU/YF50q1ncKhjtGfOuZCXfpqDGonCyqsOWn+YhiIZYLpti4Y5u5CmcyXoIHutPfsOnywYE+DYDxhxG0YKorSsJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVmeVSe+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVmeVSe+"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-594285c6509so1603150e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765555674; x=1766160474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAx6m6RPCNmtj/ZVdeNH1e1eOPTm/ihc1UsMaHdlBTc=;
        b=EVmeVSe+w2M4ZfgbzR7Ndlex4L0MYWaCeIEz/TPXvz9zSEFEep2iYC4wCuaBpmHsCN
         BPqZHVzmdiv+RENGuPd74ecQAHwWoe3H/lMLfEcgOujHNPuulJ23vSZWPFTv9VCRnTg4
         yd8C8A4XOw4jMo2evDQyGNKx4NQ326idlxVaV44hgKBPuHAE53NBzkCCO6N18uXXQqeP
         klgpftt6IEo/H2WaITBuUKF484y3V0Mrd5d2BEdPNEuspQudNyPDnyzS2q4Eqsq5fMwH
         pyvsFkJU+P2+6pUPAf1mItW1z13hrvVIOAO4fhvhzbOtOvgr8X2tm2cfkQnTDIjQhdZb
         w3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765555674; x=1766160474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAx6m6RPCNmtj/ZVdeNH1e1eOPTm/ihc1UsMaHdlBTc=;
        b=Ac/6YELrzwpw6DhhQEjkyKVvETdo1txU+K530gwc95B2fYpfWKsiYif3Cq9W/XxmXf
         Nm5tLIjEq2EJneO6zdjMu+/8D+nmonT9v+1RLSw4o/+4Nedu+c0eJzh56AsDpcOSS7Pl
         tdI3YnmNeLFQ9z8Gqg5CRYbxnvoKp3TOH0EgkZBiTzdsGm9Fh+zI7FrGN7JfZEWwgOw9
         sUAz8jzsAHFfoVrCnB5GPFKtn88PKpKFlXiGIjeTd3xCvuIFl5qA70xtILQOBEvMhYYz
         qY9WF7SdtN+0Zdi1BBG90IxIm7UbdjIUmyAOPO+MM2oeeqIR4lwF30va9QKhmVA+BZtM
         GEIw==
X-Gm-Message-State: AOJu0YwaVjO22g56shYRSAC7IZer4CNHelrwTdP4wo2wrhg/r+6t05CT
	DVKTaiJ1GmFVpZTg91CY7BOosXoC9kmgbqnS1v5XvR2pmZqHw0qLbybp7/86Pd/mohZUfuAf/Mh
	XsTcyHexSu8QYi4FK+zxXd40pJmvh1rI=
X-Gm-Gg: AY/fxX4lgRBHLpO3JU0dMN22TOGEw9necUlz/9/ABspv9fHess8xaWMwyBjRGocMWGW
	Xj8WVx7AOz+2Nv6G4WRFEDSp+7+yybnEToUHER8wTA7te0TWXKuvnLCr/IUgg5VuCGKnYrsGxtF
	AZkAdl6Ku0BAFFtPFxNP18v6Z2442EL6z2Sz+vxOkBgLZ5SYMttvrgcYaLKPuTUs4u0LpgZOYYQ
	0HO2Qzm0faAGx7HT1GDXsFMnGMys1xd78/Ys/+W5QaXVfdSpKsZPs21gedRYJJmgd/bng==
X-Google-Smtp-Source: AGHT+IE6JwuV8S8rMsAFF+5yJjY0ZQXzawqgBpNgE+CUqbQvKLn9hqO/mbeROQbO3m8LKflJ6k1/asC69Nz0pdGriz0=
X-Received: by 2002:a2e:a543:0:b0:37f:8bb4:6b with SMTP id 38308e7fff4ca-37fd08c5868mr9204221fa.38.1765555673396;
 Fri, 12 Dec 2025 08:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765484150.git.pav@iki.fi> <e8fd07e902ad1fbc00113ef57eb89b8970d29a84.1765484150.git.pav@iki.fi>
 <CABBYNZLBEhEeHb7U77WreFguqZefPkPzebRMz0mR-ErJT79BLw@mail.gmail.com> <081f864de65d00f024fd2418cafd2309eef5dc67.camel@iki.fi>
In-Reply-To: <081f864de65d00f024fd2418cafd2309eef5dc67.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2025 11:07:40 -0500
X-Gm-Features: AQt7F2oDb7xS7f7VtHFOzoC6Do7nkKBw5B4Dw4Lt7GL9T3vF0McjsbpdqKxvDNw
Message-ID: <CABBYNZJe58G1xg0-4eu7ZRiA8kTLL-6g2fm-81bAwVZj3P56rw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 4/7] shared/uinput-util: extract uinput utility
 function from AVCTP
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Dec 11, 2025 at 5:50=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> to, 2025-12-11 kello 17:05 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Extract uinput utility function from AVCTP to src/shared so that it c=
an
> > > be reused for MCS.
> > > ---
> > >  Makefile.am              |   4 +-
> > >  src/shared/uinput-util.c | 191 +++++++++++++++++++++++++++++++++++++=
++
> > >  src/shared/uinput-util.h |  31 +++++++
> > >  3 files changed, 225 insertions(+), 1 deletion(-)
> > >  create mode 100644 src/shared/uinput-util.c
> > >  create mode 100644 src/shared/uinput-util.h
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index ba0262d5f..4c7177886 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -247,7 +247,9 @@ shared_sources =3D src/shared/io.h src/shared/tim=
eout.h \
> > >                         src/shared/lc3.h src/shared/tty.h \
> > >                         src/shared/bap-defs.h \
> > >                         src/shared/asha.h src/shared/asha.c \
> > > -                       src/shared/battery.h src/shared/battery.c
> > > +                       src/shared/battery.h src/shared/battery.c \
> > > +                       src/shared/uinput-util.h \
> > > +                       src/shared/uinput-util.c
> > >
> > >  if READLINE
> > >  shared_sources +=3D src/shared/shell.c src/shared/shell.h
> > > diff --git a/src/shared/uinput-util.c b/src/shared/uinput-util.c
> > > new file mode 100644
> > > index 000000000..4e9644661
> > > --- /dev/null
> > > +++ b/src/shared/uinput-util.c
> > > @@ -0,0 +1,191 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2006-2010  Nokia Corporation
> > > + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *  Copyright (C) 2011  Texas Instruments, Inc.
> > > + *
> > > + *
> > > + */
> > > +
> > > +#ifdef HAVE_CONFIG_H
> > > +#include <config.h>
> > > +#endif
> > > +
> > > +#include <unistd.h>
> > > +#include <fcntl.h>
> > > +#include <sys/ioctl.h>
> > > +#include <errno.h>
> > > +#include <string.h>
> > > +#include <stdio.h>
> > > +#include <stdarg.h>
> > > +#include <linux/uinput.h>
> > > +
> > > +#include "bluetooth/bluetooth.h"
> > > +
> > > +#include "src/shared/util.h"
> > > +#include "src/shared/uinput-util.h"
> > > +
> > > +
> > > +#define DBG(uinput, fmt, arg...) \
> > > +       uinput_debug(uinput->debug_func, uinput->debug_data, "%s:%s()=
 " fmt, \
> > > +                                               __FILE__, __func__, #=
# arg)
> > > +
> > > +struct bt_uinput {
> > > +       int fd;
> > > +       bt_uinput_debug_func_t debug_func;
> > > +       void *debug_data;
> > > +};
> > > +
> > > +static void uinput_debug(bt_uinput_debug_func_t debug_func, void *de=
bug_data,
> > > +                                                       const char *f=
ormat, ...)
> > > +{
> > > +       va_list ap;
> > > +
> > > +       if (!debug_func || !format)
> > > +               return;
> > > +
> > > +       va_start(ap, format);
> > > +       util_debug_va(debug_func, debug_data, format, ap);
> > > +       va_end(ap);
> > > +}
> > > +
> > > +static int send_event(int fd, uint16_t type, uint16_t code, int32_t =
value)
> > > +{
> > > +       struct input_event event;
> > > +
> > > +       memset(&event, 0, sizeof(event));
> > > +       event.type      =3D type;
> > > +       event.code      =3D code;
> > > +       event.value     =3D value;
> > > +
> > > +       return write(fd, &event, sizeof(event));
> > > +}
> > > +
> > > +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool=
 pressed)
> > > +{
> > > +       if (!uinput)
> > > +               return;
> > > +
> > > +       DBG(uinput, "%d", key);
> > > +
> > > +       send_event(uinput->fd, EV_KEY, key, pressed ? 1 : 0);
> > > +       send_event(uinput->fd, EV_SYN, SYN_REPORT, 0);
> > > +}
> > > +
> > > +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix=
,
> > > +                                       const bdaddr_t *addr,
> > > +                                       const struct input_id *dev_id=
,
> > > +                                       const struct bt_uinput_key_ma=
p *key_map,
> > > +                                       bt_uinput_debug_func_t debug,
> > > +                                       void *user_data)
> > > +{
> > > +       struct bt_uinput *uinput;
> > > +       struct uinput_user_dev dev;
> > > +       int fd, err, i;
> > > +       char src[18];
> > > +
> > > +       uinput =3D new0(struct bt_uinput, 1);
> > > +       uinput->debug_func =3D debug;
> > > +       uinput->debug_data =3D user_data;
> > > +
> > > +       fd =3D open("/dev/uinput", O_RDWR);
> > > +       if (fd < 0) {
> > > +               fd =3D open("/dev/input/uinput", O_RDWR);
> > > +               if (fd < 0) {
> > > +                       fd =3D open("/dev/misc/uinput", O_RDWR);
> > > +                       if (fd < 0) {
> > > +                               err =3D errno;
> > > +                               DBG(uinput, "Can't open input device:=
 %s (%d)",
> > > +                                                       strerror(err)=
, err);
> > > +                               free(uinput);
> >
> > It is probably worth reordering the uinput allocation so it is after
> > the open, that way we don't need to free on bail out.
>
> This is on purpose for the DBG macro, so I'd not change it.

Just to be able to print that uinput was not be able to be open? I
suspect we want to decouple the opening of the uinput with the device
creation, like it is done in bt_uhid.

>
> > > +                               errno =3D err;
> > > +                               return NULL;
> > > +                       }
> > > +               }
> > > +       }
> > > +
> > > +       memset(&dev, 0, sizeof(dev));
> > > +
> > > +       if (name)
> > > +               snprintf(dev.name, UINPUT_MAX_NAME_SIZE, "%s", name);
> > > +
> > > +       if (suffix) {
> > > +               int len, slen;
> > > +
> > > +               len =3D strlen(dev.name);
> > > +               slen =3D strlen(suffix);
> > > +
> > > +               /* If name + suffix don't fit, truncate the name, the=
n add the
> > > +                * suffix.
> > > +                */
> > > +               if (slen >=3D UINPUT_MAX_NAME_SIZE)
> > > +                       slen =3D UINPUT_MAX_NAME_SIZE - 1;
> > > +               if (len > UINPUT_MAX_NAME_SIZE - slen - 1)
> > > +                       len =3D UINPUT_MAX_NAME_SIZE - slen - 1;
> > > +
> > > +               snprintf(dev.name + len, UINPUT_MAX_NAME_SIZE - len,
> > > +                                                               "%s",=
 suffix);
> > > +       }
> > > +
> > > +       if (dev_id) {
> > > +               dev.id.bustype =3D dev_id->bustype;
> > > +               dev.id.vendor =3D dev_id->vendor;
> > > +               dev.id.product =3D dev_id->product;
> > > +               dev.id.version =3D dev_id->version;
> > > +       } else {
> > > +               dev.id.bustype =3D BUS_VIRTUAL;
> > > +       }
> > > +
> > > +       if (write(fd, &dev, sizeof(dev)) < 0) {
> > > +               err =3D errno;
> > > +               DBG(uinput, "Can't write device information: %s (%d)"=
,
> > > +                                                       strerror(err)=
, err);
> > > +               close(fd);
> > > +               free(uinput);
> > > +               errno =3D err;
> > > +               return NULL;
> > > +       }
> > > +
> > > +       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> > > +       ioctl(fd, UI_SET_EVBIT, EV_REL);
> > > +       ioctl(fd, UI_SET_EVBIT, EV_REP);
> > > +       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> > > +
> > > +       ba2strlc(addr, src);
> > > +       ioctl(fd, UI_SET_PHYS, src);
> > > +
> > > +       for (i =3D 0; key_map[i].name !=3D NULL; i++)
> > > +               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> > > +
> > > +       if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
> > > +               err =3D errno;
> > > +               DBG(uinput, "Can't create uinput device: %s (%d)",
> > > +                                                       strerror(err)=
, err);
> > > +               close(fd);
> > > +               free(uinput);
> > > +               errno =3D err;
> > > +               return NULL;
> > > +       }
> > > +
> > > +       send_event(fd, EV_REP, REP_DELAY, 300);
> > > +
> > > +       DBG(uinput, "%p", uinput);
> > > +
> > > +       uinput->fd =3D fd;
> > > +       return uinput;
> > > +}
> > > +
> > > +void bt_uinput_destroy(struct bt_uinput *uinput)
> > > +{
> > > +       if (!uinput)
> > > +               return;
> > > +
> > > +       DBG(uinput, "%p", uinput);
> > > +
> > > +       ioctl(uinput->fd, UI_DEV_DESTROY);
> > > +       close(uinput->fd);
> > > +       free(uinput);
> > > +}
> > > diff --git a/src/shared/uinput-util.h b/src/shared/uinput-util.h
> > > new file mode 100644
> > > index 000000000..fb8f7e6bd
> > > --- /dev/null
> > > +++ b/src/shared/uinput-util.h
> > > @@ -0,0 +1,31 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > In theory we should only place LGPL code into src/shared, now I see we
> > are copying some code thus it should continue using the same license
> > as the original code, but perhaps it is worth reworking the copied
> > code since it is quite simple and I think it is worth it to not
> > contaminate shared library with GPL.
>
> That, or decide it's small enough to not be copyrightable, given it's
> anyway partly rewritten already.

Yeah, most of the existing code comes from code snips from uinput
documentation anyway and since we are doing many changes to the code I
think it is probably safe to relicense under LGPL.

> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2006-2010  Nokia Corporation
> > > + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *  Copyright (C) 2011  Texas Instruments, Inc.
> > > + *
> > > + *
> > > + */
> > > +
> > > +struct bt_uinput;
> > > +
> > > +struct bt_uinput_key_map {
> > > +       const char *name;
> > > +       unsigned int code;
> > > +       uint16_t uinput;
> > > +};
> > > +
> > > +typedef void (*bt_uinput_debug_func_t)(const char *str, void *user_d=
ata);
> > > +
> > > +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix=
,
> > > +                                       const bdaddr_t *addr,
> > > +                                       const struct input_id *dev_id=
,
> > > +                                       const struct bt_uinput_key_ma=
p *key_map,
> > > +                                       bt_uinput_debug_func_t debug,
> > > +                                       void *user_data);
> >
> > I'd leave the debug function to be initialized with its own function
> > (e.g. bt_uinput_set_debug).
> >
> > > +void bt_uinput_destroy(struct bt_uinput *uinput);
> > > +
> > > +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool=
 pressed);
> > > --
> > > 2.51.1
> > >
> > >
> >
>
> --
> Pauli Virtanen
>
>


--=20
Luiz Augusto von Dentz
