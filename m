Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 11:55:47 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 01/12] android/hal-sco: Add audio HAL for SCO handling
Message-ID: <20140508085542.GA21149@aemeltch-MOBL1>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399536103-19052-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399536103-19052-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 08, 2014 at 11:01:32AM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This adds audio HAL for handling SCO. Following needs to be added to
> audio_policy.conf:
> 
>   sco {
>     outputs {
>       sco {
>         ...
>         devices AUDIO_DEVICE_OUT_ALL_SCO
>         ...
>       }
>     }
> ---
>  android/Android.mk  |  23 ++++++
>  android/Makefile.am |  15 ++++
>  android/hal-sco.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 android/hal-sco.c
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 638a042..b7b284d 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -271,6 +271,29 @@ LOCAL_MODULE := audio.a2dp.default
>  include $(BUILD_SHARED_LIBRARY)
>  
>  #
> +# SCO audio
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := bluez/android/hal-sco.c
> +
> +LOCAL_C_INCLUDES = \
> +	$(call include-path-for, system-core) \
> +	$(call include-path-for, libhardware) \
> +
> +LOCAL_SHARED_LIBRARIES := \
> +	libcutils \
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> +LOCAL_MODULE_TAGS := optional
> +LOCAL_MODULE := audio.sco.default

I changed hsp to sco, I think this is not a good idea here since hsp is
mentioned in audio_policy.conf

Best regards 
Andrei Emeltchenko 


> +
> +include $(BUILD_SHARED_LIBRARY)
> +
> +#
>  # l2cap-test
>  #
>  
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 5ab6411..990ce6b 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -169,6 +169,21 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
>  					android/hardware/hardware.h \
>  					android/system/audio.h
>  
> +android_audio_sco_default_la_SOURCES = android/audio-msg.h \
> +					android/hal-msg.h \
> +					android/hal-sco.c \
> +					android/hardware/audio.h \
> +					android/hardware/audio_effect.h \
> +					android/hardware/hardware.h \
> +					android/system/audio.h
> +
> +android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
> +
> +android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
> +					-no-undefined -lrt
> +
> +plugin_LTLIBRARIES += android/audio.sco.default.la
> +
>  unit_tests += android/test-ipc
>  
>  android_test_ipc_SOURCES = android/test-ipc.c \
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> new file mode 100644
> index 0000000..c7ba504
> --- /dev/null
> +++ b/android/hal-sco.c
> @@ -0,0 +1,211 @@
> +/*
> + * Copyright (C) 2013 Intel Corporation
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
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + *
> + */
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <hardware/audio.h>
> +#include <hardware/hardware.h>
> +
> +#include "hal-log.h"
> +
> +struct hsp_audio_dev {
> +	struct audio_hw_device dev;
> +	struct a2dp_stream_out *out;
> +};
> +
> +static int audio_open_output_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					audio_output_flags_t flags,
> +					struct audio_config *config,
> +					struct audio_stream_out **stream_out)
> +
> +{
> +	DBG("");
> +
> +	return -EINVAL;
> +}
> +
> +static void audio_close_output_stream(struct audio_hw_device *dev,
> +					struct audio_stream_out *stream_out)
> +{
> +	DBG("");
> +
> +	free(stream_out);
> +}
> +
> +static int audio_set_parameters(struct audio_hw_device *dev,
> +							const char *kvpairs)
> +{
> +	DBG("%s", kvpairs);
> +
> +	return 0;
> +}
> +
> +static char *audio_get_parameters(const struct audio_hw_device *dev,
> +							const char *keys)
> +{
> +	DBG("");
> +
> +	return strdup("");
> +}
> +
> +static int audio_init_check(const struct audio_hw_device *dev)
> +{
> +	DBG("");
> +
> +	return 0;
> +}
> +
> +static int audio_set_voice_volume(struct audio_hw_device *dev, float volume)
> +{
> +	DBG("%f", volume);
> +
> +	return 0;
> +}
> +
> +static int audio_set_master_volume(struct audio_hw_device *dev, float volume)
> +{
> +	DBG("%f", volume);
> +
> +	return 0;
> +}
> +
> +static int audio_set_mode(struct audio_hw_device *dev, int mode)
> +{
> +	DBG("");
> +
> +	return -ENOSYS;
> +}
> +
> +static int audio_set_mic_mute(struct audio_hw_device *dev, bool state)
> +{
> +	DBG("");
> +
> +	return -ENOSYS;
> +}
> +
> +static int audio_get_mic_mute(const struct audio_hw_device *dev, bool *state)
> +{
> +	DBG("");
> +
> +	return -ENOSYS;
> +}
> +
> +static size_t audio_get_input_buffer_size(const struct audio_hw_device *dev,
> +					const struct audio_config *config)
> +{
> +	DBG("");
> +
> +	return -ENOSYS;
> +}
> +
> +static int audio_open_input_stream(struct audio_hw_device *dev,
> +					audio_io_handle_t handle,
> +					audio_devices_t devices,
> +					struct audio_config *config,
> +					struct audio_stream_in **stream_in)
> +{
> +	DBG("");
> +
> +	return 0;
> +}
> +
> +static void audio_close_input_stream(struct audio_hw_device *dev,
> +					struct audio_stream_in *stream_in)
> +{
> +	DBG("");
> +
> +	free(stream_in);
> +}
> +
> +static int audio_dump(const audio_hw_device_t *device, int fd)
> +{
> +	DBG("");
> +
> +	return 0;
> +}
> +
> +static int audio_close(hw_device_t *device)
> +{
> +	DBG("");
> +
> +	free(device);
> +
> +	return 0;
> +}
> +
> +static int audio_open(const hw_module_t *module, const char *name,
> +							hw_device_t **device)
> +{
> +	struct hsp_audio_dev *adev;
> +
> +	DBG("");
> +
> +	if (strcmp(name, AUDIO_HARDWARE_INTERFACE)) {
> +		error("audio: interface %s not matching [%s]", name,
> +						AUDIO_HARDWARE_INTERFACE);
> +		return -EINVAL;
> +	}
> +
> +	adev = calloc(1, sizeof(struct hsp_audio_dev));
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->dev.common.tag = HARDWARE_DEVICE_TAG;
> +	adev->dev.common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
> +	adev->dev.common.module = (struct hw_module_t *) module;
> +	adev->dev.common.close = audio_close;
> +
> +	adev->dev.init_check = audio_init_check;
> +	adev->dev.set_voice_volume = audio_set_voice_volume;
> +	adev->dev.set_master_volume = audio_set_master_volume;
> +	adev->dev.set_mode = audio_set_mode;
> +	adev->dev.set_mic_mute = audio_set_mic_mute;
> +	adev->dev.get_mic_mute = audio_get_mic_mute;
> +	adev->dev.set_parameters = audio_set_parameters;
> +	adev->dev.get_parameters = audio_get_parameters;
> +	adev->dev.get_input_buffer_size = audio_get_input_buffer_size;
> +	adev->dev.open_output_stream = audio_open_output_stream;
> +	adev->dev.close_output_stream = audio_close_output_stream;
> +	adev->dev.open_input_stream = audio_open_input_stream;
> +	adev->dev.close_input_stream = audio_close_input_stream;
> +	adev->dev.dump = audio_dump;
> +
> +	*device = &adev->dev.common;
> +
> +	return 0;
> +}
> +
> +static struct hw_module_methods_t hal_module_methods = {
> +	.open = audio_open,
> +};
> +
> +struct audio_module HAL_MODULE_INFO_SYM = {
> +	.common = {
> +		.tag = HARDWARE_MODULE_TAG,
> +		.version_major = 1,
> +		.version_minor = 0,
> +		.id = AUDIO_HARDWARE_MODULE_ID,
> +		.name = "HSP Audio HW HAL",
> +		.author = "Intel Corporation",
> +		.methods = &hal_module_methods,
> +	},
> +};
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
