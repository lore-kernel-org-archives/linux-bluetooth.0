Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCA2D3A74
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936162; cv=none; b=kjyOpVu83bgs6VXF1qkgKxlaGNzb8DBeErHPDyV2Uo3n70JDaozNd+oSmFoo1BSuyN+5RntTvqb8QDscYcwecZO8EQYoXM9xmEVKxsCoNz9V1qR5Y/VH8yggBIM+hN5ocSx8jPL8+5yisnePRka8zxsFJtLv449fortwbz7i/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936162; c=relaxed/simple;
	bh=92a5cQ0/26OFdx/zVeBcozzq6smXZ9cCjqeEPPt8Njo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqTVq4LtJnLCfjjqI8e5o841RUqYc2bria7SOj+6KF0qoZ1REyHRtDIUArqUbI3osV0lcqqdfXP6frUcLE4ec2AtRLMY7deun7/yjrDirinS7d1sNvR/H9pMT7uIsZLI8fISmqx0YzaRm86Xx7RVgM84uCqjoCzFCaX+RmBOR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from e.d.9.2.d.8.4.d.d.a.6.6.5.f.8.1.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:18f5:66ad:d48d:29de] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9lkc-008Jal-2S;
	Tue, 29 Apr 2025 15:15:58 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v5 5/6] obexd: Support sd_login_monitor_get_timeout()
Date: Tue, 29 Apr 2025 15:14:15 +0100
Message-ID: <20250429141533.803295-6-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429141533.803295-1-kernel.org@pileofstuff.org>
References: <20250429141533.803295-1-kernel.org@pileofstuff.org>
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

