Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684052;
	b=EaLa7tyje2o7j5TFzuB8240Imo3DCdOsMxfih+oWNHClvE/KPDu4fMvoCj7j060uaB9V
	 TGCgCBMeq3F6XBrdr1m1j0ryVEm9xvQ4UBcmDln59LYPox5UQm/1sgvginnd2svxnkAhW
	 1qXe5gCMhFuf7/w9ZK315trb2c/XlYagwXC1sgh0KdBX4t/RUDd75H5Qssx4ljlMflWNJ
	 4kaGpRoXpRunZxA5YvVNINW3L66npMXHa1RBHrisPsV6B61dxb3oMxi8MP6pf9a693JNR
	 /UcjmBercXOO+VULK8iXNrq2/gVlM8v/m9vaCuCdLjvhzNgI4rLyuM9CQ3s57xI/p+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B4FX7Q7AsH2W5IaoVcPnZ0ySuxoqvp6Gaw6AAzKOgnc=;
	b=sDygUoSgkMSno23NCPpYm+405JRnPbh66x9qt4WxQ375n7XqogSxS8I+giNDPaVNWrqF
	 V+bS2nTCCA092kRQv8AjKer2bsGiOBy401am868feUqGEdVIPyX00waEWHLj/Y7NSMkEc
	 I1BlFLyPiFIHJLssj2hfZuyu2dwlXA+q8k/c98tWyTfRgQgBNKCNzaJstrXFvsSKvScPr
	 yWdP6j7R6qvbkEG4cWlqPPOxKWBeSYA7EhJ78buIDFAjDxzXk+/Suo33bn7XDfPyJb4lW
	 t6HdqAOwSFTIb59PWrciC90pVq9JYkRUJ7/0K7SEiaGkPM/rb6wLByPBIv+Dt5FZ6rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrNczl64;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B7606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49B7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrNczl64
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso19473e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684051; x=1793288851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B4FX7Q7AsH2W5IaoVcPnZ0ySuxoqvp6Gaw6AAzKOgnc=;
        b=UrNczl64jXwFBdlPKaqrmJHwlLcNHAn2PvBnsHKqj8z6LqQ6L2OphstNb32nc62a6N
         vPLLlhNDEA1qqmSqLH45iwfuEFyKWs5VFSmMH+v9CtD+NLOdEQjjKK8UGjgJhKG4d6Od
         Nppefs+Iv2DVAl2V28WqXSrHbjSAF0f0Wv6R2sPJNPdhR51DGNgaKyvvgKkhwKOkr7BW
         rykae81oxyOsqotuQY7ubYNvNzoSKxeiKmV9QDa0IFsa/EckqmY8cYuLQDSkmW9Stp5f
         ouCQy/hDuHI8j2i3ewNJq4TAiHhL1QtehI9ixYongFHG8JeXPXEERC13SrGh2qWkc9ZA
         e4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684051; x=1793288851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B4FX7Q7AsH2W5IaoVcPnZ0ySuxoqvp6Gaw6AAzKOgnc=;
        b=vGRGW6x0Pl8wAlXAkmwUXc79G7cyVWMgDlNM/sNSkzuUsUfpJGNrk/4ot4aAkZt5w0
         2P7MT+swfDfodG8XfT11Zi9wD6xix9mTTON/fxYka7kekR2deIadsuyGJPGDYdN3QCh8
         5Agll2LJjvjogq3BP4Huswr+w9NfJSHUbwHr+jqRPheRVmYYzdaB1pGYNunsI9nrDT48
         1hFhU3Jz069UkO0kDf2QtHBRuyqtZfUf47DANXaInEsiN6U0Ei20Oub9co+d/awTYFvy
         IExbpFUo74VaySOInwNZN7y7efnPo22AjOozxm0HdIZp1agrLcOBLEyxptUQ8zfrGmsW
         np+w==
X-Gm-Message-State: AFq9FYKjM4NNHb+xvs9PnXXKH2nrxECdr2WcxjP5jC0IrXOEUeo4wEEN
	ynA/kQHGlLXusC7603qfggmmU4/mqkSajDBjVORK47HbJ8NjmyGDIpgyznuJ+iYhPnQ=
X-Gm-Gg: AYBFou3SGAXoWu9yPc7C7Xo7prUQYBKH/RlfVXWsAdN4qrvLdd+c/l5nCOkkvcc3teQ
	BiLG6x9rbOZVBcl07f/Ai9CdDCQoi++UpFpPS6p7ICSCGWa+sqP2wRV+qzwPxoRmTfcchewxhRl
	bcv/lZfbcj8YlzE+murPu1XxrsFHS+b7b6a4NN20VxxBYrDX5hZBFpmdaTCk543/fd/U9lwkBgU
	bg/bA+8+Y4khJnd/siA4qJi+puRkGzGH52kkOmyfjwR4C6wWsBC8KUEAqoi2hr+1quooswNrPIl
	MKhamxIvY48aZ3lkvU0w/K9hVdV9YQDZQtOUZHs9VFgpJGqANW4+Pt/ONgDYlthEX9+pNKBJwJi
	5mOJLBDfKzyBm8ro1UOAJQ+DvmJ8k4kaM4KAN28+Dp5TYp8XiaE+XFZiCivr94xwWPaByi8Q75V
	ZyVdUNlvZ8fvhUMedqJzFPtH0gjHAZc7VByAik+iufBmRWHXH1fTHCwoP4Qk2KiEyMsuu3ZNVEJ
	26MRji91jjKikdoXjs8Fp1CajA98J5Mgzg4WEwrWWVwb1aeoNM+phWvZTGMvAQ4iVWRwUA1BZbI
	hwCeK9aaMPpZUIjkMWDSjomK/189QL0J4nWmTfqj+IjHRWY=
X-Received: by 2002:a05:6122:6b01:b0:5ea:fae8:e69e with SMTP id 71dfb90a1353d-5eafae8ea02mr1084942e0c.11.1792684050503;
        Thu, 22 Oct 2026 08:47:30 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 23/27] tools: Add socket watches for testers without GLib
Date: Thu, 22 Oct 2026 11:46:56 -0400
Message-ID: <20261022154701.3959500-24-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add tester_io, watches on file descriptors on top of the mainloop for
the testers using GIOChannel watches, keeping their semantics: several
watches per descriptor holding a reference to it, the descriptor closed
with the last reference if requested, tester_io_close() reported as
TESTER_IO_NVAL, and the watches called after the other ready descriptors
in the order they were added, which the testers rely on to see the
events of the emulated controllers first.

Unlike GLib, a hang up nobody watches for drops the watches instead of
waking up the mainloop for good, and an error nobody watches for, e.g. a
connection attempt timing out, is polled again after a millisecond,
which also lets time advance under User Mode Linux time travel.

Assisted-by: Claude:claude-opus-5-5
---
 tools/tester-io.c | 400 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/tester-io.h |  52 ++++++
 2 files changed, 452 insertions(+)
 create mode 100644 tools/tester-io.c
 create mode 100644 tools/tester-io.h

diff --git a/tools/tester-io.c b/tools/tester-io.c
new file mode 100644
index 000000000000..e9675225682b
--- /dev/null
+++ b/tools/tester-io.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/mainloop.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
+
+/* Watch ids have the high bit set, so tester_remove_source() can tell them
+ * from timeout ids.
+ */
+#define WATCH_ID_BIT	0x80000000u
+
+struct tester_io {
+	int ref_count;
+	int fd;
+	bool close_on_unref;
+	bool registered;
+	bool dispatching;
+	bool scheduled;
+	unsigned int backoff_id;
+	uint32_t pending;
+	struct queue *watches;
+};
+
+struct watch {
+	unsigned int id;
+	struct tester_io *io;
+	uint32_t cond;
+	tester_io_func_t func;
+	void *user_data;
+	bool removed;
+};
+
+/* The tester_io with watches, in the order of their first watch */
+static struct queue *ios;
+static int dispatch_id;
+static unsigned int next_id;
+static unsigned int current_id;
+
+struct tester_io *tester_io_new(int fd)
+{
+	struct tester_io *io;
+
+	io = new0(struct tester_io, 1);
+	io->ref_count = 1;
+	io->fd = fd;
+	io->watches = queue_new();
+
+	return io;
+}
+
+struct tester_io *tester_io_ref(struct tester_io *io)
+{
+	if (io)
+		io->ref_count++;
+
+	return io;
+}
+
+void tester_io_unref(struct tester_io *io)
+{
+	if (!io || --io->ref_count > 0)
+		return;
+
+	queue_destroy(io->watches, free);
+
+	if (io->close_on_unref && io->fd >= 0)
+		close(io->fd);
+
+	free(io);
+}
+
+int tester_io_get_fd(struct tester_io *io)
+{
+	return io ? io->fd : -1;
+}
+
+void tester_io_set_close_on_unref(struct tester_io *io, bool close_on_unref)
+{
+	if (io)
+		io->close_on_unref = close_on_unref;
+}
+
+static void collect_cond(void *data, void *user_data)
+{
+	struct watch *watch = data;
+	uint32_t *events = user_data;
+
+	if (!watch->removed)
+		*events |= watch->cond;
+}
+
+static void io_event(int fd, uint32_t events, void *user_data);
+
+static bool match_registered_fd(const void *data, const void *match_data)
+{
+	const struct tester_io *io = data;
+
+	return io->registered && io->fd == PTR_TO_INT(match_data);
+}
+
+static void unregister(struct tester_io *io)
+{
+	if (!io->registered)
+		return;
+
+	io->registered = false;
+	mainloop_remove_fd(io->fd);
+}
+
+/* Poll for what the watches want, except while their callbacks are
+ * pending, and stop polling without any.
+ */
+static void update_events(struct tester_io *io)
+{
+	uint32_t events = 0;
+
+	queue_foreach(io->watches, collect_cond, &events);
+	events &= ~TESTER_IO_NVAL;
+
+	if (queue_isempty(io->watches) || io->scheduled || io->backoff_id ||
+								io->fd < 0) {
+		unregister(io);
+		return;
+	}
+
+	if (!io->registered) {
+		if (mainloop_add_fd(io->fd, events, io_event, io, NULL) < 0) {
+			struct tester_io *stale;
+
+			/* The descriptor of another io was closed directly,
+			 * and the same number was given to this one.
+			 */
+			stale = queue_find(ios, match_registered_fd,
+							INT_TO_PTR(io->fd));
+			if (!stale || stale == io)
+				return;
+
+			unregister(stale);
+
+			if (mainloop_add_fd(io->fd, events, io_event, io,
+								NULL) < 0)
+				return;
+		}
+
+		io->registered = true;
+		return;
+	}
+
+	mainloop_modify_fd(io->fd, events);
+}
+
+static bool match_removed(const void *data, const void *match_data)
+{
+	const struct watch *watch = data;
+
+	return watch->removed;
+}
+
+/* Drops the removed watches and their references to io. The caller holds
+ * a reference of its own, so io is freed by the caller's unref at most.
+ */
+static void cleanup(struct tester_io *io)
+{
+	struct watch *watch;
+
+	while ((watch = queue_remove_if(io->watches, match_removed, NULL))) {
+		free(watch);
+		io->ref_count--;
+	}
+
+	if (queue_isempty(io->watches)) {
+		io->scheduled = false;
+		io->pending = 0;
+		timeout_remove(io->backoff_id);
+		io->backoff_id = 0;
+		queue_remove(ios, io);
+	}
+
+	update_events(io);
+}
+
+static bool backoff_done(void *user_data)
+{
+	struct tester_io *io = user_data;
+
+	io->backoff_id = 0;
+	update_events(io);
+
+	return false;
+}
+
+static void remove_watch(void *data, void *user_data)
+{
+	struct watch *watch = data;
+
+	watch->removed = true;
+}
+
+static void dispatch(struct tester_io *io)
+{
+	const struct queue_entry *entry;
+	unsigned int last = next_id;
+	uint32_t events = io->pending;
+	uint32_t wanted = 0;
+
+	io->scheduled = false;
+	io->pending = 0;
+
+	tester_io_ref(io);
+	io->dispatching = true;
+
+	queue_foreach(io->watches, collect_cond, &wanted);
+
+	/* Watches added by a callback wait for the next event */
+	for (entry = queue_get_entries(io->watches); entry;
+							entry = entry->next) {
+		struct watch *watch = entry->data;
+
+		if (watch->removed || (watch->id & ~WATCH_ID_BIT) > last ||
+						!(events & watch->cond))
+			continue;
+
+		current_id = watch->id;
+
+		if (!watch->func(io, events & watch->cond, watch->user_data))
+			watch->removed = true;
+
+		current_id = 0;
+	}
+
+	/* A hang up nobody watches for would be reported over and over,
+	 * waking up the mainloop for good: drop the watches instead, as with
+	 * a closed descriptor. An error may be transient, e.g. a connection
+	 * attempt timing out, so keep watching after one, as GLib does.
+	 */
+	if (events & (TESTER_IO_HUP | TESTER_IO_NVAL) & ~wanted)
+		queue_foreach(io->watches, remove_watch, NULL);
+	else if (events & TESTER_IO_ERR & ~wanted && !io->backoff_id)
+		/* Polling would report the error right away again, so look
+		 * again a bit later, which lets simulated time advance too.
+		 */
+		io->backoff_id = timeout_add(1, backoff_done, io, NULL);
+
+	if (io->fd < 0)
+		queue_foreach(io->watches, remove_watch, NULL);
+
+	io->dispatching = false;
+	cleanup(io);
+	tester_io_unref(io);
+}
+
+static bool match_scheduled(const void *data, const void *match_data)
+{
+	const struct tester_io *io = data;
+
+	return io->scheduled;
+}
+
+static void dispatch_all(int id, void *user_data)
+{
+	struct tester_io *io;
+
+	mainloop_remove_timeout(id);
+	dispatch_id = 0;
+
+	while ((io = queue_find(ios, match_scheduled, NULL)))
+		dispatch(io);
+}
+
+/* Like GLib, which dispatches the ready sources in the order they were
+ * added, call the watches after the other descriptors ready at the same
+ * time, e.g. those of the emulated controllers, were handled, in the order
+ * of the first watch of each descriptor, and before idle callbacks: stop
+ * polling and dispatch once the ready descriptors were handled.
+ */
+static void schedule_dispatch(struct tester_io *io, uint32_t events)
+{
+	io->pending |= events;
+
+	if (io->scheduled)
+		return;
+
+	io->scheduled = true;
+	unregister(io);
+
+	if (!dispatch_id)
+		dispatch_id = mainloop_add_deferred(dispatch_all, NULL, NULL);
+}
+
+static void io_event(int fd, uint32_t events, void *user_data)
+{
+	struct tester_io *io = user_data;
+
+	schedule_dispatch(io, events);
+}
+
+unsigned int tester_io_add_watch(struct tester_io *io, uint32_t cond,
+				tester_io_func_t func, void *user_data)
+{
+	struct watch *watch;
+
+	if (!io || !func)
+		return 0;
+
+	if (!ios)
+		ios = queue_new();
+
+	watch = new0(struct watch, 1);
+	watch->id = ++next_id | WATCH_ID_BIT;
+	watch->io = tester_io_ref(io);
+	watch->cond = cond;
+	watch->func = func;
+	watch->user_data = user_data;
+
+	if (queue_isempty(io->watches))
+		queue_push_tail(ios, io);
+
+	queue_push_tail(io->watches, watch);
+	update_events(io);
+
+	return watch->id;
+}
+
+void tester_io_close(struct tester_io *io)
+{
+	if (!io || io->fd < 0)
+		return;
+
+	unregister(io);
+	close(io->fd);
+	io->fd = -1;
+
+	if (!queue_isempty(io->watches))
+		schedule_dispatch(io, TESTER_IO_NVAL);
+}
+
+static bool match_watch_id(const void *data, const void *match_data)
+{
+	const struct watch *watch = data;
+
+	return watch->id == PTR_TO_UINT(match_data) && !watch->removed;
+}
+
+static bool match_io_watch(const void *data, const void *match_data)
+{
+	const struct tester_io *io = data;
+
+	return queue_find(io->watches, match_watch_id, match_data);
+}
+
+unsigned int tester_current_source(void)
+{
+	return current_id;
+}
+
+void tester_remove_source(unsigned int id)
+{
+	struct tester_io *io;
+	struct watch *watch;
+
+	if (!id)
+		return;
+
+	if (!(id & WATCH_ID_BIT)) {
+		timeout_remove(id);
+		return;
+	}
+
+	io = queue_find(ios, match_io_watch, UINT_TO_PTR(id));
+	if (!io)
+		return;
+
+	watch = queue_find(io->watches, match_watch_id, UINT_TO_PTR(id));
+	watch->removed = true;
+
+	/* Cleaned up once the callbacks are done */
+	if (io->dispatching)
+		return;
+
+	tester_io_ref(io);
+	cleanup(io);
+	tester_io_unref(io);
+}
diff --git a/tools/tester-io.h b/tools/tester-io.h
new file mode 100644
index 000000000000..848251702cf0
--- /dev/null
+++ b/tools/tester-io.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <poll.h>
+#include <sys/epoll.h>
+
+/* Watches on file descriptors for the testers, in the way of GLib's
+ * GIOChannel watches, on top of the mainloop: several watches per file
+ * descriptor, each holding a reference to it, and the file descriptor
+ * closed with the last reference if requested. Like GLib, watches are
+ * called after the other ready descriptors were handled.
+ */
+
+#define TESTER_IO_IN	EPOLLIN
+#define TESTER_IO_OUT	EPOLLOUT
+#define TESTER_IO_ERR	EPOLLERR
+#define TESTER_IO_HUP	EPOLLHUP
+/* Reported once the descriptor was closed with tester_io_close() */
+#define TESTER_IO_NVAL	POLLNVAL
+
+struct tester_io;
+
+typedef bool (*tester_io_func_t)(struct tester_io *io, uint32_t cond,
+							void *user_data);
+
+struct tester_io *tester_io_new(int fd);
+struct tester_io *tester_io_ref(struct tester_io *io);
+void tester_io_unref(struct tester_io *io);
+int tester_io_get_fd(struct tester_io *io);
+void tester_io_set_close_on_unref(struct tester_io *io, bool close_on_unref);
+
+/* Closes the descriptor, which the watches see as TESTER_IO_NVAL */
+void tester_io_close(struct tester_io *io);
+
+/* The watch is called while one of cond is set, until it returns false */
+unsigned int tester_io_add_watch(struct tester_io *io, uint32_t cond,
+				tester_io_func_t func, void *user_data);
+
+/* Removes a watch, or a timeout added with timeout_add() */
+void tester_remove_source(unsigned int id);
+
+/* The id of the watch being called, 0 outside of a watch */
+unsigned int tester_current_source(void);
-- 
2.56.0

