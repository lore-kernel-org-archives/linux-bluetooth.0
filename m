Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3F1DED5C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081385; cv=none; b=jcZSzIrPQV0RgEbC/B9Apr+Ndf/O8yYSvnqIO4Uflua5ipJ3IAvsHzoTQKPEEAfvLVEWB74FIqQ1TMtSHLKi4T6Zat9asbxsu/GTGx8brqUTAo8egaIWk/fQdUzQJLdFadY6Y8GkPNNYvwkwkO5yihK/NrRP5+HcDf6oe/JhKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081385; c=relaxed/simple;
	bh=VAONhY56n8yVcKTWF1OEVMKp0bsphq4s7kPlDHIOgVQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqG/wqYoSBaY7SXSfKIeMqZYdBNQNsMzuZyztCShfldZGJ2bH7N4PKi39cyrNYjv1b4rxQHx8gm8YQbHq4FSiX63iDuyXsDPV6x0Ouwkue0GKDiapiSy3E6hDN5upoPlQQZSQDsmO5QNeHY5rkIXxrxyrH/aG4HODEScbfmWXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C49E43E985
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:49:34 +0000 (UTC)
Message-ID: <4b2bb488958446cf8ea6db7769919695700eb17e.camel@hadess.net>
Subject: Re: "cleanup" variable attribute follow-up
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Jun 2026 10:49:34 +0200
In-Reply-To: <6a284da8.7dd3efdf.a331b.6852@mx.google.com>
References: <20260609135837.476561-2-hadess@hadess.net>
	 <6a284da8.7dd3efdf.a331b.6852@mx.google.com>
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
X-GND-Score: 0
X-GND-Cause: dmFkZTGgVT0wLiKuvnCY7tnwlXI8df84jhusFuM5wFKn1mQKvnMry5P935LJdImEfwBFjUC3s2ltGWIs3DGoLn3R/yDwOFld/KBsKb/a0On3dtWF1v3pO6a7PvoIFo/uuofoxxtmWQC025R4eN64o1W+SECOHJssHEqWoqcXnFZ6teJ99FbIKcNYAmzjjKw8sjuOhUbNcprLTw2/HnKGUSAiU/S1XsU7rlI/T0FCc5KsVrHozyp+HA84j3Wrc7IHUY3KW+yQomEyAD5f7d4KyfYI2EOg0P2jHtNtu3vNt5IT2DkFk+z1vbtYOy8x2aa7wdlCHuub6WLhOi3q2b/F8sFCuajVApLlZmkPjlZSGGqh88UKv32dA1shxDNuFkoBPyhRpU1C2E/O9Y15WrKfp/1YweqYPDIP1nv9lD/qkHV62ANbpmpU4nxHBzSdY0zwaAACgZCF463O/5DERdZBg0+b9Hltku3FCKBnE6+tO9+yqolYpIBSPzb/9NE5yRyYJdV9MtVQazqh5lPRMnuq96nFlFkwFKD43VZ9AwEhcwSvgvQrUL7omQ/S/1bWcmKPgX4CR4/I31dQFjtp9yuxI+4kRyiktm1DXfInQ9/hHPzNG8yTWu7XisZ26S18CUYW+HkNIt+7yT7Yt3ivE8G2aq+1UeQoRXf1tApVOnTXfiS268mQ3g
X-GND-State: clean

I have fixes for some of the warnings checkpatch threw:
https://github.com/hadess/bluez/commit/1f69ae6c89e6811f554087a35152b9e5b5f2=
0e5c

Let me know if you want me to send them in a v2.

Cheers

On Tue, 2026-06-09 at 10:30 -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
>=20
> Dear submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing
> list.
> This is a CI test results with your patch series:
> PW
> Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D1108
> 616
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FAIL=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.51 seconds
> GitLint=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.73 seconds
> BuildEll=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16.19 seconds
> BluezMake=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 498.81 seconds
> MakeCheck=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 18.30 seconds
> MakeDistcheck=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 189=
.35 seconds
> CheckValgrind=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 217=
.95 seconds
> CheckSmatch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARNING=C2=A0=C2=A0 253.71=
 seconds
> bluezmakeextell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 131.42 secon=
ds
> IncrementalBuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 985.31 seconds
> ScanBuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PASS=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 733.50 seconds
>=20
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [BlueZ,1/6] shared/util: Fix warnings when cleaning up NULL pointers
> WARNING:LONG_LINE: line length of 94 exceeds 80 columns
> #74: FILE: src/shared/util.h:130:
> +	static inline void cleanup_##type (type **_ptr) { if (*_ptr
> !=3D NULL) (func) (*_ptr); }

Fixed.

> WARNING:SPACING: space prohibited between function name and open
> parenthesis '('
> #74: FILE: src/shared/util.h:130:
> +	static inline void cleanup_##type (type **_ptr) { if (*_ptr
> !=3D NULL) (func) (*_ptr); }

Fixed

>=20
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxO)
> #74: FILE: src/shared/util.h:130:
> +	static inline void cleanup_##type (type **_ptr) { if (*_ptr
> !=3D NULL) (func) (*_ptr); }

Bogus.

> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
>=20
> ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
> #74: FILE: src/shared/util.h:130:
> +	static inline void cleanup_##type (type **_ptr) { if (*_ptr
> !=3D NULL) (func) (*_ptr); }

Fixed.

>=20
> /github/workspace/src/patch/14619750.patch total: 2 errors, 2
> warnings, 8 lines checked
>=20
> NOTE: For some of the reported defects, checkpatch may be able to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mechanically convert to the typical style =
using --fix or --fix-
> inplace.
>=20
> /github/workspace/src/patch/14619750.patch has style problems, please
> review.
>=20
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO
> CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED
> SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>=20
> NOTE: If any of the errors are false positives, please report
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them to the maintainer, see CHECKPATCH in =
MAINTAINERS.
>=20
>=20
> [BlueZ,4/6] main: Use _cleanup_() to simplify configuration parsing
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #90: FILE: src/main.c:265:
> +	_cleanup_type_(GError) GError *err =3D NULL;

Those are all bogus, not sure why it's complaining there.

> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #114: FILE: src/main.c:447:
> +	_cleanup_type_(GError) GError *err =3D NULL;
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #210: FILE: src/main.c:895:
> +	_cleanup_type_(GError) GError *err =3D NULL;
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #415: FILE: src/main.c:1214:
> +	_cleanup_type_(GError) GError *err =3D NULL;
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20
> ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> #507: FILE: src/main.c:1577:
> +	_cleanup_type_(GError) GError *err =3D NULL;
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>=20
> /github/workspace/src/patch/14619699.patch total: 5 errors, 0
> warnings, 420 lines checked
>=20
> NOTE: For some of the reported defects, checkpatch may be able to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mechanically convert to the typical style =
using --fix or --fix-
> inplace.
>=20
> /github/workspace/src/patch/14619699.patch has style problems, please
> review.
>=20
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO
> CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED
> SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>=20
> NOTE: If any of the errors are false positives, please report
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them to the maintainer, see CHECKPATCH in =
MAINTAINERS.
>=20
>=20
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> src/main.c: note: in included file (through src/device.h):
>=20
>=20
> https://github.com/bluez/bluez/pull/2201
>=20
> ---
> Regards,
> Linux Bluetooth
