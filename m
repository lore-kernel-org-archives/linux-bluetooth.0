Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3D24C081
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144978; cv=pass; b=AVWGMwevSFlpNSnDBeO4wfHVnjCMsaet6vi2QqC8AWqXmKFOYGdzAoWdSsbu5ATzQ3y9HFkXY/wMF6CNkc/HIv++a3Hz9YVB9JowcoZQaUjSXrHpfo7+/HpPsGoZIWTZADB6frOEchh+F/fgZ1DXkENwdWFNDTwbsbm/h9FsCfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144978; c=relaxed/simple;
	bh=Sct0SAeR/w295KtiXZ/VZVHGEUQ8WFB2OPk9MPKS3uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoH/+5yAPEFlyvmqA7MGm/vJDMPXXizG2kXIRXvcph8Pyp52kAPUiQmw88SDssM5nl7CksFPYxPE65hhxWcA6569R3Bvs9a5tOex8TkTaaHargcfHD/4Ku2SOuoW5Gxs1N/dDZjZCvMULl79PnYFpRi4Tuk/Ex89TuyhdGBcbtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XtwN60wc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XtwN60wc"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZXJ1L0l0fzySN;
	Tue,  8 Apr 2025 23:42:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1744144966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEy1wdTVki0Wy7XlS6KXfSl3ypZ3qqjQhXUL8k+Zirk=;
	b=XtwN60wcNkPHcsNGNrhCyRK3jEa0rfrcXpRGw0wdPjNTrv/orU6oXdBs01iy2QJE9EN/Kh
	+Ic/zgGhd1SUCyFOn3yMfIH3xZ68x6FHBx8G4o2n8c0RluT++neJgvpAGZL9B+6zx4C/P+
	3GEeEZQcC42y71C90Oc3BUoOnl+M0ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1744144966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEy1wdTVki0Wy7XlS6KXfSl3ypZ3qqjQhXUL8k+Zirk=;
	b=iMm2f1Kioj+qcBP5hvIHV0lTp652OaxH0LKJkJZayTRIWjzHkl0A669bsqbru5NX+TdgA/
	pJ2mjKWCaM/7CXnAvvgEQ3IUY0rHNOpXMHKTR7j7zS/tvBoREASyY7a+6IviA4kJZXhjVY
	zF/aVu2APAIEFpfB00XffZdbsI4UubU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1744144966; a=rsa-sha256; cv=none;
	b=nD0p8ZlGc5tuVhrNJjM+mMUx3wzVfjIxEP6nJrYeBnoY+MAkqtW46w69Iu7SyeDgVkUrvC
	2xxzOAZcKicZbPQkawDLeb8usNXT/gK/xmMXKLuvj9FjR9p47cAxkItgCbK4rMpGtMIgIL
	AK5Guq7lMnPES1a/xclY7hHbI1OGgo8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/io: add watcher to be used with TX timestamping
Date: Tue,  8 Apr 2025 23:42:38 +0300
Message-ID: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add special implementation of fd watcher GSource for audio use.

For audio use cases, sound server may turn on TX timestamping on a
socket that we are watching.  In this case, we shall not consider the TX
timestamping POLLERR as a socket error condition, nor read the TX
timestamps.

When TX timestamps appear in errqueue, switch from fd poll wait to
polling the fd at regular intervals.  This is because unread errqueue
causes poll() to wake up immediately, so the mainloop cannot block on
that, and we have to use a timer instead with some reasonable timeout
for the use case.

This rate limits wakeups on new TX timestamps we aren't going to read,
and also avoids the busy looping if timestamping was left on but
errqueue is not flushed.

Kernel does not provide any way for user applications to disable wakeup
on POLLERR currently.  Note that even with epoll() POLLET it still wakes
up on every timestamp.

Implement this only for io-glib; it is only needed for audio use cases
that anyway are using glib, so add a glib-specific API for it in
addition to the 'struct io *' one. Uses features from GLib 2.36 (from
2013) so update configure.ac also.
---

Notes:
    v2:
    - Remove io-glib.h. Pass void * for GIOChannel *, which is how
      it needs to be if it's in io.h as requested.
    - Adjust API a bit
    
    In theory avdtp/bap could be changed to use a 'struct io *' instead, but
    it's mostly additional complication with no gain since they are using
    GLib anyway, and in theory 'struct io *' users shall use the
    io_set_ignore_errqueue API instead.

 acinclude.m4             |   4 +-
 configure.ac             |   2 +-
 src/shared/io-ell.c      |  12 +++
 src/shared/io-glib.c     | 185 ++++++++++++++++++++++++++++++++++++++-
 src/shared/io-mainloop.c |  12 +++
 src/shared/io.h          |   5 ++
 6 files changed, 216 insertions(+), 4 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 168117840..8046c9a7d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -63,8 +63,8 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wformat -Wformat-security"
 		with_cflags="$with_cflags -Wstringop-overflow"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
-		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
-		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_36"
+		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_36"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
diff --git a/configure.ac b/configure.ac
index 2ea727256..1e089aaa7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
 				 ])
 
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28)
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.36)
 
 if (test "${enable_threads}" = "yes"); then
 	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index 35dc38e2e..4d64cf3c5 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -175,6 +175,12 @@ bool io_set_close_on_destroy(struct io *io, bool do_close)
 	return l_io_set_close_on_destroy(io->l_io, do_close);
 }
 
+bool io_set_ignore_errqueue(struct io *io, bool do_ignore)
+{
+	/* TODO: unimplemented */
+	return false;
+}
+
 bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
@@ -303,3 +309,9 @@ bool io_shutdown(struct io *io)
 
 	return shutdown(fd, SHUT_RDWR) == 0;
 }
+
+unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
+							void *user_data)
+{
+	return 0;
+}
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 754043db1..81cd1122b 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -13,11 +13,14 @@
 #endif
 
 #include <errno.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 
 #include "src/shared/io.h"
 
+#define	IO_ERR_WATCH_RATELIMIT		(500 * G_TIME_SPAN_MILLISECOND)
+
 struct io_watch {
 	struct io *io;
 	guint id;
@@ -29,11 +32,24 @@ struct io_watch {
 struct io {
 	int ref_count;
 	GIOChannel *channel;
+	bool err_watch;
 	struct io_watch *read_watch;
 	struct io_watch *write_watch;
 	struct io_watch *disconnect_watch;
 };
 
+struct io_err_watch {
+	GSource			source;
+	GIOChannel		*io;
+	GIOCondition		events;
+	gpointer		tag;
+};
+
+static guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
+					GIOCondition events,
+					GIOFunc func, gpointer user_data,
+					GDestroyNotify notify);
+
 static struct io *io_ref(struct io *io)
 {
 	if (!io)
@@ -179,10 +195,17 @@ static struct io_watch *watch_new(struct io *io, GIOCondition cond,
 
 	prio = cond == G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRIORITY_DEFAULT;
 
-	watch->id = g_io_add_watch_full(io->channel, prio,
+	if (!io->err_watch)
+		watch->id = g_io_add_watch_full(io->channel, prio,
 						cond | G_IO_ERR | G_IO_NVAL,
 						watch_callback, watch,
 						watch_destroy);
+	else
+		watch->id = io_glib_add_err_watch_full(io->channel, prio,
+						cond | G_IO_ERR | G_IO_NVAL,
+						watch_callback, watch,
+						watch_destroy);
+
 	if (watch->id == 0) {
 		watch_destroy(watch);
 		return NULL;
@@ -250,6 +273,15 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
 }
 
+bool io_set_ignore_errqueue(struct io *io, bool do_ignore)
+{
+	if (!io)
+		return false;
+
+	io->err_watch = do_ignore;
+	return true;
+}
+
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 {
 	int fd;
@@ -278,3 +310,154 @@ bool io_shutdown(struct io *io)
 	return g_io_channel_shutdown(io->channel, TRUE, NULL)
 							== G_IO_STATUS_NORMAL;
 }
+
+/*
+ * GSource implementation that tolerates non-empty MSG_ERRQUEUE, without
+ * attempting to flush it. This is intended for use with TX timestamping in
+ * cases where someone else is reading the timestamps and we are only interested
+ * in POLLHUP or socket errors.
+ */
+
+static gint64 io_err_watch_wakeup;
+
+static gboolean io_err_watch_dispatch(GSource *source,
+				GSourceFunc callback, gpointer user_data)
+{
+	struct io_err_watch *watch = (void *)source;
+	const GIOFunc func = (void *)callback;
+	const gint64 timeout = IO_ERR_WATCH_RATELIMIT;
+	GIOCondition cond;
+	int fd;
+
+	if (!func)
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(watch->io);
+
+	/*
+	 * If woken up by POLLERR only, and SO_ERROR is not set, ignore this
+	 * event. Also disable polling for some time so that we don't consume
+	 * too much CPU on events we are not interested in, or busy loop if
+	 * nobody is flushing the errqueue.
+	 */
+
+	if (watch->tag)
+		cond = g_source_query_unix_fd(&watch->source, watch->tag);
+	else
+		cond = 0;
+
+	if (cond == G_IO_ERR) {
+		int err, ret;
+		socklen_t len = sizeof(err);
+
+		ret = getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &len);
+		if (ret == 0 && err == 0) {
+			g_source_remove_unix_fd(&watch->source, watch->tag);
+			watch->tag = NULL;
+
+			/* io_err watches all wake up at the same time */
+			if (!io_err_watch_wakeup)
+				io_err_watch_wakeup = g_get_monotonic_time()
+								+ timeout;
+
+			g_source_set_ready_time(&watch->source,
+							io_err_watch_wakeup);
+			return TRUE;
+		}
+	}
+
+	if (g_source_get_ready_time(&watch->source) != -1) {
+		g_assert(!watch->tag);
+		io_err_watch_wakeup = 0;
+		watch->tag = g_source_add_unix_fd(&watch->source, fd,
+							watch->events);
+		g_source_set_ready_time(&watch->source, -1);
+	}
+
+	cond &= watch->events;
+
+	if (cond)
+		return func(watch->io, cond, user_data);
+	else
+		return TRUE;
+}
+
+static void io_err_watch_finalize(GSource *source)
+{
+	struct io_err_watch *watch = (void *)source;
+
+	if (watch->tag)
+		g_source_remove_unix_fd(&watch->source, watch->tag);
+
+	g_io_channel_unref(watch->io);
+}
+
+static guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
+					GIOCondition events,
+					GIOFunc func, gpointer user_data,
+					GDestroyNotify notify)
+{
+	static GSourceFuncs source_funcs = {
+		.dispatch = io_err_watch_dispatch,
+		.finalize = io_err_watch_finalize,
+	};
+	GSourceFunc callback = (void *)func;
+	struct io_err_watch *watch;
+	gint fd;
+	guint id;
+
+	g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
+	g_return_val_if_fail(events, 0);
+	g_return_val_if_fail(func, 0);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	watch = (void *)g_source_new(&source_funcs,
+					sizeof(struct io_err_watch));
+
+	watch->io = g_io_channel_ref(io);
+	watch->events = events;
+	watch->tag = g_source_add_unix_fd(&watch->source, fd, events);
+
+	g_source_set_name((void *)watch, "io_glib_err_watch");
+	g_source_set_callback(&watch->source, callback, user_data, notify);
+
+	if (priority != G_PRIORITY_DEFAULT)
+		g_source_set_priority(&watch->source, priority);
+
+	id = g_source_attach(&watch->source, NULL);
+	g_source_unref(&watch->source);
+
+	return id;
+}
+
+struct err_watch_cb_data {
+	io_glib_err_func_t func;
+	void *data;
+};
+
+static gboolean err_watch_callback(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct err_watch_cb_data *data = user_data;
+
+	data->func(cond, data->data);
+	return FALSE;
+}
+
+unsigned int io_glib_add_err_watch(void *giochannel,
+						io_glib_err_func_t func,
+						void *user_data)
+{
+	struct err_watch_cb_data *data;
+
+	data = g_try_new0(struct err_watch_cb_data, 1);
+	if (!data)
+		return 0;
+
+	data->func = func;
+	data->data = user_data;
+	return io_glib_add_err_watch_full(giochannel, G_PRIORITY_DEFAULT,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					err_watch_callback, data, g_free);
+}
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index ad461843c..8fd49935e 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -192,6 +192,12 @@ bool io_set_close_on_destroy(struct io *io, bool do_close)
 	return true;
 }
 
+bool io_set_ignore_errqueue(struct io *io, bool do_ignore)
+{
+	/* TODO: unimplemented */
+	return false;
+}
+
 bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy)
 {
@@ -309,3 +315,9 @@ bool io_shutdown(struct io *io)
 
 	return shutdown(io->fd, SHUT_RDWR) == 0;
 }
+
+unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
+							void *user_data)
+{
+	return 0;
+}
diff --git a/src/shared/io.h b/src/shared/io.h
index bad899ff7..87c3c001c 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -20,6 +20,7 @@ void io_destroy(struct io *io);
 
 int io_get_fd(struct io *io);
 bool io_set_close_on_destroy(struct io *io, bool do_close);
+bool io_set_ignore_errqueue(struct io *io, bool do_ignore);
 
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt);
 bool io_shutdown(struct io *io);
@@ -32,3 +33,7 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy);
 bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 				void *user_data, io_destroy_func_t destroy);
+
+typedef void (*io_glib_err_func_t)(int cond, void *user_data);
+unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
+							void *user_data);
-- 
2.49.0

