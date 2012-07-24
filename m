Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] gstavdtpsink: Fix using deprecated glib api
Date: Tue, 24 Jul 2012 14:04:40 +0200
Message-ID: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_mutex_new() is deprecated in glib 2.33. GMutex can now be allocated
as part of larger structure and initialized using g_mutex_init().

This also fixes following build error:

  CC     audio/audio_libgstbluetooth_la-gstavdtpsink.lo
audio/gstavdtpsink.c: In function 'gst_avdtp_sink_finalize':
audio/gstavdtpsink.c:198:2: error: 'g_mutex_free' is deprecated
  (declared at /usr/include/glib-2.0/glib/deprecated/gthread.h:273)
  [-Werror=deprecated-declarations]
audio/gstavdtpsink.c: In function 'gst_avdtp_sink_init':
audio/gstavdtpsink.c:1044:2: error: 'g_mutex_new' is deprecated
  (declared at /usr/include/glib-2.0/glib/deprecated/gthread.h:271)
  [-Werror=deprecated-declarations]
cc1: all warnings being treated as errors
make[1]: *** [audio/audio_libgstbluetooth_la-gstavdtpsink.lo] Error 1
---
 audio/gstavdtpsink.c |    8 ++++----
 audio/gstavdtpsink.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index ffaed7f..92c920f 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -56,11 +56,11 @@ GST_DEBUG_CATEGORY_STATIC(avdtp_sink_debug);
 #define DEFAULT_AUTOCONNECT TRUE
 
 #define GST_AVDTP_SINK_MUTEX_LOCK(s) G_STMT_START {	\
-		g_mutex_lock(s->sink_lock);		\
+		g_mutex_lock(&s->sink_lock);		\
 	} G_STMT_END
 
 #define GST_AVDTP_SINK_MUTEX_UNLOCK(s) G_STMT_START {	\
-		g_mutex_unlock(s->sink_lock);		\
+		g_mutex_unlock(&s->sink_lock);		\
 	} G_STMT_END
 
 struct bluetooth_data {
@@ -195,7 +195,7 @@ static void gst_avdtp_sink_finalize(GObject *object)
 	if (self->transport)
 		g_free(self->transport);
 
-	g_mutex_free(self->sink_lock);
+	g_mutex_clear(&self->sink_lock);
 
 	G_OBJECT_CLASS(parent_class)->finalize(object);
 }
@@ -1041,7 +1041,7 @@ static void gst_avdtp_sink_init(GstAvdtpSink *self,
 
 	self->autoconnect = DEFAULT_AUTOCONNECT;
 
-	self->sink_lock = g_mutex_new();
+	g_mutex_init(&self->sink_lock);
 
 	/* FIXME this is for not synchronizing with clock, should be tested
 	 * with devices to see the behaviour
diff --git a/audio/gstavdtpsink.h b/audio/gstavdtpsink.h
index eb998ac..393797e 100644
--- a/audio/gstavdtpsink.h
+++ b/audio/gstavdtpsink.h
@@ -66,7 +66,7 @@ struct _GstAvdtpSink {
 
 	GstCaps *dev_caps;
 
-	GMutex *sink_lock;
+	GMutex sink_lock;
 
 	guint watch_id;
 };
-- 
1.7.9.5

