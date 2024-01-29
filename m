Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A15B1FE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=oB08OcsAF/rkVg509Z7+HRUu6pLR8BDFlKfMEIiCUJAea3G1FwzUaZ4ou4dU5yGAnC1Nvq70odfUbXLmA9cnK67xOaTKzxq6tLch/HbA9/KK8zLjjUZ4neNv2fsAPl9LKf6feKrmtHAcJt5rX94p/GSmwQwNWCR/eL+yS4ABNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=z2zwOAIJdLbSH5OWauqgK8n/AiJg9/e9ESmn51K3eGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghSFXbXeA+shLBcCeW8wI11gzg2hapLZjot5d2gXahCMPnuRqXJPGMl/OPPWvICAsaEToVBqpMfCzs7gaWyu95fKBQoioyXgEfLNpMh3kHJArOMZ008Rl9rbAbl5p75UQ+VcXhFVccYo0Ne7+Hab6aBViwKVf7Ws+jwLH3htNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy2KltPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy2KltPE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D98A4C43390;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539456;
	bh=z2zwOAIJdLbSH5OWauqgK8n/AiJg9/e9ESmn51K3eGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cy2KltPE/cL43bD1hv2wqUdior3sEGLlt2II+kGJM91jtprj9aI8IIGXEz+U+esjU
	 LvODii3VpxI1pGp/ExzsiSntPRuOI2d2czV41YK4BntfLpKA4L09KWlZmkecEaka4R
	 xiq+e1B+8q9hM6tQTk6D1F1SBEd7jr9yongCq6OUcGvKYNbZRlTVnxE4Cxd96DmKS3
	 hSzg1+QTpyD1E0lMOclcadwrNr4Wj2LY7V4M5axg9qkcWadoOmi9sMkIY3uHK9iPU5
	 IAab71IsEYnJmN1V3u0XJHSeVD+GWt5xYYWzV2qxcler6ryOKLBpcH5npk+GyssX1D
	 vtVw/vKTO0asg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173EC47DB3;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:16 +0000
Subject: [PATCH BlueZ v4 2/8] obexd: factor out external plugin support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-2-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=5559;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=cIMdx6HXhTyyf9nrZXFXunU9oNAXB+a/bweqZhHYUuc=;
 b=tYiy9kcFNgVL5ypyASR6SaY9uxeukDmHzK39nDhlEwqseYQpcqk33MTilzvMk93Mm72x0ICuz
 RY6eKf0hOF3AAk3nF+sxQPZ6QZwTHPe0DNqvbJreudK3uwq/bCg42uE
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

As a whole all plugins should be built-in, otherwise they would be using
internal, undocumented, unversioned, unstable API.

Flesh out the external plugin support into a few blocks and simplify the
normal path. Guard the external plugin support behind a runtime check,
which will be dead-code eliminated in the default case.

Hide the internal API (omit export-dynamic) when built without external
plugins.
---
 Makefile.obexd     |  2 ++
 obexd/src/obexd.h  |  2 +-
 obexd/src/plugin.c | 89 ++++++++++++++++++++++++++++++++++++------------------
 obexd/src/plugin.h |  4 +++
 4 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 363295d0e..0e50b1fa4 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -92,7 +92,9 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			$(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
 			$(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
 
+if EXTERNAL_PLUGINS
 obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
+endif
 
 obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				$(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index fe312a65b..af5265da5 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -18,7 +18,7 @@
 #define OBEX_MAS	(1 << 8)
 #define OBEX_MNS	(1 << 9)
 
-gboolean plugin_init(const char *pattern, const char *exclude);
+void plugin_init(const char *pattern, const char *exclude);
 void plugin_cleanup(void);
 
 gboolean manager_init(void);
diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index a3eb24753..14327782d 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -34,6 +34,8 @@
 #define PLUGINFLAG (RTLD_NOW)
 #endif
 
+#define IS_ENABLED(x) (x)
+
 static GSList *plugins = NULL;
 
 struct obex_plugin {
@@ -41,7 +43,8 @@ struct obex_plugin {
 	const struct obex_plugin_desc *desc;
 };
 
-static gboolean add_plugin(void *handle, const struct obex_plugin_desc *desc)
+static gboolean add_external_plugin(void *handle,
+					const struct obex_plugin_desc *desc)
 {
 	struct obex_plugin *plugin;
 
@@ -66,6 +69,25 @@ static gboolean add_plugin(void *handle, const struct obex_plugin_desc *desc)
 	return TRUE;
 }
 
+static void add_plugin(const struct obex_plugin_desc *desc)
+{
+	struct obex_plugin *plugin;
+
+	plugin = g_try_new0(struct obex_plugin, 1);
+	if (plugin == NULL)
+		return;
+
+	plugin->desc = desc;
+
+	if (desc->init() < 0) {
+		g_free(plugin);
+		return;
+	}
+
+	plugins = g_slist_append(plugins, plugin);
+	DBG("Plugin %s loaded", desc->name);
+}
+
 static gboolean check_plugin(const struct obex_plugin_desc *desc,
 				char **patterns, char **excludes)
 {
@@ -93,42 +115,22 @@ static gboolean check_plugin(const struct obex_plugin_desc *desc,
 }
 
 
-#include "builtin.h"
-
-gboolean plugin_init(const char *pattern, const char *exclude)
+static void external_plugin_init(char **patterns, char **excludes)
 {
-	char **patterns = NULL;
-	char **excludes = NULL;
 	GDir *dir;
 	const char *file;
-	unsigned int i;
 
-	if (strlen(PLUGINDIR) == 0)
-		return FALSE;
+	info("Using external plugins is not officially supported.\n");
+	info("Consider upstreaming your plugins into the BlueZ project.");
 
-	if (pattern)
-		patterns = g_strsplit_set(pattern, ":, ", -1);
-
-	if (exclude)
-		excludes = g_strsplit_set(exclude, ":, ", -1);
-
-	DBG("Loading builtin plugins");
-
-	for (i = 0; __obex_builtin[i]; i++) {
-		if (check_plugin(__obex_builtin[i],
-					patterns, excludes) == FALSE)
-			continue;
-
-		add_plugin(NULL,  __obex_builtin[i]);
-	}
+	if (strlen(PLUGINDIR) == 0)
+		return;
 
 	DBG("Loading plugins %s", PLUGINDIR);
 
 	dir = g_dir_open(PLUGINDIR, 0, NULL);
 	if (!dir) {
-		g_strfreev(patterns);
-		g_strfreev(excludes);
-		return FALSE;
+		return;
 	}
 
 	while ((file = g_dir_read_name(dir)) != NULL) {
@@ -164,15 +166,42 @@ gboolean plugin_init(const char *pattern, const char *exclude)
 			continue;
 		}
 
-		if (add_plugin(handle, desc) == FALSE)
+		if (add_external_plugin(handle, desc) == FALSE)
 			dlclose(handle);
 	}
 
 	g_dir_close(dir);
+}
+
+#include "builtin.h"
+
+void plugin_init(const char *pattern, const char *exclude)
+{
+	char **patterns = NULL;
+	char **excludes = NULL;
+	unsigned int i;
+
+	if (pattern)
+		patterns = g_strsplit_set(pattern, ":, ", -1);
+
+	if (exclude)
+		excludes = g_strsplit_set(exclude, ":, ", -1);
+
+	DBG("Loading builtin plugins");
+
+	for (i = 0; __obex_builtin[i]; i++) {
+		if (check_plugin(__obex_builtin[i],
+					patterns, excludes) == FALSE)
+			continue;
+
+		add_plugin(__obex_builtin[i]);
+	}
+
+	if IS_ENABLED(EXTERNAL_PLUGINS)
+		external_plugin_init(patterns, excludes);
+
 	g_strfreev(patterns);
 	g_strfreev(excludes);
-
-	return TRUE;
 }
 
 void plugin_cleanup(void)
diff --git a/obexd/src/plugin.h b/obexd/src/plugin.h
index a91746cbc..e1756b9bf 100644
--- a/obexd/src/plugin.h
+++ b/obexd/src/plugin.h
@@ -20,10 +20,14 @@ struct obex_plugin_desc {
 			#name, init, exit \
 		};
 #else
+#if EXTERNAL_PLUGINS
 #define OBEX_PLUGIN_DEFINE(name,init,exit) \
 		extern struct obex_plugin_desc obex_plugin_desc \
 				__attribute__ ((visibility("default"))); \
 		const struct obex_plugin_desc obex_plugin_desc = { \
 			#name, init, exit \
 		};
+#else
+#error "Requested non built-in plugin, while external plugins is disabled"
+#endif
 #endif

-- 
2.43.0

