Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AB7E576
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=pJZIqv6Qc5f1oFOq982ubINjaC1owGDvba4ah++pWkPMSkNQlLQn1RvE4iVjW1Ldpo6hez32bSd77dw5cDrIlxI39QOtsfb8xFUrk8FFgh7fyfosM7apDMEbGmYXKAjBx5z0pfexnTrVUsIW21bo4EZ0Uuc4WdduBFDqFQwcrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=6gXYqDg1iagSWrUXKqg53BuHbuqGR2ccSQ8itNAtFvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Scka5fsLxjziRMJpA0XV8Puxai1DZUQSdrdU0jecbBkJMrpl5pYv0avN+Rj4rLPstEkCQai/yNKiEhwwjgqm0rZ7yaYZ8bEvUoh67rAXA1hH2A3CPzOmQYD/DzO3GNJyY1gTkWjtXwwyT2Eo0kG45f+q5SEzK5mEl0o2taDe9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxrniDrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxrniDrY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F84AC43601;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=6gXYqDg1iagSWrUXKqg53BuHbuqGR2ccSQ8itNAtFvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cxrniDrYIg0PHTai3QgqN2gwgxGsUb+VQzl0rby1sfNZ0d0PMPeclFtU/Qm9bFb5S
	 P8ROjiZtRyOIpT9FpG5GJVVF/x8vR8wm2piJHCskH3g8McLaGWAG3H/FTMMeL48rPq
	 AXoFhEIfEWTifT8EkW1yJwOCJVazJyiLr5nNo0j1rCEdTZjG9z/lsx5WBNayHkvZJc
	 pVU68PKZY1KdxfGdqANgq2AyQnd7+X9O6b5Sez1xkBsCR0JkZiBhN1M2aZ8+Uhg3g1
	 GPQSbiTXQDY68vUHZNMU6fuBxs5YUl0f8TUqKIh9y/Ki17a9kMfyFV8YE2hLkjOLeA
	 JQMQPpQIws2ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D06C47DDC;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:08:01 +0000
Subject: [PATCH BlueZ v2 5/8] bluetoothd: factor out external plugin
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-rm-ext-plugins-v2-5-5244906f05ff@gmail.com>
References: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
In-Reply-To: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=6433;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=WpwMNuo+0wxS6pXtowstfiORfl+j7pw7iu2tGBo4NYw=;
 b=9zqnGIfcMpNmBU4MroQ6F4hd481xTp8ZvvcEfJxQfv0C4nzVVVsJ2QMnPV84lnSPiyu7aXhR8
 Nt2HnjkllrUB9N19k9Pe1E+vG2EdeYVteGVHOarmmmjX4s3+9gAVtjC
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

