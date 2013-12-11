Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
References: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 11 Dec 2013 20:31:23 -0200
Message-ID: <CAJdJm_N7AbhkLkKFG_aD8b3DmAkbiBF=3q2P_Nbj+R-FwtSEdQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Add coverage support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 11, 2013 at 7:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -51,6 +51,15 @@ AC_DEFUN([MISC_FLAGS], [
>                         misc_ldflags="$misc_ldflags -pie"
>                 fi
>         ])
> +       AC_ARG_ENABLE(coverage, AC_HELP_STRING([--enable-coverage],
> +                       [enable coverage flags]), [
> +               AC_PATH_PROG([LCOV], [lcov])
> +               if (test "$LCOV" && test "${enableval}" = "yes"); then
> +                       misc_cflags="$misc_cflags -ftest-coverage"
> +                       misc_cflags="$misc_cflags -fprofile-arcs"
> +                       misc_ldflags="$misc_ldflags -gcov"
> +               fi
> +       ])

I believe the current recommended (or at least simpler) way to enable
coverage is to use "--coverage" option (both as CFLAGS and LDFLAGS),
instead of separate -ftest-coverage/-fprofile-arcs/-gcov options.
Check "man gcc" for details.

>         AC_SUBST([MISC_CFLAGS], $misc_cflags)
>         AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
>  ])

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
