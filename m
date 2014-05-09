Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 08/13] android/audio: Add resampler support
Date: Fri,  9 May 2014 12:19:50 +0300
Message-Id: <1399627195-471-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399627195-471-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399627195-471-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch adds support for resampling audio in host and Android. There
are Android wrappers for SPEEXDSP library added to host.
---
 android/Android.mk              |   2 +
 android/Makefile.am             |   6 +-
 android/audio_utils/resampler.c | 265 ++++++++++++++++++++++++++++++++++++++++
 android/audio_utils/resampler.h | 109 +++++++++++++++++
 configure.ac                    |   7 ++
 5 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 android/audio_utils/resampler.c
 create mode 100644 android/audio_utils/resampler.h

diff --git a/android/Android.mk b/android/Android.mk
index c68dd11..e842928 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -282,9 +282,11 @@ LOCAL_SRC_FILES := bluez/android/hal-sco.c
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
+	$(call include-path-for, audio-utils) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
+	libaudioutils \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
diff --git a/android/Makefile.am b/android/Makefile.am
index a109fa7..5e61f03 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -176,9 +176,13 @@ android_audio_sco_default_la_SOURCES = android/audio-msg.h \
 					android/hardware/audio.h \
 					android/hardware/audio_effect.h \
 					android/hardware/hardware.h \
+					android/audio_utils/resampler.c \
+					android/audio_utils/resampler.h \
 					android/system/audio.h
 
-android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android -Wno-declaration-after-statement
+
+android_audio_sco_default_la_LIBADD = @SPEEXDSP_LIBS@
 
 android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined -lrt
diff --git a/android/audio_utils/resampler.c b/android/audio_utils/resampler.c
new file mode 100644
index 0000000..137e4d2
--- /dev/null
+++ b/android/audio_utils/resampler.c
@@ -0,0 +1,265 @@
+/*
+** Copyright 2011, The Android Open-Source Project
+**
+** Licensed under the Apache License, Version 2.0 (the "License");
+** you may not use this file except in compliance with the License.
+** You may obtain a copy of the License at
+**
+**     http://www.apache.org/licenses/LICENSE-2.0
+**
+** Unless required by applicable law or agreed to in writing, software
+** distributed under the License is distributed on an "AS IS" BASIS,
+** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+** See the License for the specific language governing permissions and
+** limitations under the License.
+*/
+
+//#define LOG_NDEBUG 0
+
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <system/audio.h>
+#include <audio_utils/resampler.h>
+#include <speex/speex_resampler.h>
+
+#include "hal-log.h"
+
+struct resampler {
+    struct resampler_itfe itfe;
+    SpeexResamplerState *speex_resampler;       // handle on speex resampler
+    struct resampler_buffer_provider *provider; // buffer provider installed by client
+    uint32_t in_sample_rate;                    // input sampling rate in Hz
+    uint32_t out_sample_rate;                   // output sampling rate in Hz
+    uint32_t channel_count;                     // number of channels (interleaved)
+    int16_t *in_buf;                            // input buffer
+    size_t in_buf_size;                         // input buffer size
+    size_t frames_in;                           // number of frames in input buffer
+    size_t frames_rq;                           // cached number of output frames
+    size_t frames_needed;                       // minimum number of input frames to produce
+                                                // frames_rq output frames
+    int32_t speex_delay_ns;                     // delay introduced by speex resampler in ns
+};
+
+
+//------------------------------------------------------------------------------
+// speex based resampler
+//------------------------------------------------------------------------------
+
+static void resampler_reset(struct resampler_itfe *resampler)
+{
+    struct resampler *rsmp = (struct resampler *)resampler;
+
+    rsmp->frames_in = 0;
+    rsmp->frames_rq = 0;
+
+    if (rsmp != NULL && rsmp->speex_resampler != NULL) {
+        speex_resampler_reset_mem(rsmp->speex_resampler);
+    }
+}
+
+static int32_t resampler_delay_ns(struct resampler_itfe *resampler)
+{
+    struct resampler *rsmp = (struct resampler *)resampler;
+
+    int32_t delay = (int32_t)((1000000000 * (int64_t)rsmp->frames_in) / rsmp->in_sample_rate);
+    delay += rsmp->speex_delay_ns;
+
+    return delay;
+}
+
+// outputs a number of frames less or equal to *outFrameCount and updates *outFrameCount
+// with the actual number of frames produced.
+static int resampler_resample_from_provider(struct resampler_itfe *resampler,
+                       int16_t *out,
+                       size_t *outFrameCount)
+{
+    struct resampler *rsmp = (struct resampler *)resampler;
+
+    if (rsmp == NULL || out == NULL || outFrameCount == NULL) {
+        return -EINVAL;
+    }
+    if (rsmp->provider == NULL) {
+        *outFrameCount = 0;
+        return -ENOSYS;
+    }
+
+    size_t framesRq = *outFrameCount;
+    // update and cache the number of frames needed at the input sampling rate to produce
+    // the number of frames requested at the output sampling rate
+    if (framesRq != rsmp->frames_rq) {
+        rsmp->frames_needed = (framesRq * rsmp->in_sample_rate) / rsmp->out_sample_rate + 1;
+        rsmp->frames_rq = framesRq;
+    }
+
+    size_t framesWr = 0;
+    size_t inFrames = 0;
+    while (framesWr < framesRq) {
+        if (rsmp->frames_in < rsmp->frames_needed) {
+            // make sure that the number of frames present in rsmp->in_buf (rsmp->frames_in) is at
+            // least the number of frames needed to produce the number of frames requested at
+            // the output sampling rate
+            if (rsmp->in_buf_size < rsmp->frames_needed) {
+                rsmp->in_buf_size = rsmp->frames_needed;
+                rsmp->in_buf = (int16_t *)realloc(rsmp->in_buf,
+                                        rsmp->in_buf_size * rsmp->channel_count * sizeof(int16_t));
+            }
+            struct resampler_buffer buf;
+            buf.frame_count = rsmp->frames_needed - rsmp->frames_in;
+            rsmp->provider->get_next_buffer(rsmp->provider, &buf);
+            if (buf.raw == NULL) {
+                break;
+            }
+            memcpy(rsmp->in_buf + rsmp->frames_in * rsmp->channel_count,
+                    buf.raw,
+                    buf.frame_count * rsmp->channel_count * sizeof(int16_t));
+            rsmp->frames_in += buf.frame_count;
+            rsmp->provider->release_buffer(rsmp->provider, &buf);
+        }
+
+        size_t outFrames = framesRq - framesWr;
+        inFrames = rsmp->frames_in;
+        if (rsmp->channel_count == 1) {
+            speex_resampler_process_int(rsmp->speex_resampler,
+                                        0,
+                                        rsmp->in_buf,
+                                        (void *) &inFrames,
+                                        out + framesWr,
+                                        (void *) &outFrames);
+        } else {
+            speex_resampler_process_interleaved_int(rsmp->speex_resampler,
+                                        rsmp->in_buf,
+                                        (void *) &inFrames,
+                                        out + framesWr * rsmp->channel_count,
+                                        (void *) &outFrames);
+        }
+        framesWr += outFrames;
+        rsmp->frames_in -= inFrames;
+
+        if ((framesWr != framesRq) && (rsmp->frames_in != 0))
+            warn("ReSampler::resample() remaining %zd frames in and %zd out",
+                rsmp->frames_in, (framesRq - framesWr));
+    }
+    if (rsmp->frames_in) {
+        memmove(rsmp->in_buf,
+                rsmp->in_buf + inFrames * rsmp->channel_count,
+                rsmp->frames_in * rsmp->channel_count * sizeof(int16_t));
+    }
+    *outFrameCount = framesWr;
+
+    return 0;
+}
+
+static int resampler_resample_from_input(struct resampler_itfe *resampler,
+                                  int16_t *in,
+                                  size_t *inFrameCount,
+                                  int16_t *out,
+                                  size_t *outFrameCount)
+{
+    struct resampler *rsmp = (struct resampler *)resampler;
+
+    if (rsmp == NULL || in == NULL || inFrameCount == NULL ||
+            out == NULL || outFrameCount == NULL) {
+        return -EINVAL;
+    }
+    if (rsmp->provider != NULL) {
+        *outFrameCount = 0;
+        return -ENOSYS;
+    }
+
+    if (rsmp->channel_count == 1) {
+        speex_resampler_process_int(rsmp->speex_resampler,
+                                    0,
+                                    in,
+                                    (void *) inFrameCount,
+                                    out,
+                                    (void *) outFrameCount);
+    } else {
+        speex_resampler_process_interleaved_int(rsmp->speex_resampler,
+                                                in,
+                                                (void *) inFrameCount,
+                                                out,
+                                                (void *) outFrameCount);
+    }
+
+    DBG("resampler_resample_from_input() DONE in %zd out %zd", *inFrameCount, *outFrameCount);
+
+    return 0;
+}
+
+int create_resampler(uint32_t inSampleRate,
+                    uint32_t outSampleRate,
+                    uint32_t channelCount,
+                    uint32_t quality,
+                    struct resampler_buffer_provider* provider,
+                    struct resampler_itfe **resampler)
+{
+    int error;
+    struct resampler *rsmp;
+
+    DBG("create_resampler() In SR %d Out SR %d channels %d",
+         inSampleRate, outSampleRate, channelCount);
+
+    if (resampler == NULL) {
+        return -EINVAL;
+    }
+
+    *resampler = NULL;
+
+    if (quality <= RESAMPLER_QUALITY_MIN || quality >= RESAMPLER_QUALITY_MAX) {
+        return -EINVAL;
+    }
+
+    rsmp = (struct resampler *)calloc(1, sizeof(struct resampler));
+
+    rsmp->speex_resampler = speex_resampler_init(channelCount,
+                                      inSampleRate,
+                                      outSampleRate,
+                                      quality,
+                                      &error);
+    if (rsmp->speex_resampler == NULL) {
+        error("ReSampler: Cannot create speex resampler: %s", speex_resampler_strerror(error));
+        free(rsmp);
+        return -ENODEV;
+    }
+
+    rsmp->itfe.reset = resampler_reset;
+    rsmp->itfe.resample_from_provider = resampler_resample_from_provider;
+    rsmp->itfe.resample_from_input = resampler_resample_from_input;
+    rsmp->itfe.delay_ns = resampler_delay_ns;
+
+    rsmp->provider = provider;
+    rsmp->in_sample_rate = inSampleRate;
+    rsmp->out_sample_rate = outSampleRate;
+    rsmp->channel_count = channelCount;
+    rsmp->in_buf = NULL;
+    rsmp->in_buf_size = 0;
+
+    resampler_reset(&rsmp->itfe);
+
+    int frames = speex_resampler_get_input_latency(rsmp->speex_resampler);
+    rsmp->speex_delay_ns = (int32_t)((1000000000 * (int64_t)frames) / rsmp->in_sample_rate);
+    frames = speex_resampler_get_output_latency(rsmp->speex_resampler);
+    rsmp->speex_delay_ns += (int32_t)((1000000000 * (int64_t)frames) / rsmp->out_sample_rate);
+
+    *resampler = &rsmp->itfe;
+    DBG("create_resampler() DONE rsmp %p &rsmp->itfe %p speex %p",
+         rsmp, &rsmp->itfe, rsmp->speex_resampler);
+    return 0;
+}
+
+void release_resampler(struct resampler_itfe *resampler)
+{
+    struct resampler *rsmp = (struct resampler *)resampler;
+
+    if (rsmp == NULL) {
+        return;
+    }
+
+    free(rsmp->in_buf);
+
+    if (rsmp->speex_resampler != NULL) {
+        speex_resampler_destroy(rsmp->speex_resampler);
+    }
+    free(rsmp);
+}
diff --git a/android/audio_utils/resampler.h b/android/audio_utils/resampler.h
new file mode 100644
index 0000000..0c7046f
--- /dev/null
+++ b/android/audio_utils/resampler.h
@@ -0,0 +1,109 @@
+/*
+** Copyright 2008, The Android Open-Source Project
+**
+** Licensed under the Apache License, Version 2.0 (the "License");
+** you may not use this file except in compliance with the License.
+** You may obtain a copy of the License at
+**
+**     http://www.apache.org/licenses/LICENSE-2.0
+**
+** Unless required by applicable law or agreed to in writing, software
+** distributed under the License is distributed on an "AS IS" BASIS,
+** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+** See the License for the specific language governing permissions and
+** limitations under the License.
+*/
+
+#ifndef ANDROID_RESAMPLER_H
+#define ANDROID_RESAMPLER_H
+
+#include <stdint.h>
+#include <sys/time.h>
+
+__BEGIN_DECLS
+
+
+#define RESAMPLER_QUALITY_MAX 10
+#define RESAMPLER_QUALITY_MIN 0
+#define RESAMPLER_QUALITY_DEFAULT 4
+#define RESAMPLER_QUALITY_VOIP 3
+#define RESAMPLER_QUALITY_DESKTOP 5
+
+struct resampler_buffer {
+    union {
+        void*       raw;
+        short*      i16;
+        int8_t*     i8;
+    };
+    size_t frame_count;
+};
+
+/* call back interface used by the resampler to get new data */
+struct resampler_buffer_provider
+{
+    /**
+     *  get a new buffer of data:
+     *   as input: buffer->frame_count is the number of frames requested
+     *   as output: buffer->frame_count is the number of frames returned
+     *              buffer->raw points to data returned
+     */
+    int (*get_next_buffer)(struct resampler_buffer_provider *provider,
+            struct resampler_buffer *buffer);
+    /**
+     *  release a consumed buffer of data:
+     *   as input: buffer->frame_count is the number of frames released
+     *             buffer->raw points to data released
+     */
+    void (*release_buffer)(struct resampler_buffer_provider *provider,
+            struct resampler_buffer *buffer);
+};
+
+/* resampler interface */
+struct resampler_itfe {
+    /**
+     * reset resampler state
+     */
+    void (*reset)(struct resampler_itfe *resampler);
+    /**
+     * resample input from buffer provider and output at most *outFrameCount to out buffer.
+     * *outFrameCount is updated with the actual number of frames produced.
+     */
+    int (*resample_from_provider)(struct resampler_itfe *resampler,
+                    int16_t *out,
+                    size_t *outFrameCount);
+    /**
+     * resample at most *inFrameCount frames from in buffer and output at most
+     * *outFrameCount to out buffer. *inFrameCount and *outFrameCount are updated respectively
+     * with the number of frames remaining in input and written to output.
+     */
+    int (*resample_from_input)(struct resampler_itfe *resampler,
+                    int16_t *in,
+                    size_t *inFrameCount,
+                    int16_t *out,
+                    size_t *outFrameCount);
+    /**
+     * return the latency introduced by the resampler in ns.
+     */
+    int32_t (*delay_ns)(struct resampler_itfe *resampler);
+};
+
+/**
+ * create a resampler according to input parameters passed.
+ * If resampler_buffer_provider is not NULL only resample_from_provider() can be called.
+ * If resampler_buffer_provider is NULL only resample_from_input() can be called.
+ */
+int create_resampler(uint32_t inSampleRate,
+          uint32_t outSampleRate,
+          uint32_t channelCount,
+          uint32_t quality,
+          struct resampler_buffer_provider *provider,
+          struct resampler_itfe **);
+
+/**
+ * release resampler resources.
+ */
+void release_resampler(struct resampler_itfe *);
+
+__END_DECLS
+
+#endif // ANDROID_RESAMPLER_H
diff --git a/configure.ac b/configure.ac
index 54a387f..e1a2288 100644
--- a/configure.ac
+++ b/configure.ac
@@ -259,6 +259,13 @@ if (test "${enable_android}" = "yes"); then
 	AC_SUBST(SBC_LIBS)
 fi
 
+if (test "${enable_android}" = "yes"); then
+	PKG_CHECK_MODULES(SPEEXDSP, speexdsp >= 1.2, dummy=yes,
+					AC_MSG_ERROR(SPEEXDSP library >= 1.2 is required))
+	AC_SUBST(SPEEXDSP_CFLAGS)
+	AC_SUBST(SPEEXDSP_LIBS)
+fi
+
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-- 
1.8.3.2

