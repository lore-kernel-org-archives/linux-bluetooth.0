Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395795;
	b=lFPkIXipt2pJ91u26ceV3TOEDt64uwkkS82RJo6MR6ctMx7BbzhJ5tN/fBHerKSXsdWq
	 1blorBmDpJ7s94cDNU9p77XdC4uvvzB6PR3/2NPAh7SEWwytK//xBwdLDeEGa6/O94uru
	 0wi4I7BfNq4wcgekQy+JNPuMcc8pdrDy8JD8H4IEysnj0b4TBHFjsAgtYIv/n45dkDQWE
	 i66xZSJ52igl5dCY6nIBM0AIX9acKEftHr6Rb8PRC6KIvG18BjszCA6hFUq3RPFjjQmD8
	 Duq8weXzS/1unQNSBkVFt6qJIOqWfNZrgaInfc3vxnaiDfFRmK3W71TmfVa7wNYoCQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wo0EWkzugmC60UjkBz0RdKP0OScAfLWeN+J+4s5BfzE=;
	b=LVRPTnSTZQf+mLSjaNaKStq9whiCaBdoFLSQqV4hqUv6au5qHC6uaYX8s2RzoiKnho5Y
	 riVf44TO64uQGzZqINBVGAPZx3ndlcvf89mnGTeoFfHS/+K7qzMFciX/Riv904otQmHnb
	 9VT6m9Py2jLAD8tTM/4H1MqSdjhIiXWvX3K2nNJyHDWwSPvgVyIXXpouf2dLuiI7gPbVG
	 zTuEibN6nHDsfHJZx8PUwTItcjUh5EYLsoFDr5sZT0P0PyARfNA9RDTbJMBcyRUGL8fJE
	 LpGfHsgek+sowwukGj8QfUyThFeJAJHw6hyyqwO/r0ueqGY44kOr08A2kbzJOHZ4ARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j8CRlR4J;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E0606A322
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C59E0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j8CRlR4J
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso481275e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395794; x=1794000594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wo0EWkzugmC60UjkBz0RdKP0OScAfLWeN+J+4s5BfzE=;
        b=j8CRlR4JRa/wbqB1LdwKqfzpk9EXeqnCurRf2NWTp3jcHkASYO/1GHBurRjfa9AyFs
         xvaeZjkCg9u/j4xV80UEEWqhQMGVnolkD79kKF3WBstFUd0tS9THNRXyK5ic4Aa8Dp8R
         ZV7aAWHOMgKXVSDqsTV/owtffZjgMcOzQazQaSNp6lww880NhzNFUIX7ZAX6xGxhWjTb
         m3bv3ihsmJgqn7enHnqwEayXy5J75tdKk+aQofxSuIIdI8m57ipLctJU8syRcacuXhn/
         EWTi/nbV/XJyntgraw/ry8miY7BjTBGOqwd7yScf+BP+fiJNBUByalC6gaXadV/Ody0H
         nvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395794; x=1794000594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wo0EWkzugmC60UjkBz0RdKP0OScAfLWeN+J+4s5BfzE=;
        b=lynzIvu0gN2+9Jgdu3Bn1unUOFMZxdNCgATEsPLMtu2jdgj3gpZ24kPKyaDFzRFDO9
         x8wMcHUZv3lAfcgfW3deXd20SB46RRb1zOhu82WO85acfPKm/zBn6xVZcmUV34zHKzFd
         6AxdbFhV6uiacCUGTbTvTC7oY2PmNQpSHob8k1YoJb7NU0QBvRupq63nK4Wdr69GcYXn
         9mShFGQ8rE4U4zOMad8yHyzXQivL8Mz//4DXCijIpar3yqr3jHA1uc0/HHpgdf8c5IU6
         RPJtRi6cA4KP/wrjWcYnmqWdofakQvJSDLE8w4JLc/B/dnZkHbzFsHfuJeLTgPBE2hhD
         AXEA==
X-Gm-Message-State: AFq9FYJL1n4LGyxQjZzA/SnDYW/pchFq9kHtfzEgM/X8XJD904WJkMut
	91LxFSR3zOoukJF9uDAMzv4PX8mQ5mEFk86TE6fweJCraFAm5FO+EfsvbcQUFg==
X-Gm-Gg: AYBFou29HVVhw/GlzYkbijbA6eB7oXoi4LIC6ckOOWujRNUqPXN65uDQIbouK3JYa/f
	CyYKXCLK2Kib9GkzUwe31doCG9aYZLk34eNnfnlwVBxMQ12khnfYARm2/kGYh4zY87Ui6wZAIPj
	IdrgUqtBjgCd+SDNJZzTTY12d849MgA4waWWzB3jMX4CXR8CNs6n8oJ7YR3uvofqWsgfxMh4ScI
	CxBrvXGs02GUDxdInnKmvhpnMxM7WAsyXqMS8F+B/GPvuhpbC2dQ46/q69EyxFrv27Kee6Uy4Ny
	zSvlzO/6jaSj4neSQE1TtxjXGuwXWdOckMv4glWAcFSEZn4JklRhIPA4gxmFEYvvBeWJCbGomMw
	U5fbPXpLbAdp4rj8dFiH6Dj9c6aecqWDEhU0oIYg08C+Zydch1QMmvbcuus++8gDMCq49N70p+t
	tF8HszRlduzcAjcGMpfTOejmjNnmFlSRc7F++qE6D1cDnhbU1hYfBry7O+IX2UVYzFLo4E8sIFD
	iK2O44gu5NE/5YSaSRf0UhJUf4PobOpgddlh1Ky37OpBQZXudrXgTjbOHbsvzT+K0Ot6deCMEFs
	leyT0sCDTUfPewL8/5sVJ4irgsX3e+hBb+NFY6dKAmIo+w3PRzvXAgm8ilmLfxGU8GCV+JbSb3N
	TF4A94Tln1CEJR9F+qkWL72g+U7mgJlnFuktHdLkSw3zKlLQXCJAVb+eZGeQjBXWJEa513z8lvy
	CyVs8=
X-Received: by 2002:a05:6122:512:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5ec68718ff2mr1871528e0c.5.1793395793860;
        Fri, 30 Oct 2026 14:29:53 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/10] a2dp: Fix refusing the AVDTP connection of a new link
Date: Fri, 30 Oct 2026 17:29:37 -0400
Message-ID: <20261030212940.753771-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

When the remote reconnects before the disconnection of the previous
link is processed, the A2DP channel of that link is still registered
and an incoming AVDTP connection on the new link is taken as a
transport channel of its session, and refused.

Process the disconnection of the signalling channel of the existing
session first if it is pending, so the connection is handled as a new
signalling channel.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c  |  7 +++++++
 profiles/audio/avdtp.c | 24 ++++++++++++++++++++++++
 profiles/audio/avdtp.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index cb1b3a9804e7..3b29ec204d00 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2796,6 +2796,13 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 		goto drop;
 
 	chan = queue_find(server->channels, match_by_device, device);
+
+	/* The channel of a previous link, if its disconnection was not
+	 * processed yet: this is not a transport channel of it.
+	 */
+	if (chan && chan->session && avdtp_check_disconnected(chan->session))
+		chan = queue_find(server->channels, match_by_device, device);
+
 	if (chan) {
 		struct a2dp_setup *setup;
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 56d27b973a17..30f80a0c2fd1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -18,6 +18,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
+#include <poll.h>
 #include <unistd.h>
 #include <assert.h>
 
@@ -1168,6 +1169,29 @@ static void connection_lost(struct avdtp *session, int err)
 	avdtp_unref(session);
 }
 
+/* Process a disconnection of the signalling channel not dispatched yet,
+ * returning whether it is disconnected.
+ */
+bool avdtp_check_disconnected(struct avdtp *session)
+{
+	struct pollfd pfd;
+
+	if (!session->io)
+		return false;
+
+	pfd.fd = g_io_channel_unix_get_fd(session->io);
+	pfd.events = 0;
+	pfd.revents = 0;
+
+	if (poll(&pfd, 1, 0) <= 0 ||
+			!(pfd.revents & (POLLHUP | POLLERR | POLLNVAL)))
+		return false;
+
+	connection_lost(session, ECONNRESET);
+
+	return true;
+}
+
 static bool disconnect_timeout(gpointer user_data)
 {
 	struct avdtp *session = user_data;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 10c8f496b44e..ab5059b055ec 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -205,6 +205,7 @@ typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 
 void avdtp_unref(struct avdtp *session);
+bool avdtp_check_disconnected(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
-- 
2.56.0

