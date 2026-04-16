Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC945368964
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367059; cv=none; b=K5JD7WL/fdpJr2/whbmOnMxoIiid4SR1dT8B6527JPznSR565Go0wCrbeDikkAoSX1o4docjOeyGf8vH9+cRlUHvWDJp88bUCcxITfeZhkXpb7wkChaaePh+ppXy4VfYFBnn+mw7VyIqLYFrg3Hfrtl2lvjCcKuIi/iWSuT1Qe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367059; c=relaxed/simple;
	bh=WAhBccDaV0iVjhkAS52iyUaRYoG/FAPdLIvSXRKGzvw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VNyAhfIYSX5v0WuDZrIYXhq+N3Xq+P78PqH3WlmvgXoVTA5iAKwiwIrmXhvvoDn9U/9w1qyboanSiS70COmEk1hcfFMhl/LG5BZXW4xrIGtWInXo/1Wd917o1Tptw6qZrBbdIqY4LEVRSLp3pnd07EDiau0SMzJi3WJp128UL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5A123ED6F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 19:17:34 +0000 (UTC)
Message-ID: <9d448d86c41020c2b820568aa0ee981d6437b798.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] unit: Add unit test for new MIN/MAX macros
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 16 Apr 2026 21:17:34 +0200
In-Reply-To: <20260401204527.148077-1-hadess@hadess.net>
References: <20260401204527.148077-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTFv5+x7moDISKVv3nfJ7oNoGJ7E/d0wEvRl4OIJT+xaNehxjyqtL0q1A+mpvzEy/FOTxAhgpgdJHFKNB/jF7mNOVBbXDTivcn/g0VS0Z/bQqdmbDff3s5qJUTYDv6btsrj7WPwRIug1IDsb9UMHD6HMm8UucJei8Ye+bj9Qzw8F3N30/6NunSyLUWERI/ez4BMHiYCeGHL6eJu4JCwFnMgajBT/9yq4+lUkarwHpDJcgV3XdqWNZsG/snBlz+1vvy8gEjXxGWAT42zNiJ8ub7Ve3AdZVzBeqA/vTmqA9aRt6UN6s65c3NMwpV0kfSx02+GKGowj7xUshJQzyi9pqn3qXDZFxEIRsfmsRO7s7sX0m8K0IyqAhj2myNOFY4h8R00m39pKojotu/hs1MKmHaE3puYjH+f2d4o6O6sg+tEX7t1v5XXFsbpf5tT048w81HFCqY8AoCdPklga1t/Fa2ku2Sb5yzZ+WGckbibVHd0z4D8xfHm7oBHzMOK1hYWdZlIXOsZgfYLIOMb/E0S4CGJRB9hS9ptvKeOvzwyQKiTNq0RLeqGUxFU6ojgrRwFfkWTFMjCqL4KXLc9SvvIoqnleRKmb/Z6vq8nl59NKVqLH2XRYlFbFyVYPA6mBGtUA6QeiijTDTi75LUZ3//ZjLXex2R8GU5JIAQTayUO4rWNXYA
X-GND-State: clean
X-GND-Score: 0

Hey Luiz,

I believe those 2 patches are also ready for review.

Cheers

On Wed, 2026-04-01 at 22:45 +0200, Bastien Nocera wrote:
> ---
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0unit/test-util.c | 34 ++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 38 insertions(+)
> =C2=A0create mode 100644 unit/test-util.c
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 2cfb884f1851..d9de71d587d8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -696,6 +696,10 @@ unit_test_lib_SOURCES =3D unit/test-lib.c
> =C2=A0unit_test_lib_LDADD =3D src/libshared-glib.la \
> =C2=A0				lib/libbluetooth-internal.la
> $(GLIB_LIBS)
> =C2=A0
> +unit_tests +=3D unit/test-util
> +unit_test_util_LDADD =3D src/libshared-glib.la \
> +				lib/libbluetooth-internal.la
> $(GLIB_LIBS)
> +
> =C2=A0unit_tests +=3D unit/test-gatt
> =C2=A0
> =C2=A0unit_test_gatt_SOURCES =3D unit/test-gatt.c
> diff --git a/unit/test-util.c b/unit/test-util.c
> new file mode 100644
> index 000000000000..8ab16cc083ba
> --- /dev/null
> +++ b/unit/test-util.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *=C2=A0 BlueZ - Bluetooth protocol stack for Linux
> + *
> + *=C2=A0 Copyright (C) 2026=C2=A0 Bastien Nocera <hadess@hadess.net>
> + *
> + *
> + */
> +
> +#include <assert.h>
> +
> +#include "src/shared/util.h"
> +#include "src/shared/tester.h"
> +
> +/* XXX glib.h must not be included, or it will clobber the
> + * MIN/MAX macros */
> +
> +static void test_min_max(const void *data)
> +{
> +	assert(MIN(3, 4) =3D=3D 3);
> +	assert(MAX(3, 4) =3D=3D 4);
> +	tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	tester_init(&argc, &argv);
> +
> +	tester_add("/util/min_max", NULL, NULL,
> +			test_min_max, NULL);
> +
> +	return tester_run();
> +}
