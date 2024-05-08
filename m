Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62F12881C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185533; cv=none; b=OgNFUd9v1UmaSOdk6lTRmt7uPKagxL3Lv2qBLMyh5gWHiR2gcJMI74zMFoFT52AnR8g/a0SvPL46ViO4b3qd3XSP/BLmr9zSbrRwbH+fwRlXFCRzZiTHS5Th74OdFl6+cqid1uDTlij4k5Y81DKmQa1dNw7S5aO9qvTr7evGoHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185533; c=relaxed/simple;
	bh=dOPV+WCFq8v88rEmEgTubzp/mnAP8a024wns8QrgbSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbsKphgASxdzXlKTuPpFo1b9p29bSgEYI4YCU/B04b2ZyKm90okz0HnvkQmzvGYJLqm5JT/zKOdUoHnupkQ17GUjys7dvk9fZCJBH7K36eLSaBIYo1OWbjBgeIMO0xb89ZRqeakYOFl4iwF8I3yPeaZBVZkIfz8OUPTwHMpkELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmgrffoR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmgrffoR"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so59122591fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715185528; x=1715790328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ftHz0XwXrVvCOXVyOVAwoLNu5FK4BQ/IWvStNn0DfQ=;
        b=MmgrffoRc7PUIZ6MmOvZVqRum6sI4uBxIbyS72xPMOY2Ykdsr5FyU3NStGGm9aoHCr
         AExn9Iz8vISMEr0qp51a6r1jyvgQ5z9ssiArqCH1obO53pQv37fDIdSP7MkZZgIt5B6I
         8DezEkbTotNpzluRXSxBZJK8gP8hCEqpRnugF9SnmhoLw12SQmq6AsJy76XuVLWwnk0a
         7FRaP7Jlj4MaGZqTHoxFstFpkf3CJp7otJQIRbtJAeWcjg+9eg2fPHp4rTystjSfu9EP
         v0gtqTK31JKesTujFX5aV5Azf11VBHVhyZZesPcDx1J95x+AedOpsZWTK4Bu+iSFuW+5
         tg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185528; x=1715790328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ftHz0XwXrVvCOXVyOVAwoLNu5FK4BQ/IWvStNn0DfQ=;
        b=Ez2V5Z0Ra62nX3WSLrnsPaW/l+e2tMHu6jyjbSsru4cTBPoHW6Pe8AxF8K4CkdSs1M
         KE7y0tyuN8mrwLOPUHxG1Rj1MdRWgzcjjDxI4bb33jQndbopcwSsrtWy33CNtTmIMZyV
         WEFloGWJdE4ZHGQGXqtcxq7xpUFES41+AQyfxw68YJsUM1vdDL1dSvUflp48hykKyQ+E
         mBpnU3bw/BFkIj6U5yq488pF+ch3EPZGmicbCCfeAyh5e4hB9ut8q6qMVE26417nJM3t
         EjKvKkglnc6Rbeudl0ou/0X7rUgIBKS/wWTun8pYkm4cnT8Vo8++n7i2XuWXaZeJsthb
         3JQA==
X-Gm-Message-State: AOJu0Ywv3ymwiazY7Pt8+pQip5tBDWqIAglljU+8B7f+KAzIeqhKgpW9
	7vCX0ogyQQF7Rwd7fAZHF/qotzPwLdZSHnHdiqgddvtjBaGvbTDWsnrl05am4SJBYmcnhTpuTdN
	FuwlbQxR0JKJAfWZR05wVY6eDTKfRjjr3
X-Google-Smtp-Source: AGHT+IHmzihtRR2QiZ1hdtURmT7AnTywnzB4l86AimWLCrQfL01bsTl7ENroSPHhxlyCbnexvK2UOD+3Kphi4zX8We0=
X-Received: by 2002:a05:651c:1a0d:b0:2d9:f00c:d2d5 with SMTP id
 38308e7fff4ca-2e4477b56d4mr23054001fa.46.1715185527967; Wed, 08 May 2024
 09:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508154604.276763-1-arun@asymptotic.io> <20240508154604.276763-2-arun@asymptotic.io>
In-Reply-To: <20240508154604.276763-2-arun@asymptotic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 May 2024 12:25:14 -0400
Message-ID: <CABBYNZK-_k5913d=dFDw-+quYtyhn1125KKH0DYWKV=bcFHH2g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] profiles: Add initial code for an ASHA plugin
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On Wed, May 8, 2024 at 12:05=E2=80=AFPM Arun Raghavan <arun@asymptotic.io> =
wrote:
>
> This implements the server role for the Audio Streaming for Hearing Aid
> specification[1].
>
> The implementation registers a remote endpoint using a subset of the
> MediaEndpoint1 interface, without any mechanism for setting/selecting a
> configuration, as this is all static in the spec for now. Also exposed
> on connection is a MediaTransport1 object, which can be used to obtain
> an fd to stream to the device.
>
> [1] https://source.android.com/docs/core/connect/bluetooth/asha
> ---
>  Makefile.plugins           |   5 +
>  configure.ac               |   4 +
>  lib/uuid.h                 |   3 +
>  profiles/audio/asha.c      | 761 +++++++++++++++++++++++++++++++++++++
>  profiles/audio/asha.h      |  34 ++
>  profiles/audio/media.c     |  28 ++
>  profiles/audio/media.h     |   2 +
>  profiles/audio/transport.c | 147 ++++++-
>  8 files changed, 982 insertions(+), 2 deletions(-)
>  create mode 100644 profiles/audio/asha.c
>  create mode 100644 profiles/audio/asha.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 4aa2c9c92..e196e1d2e 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -147,3 +147,8 @@ if CSIP
>  builtin_modules +=3D csip
>  builtin_sources +=3D profiles/audio/csip.c
>  endif
> +
> +if ASHA
> +builtin_modules +=3D asha
> +builtin_sources +=3D profiles/audio/asha.c
> +endif
> diff --git a/configure.ac b/configure.ac
> index 9dea70ddc..826b34518 100644
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
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> new file mode 100644
> index 000000000..c6769038f
> --- /dev/null
> +++ b/profiles/audio/asha.c
> @@ -0,0 +1,761 @@
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
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +
> +#include <dbus/dbus.h>
> +#include <glib.h>
> +
> +#include "gdbus/gdbus.h"
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +
> +#include "src/dbus-common.h"
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/log.h"
> +#include "src/plugin.h"
> +#include "src/profile.h"
> +#include "src/service.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/util.h"
> +
> +#include "profiles/audio/media.h"
> +#include "profiles/audio/transport.h"
> +
> +#include "asha.h"
> +#include "l2cap.h"
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
> +#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
> +
> +// 1 sequence number, 4 for L2CAP header, 2 for SDU, and then 20ms of G.=
722
> +#define ASHA_MTU 167

Afaik the L2CAP header is already accounted for, or is it another header?

> +
> +struct asha_device {
> +       struct btd_device *device;
> +       struct bt_gatt_client *client;
> +       struct gatt_db *db;
> +       struct gatt_db_attribute *attr;
> +       uint16_t acp_handle;
> +       unsigned int notify_id;
> +
> +       uint16_t psm;
> +       bool right_side;
> +       bool binaural;
> +       bool csis_supported;
> +       bool coc_streaming_supported;
> +       uint8_t hisyncid[8];
> +       uint16_t render_delay;
> +       uint16_t codec_ids;
> +
> +       struct media_transport *transport;
> +       int fd;
> +       asha_state_t state;
> +       asha_cb_t cb;
> +       void *cb_user_data;
> +       int resume_id;
> +};
> +
> +static struct asha_device *asha_device_new(void)
> +{
> +       struct asha_device *asha;
> +
> +       asha =3D new0(struct asha_device, 1);
> +
> +       return asha;
> +}
> +
> +static void asha_device_reset(struct asha_device *asha)
> +{
> +       if (asha->notify_id)
> +               bt_gatt_client_unregister_notify(asha->client,
> +                               asha->notify_id);
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
> +static void asha_state_reset(struct asha_device *asha)
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
> +static void asha_device_free(struct asha_device *asha)
> +{
> +       gatt_db_unref(asha->db);
> +       bt_gatt_client_unref(asha->client);
> +       free(asha);
> +}
> +
> +uint16_t asha_device_get_render_delay(struct asha_device *asha)
> +{
> +       return asha->render_delay;
> +}
> +
> +asha_state_t asha_device_get_state(struct asha_device *asha)
> +{
> +       return asha->state;
> +}
> +
> +int asha_device_get_fd(struct asha_device *asha)
> +{
> +       return asha->fd;
> +}
> +
> +uint16_t asha_device_get_mtu(struct asha_device *asha)
> +{
> +       return ASHA_MTU;
> +}
> +
> +static int asha_connect_socket(struct asha_device *asha)
> +{
> +       int fd =3D 0, err, ret =3D 0;
> +       struct sockaddr_l2 addr =3D { 0, };
> +       struct l2cap_options opts;
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
> +       // We need to bind before connect to work around getting the wron=
g addr
> +       // type on older(?) kernels

Lets use C style comments /* */ instead of //, so please fix that in
other comments as well.

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
> +       opts.omtu =3D opts.imtu =3D ASHA_MTU;
> +
> +       err =3D setsockopt(fd, SOL_BLUETOOTH, BT_MODE, &opts.mode,
> +                                                       sizeof(opts.mode)=
);
> +       if (err < 0) {
> +               error("Could not set L2CAP CoC socket flow control mode: =
%s",
> +                               strerror(errno));
> +               // Let this be non-fatal?
> +       }
> +
> +       err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu, size=
of(opts.imtu));
> +       if (err < 0) {
> +               error("Could not set L2CAP CoC socket receive MTU: %s",
> +                               strerror(errno));
> +               // Let this be non-fatal?
> +       }
> +
> +       err =3D connect(fd, (struct sockaddr *)&addr, sizeof(addr));
> +       if (err < 0) {
> +               error("Could not connect L2CAP CoC socket: %s", strerror(=
errno));
> +               goto error;
> +       }
> +
> +       DBG("L2CAP CoC socket is open");
> +       return fd;
> +
> +error:
> +       if (fd)
> +               close(fd);
> +       return -1;
> +}
> +
> +static void asha_acp_sent(bool success, uint8_t err, void *user_data)
> +{
> +       struct asha_device *asha =3D user_data;
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
> +               asha_state_reset(asha);
> +       }
> +}
> +
> +static int asha_send_acp(struct asha_device *asha, uint8_t *cmd,
> +               unsigned int len, asha_cb_t cb, void *user_data)
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
> +unsigned int asha_device_start(struct asha_device *asha, asha_cb_t cb,
> +               void *user_data)
> +{
> +       uint8_t acp_start_cmd[] =3D {
> +               0x01, // START
> +               0x01, // G.722, 16 kHz
> +               0,   // Unknown media type
> +               0,   // Other disconnected
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
> +       asha->fd =3D ret;
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
> +unsigned int asha_device_stop(struct asha_device *asha, asha_cb_t cb,
> +               void *user_data)
> +{
> +       uint8_t acp_stop_cmd[] =3D {
> +               0x02, // STOP
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
> +static char *make_endpoint_path(struct asha_device *asha)
> +{
> +       char *path;
> +       int err;
> +
> +       err =3D asprintf(&path, "%s/asha", device_get_path(asha->device))=
;
> +       if (err < 0) {
> +               error("Could not allocate path for remote %s",
> +                               device_get_path(asha->device));
> +               return NULL;
> +       }
> +
> +       return path;
> +
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
> +       struct asha_device *asha =3D user_data;
> +
> +       if (!success) {
> +               DBG("Reading PSM failed with ATT errror: %u", att_ecode);
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
> +       struct asha_device *asha =3D user_data;
> +
> +       if (!success) {
> +               DBG("Reading ROPs failed with ATT errror: %u", att_ecode)=
;
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
> +void audio_status_notify(uint16_t value_handle, const uint8_t *value,
> +                                       uint16_t length, void *user_data)
> +{
> +       struct asha_device *asha =3D user_data;
> +       uint8_t status =3D *value;
> +       // Back these up to survive the reset paths
> +       asha_cb_t cb =3D asha->cb;
> +       asha_cb_t cb_user_data =3D asha->cb_user_data;
> +
> +       if (asha->state =3D=3D ASHA_STARTING) {
> +               if (status =3D=3D 0) {
> +                       asha->state =3D ASHA_STARTED;
> +                       DBG("ASHA start complete");
> +               } else {
> +                       asha_state_reset(asha);
> +                       DBG("ASHA start failed");
> +               }
> +       } else if (asha->state =3D=3D ASHA_STOPPING) {
> +               // We reset our state, regardless
> +               asha_state_reset(asha);
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
> +static void handle_characteristic(struct gatt_db_attribute *attr,
> +                                                               void *use=
r_data)
> +{
> +       struct asha_device *asha =3D user_data;
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
> +       } if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) {
> +               if (!bt_gatt_client_read_value(asha->client, value_handle=
,
> +                                       read_rops, asha, NULL))
> +                       DBG("Failed to send request to read battery level=
");
> +       } if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
> +               // Store this for later writes
> +               asha->acp_handle =3D value_handle;
> +       } if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
> +               asha->notify_id =3D bt_gatt_client_register_notify(asha->=
client,
> +                               value_handle, NULL, audio_status_notify, =
asha,
> +                               NULL);
> +               if (!asha->notify_id)
> +                       DBG("Failed to send request to read battery level=
");
> +       } else {
> +               char uuid_str[MAX_LEN_UUID_STR];
> +
> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +               DBG("Unsupported characteristic: %s", uuid_str);
> +       }
> +}
> +
> +static void foreach_asha_service(struct gatt_db_attribute *attr, void *u=
ser_data)
> +{
> +       struct asha_device *asha =3D user_data;
> +
> +       DBG("Found ASHA GATT service");
> +
> +       asha->attr =3D attr;
> +       gatt_db_service_foreach_char(asha->attr, handle_characteristic, a=
sha);
> +}
> +
> +static DBusMessage *asha_set_configuration(DBusConnection *conn,
> +                                               DBusMessage *msg, void *d=
ata)
> +{
> +       return NULL;
> +}
> +
> +static gboolean get_uuid(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       const char *uuid;
> +
> +       uuid =3D ASHA_PROFILE_UUID;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_side(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       const char *side =3D asha->right_side ? "right" : "left";
> +
> +       // Use a string in case we want to support anything else in the f=
uture
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &side);
> +
> +       return TRUE;
> +}
> +
> +
> +static gboolean get_binaural(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       dbus_bool_t binaural =3D asha->binaural;
> +
> +       // Use a string in case we want to support anything else in the f=
uture
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &binaural=
);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_hisyncid(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       DBusMessageIter array;
> +       uint8_t *hisyncid =3D asha->hisyncid;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_BYTE_AS_STRING, &array)=
;
> +
> +       dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
> +                       &hisyncid, sizeof(asha->hisyncid));
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_codecs(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       dbus_uint16_t codecs =3D asha->codec_ids;
> +
> +       // Use a string in case we want to support anything else in the f=
uture
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &codecs);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_device(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       const char *path;
> +
> +       path =3D device_get_path(asha->device);
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path=
);
> +
> +       return TRUE;
> +}
> +
> +static gboolean get_transport(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct asha_device *asha =3D data;
> +       const char *path;
> +
> +       path =3D media_transport_get_path(asha->transport);
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path=
);
> +
> +       return TRUE;
> +}
> +
> +static int asha_source_device_probe(struct btd_service *service)
> +{
> +       struct asha_device *asha;
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("Probing ASHA device %s", addr);
> +
> +       asha =3D asha_device_new();
> +       asha->device =3D device;
> +
> +       btd_service_set_user_data(service, asha);
> +
> +       return 0;
> +}
> +
> +static void asha_source_device_remove(struct btd_service *service)
> +{
> +       struct asha_device *asha;
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("Removing ASHA device %s", addr);
> +
> +       asha =3D btd_service_get_user_data(service);
> +       if (!asha) {
> +               // Can this actually happen?
> +               DBG("Not handlihng ASHA profile");
> +               return;
> +       }
> +
> +       asha_device_free(asha);
> +}
> +
> +static const GDBusMethodTable asha_ep_methods[] =3D {
> +       { },
> +};
> +
> +static const GDBusPropertyTable asha_ep_properties[] =3D {
> +       { "UUID", "s", get_uuid, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { "Side", "s", get_side, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { "Binaural", "b", get_binaural, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { "HiSyncId", "ay", get_hisyncid, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { "Codecs", "q", get_codecs, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },

Codec?

> +       { "Device", "o", get_device, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { "Transport", "o", get_transport, NULL, NULL,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
> +       { }
> +};
> +
> +static void asha_source_endpoint_register(struct asha_device *asha)
> +{
> +       char *path;
> +       const struct media_endpoint *asha_ep;
> +
> +       path =3D make_endpoint_path(asha);
> +       if (!path)
> +               goto error;
> +
> +       if (g_dbus_register_interface(btd_get_dbus_connection(),
> +                               path, MEDIA_ENDPOINT_INTERFACE,
> +                               asha_ep_methods, NULL,
> +                               asha_ep_properties,
> +                               asha, NULL) =3D=3D FALSE) {
> +               error("Could not register remote ep %s", path);
> +               goto error;
> +       }
> +
> +       asha_ep =3D media_endpoint_get_asha();
> +       asha->transport =3D media_transport_create(asha->device, path, NU=
LL, 0,
> +                       (void *) asha_ep, asha);
> +
> +error:
> +       if (path)
> +               free(path);
> +       return;
> +}
> +
> +static void asha_source_endpoint_unregister(struct asha_device *asha)
> +{
> +       char *path;
> +
> +       path =3D make_endpoint_path(asha);
> +       if (!path)
> +               goto error;
> +
> +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> +                               path, MEDIA_ENDPOINT_INTERFACE);
> +
> +       if (asha->transport) {
> +               media_transport_destroy(asha->transport);
> +               asha->transport =3D NULL;
> +       }
> +
> +error:
> +       if (path)
> +               free(path);
> +}
> +
> +static int asha_source_accept(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct gatt_db *db =3D btd_device_get_gatt_db(device);
> +       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> +       struct asha_device *asha =3D btd_service_get_user_data(service);
> +       bt_uuid_t asha_uuid;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("Accepting ASHA connection on %s", addr);
> +
> +       if (!asha) {
> +               // Can this actually happen?
> +               DBG("Not handling ASHA profile");
> +               return -1;
> +       }
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
> +               asha_device_reset(asha);
> +               return -1;
> +       }
> +
> +       asha_source_endpoint_register(asha);
> +
> +       btd_service_connecting_complete(service, 0);
> +
> +       return 0;
> +}
> +
> +static int asha_source_disconnect(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct gatt_db *db =3D btd_device_get_gatt_db(device);
> +       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> +       struct asha_device *asha =3D btd_service_get_user_data(service);
> +       bt_uuid_t asha_uuid;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("Disconnecting ASHA on %s", addr);
> +
> +       if (!asha) {
> +               // Can this actually happen?
> +               DBG("Not handlihng ASHA profile");
> +               return -1;
> +       }
> +
> +       asha_source_endpoint_unregister(asha);
> +       asha_device_reset(asha);
> +
> +       btd_service_disconnecting_complete(service, 0);
> +
> +       return 0;
> +}
> +
> +static struct btd_profile asha_source_profile =3D {
> +       .name           =3D "asha-source",
> +       .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> +       .remote_uuid    =3D ASHA_PROFILE_UUID,
> +       .experimental   =3D true,
> +
> +       .device_probe   =3D asha_source_device_probe,
> +       .device_remove  =3D asha_source_device_remove,
> +
> +       .auto_connect   =3D true,
> +       .accept         =3D asha_source_accept,
> +       .disconnect     =3D asha_source_disconnect,
> +};
> +
> +static int asha_init(void)
> +{
> +       int err;
> +
> +       err =3D btd_profile_register(&asha_source_profile);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static void asha_exit(void)
> +{
> +       btd_profile_unregister(&asha_source_profile);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(asha, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT=
,
> +                                                       asha_init, asha_e=
xit)
> diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
> new file mode 100644
> index 000000000..0fc28e8a3
> --- /dev/null
> +++ b/profiles/audio/asha.h
> @@ -0,0 +1,34 @@
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
> +#include <stdint.h>
> +
> +struct asha_device;
> +
> +typedef enum {
> +       ASHA_STOPPED =3D 0,
> +       ASHA_STARTING,
> +       ASHA_STARTED,
> +       ASHA_STOPPING,
> +} asha_state_t;
> +
> +typedef void (*asha_cb_t)(int status, void *data);
> +
> +uint16_t asha_device_get_render_delay(struct asha_device *asha);
> +asha_state_t asha_device_get_state(struct asha_device *asha);
> +int asha_device_get_fd(struct asha_device *asha);
> +uint16_t asha_device_get_mtu(struct asha_device *asha);
> +
> +unsigned int asha_device_start(struct asha_device *asha, asha_cb_t cb,
> +               void *user_data);
> +unsigned int asha_device_stop(struct asha_device *asha, asha_cb_t cb,
> +               void *user_data);

I'd suggest we split the protocol portion from the plugin and put it
under src/shared so we can do unit testing without the D-Bus blocks,
Id got with bt_asha for instance name, we can do it later if you don't
feel like it is necessary right now.

> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 07147a25d..68ce2f17c 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -44,6 +44,7 @@
>  #include "src/shared/bap.h"
>  #include "src/shared/bap-debug.h"
>
> +#include "asha.h"
>  #include "avdtp.h"
>  #include "media.h"
>  #include "transport.h"
> @@ -88,6 +89,7 @@ struct endpoint_request {
>  struct media_endpoint {
>         struct a2dp_sep         *sep;
>         struct bt_bap_pac       *pac;
> +       struct asha_device      *asha;
>         char                    *sender;        /* Endpoint DBus bus id *=
/
>         char                    *path;          /* Endpoint object path *=
/
>         char                    *uuid;          /* Endpoint property UUID=
 */
> @@ -1329,6 +1331,12 @@ static bool endpoint_init_broadcast_sink(struct me=
dia_endpoint *endpoint,
>         return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
>  }
>
> +static bool endpoint_init_asha(struct media_endpoint *endpoint,
> +                                               int *err)
> +{
> +       return true;
> +}
> +
>  static bool endpoint_properties_exists(const char *uuid,
>                                                 struct btd_device *dev,
>                                                 void *user_data)
> @@ -1453,6 +1461,11 @@ static bool experimental_bcast_sink_ep_supported(s=
truct btd_adapter *adapter)
>         return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
>  }
>
> +static bool experimental_asha_supported(struct btd_adapter *adapter)
> +{
> +       return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
> +}
> +
>  static const struct media_endpoint_init {
>         const char *uuid;
>         bool (*func)(struct media_endpoint *endpoint, int *err);
> @@ -1470,6 +1483,8 @@ static const struct media_endpoint_init {
>                         experimental_broadcaster_ep_supported },
>         { BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
>                         experimental_bcast_sink_ep_supported },
> +       { ASHA_PROFILE_UUID, endpoint_init_asha,
> +                       experimental_asha_supported },
>  };
>
>  static struct media_endpoint *
> @@ -3392,3 +3407,16 @@ bool media_endpoint_is_broadcast(struct media_endp=
oint *endpoint)
>
>         return false;
>  }
> +
> +const struct media_endpoint *media_endpoint_get_asha()
> +{
> +       // Because ASHA does not require the application to register an
> +       // endpoint, we need a minimal media_endpoint for transport creat=
ion to
> +       // work, so let's create one
> +       static struct media_endpoint asha_endpoint =3D  {
> +               .uuid =3D ASHA_PROFILE_UUID,
> +               .codec =3D 0x2, /* Currently on G.722 is defined by the s=
pec */
> +       };
> +
> +       return &asha_endpoint;
> +}
> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
> index 2b579877b..68c57cfc3 100644
> --- a/profiles/audio/media.h
> +++ b/profiles/audio/media.h
> @@ -24,3 +24,5 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
>                                         struct media_endpoint *endpoint);
>  bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
>  int8_t media_player_get_device_volume(struct btd_device *device);
> +
> +const struct media_endpoint *media_endpoint_get_asha();
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 159fbd575..a104d27c0 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -37,6 +37,7 @@
>  #include "src/shared/bap.h"
>  #include "src/shared/io.h"
>
> +#include "asha.h"
>  #include "avdtp.h"
>  #include "media.h"
>  #include "transport.h"
> @@ -90,6 +91,10 @@ struct bap_transport {
>         guint                   resume_id;
>  };
>
> +struct asha_transport {
> +       uint16_t                delay;
> +};
> +
>  struct media_transport_ops {
>         const char *uuid;
>         const GDBusPropertyTable *properties;
> @@ -115,7 +120,7 @@ struct media_transport {
>         char                    *path;          /* Transport object path =
*/
>         struct btd_device       *device;        /* Transport device */
>         struct btd_adapter      *adapter;       /* Transport adapter bcas=
t*/
> -       const char              *remote_endpoint; /* Transport remote SEP=
 */
> +       char                    *remote_endpoint; /* Transport remote SEP=
 */
>         struct media_endpoint   *endpoint;      /* Transport endpoint */
>         struct media_owner      *owner;         /* Transport owner */
>         uint8_t                 *configuration; /* Transport configuratio=
n */
> @@ -219,6 +224,9 @@ void media_transport_destroy(struct media_transport *=
transport)
>         g_dbus_unregister_interface(btd_get_dbus_connection(), path,
>                                                 MEDIA_TRANSPORT_INTERFACE=
);
>
> +       if (transport->remote_endpoint)
> +               g_free(transport->remote_endpoint);
> +
>         g_free(path);
>  }
>
> @@ -1199,6 +1207,32 @@ static const GDBusPropertyTable transport_bap_bc_p=
roperties[] =3D {
>         { }
>  };
>
> +static gboolean get_asha_delay(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_transport *transport =3D data;
> +       struct asha_device *asha =3D transport->data;
> +       uint16_t delay;
> +
> +       // Delay property is in 1/10ths of ms, while ASHA RenderDelay is =
in ms
> +       delay =3D asha_device_get_render_delay(asha) * 10;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &delay);
> +
> +       return TRUE;
> +}
> +
> +static const GDBusPropertyTable transport_asha_properties[] =3D {
> +       { "Device", "o", get_device },
> +       { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
> +       { "UUID", "s", get_uuid },
> +       { "Codec", "y", get_codec },
> +       { "State", "s", get_state },
> +       { "Delay", "q", get_asha_delay },
> +       { "Volume", "q", get_volume, set_volume, volume_exists },
> +       { }
> +};
> +
>  static void transport_a2dp_destroy(void *data)
>  {
>         struct a2dp_transport *a2dp =3D data;
> @@ -1713,6 +1747,106 @@ static void *transport_bap_init(struct media_tran=
sport *transport, void *stream)
>         return bap;
>  }
>
> +static void asha_transport_sync_state(struct media_transport *transport,
> +               struct asha_device *asha)
> +{
> +       switch (asha_device_get_state(asha)) {
> +               case ASHA_STOPPED:
> +                       transport_set_state(transport, TRANSPORT_STATE_ID=
LE);
> +                       break;
> +               case ASHA_STARTING:
> +                       transport_set_state(transport, TRANSPORT_STATE_RE=
QUESTING);
> +                       break;
> +               case ASHA_STARTED:
> +                       transport_set_state(transport, TRANSPORT_STATE_AC=
TIVE);
> +                       break;
> +               case ASHA_STOPPING:
> +                       transport_set_state(transport, TRANSPORT_STATE_SU=
SPENDING);
> +                       break;
> +       }
> +}
> +
> +static void asha_transport_state_cb(int status, void *user_data)
> +{
> +       struct media_owner *owner =3D user_data;
> +       struct media_transport *transport =3D owner->transport;
> +       struct asha_device *asha =3D transport->data;
> +       asha_state_t state;
> +
> +       state =3D asha_device_get_state(asha);
> +
> +       if (state =3D=3D ASHA_STARTED) {
> +               int fd;
> +               uint16_t imtu, omtu;
> +               gboolean ret;
> +
> +               fd =3D asha_device_get_fd(asha);
> +               imtu =3D omtu =3D asha_device_get_mtu(asha);
> +
> +               media_transport_set_fd(transport, fd, imtu, omtu);
> +
> +               owner->pending->id =3D 0;
> +               ret =3D g_dbus_send_reply(btd_get_dbus_connection(),
> +                               owner->pending->msg,
> +                               DBUS_TYPE_UNIX_FD, &fd,
> +                               DBUS_TYPE_UINT16, &imtu,
> +                               DBUS_TYPE_UINT16, &omtu,
> +                               DBUS_TYPE_INVALID);
> +               if (!ret) {
> +                       media_transport_remove_owner(transport);
> +                       return;
> +               }
> +
> +               media_owner_remove(owner);
> +       } else if (state =3D=3D ASHA_STOPPED) {
> +               if (owner->pending) {
> +                       owner->pending->id =3D 0;
> +                       media_request_reply(owner->pending, 0);
> +                       media_owner_remove(owner);
> +               }
> +
> +               media_transport_remove_owner(transport);
> +       }
> +
> +       asha_transport_sync_state(transport, asha);
> +}
> +
> +static guint transport_asha_resume(struct media_transport *transport,
> +                               struct media_owner *owner)
> +{
> +       struct asha_device *asha =3D transport->data;
> +       guint ret;
> +
> +       ret =3D asha_device_start(asha, asha_transport_state_cb, owner);
> +       asha_transport_sync_state(transport, asha);
> +
> +       return ret;
> +}
> +
> +static guint transport_asha_suspend(struct media_transport *transport,
> +                               struct media_owner *owner)
> +{
> +       struct asha_device *asha =3D transport->data;
> +       guint ret =3D 0;
> +
> +       if (owner) {
> +               ret =3D asha_device_stop(asha, asha_transport_state_cb, o=
wner);
> +               asha_transport_sync_state(transport, asha);
> +       } else {
> +               ret =3D asha_device_stop(asha, NULL, NULL);
> +               // We won't have a callback to set the final state
> +               transport_set_state(transport, TRANSPORT_STATE_IDLE);
> +       }
> +
> +       return ret;
> +}
> +
> +static void *transport_asha_init(struct media_transport *transport, void=
 *data)
> +{
> +       /* We just store the struct asha_device on the transport */
> +       return data;
> +}
> +
>  #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>                       _resume, _suspend, _cancel, _set_state, _get_stream=
, \
>                       _get_volume, _set_volume, _destroy) \
> @@ -1754,6 +1888,14 @@ static void *transport_bap_init(struct media_trans=
port *transport, void *stream)
>  #define BAP_BC_OPS(_uuid) \
>         BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
>
> +#define ASHA_OPS(_uuid) \
> +       TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
> +                       transport_asha_init, \
> +                       transport_asha_resume, transport_asha_suspend, \
> +                       NULL, NULL, NULL, \
> +                       NULL, NULL, \
> +                       NULL)
> +
>  static const struct media_transport_ops transport_ops[] =3D {
>         A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
>                         transport_a2dp_src_set_volume,
> @@ -1765,6 +1907,7 @@ static const struct media_transport_ops transport_o=
ps[] =3D {
>         BAP_UC_OPS(PAC_SINK_UUID),
>         BAP_BC_OPS(BCAA_SERVICE_UUID),
>         BAP_BC_OPS(BAA_SERVICE_UUID),
> +       ASHA_OPS(ASHA_PROFILE_UUID),
>  };
>
>  static const struct media_transport_ops *
> @@ -1802,7 +1945,7 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>         transport->endpoint =3D endpoint;
>         transport->configuration =3D util_memdup(configuration, size);
>         transport->size =3D size;
> -       transport->remote_endpoint =3D remote_endpoint;
> +       transport->remote_endpoint =3D g_strdup(remote_endpoint);
>
>         if (device)
>                 transport->path =3D g_strdup_printf("%s/fd%d",
> --
> 2.45.0

Otherwise it looks pretty good.


--=20
Luiz Augusto von Dentz
