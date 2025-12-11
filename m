Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEF18C31
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490767; cv=none; b=rrpfCpxyQlVa+9o3CajZKQ4Vgjd8vBGdhfehHiHhHUTVAPKvkclIOSbDRpWXwtBM3le9b48a3E21GMjt/pOEtVXnkVRDsYOIqel/ytybM2yh9CL1E9iPknNPxcaxuFFj/YXzrluqGTUe3mtkcyWKVCDqPUI9bPSDDyLbbDoWe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490767; c=relaxed/simple;
	bh=MARMNdJ72iTcTTfq1c79kWlD58emdJXNAhZx9OGlo0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNCvjnfS9YqoxvAYae9dJbfXSgc/UfZGuyaK7hQze1r9uTGkDXUl/StuiZZKRt6wux4dGEl6CUK8auFf9l6VukAndcVLMd59/zI9omK552cyzJBkNqwCReXvsFZI9b93qyk9R8UK630xHscJPzTPRagK+N+uQVMR5AoHdll0eec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFdPcYb0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFdPcYb0"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b999d0c81so5070211fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 14:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765490763; x=1766095563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8drhaU+uYORul82VRFBPzS0Mo3TSW0NKXZXxgd5lf8=;
        b=nFdPcYb02FKF41iHA5XTP00lovnTHlaudL2ewwalzzTUcgzUVwWG8i6QwebtLUlNVi
         TvjI2mm3bdux2mdXhMLBNNNz5r3rKsLhJ06RSBRi6FCAo+KkO2uRN3CJ2lCzUbbiP8hq
         wHM5bBwFdLQwyNAFoviepAY+HtS+ZOsbihu5Y086pp60+j618BXiqtrurKia8hXxn2sU
         TYvhLnXV/XXKexiQpUZ/58RcAcYoO4AbLGZf2eFqymZJq51wntlmhPWGaF+ONO1QC8wr
         Lp5Rssp5DIYKYh5p19XKw0KckZOG1kCfhxsNxFTuDT+5otVqSv/Qc7QH+ctKUECk9Rol
         aZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765490763; x=1766095563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8drhaU+uYORul82VRFBPzS0Mo3TSW0NKXZXxgd5lf8=;
        b=N1bEM5lnCPWakq82Q4VJIrx5JZTav7ZFow3+FQL0/ltPq0gsTGr/SH8S+oRzKAWVrL
         V6iH+ctq8wv0KdV/OfGaUEd7w0jcy73r0jFRvBMYAfQCYce0zlUVo10gCnaQrIVSbKJK
         5cGfugQ5dSx4s5MOZpbx4k+yQinKSXWK88Bc5qXIshCuZ8+dZw4pLgyTnrlh8j2RxbIC
         COhc3xQPCYORRXj+o4cTJsTMFFE0sHlsYgLkAMxDz6Geq6vYZNpW8KSGtkdNZZkQMtf6
         dHZXAHPygHm4rgwthr0uJ0xXlq3cLOUth4Mya8KiWfVLiVZOZQyo2SpszmyHREqI4CkN
         LxUw==
X-Gm-Message-State: AOJu0Yzyno2kEbUJvtjRVwsfaNx18RqJzx8T7HbPVLUyyJK20AOBwnc+
	YYWOlOP6ZoARO8epj5GTOjUUiNICzVJBaxwN0uWbdnOkOb41dtdliOKFzGS062UZNHD+QlwCYG3
	q+FovoX7x6PIZAbvWUDzxiONxof2wZeA=
X-Gm-Gg: AY/fxX5LIn3QLZJy1VYE9eIfvaC3qaUQtfMClB02md3Tb/FnsaGAty3ZFPpua/LNHKC
	UDo64iN1PpxtMnXH8rY8cOiJGHQlRrd/QxND1bsSKiqXb6HP2JzMPo9wYYndGVVpSv5jnA7ZsXd
	XIj8PJYqH9mQMCb+YH5WhSX9gmaCR1Etw3G2BQWKdiJh/iq5tTPw1hHJUF0TdoeNEVDN+KUsrfl
	be4RqTLADxjO3dQZYNFcRbCWCqsE1L9jFuR/Q/+Dw3XDDuR5eUkgZ8bdxkdT+KHS0pq4A==
X-Google-Smtp-Source: AGHT+IEUUHzDCrq5UBtxirVcHEyYrdldc2twyjea/fMscW9dXzrWjJWYps2veXthpOq1TTGyMc2977F/e/Cg+x3JMLE=
X-Received: by 2002:a05:651c:b2c:b0:36a:925e:cf3c with SMTP id
 38308e7fff4ca-37fd08a291cmr89441fa.31.1765490762988; Thu, 11 Dec 2025
 14:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765484150.git.pav@iki.fi> <e8fd07e902ad1fbc00113ef57eb89b8970d29a84.1765484150.git.pav@iki.fi>
In-Reply-To: <e8fd07e902ad1fbc00113ef57eb89b8970d29a84.1765484150.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Dec 2025 17:05:49 -0500
X-Gm-Features: AQt7F2oKCXoy5qVbdm1gQfVX9tV5uBhlqum6JlmRXy1Px6Sxnm4oMWaPSZ4KTQg
Message-ID: <CABBYNZLBEhEeHb7U77WreFguqZefPkPzebRMz0mR-ErJT79BLw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 4/7] shared/uinput-util: extract uinput utility
 function from AVCTP
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Extract uinput utility function from AVCTP to src/shared so that it can
> be reused for MCS.
> ---
>  Makefile.am              |   4 +-
>  src/shared/uinput-util.c | 191 +++++++++++++++++++++++++++++++++++++++
>  src/shared/uinput-util.h |  31 +++++++
>  3 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 src/shared/uinput-util.c
>  create mode 100644 src/shared/uinput-util.h
>
> diff --git a/Makefile.am b/Makefile.am
> index ba0262d5f..4c7177886 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -247,7 +247,9 @@ shared_sources =3D src/shared/io.h src/shared/timeout=
.h \
>                         src/shared/lc3.h src/shared/tty.h \
>                         src/shared/bap-defs.h \
>                         src/shared/asha.h src/shared/asha.c \
> -                       src/shared/battery.h src/shared/battery.c
> +                       src/shared/battery.h src/shared/battery.c \
> +                       src/shared/uinput-util.h \
> +                       src/shared/uinput-util.c
>
>  if READLINE
>  shared_sources +=3D src/shared/shell.c src/shared/shell.h
> diff --git a/src/shared/uinput-util.c b/src/shared/uinput-util.c
> new file mode 100644
> index 000000000..4e9644661
> --- /dev/null
> +++ b/src/shared/uinput-util.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2006-2010  Nokia Corporation
> + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2011  Texas Instruments, Inc.
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <linux/uinput.h>
> +
> +#include "bluetooth/bluetooth.h"
> +
> +#include "src/shared/util.h"
> +#include "src/shared/uinput-util.h"
> +
> +
> +#define DBG(uinput, fmt, arg...) \
> +       uinput_debug(uinput->debug_func, uinput->debug_data, "%s:%s() " f=
mt, \
> +                                               __FILE__, __func__, ## ar=
g)
> +
> +struct bt_uinput {
> +       int fd;
> +       bt_uinput_debug_func_t debug_func;
> +       void *debug_data;
> +};
> +
> +static void uinput_debug(bt_uinput_debug_func_t debug_func, void *debug_=
data,
> +                                                       const char *forma=
t, ...)
> +{
> +       va_list ap;
> +
> +       if (!debug_func || !format)
> +               return;
> +
> +       va_start(ap, format);
> +       util_debug_va(debug_func, debug_data, format, ap);
> +       va_end(ap);
> +}
> +
> +static int send_event(int fd, uint16_t type, uint16_t code, int32_t valu=
e)
> +{
> +       struct input_event event;
> +
> +       memset(&event, 0, sizeof(event));
> +       event.type      =3D type;
> +       event.code      =3D code;
> +       event.value     =3D value;
> +
> +       return write(fd, &event, sizeof(event));
> +}
> +
> +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pre=
ssed)
> +{
> +       if (!uinput)
> +               return;
> +
> +       DBG(uinput, "%d", key);
> +
> +       send_event(uinput->fd, EV_KEY, key, pressed ? 1 : 0);
> +       send_event(uinput->fd, EV_SYN, SYN_REPORT, 0);
> +}
> +
> +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
> +                                       const bdaddr_t *addr,
> +                                       const struct input_id *dev_id,
> +                                       const struct bt_uinput_key_map *k=
ey_map,
> +                                       bt_uinput_debug_func_t debug,
> +                                       void *user_data)
> +{
> +       struct bt_uinput *uinput;
> +       struct uinput_user_dev dev;
> +       int fd, err, i;
> +       char src[18];
> +
> +       uinput =3D new0(struct bt_uinput, 1);
> +       uinput->debug_func =3D debug;
> +       uinput->debug_data =3D user_data;
> +
> +       fd =3D open("/dev/uinput", O_RDWR);
> +       if (fd < 0) {
> +               fd =3D open("/dev/input/uinput", O_RDWR);
> +               if (fd < 0) {
> +                       fd =3D open("/dev/misc/uinput", O_RDWR);
> +                       if (fd < 0) {
> +                               err =3D errno;
> +                               DBG(uinput, "Can't open input device: %s =
(%d)",
> +                                                       strerror(err), er=
r);
> +                               free(uinput);

It is probably worth reordering the uinput allocation so it is after
the open, that way we don't need to free on bail out.

> +                               errno =3D err;
> +                               return NULL;
> +                       }
> +               }
> +       }
> +
> +       memset(&dev, 0, sizeof(dev));
> +
> +       if (name)
> +               snprintf(dev.name, UINPUT_MAX_NAME_SIZE, "%s", name);
> +
> +       if (suffix) {
> +               int len, slen;
> +
> +               len =3D strlen(dev.name);
> +               slen =3D strlen(suffix);
> +
> +               /* If name + suffix don't fit, truncate the name, then ad=
d the
> +                * suffix.
> +                */
> +               if (slen >=3D UINPUT_MAX_NAME_SIZE)
> +                       slen =3D UINPUT_MAX_NAME_SIZE - 1;
> +               if (len > UINPUT_MAX_NAME_SIZE - slen - 1)
> +                       len =3D UINPUT_MAX_NAME_SIZE - slen - 1;
> +
> +               snprintf(dev.name + len, UINPUT_MAX_NAME_SIZE - len,
> +                                                               "%s", suf=
fix);
> +       }
> +
> +       if (dev_id) {
> +               dev.id.bustype =3D dev_id->bustype;
> +               dev.id.vendor =3D dev_id->vendor;
> +               dev.id.product =3D dev_id->product;
> +               dev.id.version =3D dev_id->version;
> +       } else {
> +               dev.id.bustype =3D BUS_VIRTUAL;
> +       }
> +
> +       if (write(fd, &dev, sizeof(dev)) < 0) {
> +               err =3D errno;
> +               DBG(uinput, "Can't write device information: %s (%d)",
> +                                                       strerror(err), er=
r);
> +               close(fd);
> +               free(uinput);
> +               errno =3D err;
> +               return NULL;
> +       }
> +
> +       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +       ioctl(fd, UI_SET_EVBIT, EV_REL);
> +       ioctl(fd, UI_SET_EVBIT, EV_REP);
> +       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> +
> +       ba2strlc(addr, src);
> +       ioctl(fd, UI_SET_PHYS, src);
> +
> +       for (i =3D 0; key_map[i].name !=3D NULL; i++)
> +               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> +
> +       if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
> +               err =3D errno;
> +               DBG(uinput, "Can't create uinput device: %s (%d)",
> +                                                       strerror(err), er=
r);
> +               close(fd);
> +               free(uinput);
> +               errno =3D err;
> +               return NULL;
> +       }
> +
> +       send_event(fd, EV_REP, REP_DELAY, 300);
> +
> +       DBG(uinput, "%p", uinput);
> +
> +       uinput->fd =3D fd;
> +       return uinput;
> +}
> +
> +void bt_uinput_destroy(struct bt_uinput *uinput)
> +{
> +       if (!uinput)
> +               return;
> +
> +       DBG(uinput, "%p", uinput);
> +
> +       ioctl(uinput->fd, UI_DEV_DESTROY);
> +       close(uinput->fd);
> +       free(uinput);
> +}
> diff --git a/src/shared/uinput-util.h b/src/shared/uinput-util.h
> new file mode 100644
> index 000000000..fb8f7e6bd
> --- /dev/null
> +++ b/src/shared/uinput-util.h
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

In theory we should only place LGPL code into src/shared, now I see we
are copying some code thus it should continue using the same license
as the original code, but perhaps it is worth reworking the copied
code since it is quite simple and I think it is worth it to not
contaminate shared library with GPL.

> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2006-2010  Nokia Corporation
> + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2011  Texas Instruments, Inc.
> + *
> + *
> + */
> +
> +struct bt_uinput;
> +
> +struct bt_uinput_key_map {
> +       const char *name;
> +       unsigned int code;
> +       uint16_t uinput;
> +};
> +
> +typedef void (*bt_uinput_debug_func_t)(const char *str, void *user_data)=
;
> +
> +struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
> +                                       const bdaddr_t *addr,
> +                                       const struct input_id *dev_id,
> +                                       const struct bt_uinput_key_map *k=
ey_map,
> +                                       bt_uinput_debug_func_t debug,
> +                                       void *user_data);

I'd leave the debug function to be initialized with its own function
(e.g. bt_uinput_set_debug).

> +void bt_uinput_destroy(struct bt_uinput *uinput);
> +
> +void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pre=
ssed);
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
