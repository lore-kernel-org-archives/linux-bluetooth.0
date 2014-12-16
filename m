Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418646828-15057-1-git-send-email-luiz.dentz@gmail.com>
References: <1418646828-15057-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 16 Dec 2014 14:28:52 +0200
Message-ID: <CABBYNZJzMYJdCQj6LCt5jyHgnv=j_81-rigM4mPLYo92XTCPGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix enabling coverage
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 15, 2014 at 2:33 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since MISC_FLAGS now checks for enable_coverage to add --coverage flag
> the check for lcov needs happen before before it otherwise make coverage
> doesn't work.
> ---
>  configure.ac | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index a70d55a..0acd734 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,6 +32,11 @@ m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
>  AC_DISABLE_STATIC
>  AC_PROG_LIBTOOL
>
> +if (test "$USE_MAINTAINER_MODE" = "yes"); then
> +       AC_CHECK_PROG(enable_coverage, [lcov], [yes], [no])
> +fi
> +AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
> +
>  MISC_FLAGS
>
>  AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
> @@ -274,9 +279,4 @@ fi
>  AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
>                         [Directory for the Android daemon storage files])
>
> -if (test "$USE_MAINTAINER_MODE" = "yes"); then
> -       AC_CHECK_PROG(enable_coverage, [lcov], [yes], [no])
> -fi
> -AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
> -
>  AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
