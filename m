Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DA259C83
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851675; cv=pass; b=sn+giFv7yLDBcjy5mliafC8pZEOT1+pC7FHEwAdPBuvrdLSk39NrZl7AdBgXfWco5woIGh9Secw8q3aR/Ehm4+F9bqvq2JVveg25hSmy6sMsVQzWCN4iOZN5379T0bU6MMwHVku6AeP9rVKNhTpLiviVeSBP6krpo3pTXpPOYqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851675; c=relaxed/simple;
	bh=q1WVDYLTCsPdgZG76sUBMlrpavWiKwlx2IhlEbgP5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIMgeyft/vQPp5bILC44JB91xJfT/8J57ECDblMYWWfRsHCLe86PGmBrRyyjPv7z3Wvx3+hYGsrabS7rk5A9X1yloX3zhZ36QW3JQYCt3Bm4xZDcZqlClXuxXPi0twrvartPKfAm5hyOnmGO015gHK3/8ewSdHQz23HnXHiSVss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g/eOTuOd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g/eOTuOd"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cPn3g42g2zyVW;
	Sun, 14 Sep 2025 15:07:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1757851663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kprIr3WEHZYMHqw09tPUkDK1T/JB58XnSCe6roAscvg=;
	b=g/eOTuOduCAw6h79D932HR79vXuF48+fthFlfzef2q6Dn37pdZ6SexxZEPy8UMQ+ouGwau
	Tebl83xWB8jAIs7En+tnd5S3kesjCw/7qSIPrVBZXb6IkG2B2mARaY2YS90qEPssA9RzyX
	0LjfB1tNSLgB3NqP0z5qYmVHI53HKGI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1757851663; a=rsa-sha256; cv=none;
	b=CAr28PoE9rEkzvW/bXyYPX4jy7xdpktz+aNwkuLCn14hP8skBM9/9S9v+3G3oT/7MmgDj5
	Oiqo7UL/Bv24ndQS9JFYpz+iibCmdN0g6j5fCaAh0E/Ajf4d/XOYmqV0ZHe9Czi5/pytxH
	nzo5FkS90XJLNHY5Gjw9u5rCGlmOOYQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1757851663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kprIr3WEHZYMHqw09tPUkDK1T/JB58XnSCe6roAscvg=;
	b=WdHY1oFAOI5I6nlKRK7KxIkNhKAC1n290hpcl/dfgb+qiO5YZ7ItohFMVyv7K2IMR7IwyA
	+AQooAhgtu0uXto9NtS4UjtatIokQ0MvDnPd6Mw0fZeocrdkMDRLY2rFvPIKPx/ZkB0ykY
	Vl5vGtW+7uE9aWvb95hxOWC+hob1UTY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/io: add helper for asynchronous shutdown() with SO_LINGER
Date: Sun, 14 Sep 2025 15:07:40 +0300
Message-ID: <467c9a64b1ed7e311728f07f4065de92c33622eb.1757851523.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_glib_shutdown_linger() for socket shutdown with wait for
remote ACK via SO_LINGER. E.g. wait for L2CAP Disconnect Rsp.

We don't want to block the main loop for the linger timeout, so call
shutdown() in a separate thread, as socket API seems to provide only the
blocking way to do it.

Implement it with Glib source API, as that's more convenient for the
AVDTP plugin that needs this.
---
 src/shared/io-ell.c      |  6 +++
 src/shared/io-glib.c     | 89 ++++++++++++++++++++++++++++++++++++++++
 src/shared/io-mainloop.c |  6 +++
 src/shared/io.h          |  3 ++
 4 files changed, 104 insertions(+)

diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index 4d64cf3c5..e7baed0d3 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -315,3 +315,9 @@ unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
 {
 	return 0;
 }
+
+unsigned int io_glib_shutdown_linger(void *giochannel, int how, int timeout,
+				io_destroy_func_t func, void *user_data)
+{
+	return 0;
+}
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 81cd1122b..efb7b9f5c 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -461,3 +461,92 @@ unsigned int io_glib_add_err_watch(void *giochannel,
 					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					err_watch_callback, data, g_free);
 }
+
+/*
+ * shutdown() socket, enabling SO_LINGER to wait for close ACK, with
+ * asynchronous callback.
+ */
+
+struct shutdown_linger {
+	GSource			source;
+	io_destroy_func_t	func;
+	void			*user_data;
+	int			how;
+	GIOChannel		*io;
+	GThread			*thread;
+};
+
+static gpointer shutdown_linger_thread(gpointer data)
+{
+	struct shutdown_linger *source = data;
+
+	shutdown(g_io_channel_unix_get_fd(source->io), source->how);
+	g_source_set_ready_time(&source->source, 0);
+	g_source_unref(&source->source);
+	return NULL;
+}
+
+static gboolean shutdown_linger_dispatch(GSource *gsource, GSourceFunc callback,
+							gpointer user_data)
+{
+	struct shutdown_linger *source = (void *)gsource;
+
+	if (source->func)
+		source->func(source->user_data);
+	return FALSE;
+}
+
+static void shutdown_linger_finalize(GSource *gsource)
+{
+	struct shutdown_linger *source = (void *)gsource;
+
+	if (source->thread == g_thread_self())
+		g_thread_unref(source->thread);
+	else
+		g_thread_join(source->thread);
+
+	g_io_channel_unref(source->io);
+}
+
+unsigned int io_glib_shutdown_linger(void *giochannel, int how, int timeout,
+				io_destroy_func_t func, void *user_data)
+{
+	static GSourceFuncs source_funcs = {
+		.dispatch = shutdown_linger_dispatch,
+		.finalize = shutdown_linger_finalize,
+	};
+	struct linger linger = {
+		.l_onoff = 1,
+		.l_linger = timeout,
+	};
+	GIOChannel *io = giochannel;
+	struct shutdown_linger *source;
+	guint id;
+	int fd;
+
+	if (!io)
+		return 0;
+
+	fd = g_io_channel_unix_get_fd(io);
+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &linger, sizeof(linger))) {
+		shutdown(fd, how);
+		return 0;
+	}
+
+	source = (void *)g_source_new(&source_funcs, sizeof(*source));
+
+	g_source_set_name(&source->source, "shutdown_linger");
+	source->func = func;
+	source->user_data = user_data;
+	source->how = how;
+	source->io = g_io_channel_ref(io);
+
+	g_source_ref(&source->source);  /* unref in thread */
+	source->thread = g_thread_new("shutdown_linger", shutdown_linger_thread,
+								source);
+
+	id = g_source_attach(&source->source, NULL);
+	g_source_unref(&source->source);
+
+	return id;
+}
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 8fd49935e..abe76de1d 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -321,3 +321,9 @@ unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
 {
 	return 0;
 }
+
+unsigned int io_glib_shutdown_linger(void *giochannel, int how, int timeout,
+				io_destroy_func_t func, void *user_data)
+{
+	return 0;
+}
diff --git a/src/shared/io.h b/src/shared/io.h
index 87c3c001c..7909b1707 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -37,3 +37,6 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
 typedef void (*io_glib_err_func_t)(int cond, void *user_data);
 unsigned int io_glib_add_err_watch(void *giochannel, io_glib_err_func_t func,
 							void *user_data);
+
+unsigned int io_glib_shutdown_linger(void *giochannel, int how, int timeout,
+				io_destroy_func_t func, void *user_data);
-- 
2.51.0

