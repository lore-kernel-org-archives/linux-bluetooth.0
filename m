Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] Link mcaptest with -lrt when needed
Date: Wed, 11 Feb 2015 16:33:49 +0100
Message-ID: <6010593.MLgLHOm4DO@uw000953>
In-Reply-To: <1419891774-21158-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <20141229232219.622fd4d8@free-electrons.com> <1419891774-21158-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Monday 29 of December 2014 23:22:54 Thomas Petazzoni wrote:
> The mcaptest tool uses the profiles/health/mcap.c source file, which
> calls clock_getres(). This function is defined in librt in some C
> libraries, so mcaptest should be linked against librt when needed,
> otherwise one gets link failures such as:
> 
> ld: profiles/health/mcap.o: undefined reference to symbol 'clock_getres@@GLIBC_2.2.5'
> ld: note: 'clock_getres@@GLIBC_2.2.5' is defined in DSO [...]/sysroot/lib64/librt.so.1 so try adding it to the linker command line
> [...]/sysroot/lib64/librt.so.1: could not read symbols: Invalid operation
> collect2: error: ld returned 1 exit status
> Makefile:4184: recipe for target 'tools/mcaptest' failed
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Makefile.tools | 2 +-
>  configure.ac   | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index bc827fe..fef3db5 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -195,7 +195,7 @@ tools_mcaptest_SOURCES = tools/mcaptest.c \
>  				btio/btio.h btio/btio.c \
>  				src/log.c src/log.h \
>  				profiles/health/mcap.h profiles/health/mcap.c
> -tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> +tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ @RT_LIBS@
>  
>  dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
>  			tools/hcitool.1 tools/hcidump.1 \
> diff --git a/configure.ac b/configure.ac
> index 4739c10..b0afba6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,11 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
>  AC_CHECK_LIB(dl, dlopen, dummy=yes,
>  			AC_MSG_ERROR(dynamic linking loader is required))
>  
> +AC_SEARCH_LIBS([clock_getres], [rt],
> +			[test "$ac_cv_search_clock_getres" = "none required" ||
> +			RT_LIBS=$ac_cv_search_clock_getres])
> +AC_SUBST([RT_LIBS])
> +
>  PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
>  				AC_MSG_ERROR(GLib >= 2.28 is required))
>  AC_SUBST(GLIB_CFLAGS)

This seems to got lost in traffic.
Since it doesn't apply anymore you would have to rebase it.

-- 
Best regards, 
Szymon Janc
