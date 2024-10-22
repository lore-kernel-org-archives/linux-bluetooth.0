Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC9199252
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598461; cv=none; b=A7Fgco+kastSeZ14jSsFly+/Rm64wMSsk/t4TirDOQWH86uJkKnsDHp3ca84BhV5OseAnBBKv2QdgcpgVA7hFINTrRMvfZMBxFv08L9hik9L/y6+xDEJKrbKDfREF7ilrM38USOak/XvsLHUU0lK+RtR/fvbTBHv6X+GaGkQtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598461; c=relaxed/simple;
	bh=stdfC0w+a9QqvorW0UmHP3AKTvUwMz74Z/gkoW1AZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTwV84zdB7oGQ5Qv/KR5hHbt8iaGZeU0khHUB1h+Du+nd1bV2y2VfjiIH32T9PA3ysTeNkoHA7zSDFpR7wwnffxkXMxbOwQHG4dN3f0q8KHpOJ7gaqh6c/L+RSByDy0vnWRGaySI6s6KSMCmxNKexYdGm99SoQFd4vt9JxIBz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 525851C0021;
	Tue, 22 Oct 2024 12:00:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 2/7] client: Use g_clear_pointer() to clean up menus
Date: Tue, 22 Oct 2024 13:58:32 +0200
Message-ID: <20241022120051.123888-3-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022120051.123888-1-hadess@hadess.net>
References: <20241022120051.123888-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

This would avoid warnings should the client be NULL.
---
 client/admin.c     | 5 ++---
 client/assistant.c | 5 ++---
 client/player.c    | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index cd9af6f955da..9d48867bc1d7 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -191,7 +191,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		admin_policy_status_removed(proxy);
 }
 
-static GDBusClient *client;
+static GDBusClient *client = NULL;
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
@@ -215,6 +215,5 @@ void admin_add_submenu(void)
 
 void admin_remove_submenu(void)
 {
-	g_dbus_client_unref(client);
-	client = NULL;
+	g_clear_pointer(&client, g_dbus_client_unref);
 }
diff --git a/client/assistant.c b/client/assistant.c
index 16e94664a5c3..94052e26fd59 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -390,7 +390,7 @@ static const struct bt_shell_menu assistant_menu = {
 	{} },
 };
 
-static GDBusClient * client;
+static GDBusClient * client = NULL;
 
 void assistant_add_submenu(void)
 {
@@ -409,7 +409,6 @@ void assistant_add_submenu(void)
 
 void assistant_remove_submenu(void)
 {
-	g_dbus_client_unref(client);
-	client = NULL;
+	g_clear_pointer(&client, g_dbus_client_unref);
 }
 
diff --git a/client/player.c b/client/player.c
index 188378175486..dea5922d56db 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5694,7 +5694,7 @@ static const struct bt_shell_menu transport_menu = {
 	{} },
 };
 
-static GDBusClient *client;
+static GDBusClient *client = NULL;
 
 void player_add_submenu(void)
 {
@@ -5715,6 +5715,6 @@ void player_add_submenu(void)
 
 void player_remove_submenu(void)
 {
-	g_dbus_client_unref(client);
+	g_clear_pointer(&client, g_dbus_client_unref);
 	queue_destroy(ios, transport_free);
 }
-- 
2.47.0

