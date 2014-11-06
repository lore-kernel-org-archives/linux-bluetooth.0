Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 04/15] android/hardware: Update audio.h HAL header
Date: Thu,  6 Nov 2014 17:05:49 +0200
Message-Id: <1415286360-26268-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/audio.h | 149 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 127 insertions(+), 22 deletions(-)

diff --git a/android/hardware/audio.h b/android/hardware/audio.h
index 61d92db..763ca58 100644
--- a/android/hardware/audio.h
+++ b/android/hardware/audio.h
@@ -23,6 +23,8 @@
 #include <sys/cdefs.h>
 #include <sys/types.h>
 
+#include <cutils/bitops.h>
+
 #include <hardware/hardware.h>
 #include <system/audio.h>
 #include <hardware/audio_effect.h>
@@ -52,7 +54,10 @@ __BEGIN_DECLS
 #define AUDIO_DEVICE_API_VERSION_0_0 HARDWARE_DEVICE_API_VERSION(0, 0)
 #define AUDIO_DEVICE_API_VERSION_1_0 HARDWARE_DEVICE_API_VERSION(1, 0)
 #define AUDIO_DEVICE_API_VERSION_2_0 HARDWARE_DEVICE_API_VERSION(2, 0)
-#define AUDIO_DEVICE_API_VERSION_CURRENT AUDIO_DEVICE_API_VERSION_2_0
+#define AUDIO_DEVICE_API_VERSION_3_0 HARDWARE_DEVICE_API_VERSION(3, 0)
+#define AUDIO_DEVICE_API_VERSION_CURRENT AUDIO_DEVICE_API_VERSION_3_0
+/* Minimal audio HAL version supported by the audio framework */
+#define AUDIO_DEVICE_API_VERSION_MIN AUDIO_DEVICE_API_VERSION_2_0
 
 /**
  * List of known audio HAL modules. This is the base name of the audio HAL
@@ -89,22 +94,37 @@ __BEGIN_DECLS
 #define AUDIO_PARAMETER_VALUE_TTY_HCO "tty_hco"
 #define AUDIO_PARAMETER_VALUE_TTY_FULL "tty_full"
 
+/* Hearing Aid Compatibility - Telecoil (HAC-T) mode on/off
+   Strings must be in sync with CallFeaturesSetting.java */
+#define AUDIO_PARAMETER_KEY_HAC "HACSetting"
+#define AUDIO_PARAMETER_VALUE_HAC_ON "ON"
+#define AUDIO_PARAMETER_VALUE_HAC_OFF "OFF"
+
 /* A2DP sink address set by framework */
 #define AUDIO_PARAMETER_A2DP_SINK_ADDRESS "a2dp_sink_address"
 
+/* A2DP source address set by framework */
+#define AUDIO_PARAMETER_A2DP_SOURCE_ADDRESS "a2dp_source_address"
+
 /* Screen state */
 #define AUDIO_PARAMETER_KEY_SCREEN_STATE "screen_state"
 
+/* Bluetooth SCO wideband */
+#define AUDIO_PARAMETER_KEY_BT_SCO_WB "bt_wbs"
+
+
 /**
  *  audio stream parameters
  */
 
-#define AUDIO_PARAMETER_STREAM_ROUTING "routing"            // audio_devices_t
-#define AUDIO_PARAMETER_STREAM_FORMAT "format"              // audio_format_t
-#define AUDIO_PARAMETER_STREAM_CHANNELS "channels"          // audio_channel_mask_t
-#define AUDIO_PARAMETER_STREAM_FRAME_COUNT "frame_count"    // size_t
-#define AUDIO_PARAMETER_STREAM_INPUT_SOURCE "input_source"  // audio_source_t
-#define AUDIO_PARAMETER_STREAM_SAMPLING_RATE "sampling_rate" // uint32_t
+#define AUDIO_PARAMETER_STREAM_ROUTING "routing"             /* audio_devices_t */
+#define AUDIO_PARAMETER_STREAM_FORMAT "format"               /* audio_format_t */
+#define AUDIO_PARAMETER_STREAM_CHANNELS "channels"           /* audio_channel_mask_t */
+#define AUDIO_PARAMETER_STREAM_FRAME_COUNT "frame_count"     /* size_t */
+#define AUDIO_PARAMETER_STREAM_INPUT_SOURCE "input_source"   /* audio_source_t */
+#define AUDIO_PARAMETER_STREAM_SAMPLING_RATE "sampling_rate" /* uint32_t */
+
+#define AUDIO_PARAMETER_DEVICE_DISCONNECT "disconnect"      /* audio_devices_t */
 
 /* Query supported formats. The response is a '|' separated list of strings from
  * audio_format_t enum e.g: "sup_formats=AUDIO_FORMAT_PCM_16_BIT" */
@@ -116,6 +136,11 @@ __BEGIN_DECLS
  * "sup_sampling_rates=44100|48000" */
 #define AUDIO_PARAMETER_STREAM_SUP_SAMPLING_RATES "sup_sampling_rates"
 
+/* Get the HW synchronization source used for an output stream.
+ * Return a valid source (positive integer) or AUDIO_HW_SYNC_INVALID if an error occurs
+ * or no HW sync source is used. */
+#define AUDIO_PARAMETER_STREAM_HW_AV_SYNC "hw_av_sync"
+
 /**
  * audio codec parameters
  */
@@ -135,18 +160,6 @@ __BEGIN_DECLS
 
 /**************************************/
 
-/* common audio stream configuration parameters
- * You should memset() the entire structure to zero before use to
- * ensure forward compatibility
- */
-struct audio_config {
-    uint32_t sample_rate;
-    audio_channel_mask_t channel_mask;
-    audio_format_t  format;
-    audio_offload_info_t offload_info;
-};
-typedef struct audio_config audio_config_t;
-
 /* common audio stream parameters and operations */
 struct audio_stream {
 
@@ -255,6 +268,11 @@ typedef enum {
  */
 
 struct audio_stream_out {
+    /**
+     * Common methods of the audio stream out.  This *must* be the first member of audio_stream_out
+     * as users of this structure will cast a audio_stream to audio_stream_out pointer in contexts
+     * where it's known the audio_stream references an audio_stream_out.
+     */
     struct audio_stream common;
 
     /**
@@ -378,6 +396,11 @@ struct audio_stream_out {
 typedef struct audio_stream_out audio_stream_out_t;
 
 struct audio_stream_in {
+    /**
+     * Common methods of the audio stream in.  This *must* be the first member of audio_stream_in
+     * as users of this structure will cast a audio_stream to audio_stream_in pointer in contexts
+     * where it's known the audio_stream references an audio_stream_in.
+     */
     struct audio_stream common;
 
     /** set the input gain for the audio driver. This method is for
@@ -407,7 +430,10 @@ typedef struct audio_stream_in audio_stream_in_t;
 
 /**
  * return the frame size (number of bytes per sample).
+ *
+ * Deprecated: use audio_stream_out_frame_size() or audio_stream_in_frame_size() instead.
  */
+__attribute__((__deprecated__))
 static inline size_t audio_stream_frame_size(const struct audio_stream *s)
 {
     size_t chan_samp_sz;
@@ -421,6 +447,37 @@ static inline size_t audio_stream_frame_size(const struct audio_stream *s)
     return sizeof(int8_t);
 }
 
+/**
+ * return the frame size (number of bytes per sample) of an output stream.
+ */
+static inline size_t audio_stream_out_frame_size(const struct audio_stream_out *s)
+{
+    size_t chan_samp_sz;
+    audio_format_t format = s->common.get_format(&s->common);
+
+    if (audio_is_linear_pcm(format)) {
+        chan_samp_sz = audio_bytes_per_sample(format);
+        return audio_channel_count_from_out_mask(s->common.get_channels(&s->common)) * chan_samp_sz;
+    }
+
+    return sizeof(int8_t);
+}
+
+/**
+ * return the frame size (number of bytes per sample) of an input stream.
+ */
+static inline size_t audio_stream_in_frame_size(const struct audio_stream_in *s)
+{
+    size_t chan_samp_sz;
+    audio_format_t format = s->common.get_format(&s->common);
+
+    if (audio_is_linear_pcm(format)) {
+        chan_samp_sz = audio_bytes_per_sample(format);
+        return audio_channel_count_from_in_mask(s->common.get_channels(&s->common)) * chan_samp_sz;
+    }
+
+    return sizeof(int8_t);
+}
 
 /**********************************************************************/
 
@@ -434,6 +491,11 @@ struct audio_module {
 };
 
 struct audio_hw_device {
+    /**
+     * Common methods of the audio device.  This *must* be the first member of audio_hw_device
+     * as users of this structure will cast a hw_device_t to audio_hw_device pointer in contexts
+     * where it's known the hw_device_t references an audio_hw_device.
+     */
     struct hw_device_t common;
 
     /**
@@ -503,13 +565,21 @@ struct audio_hw_device {
     size_t (*get_input_buffer_size)(const struct audio_hw_device *dev,
                                     const struct audio_config *config);
 
-    /** This method creates and opens the audio hardware output stream */
+    /** This method creates and opens the audio hardware output stream.
+     * The "address" parameter qualifies the "devices" audio device type if needed.
+     * The format format depends on the device type:
+     * - Bluetooth devices use the MAC address of the device in the form "00:11:22:AA:BB:CC"
+     * - USB devices use the ALSA card and device numbers in the form  "card=X;device=Y"
+     * - Other devices may use a number or any other string.
+     */
+
     int (*open_output_stream)(struct audio_hw_device *dev,
                               audio_io_handle_t handle,
                               audio_devices_t devices,
                               audio_output_flags_t flags,
                               struct audio_config *config,
-                              struct audio_stream_out **stream_out);
+                              struct audio_stream_out **stream_out,
+                              const char *address);
 
     void (*close_output_stream)(struct audio_hw_device *dev,
                                 struct audio_stream_out* stream_out);
@@ -519,7 +589,10 @@ struct audio_hw_device {
                              audio_io_handle_t handle,
                              audio_devices_t devices,
                              struct audio_config *config,
-                             struct audio_stream_in **stream_in);
+                             struct audio_stream_in **stream_in,
+                             audio_input_flags_t flags,
+                             const char *address,
+                             audio_source_t source);
 
     void (*close_input_stream)(struct audio_hw_device *dev,
                                struct audio_stream_in *stream_in);
@@ -541,6 +614,38 @@ struct audio_hw_device {
      * method may leave it set to NULL.
      */
     int (*get_master_mute)(struct audio_hw_device *dev, bool *mute);
+
+    /**
+     * Routing control
+     */
+
+    /* Creates an audio patch between several source and sink ports.
+     * The handle is allocated by the HAL and should be unique for this
+     * audio HAL module. */
+    int (*create_audio_patch)(struct audio_hw_device *dev,
+                               unsigned int num_sources,
+                               const struct audio_port_config *sources,
+                               unsigned int num_sinks,
+                               const struct audio_port_config *sinks,
+                               audio_patch_handle_t *handle);
+
+    /* Release an audio patch */
+    int (*release_audio_patch)(struct audio_hw_device *dev,
+                               audio_patch_handle_t handle);
+
+    /* Fills the list of supported attributes for a given audio port.
+     * As input, "port" contains the information (type, role, address etc...)
+     * needed by the HAL to identify the port.
+     * As output, "port" contains possible attributes (sampling rates, formats,
+     * channel masks, gain controllers...) for this port.
+     */
+    int (*get_audio_port)(struct audio_hw_device *dev,
+                          struct audio_port *port);
+
+    /* Set audio port configuration */
+    int (*set_audio_port_config)(struct audio_hw_device *dev,
+                         const struct audio_port_config *config);
+
 };
 typedef struct audio_hw_device audio_hw_device_t;
 
-- 
1.9.1

