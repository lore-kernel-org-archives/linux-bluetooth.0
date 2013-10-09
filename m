Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 09/15] android: Add Android Makefile for libbluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381243883-2745-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 9 Oct 2013 21:43:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <67FF7DAD-8C17-4ADB-8050-5F35CC7C34D4@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Build libbluetooth library for Android.
> ---
> android/Android.mk |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index f5fd863..8f95a66 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -41,6 +41,7 @@ LOCAL_SHARED_LIBRARIES := \
> 	libglib \
> 
> LOCAL_MODULE := bluetoothd
> +LOCAL_REQUIRED_MODULES := libbluetooth
> 
> include $(BUILD_EXECUTABLE)
> 
> @@ -63,3 +64,55 @@ LOCAL_MODULE_TAGS := optional
> LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> 
> include $(BUILD_SHARED_LIBRARY)
> +
> +#
> +# libbluetooth library
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	../lib/bluetooth.c \
> +	../lib/sdp.c \
> +	../lib/hci.c \
> +	../lib/uuid.c \

why are we building a shared library here. What is it useful for. Even within BlueZ we do not install libbluetooth anymore.

> +
> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/../lib/ \
> +	$(LOCAL_PATH)/../src/shared \

The library clearly does not include anything from src/shared/. So what is that doing here.

> +
> +LOCAL_C_INCLUDES += \
> +	$(call include-path-for, glib) \
> +	$(call include-path-for, glib)/glib \

The library clearly does not need GLib. So why are we doing that here.

> +
> +LOCAL_CFLAGS += -O3
> +
> +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> +LOCAL_CFLAGS += -Wno-pointer-arith
> +
> +# to suppress the "missing initializer near initialization" warning
> +LOCAL_CFLAGS += -Wno-missing-field-initializers

Lets fix the actual warnings.

> +
> +# Define missing flags for Android 4.2
> +LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000

And are we sure that these flags are needed for the library.

> +
> +lib_headers := \
> +	bluetooth.h \
> +	hci.h \
> +	hci_lib.h \
> +	sco.h \
> +	l2cap.h \
> +	sdp.h \
> +	sdp_lib.h \
> +	rfcomm.h \
> +	bnep.h \
> +	cmtp.h \
> +	hidp.h \

I would really prefer we do not install these.

> +
> +$(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
> +
> +$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
> +
> +LOCAL_MODULE := libbluetooth
> +
> +include $(BUILD_SHARED_LIBRARY)

Regards

Marcel

