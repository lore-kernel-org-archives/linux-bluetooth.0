Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD003D9020
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213700; cv=none; b=dsvinGHVKQd8WBsavgkniCXCe5J1ds38MnVajCnM/WH/T6uwyTW7V+ReKjL+EcaRxwzVbHfT5LOm3XPm9wl/nXZIYz5QJOwmmOuKgOg+WqDgLaTCO+l4//9tu1YQtz/T9N7vN/2bl4ru86AjmP6Wh1TWj6zWOtDHkC9xl8Suffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213700; c=relaxed/simple;
	bh=O9yMLsdSiKuVpk5qbLdKaJopjCO6KNih9voVJ8rIeK4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NdrDLmvNq6EFhqWJO69R9fApnf3/SRDiU5B9vgPJydrx88yUxaUtFJdGcc42h5oAW7EMgBFjDfXaZz3c+0YdtPJdh8a205DGertDnYxmvMxIbiiSJDHW0+75hIuv564uNXwG5Gc9kZmTjqKWeteq6V3XDkhgC5/dM+ooLdVFOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A0703E9F5;
	Thu, 20 Aug 2026 08:14:49 +0000 (UTC)
Message-ID: <ba37fe7179e00e7c4e4a2c62af8b65dfec827f35.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 1/8] eir: Fix stack buffer overflow when
 parsing the remote name
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 20 Aug 2026 10:14:49 +0200
In-Reply-To: <9ae70f091f093a644bec0f6ebc030e36a1f7a853.camel@hadess.net>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
		 <20260819204008.2292225-2-luiz.dentz@gmail.com>
	 <9ae70f091f093a644bec0f6ebc030e36a1f7a853.camel@hadess.net>
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
X-GND-Cause: dmFkZTEFw2Ck6ca2nfyhO/ZppXrk730zW2qY6szT+glp9fj5h8tt5iZe2vPpbLAwVtIPECkrTFO3VBkwhi0qxWfJ7Fiq4/Z6o++tMjn0jbAt6UMeyeR3Iz1WCtlY7I8f+seOIeu9OOBEdOQY2zz8Qdvfjvhp6A+TUI5pZEAkaeZ8zjPP0QepRZJ7PNw0oruiHG8t6xSOPRb6gGERiHEXnojHcjieEiwGfWSyhQTrlAnyMzft0W+7tIZUUbNOlY1Q9ws6m3NCUejlCUtALrQLRpx9GokcFiWF9jyJJuIKWw/33gENDlbPrwmcLI71gSrsq7q5PCU4tVOEdG3iIq08THQMt6+2tKuzi2v35bYLYBjmE/6O5pjUrA9mmHXkglfe7xeVgFz6sRDk17CbZv1FbtsV2z5m6ZwRJS0wfOXInk5O2MBcvlIDHc3mSnfaBhrBy9MMnlF7I2hjH3XtRii+Yj9SMCg1zU5a9Rb0dabe4/nwtPebBwTfy/gGDls3cA1uku8mJ8Tej2lTi+4hae92aVxsl/VnMNbFvUQ+SH0K+9VYrZLIwYgsQw28xth/FAHx0MxzrKP6HM+ICg5Q/tJW8T33uTSI+UAkBKx4+hMlBNaHR8+5aDpbmd8GAuR2G6dHY2E0/kp4ID+g8EhWZRpgziSb/Hg5XjFo5xjyJ/RrL4VaMImWxQ
X-GND-State: clean
X-GND-Score: -100

On Thu, 2026-08-20 at 09:46 +0200, Bastien Nocera wrote:
> On Wed, 2026-08-19 at 16:40 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > name2utf8() copies len bytes into a HCI_MAX_NAME_LENGTH + 2, so
> > 250,
> > byte stack buffer without clamping len first.
> >=20
> > eir_parse() only rejects a field once it runs past the end of the
> > EIR
> > data, and that data is up to 255 bytes, so field_len can be 254 and
> > the
> > data_len passed to name2utf8() can reach 253. strncpy() then writes
> > 253
> > bytes into the 250 byte buffer and leaves it unterminated, so the
> > following g_strstrip() and g_strdup() also read past the end.
> >=20
> > The EIR data comes from a remote device, either in an extended
> > inquiry
> > response or in an advertising report, so the length is attacker
> > controlled.
> >=20
> > Clamp len like the other name2utf8() copies already do. Parsing a
> > 253
> > byte EIR_NAME_COMPLETE field returned a 253 byte name before this
> > change, and returns a 249 byte one after it.
>=20
> This issue was embargoed, and this commit is the exact same one I
> sent
> privately to fix that issue.
>=20
> It would be nice to have either the authored-by or co-authored by
> tag.
> Could you please also make sure to add:
> "
> Reported-by: @sprabhav7 (Prabhav S)
>=20
> See:
> https://github.com/bluez/bluez/security/advisories/GHSA-68h6-5qgp-3975
> "
>=20
> To the commit message. I'll work on the security advisory to get it
> published.

I've also attached below a test case for the issue at hand. It should
probably be using name2utf8() first, then be adapted like the other
users were in "Replace the name2utf8 copies with str2utf8".

From 6664a7b7ff9a1ae9045b64c834179895afe720bf Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 12 Aug 2026 11:55:33 +0200
Subject: [PATCH] unit: Add name2utf8() test

Co-authored-by: @sprabhav7 (Prabhav S)

See: https://github.com/bluez/bluez/security/advisories/GHSA-68h6-5qgp-3975
---
 unit/test-eir.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index a4b6743e48b7..b51a5e1d65b0 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -701,6 +701,22 @@ static void test_parsing(gconstpointer data)
 	tester_test_passed();
 }
=20
+#define TRUNCATED_NAME "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
+
+static void test_name2utf8(const void *data)
+{
+	uint8_t name_len =3D 253;
+	uint8_t malicious_name[name_len];
+	char *ret =3D NULL;
+
+	memset(malicious_name, 'A', sizeof(malicious_name));
+	ret =3D str2utf8(malicious_name, name_len);
+	g_assert_cmpstr(ret, =3D=3D, TRUNCATED_NAME);
+	g_free (ret);
+
+	tester_test_passed();
+}
+
 static const unsigned char gigaset_gtag_data[] =3D {
 		0x02, 0x01, 0x06, 0x0d, 0xff, 0x80, 0x01, 0x02,
 		0x15, 0x12, 0x34, 0x80, 0x91, 0xd0, 0xf2, 0xbb,
@@ -743,6 +759,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
=20
 	tester_add("/eir/basic", NULL, NULL, test_basic, NULL);
+	tester_add("/eir/name2utf8", NULL, NULL, test_name2utf8, NULL);
=20
 	tester_add("/eir/macbookair", &macbookair_test, NULL, test_parsing,
 									NULL);
--=20
2.55.0
