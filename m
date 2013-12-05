Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/audio: Add audio-hal initial skeleton
Date: Thu, 5 Dec 2013 14:59:54 +0100
Message-ID: <1386251995-12188-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1386251995-12188-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1386251995-12188-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds audio module for A2DP.
Also adds empty callbacks for stream_out, stream_in and hw_device
methods.
---
 android/Android.mk  |  23 +++
 android/Makefile.am |  10 ++
 android/hal-audio.c | 436 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 469 insertions(+)
 create mode 100644 android/hal-audio.c

diff --git a/android/Android.mk b/android/Android.mk
index 549613c..ebc3219 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -203,3 +203,26 @@ LOCAL_MODULE_TAGS := eng
 LOCAL_MODULE := btmon
 
 include $(BUILD_EXECUTABLE)
+
+#
+# A2DP audio
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := hal-audio.c
+
+LOCAL_C_INCLUDES = \
+	$(call include-path-for, system-core) \
+	$(call include-path-for, libhardware) \
+
+LOCAL_SHARED_LIBRARIES := \
+	libcutils \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE := audio.a2dp.default
+
+include $(BUILD_SHARED_LIBRARY)
diff --git a/android/Makefile.am b/android/Makefile.am
index df04762..9349a61 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -83,6 +83,16 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 
 android_haltest_LDFLAGS = -pthread
 
+noinst_LTLIBRARIES += android/libaudio-internal.la
+
+android_libaudio_internal_la_SOURCES = android/hal-audio.c \
+					android/hardware/audio.h \
+					android/hardware/audio_effect.h \
+					android/hardware/hardware.h \
+					android/system/audio.h
+
+android_libaudio_internal_la_CPPFLAGS = -I$(srcdir)/android
+
 endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
diff --git a/android/hal-audio.c b/android/hal-audio.c
new file mode 100644
index 0000000..e98f317
--- /dev/null
+++ b/android/hal-audio.c
@@ -0,0 +1,436 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <hardware/audio.h>
+#include <hardware/hardware.h>
+
+#include "hal-log.h"
+
+static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
+								size_t bytes)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static uint32_t out_get_sample_rate(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static size_t out_get_buffer_size(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static uint32_t out_get_channels(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static audio_format_t out_get_format(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_set_format(struct audio_stream *stream, audio_format_t format)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_standby(struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_dump(const struct audio_stream *stream, int fd)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_set_parameters(struct audio_stream *stream, const char *kvpairs)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static char *out_get_parameters(const struct audio_stream *stream,
+							const char *keys)
+{
+	DBG("");
+	return strdup("");
+}
+
+static uint32_t out_get_latency(const struct audio_stream_out *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_set_volume(struct audio_stream_out *stream, float left,
+								float right)
+{
+	DBG("");
+	/* volume controlled in audioflinger mixer (digital) */
+	return -ENOSYS;
+}
+
+static int out_get_render_position(const struct audio_stream_out *stream,
+							uint32_t *dsp_frames)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_add_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int out_remove_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static uint32_t in_get_sample_rate(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_set_sample_rate(struct audio_stream *stream, uint32_t rate)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static size_t in_get_buffer_size(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static uint32_t in_get_channels(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static audio_format_t in_get_format(const struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_set_format(struct audio_stream *stream, audio_format_t format)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_standby(struct audio_stream *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_dump(const struct audio_stream *stream, int fd)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_set_parameters(struct audio_stream *stream, const char *kvpairs)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static char *in_get_parameters(const struct audio_stream *stream,
+							const char *keys)
+{
+	DBG("");
+	return strdup("");
+}
+
+static int in_set_gain(struct audio_stream_in *stream, float gain)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
+								size_t bytes)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static uint32_t in_get_input_frames_lost(struct audio_stream_in *stream)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_add_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int in_remove_audio_effect(const struct audio_stream *stream,
+							effect_handle_t effect)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_open_output_stream(struct audio_hw_device *dev,
+					audio_io_handle_t handle,
+					audio_devices_t devices,
+					audio_output_flags_t flags,
+					struct audio_config *config,
+					struct audio_stream_out **stream_out)
+
+{
+	struct audio_stream_out *out;
+
+	out = calloc(1, sizeof(struct audio_stream_out));
+	if (!out)
+		return -ENOMEM;
+
+	DBG("");
+
+	out->common.get_sample_rate = out_get_sample_rate;
+	out->common.set_sample_rate = out_set_sample_rate;
+	out->common.get_buffer_size = out_get_buffer_size;
+	out->common.get_channels = out_get_channels;
+	out->common.get_format = out_get_format;
+	out->common.set_format = out_set_format;
+	out->common.standby = out_standby;
+	out->common.dump = out_dump;
+	out->common.set_parameters = out_set_parameters;
+	out->common.get_parameters = out_get_parameters;
+	out->common.add_audio_effect = out_add_audio_effect;
+	out->common.remove_audio_effect = out_remove_audio_effect;
+	out->get_latency = out_get_latency;
+	out->set_volume = out_set_volume;
+	out->write = out_write;
+	out->get_render_position = out_get_render_position;
+
+	*stream_out = out;
+
+	return 0;
+}
+
+static void adev_close_output_stream(struct audio_hw_device *dev,
+					struct audio_stream_out *stream)
+{
+	DBG("");
+}
+
+static int adev_set_parameters(struct audio_hw_device *dev,
+							const char *kvpairs)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static char *adev_get_parameters(const struct audio_hw_device *dev,
+							const char *keys)
+{
+	DBG("");
+	return strdup("");
+}
+
+static int adev_init_check(const struct audio_hw_device *dev)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_set_voice_volume(struct audio_hw_device *dev, float volume)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_set_master_volume(struct audio_hw_device *dev, float volume)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_set_mode(struct audio_hw_device *dev, int mode)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_set_mic_mute(struct audio_hw_device *dev, bool state)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_get_mic_mute(const struct audio_hw_device *dev, bool *state)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static size_t adev_get_input_buffer_size(const struct audio_hw_device *dev,
+					const struct audio_config *config)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_open_input_stream(struct audio_hw_device *dev,
+						audio_io_handle_t handle,
+						audio_devices_t devices,
+						struct audio_config *config,
+					  struct audio_stream_in **stream_in)
+{
+	struct audio_stream_in *in;
+
+	DBG("");
+
+	in = calloc(1, sizeof(struct audio_stream_in));
+	if (!in)
+		return -ENOMEM;
+
+	in->common.get_sample_rate = in_get_sample_rate;
+	in->common.set_sample_rate = in_set_sample_rate;
+	in->common.get_buffer_size = in_get_buffer_size;
+	in->common.get_channels = in_get_channels;
+	in->common.get_format = in_get_format;
+	in->common.set_format = in_set_format;
+	in->common.standby = in_standby;
+	in->common.dump = in_dump;
+	in->common.set_parameters = in_set_parameters;
+	in->common.get_parameters = in_get_parameters;
+	in->common.add_audio_effect = in_add_audio_effect;
+	in->common.remove_audio_effect = in_remove_audio_effect;
+	in->set_gain = in_set_gain;
+	in->read = in_read;
+	in->get_input_frames_lost = in_get_input_frames_lost;
+
+	*stream_in = in;
+
+	return 0;
+}
+
+static void adev_close_input_stream(struct audio_hw_device *dev,
+					struct audio_stream_in *stream_in)
+{
+	DBG("");
+	free(stream_in);
+}
+
+static int adev_dump(const audio_hw_device_t *device, int fd)
+{
+	DBG("");
+	return -ENOSYS;
+}
+
+static int adev_close(hw_device_t *device)
+{
+	DBG("");
+	free(device);
+	return 0;
+}
+
+static int adev_open(const hw_module_t *module, const char *name,
+							hw_device_t **device)
+{
+	struct audio_hw_device *adev;
+
+	DBG("");
+
+	if (strcmp(name, AUDIO_HARDWARE_INTERFACE)) {
+		error("interface %s not matching [%s]", name,
+						AUDIO_HARDWARE_INTERFACE);
+		return -EINVAL;
+	}
+
+	adev = calloc(1, sizeof(struct audio_hw_device));
+	if (!adev)
+		return -ENOMEM;
+
+	adev->common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
+	adev->common.module = (struct hw_module_t *) module;
+	adev->common.close = adev_close;
+
+	adev->init_check = adev_init_check;
+	adev->set_voice_volume = adev_set_voice_volume;
+	adev->set_master_volume = adev_set_master_volume;
+	adev->set_mode = adev_set_mode;
+	adev->set_mic_mute = adev_set_mic_mute;
+	adev->get_mic_mute = adev_get_mic_mute;
+	adev->set_parameters = adev_set_parameters;
+	adev->get_parameters = adev_get_parameters;
+	adev->get_input_buffer_size = adev_get_input_buffer_size;
+	adev->open_output_stream = adev_open_output_stream;
+	adev->close_output_stream = adev_close_output_stream;
+	adev->open_input_stream = adev_open_input_stream;
+	adev->close_input_stream = adev_close_input_stream;
+	adev->dump = adev_dump;
+
+	*device = &adev->common;
+
+	return 0;
+}
+
+static struct hw_module_methods_t hal_module_methods = {
+	.open = adev_open,
+};
+
+struct audio_module HAL_MODULE_INFO_SYM = {
+	.common = {
+	.tag = HARDWARE_MODULE_TAG,
+	.version_major = 1,
+	.version_minor = 0,
+	.id = AUDIO_HARDWARE_MODULE_ID,
+	.name = "A2DP Bluez HW HAL",
+	.author = "Intel Corporation",
+	.methods = &hal_module_methods,
+	},
+};
-- 
1.8.4

