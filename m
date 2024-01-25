Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68B625
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=iUIEJLbwi66pIzpO2wJchUpX/G9cO5aYVsKNmJYhT4GbHznYuPEI/BWpXdJb+fSEUXQVpUaErAZ5a8bNheBHAn2vvQT6l71Y4H4S17Ra4F8oRmO+lELd3iclC8wUSjXwDdHqsqA387kMXROU1pN5800BiPaQNHl+j6nKVUabXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=6gXYqDg1iagSWrUXKqg53BuHbuqGR2ccSQ8itNAtFvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo6lPZ5TCTJEg+3Q78Nm9APxyckriJ54DJoIFlV0iR0iD7jKe0h1a2gW+05Zk54HfO9DPKF0yIoA1zEIUHxEwc97wgwFKu0N8h7W/AlWj1aqP2jTGlVMGF9rP9b9rwsHikqp+kXjH32eFmVzHNwG9AKupVEEho0ydIAoBxY5tQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmM//y31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmM//y31"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6D0C433A6;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=6gXYqDg1iagSWrUXKqg53BuHbuqGR2ccSQ8itNAtFvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KmM//y31E/oYj9vjZM4O1fctMb755yLeOHhbkJTUDCchwv2O9KRNnuITppK5V/EYo
	 CEzBdnWTmiqHma60kLEMlM+H/+yLecEjzR1S87HbZwRemAbxUtnaGkRtWVNjLieMsG
	 O6h7wGxOhcO7eBgogOc5cUed5Bt2KvNoUfKmJt2YN4j6K6G7ot57Vy3O5QGcCTkjxW
	 WBeQ0KLf4vPbjrebXeCjyC7J70UE9K27/VD6jvYexjNo79H7DrgUZzFb7+yhDyivIh
	 /A7WlSmkPaqeq5DGGEFSQAHVx6BYuJwp9aOQ5UUO5PxzL1J/iOvd+Tp7eMpuVUKsk+
	 lLNSQ9owmkdug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D655C46CD2;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:30 +0000
Subject: [PATCH BlueZ v3 5/8] bluetoothd: factor out external plugin
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-5-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=6433;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=WpwMNuo+0wxS6pXtowstfiORfl+j7pw7iu2tGBo4NYw=;
 b=YhA6OzZVIrsv8/HKdWR6zlickTTm/N6qZmOL6VuKOOytzHq9BwEM36JSztnHhY4HGEmWij5yF
 tUxij5AsLi5DSGSTtDEauCBGOIQ4TiQJ4kS3BaZZ1tcYRQ/a6gK3WMz
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

As a whole all plugins should be built-in, otherwise they would be using
internal, undocumented, unversioned, unstable API.

Flesh out the external plugin support into a few pre-processor blocks
and simplify the normal path.
---
 Makefile.am  |  4 ---
 src/btd.h    |  2 +-
 src/plugin.c | 97 ++++++++++++++++++++++++++++++++++++++----------------------
 src/plugin.h | 16 ++++++++++
 4 files changed, 79 insertions(+), 40 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ea51b25cc..1b82e8551 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -51,11 +51,7 @@ EXTRA_DIST += src/bluetooth.service.in src/org.bluez.service
 
 plugindir = $(libdir)/bluetooth/plugins
 
-if MAINTAINER_MODE
-build_plugindir = $(abs_top_srcdir)/plugins/.libs
-else
 build_plugindir = $(plugindir)
-endif
 
 if MANPAGES
 man_MANS =
diff --git a/src/btd.h b/src/btd.h
index b7e7ebd61..7166e2168 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -155,7 +155,7 @@ struct btd_opts {
 
 extern struct btd_opts btd_opts;
 
-gboolean plugin_init(const char *enable, const char *disable);
+void plugin_init(const char *enable, const char *disable);
 void plugin_cleanup(void);
 
 void rfkill_init(void);
diff --git a/src/plugin.c b/src/plugin.c
index 2a29a888e..ae9406375 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -29,7 +29,9 @@
 static GSList *plugins = NULL;
 
 struct bluetooth_plugin {
+#if EXTERNAL_PLUGINS
 	void *handle;
+#endif
 	gboolean active;
 	const struct bluetooth_plugin_desc *desc;
 };
@@ -42,7 +44,8 @@ static int compare_priority(gconstpointer a, gconstpointer b)
 	return plugin2->desc->priority - plugin1->desc->priority;
 }
 
-static gboolean add_plugin(void *handle,
+#if EXTERNAL_PLUGINS
+static gboolean add_external_plugin(void *handle,
 				const struct bluetooth_plugin_desc *desc)
 {
 	struct bluetooth_plugin *plugin;
@@ -71,6 +74,22 @@ static gboolean add_plugin(void *handle,
 
 	return TRUE;
 }
+#endif
+
+static void add_plugin(const struct bluetooth_plugin_desc *desc)
+{
+	struct bluetooth_plugin *plugin;
+
+	DBG("Loading %s plugin", desc->name);
+
+	plugin = g_try_new0(struct bluetooth_plugin, 1);
+	if (plugin == NULL)
+		return;
+
+	plugin->desc = desc;
+
+	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+}
 
 static gboolean enable_plugin(const char *name, char **cli_enable,
 							char **cli_disable)
@@ -98,48 +117,24 @@ static gboolean enable_plugin(const char *name, char **cli_enable,
 	return TRUE;
 }
 
-#include "src/builtin.h"
 
-gboolean plugin_init(const char *enable, const char *disable)
+static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 {
-	GSList *list;
+#if EXTERNAL_PLUGINS
 	GDir *dir;
 	const char *file;
-	char **cli_disabled, **cli_enabled;
-	unsigned int i;
-
-	/* Make a call to BtIO API so its symbols got resolved before the
-	 * plugins are loaded. */
-	bt_io_error_quark();
 
-	if (enable)
-		cli_enabled = g_strsplit_set(enable, ", ", -1);
-	else
-		cli_enabled = NULL;
-
-	if (disable)
-		cli_disabled = g_strsplit_set(disable, ", ", -1);
-	else
-		cli_disabled = NULL;
-
-	DBG("Loading builtin plugins");
-
-	for (i = 0; __bluetooth_builtin[i]; i++) {
-		if (!enable_plugin(__bluetooth_builtin[i]->name, cli_enabled,
-								cli_disabled))
-			continue;
-
-		add_plugin(NULL,  __bluetooth_builtin[i]);
-	}
+	warn("Using external plugins is not officially supported.\n");
+	warn("Consider upstreaming your plugins into the BlueZ project.");
 
 	if (strlen(PLUGINDIR) == 0)
-		goto start;
+		return;
 
 	DBG("Loading plugins %s", PLUGINDIR);
 
 	dir = g_dir_open(PLUGINDIR, 0, NULL);
 	if (!dir)
-		goto start;
+		return;
 
 	while ((file = g_dir_read_name(dir)) != NULL) {
 		const struct bluetooth_plugin_desc *desc;
@@ -174,13 +169,45 @@ gboolean plugin_init(const char *enable, const char *disable)
 			continue;
 		}
 
-		if (add_plugin(handle, desc) == FALSE)
+		if (add_external_plugin(handle, desc) == FALSE)
 			dlclose(handle);
 	}
 
 	g_dir_close(dir);
+#endif
+}
+
+#include "src/builtin.h"
+
+void plugin_init(const char *enable, const char *disable)
+{
+	GSList *list;
+	char **cli_disabled = NULL;
+	char **cli_enabled = NULL;
+	unsigned int i;
+
+	/* Make a call to BtIO API so its symbols got resolved before the
+	 * plugins are loaded. */
+	bt_io_error_quark();
+
+	if (enable)
+		cli_enabled = g_strsplit_set(enable, ", ", -1);
+
+	if (disable)
+		cli_disabled = g_strsplit_set(disable, ", ", -1);
+
+	DBG("Loading builtin plugins");
+
+	for (i = 0; __bluetooth_builtin[i]; i++) {
+		if (!enable_plugin(__bluetooth_builtin[i]->name, cli_enabled,
+								cli_disabled))
+			continue;
+
+		add_plugin(__bluetooth_builtin[i]);
+	}
+
+	external_plugin_init(cli_enabled, cli_disabled);
 
-start:
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 		int err;
@@ -201,8 +228,6 @@ start:
 
 	g_strfreev(cli_enabled);
 	g_strfreev(cli_disabled);
-
-	return TRUE;
 }
 
 void plugin_cleanup(void)
@@ -217,8 +242,10 @@ void plugin_cleanup(void)
 		if (plugin->active == TRUE && plugin->desc->exit)
 			plugin->desc->exit();
 
+#if EXTERNAL_PLUGINS
 		if (plugin->handle != NULL)
 			dlclose(plugin->handle);
+#endif
 
 		g_free(plugin);
 	}
diff --git a/src/plugin.h b/src/plugin.h
index 8d0903f2d..a1984d536 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -13,14 +13,19 @@
 
 struct bluetooth_plugin_desc {
 	const char *name;
+#if EXTERNAL_PLUGINS
 	const char *version;
+#endif
 	int priority;
 	int (*init) (void);
 	void (*exit) (void);
+#if EXTERNAL_PLUGINS
 	void *debug_start;
 	void *debug_stop;
+#endif
 };
 
+#if EXTERNAL_PLUGINS
 #ifdef BLUETOOTH_PLUGIN_BUILTIN
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
 		const struct bluetooth_plugin_desc \
@@ -41,3 +46,14 @@ struct bluetooth_plugin_desc {
 			__start___debug, __stop___debug \
 		};
 #endif
+#else
+#ifdef BLUETOOTH_PLUGIN_BUILTIN
+#define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
+		const struct bluetooth_plugin_desc \
+		__bluetooth_builtin_ ## name = { \
+			#name, priority, init, exit \
+		};
+#else
+#error "Requested non built-in plugin, while external plugins is disabled"
+#endif
+#endif

-- 
2.43.0

