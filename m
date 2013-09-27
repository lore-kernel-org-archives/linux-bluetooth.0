Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 1/3] build: Add skeleton for BlueZ Android
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Sep 2013 04:08:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EAD23378-CBDD-4A1C-A656-21031000522F@holtmann.org>
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Makefile.am         |    4 +++-
> Makefile.android    |    4 ++++
> android/Android.mk  |    5 +++++
> bootstrap-configure |    3 ++-
> configure.ac        |    4 ++++
> 5 files changed, 18 insertions(+), 2 deletions(-)
> create mode 100644 Makefile.android
> create mode 100644 android/Android.mk
> 
> diff --git a/Makefile.am b/Makefile.am
> index 4e4b1c5..51204f4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -179,6 +179,7 @@ test_scripts =
> 
> include Makefile.tools
> include Makefile.obexd
> +include Makefile.android
> 
> if HID2HCI
> rulesdir = @UDEV_DIR@/rules.d
> @@ -293,7 +294,8 @@ pkgconfig_DATA = lib/bluez.pc
> endif
> 
> DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> -					--disable-systemd --disable-udev
> +					--disable-systemd --disable-udev \
> +					--enable-android
> 
> DISTCLEANFILES = $(pkgconfig_DATA)
> 
> diff --git a/Makefile.android b/Makefile.android
> new file mode 100644
> index 0000000..5e43730
> --- /dev/null
> +++ b/Makefile.android
> @@ -0,0 +1,4 @@
> +
> +if ANDROID
> +EXTRA_DIST += android/Android.mk
> +endif

as I mentioned in another patch. No need for if around EXTRA_DIST.

> diff --git a/android/Android.mk b/android/Android.mk
> new file mode 100644
> index 0000000..e810654
> --- /dev/null
> +++ b/android/Android.mk
> @@ -0,0 +1,5 @@
> +LOCAL_PATH := $(call my-dir)
> +
> +# Retrieve BlueZ version from configure.ac file
> +BLUEZ_VERSION := $(shell grep AC_INIT $(LOCAL_PATH)/../configure.ac | tr -d ' ' | sed -e 's/.*(.*,\(.*\))/\1/')
> +
> diff --git a/bootstrap-configure b/bootstrap-configure
> index 7a6e7d1..8bde920 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -12,4 +12,5 @@ fi
> 		--sysconfdir=/etc \
> 		--localstatedir=/var \
> 		--enable-experimental \
> -		--disable-datafiles $*
> +		--disable-datafiles \
> +		--enable-android $*

Historically --disable-datafiles is always last. And I like to keep it that way. Please add it after --enable-experimental.

> diff --git a/configure.ac b/configure.ac
> index 41c2935..22ab240 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -242,4 +242,8 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
> 			[Directory for the configuration files])
> AC_SUBST(CONFIGDIR, "${configdir}")
> 
> +AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
> +			[enable BlueZ Android]), [android=${enableval}])

I would call it BlueZ for Android, but that is minor details.

> +AM_CONDITIONAL(ANDROID, test "${android}" = "yes")

However this should be ${enable_android} like with every other configure option we have.

> +
> AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)

Regards

Marcel

