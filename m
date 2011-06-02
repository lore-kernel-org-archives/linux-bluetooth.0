Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 4/5] Add function for starting body streaming later
Date: Thu,  2 Jun 2011 15:23:22 +0200
Message-Id: <1307021003-15418-5-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PBAP and MAP profiles presents a requirement that in case of multi-packet
responses, application parameter header shall be send in the first
packet.

Starting body streaming in OpenOBEX adds body header immediately and
queues any other added header for sending after the streaming is
finished. Thus to get the possibility to comply to this requirement and
still be able to use streaming mode function to start streaming later in
time is added.
---
 src/obex.c |   27 +++++++++++++++++++++++++++
 src/obex.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 643b942..097f278 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1420,6 +1420,33 @@ int obex_aparam_write(struct obex_session *os,
 			OBEX_HDR_APPARAM, hd, size, 0);
 }
 
+void obex_start_streaming(struct obex_session *os, obex_object_t *obj)
+{
+	obex_headerdata_t hd;
+	int err;
+
+	os->driver->set_io_watch(os->object, NULL, NULL);
+
+	hd.bs = NULL;
+	OBEX_ObjectAddHeader(os->obex, obj, OBEX_HDR_BODY,
+			hd, 0, OBEX_FL_STREAM_START);
+
+	err = obex_write_stream(os, os->obex, obj);
+
+	if (err == -EAGAIN) {
+		/* Just to be double sure */
+		OBEX_SuspendRequest(os->obex, obj);
+		os->obj = obj;
+		os->driver->set_io_watch(os->object, handle_async_io,
+								os);
+	} else if (err < 0) {
+		os_set_response(obj, err);
+	} else {
+		/* Request has been suspended in cmd_get */
+		OBEX_ResumeRequest(os->obex);
+	}
+}
+
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/src/obex.h b/src/obex.h
index 94274c2..64b4cdc 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -64,6 +64,7 @@ int obex_aparam_write(struct obex_session *os, obex_object_t *obj,
 
 const char *obex_option_root_folder(void);
 gboolean obex_option_symlinks(void);
+void obex_start_streaming(struct obex_session *os, obex_object_t *obj);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.4.1

