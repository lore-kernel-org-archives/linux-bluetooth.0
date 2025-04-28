Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B65266B67
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846371; cv=none; b=IqZ4Ic35qMzXB4bzMCuZndtXjsCkcS3dtkf13GOYqDUi18xIZNXptOMwCydkM1FHxN0lUzkpQSZP0FJ4eLF5crPUYTr3ligbSJl7zQiriroxwDbwLDk8cY+206gyNo4B2feFG6zLg2jCrfLJ0uH7b27sVqvuu4HdqmPbCKMCTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846371; c=relaxed/simple;
	bh=o6FXSPXllMPbxDlIw7c/oBtLs4bvaGevNa8AwU7qOC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axMD87F9gC0H6/4clU+XXheEYvM/YngtkoOlHbhs3mRwAEs0nX72I2eUqEr1U0LP0yrLDlFng5xx8tQYLlUR1Jwajl0b/KxRTFAZAWCD8rjSZukfg/E1iEGaeTdGse2nbbymLIbiZqLexOHYVvyIxvR9S/mpATcoOr8D/2nSTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 4.0.e.4.2.0.f.6.8.d.6.d.1.1.3.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4311:d6d8:6f02:4e04] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9OOM-0079pP-1b;
	Mon, 28 Apr 2025 14:19:26 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v4 5/6] obexd: Support sd_login_monitor_get_timeout()
Date: Mon, 28 Apr 2025 14:15:34 +0100
Message-ID: <20250428131842.488921-6-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428131842.488921-1-kernel.org@pileofstuff.org>
References: <20250428131842.488921-1-kernel.org@pileofstuff.org>
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

Cc: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/logind.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/obexd/src/logind.c b/obexd/src/logind.c
index eb4924684..5bb9a5986 100644
--- a/obexd/src/logind.c
+++ b/obexd/src/logind.c
@@ -101,6 +101,37 @@ static gboolean event_handler(GIOChannel *source, GIOCondition condition,
 	return TRUE;
 }
 
+static gboolean timeout_handler(gpointer user_data)
+{
+	uint64_t timeout_usec;
+	int res;
+
+	if (!event_handler(NULL, 0, NULL))
+		return FALSE;
+
+	res = sd_login_monitor_get_timeout(monitor, &timeout_usec);
+	if (res < 0) {
+		error("sd_login_monitor_get_timeout(): %s", strerror(-res));
+		return FALSE;
+	}
+
+	if (timeout_usec != (uint64_t)-1) {
+		uint64_t time_usec;
+		struct timespec ts;
+
+		res = clock_gettime(CLOCK_MONOTONIC, &ts);
+		if (res < 0)
+			return -errno;
+		time_usec = (uint64_t) ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
+		if (time_usec > timeout_usec)
+			return timeout_handler(user_data);
+		g_timeout_add((timeout_usec - time_usec + 999) / 1000,
+				timeout_handler, user_data);
+	}
+
+	return FALSE;
+}
+
 static int logind_init(void)
 {
 	GIOChannel *channel;
@@ -146,7 +177,7 @@ static int logind_init(void)
 
 	g_io_channel_unref(channel);
 
-	event_handler(NULL, 0, NULL);
+	timeout_handler(NULL);
 
 	return 0;
 
-- 
2.49.0

