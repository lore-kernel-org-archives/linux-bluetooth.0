Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16D1917F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383925; cv=none; b=KlRQzfOMSl2FbPsic+3bNvU2Eg4kxj5CACtjFuCfVtqFPEcXTcNtylrH1b+iTEZmv+8CT82yXYLDdd9BtJrJWcU+Uvz4Q9uU25J9Ec/tejXFv/qW/lEVinbHzbR4hQJBRMcW4esa1jWH8Hc/pP7EMeh7MJnAy9J9qDTJiniX9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383925; c=relaxed/simple;
	bh=/Kv+menzVrpNHbc8zH3446z4xxTNDzeIC4ya13mUABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwYYtmGsRzCwmt+eJLMXGT86htd+OrS5v3cIekoBy8Oa9HefiElFiXWupZV6u8P7/PM37gAk3fFF16OBNlj731lESz4gXXjGL7cC3GUtHPD6JdABPQjMZGzL35M7N3vHKPPrc9bLIaUq84GDnHaYotG2N6bUcPailNEONjNfIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmDKX7z2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmDKX7z2"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a415a22ecso235311fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765383921; x=1765988721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wpxtcG2sPw9E2n5HP9BvCnEdEft/awCB/xlXnE5fso=;
        b=hmDKX7z2oI/Rxf4t3kRHgEE/LDj+zvjmom0Q0X80lNbY2vWGfm/0hHMl4M9GQkU4/G
         QH6hQJ0+f+gPraqHwaGVFxITK9rsRbskW8QFlTkYkJtj/1CIgbTFROjW+f3jmEV2guFd
         fHTvpiMrKYfpqTV819YYgJm/4IYVKTCWJ+DMS05LAaBY1njZq3Ydg1fPseNWF/sVScCq
         qDoyOXGZLTkCWdp7RKrPA9OfEn/otPViepEpBe7TRJqc4ImM4qzk/3EyMnNSUkxjSoOa
         R36wp6cxhdnBL1u6YntG+3jTo2hQKwBFVYdrOqyupKhF8pwQ5YR8ueKCctzi7qq3GcAs
         g+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383921; x=1765988721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wpxtcG2sPw9E2n5HP9BvCnEdEft/awCB/xlXnE5fso=;
        b=lqHzJylyNw/6vLcScUhIP/dPZQnL04S1oe/+gg3pT1ao5mOv7dtvJhC3h+X9UDncpG
         FcucSYEQ6VBm+/SmnCD5GBBa8usYeLh2Xfkkce4yLarpRFgTOxDrgHVMigRqHmKG31WY
         Jv7FMf2NUk0vqjfWczmd2Af+OVVZ9i4W1zrPugmUQNh7D2Jy6RyNxwHlCqAQARB9sQtn
         d9tVbH0UwWeBuftfznmcBAmeYgcqwrDucmDRORIX1ek+EOoq6HohK8l+bNhXSABmh/bi
         /R5SB8lGfw8CavzKcup49vBmHYL0RY5PTs2YsXX49sPbJj+zcIScuVhMMlczbIb6SnGV
         T9yQ==
X-Gm-Message-State: AOJu0Yxc9414fMY6ZIB00w35Kl1rlW2+7cLWK3U53FfA+aQODaCPb1X5
	v37KBpTFVNc18/4ao3+LNwRpo4NqoBRWirY0sVqpycZRI13fVF4uMdllUnzAJVM2K87lyP4dCHc
	FNTyk+ycRR3GuWF0tobS6nN1gdbyp0mxgf6SJ
X-Gm-Gg: AY/fxX4w+8Bys0T4TY/NywpK9Kthu8QXWWl8b5z7aWTnBMDgDnuhzTEeq1eXKDeX/fv
	7BFbG1xDFSo5su11c0ZyYLFpHMGtdJP6k7uG/i+Tgcd26fTpJVo+dT6gJ26UEtkQaCR+FykxlSQ
	F45oazYOm0pNqmzjpdivNsf7hmy3g3cverrfsvcMMuM7Su8eiQg8BeavJANkgPWT1CMbOBUIZqu
	aQnll9R6jan6KQtLQJ+9kjCthTccPVG78V3N3vKUtAIGKLl21Fhhzv+s9s2tUBP3fHgSQ==
X-Google-Smtp-Source: AGHT+IEFz9uFznLXBZ1ePTMCFjgOh8xVt24YWXSJJTq5C40k9bQ82r9F1QRFDbhE4o2G+ZxWcyTYtwELFKfiPCtg+X4=
X-Received: by 2002:a2e:be25:0:b0:37f:a66c:da55 with SMTP id
 38308e7fff4ca-37fb2396e70mr9229441fa.20.1765383921148; Wed, 10 Dec 2025
 08:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765383173.git.pav@iki.fi> <0ca3e2b822e0111525e7b88edc2db54c35fcee0b.1765383173.git.pav@iki.fi>
In-Reply-To: <0ca3e2b822e0111525e7b88edc2db54c35fcee0b.1765383173.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Dec 2025 11:25:07 -0500
X-Gm-Features: AQt7F2opzB0nzAM1uhhEt8vnTkMPoGhSqaNA4m5yuEk6gBYNHmfN41g7HB5NgJw
Message-ID: <CABBYNZJ8Oj1c47kqwws8gttMBF0BNMdf72UTOjtySmKpWSA-8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/7] avctp: move uinput utilities to uinput-util.c
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Dec 10, 2025 at 11:13=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Move basic uinput utilities to a separate file, so they can be reused
> for MCS.
> ---
>  Makefile.plugins             |   4 +-
>  profiles/audio/avctp.c       | 119 +++-------------------------
>  profiles/audio/uinput-util.c | 146 +++++++++++++++++++++++++++++++++++
>  profiles/audio/uinput-util.h |  23 ++++++
>  4 files changed, 181 insertions(+), 111 deletions(-)
>  create mode 100644 profiles/audio/uinput-util.c
>  create mode 100644 profiles/audio/uinput-util.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 3572ee845..54647e2ab 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -44,7 +44,9 @@ if AVRCP
>  builtin_modules +=3D avrcp
>  builtin_sources +=3D profiles/audio/control.h profiles/audio/control.c \
>                         profiles/audio/avctp.h profiles/audio/avctp.c \
> -                       profiles/audio/avrcp.h profiles/audio/avrcp.c
> +                       profiles/audio/avrcp.h profiles/audio/avrcp.c \
> +                       profiles/audio/uinput-util.h \
> +                       profiles/audio/uinput-util.c
>  endif
>
>  if NETWORK
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 65eec6f6c..346a97dd1 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -44,6 +44,7 @@
>
>  #include "avctp.h"
>  #include "avrcp.h"
> +#include "uinput-util.h"
>
>  /* AV/C Panel 1.23, page 76:
>   * command with the pressed value is valid for two seconds
> @@ -228,11 +229,7 @@ struct avctp_browsing_pdu_handler {
>         GDestroyNotify destroy;
>  };
>
> -static const struct {
> -       const char *name;
> -       uint8_t avc;
> -       uint16_t uinput;
> -} key_map[] =3D {
> +static const struct uinput_key_map key_map[] =3D {
>         { "SELECT",             AVC_SELECT,             KEY_SELECT },
>         { "UP",                 AVC_UP,                 KEY_UP },
>         { "DOWN",               AVC_DOWN,               KEY_DOWN },
> @@ -301,25 +298,9 @@ static gboolean avctp_passthrough_rsp(struct avctp *=
session, uint8_t code,
>                                         uint8_t *operands, size_t operand=
_count,
>                                         void *user_data);
>
> -static int send_event(int fd, uint16_t type, uint16_t code, int32_t valu=
e)
> -{
> -       struct input_event event;
> -
> -       memset(&event, 0, sizeof(event));
> -       event.type      =3D type;
> -       event.code      =3D code;
> -       event.value     =3D value;
> -
> -       return write(fd, &event, sizeof(event));
> -}
> -
>  static void send_key(int fd, uint16_t key, int pressed)
>  {
> -       if (fd < 0)
> -               return;
> -
> -       send_event(fd, EV_KEY, key, pressed);
> -       send_event(fd, EV_SYN, SYN_REPORT, 0);
> +       uinput_send_key(fd, key, pressed);
>  }
>
>  static bool auto_release(gpointer user_data)
> @@ -401,12 +382,12 @@ static size_t handle_panel_passthrough(struct avctp=
 *session,
>         for (i =3D 0; key_map[i].name !=3D NULL; i++) {
>                 uint8_t key_quirks;
>
> -               if ((operands[0] & 0x7F) !=3D key_map[i].avc)
> +               if ((operands[0] & 0x7F) !=3D key_map[i].code)
>                         continue;
>
>                 DBG("AV/C: %s %s", key_map[i].name, status);
>
> -               key_quirks =3D session->key_quirks[key_map[i].avc];
> +               key_quirks =3D session->key_quirks[key_map[i].code];
>
>                 if (key_quirks & QUIRK_NO_RELEASE) {
>                         if (!pressed) {
> @@ -1154,89 +1135,6 @@ failed:
>         return FALSE;
>  }
>
> -static int uinput_create(struct btd_device *device, const char *name,
> -                        const char *suffix)
> -{
> -       struct uinput_user_dev dev;
> -       int fd, err, i;
> -       char src[18];
> -
> -       fd =3D open("/dev/uinput", O_RDWR);
> -       if (fd < 0) {
> -               fd =3D open("/dev/input/uinput", O_RDWR);
> -               if (fd < 0) {
> -                       fd =3D open("/dev/misc/uinput", O_RDWR);
> -                       if (fd < 0) {
> -                               err =3D -errno;
> -                               error("Can't open input device: %s (%d)",
> -                                                       strerror(-err), -=
err);
> -                               return err;
> -                       }
> -               }
> -       }
> -
> -       memset(&dev, 0, sizeof(dev));
> -
> -       if (name) {
> -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> -               dev.name[UINPUT_MAX_NAME_SIZE - 1] =3D '\0';
> -       }
> -
> -       if (suffix) {
> -               int len, slen;
> -
> -               len =3D strlen(dev.name);
> -               slen =3D strlen(suffix);
> -
> -               /* If name + suffix don't fit, truncate the name, then ad=
d the
> -                * suffix.
> -                */
> -               if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
> -                       strcpy(dev.name + len, suffix);
> -               } else {
> -                       len =3D UINPUT_MAX_NAME_SIZE - slen - 1;
> -                       strncpy(dev.name + len, suffix, slen);
> -                       dev.name[UINPUT_MAX_NAME_SIZE - 1] =3D '\0';
> -               }
> -       }
> -
> -       dev.id.bustype =3D BUS_BLUETOOTH;
> -       dev.id.vendor  =3D btd_device_get_vendor(device);
> -       dev.id.product =3D btd_device_get_product(device);
> -       dev.id.version =3D btd_device_get_version(device);
> -
> -       if (write(fd, &dev, sizeof(dev)) < 0) {
> -               err =3D -errno;
> -               error("Can't write device information: %s (%d)",
> -                                               strerror(-err), -err);
> -               close(fd);
> -               return err;
> -       }
> -
> -       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> -       ioctl(fd, UI_SET_EVBIT, EV_REL);
> -       ioctl(fd, UI_SET_EVBIT, EV_REP);
> -       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> -
> -       ba2strlc(btd_adapter_get_address(device_get_adapter(device)), src=
);
> -       ioctl(fd, UI_SET_PHYS, src);
> -
> -       for (i =3D 0; key_map[i].name !=3D NULL; i++)
> -               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> -
> -       if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
> -               err =3D -errno;
> -               error("Can't create uinput device: %s (%d)",
> -                                               strerror(-err), -err);
> -               close(fd);
> -               return err;
> -       }
> -
> -       send_event(fd, EV_REP, REP_DELAY, 300);
> -
> -       return fd;
> -}
> -
>  static void init_uinput(struct avctp *session)
>  {
>         char name[UINPUT_MAX_NAME_SIZE];
> @@ -1249,7 +1147,8 @@ static void init_uinput(struct avctp *session)
>                 session->key_quirks[AVC_PAUSE] |=3D QUIRK_NO_RELEASE;
>         }
>
> -       session->uinput =3D uinput_create(session->device, name, " (AVRCP=
)");
> +       session->uinput =3D uinput_create(device_get_adapter(session->dev=
ice),
> +                               session->device, name, " (AVRCP)", key_ma=
p);
>         if (session->uinput < 0)
>                 error("AVRCP: failed to init uinput for %s", name);
>         else
> @@ -1793,7 +1692,7 @@ static const char *op2str(uint8_t op)
>         int i;
>
>         for (i =3D 0; key_map[i].name !=3D NULL; i++) {
> -               if ((op & 0x7F) =3D=3D key_map[i].avc)
> +               if ((op & 0x7F) =3D=3D key_map[i].code)
>                         return key_map[i].name;
>         }
>
> @@ -2232,7 +2131,7 @@ bool avctp_supports_avc(uint8_t avc)
>         int i;
>
>         for (i =3D 0; key_map[i].name !=3D NULL; i++) {
> -               if (key_map[i].avc =3D=3D avc)
> +               if (key_map[i].code =3D=3D avc)
>                         return true;
>         }
>         return false;
> diff --git a/profiles/audio/uinput-util.c b/profiles/audio/uinput-util.c
> new file mode 100644
> index 000000000..75f2a500c
> --- /dev/null
> +++ b/profiles/audio/uinput-util.c
> @@ -0,0 +1,146 @@
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
> +#include <linux/uinput.h>
> +
> +#include <glib.h>
> +
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/log.h"
> +
> +#include "uinput-util.h"
> +
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
> +void uinput_send_key(int fd, uint16_t key, int pressed)
> +{
> +       if (fd < 0)
> +               return;
> +
> +       send_event(fd, EV_KEY, key, pressed);
> +       send_event(fd, EV_SYN, SYN_REPORT, 0);
> +}
> +
> +int uinput_create(struct btd_adapter *adapter, struct btd_device *device=
,
> +                                       const char *name, const char *suf=
fix,
> +                                       const struct uinput_key_map *key_=
map)
> +{
> +       struct uinput_user_dev dev;
> +       int fd, err, i;
> +       char src[18];
> +
> +       fd =3D open("/dev/uinput", O_RDWR);
> +       if (fd < 0) {
> +               fd =3D open("/dev/input/uinput", O_RDWR);
> +               if (fd < 0) {
> +                       fd =3D open("/dev/misc/uinput", O_RDWR);
> +                       if (fd < 0) {
> +                               err =3D -errno;
> +                               error("Can't open input device: %s (%d)",
> +                                                       strerror(-err), -=
err);
> +                               return err;
> +                       }
> +               }
> +       }
> +
> +       memset(&dev, 0, sizeof(dev));
> +
> +       if (name) {
> +               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> +               dev.name[UINPUT_MAX_NAME_SIZE - 1] =3D '\0';
> +       }
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
> +               if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
> +                       strcpy(dev.name + len, suffix);
> +               } else {
> +                       len =3D UINPUT_MAX_NAME_SIZE - slen - 1;
> +                       strncpy(dev.name + len, suffix, slen);
> +                       dev.name[UINPUT_MAX_NAME_SIZE - 1] =3D '\0';
> +               }
> +       }
> +
> +       if (device) {
> +               dev.id.bustype =3D BUS_BLUETOOTH;
> +               dev.id.vendor  =3D btd_device_get_vendor(device);
> +               dev.id.product =3D btd_device_get_product(device);
> +               dev.id.version =3D btd_device_get_version(device);
> +       } else {
> +               dev.id.bustype =3D BUS_VIRTUAL;
> +               dev.id.vendor  =3D 0;
> +               dev.id.product =3D 0;
> +               dev.id.version =3D 0;
> +       }
> +
> +       if (write(fd, &dev, sizeof(dev)) < 0) {
> +               err =3D -errno;
> +               error("Can't write device information: %s (%d)",
> +                                               strerror(-err), -err);
> +               close(fd);
> +               return err;
> +       }
> +
> +       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> +       ioctl(fd, UI_SET_EVBIT, EV_REL);
> +       ioctl(fd, UI_SET_EVBIT, EV_REP);
> +       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> +
> +       ba2strlc(btd_adapter_get_address(adapter), src);
> +       ioctl(fd, UI_SET_PHYS, src);
> +
> +       for (i =3D 0; key_map[i].name !=3D NULL; i++)
> +               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> +
> +       if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
> +               err =3D -errno;
> +               error("Can't create uinput device: %s (%d)",
> +                                               strerror(-err), -err);
> +               close(fd);
> +               return err;
> +       }
> +
> +       send_event(fd, EV_REP, REP_DELAY, 300);
> +
> +       return fd;
> +}
> diff --git a/profiles/audio/uinput-util.h b/profiles/audio/uinput-util.h
> new file mode 100644
> index 000000000..75de8aedd
> --- /dev/null
> +++ b/profiles/audio/uinput-util.h
> @@ -0,0 +1,23 @@
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
> +struct uinput_key_map {
> +       const char *name;
> +       unsigned int code;
> +       uint16_t uinput;
> +};
> +
> +int uinput_create(struct btd_adapter *adapter, struct btd_device *device=
,
> +                                       const char *name, const char *suf=
fix,
> +                                       const struct uinput_key_map *key_=
map);
> +
> +void uinput_send_key(int fd, uint16_t key, int pressed);
> --
> 2.51.1
>

I would consider moving this to src/shared though, so we can later
create unit tests if we need to, we will need to decouple it from
btd_adapter and btd_device and create a bt_uinput instance that wraps
the access to uinput fd.

--=20
Luiz Augusto von Dentz
