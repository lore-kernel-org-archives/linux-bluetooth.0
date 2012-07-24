Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] gsta2dpsink: Fix using deprecated glib api
Date: Tue, 24 Jul 2012 14:04:41 +0200
Message-ID: <1343131482-17629-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_mutex_new() is deprecated in glib 2.33. GMutex can now be allocated
as part of larger structure and initialized using g_mutex_init().

This also fixes following build error:

  CC     audio/audio_libgstbluetooth_la-gsta2dpsink.lo
audio/gsta2dpsink.c: In function 'gst_a2dp_sink_finalize':
audio/gsta2dpsink.c:82:2: error: 'g_mutex_free' is deprecated
  (declared at /usr/include/glib-2.0/glib/deprecated/gthread.h:273)
  [-Werror=deprecated-declarations]
audio/gsta2dpsink.c: In function 'gst_a2dp_sink_init':
audio/gsta2dpsink.c:711:2: error: 'g_mutex_new' is deprecated
  (declared at /usr/include/glib-2.0/glib/deprecated/gthread.h:271)
  [-Werror=deprecated-declarations]
cc1: all warnings being treated as errors
---
 audio/gsta2dpsink.c |   12 ++++++------
 audio/gsta2dpsink.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/gsta2dpsink.c b/audio/gsta2dpsink.c
index c8f6346..9f8781e 100644
--- a/audio/gsta2dpsink.c
+++ b/audio/gsta2dpsink.c
@@ -79,7 +79,7 @@ static void gst_a2dp_sink_finalize(GObject *obj)
 {
 	GstA2dpSink *self = GST_A2DP_SINK(obj);
 
-	g_mutex_free(self->cb_mutex);
+	g_mutex_clear(&self->cb_mutex);
 
 	G_OBJECT_CLASS(parent_class)->finalize(obj);
 }
@@ -665,10 +665,10 @@ static gboolean gst_a2dp_sink_init_fakesink(GstA2dpSink *self)
 	if (self->fakesink != NULL)
 		return TRUE;
 
-	g_mutex_lock(self->cb_mutex);
+	g_mutex_lock(&self->cb_mutex);
 	self->fakesink = gst_a2dp_sink_init_element(self, "fakesink",
 			"fakesink", self->capsfilter);
-	g_mutex_unlock(self->cb_mutex);
+	g_mutex_unlock(&self->cb_mutex);
 
 	if (!self->fakesink)
 		return FALSE;
@@ -678,7 +678,7 @@ static gboolean gst_a2dp_sink_init_fakesink(GstA2dpSink *self)
 
 static gboolean gst_a2dp_sink_remove_fakesink(GstA2dpSink *self)
 {
-	g_mutex_lock(self->cb_mutex);
+	g_mutex_lock(&self->cb_mutex);
 
 	if (self->fakesink != NULL) {
 		gst_element_set_locked_state(self->fakesink, TRUE);
@@ -688,7 +688,7 @@ static gboolean gst_a2dp_sink_remove_fakesink(GstA2dpSink *self)
 		self->fakesink = NULL;
 	}
 
-	g_mutex_unlock(self->cb_mutex);
+	g_mutex_unlock(&self->cb_mutex);
 
 	return TRUE;
 }
@@ -708,7 +708,7 @@ static void gst_a2dp_sink_init(GstA2dpSink *self,
 	self->ghostpad = NULL;
 	self->sink_is_in_bin = FALSE;
 
-	self->cb_mutex = g_mutex_new();
+	g_mutex_init(&self->cb_mutex);
 
 	/* we initialize our capsfilter */
 	gst_a2dp_sink_init_caps_filter(self);
diff --git a/audio/gsta2dpsink.h b/audio/gsta2dpsink.h
index 1a591b2..5822dcd 100644
--- a/audio/gsta2dpsink.h
+++ b/audio/gsta2dpsink.h
@@ -66,7 +66,7 @@ struct _GstA2dpSink {
 	 * when it is created we forward this to it */
 	GstTagList *taglist;
 
-	GMutex *cb_mutex;
+	GMutex cb_mutex;
 };
 
 struct _GstA2dpSinkClass {
-- 
1.7.9.5

