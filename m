Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
References: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Tue, 14 Jan 2014 22:17:08 +0100
Message-ID: <CAF3PWx1__Bbu7=AWtLZ7FEdc+FdvM3uuv1qnA5iXb1A-UDncgQ@mail.gmail.com>
Subject: Re: [RFC 1/4] android: Add sample init.bluetooth.rc file
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 14 January 2014 16:28, Szymon Janc <szymon.janc@tieto.com> wrote:
> This file is intended to be included from device init.rc.
> ---
>  android/Android.mk        | 16 +++++++++++++++-
>  android/Makefile.am       |  1 +
>  android/init.bluetooth.rc | 27 +++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 android/init.bluetooth.rc
>
> diff --git a/android/Android.mk b/android/Android.mk
> index ae52ab4..f13e703 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -109,7 +109,7 @@ LOCAL_MODULE := bluetooth.default
>  LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> -LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop
> +LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop init.bluetooth.rc
>
>  include $(BUILD_SHARED_LIBRARY)
>
> @@ -263,3 +263,17 @@ LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := bluetoothd-snoop
>
>  include $(BUILD_EXECUTABLE)
> +
> +#
> +# init.bleutooth.rc
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_MODULE := init.bluetooth.rc
> +LOCAL_MODULE_CLASS := ETC
> +LOCAL_SRC_FILES := $(LOCAL_MODULE)
> +LOCAL_MODULE_TAGS := optional
> +LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
> +
> +include $(BUILD_PREBUILT)
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 7806f79..b205019 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -134,6 +134,7 @@ android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
>  endif
>
>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
> +               android/init.bluetooth.rc \
>                 android/pics-gap.txt android/pics-hid.txt \
>                 android/pics-pan.txt android/pics-did.txt \
>                 android/pics-opp.txt android/pics-pbap.txt \
> diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
> new file mode 100644
> index 0000000..e2be9e8
> --- /dev/null
> +++ b/android/init.bluetooth.rc
> @@ -0,0 +1,27 @@
> +chown bluetooth bluetooth /data/misc/bluetooth
> +
> +chown bluetooth bluetooth /dev/uhid

There should be some action trigger at the beginning, e.g. 'on boot'
should be fine.


BR,
Andrzej
