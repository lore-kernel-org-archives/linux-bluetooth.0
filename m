Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [RFC v2 BlueZ] build: Add coverage support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386874657-26642-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 13 Dec 2013 13:34:20 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B615ECEA-19A0-4434-8361-16D5327A14C7@holtmann.org>
References: <1386874657-26642-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Coverage is disabled by default but it is automatically enabled by
> bootstrap-configure using --enable-coverage, it creates a new make target
> 'coverage' that can be run after make check or any tester that produces
> .gdca files.
> 
> The build time using --enable-coverage is considerable bigger so if
> that is a problem just disable it, also this is the reason why it is not
> added directly under --enable-maintainer-mode so it is possible to
> turn off coverage without having to turn off maintainer mode.
> 
> Since lcov apparently cannot detect changes to .gcda there is another
> make target 'clean-coverage' so after that make coverage can be
> run again.
> ---
> Makefile.am         | 17 +++++++++++++++++
> acinclude.m4        |  8 ++++++++
> bootstrap-configure |  1 +
> configure.ac        |  5 +++++
> 4 files changed, 31 insertions(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 15cc149..4b3351a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -331,5 +331,22 @@ lib/bluetooth/%.h: lib/%.h
> 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
> 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
> 
> +if COVERAGE
> +clean-coverage:
> +	$(RM) -r coverage
> +
> +coverage:
> +	$(AM_V_at)$(MKDIR_P) -p coverage
> +	@lcov --compat-libtool --directory $(top_builddir) --capture \
> +					--output-file coverage/check.info
> +	@genhtml -o coverage/ coverage/check.info

I would actually prefer if we can have some sort AM_V_GEN thing working here. So that make V=1 will end up showing the exact command.

> +
> +clean-local: clean-coverage
> +	@find $(top_builddir) -name "*.gcda" -exec $(RM) {} \;
> +	@find $(top_builddir) -name "*.gcno" -exec $(RM) {} \;
> +	@lcov --directory . --zerocounters
> +	$(RM) -r lib/bluetooth
> +else
> clean-local:
> 	$(RM) -r lib/bluetooth
> +endif

This if for clean-local is not something I like that much. Can we not come up with a better way and leave clean-local as it is. Just make clean-coverage a null-op.

> diff --git a/acinclude.m4 b/acinclude.m4
> index 2065852..4bb8bde 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -51,6 +51,14 @@ AC_DEFUN([MISC_FLAGS], [
> 			misc_ldflags="$misc_ldflags -pie"
> 		fi
> 	])
> +	AC_ARG_ENABLE(coverage, AC_HELP_STRING([--enable-coverage],
> +						[enable coverage flags]), [
> +		enable_coverage=${enableval}
> +		if (test "${enable_coverage}" = "yes"); then
> +			misc_cflags="$misc_cflags --coverage"
> +			misc_ldflags="$misc_ldflags --coverage"
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
> index 18d0b55..5e684a3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -252,4 +252,9 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
> 					[enable_android=${enableval}])
> AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
> 
> +if (test "${enable_coverage}" = "yes"); then
> +	AC_CHECK_PROG([LCOV], [lcov], [yes], AC_MSG_ERROR(lcov is required))
> +fi
> +AM_CONDITIONAL([COVERAGE], [test "${enable_coverage}" = "yes"])
> +

Still not 100% convinced that we really want this. I get the feeling that maintainer-mode would be just fine.

Regards

Marcel

