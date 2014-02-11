Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] android: Add support for Valgrind in debug variants
Date: Tue, 11 Feb 2014 08:34:03 -0800 (PST)
Message-ID: <7693126.sOkHjmfPIf@leonov>
In-Reply-To: <1392128934-11906-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392128934-11906-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tuesday 11 of February 2014 15:28:54 Andrzej Kaczmarek wrote:
> This patch allows bluetoothd to be run with Valgrind easily in debug
> variants.
> 
> For userdebug and eng variants bluetoothd is renamed to bluetoothd-main
> and bluetoothd acts a wrapper to launch it either with or without
> Valgrind (this is decided by value of persist.sys.bluetooth.valgrind
> property).
> ---
>  android/Android.mk           | 42 ++++++++++++++++++++++++
>  android/bluetoothd-wrapper.c | 76
> ++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 118
> insertions(+)
>  create mode 100644 android/bluetoothd-wrapper.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index b82ef84..84e96fe 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -91,7 +91,15 @@ $(shell mkdir -p $(LOCAL_PATH)/bluez/lib/bluetooth)
>  $(foreach file,$(lib_headers), $(shell ln -sf ../$(file)
> $(LOCAL_PATH)/bluez/lib/bluetooth/$(file)))
> 
>  LOCAL_MODULE_TAGS := optional
> +
> +# for userdebug/eng this module is bluetoothd-main since bluetoothd is used
> as +# wrapper to launch bluetooth with Valgrind
> +ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
> +LOCAL_MODULE := bluetoothd-main
> +LOCAL_STRIP_MODULE := false
> +else
>  LOCAL_MODULE := bluetoothd
> +endif
> 
>  include $(BUILD_EXECUTABLE)
> 
> @@ -415,3 +423,37 @@ LOCAL_CFLAGS:= \
>  LOCAL_MODULE := libsbc
> 
>  include $(BUILD_SHARED_LIBRARY)
> +
> +ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
> +
> +#
> +# bluetoothd (debug)
> +# this is just a wrapper used in userdebug/eng to launch bluetoothd-main
> +# with/without Valgrind
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	bluez/android/bluetoothd-wrapper.c
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_SHARED_LIBRARIES := \
> +	libcutils \
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
> +LOCAL_MODULE_TAGS := optional
> +LOCAL_MODULE := bluetoothd
> +
> +LOCAL_REQUIRED_MODULES := \
> +	bluetoothd-main \
> +	valgrind \
> +	memcheck-$(TARGET_ARCH)-linux \
> +	vgpreload_core-$(TARGET_ARCH)-linux \
> +	vgpreload_memcheck-$(TARGET_ARCH)-linux \
> +	default.supp
> +
> +include $(BUILD_EXECUTABLE)
> +
> +endif
> \ No newline at end of file
> diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
> new file mode 100644
> index 0000000..122e6b0
> --- /dev/null
> +++ b/android/bluetoothd-wrapper.c
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> + * See the License for the specific language governing permissions and + *
> limitations under the License.
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <cutils/properties.h>
> +
> +#define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
> +
> +#define VALGRIND_BIN "/system/bin/valgrind"
> +
> +#define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
> +
> +static void run_valgrind(void)
> +{
> +	char *prg_argv[4];
> +	char *prg_envp[3];
> +
> +	prg_argv[0] = VALGRIND_BIN;
> +	prg_argv[1] = "--leak-check=full";
> +	prg_argv[2] = BLUETOOTHD_BIN;
> +	prg_argv[3] = NULL;
> +
> +	prg_envp[0] = "G_SLICE=always-malloc";
> +	prg_envp[1] = "G_DEBUG=gc-friendly";
> +	prg_envp[2] = NULL;
> +
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +}
> +
> +static void run_bluetoothd(void)
> +{
> +	char *prg_argv[2];
> +	char *prg_envp[1];
> +
> +	prg_argv[0] = BLUETOOTHD_BIN;
> +	prg_argv[1] = NULL;
> +
> +	prg_envp[0] = NULL;
> +
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char value[PROPERTY_VALUE_MAX];
> +
> +	if (property_get(PROPERTY_NAME, value, "") > 0 &&
> +			(!strcasecmp(value, "true") || atoi(value) > 0))
> +		run_valgrind();
> +
> +	/* In case we failed to execute Valgrind, try to run bluetoothd
> +	 * without it
> +	 */
> +
> +	run_bluetoothd();
> +
> +	return 0;
> +}

Applied, thanks.

-- 
BR
Szymon Janc
