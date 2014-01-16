Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/2] android: Add btmgmt to debug builds
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389883945-10707-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 16 Jan 2014 14:08:27 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <BE345789-E478-4C6C-B192-4DAB782CE135@holtmann.org>
References: <1389883945-10707-1-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> android/Android.mk | 36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 7e97ec8..b3e6a50 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -282,3 +282,39 @@ LOCAL_MODULE_TAGS := optional
> LOCAL_MODULE := bluetoothd-snoop
> 
> include $(BUILD_EXECUTABLE)
> +
> +#
> +# btmgmt
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	../tools/btmgmt.c \
> +	../monitor/mainloop.c \
> +	../lib/bluetooth.c \
> +	../lib/sdp.c \
> +	../src/eir.c \
> +	../src/glib-helper.c \
> +	../src/shared/io-mainloop.c \
> +	../src/shared/mgmt.c \
> +	../src/shared/queue.c \
> +	../src/shared/util.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(call include-path-for, glib) \
> +	$(call include-path-for, glib)/glib \
> +	$(LOCAL_PATH)/.. \
> +	$(LOCAL_PATH)/../src \
> +	$(LOCAL_PATH)/../lib \
> +
> +LOCAL_SHARED_LIBRARIES := \
> +	libglib \

have Johan fix the dependency on GLib instead. It should not be needed anymore.

Regards

Marcel

