Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00922F74F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963856; cv=none; b=eSWhIJH+oyiUy7pgmGGYHHRgpV4tCXVzK99nmsdLe1YrRMjg9j0VcAzPBg20e9NeGOUtjUrzbx0E5HEal3SpPLoDavF6QS/JDLWS4SQsWX58+WI1kZPjIa9WQ/nRxaZhl/C/do7Dj4CT03n/RYtl+vO3sh+hyfukprnLNxhSmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963856; c=relaxed/simple;
	bh=+/7SwT+QDlepVHfMkAbFsnqCjp+z0kumPfRtWsPcZj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya7vVGVB22yd0UraVdkDEcGb4vWFNFTEHwBS4EMm36Uk/dJkT7suHhhiImXRkJNH+Prd3LwN2tqSSYt+o6N3SNmLIroR5FfSgcWxFjWFSFI4JvEqrlKeJTyn4r7/74EvldS8Rk67juFxpde3Mai4c7mnmWW7AAwjkrEAQVF4y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from c.2.f.1.6.8.1.3.8.c.d.1.f.3.3.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d33f:1dc8:3186:1f2c] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMTOO-001uWv-04;
	Tue, 03 Jun 2025 16:17:32 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 1/3] obexd: Pass at_(un)register value to logind callbacks
Date: Tue,  3 Jun 2025 16:13:29 +0100
Message-ID: <20250603151651.1080923-2-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Logind (un)registers callbacks that it calls when the user's state changes.
Callbacks may also be called during (un)registration.
Clients may need to handle those initial/final calls specially.

Pass an argument indicating whether this is being called during
(un)registration, and modify existing callbacks to ignore that argument.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/client/pbap.c       |  6 ++++--
 obexd/plugins/bluetooth.c |  6 ++++--
 obexd/src/logind.c        | 14 +++++++-------
 obexd/src/logind.h        |  8 ++++----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 51b523592..64bb8ff72 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1455,8 +1455,9 @@ static struct obc_driver pbap = {
 	.remove = pbap_remove
 };
 
-static int pbap_init_cb(void)
+static int pbap_init_cb(gboolean at_register)
 {
+	(void)at_register;
 	int err;
 
 	DBG("");
@@ -1482,8 +1483,9 @@ static int pbap_init_cb(void)
 	return 0;
 }
 
-static void pbap_exit_cb(void)
+static void pbap_exit_cb(gboolean at_unregister)
 {
+	(void)at_unregister;
 	DBG("");
 
 	g_dbus_remove_watch(system_conn, listener_id);
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 7ff27a8a8..ad37e636d 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -427,8 +427,9 @@ static const struct obex_transport_driver driver = {
 
 static unsigned int listener_id = 0;
 
-static int bluetooth_init_cb(void)
+static int bluetooth_init_cb(gboolean at_register)
 {
+	(void)at_register;
 	connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (connection == NULL)
 		return -EPERM;
@@ -439,8 +440,9 @@ static int bluetooth_init_cb(void)
 	return obex_transport_driver_register(&driver);
 }
 
-static void bluetooth_exit_cb(void)
+static void bluetooth_exit_cb(gboolean at_unregister)
 {
+	(void)at_unregister;
 	GSList *l;
 
 	g_dbus_remove_watch(connection, listener_id);
diff --git a/obexd/src/logind.c b/obexd/src/logind.c
index a0eb62b1e..b4279b209 100644
--- a/obexd/src/logind.c
+++ b/obexd/src/logind.c
@@ -43,13 +43,13 @@ static void call_init_cb(gpointer data, gpointer user_data)
 {
 	int res;
 
-	res = ((struct callback_pair *)data)->init_cb();
+	res = ((struct callback_pair *)data)->init_cb(FALSE);
 	if (res)
 		*(int *)user_data = res;
 }
 static void call_exit_cb(gpointer data, gpointer user_data)
 {
-	((struct callback_pair *)data)->exit_cb();
+	((struct callback_pair *)data)->exit_cb(FALSE);
 }
 
 static int update(void)
@@ -229,7 +229,7 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
 	struct callback_pair *cbs;
 
 	if (!monitoring_enabled)
-		return init_cb();
+		return init_cb(TRUE);
 	if (callbacks == NULL) {
 		int res;
 
@@ -237,23 +237,23 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
 		if (res) {
 			error("logind_init(): %s - login detection disabled",
 				strerror(-res));
-			return init_cb();
+			return init_cb(TRUE);
 		}
 	}
 	cbs = g_new(struct callback_pair, 1);
 	cbs->init_cb = init_cb;
 	cbs->exit_cb = exit_cb;
 	callbacks = g_slist_prepend(callbacks, cbs);
-	return active ? init_cb() : 0;
+	return active ? init_cb(TRUE) : 0;
 }
 void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
 {
 	GSList *cb_node;
 
 	if (!monitoring_enabled)
-		return exit_cb();
+		return exit_cb(TRUE);
 	if (active)
-		exit_cb();
+		exit_cb(TRUE);
 	cb_node = g_slist_find_custom(callbacks, init_cb, find_cb);
 	if (cb_node != NULL)
 		callbacks = g_slist_delete_link(callbacks, cb_node);
diff --git a/obexd/src/logind.h b/obexd/src/logind.h
index eb3ff8d7b..3cdb03338 100644
--- a/obexd/src/logind.h
+++ b/obexd/src/logind.h
@@ -8,8 +8,8 @@
  *
  */
 
-typedef int (*logind_init_cb)(void);
-typedef void (*logind_exit_cb)(void);
+typedef int (*logind_init_cb)(gboolean at_register);
+typedef void (*logind_exit_cb)(gboolean at_unregister);
 
 #ifdef SYSTEMD
 
@@ -22,12 +22,12 @@ int logind_set(gboolean enabled);
 static inline int logind_register(logind_init_cb init_cb,
 					logind_exit_cb exit_cb)
 {
-	return init_cb();
+	return init_cb(TRUE);
 }
 static inline void logind_unregister(logind_init_cb init_cb,
 					logind_exit_cb exit_cb)
 {
-	return exit_cb();
+	return exit_cb(TRUE);
 }
 static inline int logind_set(gboolean enabled)
 {
-- 
2.49.0

