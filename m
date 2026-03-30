Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E32DF136
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873856; cv=none; b=D3N8xrPECNT08BXv1SXESVeYbm+E0NZRvKcNiUeiGNa54j6Ej2cHm6a6zYw5BK1/wPiQz9N6vSz7jc4aO9ay8X5Evvu7zndjdod1iuz1preP6qKPz2vD1sEN8Q+UzV/jH0ikAiIWTusrGcDqHVbwnhykFIzMMsc4Q4UAnCZVbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873856; c=relaxed/simple;
	bh=A65XVjnfWCEicbXhgYWn9CKClmElL9qgiQPojauceH4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSDbsGfWA15rfDaIu1HpabjYG9i8Bj5I+5bdDTefsyl/rk/KO2dWHK/Y57m3GImecQM7iMqVo/XopkKQIBZlGiiJw5o/etzx8EMmoStkJiyeZaa5Qh27zhQ51A25MF6iVDLxPGLo6txvJYn4U9nXt6JHTTGgoTv5ya2pg3pcdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79CC23EC1B;
	Mon, 30 Mar 2026 12:30:46 +0000 (UTC)
Message-ID: <ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 02/20] emulator: btvirt: allow specifying where
 server unix sockets are made
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Mon, 30 Mar 2026 14:30:46 +0200
In-Reply-To: <41d54c33641f8a6004b3cb9a616c746119e2b156.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
	 <41d54c33641f8a6004b3cb9a616c746119e2b156.1774214693.git.pav@iki.fi>
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
X-GND-Cause: dmFkZTGZNaDYCvYHnLyGBTGayvcz2UjV9HrRbZgzOilq6nyL4nq2T67sdhGU4NkoMJTckWctzGawWvqA8CCiQhzEJy29StKferBPHOgur5AVK+h2xzfBuMUk6EzDAfDi4CoGuof0LsoTwWSA1tJiUDKRwyVQD8eOjK6LFMSj9BGqCT8IMGO6+zsbV9fDDuGj1g62siJvnoru4AeAXT44x/+k6S+OYEFuqBvBfVfqCzIkoOvcaucTdVMQC1MjJo65/o+xXcVN1tRyrXtlqFIMARM6fmh0PqdTGwlOID9MNz/ebo9vKIaGDybPdnAxrjNk0UPkH2k28NJABWWkLYTaVf2eUDj8sgFRzqcym8JDhCqNH3ha8/oB17T89qSpkxuje+DvtF5mBoIdT7JA0bdgyeyOjN9Y2AGes6SXr32ibaUK8Je0LUT0JWhwF8baTYQrTMyOddSRULh7XB4y2oC5gUPD4Xx3yvDORATdnoVGup4yhHRCqkVZS5igQ+/fxZo43fWJmAn6NsvACs+jXMcN5Pr7Bbovv3kKffyDeGCoRmU3eHL39ANS4yZ9CzYSgI/Fz2fb+5vFTFsIzbZPMSMVSw/yAiJG/NQtsgKVMpuwmcRc7Hq7MjRGaKcybGc+gdMh7n7aPG7NiIgbvSfUXHOGSg9gWGE1rFkS9hH5xbdwWAGb1htfpg
X-GND-State: clean
X-GND-Score: -100

On Sun, 2026-03-22 at 23:29 +0200, Pauli Virtanen wrote:
> Make --server to take optional path name where to create the various
> server sockets.
> ---
> =C2=A0emulator/main.c | 37 ++++++++++++++++++++++++-------------
> =C2=A01 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/emulator/main.c b/emulator/main.c
> index 456fcd98e..09d6e9adb 100644
> --- a/emulator/main.c
> +++ b/emulator/main.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <stdbool.h>
> =C2=A0#include <getopt.h>
> =C2=A0#include <sys/uio.h>
> +#include <limits.h>
> =C2=A0
> =C2=A0#include "src/shared/mainloop.h"
> =C2=A0#include "src/shared/util.h"
> @@ -46,7 +47,7 @@ static void usage(void)
> =C2=A0	printf("options:\n"
> =C2=A0		"\t-d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable debug\n"
> =C2=A0		"\t-S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Create local serial =
port\n"
> -		"\t-s=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Create local server
> sockets\n"
> +		"\t-s[path=3D/tmp]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cre=
ate local server
> sockets\n"
> =C2=A0		"\t-t[port=3D45550]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cre=
ate a TCP server\n"
> =C2=A0		"\t-l[num]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Number of local
> controllers\n"
> =C2=A0		"\t-L=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Create LE only
> controller\n"
> @@ -60,7 +61,7 @@ static void usage(void)
> =C2=A0static const struct option main_options[] =3D {
> =C2=A0	{ "debug",=C2=A0=C2=A0 no_argument,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 NULL, 'd' },
> =C2=A0	{ "serial",=C2=A0 no_argument,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NULL, 'S' },
> -	{ "server",=C2=A0 no_argument,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL=
, 's' },
> +	{ "server",=C2=A0 optional_argument, NULL, 's' },
> =C2=A0	{ "tcp",=C2=A0=C2=A0=C2=A0=C2=A0 optional_argument, NULL, 't' },
> =C2=A0	{ "local",=C2=A0=C2=A0 optional_argument, NULL, 'l' },
> =C2=A0	{ "le",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_argument,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 NULL, 'L' },
> @@ -88,6 +89,7 @@ int main(int argc, char *argv[])
> =C2=A0	struct server *server5;
> =C2=A0	bool debug_enabled =3D false;
> =C2=A0	bool server_enabled =3D false;
> +	const char *server_path =3D "/tmp";
> =C2=A0	uint16_t tcp_port =3D 0;
> =C2=A0	bool serial_enabled =3D false;
> =C2=A0	int letest_count =3D 0;
> @@ -100,7 +102,7 @@ int main(int argc, char *argv[])
> =C2=A0	for (;;) {
> =C2=A0		int opt;
> =C2=A0
> -		opt =3D getopt_long(argc, argv,
> "dSst::l::LBAU::T::vh",
> +		opt =3D getopt_long(argc, argv,
> "dSs::t::l::LBAU::T::vh",
> =C2=A0						main_options, NULL);
> =C2=A0		if (opt < 0)
> =C2=A0			break;
> @@ -114,6 +116,8 @@ int main(int argc, char *argv[])
> =C2=A0			break;
> =C2=A0		case 's':
> =C2=A0			server_enabled =3D true;
> +			if (optarg)
> +				server_path =3D optarg;
> =C2=A0			break;
> =C2=A0		case 't':
> =C2=A0			if (optarg)
> @@ -196,28 +200,35 @@ int main(int argc, char *argv[])
> =C2=A0	}
> =C2=A0
> =C2=A0	if (server_enabled) {
> -		server1 =3D server_open_unix(SERVER_TYPE_BREDRLE,
> -						"/tmp/bt-server-
> bredrle");
> +		char path[PATH_MAX];
> +
> +		snprintf(path, sizeof(path), "%s/%s", server_path,
> +							"bt-server-
> bredrle");
> +		server1 =3D server_open_unix(SERVER_TYPE_BREDRLE,
> path);

If we were allowed to use new glib calls, this hand-rolled code should
probably use like g_build_filename():
https://docs.gtk.org/glib/func.build_filename.html
and g_auto:
https://docs.gtk.org/glib/auto-cleanup.html
to simplify the code.

Luiz, could we have have an update to maintainer-guidelines.rst to
reflect the current guidelines for using or adding glib calls to the
code?

Pauli, do you think we could have helpers for this sort of path
manipulation in src/shared? Not saying it needs to be to the level of
complexity of the g_build_filename() implementation, but snprintf()...:
https://github.com/GNOME/glib/blob/main/glib/gfileutils.c#L1926

Luiz, another question, could we start using __attribute__(cleanup())
in bluez?

Consider the following example, adapted from systemd:
#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

static inline void freep(void *p) {
        free(*(void**) p);=20
}

#define _cleanup_(f) __attribute__((cleanup(f)))
#define _cleanup_free_ _cleanup_(freep)

int main(int argc, char **argv)
{
        _cleanup_free_ char *foo =3D NULL;

        foo =3D strdup("my string");

        printf ("%s\n", foo);

        return 0;
}

Is that something we could use? Happy to send a patchset to implement
the basics of it, and cleanup a few places where that would make the
code more readable.

As the systemd coding style says in
https://systemd.io/CODING_STYLE/#memory-allocation

"Make use of _cleanup_free_ and friends. It makes your code much nicer
to read (and shorter)!"

> =C2=A0		if (!server1)
> =C2=A0			fprintf(stderr, "Failed to open BR/EDR/LE
> server\n");
> =C2=A0
> -		server2 =3D server_open_unix(SERVER_TYPE_BREDR,
> -						"/tmp/bt-server-
> bredr");
> +		snprintf(path, sizeof(path), "%s/%s", server_path,
> +							"bt-server-
> bredr");
> +		server2 =3D server_open_unix(SERVER_TYPE_BREDR, path);
> =C2=A0		if (!server2)
> =C2=A0			fprintf(stderr, "Failed to open BR/EDR
> server\n");
> =C2=A0
> -		server3 =3D server_open_unix(SERVER_TYPE_AMP,
> -						"/tmp/bt-server-
> amp");
> +		snprintf(path, sizeof(path), "%s/%s", server_path,
> +							"bt-server-
> amp");
> +		server3 =3D server_open_unix(SERVER_TYPE_AMP, path);
> =C2=A0		if (!server3)
> =C2=A0			fprintf(stderr, "Failed to open AMP
> server\n");
> =C2=A0
> -		server4 =3D server_open_unix(SERVER_TYPE_LE,
> -						"/tmp/bt-server-
> le");
> +		snprintf(path, sizeof(path), "%s/%s", server_path,
> +							"bt-server-
> le");
> +		server4 =3D server_open_unix(SERVER_TYPE_LE, path);
> =C2=A0		if (!server4)
> =C2=A0			fprintf(stderr, "Failed to open LE
> server\n");
> =C2=A0
> -		server5 =3D server_open_unix(SERVER_TYPE_MONITOR,
> -						"/tmp/bt-server-
> mon");
> +		snprintf(path, sizeof(path), "%s/%s", server_path,
> +							"bt-server-
> mon");
> +		server5 =3D server_open_unix(SERVER_TYPE_MONITOR,
> path);
> =C2=A0		if (!server5)
> =C2=A0			fprintf(stderr, "Failed to open monitor
> server\n");
> =C2=A0	}
