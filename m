Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 2/3] android: Add skeleton of BlueZ Android daemon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380024798-32017-2-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 27 Sep 2013 04:05:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2A24E0BD-2EFF-4811-833E-A850B1469054@holtmann.org>
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com> <1380024798-32017-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Define local mapping to glib path, otherwise this has to be inside central
> place in the build repository.
> 
> Retrieve Bluetooth version from configure.ac.
> ---
> .gitignore         |    2 +
> Makefile.android   |    5 +++

I rather keep the changes to a global Makefile separate from the android/ stuff.

> android/Android.mk |   24 ++++++++++++
> android/main.c     |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 141 insertions(+)
> create mode 100644 android/main.c

It is perfectly fine to split this into two patches. Add the *.c file(s) first and in a second patch add the build changes.

> diff --git a/.gitignore b/.gitignore
> index 8a25a3e..3707209 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -98,3 +98,5 @@ unit/test-gobex-packet
> unit/test-gobex-transfer
> unit/test-*.log
> unit/test-*.trs
> +
> +android/bluetoothd
> diff --git a/Makefile.android b/Makefile.android
> index 5e43730..e056dce 100644
> --- a/Makefile.android
> +++ b/Makefile.android
> @@ -1,4 +1,9 @@
> 
> if ANDROID
> +noinst_PROGRAMS += android/bluetoothd
> +
> +android_bluetoothd_SOURCES = android/main.c
> +android_bluetoothd_LDADD = @GLIB_LIBS@
> +
> EXTRA_DIST += android/Android.mk
> endif

You can not put the EXTRA_DIST under an if ANDROID. Make that part global.

I expect that make distcheck works no matter what is configured. Check the final tarballs if all files are actually included.

Regards

Marcel

