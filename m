Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49F69953
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955822; cv=none; b=NYcjrQ43+HfmXUgR2nxARQrF7kHpo9mSxopXa3Rw+W6+Dq4eo3kdDxjcRRsZpkSYNWUKNvFM3CUHzL6kY//8/6TDldMDQCStGXI5i0uL4YhHatHx9zeUU7E4OovhQYdvMIqsVIn5FGGTRfwHMRGz92rl86Jep78rYAMeFjwRW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955822; c=relaxed/simple;
	bh=OnIG5XbPXzEXg6Q423lRnc1aXHMgw8Ci41KH+KquB0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3hNdnrbyUAwchpianUv+xPijbk09Xn+eepbMWpUPXtESySFHI0wguu0EbAzg5LphEy8e39/umQEzPcCEJV4HwPmKh/9oT1G2AhTFsar3JvhcWDatvCt9nd2ZP/sj6OF+WcKL5Ab7WIuZrd3XPYsQBeOTCx1dmG/Xkc9WlSJsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kny/oNvA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kny/oNvA"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso23594741fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715955818; x=1716560618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDwfqWbVOjV6tA68f3L2KkJvNLJpFrKSVSGj9Jo0G7o=;
        b=kny/oNvA6h0YU496Y4aSoY93pMGsE+P1MqvuXeDrhX5bIKW6TN0t34Y9r/Rey5Z9nd
         m/IZwNQY4JADAtNxLlgwGxI2ikb7vWkZDmfDCeQshbnBLm3MM4CJexitMcXE/gxL5yam
         t4hBGaS1Js/SolIqczCDeIOtX8bDowNtOQ6tJIZcRHKcHK8SwVcyKpCAdAd6I9oej3tk
         KMzwdc+UcOsURVozUvnHql9BdYO1tZv9FQI/Op4EH1/ShUsGLRbocMC2xaZtROodWokC
         izO0ayfpFIxZ0mrxwd/AyIXjEpFmckLjRy29BuENpR2F5OaHmp4QflGh7WV4Sp+TWMuf
         lmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715955818; x=1716560618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDwfqWbVOjV6tA68f3L2KkJvNLJpFrKSVSGj9Jo0G7o=;
        b=itBY7cPxfv1+SF72j13Dh5G8wEKDFyIvZz1h72qFuSzOkVwxFvJ9hlekgDTjcfSZm1
         qWa7bjyT80D77geuJALAAWVZ6YF3jcqizLPg5/G89AEmBXplZMRbc3Ec718LX5OQGcgO
         uJ8Tn2UHvUGww1er9JbbwLBpnWcB7MesOidHQGnWuTzdvEier9c3JFPiKUPadNq3SsiL
         b597/g6NnUf9UZ0LK6A7sl9YShXWHCgKyYvoCh3YxZFuiWmKHw/9Ko2qaAsYnoTYMhAi
         Ois1A2y128ETK5qnykhxPegItQhBR19mFWcMgsC4pV91U/KL/+kDV03+dSIxipXfhejU
         brSA==
X-Gm-Message-State: AOJu0YxxqyPuJimY+7fit48R9T61qO47O1g8WrEwE17hkAFhHv4nITdY
	Es3hYcnXl6fLdGEFMlWmcZ2/g3BMMmQO6x6iufMkwQPTs86mKsQNCJM2NtLcROheLmEBBZ2XAsd
	d0JY0RAbpm4ik85P91MSDzBTVzo7Gcw==
X-Google-Smtp-Source: AGHT+IEXzntaIyQ2RsPgCIw+rmaOK48jxHMn9jnZr2fNmr2umnGjrmF8fsBRqNcGL0ZWGTNcAQJGhyYMGAFciLDgqes=
X-Received: by 2002:a2e:1319:0:b0:2e6:be3c:9d37 with SMTP id
 38308e7fff4ca-2e6be3ce4d9mr86395191fa.14.1715955817402; Fri, 17 May 2024
 07:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516193836.228281-1-arun@asymptotic.io> <20240516193836.228281-2-arun@asymptotic.io>
In-Reply-To: <20240516193836.228281-2-arun@asymptotic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 May 2024 10:23:25 -0400
Message-ID: <CABBYNZLriw3OMX_oNA84FohCp20i0zeskZn9MZGOD5qg=EaPEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ,v6 1/5] src/shared: Add initial implementation for
 an ASHA profile
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On Fri, May 17, 2024 at 9:07=E2=80=AFAM Arun Raghavan <arun@asymptotic.io> =
wrote:
>
> This implements the server role for the Audio Streaming for Hearing Aid
> specification[1]. Includes basic ability to probe the ASHA GATT service,
> as well as starting/stopping streaming.
>
> [1] https://source.android.com/docs/core/connect/bluetooth/asha
> ---
>  Makefile.am       |   3 +-
>  configure.ac      |   4 +
>  lib/uuid.h        |   3 +
>  src/shared/asha.c | 529 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/asha.h |  75 +++++++
>  5 files changed, 613 insertions(+), 1 deletion(-)
>  create mode 100644 src/shared/asha.c
>  create mode 100644 src/shared/asha.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 05d02932f..3e6610017 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -238,7 +238,8 @@ shared_sources =3D src/shared/io.h src/shared/timeout=
.h \
>                         src/shared/bass.h src/shared/bass.c \
>                         src/shared/ccp.h src/shared/ccp.c \
>                         src/shared/lc3.h src/shared/tty.h \
> -                       src/shared/bap-defs.h
> +                       src/shared/bap-defs.h \
> +                       src/shared/asha.h src/shared/asha.c
>
>  if READLINE
>  shared_sources +=3D src/shared/shell.c src/shared/shell.h
> diff --git a/configure.ac b/configure.ac
> index 8b3cdb4e8..213e36b32 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -216,6 +216,10 @@ AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
>                 [disable CSIP profile]), [enable_csip=3D${enableval}])
>  AM_CONDITIONAL(CSIP, test "${enable_csip}" !=3D "no")
>
> +AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
> +               [disable ASHA support]), [enable_asha=3D${enableval}])
> +AM_CONDITIONAL(ASHA, test "${enable_asha}" !=3D "no")
> +
>  AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
>                 [disable Bluetooth tools]), [enable_tools=3D${enableval}]=
)
>  AM_CONDITIONAL(TOOLS, test "${enable_tools}" !=3D "no")
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 8404b287e..479986f06 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -163,6 +163,9 @@ extern "C" {
>  #define BAA_SERVICE                                    0x1851
>  #define BAA_SERVICE_UUID       "00001851-0000-1000-8000-00805f9b34fb"
>
> +#define ASHA_SERVICE                                   0xFDF0
> +#define ASHA_PROFILE_UUID      "0000FDF0-0000-1000-8000-00805f9b34fb"
> +
>  #define PAC_CONTEXT                                    0x2bcd
>  #define PAC_SUPPORTED_CONTEXT                          0x2bce
>
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> new file mode 100644
> index 000000000..db86846fa
> --- /dev/null
> +++ b/src/shared/asha.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Asymptotic Inc.
> + *
> + *  Author: Arun Raghavan <arun@asymptotic.io>
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +
> +#include "lib/bluetooth.h"
> +#include "lib/l2cap.h"
> +#include "lib/uuid.h"
> +
> +#include "src/adapter.h"
> +#include "src/device.h"

This is not quite right, we can't depend on libbluetooth since that is
GPL also both adapter.h and device.h, or any header that adds btd_
APIs, are probably only meant for use in bluetoothd internals, usually
that means that the connection setup, socket handling etc, needs to be
done at the plugin side and then attached to the bt_asha instance as a
pure file descriptor then you can manage it via io handling.

> +#include "src/shared/util.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/log.h"
> +
> +#include "asha.h"
> +
> +/* We use strings instead of uint128_t to maintain readability */
> +#define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c9=
02aad37bb"
> +#define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937=
b0996cc0"
> +#define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b5640483=
7"
> +#define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
> +#define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
> +
> +/* 2 byte SDU length, 1 byte sequence number, and then 20ms of G.722 */
> +#define ASHA_MIN_MTU 163
> +#define ASHA_CONNECTION_MTU 512                        /* The default of=
 672 does not
> +                                                * work */
> +
> +struct bt_asha_device *bt_asha_device_new(void)
> +{
> +       struct bt_asha_device *asha;
> +
> +       asha =3D new0(struct bt_asha_device, 1);
> +
> +       return asha;
> +}
> +
> +void bt_asha_device_reset(struct bt_asha_device *asha)
> +{
> +       if (asha->status_notify_id) {
> +               bt_gatt_client_unregister_notify(asha->client,
> +                                               asha->status_notify_id);
> +       }
> +
> +       if (asha->volume_notify_id) {
> +               bt_gatt_client_unregister_notify(asha->client,
> +                                               asha->volume_notify_id);
> +       }
> +
> +       gatt_db_unref(asha->db);
> +       asha->db =3D NULL;
> +
> +       bt_gatt_client_unref(asha->client);
> +       asha->client =3D NULL;
> +
> +       asha->psm =3D 0;
> +}
> +
> +void bt_asha_state_reset(struct bt_asha_device *asha)
> +{
> +       close(asha->fd);
> +       asha->fd =3D -1;
> +
> +       asha->state =3D ASHA_STOPPED;
> +       asha->resume_id =3D 0;
> +
> +       asha->cb =3D NULL;
> +       asha->cb_user_data =3D NULL;
> +}
> +
> +void bt_asha_device_free(struct bt_asha_device *asha)
> +{
> +       gatt_db_unref(asha->db);
> +       bt_gatt_client_unref(asha->client);
> +       free(asha);
> +}
> +
> +uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha)
> +{
> +       return asha->render_delay;
> +}
> +
> +enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *ash=
a)
> +{
> +       return asha->state;
> +}
> +
> +int bt_asha_device_get_fd(struct bt_asha_device *asha)
> +{
> +       return asha->fd;
> +}
> +
> +uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha)
> +{
> +       return asha->omtu;
> +}
> +uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha)
> +{
> +       return asha->imtu;
> +}
> +
> +static int asha_connect_socket(struct bt_asha_device *asha)
> +{
> +       int fd =3D 0, err;
> +       struct sockaddr_l2 addr =3D { 0, };
> +       struct l2cap_options opts;
> +       socklen_t len;
> +
> +       fd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> +       if (fd < 0) {
> +               error("Could not open L2CAP CoC socket: %s", strerror(err=
no));
> +               goto error;
> +       }
> +
> +       addr.l2_family =3D AF_BLUETOOTH;
> +       addr.l2_bdaddr_type =3D BDADDR_LE_PUBLIC;
> +
> +       /*
> +        * We need to bind before connect to work around getting the wron=
g addr
> +        * type on older(?) kernels
> +        */
> +       err =3D bind(fd, (struct sockaddr *) &addr, sizeof(addr));
> +       if (err < 0) {
> +               error("Could not bind L2CAP CoC socket: %s", strerror(err=
no));
> +               goto error;
> +       }
> +
> +       addr.l2_psm =3D asha->psm;
> +       bacpy(&addr.l2_bdaddr, device_get_address(asha->device));
> +
> +       opts.mode =3D BT_MODE_LE_FLOWCTL;
> +       opts.omtu =3D opts.imtu =3D ASHA_MIN_MTU;
> +
> +       err =3D setsockopt(fd, SOL_BLUETOOTH, BT_MODE, &opts.mode,
> +                                                       sizeof(opts.mode)=
);
> +       if (err < 0) {
> +               error("Could not set L2CAP CoC socket flow control mode: =
%s",
> +                               strerror(errno));
> +               /* Let this be non-fatal? */
> +       }
> +
> +       opts.imtu =3D ASHA_CONNECTION_MTU;
> +       err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu,
> +                                                       sizeof(opts.imtu)=
);
> +       if (err < 0) {
> +               error("Could not set L2CAP CoC socket receive MTU: %s",
> +                               strerror(errno));
> +               /* Let this be non-fatal? */
> +       }
> +
> +       err =3D connect(fd, (struct sockaddr *)&addr, sizeof(addr));
> +       if (err < 0) {
> +               error("Could not connect L2CAP CoC socket: %s",
> +                                                       strerror(errno));
> +               goto error;
> +       }
> +
> +       err =3D getsockopt(fd, SOL_BLUETOOTH, BT_SNDMTU, &opts.omtu, &len=
);
> +       if (err < 0) {
> +               error("Could not get L2CAP CoC socket receive MTU: %s",
> +                               strerror(errno));
> +               /* Let this be non-fatal? */
> +       }
> +
> +       err =3D getsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu, &len=
);
> +       if (err < 0) {
> +               error("Could not get L2CAP CoC socket receive MTU: %s",
> +                               strerror(errno));
> +               /* Let this be non-fatal? */
> +       }
> +
> +       asha->fd =3D fd;
> +       asha->imtu =3D opts.imtu;
> +       asha->omtu =3D opts.omtu;
> +
> +       DBG("L2CAP CoC socket is open");
> +       return 0;
> +
> +error:
> +       if (fd)
> +               close(fd);
> +       return -1;
> +}
> +
> +static void asha_acp_sent(bool success, uint8_t err, void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       if (success) {
> +               DBG("AudioControlPoint command successfully sent");
> +       } else {
> +               error("Failed to send AudioControlPoint command: %d", err=
);
> +
> +               if (asha->cb)
> +                       asha->cb(-1, asha->cb_user_data);
> +
> +               bt_asha_state_reset(asha);
> +       }
> +}
> +
> +static int asha_send_acp(struct bt_asha_device *asha, uint8_t *cmd,
> +               unsigned int len, bt_asha_cb_t cb, void *user_data)
> +{
> +       if (!bt_gatt_client_write_value(asha->client, asha->acp_handle, c=
md,
> +                               len, asha_acp_sent, asha, NULL)) {
> +               error("Error writing ACP start");
> +               return -1;
> +       }
> +
> +       asha->cb =3D cb;
> +       asha->cb_user_data =3D user_data;
> +
> +       return 0;
> +}
> +
> +unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_c=
b_t cb,
> +               void *user_data)
> +{
> +       uint8_t acp_start_cmd[] =3D {
> +               0x01,           /* START */
> +               0x01,           /* G.722, 16 kHz */
> +               0,              /* Unknown media type */
> +               asha->volume,   /* Volume */
> +               0,              /* Other disconnected */
> +       };
> +       int ret;
> +
> +       if (asha->state !=3D ASHA_STOPPED) {
> +               error("ASHA device start failed. Bad state %d", asha->sta=
te);
> +               return 0;
> +       }
> +
> +       ret =3D asha_connect_socket(asha);
> +       if (ret < 0)
> +               return 0;
> +
> +       ret =3D asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd),=
 cb,
> +                       user_data);
> +       if (ret < 0)
> +               return 0;
> +
> +       asha->state =3D ASHA_STARTING;
> +
> +       return (++asha->resume_id);
> +}
> +
> +unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb=
_t cb,
> +               void *user_data)
> +{
> +       uint8_t acp_stop_cmd[] =3D {
> +               0x02, /* STOP */
> +       };
> +       int ret;
> +
> +       if (asha->state !=3D ASHA_STARTED)
> +               return 0;
> +
> +       asha->state =3D ASHA_STOPPING;
> +
> +       ret =3D asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), c=
b,
> +                       user_data);
> +       if (ret < 0)
> +               return 0;
> +
> +       return asha->resume_id;
> +}
> +
> +int8_t bt_asha_device_get_volume(struct bt_asha_device *asha)
> +{
> +       return asha->volume;
> +}
> +
> +bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volum=
e)
> +{
> +       if (!bt_gatt_client_write_value(asha->client, asha->volume_handle=
,
> +                               (const uint8_t *)&volume, 1, NULL, NULL,
> +                               NULL)) {
> +               error("Error writing ACP start");
> +               return false;
> +       }
> +
> +       asha->volume =3D volume;
> +       return true;
> +}
> +
> +static bool uuid_cmp(const char *uuid1, const bt_uuid_t *uuid2)
> +{
> +       bt_uuid_t lhs;
> +
> +       bt_string_to_uuid(&lhs, uuid1);
> +
> +       return bt_uuid_cmp(&lhs, uuid2) =3D=3D 0;
> +}
> +
> +static void read_psm(bool success,
> +                       uint8_t att_ecode,
> +                       const uint8_t *value,
> +                       uint16_t length,
> +                       void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       if (!success) {
> +               DBG("Reading PSM failed with ATT error: %u", att_ecode);
> +               return;
> +       }
> +
> +       if (length !=3D 2) {
> +               DBG("Reading PSM failed: unexpected length %u", length);
> +               return;
> +       }
> +
> +       asha->psm =3D get_le16(value);
> +
> +       DBG("Got PSM: %u", asha->psm);
> +}
> +
> +static void read_rops(bool success,
> +                       uint8_t att_ecode,
> +                       const uint8_t *value,
> +                       uint16_t length,
> +                       void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       if (!success) {
> +               DBG("Reading ROPs failed with ATT error: %u", att_ecode);
> +               return;
> +       }
> +
> +       if (length !=3D 17) {
> +               DBG("Reading ROPs failed: unexpected length %u", length);
> +               return;
> +       }
> +
> +       if (value[0] !=3D 0x01) {
> +               DBG("Unexpected ASHA version: %u", value[0]);
> +               return;
> +       }
> +
> +       /* Device Capabilities */
> +       asha->right_side =3D (value[1] & 0x1) !=3D 0;
> +       asha->binaural =3D (value[1] & 0x2) !=3D 0;
> +       asha->csis_supported =3D (value[1] & 0x4) !=3D 0;
> +       /* HiSyncId: 2 byte company id, 6 byte ID shared by left and righ=
t */
> +       memcpy(asha->hisyncid, &value[2], 8);
> +       /* FeatureMap */
> +       asha->coc_streaming_supported =3D (value[10] & 0x1) !=3D 0;
> +       /* RenderDelay */
> +       asha->render_delay =3D get_le16(&value[11]);
> +       /* byte 13 & 14 are reserved */
> +       /* Codec IDs */
> +       asha->codec_ids =3D get_le16(&value[15]);
> +
> +       DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: =
%u",
> +                       asha->right_side, asha->binaural, asha->csis_supp=
orted,
> +                       asha->render_delay, asha->codec_ids);
> +}
> +
> +static void audio_status_notify(uint16_t value_handle, const uint8_t *va=
lue,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +       uint8_t status =3D *value;
> +       /* Back these up to survive the reset paths */
> +       bt_asha_cb_t cb =3D asha->cb;
> +       bt_asha_cb_t cb_user_data =3D asha->cb_user_data;
> +
> +       if (asha->state =3D=3D ASHA_STARTING) {
> +               if (status =3D=3D 0) {
> +                       asha->state =3D ASHA_STARTED;
> +                       DBG("ASHA start complete");
> +               } else {
> +                       bt_asha_state_reset(asha);
> +                       DBG("ASHA start failed");
> +               }
> +       } else if (asha->state =3D=3D ASHA_STOPPING) {
> +               /* We reset our state, regardless */
> +               bt_asha_state_reset(asha);
> +               DBG("ASHA stop %s", status =3D=3D 0 ? "complete" : "faile=
d");
> +       }
> +
> +       if (cb) {
> +               cb(status, cb_user_data);
> +               asha->cb =3D NULL;
> +               asha->cb_user_data =3D NULL;
> +       }
> +}
> +
> +static void read_volume(bool success,
> +                       uint8_t att_ecode,
> +                       const uint8_t *value,
> +                       uint16_t length,
> +                       void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       if (!success) {
> +               DBG("Reading volume failed with ATT error: %u", att_ecode=
);
> +               return;
> +       }
> +
> +       if (length !=3D 2) {
> +               DBG("Reading volume failed: unexpected length %u", length=
);
> +               return;
> +       }
> +
> +       asha->volume =3D get_s8(value);
> +
> +       DBG("Got volume: %d", asha->volume);
> +}
> +
> +static void volume_notify(uint16_t value_handle, const uint8_t *value,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       asha->volume =3D get_s8(value);
> +
> +       DBG("Volume changed: %d", asha->volume);
> +}
> +
> +static void handle_characteristic(struct gatt_db_attribute *attr,
> +                                                               void *use=
r_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid;
> +
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, N=
ULL,
> +                                                               NULL, &uu=
id)) {
> +               error("Failed to obtain characteristic data");
> +               return;
> +       }
> +
> +       if (uuid_cmp(ASHA_CHRC_LE_PSM_OUT_UUID, &uuid)) {
> +               if (!bt_gatt_client_read_value(asha->client, value_handle=
,
> +                                       read_psm, asha, NULL))
> +                       DBG("Failed to send request to read battery level=
");
> +       } else if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) =
{
> +               if (!bt_gatt_client_read_value(asha->client, value_handle=
,
> +                                       read_rops, asha, NULL))
> +                       DBG("Failed to send request for readonly properti=
es");
> +       } else if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
> +               /* Store this for later writes */
> +               asha->acp_handle =3D value_handle;
> +       } else if (uuid_cmp(ASHA_CHRC_VOLUME_UUID, &uuid)) {
> +               /* Store this for later reads and writes */
> +               asha->volume_handle =3D value_handle;
> +               asha->volume_notify_id =3D
> +                       bt_gatt_client_register_notify(asha->client,
> +                               value_handle, NULL, volume_notify, asha,
> +                               NULL);
> +               if (!asha->status_notify_id)
> +                       DBG("Failed to send request to notify volume");
> +               if (!bt_gatt_client_read_value(asha->client, value_handle=
,
> +                                       read_volume, asha, NULL))
> +                       DBG("Failed to send request to volume");
> +       } else if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
> +               asha->status_notify_id =3D
> +                       bt_gatt_client_register_notify(asha->client,
> +                               value_handle, NULL, audio_status_notify, =
asha,
> +                               NULL);
> +               if (!asha->status_notify_id)
> +                       DBG("Failed to send request to notify AudioStatus=
");
> +       } else {
> +               char uuid_str[MAX_LEN_UUID_STR];
> +
> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +               DBG("Unsupported characteristic: %s", uuid_str);
> +       }
> +}
> +
> +static void foreach_asha_service(struct gatt_db_attribute *attr,
> +                                                       void *user_data)
> +{
> +       struct bt_asha_device *asha =3D user_data;
> +
> +       DBG("Found ASHA GATT service");
> +
> +       asha->attr =3D attr;
> +       gatt_db_service_foreach_char(asha->attr, handle_characteristic, a=
sha);
> +}
> +
> +bool bt_asha_device_probe(struct bt_asha_device *asha)
> +{
> +       struct btd_device *device =3D asha->device;
> +       struct gatt_db *db =3D btd_device_get_gatt_db(device);
> +       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> +       bt_uuid_t asha_uuid;
> +
> +       asha->db =3D gatt_db_ref(db);
> +       asha->client =3D bt_gatt_client_clone(client);
> +
> +       bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
> +       gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, ash=
a);
> +
> +       if (!asha->attr) {
> +               error("ASHA attribute not found");
> +               bt_asha_device_reset(asha);
> +               return false;
> +       }
> +
> +       return true;
> +}
> diff --git a/src/shared/asha.h b/src/shared/asha.h
> new file mode 100644
> index 000000000..24fe5d5bd
> --- /dev/null
> +++ b/src/shared/asha.h
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Asymptotic Inc.
> + *
> + *  Author: Arun Raghavan <arun@asymptotic.io>
> + *
> + *
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +struct bt_asha_device;
> +
> +enum bt_asha_state_t {
> +       ASHA_STOPPED =3D 0,
> +       ASHA_STARTING,
> +       ASHA_STARTED,
> +       ASHA_STOPPING,
> +};
> +
> +typedef void (*bt_asha_cb_t)(int status, void *data);
> +
> +struct bt_asha_device {
> +       struct btd_device *device;
> +       struct bt_gatt_client *client;
> +       struct gatt_db *db;
> +       struct gatt_db_attribute *attr;
> +       uint16_t acp_handle;
> +       uint16_t volume_handle;
> +       unsigned int status_notify_id;
> +       unsigned int volume_notify_id;
> +
> +       uint16_t psm;
> +       bool right_side;
> +       bool binaural;
> +       bool csis_supported;
> +       bool coc_streaming_supported;
> +       uint8_t hisyncid[8];
> +       uint16_t render_delay;
> +       uint16_t codec_ids;
> +       int8_t volume;
> +
> +       struct media_transport *transport;
> +       int fd;
> +       uint16_t imtu, omtu;
> +       enum bt_asha_state_t state;
> +       bt_asha_cb_t cb;
> +       void *cb_user_data;
> +       int resume_id;
> +};
> +
> +struct bt_asha_device *bt_asha_device_new(void);
> +void bt_asha_device_reset(struct bt_asha_device *asha);
> +void bt_asha_state_reset(struct bt_asha_device *asha);
> +void bt_asha_device_free(struct bt_asha_device *asha);
> +
> +uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha);
> +enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *ash=
a);
> +int bt_asha_device_get_fd(struct bt_asha_device *asha);
> +uint16_t bt_asha_device_get_omtu(struct bt_asha_device *asha);
> +uint16_t bt_asha_device_get_imtu(struct bt_asha_device *asha);
> +
> +unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_c=
b_t cb,
> +               void *user_data);
> +unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb=
_t cb,
> +               void *user_data);
> +
> +int8_t bt_asha_device_get_volume(struct bt_asha_device *asha);
> +bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volum=
e);
> +
> +bool bt_asha_device_probe(struct bt_asha_device *asha);
> --
> 2.45.0
>
>


--=20
Luiz Augusto von Dentz
