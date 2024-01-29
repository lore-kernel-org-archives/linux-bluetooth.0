Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F81152DF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=mySB+G2IW8U0PaTwownHRxC2N71YTRWh1sga9P1YQ+qAUaTbBfli06Za41OcEobccVAC1s9hGL/KJRfsHw2gsgnstZAT42bZXjdDDk2dupzX7p656qJDK10wqzuFp7ZSN9Al8vKkhsKmlQ9Zf4zy3PDg4M59O2iR/KC7R4pgjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=IcBNTPe5Nry9T4IsmqBEi0l0KqWwonBMGdJED+difIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5G1ppwLc5fTiya4ZF7wifX8KPJsZAuXeG8bG2Y2M2oYqxHYdp/0qgXEWuu/eLO1czaYTbZ19fA9R4vLEy7hQB+2dDCz16cznS/yYTWlsj0Z1JEKDTL2uv13VrYc8vzB+1C+Zka1xrz8VhHNsH3Gk6kbURtjtdPDJb72gC0HwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udemDfIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udemDfIC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E3DC433A6;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539457;
	bh=IcBNTPe5Nry9T4IsmqBEi0l0KqWwonBMGdJED+difIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=udemDfICcVX07gW++d1O8rU0qtLRjZC91nK73IwfSEhKM2R54Pw3k5rc8kpQvUDJT
	 hZ1OQhs+p+/Vr/8iKWlclUQzzZ4fBLithAU4UCzUE47ZLTWMnfjTO+IiVxhoOlqYKD
	 OmSUeNxXu5fB33FhXsWEohk1cCRThTb1DhKENLulhQ/XogJHHRtpvXli1a3Ebq/mDS
	 j02o5HPzg5e+swrAYaiT8yUCujOXPNWt70gA/aT1NZ/py/U1JfvalpBzMgHwV618dU
	 Js/NwzoSCGy+PiGg7WC1zI+lBd7FL/2C0xpzL2fbElIrLYpkFjvjpqzNEGKfFTP+FW
	 lZSNfFGUZ2xqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A6CC47DDF;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:19 +0000
Subject: [PATCH BlueZ v4 5/8] bluetoothd: factor out external plugin
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-5-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=5822;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=TV/c7UPogYHUQWh6xBi+E6A5A9BeHU9R8RK05/SU01E=;
 b=kbOZBCoJhH8McwIsGHw75mC7Xpx4NnITS/MYyjA3668CBoiitd/82ELFvKgkLnqmo7kPRCwmO
 J1Or9fR7NYODuuZnEa5z3/6DojYTGN9xkHv7kQx635mBUtndZkevO1r
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

As a whole all plugins should be built-in, otherwise they would be using
internal, undocumented, unversioned, unstable API.

Flesh out the external plugin support and simplify the normal path.
Guard the external plugin support behind a runtime check, which will be
dead-code eliminated in the default case.
---
 Makefile.am  |  4 ---
 src/btd.h    |  2 +-
 src/plugin.c | 92 +++++++++++++++++++++++++++++++++++++-----------------------
 src/plugin.h |  4 +++
 4 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9e35d7fd9..2d5650ced 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -51,11 +51,7 @@ EXTRA_DIST += src/org.bluez.service
 
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
index 2a29a888e..b6a84299a 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -26,6 +26,8 @@
 #include "src/log.h"
 #include "src/btd.h"
 
+#define IS_ENABLED(x) (x)
+
 static GSList *plugins = NULL;
 
 struct bluetooth_plugin {
@@ -42,7 +44,7 @@ static int compare_priority(gconstpointer a, gconstpointer b)
 	return plugin2->desc->priority - plugin1->desc->priority;
 }
 
-static gboolean add_plugin(void *handle,
+static gboolean add_external_plugin(void *handle,
 				const struct bluetooth_plugin_desc *desc)
 {
 	struct bluetooth_plugin *plugin;
@@ -72,6 +74,21 @@ static gboolean add_plugin(void *handle,
 	return TRUE;
 }
 
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
+
 static gboolean enable_plugin(const char *name, char **cli_enable,
 							char **cli_disable)
 {
@@ -98,48 +115,23 @@ static gboolean enable_plugin(const char *name, char **cli_enable,
 	return TRUE;
 }
 
-#include "src/builtin.h"
 
-gboolean plugin_init(const char *enable, const char *disable)
+static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 {
-	GSList *list;
 	GDir *dir;
 	const char *file;
-	char **cli_disabled, **cli_enabled;
-	unsigned int i;
-
-	/* Make a call to BtIO API so its symbols got resolved before the
-	 * plugins are loaded. */
-	bt_io_error_quark();
-
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
 
-		add_plugin(NULL,  __bluetooth_builtin[i]);
-	}
+	info("Using external plugins is not officially supported.\n");
+	info("Consider upstreaming your plugins into the BlueZ project.");
 
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
@@ -174,13 +166,45 @@ gboolean plugin_init(const char *enable, const char *disable)
 			continue;
 		}
 
-		if (add_plugin(handle, desc) == FALSE)
+		if (add_external_plugin(handle, desc) == FALSE)
 			dlclose(handle);
 	}
 
 	g_dir_close(dir);
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
+	if IS_ENABLED(EXTERNAL_PLUGINS)
+		external_plugin_init(cli_enabled, cli_disabled);
 
-start:
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 		int err;
@@ -201,8 +225,6 @@ start:
 
 	g_strfreev(cli_enabled);
 	g_strfreev(cli_disabled);
-
-	return TRUE;
 }
 
 void plugin_cleanup(void)
diff --git a/src/plugin.h b/src/plugin.h
index 8d0903f2d..b484ed378 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -28,6 +28,7 @@ struct bluetooth_plugin_desc {
 			#name, version, priority, init, exit \
 		};
 #else
+#if EXTERNAL_PLUGINS
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
 		extern struct btd_debug_desc __start___debug[] \
 				__attribute__ ((weak, visibility("hidden"))); \
@@ -40,4 +41,7 @@ struct bluetooth_plugin_desc {
 			#name, version, priority, init, exit, \
 			__start___debug, __stop___debug \
 		};
+#else
+#error "Requested non built-in plugin, while external plugins is disabled"
+#endif
 #endif

-- 
2.43.0

