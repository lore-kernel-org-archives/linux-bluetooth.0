Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64F399
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=UHPDcsgyFWk8Ic1aLX/7JrpL9OfPGpCwSHZI7KEVMKP31IxMEcY329oyZG4xCco9VeIuDtPY3lxe5/DGlDC9K/HuyH/bVbuyY9kOHOKf3NA1LwNAJdRiT3MOwUtCl6NwpQdBngdF8QD+9qwPtax/gXA+oIYKvU8hUjoZKfMX+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=G9genvZ+XzEEPgL5CU4jnpFYI5JsJj4sQ/6exI14zAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxZUItQDIOw7E+QEF/ojyqGPdP8LYwjyGKfRwZOfNUwXOLs3tvPwrXYLSFyN5Zu33/W2i/vG72anS2B7YJLHhUifxF/ITAgRCQalTGsJ2saSQwHekcUw5DYilOIKmflIVn9Z2sSa6tGSJpQqcpgeCjwCAoouQdbBtfZ99kV7oCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io/b2CsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io/b2CsC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 819D7C43330;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=G9genvZ+XzEEPgL5CU4jnpFYI5JsJj4sQ/6exI14zAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=io/b2CsC/KZ8uTVFakQaMkU/Dwj/JMPeFaHsYX5ootxTkqqhfM0p/jQ0W6kBC132D
	 HM7AGSdnYTnaxh/eoHtqoJrzrgEq/x9QuE9uxEkhAcuYpgsu7uVGzfJEdSrfyp9o4x
	 ekyhfWPSw42IU2YI62h2OvQq/9ouV20sk0S07U9Txbu2/DlgAA/tpPS9jN6xMxDEFI
	 TmqjPCdcO1/LrUBN767CGjZR7PQhgt7efcPOorNXcoAtY4KVBW/Z6XuQ0hf3zjXYrc
	 SwpVAQvvX5Ye/MjwjbAP3QJLYrYCSbDe03ULkbdaE4rs2QJX8UkMHb05kUQy5ju4sz
	 UrketYFwc/m5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AFEC47422;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:32 +0000
Subject: [PATCH BlueZ v3 7/8] bluetoothd: change plugin loading alike obexd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-7-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=3470;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=6yElFux7++NnGhXn3yTR7PlLXi4XViEHuKoqMgyFigw=;
 b=lXobeEKJxrFM52Kbj5OKm+XlDLerbaNjVpH6BHJ+gVI6v9prO3Dq3yf8MN1lpY74DOfrslXio
 9dmelYX4Up5DokHJDjLYU6/lUlWsrR7KgtmfxLmtqeRLBWvN5yx4WFB
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Currently, we print "Loading foobar" for every plugin, before we try the
respective init() callback. Instead we handle the latter in a bunch, at
the end of the process.

Do the init() call early, print "Loaded" once it's actually successful
and drop the no-longer "active" tracking.
---
 src/plugin.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index ae9406375..3895792bc 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -32,7 +32,6 @@ struct bluetooth_plugin {
 #if EXTERNAL_PLUGINS
 	void *handle;
 #endif
-	gboolean active;
 	const struct bluetooth_plugin_desc *desc;
 };
 
@@ -44,6 +43,22 @@ static int compare_priority(gconstpointer a, gconstpointer b)
 	return plugin2->desc->priority - plugin1->desc->priority;
 }
 
+static int init_plugin(const struct bluetooth_plugin_desc *desc)
+{
+	int err;
+
+	err = desc->init();
+	if (err < 0) {
+		if (err == -ENOSYS || err == -ENOTSUP)
+			warn("System does not support %s plugin",
+						desc->name);
+		else
+			error("Failed to init %s plugin",
+						desc->name);
+	}
+	return err;
+}
+
 #if EXTERNAL_PLUGINS
 static gboolean add_external_plugin(void *handle,
 				const struct bluetooth_plugin_desc *desc)
@@ -58,19 +73,22 @@ static gboolean add_external_plugin(void *handle,
 		return FALSE;
 	}
 
-	DBG("Loading %s plugin", desc->name);
-
 	plugin = g_try_new0(struct bluetooth_plugin, 1);
 	if (plugin == NULL)
 		return FALSE;
 
 	plugin->handle = handle;
-	plugin->active = FALSE;
 	plugin->desc = desc;
 
+	if (init_plugin(desc) < 0) {
+		g_free(plugin);
+		return FALSE;
+	}
+
 	__btd_enable_debug(desc->debug_start, desc->debug_stop);
 
 	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	DBG("Plugin %s loaded", desc->name);
 
 	return TRUE;
 }
@@ -88,7 +106,13 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
 
 	plugin->desc = desc;
 
+	if (init_plugin(desc) < 0) {
+		g_free(plugin);
+		return;
+	}
+
 	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	DBG("Plugin %s loaded", desc->name);
 }
 
 static gboolean enable_plugin(const char *name, char **cli_enable,
@@ -181,7 +205,6 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 
 void plugin_init(const char *enable, const char *disable)
 {
-	GSList *list;
 	char **cli_disabled = NULL;
 	char **cli_enabled = NULL;
 	unsigned int i;
@@ -208,24 +231,6 @@ void plugin_init(const char *enable, const char *disable)
 
 	external_plugin_init(cli_enabled, cli_disabled);
 
-	for (list = plugins; list; list = list->next) {
-		struct bluetooth_plugin *plugin = list->data;
-		int err;
-
-		err = plugin->desc->init();
-		if (err < 0) {
-			if (err == -ENOSYS || err == -ENOTSUP)
-				warn("System does not support %s plugin",
-							plugin->desc->name);
-			else
-				error("Failed to init %s plugin",
-							plugin->desc->name);
-			continue;
-		}
-
-		plugin->active = TRUE;
-	}
-
 	g_strfreev(cli_enabled);
 	g_strfreev(cli_disabled);
 }
@@ -239,7 +244,7 @@ void plugin_cleanup(void)
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 
-		if (plugin->active == TRUE && plugin->desc->exit)
+		if (plugin->desc->exit)
 			plugin->desc->exit();
 
 #if EXTERNAL_PLUGINS

-- 
2.43.0

