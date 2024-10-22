Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8319F423
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606283; cv=none; b=Gbvy1rG34h4fmm6VXgPjVvQq7rGS0IGt3jiAKfkA7w59IcQ8mhSSyNng/PWjF++VU/gHL+BhNMBsnMcsa6HAw98n9d85dML9H8IkoaJEMmtHof5HQuTcM0j9STPuN2z0KVMWezKC3Q3bQcr+ngAjEagBlHLQy6BQ7gkDvxcHCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606283; c=relaxed/simple;
	bh=LyZBJ+/JOYDSY+EdIQETDOgSabMnIXIvuxpdyI8Gh9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmXTRAc7sQAF2Pf97NVv/REbAfZkeAD5Q6LZjRbKQPMO9/G/JxE9rtKrlFEgxhuowzxuxx4FCSS2qkWh6OHkG+CUIhJprxOiOwknUvNjAYtGkVnfqZ0cSYX5c10hooQmEaX5D6So8yO9DguQkqmOTo2PhVk4YoRMl9nsl+Xi6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78C55240003;
	Tue, 22 Oct 2024 14:11:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 3/7] client: Split installing submenu and doing I/O
Date: Tue, 22 Oct 2024 16:10:34 +0200
Message-ID: <20241022141118.150143-4-hadess@hadess.net>
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

Split off installing the command's submenu and contacting the management
socket or the bluez daemon.
---
 client/admin.c     |  3 +++
 client/admin.h     |  1 +
 client/assistant.c |  3 +++
 client/assistant.h |  1 +
 client/main.c      |  4 ++++
 client/mgmt.c      | 11 +++++++----
 client/mgmt.h      |  3 ++-
 client/player.c    |  3 +++
 client/player.h    |  1 +
 tools/btmgmt.c     |  3 ++-
 10 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index 9d48867bc1d7..15759ba0291a 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -202,7 +202,10 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 void admin_add_submenu(void)
 {
 	bt_shell_add_submenu(&admin_menu);
+}
 
+void admin_enable_submenu(void)
+{
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
 		return;
diff --git a/client/admin.h b/client/admin.h
index 4da83e4e36ba..68a497971f66 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -18,4 +18,5 @@
  */
 
 void admin_add_submenu(void);
+void admin_enable_submenu(void);
 void admin_remove_submenu(void);
diff --git a/client/assistant.c b/client/assistant.c
index 94052e26fd59..ceade046be68 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -395,7 +395,10 @@ static GDBusClient * client = NULL;
 void assistant_add_submenu(void)
 {
 	bt_shell_add_submenu(&assistant_menu);
+}
 
+void assistant_enable_submenu(void)
+{
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
 		return;
diff --git a/client/assistant.h b/client/assistant.h
index 418b0b84031f..c304abea0515 100644
--- a/client/assistant.h
+++ b/client/assistant.h
@@ -9,5 +9,6 @@
  */
 
 void assistant_add_submenu(void);
+void assistant_enable_submenu(void);
 void assistant_remove_submenu(void);
 
diff --git a/client/main.c b/client/main.c
index 3f8143dde4b8..17af62000f6d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3204,9 +3204,13 @@ int main(int argc, char *argv[])
 					(void *)endpoint_option);
 
 	admin_add_submenu();
+	admin_enable_submenu();
 	player_add_submenu();
+	player_enable_submenu();
 	mgmt_add_submenu();
+	mgmt_enable_submenu();
 	assistant_add_submenu();
+	assistant_enable_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
diff --git a/client/mgmt.c b/client/mgmt.c
index 602b92228ab8..aea3d95597c9 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -6026,7 +6026,13 @@ static void mgmt_debug(const char *str, void *user_data)
 	print("%s%s", prefix, str);
 }
 
-bool mgmt_add_submenu(void)
+void mgmt_add_submenu(void)
+{
+	bt_shell_add_submenu(&mgmt_menu);
+	bt_shell_add_submenu(&monitor_menu);
+}
+
+bool mgmt_enable_submenu(void)
 {
 	mgmt = mgmt_new_default();
 	if (!mgmt) {
@@ -6034,9 +6040,6 @@ bool mgmt_add_submenu(void)
 		return false;
 	}
 
-	bt_shell_add_submenu(&mgmt_menu);
-	bt_shell_add_submenu(&monitor_menu);
-
 	if (getenv("MGMT_DEBUG"))
 		mgmt_set_debug(mgmt, mgmt_debug, "mgmt: ", NULL);
 
diff --git a/client/mgmt.h b/client/mgmt.h
index 5a2026eab6a2..b0f3cafd0777 100644
--- a/client/mgmt.h
+++ b/client/mgmt.h
@@ -8,6 +8,7 @@
  *
  */
 
-bool mgmt_add_submenu(void);
+void mgmt_add_submenu(void);
+bool mgmt_enable_submenu(void);
 void mgmt_remove_submenu(void);
 void mgmt_set_index(const char *arg);
diff --git a/client/player.c b/client/player.c
index dea5922d56db..3189e0575798 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5701,7 +5701,10 @@ void player_add_submenu(void)
 	bt_shell_add_submenu(&player_menu);
 	bt_shell_add_submenu(&endpoint_menu);
 	bt_shell_add_submenu(&transport_menu);
+}
 
+void player_enable_submenu(void)
+{
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
 		return;
diff --git a/client/player.h b/client/player.h
index e7778cb1efd9..c09ffa94cbff 100644
--- a/client/player.h
+++ b/client/player.h
@@ -9,4 +9,5 @@
  */
 
 void player_add_submenu(void);
+void player_enable_submenu(void);
 void player_remove_submenu(void);
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 436c2bb21f10..0f6051d5befe 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -46,7 +46,8 @@ int main(int argc, char *argv[])
 
 	bt_shell_init(argc, argv, &opt);
 
-	if (!mgmt_add_submenu()) {
+	mgmt_add_submenu();
+	if (!mgmt_enable_submenu()) {
 		fprintf(stderr, "Unable to open mgmt_socket\n");
 		return EXIT_FAILURE;
 	}
-- 
2.47.0

