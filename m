Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13819F133
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606283; cv=none; b=jQBhNFcYLdIvqIlwEs7kvmZpdP0zteitU6qwqFCoEyNFrcuzv99EczJfjRgIGEMoOj0DGJ6WPDRmbpZRyjYZW+FwaJEvEn40GYLCyA5XPGoLTw48iWaD1r4AdPugVNqC+j0Hi0AAfaXfrHqZKro/O83f1dewKTQZuNAnWla/t0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606283; c=relaxed/simple;
	bh=stdfC0w+a9QqvorW0UmHP3AKTvUwMz74Z/gkoW1AZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjuii2eRJoDKpxJAgWrfwI1s1A36D+AIZ1Tksl1iEStwIZZoHUBbS//s6G4g0dMA3PP/eQRZJwLg4NjjzbyOC3DMYFoOzQY9uWZyGOGw2/vIEkeTIg3yZIfcOhbwP2BksaT/HxSpm2KJdqZOqFGkQudxwXzjdN8VLWinyITvy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38A9F240004;
	Tue, 22 Oct 2024 14:11:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 2/7] client: Use g_clear_pointer() to clean up menus
Date: Tue, 22 Oct 2024 16:10:33 +0200
Message-ID: <20241022141118.150143-3-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022141118.150143-1-hadess@hadess.net>
References: <20241022141118.150143-1-hadess@hadess.net>
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

