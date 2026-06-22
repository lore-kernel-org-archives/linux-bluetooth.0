Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111A376A10
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141998; cv=pass; b=n2AbqWBiP8AfdM8ueOQz12BNSqvbKyg2zdKB0F3pDxN9RD8TqYZ2z0DcXw2f268JGt3ZpJqCktBPrUiD5/JfEFXrvUhNecpkAmex6jxiqRlg5GoNOERFal5ojXZesjA0Yrnm3yDKkhdeO+/dlsbBxr+aglQ1IQCHDfzrF7DjI5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141998; c=relaxed/simple;
	bh=NcmwTStEUKqrBQqasGN7cJC/sYdnDR/BZSrXdoDe170=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUwlX9MC68HolHFit6Kj/IsRa6Yr2DKTmiH0Q08XVTFs34VQRVOwn9hYOoHB2/se22Az+8Gk5BZTF74/g115SELfNbowQL+KnlPaXqx5F+c8hzUdWCdTWCON3+4lov/AgGd9p5SHO1OgMsfDZMYPTQPuxd9DCV2fbkvOkP38bYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=vfNMaTfc; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="vfNMaTfc"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gkX9B4q1hz49Q5R;
	Mon, 22 Jun 2026 18:26:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1782141983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pzm+oi07l0z0FRaEXeYskd9h5pwqsENbxJwvsoNP/Vw=;
	b=vfNMaTfcqM8Qaekwr1BDvHG8KyZMjS+nrs9O4x1lnqG6iCL0w5zvoCJRUlqMo/1JOxQdET
	CDqpx4ffYlXVFWVpMHak6iphAYPlel0NH/+y8L5831TuTRDlIOVZI/A4qObGQIrYJtWD12
	xLL3YPmxQp42KzpsfWsk6+pGKMP26qP9I5GYJrP2XUHtl0Kr9uh2HY5+bIslll6pGk5eUr
	06yU8bq0rlgkaEUTRrRyBud3IDoB2sFr4+NObkIbJeB9I7vt7cgVE4pJzB8lT1LHBmYJXu
	NJV+v0KJbqc+9ONd8eFl0uPT26XRTnm348SuzUbBIBZLEiMpchJSW8l4Sp1UJg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1782141983;
	b=lQictruPJcfT6RizdBUyMHndH9Hm1ajZeYI5teLxbenbXZ5mERuLN2IIpquvh8HYEGPkBd
	y34m3/M2VA6OD9aBRd3FJGqXLtuaD2cC4Gyq8L5Z6KB1phLq0K4nW4ilYiHfJ4FIwtV0UU
	vVHMXJJVarA4HMnC/d9wM5D9j1dLF0mdozbwjx83nf4msddpBesNUz7ybxP+NfTy4WLRFZ
	UgaL02Ix9KM/tAa321buhVSq6MVCtyth6aaOb6MRm4D2dhUxhYlo4Yf/aexLlRspvll5Gj
	YM1wR8tB/OU/bjinjznA5gd/EZw33cjC76s4qIRJEg7xQm51XxNEa7M9+MX/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1782141983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pzm+oi07l0z0FRaEXeYskd9h5pwqsENbxJwvsoNP/Vw=;
	b=oYMhykWFjGt2pdqOuX/MehwhLIx5jzxfWz9FW1pH/ZPLmzKoGpqVnQir6v94ifjtNqaAAu
	K+XSipRj7Fn8Rbi5gGAQbFIHa3K03OD/ZOmYKXOfLKnndTZ1/RSWsrgwev+gUdogP1uYSx
	r8NgwwRS1M+H0+qlNaLIAF1pTq6u/+izq1fZMLccinlpZE72wMASkFtw2uF/yEJBdjm/Gr
	ZuBErYWoY1/2sNTNBK3G38yfsIloo2IZLyay8Gmv+5aOr8PrchxMu4KB3ePnWMHN8XVrux
	nA2wrntGHgr9mmJdPkPbSqhEao65P0mmbSOK/YbCkLldST5dK98j2z3YS80wqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <44da5c7fd01e6c9ac0499ab4ff06530af38adf00.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/2] audio: harden a2dp parsers
From: Pauli Virtanen <pav@iki.fi>
To: Geraldo Netto <geraldonetto@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Mon, 22 Jun 2026 18:26:19 +0300
In-Reply-To: <20260620191735.2675946-2-geraldonetto@gmail.com>
References: <20260620191735.2675946-1-geraldonetto@gmail.com>
	 <20260620191735.2675946-2-geraldonetto@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

la, 2026-06-20 kello 21:17 +0200, Geraldo Netto kirjoitti:
> ---
>  Makefile.am                   |   7 +
>  Makefile.plugins              |   1 +
>  profiles/audio/a2dp-helpers.c | 136 ++++++++++++++++
>  profiles/audio/a2dp-helpers.h |  20 +++
>  profiles/audio/a2dp.c         |  86 +++++-----
>  unit/test-a2dp.c              | 288 ++++++++++++++++++++++++++++++++++
>  6 files changed, 489 insertions(+), 49 deletions(-)

This seems to be mixing style changes (eg NULL -> (GSourceFunc) NULL)
and other changes.

Generally it's better to separate the two, and commit messages should
make clear why you are changing things.

In this case also not clear to me the style changes are needed. The
NULL cast is probably not needed, the uint8_t delay_reporting; variable
doesn't seem to be used later.

>  create mode 100644 profiles/audio/a2dp-helpers.c
>  create mode 100644 profiles/audio/a2dp-helpers.h
>  create mode 100644 unit/test-a2dp.c
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 76c4ab5d4..35871cc57 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -642,6 +642,13 @@ unit_test_avdtp_SOURCES =3D unit/test-avdtp.c \
>  				unit/avdtp.c unit/avdtp.h
>  unit_test_avdtp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> =20
> +unit_tests +=3D unit/test-a2dp
> +
> +unit_test_a2dp_SOURCES =3D unit/test-a2dp.c \
> +				profiles/audio/a2dp-helpers.c \
> +				profiles/audio/a2dp-helpers.h
> +unit_test_a2dp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
> +
>  unit_tests +=3D unit/test-avctp
> =20
>  unit_test_avctp_SOURCES =3D unit/test-avctp.c \
> diff --git a/Makefile.plugins b/Makefile.plugins
> index ac667beda..57400d877 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -27,6 +27,7 @@ builtin_modules +=3D a2dp
>  builtin_sources +=3D profiles/audio/source.h profiles/audio/source.c \
>  			profiles/audio/sink.h profiles/audio/sink.c \
>  			profiles/audio/a2dp.h profiles/audio/a2dp.c \
> +			profiles/audio/a2dp-helpers.h profiles/audio/a2dp-helpers.c \
>  			profiles/audio/avdtp.h profiles/audio/avdtp.c \
>  			profiles/audio/a2dp-codecs.h
>  endif
> diff --git a/profiles/audio/a2dp-helpers.c b/profiles/audio/a2dp-helpers.=
c
> new file mode 100644
> index 000000000..035236df6
> --- /dev/null
> +++ b/profiles/audio/a2dp-helpers.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <dbus/dbus.h>
> +#include <glib.h>
> +
> +#include "a2dp-helpers.h"
> +
> +static bool parse_hex_byte(const char **value, uint8_t *byte)
> +{
> +	int high;
> +	int low;
> +
> +	if ((*value)[0] =3D=3D '\0' || (*value)[1] =3D=3D '\0')
> +		return false;
> +
> +	high =3D g_ascii_xdigit_value((*value)[0]);
> +	low =3D g_ascii_xdigit_value((*value)[1]);
> +	if (high < 0 || low < 0)
> +		return false;
> +
> +	*byte =3D high << 4 | low;
> +	*value +=3D 2;
> +
> +	return true;
> +}
> +
> +static bool parse_colon(const char **value)
> +{
> +	if (**value !=3D ':')
> +		return false;
> +
> +	(*value)++;
> +
> +	return true;
> +}
> +
> +static bool parse_caps(const char *value, uint8_t *caps, size_t caps_len=
,
> +								size_t *size)
> +{
> +	size_t len;
> +	size_t i;
> +
> +	if (!value || !caps || !size)
> +		return false;
> +
> +	*size =3D 0;
> +
> +	len =3D strlen(value);
> +	if (!len || len % 2 || len / 2 > caps_len)
> +		return false;
> +
> +	for (i =3D 0; i < len; i++) {
> +		if (!g_ascii_isxdigit(value[i]))
> +			return false;
> +	}
> +
> +	for (i =3D 0; i < len; i +=3D 2) {
> +		const char *pos =3D value + i;
> +
> +		parse_hex_byte(&pos, &caps[i / 2]);
> +	}
> +
> +	*size =3D len / 2;
> +
> +	return true;
> +}
> +
> +bool a2dp_parse_capabilities_array(DBusMessageIter *value,
> +					uint8_t **caps, int *size)
> +{
> +	DBusMessageIter array;
> +
> +	if (!value || !caps || !size)
> +		return false;
> +
> +	*caps =3D NULL;
> +	*size =3D 0;
> +
> +	if (dbus_message_iter_get_arg_type(value) !=3D DBUS_TYPE_ARRAY)
> +		return false;
> +
> +	if (dbus_message_iter_get_element_type(value) !=3D DBUS_TYPE_BYTE)
> +		return false;
> +
> +	dbus_message_iter_recurse(value, &array);
> +	dbus_message_iter_get_fixed_array(&array, caps, size);
> +
> +	return *caps && *size > 0;
> +}
> +
> +bool a2dp_parse_persisted_endpoint(const char *value, uint8_t *type,
> +					uint8_t *codec,
> +					bool *delay_reporting,
> +					uint8_t *caps, size_t caps_len,
> +					size_t *size)
> +{
> +	const char *pos;
> +	uint8_t delay =3D 0;
> +
> +	if (!value || !type || !codec || !delay_reporting || !size)
> +		return false;
> +
> +	*size =3D 0;
> +
> +	pos =3D value;
> +	if (!parse_hex_byte(&pos, type) || !parse_colon(&pos))
> +		return false;
> +
> +	if (!parse_hex_byte(&pos, codec) || !parse_colon(&pos))
> +		return false;
> +
> +	if (pos[0] !=3D '\0' && pos[1] !=3D '\0' &&
> +			g_ascii_isxdigit(pos[0]) && g_ascii_isxdigit(pos[1]) &&
> +			pos[2] =3D=3D ':') {
> +		parse_hex_byte(&pos, &delay);
> +		parse_colon(&pos);
> +		if (delay > 1)
> +			return false;
> +	}
> +
> +	if (!parse_caps(pos, caps, caps_len, size))
> +		return false;
> +
> +	*delay_reporting =3D delay;
> +
> +	return true;
> +}
> diff --git a/profiles/audio/a2dp-helpers.h b/profiles/audio/a2dp-helpers.=
h
> new file mode 100644
> index 000000000..a5c90c516
> --- /dev/null
> +++ b/profiles/audio/a2dp-helpers.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifndef BLUEZ_A2DP_HELPERS_H
> +#define BLUEZ_A2DP_HELPERS_H
> +
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +
> +#include <dbus/dbus.h>
> +
> +bool a2dp_parse_capabilities_array(DBusMessageIter *value,
> +					uint8_t **caps, int *size);
> +bool a2dp_parse_persisted_endpoint(const char *value, uint8_t *type,
> +					uint8_t *codec,
> +					bool *delay_reporting,
> +					uint8_t *caps, size_t caps_len,
> +					size_t *size);
> +
> +#endif /* BLUEZ_A2DP_HELPERS_H */
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a5e002784..0999436c5 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -52,6 +52,7 @@
>  #include "sink.h"
>  #include "source.h"
>  #include "a2dp.h"
> +#include "a2dp-helpers.h"
>  #include "a2dp-codecs.h"
>  #include "media.h"
> =20
> @@ -689,7 +690,7 @@ static void stream_state_changed(struct avdtp_stream =
*stream,
>  		if (err < 0 && err !=3D -EINPROGRESS) {
>  			error("avdtp_start: %s (%d)", strerror(-err), -err);
>  			finalize_setup_errno(setup, err, finalize_resume,
> -									NULL);
> +							(GSourceFunc) NULL);
>  			return;
>  		}
> =20
> @@ -942,7 +943,8 @@ static void endpoint_open_cb(struct a2dp_setup *setup=
, uint8_t error_code)
> =20
>  	if (error_code !=3D 0) {
>  		setup->stream =3D NULL;
> -		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
> +		finalize_setup_errno(setup, -EPERM, finalize_config,
> +							(GSourceFunc) NULL);
>  		goto done;
>  	}
> =20
> @@ -954,7 +956,7 @@ static void endpoint_open_cb(struct a2dp_setup *setup=
, uint8_t error_code)
> =20
>  	error("avdtp_open %s (%d)", strerror(-err), -err);
>  	setup->stream =3D NULL;
> -	finalize_setup_errno(setup, err, finalize_config, NULL);
> +	finalize_setup_errno(setup, err, finalize_config, (GSourceFunc) NULL);
>  done:
>  	setup_unref(setup);
>  }
> @@ -974,6 +976,7 @@ static void store_remote_sep(void *data, void *user_d=
ata)
>  	char seid[4], value[256];
>  	struct avdtp_service_capability *service =3D avdtp_get_codec(sep->sep);
>  	struct avdtp_media_codec_capability *codec;
> +	uint8_t delay_reporting;
>  	unsigned int i;
>  	ssize_t offset;
> =20
> @@ -981,12 +984,13 @@ static void store_remote_sep(void *data, void *user=
_data)
>  		return;
> =20
>  	codec =3D (void *) service->data;
> +	delay_reporting =3D avdtp_get_delay_reporting(sep->sep);
> =20
>  	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
> =20
>  	offset =3D sprintf(value, "%02hhx:%02hhx:%02hhx:",
>  			avdtp_get_type(sep->sep), codec->media_codec_type,
> -			avdtp_get_delay_reporting(sep->sep));
> +			delay_reporting);
> =20
>  	for (i =3D 0; i < service->length - sizeof(*codec); i++)
>  		offset +=3D sprintf(value + offset, "%02hhx", codec->data[i]);
> @@ -1139,7 +1143,8 @@ static void setconf_cfm(struct avdtp *session, stru=
ct avdtp_local_sep *sep,
>  			return;
> =20
>  		setup->stream =3D NULL;
> -		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
> +		finalize_setup_errno(setup, -EPERM, finalize_config,
> +							(GSourceFunc) NULL);
>  		setup_unref(setup);
>  		return;
>  	}
> @@ -1148,7 +1153,8 @@ static void setconf_cfm(struct avdtp *session, stru=
ct avdtp_local_sep *sep,
>  	if (ret < 0) {
>  		error("avdtp_open %s (%d)", strerror(-ret), -ret);
>  		setup->stream =3D NULL;
> -		finalize_setup_errno(setup, ret, finalize_config, NULL);
> +		finalize_setup_errno(setup, ret, finalize_config,
> +							(GSourceFunc) NULL);
>  	}
>  }
> =20
> @@ -1431,7 +1437,8 @@ static gboolean suspend_ind(struct avdtp *session, =
struct avdtp_local_sep *sep,
>  	if (start_err < 0 && start_err !=3D -EINPROGRESS) {
>  		error("avdtp_start: %s (%d)", strerror(-start_err),
>  								-start_err);
> -		finalize_setup_errno(setup, start_err, finalize_resume, NULL);
> +		finalize_setup_errno(setup, start_err, finalize_resume,
> +							(GSourceFunc) NULL);
>  	}
> =20
>  	return TRUE;
> @@ -1483,7 +1490,8 @@ static void suspend_cfm(struct avdtp *session, stru=
ct avdtp_local_sep *sep,
>  	start_err =3D avdtp_start(session, a2dp_stream->stream);
>  	if (start_err < 0 && start_err !=3D -EINPROGRESS) {
>  		error("avdtp_start: %s (%d)", strerror(-start_err), -start_err);
> -		finalize_setup_errno(setup, start_err, finalize_suspend, NULL);
> +		finalize_setup_errno(setup, start_err, finalize_suspend,
> +							(GSourceFunc) NULL);
>  	}
>  }
> =20
> @@ -1504,7 +1512,7 @@ static gboolean close_ind(struct avdtp *session, st=
ruct avdtp_local_sep *sep,
>  		return TRUE;
> =20
>  	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
> -							finalize_resume, NULL);
> +					finalize_resume, (GSourceFunc) NULL);
> =20
>  	return TRUE;
>  }
> @@ -1572,7 +1580,8 @@ static gboolean a2dp_reconfigure(gpointer data)
>  	return FALSE;
> =20
>  failed:
> -	finalize_setup_errno(setup, posix_err, finalize_config, NULL);
> +	finalize_setup_errno(setup, posix_err, finalize_config,
> +							(GSourceFunc) NULL);
>  	return FALSE;
>  }
> =20
> @@ -1648,8 +1657,8 @@ static void abort_ind(struct avdtp *session, struct=
 avdtp_local_sep *sep,
>  		return;
> =20
>  	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
> -							finalize_resume,
> -							finalize_config, NULL);
> +					finalize_resume, finalize_config,
> +					(GSourceFunc) NULL);
> =20
>  	return;
>  }
> @@ -1901,7 +1910,8 @@ static void channel_free(void *data)
>  		setup->chan =3D NULL;
>  		setup_ref(setup);
>  		/* Finalize pending commands before we NULL setup->session */
> -		finalize_setup_errno(setup, -ENOTCONN, finalize_all, NULL);
> +		finalize_setup_errno(setup, -ENOTCONN, finalize_all,
> +							(GSourceFunc) NULL);
>  		avdtp_unref(setup->session);
>  		setup->session =3D NULL;
>  		setup_unref(setup);
> @@ -1991,10 +2001,12 @@ static struct a2dp_sep *find_sep(struct a2dp_serv=
er *server, uint8_t type,
> =20
>  static int parse_properties(DBusMessageIter *props, uint8_t **caps, int =
*size)
>  {
> +	*caps =3D NULL;
> +	*size =3D 0;
> +
>  	while (dbus_message_iter_get_arg_type(props) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
>  		const char *key;
>  		DBusMessageIter value, entry;
> -		int var;
> =20
>  		dbus_message_iter_recurse(props, &entry);
>  		dbus_message_iter_get_basic(&entry, &key);
> @@ -2002,15 +2014,10 @@ static int parse_properties(DBusMessageIter *prop=
s, uint8_t **caps, int *size)
>  		dbus_message_iter_next(&entry);
>  		dbus_message_iter_recurse(&entry, &value);
> =20
> -		var =3D dbus_message_iter_get_arg_type(&value);
>  		if (strcasecmp(key, "Capabilities") =3D=3D 0) {
> -			DBusMessageIter array;
> -
> -			if (var !=3D DBUS_TYPE_ARRAY)
> +			if (!a2dp_parse_capabilities_array(&value, caps, size))
>  				return -EINVAL;
> =20
> -			dbus_message_iter_recurse(&value, &array);
> -			dbus_message_iter_get_fixed_array(&array, caps, size);
>  			return 0;
>  		}
> =20
> @@ -2130,7 +2137,7 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>  	struct avdtp_media_codec_capability *codec;
>  	DBusMessageIter args, props;
>  	const char *sender, *path;
> -	uint8_t *caps;
> +	uint8_t *caps =3D NULL;
>  	int err, size =3D 0;
> =20
>  	sender =3D dbus_message_get_sender(msg);
> @@ -2371,11 +2378,10 @@ static void load_remote_sep(struct a2dp_channel *=
chan, GKeyFile *key_file,
>  	for (; *seids; seids++) {
>  		uint8_t type;
>  		uint8_t codec;
> -		uint8_t delay_reporting;
> +		bool delay_reporting;
>  		GSList *l =3D NULL;
> -		char caps[256];
>  		uint8_t data[128];
> -		int i, size;
> +		size_t size;
> =20
>  		if (sscanf(*seids, "%02hhx", &rseid) !=3D 1)
>  			continue;
> @@ -2385,34 +2391,16 @@ static void load_remote_sep(struct a2dp_channel *=
chan, GKeyFile *key_file,
>  		if (!value)
>  			continue;
> =20
> -		/* Try loading with delay_reporting first */
> -		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type, &codec,
> -					&delay_reporting, caps) !=3D 4) {
> -			/* Try old format */
> -			if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
> -								caps) !=3D 3) {
> -				warn("Unable to load Endpoint: seid %u", rseid);
> -				g_free(value);
> -				continue;
> -			}
> -			delay_reporting =3D false;
> -		}
> -
> -		for (i =3D 0, size =3D strlen(caps); i < size; i +=3D 2) {
> -			uint8_t *tmp =3D data + i / 2;
> -
> -			if (sscanf(caps + i, "%02hhx", tmp) !=3D 1) {
> -				warn("Unable to load Endpoint: seid %u", rseid);
> -				break;
> -			}
> +		if (!a2dp_parse_persisted_endpoint(value, &type, &codec,
> +						&delay_reporting, data,
> +						sizeof(data), &size)) {
> +			warn("Unable to load Endpoint: seid %u", rseid);
> +			g_free(value);
> +			continue;
>  		}
> -
>  		g_free(value);
> =20
> -		if (i !=3D size)
> -			continue;
> -
> -		caps_add_codec(&l, codec, data, size / 2);
> +		caps_add_codec(&l, codec, data, size);
> =20
>  		rsep =3D avdtp_register_remote_sep(chan->session, rseid, type, l,
>  							delay_reporting);
> diff --git a/unit/test-a2dp.c b/unit/test-a2dp.c
> new file mode 100644
> index 000000000..2f7bd7bbc
> --- /dev/null
> +++ b/unit/test-a2dp.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <dbus/dbus.h>
> +#include <glib.h>
> +
> +#include "profiles/audio/a2dp-helpers.h"
> +
> +static DBusMessage *new_method_call(void)
> +{
> +	return dbus_message_new_method_call("org.bluez.test",
> +						"/org/bluez/test",
> +						"org.bluez.test",
> +						"Test");
> +}
> +
> +static void append_byte_array(DBusMessage *msg, const uint8_t *data, int=
 size)
> +{
> +	DBusMessageIter iter;
> +	DBusMessageIter array;
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +						DBUS_TYPE_BYTE_AS_STRING,
> +						&array);
> +	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
> +						&data, size);
> +	dbus_message_iter_close_container(&iter, &array);
> +}
> +
> +static void append_string_array(DBusMessage *msg)
> +{
> +	DBusMessageIter iter;
> +	DBusMessageIter array;
> +	const char *value =3D "not-bytes";
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +						DBUS_TYPE_STRING_AS_STRING,
> +						&array);
> +	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &value);
> +	dbus_message_iter_close_container(&iter, &array);
> +}
> +
> +static void test_capabilities_array_accepts_byte_array(void)
> +{
> +	DBusMessage *msg =3D new_method_call();
> +	DBusMessageIter iter;
> +	const uint8_t bytes[] =3D { 0x11, 0x22, 0x33 };
> +	uint8_t *caps =3D NULL;
> +	int size =3D 0;
> +
> +	g_assert_nonnull(msg);
> +
> +	append_byte_array(msg, bytes, sizeof(bytes));
> +	g_assert_true(dbus_message_iter_init(msg, &iter));
> +	g_assert_true(a2dp_parse_capabilities_array(&iter, &caps, &size));
> +	g_assert_cmpint(size, =3D=3D, 3);
> +	g_assert_nonnull(caps);
> +	g_assert_cmpint(memcmp(caps, bytes, sizeof(bytes)), =3D=3D, 0);
> +
> +	dbus_message_unref(msg);
> +}
> +
> +static void test_capabilities_array_rejects_wrong_element_type(void)
> +{
> +	DBusMessage *msg =3D new_method_call();
> +	DBusMessageIter iter;
> +	uint8_t *caps =3D (void *) 0x01;
> +	int size =3D 1;
> +
> +	g_assert_nonnull(msg);
> +
> +	append_string_array(msg);
> +	g_assert_true(dbus_message_iter_init(msg, &iter));
> +	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
> +	g_assert_null(caps);
> +	g_assert_cmpint(size, =3D=3D, 0);
> +
> +	dbus_message_unref(msg);
> +}
> +
> +static void test_capabilities_array_rejects_empty_array(void)
> +{
> +	DBusMessage *msg =3D new_method_call();
> +	DBusMessageIter iter;
> +	uint8_t *caps =3D (void *) 0x01;
> +	int size =3D 1;
> +
> +	g_assert_nonnull(msg);
> +
> +	append_byte_array(msg, NULL, 0);
> +	g_assert_true(dbus_message_iter_init(msg, &iter));
> +	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
> +	g_assert_cmpint(size, =3D=3D, 0);
> +
> +	dbus_message_unref(msg);
> +}
> +
> +static void test_capabilities_array_rejects_missing_iter(void)
> +{
> +	uint8_t *caps =3D (void *) 0x01;
> +	int size =3D 1;
> +
> +	g_assert_false(a2dp_parse_capabilities_array(NULL, &caps, &size));
> +}
> +
> +static void test_capabilities_array_rejects_non_array(void)
> +{
> +	DBusMessage *msg =3D new_method_call();
> +	DBusMessageIter iter;
> +	const char *value =3D "not-array";
> +	uint8_t *caps =3D (void *) 0x01;
> +	int size =3D 1;
> +
> +	g_assert_nonnull(msg);
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &value);
> +	g_assert_true(dbus_message_iter_init(msg, &iter));
> +	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
> +	g_assert_null(caps);
> +	g_assert_cmpint(size, =3D=3D, 0);
> +
> +	dbus_message_unref(msg);
> +}
> +
> +static void assert_endpoint(const char *value, uint8_t expected_type,
> +				uint8_t expected_codec,
> +				bool expected_delay,
> +				const uint8_t *expected_caps,
> +				size_t expected_size)
> +{
> +	uint8_t type =3D 0xff;
> +	uint8_t codec =3D 0xff;
> +	bool delay_reporting =3D true;
> +	uint8_t caps[128];
> +	size_t size =3D 0;
> +
> +	memset(caps, 0xa5, sizeof(caps));
> +
> +	g_assert_true(a2dp_parse_persisted_endpoint(value, &type, &codec,
> +							&delay_reporting,
> +							caps, sizeof(caps),
> +							&size));
> +	g_assert_cmpint(type, =3D=3D, expected_type);
> +	g_assert_cmpint(codec, =3D=3D, expected_codec);
> +	g_assert_cmpint(delay_reporting, =3D=3D, expected_delay);
> +	g_assert_cmpuint(size, =3D=3D, expected_size);
> +	g_assert_cmpint(memcmp(caps, expected_caps, expected_size), =3D=3D, 0);
> +}
> +
> +static void test_endpoint_parser_accepts_current_format(void)
> +{
> +	const uint8_t caps[] =3D { 0x11, 0x22, 0x33 };
> +
> +	assert_endpoint("00:40:01:112233", 0x00, 0x40, true, caps,
> +							sizeof(caps));
> +}
> +
> +static void test_endpoint_parser_accepts_old_format(void)
> +{
> +	const uint8_t caps[] =3D { 0xaa, 0xbb };
> +
> +	assert_endpoint("01:02:aabb", 0x01, 0x02, false, caps, sizeof(caps));
> +}
> +
> +static void assert_endpoint_rejected(const char *value)
> +{
> +	uint8_t type =3D 0xff;
> +	uint8_t codec =3D 0xff;
> +	bool delay_reporting =3D true;
> +	uint8_t caps[4] =3D { 0xa5, 0xa5, 0xa5, 0xa5 };
> +	size_t size =3D 7;
> +
> +	g_assert_false(a2dp_parse_persisted_endpoint(value, &type, &codec,
> +							&delay_reporting,
> +							caps, sizeof(caps),
> +							&size));
> +	g_assert_cmpint(caps[0], =3D=3D, 0xa5);
> +	g_assert_cmpint(caps[1], =3D=3D, 0xa5);
> +	g_assert_cmpint(caps[2], =3D=3D, 0xa5);
> +	g_assert_cmpint(caps[3], =3D=3D, 0xa5);
> +}
> +
> +static void test_endpoint_parser_rejects_invalid_fields(void)
> +{
> +	assert_endpoint_rejected(NULL);
> +	assert_endpoint_rejected("");
> +	assert_endpoint_rejected("00:40");
> +	assert_endpoint_rejected("00:40:");
> +	assert_endpoint_rejected("00:40:01:");
> +	assert_endpoint_rejected("00:40:02:aabb");
> +	assert_endpoint_rejected("00:40:01:aab");
> +	assert_endpoint_rejected("00:40:01:aazz");
> +	assert_endpoint_rejected("00:40:01:aa:bb");
> +	assert_endpoint_rejected("00:40:aabb:");
> +	assert_endpoint_rejected("xx:40:01:aabb");
> +}
> +
> +static void test_endpoint_parser_rejects_missing_output_buffer(void)
> +{
> +	uint8_t type;
> +	uint8_t codec;
> +	bool delay_reporting;
> +	size_t size;
> +
> +	g_assert_false(a2dp_parse_persisted_endpoint("00:40:01:aabb",
> +							&type, &codec,
> +							&delay_reporting,
> +							NULL, 0, &size));
> +}
> +
> +static void test_endpoint_parser_rejects_oversized_caps(void)
> +{
> +	char value[sizeof("00:40:01:") + 16];
> +
> +	memset(value, 'a', sizeof(value));
> +	memcpy(value, "00:40:01:", strlen("00:40:01:"));
> +	value[sizeof(value) - 1] =3D '\0';
> +
> +	assert_endpoint_rejected(value);
> +}
> +
> +static void test_endpoint_parser_fuzz_cases_keep_bounds(void)
> +{
> +	static const char alphabet[] =3D "0123456789abcdefABCDEF:gZ";
> +	unsigned int i;
> +
> +	for (i =3D 0; i < 4096; i++) {
> +		char value[16];
> +		uint8_t type;
> +		uint8_t codec;
> +		bool delay_reporting;
> +		uint8_t caps[6] =3D { 0, 0, 0, 0, 0xcc, 0xdd };
> +		size_t size;
> +		size_t len =3D i % (sizeof(value) - 1);
> +		size_t j;
> +
> +		for (j =3D 0; j < len; j++)
> +			value[j] =3D alphabet[(i + j * 7) %
> +						(sizeof(alphabet) - 1)];
> +		value[len] =3D '\0';
> +
> +		a2dp_parse_persisted_endpoint(value, &type, &codec,
> +						&delay_reporting, caps, 4,
> +						&size);
> +		g_assert_cmpint(caps[4], =3D=3D, 0xcc);
> +		g_assert_cmpint(caps[5], =3D=3D, 0xdd);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	g_test_init(&argc, &argv, NULL);
> +
> +	g_test_add_func("/a2dp/capabilities/byte-array",
> +			test_capabilities_array_accepts_byte_array);
> +	g_test_add_func("/a2dp/capabilities/wrong-element-type",
> +			test_capabilities_array_rejects_wrong_element_type);
> +	g_test_add_func("/a2dp/capabilities/empty-array",
> +			test_capabilities_array_rejects_empty_array);
> +	g_test_add_func("/a2dp/capabilities/missing-iter",
> +			test_capabilities_array_rejects_missing_iter);
> +	g_test_add_func("/a2dp/capabilities/non-array",
> +			test_capabilities_array_rejects_non_array);
> +	g_test_add_func("/a2dp/endpoint/current-format",
> +			test_endpoint_parser_accepts_current_format);
> +	g_test_add_func("/a2dp/endpoint/old-format",
> +			test_endpoint_parser_accepts_old_format);
> +	g_test_add_func("/a2dp/endpoint/invalid-fields",
> +			test_endpoint_parser_rejects_invalid_fields);
> +	g_test_add_func("/a2dp/endpoint/missing-output-buffer",
> +			test_endpoint_parser_rejects_missing_output_buffer);
> +	g_test_add_func("/a2dp/endpoint/oversized-caps",
> +			test_endpoint_parser_rejects_oversized_caps);
> +	g_test_add_func("/a2dp/endpoint/fuzz-bounds",
> +			test_endpoint_parser_fuzz_cases_keep_bounds);
> +
> +	return g_test_run();
> +}

--=20
Pauli Virtanen
