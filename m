Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A233AD9C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015025; cv=none; b=u/JDW42I4ECvsN/RqVycQGTJRJHdAmSK5J0Q9SJ1nU5IIN4pUPhaUzVaifYmCUVMusIJrYltez8h3S3/KD4rrYK/Nqg48LVoCIr3IHvuZhl4NlMPkDpBx6jE5xrzVVK+t1PO5I7ocvS4qXpnBpROrDhG7fiJAppfENamLrKuvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015025; c=relaxed/simple;
	bh=4Y3tN00T/yYDcPf1vaSebXD4nMVcGIcdphmPm/ta8YM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJDdwMy8xLNAs8vurTlyLQWTmKGbOp/X+o+3nSUb4+0q14HqiOCCc159g1teO2DehJ8FAf9bHt8ciBZmL8tV6IU9rJyPrxQaKfmUDYCU7Ldw4OzQWjbrN9yiE8Ha6EdcnZJeXzq0m8lpBQh0K8znY4Hrtp+bMRqlwDQyXl3Mzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 4C8F2580E3B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D4FC3EDD2;
	Tue,  9 Jun 2026 13:58:41 +0000 (UTC)
Message-ID: <2bcdb83c7bd826751add1fabc414ce8987bc5e9b.camel@hadess.net>
Subject: Re: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Jun 2026 15:58:40 +0200
In-Reply-To: <fa6f77805bd81b200a0af16287fb81c3fc16e7b2.camel@iki.fi>
References: <20260511132131.1283892-1-hadess@hadess.net>
		 <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
		 <CABBYNZ+RZH25K0jhRsrTbYOZxQQeV9EvxYK907sgGW0Ot-mR3Q@mail.gmail.com>
	 <fa6f77805bd81b200a0af16287fb81c3fc16e7b2.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTG0mXUgJpguryFH/3Zx8z4wGhecYWZw60CYRRkoCZFl1rAV8ajK9lqcCpOxj5wDQd7jCReLHyrMifhL92o6HNuT4gZmOKQTNT7Qbt/lz2v/zcJOwRySkvC8iAScE9ggu9J5GDHBcmPwEPFittLYgmrgS71fMVQ193xQSKXRE4ZwkiHwCaZOa+Aa0u3N10mzhvD7HKUSWTmEVl/00QVL8rd2OkvmLAmXthy0BqWdEOiMxz0emE/JTxdV6IW7oCHxxq+eWtgPRfbEsv+W38kxw9vNm5Yhl5XV7LnTr2sTelIuRC3KuXkqTaOftzf48Gb6XPvz6fKPtIuv7ih5vIFcL6HvgzmHvC7Je0hhA8KJlCGoGMixBCWnX4jpJpFK1S/Yi8g2am9auveVEgu/V9iIzeJyceyTOGk2lP/BlMESqff22x747ZZtLSR4axcit0I1fVnzmZs3WPpjZaP+ssenUn3VizE/+ZmwftjEV1BdIPzjKTTzmjWusDXY782+SiEX9MI35Oh8MIPtFJ5o6Ke6nGEUzMlh3RW81wrx8h2j8IBUPzFABngO3Ff+bDqr2HnCwdb+phurtol8t6tZGT9PTYWSM8X67Q1Dhm3a6w0Fdf5wZeWIii1UoVmUj8YvYGJfBwa0XMBpRNzdDYn64EMlTL8XDkuZtMiN4nIosvlkhkYGig

Hey,

Coming back to this nearly a month later.

On Tue, 2026-05-12 at 23:40 +0300, Pauli Virtanen wrote:
> I think it needed something like the below.
>=20
> I think it would be better to have _steal_() and _steal_fd_() be
> macros
> so that compiler can check the types so you can't mistake
> _steal_(keyfile) and _steal_(&keyfile)
>=20
> https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/spa/includ=
e/spa/utils/cleanup.h

I've implemented something "similar" (only so many ways to skin a
cat...), thanks.

> Not sure what can be done about the _cleanup_(g_free) char *str ---
> it
> would be great if this generated compiler warning/error but it looks
> like it didn't, so maybe this macro should be private so you're
> forced
> to declare the CLEANUP_FREEFUNC always.

Nowadays, calling g_free() just calls free():
https://github.com/GNOME/glib/blob/main/glib/gmem.c#L208
so we could replace this all with _cleanup_free_(), if we were to bump
the glib requirements to match when glib started just calling free(),
in 2.46 (released in 2021).

Or we could use g_autofree, but that also would require bumping glib
requirements to 2.44.

I've implemented it the same way you did, copy/pasting the "free()"
functions in src/shared/util.h

> diff --git a/src/main.c b/src/main.c
> index 9053e74aa..9d1074c11 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -205,8 +205,20 @@ static const struct group_table {
> =C2=A0	{ }
> =C2=A0};
> =C2=A0
> -CLEANUP_FREEFUNC(GError, g_error_free);
> -CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
> +static void cleanup_g_error(GError *err)
> +{
> +	if (err)
> +		g_error_free(err);
> +}
> +
> +static void cleanup_g_key_file(GKeyFile *keyfile)
> +{
> +	if (keyfile)
> +		g_key_file_free(keyfile);

I added the "if p !=3D NULL" conditional to the macro directly.

> +}
> +
> +CLEANUP_FREEFUNC(GError, cleanup_g_error);
> +CLEANUP_FREEFUNC(GKeyFile, cleanup_g_key_file);
> =C2=A0
> =C2=A0static int8_t check_sirk_alpha_numeric(char *str)
> =C2=A0{
> @@ -291,7 +303,7 @@ static GKeyFile *load_config(const char *name)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> -	return _steal_(keyfile);
> +	return _steal_(&keyfile);
> =C2=A0}
> =C2=A0
> =C2=A0static void parse_did(const char *did)
> @@ -457,12 +469,19 @@ static bool parse_config_string(GKeyFile
> *config,
> const char *group,
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +static inline void cleanup_g_free(void *p)
> +{
> +	g_free(*(void **) p);
> +}
> +
> +#define _cleanup_g_free_ _cleanup_(cleanup_g_free)
> +
> =C2=A0static bool parse_config_int(GKeyFile *config, const char *group,
> =C2=A0					const char *key, int *val,
> =C2=A0					size_t min, size_t max)
> =C2=A0{
> =C2=A0	size_t tmp;
> -	_cleanup_(g_free) char *str =3D NULL;
> +	_cleanup_g_free_ char *str =3D NULL;
> =C2=A0	char *endptr =3D NULL;
> =C2=A0
> =C2=A0	if (!parse_config_string(config, group, key, &str))
>=20
> and so on for the rest of _cleanup_(g_free)
