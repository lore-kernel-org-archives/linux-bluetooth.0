Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH BlueZ] build: Add coverage support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 11 Dec 2013 13:00:59 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <4818FD30-C986-47E0-8441-E58938077D45@holtmann.org>
References: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
> Makefile.am         | 18 ++++++++++++++++++
> acinclude.m4        |  9 +++++++++
> bootstrap-configure |  1 +
> configure.ac        |  2 ++
> 4 files changed, 30 insertions(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 15cc149..1a59532 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
> 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
> 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
> 
> +if COVERAGE

maybe we should just make this depend on maintainer-mode.

> +clean-coverage:
> +	$(RM) -r coverage
> +	@find . -name "*.gcda" -exec $(RM) {} \;
> +	$(LCOV) --directory . --zerocounters
> +
> +check-coverage:
> +	@make check
> +	$(AM_V_at)$(MKDIR_P) -p coverage
> +	$(LCOV) --compat-libtool --directory . --capture --output-file \
> +							coverage/check.info
> +	@genhtml -o coverage/ coverage/check.info
> +
> clean-local:
> +	@make clean-coverage
> 	$(RM) -r lib/bluetooth
> +else
> +clean-local:
> +	$(RM) -r lib/bluetooth
> +endif
> diff --git a/acinclude.m4 b/acinclude.m4
> index 2065852..e5eb481 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -51,6 +51,15 @@ AC_DEFUN([MISC_FLAGS], [
> 			misc_ldflags="$misc_ldflags -pie"
> 		fi
> 	])
> +	AC_ARG_ENABLE(coverage, AC_HELP_STRING([--enable-coverage],
> +			[enable coverage flags]), [
> +		AC_PATH_PROG([LCOV], [lcov])
> +		if (test "$LCOV" && test "${enableval}" = "yes"); then
> +			misc_cflags="$misc_cflags -ftest-coverage"
> +			misc_cflags="$misc_cflags -fprofile-arcs"
> +			misc_ldflags="$misc_ldflags -gcov"
> +		fi
> +	])
> 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
> 	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
> ])
> diff --git a/bootstrap-configure b/bootstrap-configure
> index c7f08ed..35aa98b 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -14,4 +14,5 @@ fi
> 		--enable-experimental \
> 		--enable-android \
> 		--enable-sixaxis \
> +		--enable-coverage \
> 		--disable-datafiles $*
> diff --git a/configure.ac b/configure.ac
> index 18d0b55..c55924f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -252,4 +252,6 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
> 					[enable_android=${enableval}])
> AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
> 
> +AM_CONDITIONAL([COVERAGE], [test "$LCOV”])

I do not like this one. The test should check enable_xxx variables. I rather have configure abort with error if some programs or dependencies are not found.

Regards

Marcel

