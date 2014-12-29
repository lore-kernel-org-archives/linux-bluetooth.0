Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419857362-23502-1-git-send-email-szymon.janc@tieto.com>
References: <1419857362-23502-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 29 Dec 2014 12:32:23 -0200
Message-ID: <CABBYNZJk4e87fVNbm0NWv62fjUAFrsepkoTzn7HiFzM55SwE8w@mail.gmail.com>
Subject: Re: [RFC] build: Enable -Wformat -Wformat-security in maintainer mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 29, 2014 at 10:49 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> __attribute__((format(printf))) doesn't seem to catch missing format
> string in function call ie.
>
> char *p = "foo";
>
> printf(p);
> vs
> printf("%s", p);
>
> Enabling -Wformat -Wformat-security warns in such case.
> ---
>
> This should allow to early catch bugs like those fixed in
> patch "Add missing format specifiers in src/error.c" sent by
> Mariusz.
>
>  acinclude.m4 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index 960d54c..bc39c6d 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -21,6 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags="$with_cflags -Wredundant-decls"
>                 with_cflags="$with_cflags -Wcast-align"
>                 with_cflags="$with_cflags -Wswitch-enum"
> +               with_cflags="$with_cflags -Wformat -Wformat-security"
>                 with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
>                 with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
>                 with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_28"
> --
> 1.9.3

+1, at least I don't see any reason not to enable it.


-- 
Luiz Augusto von Dentz
