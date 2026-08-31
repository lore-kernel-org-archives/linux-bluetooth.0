Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6156372046
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209976; cv=pass; b=d7aHoTJZZKl8VbTb1lOQ6+iG7toJMEng2nxWqFCESnzZSP+nDFFc6f0+BBxDPAWZvYFs4XWbpE7UotOiR/puSoAhjuYHARFCwN4iNjr/wZMJQsth5WoJPjNh2EGqlhw3uX5/xTHSKT+gP8ElmFwNVhShKDkcCWpzTwwlyJ74xJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209976; c=relaxed/simple;
	bh=G5nqvZ9bzR3QWjPHSF8y+l+7BcfDDAqAmeF8Qk74LKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP0OsupBiaCeLRpHthqRZ5+x0Xh/wJss76l9/4tJHgOVmGf8GT+vKv/yMKdNPsdFqmtR0mT52zYBfV3PtMASTWdIVWx6ol5D/qnER69svpgAJpd1VOJUaBSHt0w7zbcA9mNpHubxh5YNw/CoBvSLeOc8jx7l3xree6cBLzxFpXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMaGiioz; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMaGiioz"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-866e57f63a3so2068117b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 13:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788209971; cv=none;
        d=google.com; s=arc-20260327;
        b=kH3FUQxQcPGEgBUFHLQI/RYYX8cMOlET2ICT3CUd//0A4BHIuMgxOdWcR28/dVAlrv
         0euuy7RIPkplGHo7SSzgAmAnXilQMRrU16xTvfK6zn5kOCMTkxvJgxfMyzZn6jzTk7Zj
         yEYBdCz38Y+sxwzdA4u3vAQikiz9D/fVnkKqb0CNy+RZ0G46YPU0ec8BJA8qLWY55baL
         qSBSjlsF1I20b0AkGQ4M7UNWjZ6z/Fr+dtNqMNR9wpy4+TMJEFsr7cuSC53nak8HXw2W
         qgUlJmg3AjkW527Qluymc0GmIFHYZTP4j8RQrTKaxyGYlVE+/ZtkdmDEcMiivjKz28+H
         +Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uumF64NUDfVQaGMVnm5EhrJO7nOTLm7HTGvNHgSCgWs=;
        fh=wExMSkI/OLe1x9hrlv4uso6+dv4dPtsXQ7gBT+vxdrM=;
        b=G8UvVjgmoEaEys7FCFMrFbSngwZH2SKUjoVrZ+WsQexK2BGBxF/Icvb+YhNeEJNZ/f
         mX+ON62+3DbtT+jKFqz2YKP0seVo27F5RLbUk06EK1yZcuNc4BwGvDwrCQnGcryHSz9S
         LgN3MXb751FFU/zQ/F0VG9nvHLdTcUI91Z6bUNT01wWvMHUc1KAHvdMyyjpUI7OR7jWT
         iJcCJK3jTOlTgfxI9vsRiFQWW0r/ynoW7ONC0OiinqDBopGWTokWOY2x6Y3zkO1JqHuX
         PLIApikoEAu3U+exU3aeWEXg5ydXnl4d16e4oD8wMRJ+j0fV7a4k51oKXlSEm6IK/4dA
         +9kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788209971; x=1788814771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uumF64NUDfVQaGMVnm5EhrJO7nOTLm7HTGvNHgSCgWs=;
        b=SMaGiiozkDetM8zE9nct+jEwdZfF+jhd3z3qdoLmX2gSS483gXB3waiXQDS6UPRSYb
         /2r23YBFqRuRWrL+5qgJj+3kYYANLNRAP15mM+O3TS/JUSjvNbwEDDEx9JRzM3Vu+kDe
         Ugqmf85whwme3IWpaFAS3JBfA9zX/KrVspGKsyG/oDDyDwuhKXomjlkvKZux+zZYXLjE
         Q81BC+SKv4K/eO2TblQSYlfHjaTZTFKnFjN6vL7RV6klB6YI9FspWD8fJlVs9P0zSaK3
         10WyCzJYJlsZbtjdbgX8LupNKI6ynHfd0caRh4VMNBJMSjFGMtupnDyFPoWayi/aPthF
         Hjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788209971; x=1788814771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uumF64NUDfVQaGMVnm5EhrJO7nOTLm7HTGvNHgSCgWs=;
        b=mcePnSoU0jnr9VL5O/67K6fE0RYGsXX+d8p4reD9PCYFf0dUo43zEg36cQkgCUFW34
         nkCqqx7hVKIUBCYf9LgcZU2njtug7E51DvI3lWyV/GGP5CwNQ7DFPlFuz1zVmaWz/H72
         4Cr07gGas1PRs8/7UxJCGj8mozp20MZYQEDuvdelAnSlMSb4Job5Jfvujq7FRule4dI8
         5cZdQ31gMCbzac+l6q5mfhmlMQ/Yo+agCLz63E2hxiMmkaqxHbgjCat6QZHEaXQdGUus
         vE/C+11g5hZD6IQMxVNpD190+cNDQG+s0XDqOxcSppAOYb9gh7Qn4HLt55jmSWLLOe5C
         v8aQ==
X-Gm-Message-State: AFuF++mk429KLpa1h1m/D0Q5FiHMXoVHjUaV8R83MNP5SY+ay/U4TsW4
	SzzBlhz/mF9CX1S1s8uodod7+lIwMeQL8g7FOeZkz0+Eu3v6aYGQ3AkyRY14AptC+6BFPEylJQq
	5Z+iKopUWDTedBCucsyonVshFB2gUJKR89QyFBMc=
X-Gm-Gg: AYBFou2UoBlyeLMM+543ZF3qGaROu80gsLD+5PWvZINSJrFXtKxTk6YCCMpuhoGwfZx
	WmCq+PgwsNxCm/JJNh8KWog7rza1M8JNIhdocB8tQ2cT2O93beIghH+DVTM1Mptwn7jMAwnVNqo
	o2Zy6vxmg++ah+PekRbOkQnu61cXR90JvSag3TOwZU4+MQ0h+QbE6/BsgOVrPkodZvOAeKXGpjZ
	8MVaEtSZYsV93EPMjZtWxZWMl2EJEWERZ/tcn3oJRHT7VYjEnIOpY7/2aTByezQS09sNuLf7+Gh
	iTd69N+qRKzd1cU5vJOA0vx9qTU0/5kW1Wh+qaaehLQ3N7CtngqR1SIYuD+pTCN4YYxaSXN3guG
	Kp9HZD5BMcj7LMQv4q+b4XuPv4ie/0Q==
X-Received: by 2002:a05:690c:6611:b0:85a:f3fd:9f2 with SMTP id
 00721157ae682-85d69e01852mr104620817b3.11.1788209971324; Mon, 31 Aug 2026
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803195620.255866-1-jan.brummer@tabos.org>
 <20260831150051.80631-1-jan.brummer@tabos.org> <20260831150051.80631-2-jan.brummer@tabos.org>
In-Reply-To: <20260831150051.80631-2-jan.brummer@tabos.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 16:59:18 -0400
X-Gm-Features: AcwNN1WvrYnqjeLRbMC4iDUNr3U2lcNXeNXVml6c2ojnQOOsQvLy8vCVuvpJNQA
Message-ID: <CABBYNZLsTfczANXyhf8c9L+V0o0Jb8A9=7_Qu8P=wa1F8KL-mA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add cover art support
To: Jan-Michael <jan.brummer@tabos.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan-Michael,

On Mon, Aug 31, 2026 at 4:40=E2=80=AFPM Jan-Michael <jan.brummer@tabos.org>=
 wrote:
>
> From: Jan-Michael Brummer <jan.brummer@tabos.org>
>
> Add bluetooth cover art support based on the existing code.
> Tested with VW head unit and Fairphone 5.
> ---
>  Makefile.plugins           |   4 +-
>  doc/org.bluez.Media.rst    |  21 ++
>  profiles/audio/avrcp-bip.c | 608 +++++++++++++++++++++++++++++++++++++
>  profiles/audio/avrcp-bip.h |  46 +++
>  profiles/audio/avrcp.c     |  92 +++++-
>  profiles/audio/media.c     | 194 ++++++++++++
>  src/bluetooth.conf         |   1 +
>  tools/mpris-proxy.c        |  81 +++++
>  8 files changed, 1041 insertions(+), 6 deletions(-)
>  create mode 100644 profiles/audio/avrcp-bip.c
>  create mode 100644 profiles/audio/avrcp-bip.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index ac667beda..101e6bdc6 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -37,7 +37,9 @@ builtin_modules +=3D avrcp
>  builtin_sources +=3D profiles/audio/control.h profiles/audio/control.c \
>                         profiles/audio/avctp.h profiles/audio/avctp.c \
>                         profiles/audio/avrcp.h profiles/audio/avrcp.c \
> -                       profiles/audio/avrcp-player.c
> +                       profiles/audio/avrcp-player.c \
> +                       profiles/audio/avrcp-bip.h profiles/audio/avrcp-b=
ip.c \
> +                       $(gobex_sources)
>  endif
>
>  if NETWORK
> diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
> index 1352a822d..0c793db58 100644
> --- a/doc/org.bluez.Media.rst
> +++ b/doc/org.bluez.Media.rst
> @@ -91,6 +91,27 @@ MPRIS 2.2 spec:
>
>  http://specifications.freedesktop.org/mpris-spec/latest/
>
> +The object may additionally implement **org.bluez.MediaPlayerCoverArt1**=
 to
> +serve album art to remote AVRCP controllers:
> +
> +.. code-block::
> +
> +       array{byte} GetCoverArt(string url)
> +
> +Called with the value the player last exported as **mpris:artUrl** whene=
ver
> +that value changes. It shall return the image as JPEG data, at most 1 Mi=
B in
> +size; other encodings are ignored by the AVRCP Cover Art responder.
> +
> +The image is passed as bytes rather than read from **mpris:artUrl** dire=
ctly
> +because bluetoothd is sandboxed and cannot access the caches players com=
monly
> +store their artwork in. Players that do not implement this interface sim=
ply do
> +not provide cover art.

It would be much better to expose a file descriptor that bluetoothd
can read directly instead of transferring the whole content over
D-Bus.

> +Possible Errors:
> +
> +:org.bluez.Error.NotSupported:
> +:org.bluez.Error.Failed:
> +
>  Note: If the sender disconnects its objects are automatically unregister=
ed.
>
>  Possible Errors:
> diff --git a/profiles/audio/avrcp-bip.c b/profiles/audio/avrcp-bip.c
> new file mode 100644
> index 000000000..dfd710b5b
> --- /dev/null
> +++ b/profiles/audio/avrcp-bip.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  AVRCP 1.6 Cover Art Responder (BIP over OBEX/L2CAP, Target role)
> + *
> + *  Copyright (C) 2026  tabos.org
> + *
> + *  Implements the "Cover Art Responder" role of the Basic Imaging
> + *  Profile subset defined in AVRCP 1.6 section 5.14. The responder is
> + *  an OBEX server on a dynamic L2CAP PSM (GOEP 2.0, ERTM) which is
> + *  advertised in the AdditionalProtocolDescriptorList of the AVRCP
> + *  Target SDP record. Controllers (e.g. car head units) connect to it
> + *  and fetch the image referenced by media attribute 0x08 (ImgHandle)
> + *  using GetImageProperties, GetLinkedThumbnail and GetImage.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include "bluetooth/bluetooth.h"
> +
> +#include "gobex/gobex.h"

Bas idea to link gobex to bluetoothd, that should really be obexd to
handle the bip session and transfer, otherwise we have to duplicate
the whole obex session management again.

> +#include "btio/btio.h"
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/log.h"

> +#include "avctp.h"
> +#include "avrcp-bip.h"
> +
> +/* OBEX Target UUID for AVRCP Cover Art (AVRCP 1.6, section 5.14.2.1) */
> +static const uint8_t cover_art_target_uuid[] =3D {
> +       0x71, 0x63, 0xDD, 0x54, 0x4A, 0x7E, 0x11, 0xE2,
> +       0xB4, 0x7C, 0x00, 0x50, 0xC2, 0x49, 0x00, 0x48
> +};
> +
> +/* BIP user defined headers */
> +#define BIP_HDR_IMG_HANDLE     0x30    /* Unicode text */
> +#define BIP_HDR_IMG_DESCRIPTOR 0x71    /* Byte sequence */
> +
> +#define BIP_TYPE_CAPABILITIES  "x-bt/img-capabilities"
> +#define BIP_TYPE_PROPERTIES    "x-bt/img-properties"
> +#define BIP_TYPE_IMAGE         "x-bt/img-img"
> +#define BIP_TYPE_THUMBNAIL     "x-bt/img-thm"
> +
> +#define COVER_ART_MAX_IMAGES   4
> +
> +struct cover_image {
> +       char            handle[8];      /* 7 digit handle + NUL */
> +       GBytes          *data;
> +       unsigned int    width;
> +       unsigned int    height;
> +};
> +
> +struct bip_session {
> +       GObex           *obex;
> +       GBytes          *pending;       /* image being transferred */
> +       size_t          offset;
> +       bool            connected;      /* CONNECT with valid target seen=
 */
> +       bdaddr_t        src;            /* local adapter address */
> +       bdaddr_t        dst;            /* peer address */
> +};
> +
> +/*
> + * Candidate PSMs for the responder. The listener is bound to
> + * BDADDR_ANY so it keeps working when the controller address changes
> + * after the first power-on (e.g. controllers that boot with a default
> + * address until the driver programs the real BD_ADDR). Dynamic kernel
> + * PSM allocation cannot be used for a BDADDR_ANY socket: the kernel
> + * only guarantees PSM uniqueness per source address, so the allocated
> + * PSM may collide with the dynamic PSMs handed to the external OBEX
> + * profiles (MNS/MAS/PBAP/...) of src/profile.c, which bind to the
> + * adapter address, and those sockets would then shadow this one. Pick
> + * from a high range instead that neither the kernel allocator nor
> + * profile.c reaches in practice.
> + */
> +static const uint16_t candidate_psms[] =3D {
> +       0x10F1, 0x10F3, 0x10F5, 0x10F7, 0x10F9
> +};

I assume it doesn't need to be a fixed psm, otherwise the spec would
reseve one, beside if you move this over to obexd then all the logic
of OBEX profiles is reused.

> +static GIOChannel *server_io;
> +static uint16_t server_psm;
> +static unsigned int server_ref;
> +static uint32_t next_handle =3D 1;
> +static GSList *images;         /* struct cover_image, newest first */
> +static GSList *sessions;       /* struct bip_session */
> +
> +static bool session_has_avrcp(struct bip_session *session);
> +
> +/*
> + * Minimal JPEG SOFn parser to extract the pixel dimensions for the
> + * image-properties object. Returns false if the data doesn't look
> + * like a JPEG image.
> + */
> +static bool jpeg_get_size(const uint8_t *data, size_t len,
> +                               unsigned int *width, unsigned int *height=
)
> +{
> +       size_t i;
> +
> +       if (len < 4 || data[0] !=3D 0xff || data[1] !=3D 0xd8)
> +               return false;
> +
> +       i =3D 2;
> +       while (i + 9 < len) {
> +               uint8_t marker;
> +               uint16_t seglen;
> +
> +               if (data[i] !=3D 0xff) {
> +                       i++;
> +                       continue;
> +               }
> +
> +               marker =3D data[i + 1];
> +
> +               /* Standalone markers without length field */
> +               if (marker =3D=3D 0xff || (marker >=3D 0xd0 && marker <=
=3D 0xd9)) {
> +                       i +=3D 2;
> +                       continue;
> +               }
> +
> +               seglen =3D (data[i + 2] << 8) | data[i + 3];
> +               if (seglen < 2)
> +                       return false;
> +
> +               /* SOF0..SOF15 except DHT(C4)/JPG(C8)/DAC(CC) */
> +               if (marker >=3D 0xc0 && marker <=3D 0xcf && marker !=3D 0=
xc4 &&
> +                               marker !=3D 0xc8 && marker !=3D 0xcc) {
> +                       if (i + 9 >=3D len)
> +                               return false;
> +                       *height =3D (data[i + 5] << 8) | data[i + 6];
> +                       *width =3D (data[i + 7] << 8) | data[i + 8];
> +                       return true;
> +               }
> +
> +               i +=3D 2 + seglen;
> +       }
> +
> +       return false;
> +}
> +
> +static void cover_image_free(void *data)
> +{
> +       struct cover_image *img =3D data;
> +
> +       g_bytes_unref(img->data);
> +       g_free(img);
> +}
> +
> +static struct cover_image *find_image(const char *handle)
> +{
> +       GSList *l;
> +
> +       for (l =3D images; l; l =3D l->next) {
> +               struct cover_image *img =3D l->data;
> +
> +               if (g_str_equal(img->handle, handle))
> +                       return img;
> +       }
> +
> +       return NULL;
> +}
> +
> +const char *avrcp_bip_set_cover_art(const uint8_t *data, size_t len)
> +{
> +       struct cover_image *img;
> +       unsigned int width =3D 0, height =3D 0;
> +
> +       if (data =3D=3D NULL || len =3D=3D 0)
> +               return NULL;
> +
> +       if (!jpeg_get_size(data, len, &width, &height)) {
> +               DBG("cover art is not a valid JPEG image");
> +               return NULL;
> +       }
> +
> +       img =3D g_new0(struct cover_image, 1);
> +       snprintf(img->handle, sizeof(img->handle), "%07u",
> +                                       next_handle++ % 10000000);
> +       img->data =3D g_bytes_new(data, len);
> +       img->width =3D width;
> +       img->height =3D height;
> +
> +       images =3D g_slist_prepend(images, img);
> +
> +       /* Keep a short tail so a controller can still fetch the
> +        * previous image right after a track change.
> +        */
> +       while (g_slist_length(images) > COVER_ART_MAX_IMAGES) {
> +               GSList *last =3D g_slist_last(images);
> +
> +               cover_image_free(last->data);
> +               images =3D g_slist_delete_link(images, last);
> +       }
> +
> +       DBG("handle %s (%zu bytes, %ux%u)", img->handle, len, width, heig=
ht);
> +
> +       return img->handle;
> +}
> +
> +void avrcp_bip_clear_cover_art(void)
> +{
> +       g_slist_free_full(images, cover_image_free);
> +       images =3D NULL;
> +}
> +
> +static void session_free(struct bip_session *session)
> +{
> +       sessions =3D g_slist_remove(sessions, session);
> +
> +       if (session->pending)
> +               g_bytes_unref(session->pending);
> +
> +       if (session->obex)
> +               g_obex_unref(session->obex);
> +
> +       g_free(session);
> +}
> +
> +static void disconn_func(GObex *obex, GError *err, gpointer user_data)
> +{
> +       struct bip_session *session =3D user_data;
> +
> +       DBG("BIP session disconnected");
> +
> +       session_free(session);
> +}
> +
> +static char *packet_get_type(GObexPacket *req)
> +{
> +       GObexHeader *hdr;
> +       const guint8 *type;
> +       gsize len;
> +
> +       hdr =3D g_obex_packet_get_header(req, G_OBEX_HDR_TYPE);
> +       if (hdr =3D=3D NULL)
> +               return NULL;
> +
> +       if (!g_obex_header_get_bytes(hdr, &type, &len) || len =3D=3D 0)
> +               return NULL;
> +
> +       /* Type header is a NUL terminated ASCII string */
> +       return g_strndup((const char *) type, len);
> +}
> +
> +static char *packet_get_img_handle(GObexPacket *req)
> +{
> +       GObexHeader *hdr;
> +       const char *handle;
> +
> +       hdr =3D g_obex_packet_get_header(req, BIP_HDR_IMG_HANDLE);
> +       if (hdr =3D=3D NULL)
> +               return NULL;
> +
> +       if (!g_obex_header_get_unicode(hdr, &handle))
> +               return NULL;
> +
> +       return g_strdup(handle);
> +}
> +
> +static void connect_func(GObex *obex, GObexPacket *req, gpointer user_da=
ta)
> +{
> +       struct bip_session *session =3D user_data;
> +       GObexHeader *hdr;
> +       const guint8 *target;
> +       gsize len;
> +       GError *err =3D NULL;
> +
> +       hdr =3D g_obex_packet_get_header(req, G_OBEX_HDR_TARGET);
> +       if (hdr =3D=3D NULL || !g_obex_header_get_bytes(hdr, &target, &le=
n) ||
> +                       len !=3D sizeof(cover_art_target_uuid) ||
> +                       memcmp(target, cover_art_target_uuid, len) !=3D 0=
) {
> +               g_obex_send_rsp(obex, G_OBEX_RSP_NOT_ACCEPTABLE, NULL,
> +                                                       G_OBEX_HDR_INVALI=
D);
> +               return;
> +       }
> +
> +       session->connected =3D true;
> +
> +       DBG("Cover Art OBEX session connected");
> +
> +       /* gobex fills in version/flags/mpl and the Connection ID */
> +       g_obex_send_rsp(obex, G_OBEX_RSP_SUCCESS, &err,
> +                       G_OBEX_HDR_WHO, cover_art_target_uuid,
> +                       sizeof(cover_art_target_uuid),
> +                       G_OBEX_HDR_INVALID);
> +
> +       if (err !=3D NULL) {
> +               error("Cover Art CONNECT rsp: %s", err->message);
> +               g_error_free(err);
> +       }
> +}
> +
> +static void disconnect_func(GObex *obex, GObexPacket *req, gpointer user=
_data)
> +{
> +       g_obex_send_rsp(obex, G_OBEX_RSP_SUCCESS, NULL, G_OBEX_HDR_INVALI=
D);
> +}
> +
> +static gssize pending_data_producer(void *buf, gsize len, gpointer user_=
data)
> +{
> +       struct bip_session *session =3D user_data;
> +       gsize size, remaining;
> +       const uint8_t *data;
> +
> +       if (session->pending =3D=3D NULL)
> +               return 0;
> +
> +       data =3D g_bytes_get_data(session->pending, &size);
> +
> +       if (session->offset >=3D size)
> +               remaining =3D 0;
> +       else
> +               remaining =3D size - session->offset;
> +
> +       if (remaining =3D=3D 0) {
> +               g_bytes_unref(session->pending);
> +               session->pending =3D NULL;
> +               session->offset =3D 0;
> +               return 0;
> +       }
> +
> +       len =3D MIN(len, remaining);
> +       memcpy(buf, data + session->offset, len);
> +       session->offset +=3D len;
> +
> +       return len;
> +}
> +
> +static void transfer_complete(GObex *obex, GError *err, gpointer user_da=
ta)
> +{
> +       struct bip_session *session =3D user_data;
> +
> +       if (err !=3D NULL)
> +               DBG("Cover Art transfer failed: %s", err->message);
> +
> +       if (session->pending) {
> +               g_bytes_unref(session->pending);
> +               session->pending =3D NULL;
> +       }
> +
> +       session->offset =3D 0;
> +}
> +
> +static void respond_with_bytes(struct bip_session *session, GBytes *byte=
s,
> +                                                       gboolean with_len=
gth)
> +{
> +       GError *err =3D NULL;
> +       gsize size;
> +
> +       g_bytes_get_data(bytes, &size);
> +
> +       if (session->pending)
> +               g_bytes_unref(session->pending);
> +
> +       session->pending =3D g_bytes_ref(bytes);
> +       session->offset =3D 0;
> +
> +       if (with_length)
> +               g_obex_get_rsp(session->obex, pending_data_producer,
> +                               transfer_complete, session, &err,
> +                               G_OBEX_HDR_LENGTH, (guint32) size,
> +                               G_OBEX_HDR_INVALID);
> +       else
> +               g_obex_get_rsp(session->obex, pending_data_producer,
> +                               transfer_complete, session, &err,
> +                               G_OBEX_HDR_INVALID);
> +
> +       if (err !=3D NULL) {
> +               error("Cover Art GET rsp: %s", err->message);
> +               g_error_free(err);
> +               g_bytes_unref(session->pending);
> +               session->pending =3D NULL;
> +       }
> +}
> +
> +static void get_image_properties(struct bip_session *session,
> +                                               struct cover_image *img)
> +{
> +       GString *xml;
> +       GBytes *bytes;
> +       gsize size;
> +       char *str;
> +
> +       g_bytes_get_data(img->data, &size);
> +
> +       xml =3D g_string_new("");
> +       g_string_append_printf(xml,
> +               "<image-properties version=3D\"1.0\" handle=3D\"%s\">\r\n=
"
> +               "<native encoding=3D\"JPEG\" pixel=3D\"%u*%u\" size=3D\"%=
zu\"/>\r\n"
> +               "<variant encoding=3D\"JPEG\" pixel=3D\"200*200\"/>\r\n"
> +               "</image-properties>\r\n",
> +               img->handle, img->width, img->height, size);
> +
> +       str =3D g_string_free(xml, FALSE);
> +       bytes =3D g_bytes_new_take(str, strlen(str));
> +
> +       respond_with_bytes(session, bytes, FALSE);
> +       g_bytes_unref(bytes);
> +}
> +
> +static void get_func(GObex *obex, GObexPacket *req, gpointer user_data)
> +{
> +       struct bip_session *session =3D user_data;
> +       struct cover_image *img =3D NULL;
> +       char *type, *handle;
> +
> +       if (!session->connected || !session_has_avrcp(session)) {
> +               g_obex_send_rsp(obex, G_OBEX_RSP_FORBIDDEN, NULL,
> +                                                       G_OBEX_HDR_INVALI=
D);
> +               return;
> +       }
> +
> +       type =3D packet_get_type(req);
> +       if (type =3D=3D NULL) {
> +               g_obex_send_rsp(obex, G_OBEX_RSP_BAD_REQUEST, NULL,
> +                                                       G_OBEX_HDR_INVALI=
D);
> +               return;
> +       }
> +
> +       handle =3D packet_get_img_handle(req);
> +
> +       DBG("type %s handle %s", type, handle ? handle : "(none)");
> +
> +       if (handle !=3D NULL)
> +               img =3D find_image(handle);
> +       else if (images !=3D NULL)
> +               img =3D images->data;     /* newest */
> +
> +       if (img =3D=3D NULL) {
> +               g_obex_send_rsp(obex, G_OBEX_RSP_NOT_FOUND, NULL,
> +                                                       G_OBEX_HDR_INVALI=
D);
> +               goto done;
> +       }
> +
> +       if (g_str_equal(type, BIP_TYPE_PROPERTIES)) {
> +               get_image_properties(session, img);
> +       } else if (g_str_equal(type, BIP_TYPE_THUMBNAIL)) {
> +               /*
> +                * BIP mandates a 200x200 baseline JPEG thumbnail. We
> +                * hand out the native image; head units tested (VW MIB)
> +                * scale it themselves. Players should provide a
> +                * reasonably sized JPEG via mpris:artUrl.
> +                */
> +               respond_with_bytes(session, img->data, FALSE);
> +       } else if (g_str_equal(type, BIP_TYPE_IMAGE)) {
> +               respond_with_bytes(session, img->data, TRUE);
> +       } else {
> +               g_obex_send_rsp(obex, G_OBEX_RSP_NOT_IMPLEMENTED, NULL,
> +                                                       G_OBEX_HDR_INVALI=
D);
> +       }
> +
> +done:
> +       g_free(type);
> +       g_free(handle);
> +}
> +
> +static void bip_connect_cb(GIOChannel *io, GError *gerr, gpointer user_d=
ata)
> +{
> +       struct bip_session *session;
> +       GObex *obex;
> +
> +       if (gerr !=3D NULL) {
> +               error("Cover Art accept: %s", gerr->message);
> +               return;
> +       }
> +
> +       obex =3D g_obex_new(io, G_OBEX_TRANSPORT_PACKET, -1, -1);
> +       if (obex =3D=3D NULL) {
> +               g_io_channel_shutdown(io, TRUE, NULL);
> +               return;
> +       }
> +
> +       session =3D g_new0(struct bip_session, 1);
> +       session->obex =3D obex;
> +
> +       bt_io_get(io, NULL, BT_IO_OPT_SOURCE_BDADDR, &session->src,
> +                       BT_IO_OPT_DEST_BDADDR, &session->dst,
> +                       BT_IO_OPT_INVALID);
> +
> +       sessions =3D g_slist_prepend(sessions, session);
> +
> +       g_obex_set_disconnect_function(obex, disconn_func, session);
> +       g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, connect_func=
,
> +                                                               session);
> +       g_obex_add_request_function(obex, G_OBEX_OP_DISCONNECT,
> +                                               disconnect_func, session)=
;
> +       g_obex_add_request_function(obex, G_OBEX_OP_GET, get_func, sessio=
n);
> +
> +       DBG("Cover Art transport connected");
> +}
> +
> +/*
> + * AVRCP 1.6 section 5.14.2.2: the Cover Art OBEX connection is only
> + * valid while an AVRCP (AVCTP) connection exists between the same
> + * devices. This is enforced when image data is requested rather than
> + * when the transport is set up: head units establish the OBEX channel
> + * in parallel with AVCTP during the initial connection burst, so the
> + * AVCTP session may not be registered yet when the transport comes
> + * in, and rejecting it at that point makes controllers give up on
> + * cover art until the next connection.
> + */
> +static bool session_has_avrcp(struct bip_session *session)
> +{
> +       struct btd_adapter *adapter;
> +       struct btd_device *device;
> +
> +       adapter =3D adapter_find(&session->src);
> +       if (adapter =3D=3D NULL)
> +               return false;
> +
> +       device =3D btd_adapter_find_device(adapter, &session->dst,
> +                                                               BDADDR_BR=
EDR);
> +       if (device =3D=3D NULL || avctp_get(device) =3D=3D NULL) {
> +               DBG("Peer has no AVRCP session");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static void bip_confirm_cb(GIOChannel *io, gpointer user_data)
> +{
> +       GError *gerr =3D NULL;
> +
> +       if (!bt_io_accept(io, bip_connect_cb, NULL, NULL, &gerr)) {
> +               error("Cover Art bt_io_accept: %s", gerr->message);
> +               g_error_free(gerr);
> +               g_io_channel_shutdown(io, TRUE, NULL);
> +       }
> +}
> +
> +uint16_t avrcp_bip_server_start(void)
> +{
> +       size_t i;
> +
> +       if (server_io !=3D NULL) {
> +               server_ref++;
> +               return server_psm;
> +       }
> +
> +       for (i =3D 0; i < G_N_ELEMENTS(candidate_psms); i++) {
> +               GError *gerr =3D NULL;
> +
> +               server_io =3D bt_io_listen(NULL, bip_confirm_cb, NULL, NU=
LL,
> +                               &gerr,
> +                               BT_IO_OPT_PSM, candidate_psms[i],
> +                               BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
> +                               BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +                               BT_IO_OPT_INVALID);
> +               if (server_io !=3D NULL) {
> +                       server_psm =3D candidate_psms[i];
> +                       break;
> +               }
> +
> +               DBG("Cover Art responder PSM 0x%04x: %s",
> +                               candidate_psms[i], gerr->message);
> +               g_error_free(gerr);
> +       }
> +
> +       if (server_io =3D=3D NULL) {
> +               error("Cover Art responder: no free PSM");
> +               return 0;
> +       }
> +
> +       server_ref =3D 1;
> +
> +       DBG("Cover Art responder listening on PSM 0x%04x", server_psm);
> +
> +       return server_psm;
> +}
> +
> +void avrcp_bip_server_stop(void)
> +{
> +       if (server_io =3D=3D NULL)
> +               return;
> +
> +       if (--server_ref > 0)
> +               return;
> +
> +       while (sessions !=3D NULL)
> +               session_free(sessions->data);
> +
> +       avrcp_bip_clear_cover_art();
> +
> +       g_io_channel_shutdown(server_io, TRUE, NULL);
> +       g_io_channel_unref(server_io);
> +       server_io =3D NULL;
> +       server_psm =3D 0;
> +}
> +
> +bool avrcp_bip_server_active(void)
> +{
> +       return server_io !=3D NULL;
> +}
> +
> +uint16_t avrcp_bip_server_get_psm(void)
> +{
> +       return server_psm;
> +}
> diff --git a/profiles/audio/avrcp-bip.h b/profiles/audio/avrcp-bip.h
> new file mode 100644
> index 000000000..ce7f80a26
> --- /dev/null
> +++ b/profiles/audio/avrcp-bip.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  AVRCP 1.6 Cover Art Responder (BIP over OBEX/L2CAP, Target role)
> + *
> + *  Copyright (C) 2026  tabos.org
> + *
> + */
> +
> +#ifndef __AVRCP_BIP_H
> +#define __AVRCP_BIP_H
> +
> +#include <stdint.h>
> +#include <stddef.h>
> +#include <stdbool.h>
> +
> +/*
> + * Start the global BIP Cover Art responder. Reference counted, called
> + * once per adapter using it. Returns the L2CAP PSM the OBEX server is
> + * listening on, or 0 on failure.
> + */
> +uint16_t avrcp_bip_server_start(void);
> +
> +/* Drop one reference; the listener is closed with the last user. */
> +void avrcp_bip_server_stop(void);
> +
> +/* Whether the responder is currently listening. */
> +bool avrcp_bip_server_active(void);
> +
> +/* L2CAP PSM of the running responder (0 if inactive). */
> +uint16_t avrcp_bip_server_get_psm(void);
> +
> +/*
> + * Register the cover art of the current track. The data must be a
> + * complete JPEG image. Returns the 7-digit BIP image handle to be
> + * exposed as media attribute 0x08 (valid until replaced), or NULL
> + * on error.
> + */
> +const char *avrcp_bip_set_cover_art(const uint8_t *data, size_t len);
> +
> +/* Remove all registered images (e.g. on playback stop). */
> +void avrcp_bip_clear_cover_art(void);
> +
> +#endif /* __AVRCP_BIP_H */
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 2194a9135..68f7b9176 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -52,6 +52,7 @@
>
>  #include "avctp.h"
>  #include "avrcp.h"
> +#include "avrcp-bip.h"
>  #include "control.h"
>  #include "media.h"
>  #include "player.h"
> @@ -216,6 +217,7 @@ struct get_total_number_of_items_rsp {
>  struct avrcp_server {
>         struct btd_adapter *adapter;
>         bool browsing;
> +       bool cover_art;
>         uint32_t tg_record_id;
>         uint32_t ct_record_id;
>         GSList *players;
> @@ -484,7 +486,63 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
>         return record;
>  }
>
> -static sdp_record_t *avrcp_tg_record(bool browsing)
> +static void avrcp_tg_add_protos(sdp_record_t *record, sdp_data_t *versio=
n,
> +                                       bool browsing, uint16_t cover_psm=
)
> +{
> +       sdp_list_t *apseq_browsing =3D NULL, *apseq_obex =3D NULL;
> +       uuid_t l2cap, avctp, obex;
> +       sdp_list_t *aproto =3D NULL, *proto[2] =3D { NULL, NULL };
> +       sdp_list_t *oproto[2] =3D { NULL, NULL };
> +       sdp_data_t *psm =3D NULL, *opsm =3D NULL;
> +       uint16_t ap =3D AVCTP_BROWSING_PSM;
> +
> +       if (!browsing && cover_psm =3D=3D 0)
> +               return;
> +
> +       sdp_uuid16_create(&l2cap, L2CAP_UUID);
> +
> +       if (browsing) {
> +               proto[0] =3D sdp_list_append(NULL, &l2cap);
> +               psm =3D sdp_data_alloc(SDP_UINT16, &ap);
> +               proto[0] =3D sdp_list_append(proto[0], psm);
> +               apseq_browsing =3D sdp_list_append(NULL, proto[0]);
> +
> +               sdp_uuid16_create(&avctp, AVCTP_UUID);
> +               proto[1] =3D sdp_list_append(NULL, &avctp);
> +               proto[1] =3D sdp_list_append(proto[1], version);
> +               apseq_browsing =3D sdp_list_append(apseq_browsing, proto[=
1]);
> +
> +               aproto =3D sdp_list_append(aproto, apseq_browsing);
> +       }
> +
> +       /* AVRCP 1.6 section 8: Cover Art OBEX transport entry */
> +       if (cover_psm !=3D 0) {
> +               oproto[0] =3D sdp_list_append(NULL, &l2cap);
> +               opsm =3D sdp_data_alloc(SDP_UINT16, &cover_psm);
> +               oproto[0] =3D sdp_list_append(oproto[0], opsm);
> +               apseq_obex =3D sdp_list_append(NULL, oproto[0]);
> +
> +               sdp_uuid16_create(&obex, OBEX_UUID);
> +               oproto[1] =3D sdp_list_append(NULL, &obex);
> +               apseq_obex =3D sdp_list_append(apseq_obex, oproto[1]);
> +
> +               aproto =3D sdp_list_append(aproto, apseq_obex);
> +       }
> +
> +       sdp_set_add_access_protos(record, aproto);
> +
> +       free(psm);
> +       free(opsm);
> +       sdp_list_free(proto[0], NULL);
> +       sdp_list_free(proto[1], NULL);
> +       sdp_list_free(oproto[0], NULL);
> +       sdp_list_free(oproto[1], NULL);
> +       sdp_list_free(apseq_browsing, NULL);
> +       sdp_list_free(apseq_obex, NULL);
> +       sdp_list_free(aproto, NULL);
> +}
> +
> +static sdp_record_t *avrcp_tg_record(bool browsing, uint16_t cover_psm)
>  {
>         sdp_list_t *svclass_id, *pfseq, *apseq, *root;
>         uuid_t root_uuid, l2cap, avctp, avrtg;
> @@ -500,6 +558,9 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
>                                         AVRCP_FEATURE_CATEGORY_4 |
>                                         AVRCP_FEATURE_TG_PLAYER_SETTINGS)=
;
>
> +       if (cover_psm !=3D 0)
> +               feat |=3D AVRCP_FEATURE_TG_COVERT_ART;
> +
>         record =3D sdp_record_alloc();
>         if (!record)
>                 return NULL;
> @@ -530,10 +591,10 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
>         sdp_set_access_protos(record, aproto_control);
>
>         /* Additional Protocol Descriptor List */
> -       if (browsing) {
> +       if (browsing)
>                 feat |=3D AVRCP_FEATURE_BROWSING;
> -               avrcp_browsing_record(record, version);
> -       }
> +
> +       avrcp_tg_add_protos(record, version, browsing, cover_psm);
>
>         /* Bluetooth Profile Descriptor List */
>         sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
> @@ -1272,6 +1333,18 @@ static uint8_t avrcp_handle_get_element_attributes=
(struct avrcp *session,
>                                         id > AVRCP_MEDIA_ATTRIBUTE_LAST)
>                                 continue;
>
> +                       /*
> +                        * AVRCP 1.6 Section 5.14: the Default Cover Art
> +                        * attribute shall only be included if a valid
> +                        * image handle exists for the current track.
> +                        * Returning it with an empty value makes some
> +                        * head units (e.g. VW MIB) give up on Cover Art
> +                        * for the rest of the session.
> +                        */
> +                       if (id =3D=3D AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE &&
> +                                       player_get_metadata(player, id) =
=3D=3D NULL)
> +                               continue;
> +
>                         len++;
>                         attr_ids =3D g_list_prepend(attr_ids,
>                                                         GUINT_TO_POINTER(=
id));
> @@ -4872,6 +4945,11 @@ static void avrcp_target_server_remove(struct btd_=
profile *p,
>                 server->tg_record_id =3D 0;
>         }
>
> +       if (server->cover_art) {
> +               avrcp_bip_server_stop();
> +               server->cover_art =3D false;
> +       }
> +
>         if (server->ct_record_id =3D=3D 0)
>                 avrcp_server_unregister(server);
>  }
> @@ -4893,7 +4971,11 @@ static int avrcp_target_server_probe(struct btd_pr=
ofile *p,
>                 return -EPROTONOSUPPORT;
>
>  done:
> -       record =3D avrcp_tg_record(server->browsing);
> +       if (!server->cover_art)
> +               server->cover_art =3D avrcp_bip_server_start() !=3D 0;
> +
> +       record =3D avrcp_tg_record(server->browsing,
> +                       server->cover_art ? avrcp_bip_server_get_psm() : =
0);
>         if (!record) {
>                 error("Unable to allocate new service record");
>                 avrcp_target_server_remove(p, adapter);
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 5d9ea2cbc..8ae716913 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -66,6 +66,9 @@
>  #ifdef HAVE_A2DP
>  #include "a2dp.h"
>  #endif
> +#ifdef HAVE_AVRCP
> +#include "avrcp-bip.h"
> +#endif
>
>  #define MEDIA_INTERFACE "org.bluez.Media1"
>  #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
> @@ -159,6 +162,10 @@ struct local_player {
>         bool                    previous;
>         bool                    control;
>         char                    *name;
> +       char                    *art_url;       /* Registered cover art U=
RL */
> +       char                    art_handle[8];  /* BIP handle of art_url =
*/
> +       char                    *art_pending;   /* URL being fetched */
> +       DBusPendingCall         *art_call;      /* Pending GetCoverArt ca=
ll */
>         struct queue            *cbs;
>  };
>
> @@ -2039,6 +2046,20 @@ static void local_player_emit_player_added(struct =
local_player *mp)
>         }
>  }
>
> +#ifdef HAVE_AVRCP
> +static void cover_art_cancel(struct local_player *mp)
> +{
> +       if (mp->art_call !=3D NULL) {
> +               dbus_pending_call_cancel(mp->art_call);
> +               dbus_pending_call_unref(mp->art_call);
> +               mp->art_call =3D NULL;
> +       }
> +
> +       g_free(mp->art_pending);
> +       mp->art_pending =3D NULL;
> +}
> +#endif
> +
>  static void local_player_destroy(struct local_player *mp)
>  {
>         DBusConnection *conn =3D btd_get_dbus_connection();
> @@ -2064,11 +2085,16 @@ static void local_player_destroy(struct local_pla=
yer *mp)
>         if (mp->settings)
>                 g_hash_table_unref(mp->settings);
>
> +#ifdef HAVE_AVRCP
> +       cover_art_cancel(mp);
> +#endif
> +
>         g_timer_destroy(mp->timer);
>         g_free(mp->sender);
>         g_free(mp->path);
>         g_free(mp->status);
>         g_free(mp->name);
> +       g_free(mp->art_url);
>         g_free(mp);
>  }
>
> @@ -2458,6 +2484,159 @@ static gboolean parse_int32_metadata(struct local=
_player *mp, const char *key,
>         return TRUE;
>  }
>
> +#ifdef HAVE_AVRCP
> +#define COVER_ART_MAX_SIZE (1024 * 1024)
> +#define COVER_ART_TIMEOUT 5000 /* ms */
> +#define MEDIA_PLAYER_COVER_ART_INTERFACE "org.bluez.MediaPlayerCoverArt1=
"
> +
> +static void cover_art_reset(struct local_player *mp)
> +{
> +       cover_art_cancel(mp);
> +
> +       g_free(mp->art_url);
> +       mp->art_url =3D NULL;
> +       mp->art_handle[0] =3D '\0';
> +}
> +
> +static void cover_art_reply(DBusPendingCall *call, void *user_data)
> +{
> +       struct local_player *mp =3D user_data;
> +       DBusMessage *reply;
> +       DBusMessageIter iter, array;
> +       const uint8_t *data =3D NULL;
> +       const char *handle;
> +       int len =3D 0;
> +
> +       reply =3D dbus_pending_call_steal_reply(call);
> +
> +       dbus_pending_call_unref(mp->art_call);
> +       mp->art_call =3D NULL;
> +
> +       /* The call was cancelled or the connection went away */
> +       if (reply =3D=3D NULL) {
> +               g_free(mp->art_pending);
> +               mp->art_pending =3D NULL;
> +               return;
> +       }
> +
> +       if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) =
{
> +               DBG("GetCoverArt: %s", dbus_message_get_error_name(reply)=
);
> +               goto done;
> +       }
> +
> +       if (!dbus_message_iter_init(reply, &iter) ||
> +                       dbus_message_iter_get_arg_type(&iter) !=3D
> +                                                       DBUS_TYPE_ARRAY |=
|
> +                       dbus_message_iter_get_element_type(&iter) !=3D
> +                                                       DBUS_TYPE_BYTE) {
> +               DBG("GetCoverArt: unexpected reply signature");
> +               goto done;
> +       }
> +
> +       dbus_message_iter_recurse(&iter, &array);
> +       dbus_message_iter_get_fixed_array(&array, &data, &len);
> +
> +       if (len <=3D 0 || len > COVER_ART_MAX_SIZE) {
> +               DBG("cover art has invalid size (%d bytes), ignoring", le=
n);
> +               goto done;
> +       }
> +
> +       /* Non-JPEG images are rejected by the responder */
> +       handle =3D avrcp_bip_set_cover_art(data, len);
> +       if (handle =3D=3D NULL)
> +               goto done;
> +
> +       g_free(mp->art_url);
> +       mp->art_url =3D mp->art_pending;
> +       mp->art_pending =3D NULL;
> +
> +       strncpy(mp->art_handle, handle, sizeof(mp->art_handle) - 1);
> +       mp->art_handle[sizeof(mp->art_handle) - 1] =3D '\0';
> +
> +       /*
> +        * The track was announced without attribute 0x08 while the image
> +        * was in flight, so tell the peer to read the metadata again now
> +        * that a valid handle exists.
> +        */
> +       if (mp->track !=3D NULL) {
> +               g_hash_table_insert(mp->track, g_strdup("ImgHandle"),
> +                                                       g_strdup(handle))=
;
> +               local_player_emit_track_changed(mp);
> +       }
> +
> +done:
> +       g_free(mp->art_pending);
> +       mp->art_pending =3D NULL;
> +       dbus_message_unref(reply);
> +}
> +
> +static void cover_art_request(struct local_player *mp, const char *url)
> +{
> +       DBusMessage *msg;
> +
> +       cover_art_cancel(mp);
> +
> +       msg =3D dbus_message_new_method_call(mp->sender, mp->path,
> +                                       MEDIA_PLAYER_COVER_ART_INTERFACE,
> +                                       "GetCoverArt");
> +       if (msg =3D=3D NULL) {
> +               error("Couldn't allocate D-Bus message");
> +               return;
> +       }
> +
> +       dbus_message_append_args(msg, DBUS_TYPE_STRING, &url,
> +                                                       DBUS_TYPE_INVALID=
);
> +
> +       if (!g_dbus_send_message_with_reply(btd_get_dbus_connection(), ms=
g,
> +                                       &mp->art_call, COVER_ART_TIMEOUT)=
) {
> +               error("Failed to send GetCoverArt");
> +               dbus_message_unref(msg);
> +               return;
> +       }
> +
> +       dbus_message_unref(msg);
> +
> +       mp->art_pending =3D g_strdup(url);
> +
> +       dbus_pending_call_set_notify(mp->art_call, cover_art_reply, mp, N=
ULL);
> +}
> +
> +static gboolean parse_art_url_metadata(struct local_player *mp,
> +                                                       DBusMessageIter *=
iter)
> +{
> +       const char *url;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_STRING)
> +               return FALSE;
> +
> +       dbus_message_iter_get_basic(iter, &url);
> +
> +       if (!avrcp_bip_server_active())
> +               return TRUE;
> +
> +       /*
> +        * Players resend their full metadata on many state changes.
> +        * Reuse the registered handle if the cover has not changed to
> +        * avoid refetching the image and churning image handles, which
> +        * would make controllers re-fetch an unchanged image.
> +        */
> +       if (mp->art_url !=3D NULL && g_str_equal(mp->art_url, url) &&
> +                                               mp->art_handle[0] !=3D '\=
0') {
> +               g_hash_table_insert(mp->track, g_strdup("ImgHandle"),
> +                                               g_strdup(mp->art_handle))=
;
> +               return TRUE;
> +       }
> +
> +       /* Likewise, do not restart a request that is already in flight *=
/
> +       if (mp->art_pending !=3D NULL && g_str_equal(mp->art_pending, url=
))
> +               return TRUE;
> +
> +       cover_art_request(mp, url);
> +
> +       return TRUE;
> +}
> +#endif
> +
>  static gboolean parse_player_metadata(struct local_player *mp,
>                                                         DBusMessageIter *=
iter)
>  {
> @@ -2465,6 +2644,9 @@ static gboolean parse_player_metadata(struct local_=
player *mp,
>         DBusMessageIter var;
>         int ctype;
>         gboolean title =3D FALSE;
> +#ifdef HAVE_AVRCP
> +       gboolean art =3D FALSE;
> +#endif
>
>         ctype =3D dbus_message_iter_get_arg_type(iter);
>         if (ctype !=3D DBUS_TYPE_ARRAY)
> @@ -2517,6 +2699,12 @@ static gboolean parse_player_metadata(struct local=
_player *mp,
>                 } else if (strcasecmp(key, "xesam:trackNumber") =3D=3D 0)=
 {
>                         if (!parse_int32_metadata(mp, "TrackNumber", &var=
))
>                                 return FALSE;
> +               } else if (strcasecmp(key, "mpris:artUrl") =3D=3D 0) {
> +#ifdef HAVE_AVRCP
> +                       if (!parse_art_url_metadata(mp, &var))
> +                               return FALSE;
> +                       art =3D TRUE;
> +#endif
>                 } else
>                         DBG("%s not supported, ignoring", key);
>
> @@ -2527,6 +2715,12 @@ static gboolean parse_player_metadata(struct local=
_player *mp,
>                 g_hash_table_insert(mp->track, g_strdup("Title"),
>                                                                 g_strdup(=
""));
>
> +#ifdef HAVE_AVRCP
> +       /* The new track has no cover art, drop whatever was cached */
> +       if (art =3D=3D FALSE)
> +               cover_art_reset(mp);
> +#endif
> +
>         mp->position =3D 0;
>         g_timer_start(mp->timer);
>
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index b6c614908..f94198d65 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -14,6 +14,7 @@
>      <allow send_interface=3D"org.bluez.Agent1"/>
>      <allow send_interface=3D"org.bluez.MediaEndpoint1"/>
>      <allow send_interface=3D"org.bluez.MediaPlayer1"/>
> +    <allow send_interface=3D"org.bluez.MediaPlayerCoverArt1"/>
>      <allow send_interface=3D"org.bluez.Profile1"/>
>      <allow send_interface=3D"org.bluez.GattCharacteristic1"/>
>      <allow send_interface=3D"org.bluez.GattDescriptor1"/>
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
> index 1d7a421e9..3474c4b4a 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -33,6 +33,8 @@
>  #define BLUEZ_DEVICE_INTERFACE "org.bluez.Device1"
>  #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
>  #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
> +#define BLUEZ_MEDIA_PLAYER_COVER_ART_INTERFACE \
> +                                       "org.bluez.MediaPlayerCoverArt1"
>  #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
>  #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
>  #define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
> @@ -385,6 +387,76 @@ done:
>         dbus_message_unref(reply);
>  }
>
> +#define COVER_ART_MAX_SIZE (1024 * 1024)
> +
> +/*
> + * bluetoothd is sandboxed and has no access to the user's home director=
y,
> + * so it cannot read the file mpris:artUrl points to. Read it here inste=
ad,
> + * where we already run with the permissions of the player, and hand the
> + * image over as plain bytes.
> + */
> +static DBusHandlerResult cover_art_get(DBusConnection *conn, DBusMessage=
 *msg)
> +{
> +       DBusMessage *reply;
> +       DBusMessageIter iter, array;
> +       const char *url;
> +       char *filename, *contents =3D NULL;
> +       gsize len =3D 0;
> +       GError *gerr =3D NULL;
> +
> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &url,
> +                                                       DBUS_TYPE_INVALID=
))
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       filename =3D g_filename_from_uri(url, NULL, NULL);
> +       if (filename =3D=3D NULL) {
> +               reply =3D g_dbus_create_error(msg, ERROR_INTERFACE
> +                                       ".NotSupported", "Not a local fil=
e");
> +               goto send;
> +       }
> +
> +       if (!g_file_get_contents(filename, &contents, &len, &gerr)) {
> +               reply =3D g_dbus_create_error(msg, ERROR_INTERFACE ".Fail=
ed",
> +                                                       "%s", gerr->messa=
ge);
> +               g_error_free(gerr);
> +               g_free(filename);
> +               goto send;
> +       }
> +
> +       g_free(filename);
> +
> +       if (len =3D=3D 0 || len > COVER_ART_MAX_SIZE) {
> +               reply =3D g_dbus_create_error(msg, ERROR_INTERFACE ".Fail=
ed",
> +                                                       "Invalid image si=
ze");
> +               g_free(contents);
> +               goto send;
> +       }
> +
> +       reply =3D dbus_message_new_method_return(msg);
> +       if (reply =3D=3D NULL) {
> +               g_free(contents);
> +               return DBUS_HANDLER_RESULT_NEED_MEMORY;
> +       }
> +
> +       dbus_message_iter_init_append(reply, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_BYTE_AS_STRING, &array)=
;
> +       dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
> +                                                       &contents, len);
> +       dbus_message_iter_close_container(&iter, &array);
> +
> +       g_free(contents);
> +
> +send:
> +       if (reply =3D=3D NULL)
> +               return DBUS_HANDLER_RESULT_NEED_MEMORY;
> +
> +       dbus_connection_send(conn, reply, NULL);
> +       dbus_message_unref(reply);
> +
> +       return DBUS_HANDLER_RESULT_HANDLED;
> +}
> +
>  static DBusHandlerResult player_message(DBusConnection *conn,
>                                                 DBusMessage *msg, void *d=
ata)
>  {
> @@ -393,6 +465,15 @@ static DBusHandlerResult player_message(DBusConnecti=
on *conn,
>         DBusMessageIter args, iter;
>         DBusPendingCall *call;
>
> +       /*
> +        * Cover art is served by the proxy itself, the player behind it
> +        * knows nothing about this interface.
> +        */
> +       if (dbus_message_is_method_call(msg,
> +                               BLUEZ_MEDIA_PLAYER_COVER_ART_INTERFACE,
> +                               "GetCoverArt"))
> +               return cover_art_get(conn, msg);
> +
>         dbus_message_iter_init(msg, &args);
>
>         copy =3D dbus_message_new_method_call(owner,
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
