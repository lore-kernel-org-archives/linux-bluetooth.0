Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546A395AC2
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580889; cv=none; b=Sz/nLmUtlDb1OZ0LePG/kq7iTzldvre9YwyYfHNkbz85+cqXF/xqIR70j+jkdouYo1YXvwyIJP+H0H8H3B839acZN8ujsR7I/lSM/X9zLecW4ljkYzFv7fX6gEG6DGCMakRyDMASmfsulpefOLONGgSVN6XhfFUT2i0zPENhJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580889; c=relaxed/simple;
	bh=ekHsjaFPJ0ZmT80SAIASGRUANyyPPv3OV2nlaOHlOds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mUo0yW9Rrx6enpyvwEWWeYbZiCc+VzE4A8l4uXTu+TjqqGwOlKo4HArTiDNnkObjDamRnVlndnMBY0bogKQPvAy4wmf5mx+MX6s7crXK/ThawVWuqVYmy4h023//KRAOgE4Txdgycn8zfZjEIRI+226GYQ2TsGjBTqXRB8hlmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F99A3E9A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 10:14:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] media: Fix possible crash on exit/adapter removal
Date: Tue, 12 May 2026 12:14:16 +0200
Message-ID: <20260512101431.2017966-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF04CuJkK7xnoGEClrFhN6IMHcsIWHX4/Q2YtNKZRL7MSgwnwwnhyhiFUJjYIi9uC+NG2yn63bdwiMJ3wqr7wadbmDhm/J0XYXFl248NpIDUwLquVdpOu6H7CkrPPJ4rZAG2KK5+y/Irv+tIEjYahnEarYD/zrzBul/T9gszj8CEIA1WoLAVNH+jtV2isyqLwRRfGjeCWYkPZFYUWhb+B+I7KOd7H59bEY6/kBGjNDebIqONRSgCGdA8J1UZmNVPE0cUR/z0QKxA0mt9vM0E97qR44Ti15nPKvRLqLyPIl0PhvDheqPZUT/L2y+VBSmvTf9STIkfnyAM8lor/dL9gSoIg6LYFSSlJhm+BSNXsLqEhXBoOaFRHEW5eo4VB799Aq/G/2tkYoGfH3tmMyp8of0V9ust51XRqxL/sLrUDF4pIMnMtR15aISA9soOMlYAd9Y+XRD2wrWM4H5yIkmQsn8UksMm7vZ+hJUyj/g2kUwsURROzDA26zGLxkdZX6r0b/0L/nMk9G/0U6uRf61fqHRuzUwLSHp7cE9aXXUUcdk2eqktpd72yM+kjCq8h0mUVQgmQ2qCTXy6oQ7qkd31P7ESMtRA9vURQ2ZUVeuLhqv8j1JDQHBMtFwqf40cxNBrRiWtPA/Sw8ZXTqF41VgRkxwu7rXewQT4Kb6K3il/jB6cQ

Nothing protects media_endpoint_remove() from being called multiple
times for the same structure. Before a g_free() call is made on
endpoint->capabilities, there are NULL checks, and NULL setting,
for every variable that might get modified, so a second call to the same
function, even though it's still using-after-free, is only
reading-after-free, and might crash at the first attempt at modifying
that freed memory.

The reason why this function might be called multiple times is because
in some circumstances, another signal might be received that the
endpoint is getting removed while we're already in the process of
removing that endpoint.

For example, release_endpoint() (which should appear in between
path_free() and media_endpoint_remove() in the below backtrace, as
that's the function called at profiles/audio/media.c:3651), will send a
D-Bus message which it then waits for the answer to, meaning that other
D-Bus message could be received while we're waiting for the answer, and
then destroying the endpoint.

 #11 media_endpoint_destroy at profiles/audio/media.c:231
 #12 media_endpoint_remove at profiles/audio/media.c:314
 #13 path_free at profiles/audio/media.c:3651
 #14 remove_interface at gdbus/object.c:742
 #15 g_dbus_unregister_interface at gdbus/object.c:1499
 #16 g_slist_foreach at ../glib/gslist.c:837
 #17 unload_drivers at src/adapter.c:5932
 #18 adapter_remove at src/adapter.c:7088
 #19 adapter_unregister at src/adapter.c:9504
 #20 index_removed at src/adapter.c:10693
 #21 queue_foreach at src/shared/queue.c:207
 #23 process_notify at src/shared/mgmt.c:349
 #24 can_read_data at src/shared/mgmt.c:409
 #25 watch_callback at src/shared/io-glib.c:173
 #27 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
 #28 g_main_context_iterate_unlocked at ../glib/gmain.c:4516
 #30 mainloop_run at src/shared/mainloop-glib.c:65
 #31 mainloop_run_with_signal at src/shared/mainloop-notify.c:196

in profiles/audio/media.c:
 231         g_free(endpoint->capabilities);

See https://bugzilla.redhat.com/show_bug.cgi?id=2467980
---
 profiles/audio/media.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index cdaafb04e38c..ad31872c6431 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -611,6 +611,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 static void release_endpoint(struct media_endpoint *endpoint)
 {
 	DBusMessage *msg;
+	struct media_adapter *adapter = endpoint->adapter;
 
 	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
@@ -631,7 +632,9 @@ static void release_endpoint(struct media_endpoint *endpoint)
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
 
 done:
-	media_endpoint_remove(endpoint);
+	/* Make sure endpoint didn't already get removed */
+	if (g_slist_find(adapter->endpoints, endpoint))
+		media_endpoint_remove(endpoint);
 }
 
 static const char *get_name(struct a2dp_sep *sep, void *user_data)
-- 
2.54.0

