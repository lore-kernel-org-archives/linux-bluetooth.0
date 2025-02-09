Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306133987
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097974; cv=pass; b=Qe/21MePooBm9+JtCui+zL+FbbSY8Hy2xA8OPxKS/itYg5dQ1L+IGzVkAnP6h9m6G3qAkov6YyubohjTse7d9lI1vfQmy4dnwiHxcekLqqCzZq4ucEb2ZJ3maP0CYESrcCV3cdidTCHOuOnlo57hmcYjtgl5BTz8xPIKdW3Ksz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097974; c=relaxed/simple;
	bh=zfnrHnzEH31QmdtvEvfQ+LgtmxMxIJRhG1R51i45Tts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDb/A9ZLv6UIbJtnNsCNIImtlgTzb92IjD6yXqwHcZT4HTRrXYqWMOgELQK3wrSMyvBuMSpw9jJrQ2AxcA8qnlck5hHOQ7+Q2xcuaFrLwI2QYuKAd6pD24xuRZtMN5CJiO9g79MktKsneQt30kHGYsUw0f2oING8EGtFiF9W8vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=EFJT9xNY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="EFJT9xNY"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPWj4c5hz49Q6m;
	Sun,  9 Feb 2025 12:46:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgInILH+4cVunQ/Q//WnoTJ0PsKf5QKOareIUfpMNjs=;
	b=EFJT9xNYd0AIn9HsZnd46qGTaEC3aOgj913DeTHDL8+TkCXiOrOxG0uij5jbZHWHtY6ZjT
	Sygwi/tiFlxjdC3upbkXeozd/cDxelLaErqiu8SAfRHSlNeyeonkOc/YsOunQKDvlDutsj
	ooobWYK0z4amwK5Y1hCoHiPwng+ny7R7y/K15ThRcqZgtiG2ik/314O3EGvI/5AjmeWcfs
	3lKuzKepVkyrI4chEPUx1/vjw5QPN9xt6MAWJguF+SFWTVB0UJG8QdkTQ1dAigJDXZ8ZIJ
	vnW52QTOc0UZzFoSuEEd5wA9HCofmF573n5BA15fQEWWRoRAaDiR9/8a6K2zUQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097970; a=rsa-sha256;
	cv=none;
	b=DB6OgZ9RybKlG50nMg+1lWsijkcJbPSRpzXCKI7OcHIRjchFRPgA2eB2t1Q8xwWWAKSiJR
	yizXp1byOyoTjXHZx4rfN0gktgIfUtkVtVDu3QTgYpIWPteQT5VqeQxJt367kY6tDzH5Uq
	jixjWq2epVFzskWmn1XKN/+ULXGYcb12KIvN4cMRX2zaYFAPKPTsbSYBxyi+vk+lu3lGPR
	SS5K2uG3X+lyUSlHBxMFWQP9ZOcsRUsqtbd5AHYNQjOblUFfLQtDq7iUAh+GSiEbBTtgms
	wuGGoY8KLm3WDFOXJXZBJP/yZ/BKjM53V7KohdD1oaJA+VOXvdMGO14Fm1L4SA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgInILH+4cVunQ/Q//WnoTJ0PsKf5QKOareIUfpMNjs=;
	b=XQBiaWisESrwFpp2Q0USyHYFta34+AXb9Mi9jVst6ZhKabQFqUSnsXIxpkdRnd/cFzEuGK
	5piEiYC37UCU1zV5j9R0jQxGQW6KUWJo+FVEwlYi9CFh6IN6rIzaIGEj/0Ulltagib5C8i
	62BDwqeQ92hh95lja1Jl2/Z65IG15yJjFapPn4lMdCtXdtWLvP6lG3nUUmtkTBHtDlg+PO
	/H/ki+m2g9l8hARcSUK/7wpP0RWZtMJCTw/GYMdGEnjf4XUsu7arr9pJneoMPIKrk26WQ+
	7F1peVH+JggilrR4L9Qyk4dzKy89FIuVCqCesZVSeArRIYlOgR267jLE/Csdvw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with TX timestamping
Date: Sun,  9 Feb 2025 12:46:02 +0200
Message-ID: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739097949.git.pav@iki.fi>
References: <cover.1739097949.git.pav@iki.fi>
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

Implement this only for io-glib; it is only needed for audio use cases
that anyway are using glib.  Uses features from GLib 2.36 (from 2013) so
update configure.ac also.
---
 Makefile.am          |   1 +
 acinclude.m4         |   3 +-
 configure.ac         |   2 +-
 src/shared/io-glib.c | 157 ++++++++++++++++++++++++++++++++++++++++++-
 src/shared/io-glib.h |  20 ++++++
 5 files changed, 179 insertions(+), 4 deletions(-)
 create mode 100644 src/shared/io-glib.h

diff --git a/Makefile.am b/Makefile.am
index 0821530e6..f958e2b99 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -253,6 +253,7 @@ shared_sources += src/shared/shell.c src/shared/shell.h
 endif
 
 src_libshared_glib_la_SOURCES = $(shared_sources) \
+				src/shared/io-glib.h \
 				src/shared/io-glib.c \
 				src/shared/timeout-glib.c \
 				src/shared/mainloop-glib.c \
diff --git a/acinclude.m4 b/acinclude.m4
index 168117840..598986d6e 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -63,8 +63,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 		with_cflags="$with_cflags -Wformat -Wformat-security"
 		with_cflags="$with_cflags -Wstringop-overflow"
 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
-		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
-		with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
+		with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_36"
 	fi
 	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
diff --git a/configure.ac b/configure.ac
index 75841e4c9..d2b0bab2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
 				 ])
 
 
-PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28)
+PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.36)
 
 if (test "${enable_threads}" = "yes"); then
 	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 754043db1..bea9b2c32 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -13,10 +13,14 @@
 #endif
 
 #include <errno.h>
+#include <sys/socket.h>
 
 #include <glib.h>
 
 #include "src/shared/io.h"
+#include "src/shared/io-glib.h"
+
+#define	IO_ERR_WATCH_RATELIMIT		(500 * G_TIME_SPAN_MILLISECOND)
 
 struct io_watch {
 	struct io *io;
@@ -29,11 +33,19 @@ struct io_watch {
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
 static struct io *io_ref(struct io *io)
 {
 	if (!io)
@@ -179,10 +191,17 @@ static struct io_watch *watch_new(struct io *io, GIOCondition cond,
 
 	prio = cond == G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRIORITY_DEFAULT;
 
-	watch->id = g_io_add_watch_full(io->channel, prio,
+	if (!io->err_watch)
+		watch->id = g_io_add_watch_full(io->channel, prio,
+						cond | G_IO_ERR | G_IO_NVAL,
+						watch_callback, watch,
+						watch_destroy);
+	else
+		watch->id = io_glib_add_err_watch_full(io->channel, prio,
 						cond | G_IO_ERR | G_IO_NVAL,
 						watch_callback, watch,
 						watch_destroy);
+
 	if (watch->id == 0) {
 		watch_destroy(watch);
 		return NULL;
@@ -250,6 +269,15 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 	return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
 }
 
+bool io_set_use_err_watch(struct io *io, bool err_watch)
+{
+	if (!io)
+		return false;
+
+	io->err_watch = err_watch;
+	return true;
+}
+
 ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 {
 	int fd;
@@ -278,3 +306,130 @@ bool io_shutdown(struct io *io)
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
+guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
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
+guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, GIOFunc func,
+							gpointer user_data)
+{
+	return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, events,
+							func, user_data, NULL);
+}
diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
new file mode 100644
index 000000000..1db6fd468
--- /dev/null
+++ b/src/shared/io-glib.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#include <glib.h>
+
+guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
+				GIOFunc func, gpointer user_data);
+guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
+				GIOCondition events, GIOFunc func,
+				gpointer user_data,
+				GDestroyNotify notify);
+
+bool io_set_use_err_watch(struct io *io, bool err_watch);
-- 
2.48.1

