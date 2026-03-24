Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E2390208
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341718; cv=none; b=hvHprpdtVH1OuKuj3cmotp3VAIZE1Ceq4q09AHfYDA0d1n/+sYGt6UNE1AD9/YeuL++0bfwo4SJCwXONvv6dr0UJnq84a4Rcfikj1rwfVzFjv6FIJmtgTYx4Qm0GfGErzprSBlNTDB7KxfIWj6oHPAqffm1jDjPopr6i+3j+CPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341718; c=relaxed/simple;
	bh=wvRObholTWXQn5qitZ/hu32OHJobKb0XS21aJn27/X0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwIVbwhbaPuixEtbjd2+JZiYHSbvW3VX0ey49gl1tc5EWiHrEuZIl0Tvy2KdA88d42yYI4Ht2G2Ghn/6p6Nenw2Zhpi+U1XtLA6hmGW1vWcA5zpIogro2Fn0C5gZIU0l1kk9oCTXjPAGZK+ZJ3qMayKSDrmgPCFxzjuDlYUOhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BC353ED4F;
	Tue, 24 Mar 2026 08:41:43 +0000 (UTC)
Message-ID: <1a71518d9dff54e50b8da0663f293ea7afcce94e.camel@hadess.net>
Subject: Re: [PATCH] obexd/bip: Fix uninitialized memory and malformed XML
 in GetImage request
From: Bastien Nocera <hadess@hadess.net>
To: maxing <2965346066@qq.com>, linux-bluetooth@vger.kernel.org
Date: Tue, 24 Mar 2026 09:41:42 +0100
In-Reply-To: <tencent_855A3D40BA68914559569DE8F0A84AC00C09@qq.com>
References: <tencent_855A3D40BA68914559569DE8F0A84AC00C09@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgeeuveefheefgfffgefhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopedvleeiheefgeeitdeiieesqhhqrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

On Mon, 2026-03-23 at 08:48 +0800, maxing wrote:
> This commit addresses several defects in the AVRCP BIP GetImage
> implementation that caused strict OBEX servers (e.g., Android)
> to reject image transfers with "Precondition Failed (0x4C)".
>=20
> 1. Fix uninitialized memory read:
> =C2=A0=C2=A0 In `get_image()`, the `maxsize` variable was not initialized=
. If
> the
> =C2=A0=C2=A0 client omitted the "maxsize" key in the D-Bus dictionary,
> `maxsize`
> =C2=A0=C2=A0 retained garbage data from the stack, leading to anomalous l=
og
> entries.
>=20
> 2. Fix malformed XML image descriptor:
> =C2=A0=C2=A0 When D-Bus clients omitted the `pixel` or `encoding` paramet=
ers,
> =C2=A0=C2=A0 `parse_get_image_dict()` improperly forced them to empty str=
ings
> ("").
> =C2=A0=C2=A0 This resulted in `get_image()` generating an invalid XML tag=
:
> =C2=A0=C2=A0 `<image encoding=3D"" pixel=3D""/>`.
> =C2=A0=C2=A0 The XML construction logic has been rewritten to dynamically
> append
> =C2=A0=C2=A0 only the provided attributes, and the previously parsed but
> ignored
> =C2=A0=C2=A0 `maxsize` attribute is now properly included if specified.
>=20
> 3. Fix D-Bus iterator advancement:
> =C2=A0=C2=A0 Removed a redundant D-Bus type check in `parse_get_image_dic=
t()`
> =C2=A0=C2=A0 where the iterator was evaluated twice before calling
> =C2=A0=C2=A0 `dbus_message_iter_next()`.

I think that it would be useful for you to split those 3 fixes into 3
separate commits in a single patchset, which would make it easier to
review individually.

Regards

>=20
> Signed-off-by: maxing <2965346066@qq.com>
> ---
> =C2=A0obexd/client/bip.c | 31 ++++++++++++++++---------------
> =C2=A01 file changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/obexd/client/bip.c b/obexd/client/bip.c
> index ec75fdd67..7c724b4b4 100644
> --- a/obexd/client/bip.c
> +++ b/obexd/client/bip.c
> @@ -38,9 +38,6 @@
> =C2=A0
> =C2=A0#define EOL_CHARS "\n"
> =C2=A0#define IMG_DESC_BEGIN "<image-descriptor version=3D\"1.0\">"
> EOL_CHARS
> -#define IMG_BEGIN "<image encoding=3D\"%s\" pixel=3D\"%s\""
> -#define IMG_TRANSFORM " transformation=3D\"%s\""
> -#define IMG_END "/>" EOL_CHARS
> =C2=A0#define IMG_DESC_END "</image-descriptor>" EOL_CHARS
> =C2=A0
> =C2=A0static DBusConnection *conn;
> @@ -206,9 +203,9 @@ static gboolean parse_get_image_dict(DBusMessage
> *msg, char **path,
> =C2=A0		goto failed;
> =C2=A0	dbus_message_iter_get_basic(&iter, path);
> =C2=A0	*path =3D g_strdup(*path);
> +	dbus_message_iter_next(&iter);
> =C2=A0	if (dbus_message_iter_get_arg_type(&iter) !=3D
> DBUS_TYPE_STRING)
> =C2=A0		goto failed;
> -	dbus_message_iter_next(&iter);
> =C2=A0	dbus_message_iter_get_basic(&iter, handle);
> =C2=A0	*handle =3D g_strdup(*handle);
> =C2=A0	dbus_message_iter_next(&iter);
> @@ -258,13 +255,11 @@ static gboolean
> parse_get_image_dict(DBusMessage *msg, char **path,
> =C2=A0		dbus_message_iter_next(&array);
> =C2=A0	}
> =C2=A0
> -	if (*pixel =3D=3D NULL)
> -		*pixel =3D strdup("");
> -	if (*encoding =3D=3D NULL)
> -		*encoding =3D strdup("");
> -
> -	DBG("pixel: '%s' encoding: '%s' maxsize: '%lu' transform:
> '%s'",
> -			*pixel, *encoding, *maxsize, *transform
> +	DBG("pixel: '%s' encoding: '%s' maxsize: '%llu' transform:
> '%s'",
> +			*pixel ? *pixel : "",
> +			*encoding ? *encoding : "",
> +			(unsigned long long)*maxsize,
> +			*transform ? *transform : ""
> =C2=A0	);
> =C2=A0
> =C2=A0	return TRUE;
> @@ -283,7 +278,7 @@ static DBusMessage *get_image(DBusConnection
> *connection,
> =C2=A0	struct bip_avrcp_data *bip_avrcp =3D user_data;
> =C2=A0	char *handle =3D NULL, *image_path =3D NULL, *transform =3D NULL,
> =C2=A0		*encoding =3D NULL, *pixel =3D NULL;
> -	uint64_t maxsize;
> +	uint64_t maxsize =3D 0;
> =C2=A0	struct obc_transfer *transfer;
> =C2=A0	GObexHeader *header;
> =C2=A0	DBusMessage *reply =3D NULL;
> @@ -310,10 +305,16 @@ static DBusMessage *get_image(DBusConnection
> *connection,
> =C2=A0	obc_transfer_add_header(transfer, header);
> =C2=A0
> =C2=A0	descriptor =3D g_string_new(IMG_DESC_BEGIN);
> -	g_string_append_printf(descriptor, IMG_BEGIN, encoding,
> pixel);
> +	g_string_append(descriptor, "<image");
> +	if (encoding !=3D NULL)
> +		g_string_append_printf(descriptor, "
> encoding=3D\"%s\"", encoding);
> +	if (pixel !=3D NULL)
> +		g_string_append_printf(descriptor, " pixel=3D\"%s\"",
> pixel);
> +	if (maxsize > 0)
> +		g_string_append_printf(descriptor, "
> maxsize=3D\"%llu\"", (unsigned long long)maxsize);
> =C2=A0	if (transform !=3D NULL)
> -		g_string_append_printf(descriptor, IMG_TRANSFORM,
> transform);
> -	g_string_append(descriptor, IMG_END);
> +		g_string_append_printf(descriptor, "
> transformation=3D\"%s\"", transform);
> +	g_string_append(descriptor, "/>" EOL_CHARS);
> =C2=A0	descriptor =3D g_string_append(descriptor, IMG_DESC_END);
> =C2=A0	header =3D g_obex_header_new_bytes(IMG_DESC_TAG, descriptor-
> >str,
> =C2=A0						descriptor->len);
