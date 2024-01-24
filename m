Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36537E575
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=GpBu02Bi/GSP+FZxNnGbsWcdLATOXdPGhqc6wvWLSjIuetNtte+y9LC9Z8cfT4QiUcEnEwF1LJmredVXi8EBJ7TCplM65fzAgZ41nQMm6jTtq4lTG0W1T+Ono+a8wilIMtg+YhcUsMcCDdYF02R1DDVM/GqKrONZFnLB8uk+e+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=QJg5pixklobSgAARqWUGUlRWGe9HIQqjbwWWEc0VPSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWvF4XUjtBAsJ8MWRhKqulfnMoNxdBVy8UNaMYOsQRlU3IFT2bZDc2dbBVSNAlOTT+s8NbL1Y10U7MqMNWs2K7v+Ibw89fo3NlbXTZaQf37zKdxYr2XXsB99gseNmlnLiRyCA/ztgf4WLz6HoqsYYklFeg/pmvr0UQK/3CknHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2PnzT+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2PnzT+P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 641FAC43143;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=QJg5pixklobSgAARqWUGUlRWGe9HIQqjbwWWEc0VPSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t2PnzT+P264tY4C7R3cz8YLdyBxIrEZePXMBwECcn/vN1jw0KXz+3UDrHtZB2ZkCm
	 fnxTfXTqqGaAp1yvmeamPyAqCivywks6egD3uVSGB1eQKuVQHUgC/uN6ecQRqppJKz
	 Ta++McilTDJr0HeC069fscd78tHv73UR7T/lS9RIIEVIxmNr1Gbg1mYb0xLe4m0PEs
	 EP7ROdJ/hSs8s8mS1NnkHVwbq+n9OLP/gWDUQYXc39uondz0R+HPmwoPF1kYzU61nj
	 tOeSHTaDAcpMHtSEfp3AjT3L4qwKO0ayhDigCOss6x/bcEKb7Sgj8tCgme1iYq06Oi
	 qBAb8hfTsZ8YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53473C46CD2;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:08:03 +0000
Subject: [PATCH BlueZ v2 7/8] bluetoothd: change plugin loading alike obexd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-rm-ext-plugins-v2-7-5244906f05ff@gmail.com>
References: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
In-Reply-To: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=3454;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=lDIlt74J4TxHWA83j/ATOvQ2txmbjUJNdwwnk4TmfAc=;
 b=n5JPCEWKxvlADNo49MpjCnWsLFcSDxyd2AmTTkJDBDAU3fcWRN8736bJvR1s2poGzOzvJkAyk
 958fAnD/MEFB6q/TR23qeAyVWWjcT+HXmBhXO+l2dTURShVDRe7KXUO
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
 src/plugin.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index ae9406375..a1836e10f 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -32,7 +32,6 @@ struct bluetooth_plugin {
 #if EXTERNAL_PLUGINS
 	void *handle;
 #endif
-	gboolean active;
 	const struct bluetooth_plugin_desc *desc;
 };
 
@@ -44,6 +43,21 @@ static int compare_priority(gconstpointer a, gconstpointer b)
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
+}
+
 #if EXTERNAL_PLUGINS
 static gboolean add_external_plugin(void *handle,
 				const struct bluetooth_plugin_desc *desc)
@@ -58,19 +72,22 @@ static gboolean add_external_plugin(void *handle,
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
@@ -88,7 +105,13 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
 
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
@@ -181,7 +204,6 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 
 void plugin_init(const char *enable, const char *disable)
 {
-	GSList *list;
 	char **cli_disabled = NULL;
 	char **cli_enabled = NULL;
 	unsigned int i;
@@ -208,24 +230,6 @@ void plugin_init(const char *enable, const char *disable)
 
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
@@ -239,7 +243,7 @@ void plugin_cleanup(void)
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 
-		if (plugin->active == TRUE && plugin->desc->exit)
+		if (plugin->desc->exit)
 			plugin->desc->exit();
 
 #if EXTERNAL_PLUGINS

-- 
2.43.0

