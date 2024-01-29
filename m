Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308F152DFE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=nXWyWheGbrSaJ8EOx/5NPC59tpPqAmG/LPF2qn/omP0BrnBeLunsetjuganLcEGiX380uYyBcCTZgQa0VJvdIDF3kbMPR7POVDLdsDbJgwFJno3+4Y2XwaNi0ejNX0h2SfkfctdzSbDocgu9gOPg64v6UM2RWiYzs8wyeQx0KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=LGatdnqgDfRAq/Xk+lReqIqM4ymIrHHXvVHxoeqEusI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ng9jR6zGX5tjbVKVf2ojW8UE99ghwkEsCzp94NMJie/KIAfgfVUi7mJJrYzHgZijBfPLxlmKIFblmCCIcIs8xxpZgK9OOoVAl3o6gXd6p9e+jXOiplRS/GEITt5uLQWa6+GLFDW//8e28tRxKJgt+LEizdPsCLgI0GsO1+MVaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmkjXXRT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmkjXXRT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A54FC433B1;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539457;
	bh=LGatdnqgDfRAq/Xk+lReqIqM4ymIrHHXvVHxoeqEusI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pmkjXXRTY5S+40fhhYW7sBEoe/IMpDsfRLWyiCb35jEkbOQrEv5Du5qykPh2Wl9ma
	 uU+YSJuKAaUmyq7s5/RSaI4EA0wlfFzTZKHODB2RSfwmGvN6s2I2KNotbMmHGWXpNl
	 bcCqN2ymtuKG0031HfBcNioZbTf0jX9KeTeByIEAsn6YR/7RbJol6cxEcdfbV8Ab1o
	 afUxi70d1gqLU3aA8CyzUazXGSygVl0r/I8F87fER1cyG0O+viL+qGGEOVn3E/8XiQ
	 dENru1FlLHo2EK481ysX9rs9seYu9jrFTEhlk5cCWBQYdU+4AXQkZ4+0UYorEa6E1Q
	 8QjOH/y2bu5CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A15C48286;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:21 +0000
Subject: [PATCH BlueZ v4 7/8] bluetoothd: change plugin loading alike obexd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-7-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=3497;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=DL7N7DwKctcZBFQW2V1+S1oTVHffRx+jI1FmauTGk9w=;
 b=yQ9Y89mRKZzqYkaOBPfK9oBPwzeLplN3zqrA/LUvnTzNvOcxDS+Ay5UX8gKHzdz4tatbzWoxX
 RAJXPy7BeHvAxi4QJyM6ckkD0hSVwjRLjIs0k0Y12txXwZhLQTDLh/1
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
index b6a84299a..e6d05be4c 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -32,7 +32,6 @@ static GSList *plugins = NULL;
 
 struct bluetooth_plugin {
 	void *handle;
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
 static gboolean add_external_plugin(void *handle,
 				const struct bluetooth_plugin_desc *desc)
 {
@@ -57,19 +72,22 @@ static gboolean add_external_plugin(void *handle,
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
@@ -86,7 +104,13 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
 
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
@@ -177,7 +201,6 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 
 void plugin_init(const char *enable, const char *disable)
 {
-	GSList *list;
 	char **cli_disabled = NULL;
 	char **cli_enabled = NULL;
 	unsigned int i;
@@ -205,24 +228,6 @@ void plugin_init(const char *enable, const char *disable)
 	if IS_ENABLED(EXTERNAL_PLUGINS)
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
@@ -236,7 +241,7 @@ void plugin_cleanup(void)
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 
-		if (plugin->active == TRUE && plugin->desc->exit)
+		if (plugin->desc->exit)
 			plugin->desc->exit();
 
 		if (plugin->handle != NULL)

-- 
2.43.0

