Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF371E570D
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129158; cv=none; b=uYhQtEDxkocjuu9vp72tAaBX6YJWUEmaku03SeLpJn66qlVe/lGvO9efvkXcGxbDR73+3yqVAY8DGyw05n5Ha7/TPse2ZZ8okznZU6KU1KxF4M0rz5eUz6UkqJtoq9qU6qo+em+1YIbrBi2YFSwu1oKPiW1U9VadAScBbHuQ+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129158; c=relaxed/simple;
	bh=43davrjwyMt3temJ8Nqt6cUnDxTiabAvGZCboOdjCg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5/xScbz6UvI9BJ0j9PY+20hoyU9W6dZFS3Ppj76l/gSucHoqgYsasicbWznZRK5+exdpCFr7BgiTrjZkD9PSYe9AIL7oSC1iE6p7Ji4NdvLPprP6MRY2jqnqZXVV3f2PmGV4ai+jBcAjsirc9lWOlA7qofkOYDKpUNk9a0rWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DC9143311;
	Tue, 13 May 2025 09:39:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 1/9] client: Split installing submenu and doing I/O
Date: Tue, 13 May 2025 11:38:11 +0200
Message-ID: <20250513093913.396876-2-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513093913.396876-1-hadess@hadess.net>
References: <20250513093913.396876-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveethfelveejffetkeelheehueejlefhvdehteehgfeghfekgfdvfefhgeekieetnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtrddrpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
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
index 4d645d9469bb..614a492f1f5f 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -193,7 +193,10 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
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
index 0047770dc737..08cca585d466 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -9,4 +9,5 @@
  */
 
 void admin_add_submenu(void);
+void admin_enable_submenu(void);
 void admin_remove_submenu(void);
diff --git a/client/assistant.c b/client/assistant.c
index 16e94664a5c3..555ac6feb048 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -395,7 +395,10 @@ static GDBusClient * client;
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
index a2d9d88bff43..e35e89dd2362 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3420,9 +3420,13 @@ int main(int argc, char *argv[])
 					(void *)endpoint_option);
 
 	admin_add_submenu();
+	admin_enable_submenu();
 	player_add_submenu();
+	player_enable_submenu();
 	mgmt_add_submenu();
+	mgmt_enable_submenu();
 	assistant_add_submenu();
+	assistant_enable_submenu();
 	hci_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
diff --git a/client/mgmt.c b/client/mgmt.c
index faa97a159e3c..6c6d62f4bba1 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -6169,7 +6169,13 @@ static void mgmt_debug(const char *str, void *user_data)
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
@@ -6177,9 +6183,6 @@ bool mgmt_add_submenu(void)
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
index 647e9bed70e6..7aab4af6d861 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5876,7 +5876,10 @@ void player_add_submenu(void)
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
2.49.0

