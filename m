Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D919DF6A
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879284; cv=pass; b=OXF6idaNqlqZotdLYIIcMsoyjQsGhmXwpYLV/olCCJx3/trPboTGmja8kV1/cI51scGsbmb9dso27MOV8KO6Q67lDs90kvwFCBvst0eoxeiSpmSkRhj8OHTzC3fjIn9ewfrdMkEE6mH5m21Qo8CtyR/Oj8coXi5UpZhjrBewYJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879284; c=relaxed/simple;
	bh=+TNcqLcie3cVOvYAn+4dZc4Hn1CAe7Vhi3nlyh3iLmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+WeTbhVq+FssDl8FUQ/QO/FMqY76M0QsZP/sdCP5vJ68dHihibsNidBhHWKFmOf3Guep50uPqjAYuQPtPCMOylMWpT0qFNGNK6NySM74MGFNNf2CeKguuq0qjblMWBz//7XKxiFacGtK5EPkLTz3DtX/ZKRpqL6vXUTEOSTCgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU+BXKSY; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU+BXKSY"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-650158138d9so2206149d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 07:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774879282; cv=none;
        d=google.com; s=arc-20240605;
        b=hm6CynFLKcIMZ6H/mnbqZWagDZEgYY3Gdddbwuq6F8sKedV8wjiWxITWqUWPFAX0b6
         GgRRWxWqpQ4y3uDoiHubfu4qj60H/k6BV76BLNTNy9Dx9t+FSMAKgrnr7+uodVVR8tWK
         zdefN37M/mGObtZ4195LrXxJKr46oHHcKjw21cg+cAv/AYwSG7z0su/KPwFFcnqRLkYv
         Ic+A9qEF/Q/ZEUauORFSxEHHqgmHLGbT+yP1BkY2/rvxwpeSEXdcfM/R5fbP/zCQp/4p
         CUFWTWGggLUeJiuEBpsLoT7wG4RfNWP0GlR6duLfMKp+xRN1/Lw6fu73XSC89PBo5wi5
         QdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iz/oZf7U+ic/PgCGX2KicGxC3pM9cMVW8/mHCowexu8=;
        fh=17q+SCcltX/E//iUrbAEWKpALk8TdeHyyZPZFPD1Y88=;
        b=aEGFgdKQJozLwCytyMK3dzswrQMkUrrH+oQlUh0gIjIqEo3fFpvs5npeZp2f8JqZ1E
         ub8mP8FxBJ8Z9fmmU0PcG3GB2pQTaUZIAkdBXWYaD5xYCvAvtR/aIeL106jSOs28CVH2
         XL5IoH3cJyHBIQoy0Eqxbzjaic69ZnZ0e1pMDQrT+YZvnrOrxn0HnRmsfJNlHY2kNWHT
         spc/hjSoBpqhZZCS1Smo6pV4oZBhQuPGP0pppqOfuoh6+gNliohW8R490Ka/L9gu0Bg1
         3cMFvnaK6mIjvAvzDIyauLBufaJfqc1HV9hG5iE3FiLgA122bTxEgNri0KVGgqOQoP35
         iBqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879282; x=1775484082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz/oZf7U+ic/PgCGX2KicGxC3pM9cMVW8/mHCowexu8=;
        b=dU+BXKSYJ18MWrTZOxd6XfktZrJZ8SjfreB5dBNkhAlsuJj91TpkawZOA3rWzgvKfr
         iwFiC1coaJcqyQFlhssOtyHYiSMl2Ytdbpw/91++w6l0y3XCDMuMxmhCnbFDhEwYyiKU
         iiAeG6tchyFhZSDsJP7zptBgBbO87e0T1HALOlAwNx1rvRRLqDinp+qTdXONTVbdpWBT
         TELXOw5cX0DsbtPPrGO+F+y2VA7Dhc3DOxbtnOrAI5b3xWjP2keAcWshmGEuEvK84VbA
         mL0d4ej9I4gtWSyKnNmrYlwz0lt4XToL4SBjj0E11MXM5tFIg+95k2IgU2KAPCJdQCr8
         2y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879282; x=1775484082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iz/oZf7U+ic/PgCGX2KicGxC3pM9cMVW8/mHCowexu8=;
        b=C1iGichvj3n1XNjQjdAefFXva7qegApDyG8I4q0f/ntAx6csgoFITg9k5FpyaFwEkK
         mysgYEPsvrGkenpzhEKT+Q6nHS6XRT1/GzWa8ERnvJtMW94UULkUAs3YdfN+XQoCoGji
         gkAT6XrJ2zsXrAMs4l9CRyW36yOAxV9quCoxpnv4QYEUa2WJ0+HcpYWBxMaQ5UzW/kBG
         idvNYbtWbx2C1klTeiUVHGtSBXhtzMfpzrHUn3LS8598efTgM9cu81kRi1Ryz69wm01P
         8BO2hvdpM7XrbIbuH7VrvwzMVf14jEa9EQEqH+410xIHBdO87nWgkPKgl9MkSRxBTlt4
         8mjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhi/oZwVWszaNgVRwgcUaJFGSiyh3COLnfDRkH3dLB1sUmoOMRubUjmln9QKjbTS+Id5qSj/cDC1azzAY7HNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzh5FP4QJpmtC2oKmjYJpXlt005X2SUH42cMe9n1T+09gJHnT8
	OML94mdUsYzpAL9bg7CGUJKsM07hPElRSe8sR9crgilRcMOcztl0TQb5KPVGlkqPu+eqxhZxnYa
	cv/4wMRC4xpUb4G307FbecAla1eZUZ5U=
X-Gm-Gg: ATEYQzz+oM1MZKYF6y8K235qtRs054AZg6JG9eTUmHnMcgccO6p6zGVUcC+vUIQ2jFM
	VIIH7Fdf2kI93Dq/dCHNUJ32VD2b2p3kg/iqd03bM93l+U5Gp+kWvMxdTY5MZ9xiXoUdpYTKASJ
	cww1nPhABh2LEQ9iwFVob7ODLNz1EnBjQBB930c6gUbZECJGDh6RWmuZa3gwVpLbTuXOih9TXMm
	XfMmtJ0kBkhKXl3xlXAI5+khUwElGLPOsR6dVHnMXXgT9xmH2NQHyBag+vs/GlKz9PQH0Fp960A
	zlq7yTfW1kkB8vwGAhiOHK7tO5UetR1v8fX55fyOt9JLv9MXLgc7YEQxYLGdiRxkJX2i6g==
X-Received: by 2002:a05:690e:11ce:b0:64e:a4f6:1de0 with SMTP id
 956f58d0204a3-64ff722f89amr12004075d50.35.1774879279964; Mon, 30 Mar 2026
 07:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774214693.git.pav@iki.fi> <41d54c33641f8a6004b3cb9a616c746119e2b156.1774214693.git.pav@iki.fi>
 <ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net>
In-Reply-To: <ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 10:01:07 -0400
X-Gm-Features: AQROBzCfXytCneF5VKEQihMzPOzQFhw1UPBaIBK6LMGI5XxGYsELBgOFswvJkHA
Message-ID: <CABBYNZKt7POxvoJw7k0J2YvH4rpx4rfhrJ8+D9XgQwBFxKASuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 02/20] emulator: btvirt: allow specifying where
 server unix sockets are made
To: Bastien Nocera <hadess@hadess.net>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Mar 30, 2026 at 8:36=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Sun, 2026-03-22 at 23:29 +0200, Pauli Virtanen wrote:
> > Make --server to take optional path name where to create the various
> > server sockets.
> > ---
> >  emulator/main.c | 37 ++++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/emulator/main.c b/emulator/main.c
> > index 456fcd98e..09d6e9adb 100644
> > --- a/emulator/main.c
> > +++ b/emulator/main.c
> > @@ -18,6 +18,7 @@
> >  #include <stdbool.h>
> >  #include <getopt.h>
> >  #include <sys/uio.h>
> > +#include <limits.h>
> >
> >  #include "src/shared/mainloop.h"
> >  #include "src/shared/util.h"
> > @@ -46,7 +47,7 @@ static void usage(void)
> >       printf("options:\n"
> >               "\t-d                    Enable debug\n"
> >               "\t-S                    Create local serial port\n"
> > -             "\t-s                    Create local server
> > sockets\n"
> > +             "\t-s[path=3D/tmp]         Create local server
> > sockets\n"
> >               "\t-t[port=3D45550]        Create a TCP server\n"
> >               "\t-l[num]               Number of local
> > controllers\n"
> >               "\t-L                    Create LE only
> > controller\n"
> > @@ -60,7 +61,7 @@ static void usage(void)
> >  static const struct option main_options[] =3D {
> >       { "debug",   no_argument,       NULL, 'd' },
> >       { "serial",  no_argument,       NULL, 'S' },
> > -     { "server",  no_argument,       NULL, 's' },
> > +     { "server",  optional_argument, NULL, 's' },
> >       { "tcp",     optional_argument, NULL, 't' },
> >       { "local",   optional_argument, NULL, 'l' },
> >       { "le",      no_argument,       NULL, 'L' },
> > @@ -88,6 +89,7 @@ int main(int argc, char *argv[])
> >       struct server *server5;
> >       bool debug_enabled =3D false;
> >       bool server_enabled =3D false;
> > +     const char *server_path =3D "/tmp";
> >       uint16_t tcp_port =3D 0;
> >       bool serial_enabled =3D false;
> >       int letest_count =3D 0;
> > @@ -100,7 +102,7 @@ int main(int argc, char *argv[])
> >       for (;;) {
> >               int opt;
> >
> > -             opt =3D getopt_long(argc, argv,
> > "dSst::l::LBAU::T::vh",
> > +             opt =3D getopt_long(argc, argv,
> > "dSs::t::l::LBAU::T::vh",
> >                                               main_options, NULL);
> >               if (opt < 0)
> >                       break;
> > @@ -114,6 +116,8 @@ int main(int argc, char *argv[])
> >                       break;
> >               case 's':
> >                       server_enabled =3D true;
> > +                     if (optarg)
> > +                             server_path =3D optarg;
> >                       break;
> >               case 't':
> >                       if (optarg)
> > @@ -196,28 +200,35 @@ int main(int argc, char *argv[])
> >       }
> >
> >       if (server_enabled) {
> > -             server1 =3D server_open_unix(SERVER_TYPE_BREDRLE,
> > -                                             "/tmp/bt-server-
> > bredrle");
> > +             char path[PATH_MAX];
> > +
> > +             snprintf(path, sizeof(path), "%s/%s", server_path,
> > +                                                     "bt-server-
> > bredrle");
> > +             server1 =3D server_open_unix(SERVER_TYPE_BREDRLE,
> > path);
>
> If we were allowed to use new glib calls, this hand-rolled code should
> probably use like g_build_filename():
> https://docs.gtk.org/glib/func.build_filename.html
> and g_auto:
> https://docs.gtk.org/glib/auto-cleanup.html
> to simplify the code.

Don't really want to drag new dependecies.

> Luiz, could we have have an update to maintainer-guidelines.rst to
> reflect the current guidelines for using or adding glib calls to the
> code?
>
> Pauli, do you think we could have helpers for this sort of path
> manipulation in src/shared? Not saying it needs to be to the level of
> complexity of the g_build_filename() implementation, but snprintf()...:
> https://github.com/GNOME/glib/blob/main/glib/gfileutils.c#L1926

Perhaps something like a util_filename or something simpler.

> Luiz, another question, could we start using __attribute__(cleanup())
> in bluez?
>
> Consider the following example, adapted from systemd:
> #include <stddef.h>
> #include <string.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> static inline void freep(void *p) {
>         free(*(void**) p);
> }
>
> #define _cleanup_(f) __attribute__((cleanup(f)))
> #define _cleanup_free_ _cleanup_(freep)
>
> int main(int argc, char **argv)
> {
>         _cleanup_free_ char *foo =3D NULL;
>
>         foo =3D strdup("my string");
>
>         printf ("%s\n", foo);
>
>         return 0;
> }
>
> Is that something we could use? Happy to send a patchset to implement
> the basics of it, and cleanup a few places where that would make the
> code more readable.
>
> As the systemd coding style says in
> https://systemd.io/CODING_STYLE/#memory-allocation

Yes, that's probably a good idea. I need to check what the kernel is
doing in this regard as well since I recall they were introducing some
support for auto freeing stuff.

> "Make use of _cleanup_free_ and friends. It makes your code much nicer
> to read (and shorter)!"
>
> >               if (!server1)
> >                       fprintf(stderr, "Failed to open BR/EDR/LE
> > server\n");
> >
> > -             server2 =3D server_open_unix(SERVER_TYPE_BREDR,
> > -                                             "/tmp/bt-server-
> > bredr");
> > +             snprintf(path, sizeof(path), "%s/%s", server_path,
> > +                                                     "bt-server-
> > bredr");
> > +             server2 =3D server_open_unix(SERVER_TYPE_BREDR, path);
> >               if (!server2)
> >                       fprintf(stderr, "Failed to open BR/EDR
> > server\n");
> >
> > -             server3 =3D server_open_unix(SERVER_TYPE_AMP,
> > -                                             "/tmp/bt-server-
> > amp");
> > +             snprintf(path, sizeof(path), "%s/%s", server_path,
> > +                                                     "bt-server-
> > amp");
> > +             server3 =3D server_open_unix(SERVER_TYPE_AMP, path);
> >               if (!server3)
> >                       fprintf(stderr, "Failed to open AMP
> > server\n");
> >
> > -             server4 =3D server_open_unix(SERVER_TYPE_LE,
> > -                                             "/tmp/bt-server-
> > le");
> > +             snprintf(path, sizeof(path), "%s/%s", server_path,
> > +                                                     "bt-server-
> > le");
> > +             server4 =3D server_open_unix(SERVER_TYPE_LE, path);
> >               if (!server4)
> >                       fprintf(stderr, "Failed to open LE
> > server\n");
> >
> > -             server5 =3D server_open_unix(SERVER_TYPE_MONITOR,
> > -                                             "/tmp/bt-server-
> > mon");
> > +             snprintf(path, sizeof(path), "%s/%s", server_path,
> > +                                                     "bt-server-
> > mon");
> > +             server5 =3D server_open_unix(SERVER_TYPE_MONITOR,
> > path);
> >               if (!server5)
> >                       fprintf(stderr, "Failed to open monitor
> > server\n");
> >       }
>


--=20
Luiz Augusto von Dentz
