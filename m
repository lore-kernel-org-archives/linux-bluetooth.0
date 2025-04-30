Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897225B1C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019032; cv=none; b=LYdtCTe3629EYHiVlAnLGQBx4psrCoivl9x8LeAlLoch4xv1ElC9SCBfTl2fZqoKMoP/zsWJlvz8gjXE/30/9CitpeqUFcbemtosOtwBQS7ynZQv/NuDGq23/me1WN14G//EYToQNuBUSvMqj0aCAt/jv1nDarV61Db6eGJ9Cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019032; c=relaxed/simple;
	bh=92a5cQ0/26OFdx/zVeBcozzq6smXZ9cCjqeEPPt8Njo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbq6qx1zu5JbEUlV2DKB3UFzdQzEtsG7hwkJkJHS2WTPEzlkaCvXy2AyNssSjm7rCiGtBOqCSVipIWhb5xo9HZ9hHveP7EmWNGVWNW2qhZHGw8xIarE+HPKf/ClHrF1RmyzvnO5dQZcbupuyu2JX+VXTIZUFMITR5N0SB0mZKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.e.2.8.8.9.5.f.7.2.3.4.3.2.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4234:327f:5988:2eda] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uA7JB-00B6cr-1s;
	Wed, 30 Apr 2025 14:17:06 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v6 2/3] obexd: Support sd_login_monitor_get_timeout()
Date: Wed, 30 Apr 2025 14:14:01 +0100
Message-ID: <20250430131648.1291354-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for sd_login_monitor_get_timeout() implies the API
may need to be checked after some time, even if no events have been
received via the fd.

In practice, the implementation has always returned a dummy value,
and changing it now would cause enough breakage in other projects
to make it unlikely to ever happen.

Add a handler for that case, even though it can't currently
happen in the real world.

The API assumes we call poll() directly, so in theory it could change
the timeout based on some event that doesn't trigger a callback
(e.g. sending a signal to the service).  It's hard to see how we'd
handle that without running a poll() in a separate thread,
which would be a lot of complexity for an untestable edge case.
Don't try to handle that problem.

Cc: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/logind.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/obexd/src/logind.c b/obexd/src/logind.c
index ff2bf3219..a0eb62b1e 100644
--- a/obexd/src/logind.c
+++ b/obexd/src/logind.c
@@ -30,6 +30,7 @@ static int uid;
 static gboolean active = FALSE;
 static gboolean monitoring_enabled = TRUE;
 static guint event_source;
+static guint timeout_source;
 
 struct callback_pair {
 	logind_init_cb init_cb;
@@ -82,8 +83,11 @@ static int update(void)
 	return res;
 }
 
+static gboolean timeout_handler(gpointer user_data);
+
 static int check_event(void)
 {
+	uint64_t timeout_usec;
 	int res;
 
 	res = sd_login_monitor_flush(monitor);
@@ -95,6 +99,25 @@ static int check_event(void)
 	if (res < 0)
 		return res;
 
+	res = sd_login_monitor_get_timeout(monitor, &timeout_usec);
+	if (res < 0)
+		return res;
+
+	if (timeout_usec != (uint64_t)-1) {
+		uint64_t time_usec;
+		struct timespec ts;
+		guint interval;
+
+		res = clock_gettime(CLOCK_MONOTONIC, &ts);
+		if (res < 0)
+			return -errno;
+		time_usec = (uint64_t) ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
+		if (time_usec > timeout_usec)
+			return check_event();
+		interval = (timeout_usec - time_usec + 999) / 1000;
+		timeout_source = g_timeout_add(interval, timeout_handler, NULL);
+	}
+
 	return 0;
 }
 
@@ -104,6 +127,11 @@ static gboolean event_handler(GIOChannel *source, GIOCondition condition,
 {
 	int res;
 
+	if (timeout_source) {
+		g_source_remove(timeout_source);
+		timeout_source = 0;
+	}
+
 	res = check_event();
 	if (res) {
 		error("%s: %s", __func__, strerror(-res));
@@ -113,6 +141,17 @@ static gboolean event_handler(GIOChannel *source, GIOCondition condition,
 	return TRUE;
 }
 
+static gboolean timeout_handler(gpointer user_data)
+{
+	int res;
+
+	res = check_event();
+	if (res)
+		error("%s: %s", __func__, strerror(-res));
+
+	return FALSE;
+}
+
 static int logind_init(void)
 {
 	GIOChannel *channel;
@@ -173,6 +212,10 @@ static void logind_exit(void)
 		g_source_remove(event_source);
 		event_source = 0;
 	}
+	if (timeout_source) {
+		g_source_remove(timeout_source);
+		timeout_source = 0;
+	}
 	sd_login_monitor_unref(monitor);
 }
 
-- 
2.49.0

