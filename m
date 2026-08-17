Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA53C3787
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956098; cv=none; b=q/SKnM6DoJTFmbwr498+G3LWGkUIo5O7Z6xcBgo2OPqvq3j7GLWx9v0oHXFUStBROxXUN3AotYuI7YrCK6GTcIJHp6WTQMEb5/XpCzYd1XFnlS0uG6S5lN+a8tUkv75ivt6urx04bcJHGYBbEt+5r72B9zJC5ZXhrNDm/rsEnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956098; c=relaxed/simple;
	bh=Gn4ZbxNEVJLxlk6wUfb7/O/CK2mSp0HSNjsqYiBBzUQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsM5ZGCDjpwy9iWsR0rXoCPeJrvIE1X77n62qDTMXj8ZuTPz2P+eEN/wGFejeeuK+peA8PFAZ4UbjKnXWLwROlR3vCFdpL3XL7lpV33KrwHlqWqzhKhl2TanO1xtQrUoyvK+JbQrGFe+SXznH3+TrrTXrXXkL+OgK7AI55F8jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19B943EB90;
	Mon, 17 Aug 2026 08:41:29 +0000 (UTC)
Message-ID: <8664f27d1427fac3a37f3be0f97f40c6af4d097c.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 2/3] unit/test-sdp-xml: Give each test its own
 test_data
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 17 Aug 2026 10:41:28 +0200
In-Reply-To: <20260814174731.1441738-2-luiz.dentz@gmail.com>
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
	 <20260814174731.1441738-2-luiz.dentz@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEx4HHALaOJ/XphvcxGcPItnSOZS7n7ZnDcm3IdV2LQ/TGBvJ/0nUFWDBz6OzI4azR+2Nj4IEdSBEdLhA9NcgTN02o2vDqC4mxug9dv8/mO05Wa4v3NRhSLER3qsrGIss0kkl+S/3X2b5R9hm5TBU/SYc0VonWF413AdWdwd6uuew/kNUSyowlT4nTlSz0aDQXE3+eyARKo9SnwKZM6U4afzfGZ7W22IOm9DZIlSRtHWWuHoVkeeyE0zoctmzfoY5dco7DVi1Nx/Dugcv3RtHoxg4Fp4d6p/iNaeG0+dWBAwnzgePnkeetMI951OqlXUf5NjD/IB98M2l1T+xiQ5oUQtZcfFwkL2wh0dWY9ZP9vw7J41MMho298YOmrQ2MHK4T68KJ4HWorJc/HsS8PnWEA4tdJsVBHbDqS1+CH8TuyBIb6Q3vqDLHpCSK8qRbNbmHLpEuN7QAlKEjryIepFu1GXhs2yv42syQGSVoPqE1ZsZgJHMLKKVInym9aleQkW+RtmNFvGOI8pvRn2aPmgQNprckhZRFpGO3Dq1I4eiZjw+GLKHVGjPwEQ/EZB2krVK4+Sp3IeMK0Wq2wCr16qtUn3nsCVF/BPdb7QQJqceP5YMghj1Hio5DHYYFjOTAI/oaeYfcH42Gi/j7ss1GiWwGmFa2R7cDX7M3wjSAtGtK88w
X-GND-State: clean

On Fri, 2026-08-14 at 13:47 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> DEFINE_TEST assigned the filename and expected result to a single
> test_data and passed its address to tester_add(), so every test
> shared
> one struct and ran with whatever the last registered test left in it.
>=20
> All the file based tests therefore parsed the same file, and a test
> pointing at a file that does not exist still passed.
>=20
> That in particular meant compute-seq-size-type-confusion.xml, the
> regression test for GHSA-7mmr-gwqx-vc34, was never actually parsed,
> and
> passed only because it inherited the expected result of the test
> registered after it.

That's not quite correct. The fix introduced memory leaks, which you're
fixing in "sdp-xml: Fix leaking the parse stack on malformed input",
but it fixed the original crash.

This test would only fail when run under ASan.

I just want to be clear that this fix doesn't have an impact on GHSA-
7mmr-gwqx-vc34 being resolved earlier.

>=20
> Use an array with one entry per test instead.
>=20
> Assisted-by: Claude:claude-opus-5
> ---
> =C2=A0unit/test-sdp-xml.c | 34 ++++++++++++++++++++++------------
> =C2=A01 file changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
> index b338788aa295..72e01f5f5806 100644
> --- a/unit/test-sdp-xml.c
> +++ b/unit/test-sdp-xml.c
> @@ -114,25 +114,35 @@ static void
> sequence_on_squared_teardown(gconstpointer data)
> =C2=A0	tester_teardown_complete();
> =C2=A0}
> =C2=A0
> -#define DEFINE_TEST(fname, res)
> {					\
> -	data.expected_result =3D
> res;					\
> -	data.filename =3D
> fname;						\
> -	tester_add("/" fname, &data,
> NULL,				\
> -			parse_xml_for_filename,
> NULL);			\
> -	}
> +#define DEFINE_TEST(fname, res) { .filename =3D fname,
> .expected_result =3D res }
> +
> +/*
> + * Each test needs its own test_data, sharing a single one would
> make every
> + * test run with the values assigned by the last one registered.
> + */
> +static struct test_data file_tests[] =3D {
> +	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE),
> +	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE),
> +	/* From
> https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34
> =C2=A0*/
> +	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE),
> +	/* From
> https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc
> =C2=A0*/
> +	DEFINE_TEST("duplicate-attribute.xml", TRUE),
> +};
> =C2=A0
> =C2=A0int main(int argc, char *argv[])
> =C2=A0{
> =C2=A0	struct test_data data;
> +	unsigned int i;
> =C2=A0
> =C2=A0	tester_init(&argc, &argv);
> =C2=A0
> -	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
> -	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
> -	/* From
> https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34
> =C2=A0*/
> -	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
> -	/* From
> https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc
> =C2=A0*/
> -	DEFINE_TEST("duplicate-attribute.xml", TRUE);
> +	for (i =3D 0; i < G_N_ELEMENTS(file_tests); i++) {
> +		char *name =3D g_strdup_printf("/%s",
> file_tests[i].filename);
> +
> +		tester_add(name, &file_tests[i], NULL,
> +				parse_xml_for_filename, NULL);
> +		g_free(name);
> +	}
> =C2=A0
> =C2=A0	tester_add("/sequence_on_squared", &data,
> =C2=A0		=C2=A0=C2=A0 sequence_on_squared_setup,
