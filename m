Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 05/16] android: Add Android Makefile for mgmt library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380291161-10232-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 29 Sep 2013 15:34:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BED04688-8109-4329-BC89-F3C6CC3CB7AF@holtmann.org>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Build libbluez shared library for Android.
> ---
> android/Android.mk |   30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 93de803..40cff9a 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -43,3 +43,33 @@ LOCAL_MODULE_TAGS := optional
> LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> 
> include $(BUILD_SHARED_LIBRARY)
> +
> +#
> +# mgmt library libbluez
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	../src/shared/mgmt.c \
> +	../src/shared/util.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(call include-path-for, glib) \
> +	$(call include-path-for, glib)/glib \
> +
> +LOCAL_C_INCLUDES += \
> +	$(LOCAL_PATH)/../ \
> +
> +LOCAL_SHARED_LIBRARIES := \
> +	libglib \
> +
> +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> +LOCAL_CFLAGS := -Wno-pointer-arith
> +
> +# Define missing flags for Android 4.2
> +LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
> +
> +LOCAL_MODULE    := libbluez
> +
> +include $(BUILD_SHARED_LIBRARY)

why are we building a shared library here. We could just link the source files into the daemon code. bluetoothd is just compiling these files and not bothering with a shared library.

Regards

Marcel

