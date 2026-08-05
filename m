Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C823476CFE
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949957; cv=pass; b=D71Qh96FVjtuAobw0dmX0+Pkq1eOKRa6uGJW1rGPS7cn7vylNZzVxTHGJmwvJ7Z63DV4LWtF0RO4AECzxB2gJQrS6zLaasVF4IX0WiY97J1oVeh+1DazytVXtVVlZwqloJeXgaubHG1EV57tgRbytcD3pHGPJIYNJqN68DBBDK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949957; c=relaxed/simple;
	bh=xUKzaPLOyGc/5YJYqkdPkGfzQAyKCQ8Grg9cxq1gIdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXoX5bxyIIgwT2EWRec4KhmplFIZyxvbO376o+xT8EPslXjQBZkTmvHCJQKc/qqDQsLRrDOyS5jk4pMqqpebZ16yQZLU3TtujqxxDoX0N73J/fb4KFx9nCWvFFaPWtDxUZqVhOAHfoCLbOs2WfjV3C44ZbGT2wEJ48ryUreGyHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaNI+mCu; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaNI+mCu"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664a09bc459so1898934d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 10:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785949954; cv=none;
        d=google.com; s=arc-20260327;
        b=MqJ2DWMWeyY8hECYLHmzp2pADgMilonyjCzqybmsHdRRW0XOK2ViTK0I4vueJ0M3Ad
         7LFN2gOqq9swlHgfK21srKQUWjXg+aukxwr7E2sMXFPZ4mcV7OAk1is2ceLyT5/4ZqnI
         Ac6hy9Gmt1+rEWpTG9l9GfmtGZqxtPwCnUylyjBKbgxT0mGE9Nv3sKDlBsHKBphiqTeE
         DBhpPkFWXwWizblVitrTXwDgWF6p8OyIccI0iF+fH1+BFQdKDg8IBP0vBOyUKFk8DhR0
         Z0Elrj64Em+DDPgkUrbebqbx2OEuEEQVcBsTbSZJAPfe53JE/JYoBXzt+OiMCO375jd6
         V2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHp06MXNStEu/kB1sZbojzrKy/HbEmuLUoZhdaPWhI8=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=VUZfDg0crnehdOAHG9/p2fjAEZeTQs4U1ZL/02G0qHEy1Cm19H/hSB80cFnYfRllhE
         jl3fp+t4HY+x5+C5bxGCp/SPKubwt6ZuPT3SJZ+BdPu8dwl2oAza8xGgIKapnFH+r4nD
         go8y9gWvrRUUkqelnVPzlzWp6mJEDKwFam0sm/D1f37ZcZBJG+NQgO56sH5Gam+Lcyil
         A7CKGDiIa6QhYjrUDxvIfE7QX4Wv7oOqPBcttgDAtCKXVZE0KQLOQ5jySicbTEwTxt63
         oxu55fRlc9KdTBMUVkHxMrrQXht5Lt/MZQriwoKXVoj0Znau/9wEDAsj8P7Bz3Ael6Tz
         bMmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785949954; x=1786554754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BHp06MXNStEu/kB1sZbojzrKy/HbEmuLUoZhdaPWhI8=;
        b=jaNI+mCuVR8PoeOMLGRZ5rFl4iCH5Du5XKgwfBqpyXZlBdFtfxPWbZoYSJeYupz2ts
         l2NGoetGmk/WjG1Z2iWz/uX3aj7OsqVBnspMppTayZDRATLgDI7O40Q9bv9cKrBbzERl
         OsT8PpzSwGiUO6VanOT9rI5j/vlMGnR9KtQHCfJG/8Svfu5MUVfEz2efmvPDSDIp50O8
         BBGF6HqjltMI3C52V19/8KBIUL0sPhnlnMSPwivX0ctXS8zM/SgzeZtKRDB1dMM5glv7
         u7JKgxuCncGj4CxENsCxzBGielGKhcBDBO4fAVoBTxz/PTnZfrw15Vu2xsUC+tqn8osW
         4txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785949954; x=1786554754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHp06MXNStEu/kB1sZbojzrKy/HbEmuLUoZhdaPWhI8=;
        b=NYIeH2jWaFHG2pJaErsYtsrcCKH0bi5fh2vee07h+dOxZfPfXySymKBFuwKB7qzBfA
         UtE2Tp8r4Qh86fweqqFwUMq0r8MO98oTE/bmUL7XkJGc+G1eTE2mzOZhwz4sg2yfQg+X
         rVxb5y4eFRJD9r6zKaJamMPP8tWmvMqt39J9N7S1LptfhD58U34FvPs74+rmlq4t66uB
         H6A6hDIAkdZO0R0Lq5ijm2COPMw4HeL8jp9Z2vJanKhDUYCFWLSIPY09MuhLMh4DMeDR
         AYcMa55S0f1oJASX9+x1/mjmwKxDc1n8rd3p20wH4esq4FSuAY0ir275wc6DIXl6ySpz
         yA5g==
X-Gm-Message-State: AOJu0YzGdYBQ6INs8Oj4dMIAE4OjdL+6l7czHDtTAhtC6M7um9qroC7G
	rbS0tCqW7slUsSDWdvwgAJ6TVaHCQe5/0Vg2FaiL+OewLK3ZJD7r6HwscF5Lskl0UATVF/3MVO0
	xRcC5VydO1CSmwBQYne+vHdEJHQcrAT0=
X-Gm-Gg: AR+sD128pBM+BT5v34yYMTOqX3WCc4c+uHh9txzYtCAAfULjhx3xEmRU+Zpgm39/NKh
	BLY5XPnC0HTC4K0OIer2KboCx5Jn6jMbf+VIB+qQHeBwtzmMe+0E9lGV8NBoSa+c7ORI5GKN7Kp
	Kd+BewUKOm6Dh7hGBpKs2t6BTdFZNx1Z3vh1RgGrUwQis89oeaxXPER3/m3VOfdzaXOFJFkZhFX
	z9j5SXG24OZYnNrUKPB1XnkIiyngry6ypsA5wzRVhCzCFXLGrS8Aum0qxB6BclAWJdtpZmmtIxP
	ZiIhNvadC6xcmkKeJ4k4Tn/FFNCgc26mXE2oa7y8IE1P2/bMZiKobUBaSoeOSBmA1Z0e+KH1G2y
	ENfQvrcmpoml2QkHL/XP4Xv9QeivOlUmCc90=
X-Received: by 2002:a53:ec0d:0:b0:667:bb60:789a with SMTP id
 956f58d0204a3-6699a83716dmr3437248d50.10.1785949954356; Wed, 05 Aug 2026
 10:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804142419.2274153-1-hadess@hadess.net> <20260804142419.2274153-2-hadess@hadess.net>
In-Reply-To: <20260804142419.2274153-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Aug 2026 13:12:23 -0400
X-Gm-Features: AUfX_myYNA6TG2J4nyh1KSswwOnCN7gqTPMpPgXdnxcQ_PMNl398a0E0Z6RdMQM
Message-ID: <CABBYNZKb7_6CBD_Aq27PHUqA5=_P_NeyY4qcKOjCNk-dRN6-cw@mail.gmail.com>
Subject: Re: [BlueZ, v2 1/3] avrcp: Split off name parsing from parse_*_element()
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> This will allow us to use the name extraction code in
> parse_media_element() and parse_folder_element() separately, such
> as in tests.
> ---
>  Makefile.plugins             |  1 +
>  profiles/audio/avrcp-parse.c | 47 ++++++++++++++++++++++++++++++++++++
>  profiles/audio/avrcp-parse.h | 19 +++++++++++++++
>  profiles/audio/avrcp.c       | 26 +++++---------------
>  4 files changed, 73 insertions(+), 20 deletions(-)
>  create mode 100644 profiles/audio/avrcp-parse.c
>  create mode 100644 profiles/audio/avrcp-parse.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index ac667beda847..a505fcd6691f 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -37,6 +37,7 @@ builtin_modules +=3D avrcp
>  builtin_sources +=3D profiles/audio/control.h profiles/audio/control.c \
>                         profiles/audio/avctp.h profiles/audio/avctp.c \
>                         profiles/audio/avrcp.h profiles/audio/avrcp.c \
> +                       profiles/audio/avrcp-parse.h profiles/audio/avrcp=
-parse.c \
>                         profiles/audio/avrcp-player.c
>  endif
>
> diff --git a/profiles/audio/avrcp-parse.c b/profiles/audio/avrcp-parse.c
> new file mode 100644
> index 000000000000..d3d0a070a4da
> --- /dev/null
> +++ b/profiles/audio/avrcp-parse.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2026  Red Hat Inc.
> + *
> + *
> + */
> +
> +#include "avrcp-parse.h"
> +#include "src/shared/util.h"
> +
> +gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
> +                                        char *name, uint16_t *namesize)
> +{
> +       uint16_t namelen;
> +
> +       if (len < 13)
> +               return FALSE;
> +
> +       memset(name, 0, NAME_MAX_LEN);
> +       *namesize =3D get_be16(&operands[11]);
> +       namelen =3D MIN(*namesize, NAME_MAX_LEN - 1);
> +       if (namelen > 0) {
> +               memcpy(name, &operands[13], namelen);
> +               strtoutf8(name, namelen);
> +       }
> +
> +       return TRUE;
> +}
> +
> +gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
> +                                       char *name)
> +{
> +       uint16_t namelen;
> +
> +       if (len < 12)
> +               return FALSE;
> +
> +       memset(name, 0, NAME_MAX_LEN);
> +       namelen =3D MIN(get_be16(&operands[12]), NAME_MAX_LEN - 1);
> +       if (namelen > 0)
> +               memcpy(name, &operands[14], namelen);
> +
> +       return TRUE;
> +}

Rather than creating yet another file how about hosting this under
shared/util.h directly? It already depends on it anyway, we could got
with something like strntoutf8 or a similar function that checks the
length, etc, actually be maybe better to do it under
util_iov_pull_utf8(iov, len, str, str_max_len) so we can load the pdu
into the iov then use iov_pull_mem, etc, to verify that we have enough
bytes in a generic manner.

> diff --git a/profiles/audio/avrcp-parse.h b/profiles/audio/avrcp-parse.h
> new file mode 100644
> index 000000000000..f7a33c854442
> --- /dev/null
> +++ b/profiles/audio/avrcp-parse.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2026  Red Hat Inc.
> + *
> + *
> + */
> +
> +#include <glib.h>
> +#include <inttypes.h>
> +
> +#define NAME_MAX_LEN 255
> +
> +gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
> +                                        char *name, uint16_t *namesize);
> +gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
> +                                       char *name);
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 2194a913580f..af3c72174764 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -52,6 +52,7 @@
>
>  #include "avctp.h"
>  #include "avrcp.h"
> +#include "avrcp-parse.h"
>  #include "control.h"
>  #include "media.h"
>  #include "player.h"
> @@ -2614,24 +2615,15 @@ static struct media_item *parse_media_element(str=
uct avrcp *session,
>         struct avrcp_player *player;
>         struct media_player *mp;
>         struct media_item *item;
> -       uint16_t namelen, namesize;
> -       char name[255];
> +       uint16_t namesize;
> +       char name[NAME_MAX_LEN];
>         uint64_t uid;
>         uint8_t count;
>
> -       if (len < 13)
> +       if (!parse_media_element_name(operands, len, name, &namesize))
>                 return NULL;
>
>         uid =3D get_be64(&operands[0]);
> -
> -       memset(name, 0, sizeof(name));
> -       namesize =3D get_be16(&operands[11]);
> -       namelen =3D MIN(namesize, sizeof(name) - 1);
> -       if (namelen > 0) {
> -               memcpy(name, &operands[13], namelen);
> -               strtoutf8(name, namelen);
> -       }
> -
>         count =3D operands[13 + namesize];
>
>         player =3D session->controller->player;
> @@ -2655,24 +2647,18 @@ static struct media_item *parse_media_folder(stru=
ct avrcp *session,
>         struct avrcp_player *player =3D session->controller->player;
>         struct media_player *mp =3D player->user_data;
>         struct media_item *item;
> -       uint16_t namelen;
> -       char name[255];
> +       char name[NAME_MAX_LEN];
>         uint64_t uid;
>         uint8_t type;
>         uint8_t playable;
>
> -       if (len < 12)
> +       if (!parse_media_folder_name(operands, len, name))
>                 return NULL;
>
>         uid =3D get_be64(&operands[0]);
>         type =3D operands[8];
>         playable =3D operands[9];
>
> -       memset(name, 0, sizeof(name));
> -       namelen =3D MIN(get_be16(&operands[12]), sizeof(name) - 1);
> -       if (namelen > 0)
> -               memcpy(name, &operands[14], namelen);
> -
>         item =3D media_player_create_folder(mp, name, type, uid);
>         if (!item)
>                 return NULL;
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
