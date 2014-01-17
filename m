Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 1/6] android: Add sample init.bluetooth.rc file
Date: Fri, 17 Jan 2014 20:47:09 +0100
Message-ID: <1898176.UTpxHBbyQh@athlon>
In-Reply-To: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
References: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 17 January 2014 16:30:41 Szymon Janc wrote:
> This file is intended to be included from device init.rc.
> ---
>  android/Android.mk        | 16 +++++++++++++++-
>  android/Makefile.am       |  1 +
>  android/init.bluetooth.rc | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 android/init.bluetooth.rc
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 7e97ec8..afa3a51 100644
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
> @@ -282,3 +282,17 @@ LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := bluetoothd-snoop
> 
>  include $(BUILD_EXECUTABLE)
> +
> +#
> +# init.bluetooth.rc
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
> index 8d2714d..5aa3995 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -136,6 +136,7 @@ android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS)
> -module -avoid-version \ endif
> 
>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
> +		android/init.bluetooth.rc \
>  		android/pics-gap.txt android/pics-hid.txt \
>  		android/pics-pan.txt android/pics-did.txt \
>  		android/pics-opp.txt android/pics-pbap.txt \
> diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
> new file mode 100644
> index 0000000..9f9aa84
> --- /dev/null
> +++ b/android/init.bluetooth.rc
> @@ -0,0 +1,37 @@
> +# required permissions
> +on boot
> +    chown bluetooth bluetooth /data/misc/bluetooth
> +    chown bluetooth bluetooth /dev/uhid
> +
> +# services
> +on property:bluetooth.start=daemon
> +    setprop bluetooth.start none
> +    start bluetoothd
> +
> +on property:bluetooth.stop=daemon
> +    setprop bluetooth.stop none
> +    stop bluetoothd
> +
> +on property:bluetooth.start=snoop
> +    setprop bluetooth.start none
> +    start bluetoothd-snoop
> +
> +on property:bluetooth.stop=snoop
> +    setprop bluetooth.stop none
> +    stop bluetoothd-snoop
> +
> +service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
> +    class main
> +    # init does not yet support setting capabilities so run as root,
> +    # bluetoothd drop uid to bluetooth with the right linux capabilities
> +    group bluetooth
> +    disabled
> +    oneshot
> +
> +service bluetoothd-snoop /system/bin/logwrapper
> /system/bin/bluetoothd-snoop +    class main
> +    # init does not yet support setting capabilities so run as root,
> +    # bluetoothd-snoop drops unneeded linux capabilities
> +    group nobody
> +    disabled
> +    oneshot

This is now upstream.

-- 
Szymon K. Janc
szymon.janc@gmail.com
