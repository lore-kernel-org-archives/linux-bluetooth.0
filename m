Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171102141100.21883-1-hadess@hadess.net>
References: <20171102141100.21883-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Nov 2017 13:22:49 +0200
Message-ID: <CABBYNZJXYyzk4J0KkTkodobcqVUPd3tY38QCwC5bAdPcAgwmOg@mail.gmail.com>
Subject: Re: [PATCH] obexd: Fix compilation error on newer glibc
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Nov 2, 2017 at 4:11 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Since this glibc commit:
> https://sourceware.org/git/gitweb.cgi?p=3Dglibc.git;a=3Dcommitdiff;h=3D37=
f802f86400684c8d13403958b2c598721d6360
>
> glibc doesn't include declare ssize_t when fcntl.h is included (fcntl.h
> included <bits/uio.h> which includes <sys/types.h>).
>
> This fixes the following compile-time error:
>
> In file included from obexd/plugins/mas.c:41:0:
> ./obexd/src/obex.h:37:1: error: unknown type name =E2=80=98ssize_t=E2=80=
=99; did you mean =E2=80=98size_t=E2=80=99?
>  ssize_t obex_get_size(struct obex_session *os);
>  ^~~~~~~
> ---
>  obexd/src/obex.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/obexd/src/obex.h b/obexd/src/obex.h
> index fc1674755..67593f11b 100644
> --- a/obexd/src/obex.h
> +++ b/obexd/src/obex.h
> @@ -22,6 +22,8 @@
>   *
>   */
>
> +#include <unistd.h>
> +
>  #define OBJECT_SIZE_UNKNOWN -1
>  #define OBJECT_SIZE_DELETE -2
>
> --
> 2.14.3

Applied, thanks.

--=20
Luiz Augusto von Dentz
