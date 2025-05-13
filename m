Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE636239082
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129161; cv=none; b=R6DXucq7kZRSdAI+3Fyh93aeBaVjemGmK/daps9cCztK9UKA7F7oE9ptkM6Ee9pTJsA8WgVYMA1KwHyLMMAd1NA/AMXbiUQVzIHUeoBTjizf6TJbGkqjVCTqcNOxEveVTr5joKei6leEwUZ5KdKdPfXbjqJRyFfxdXK/LbDyLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129161; c=relaxed/simple;
	bh=pZ8OOAA2CRxedVPdUJIIF28i/WXveMwXVZkqQ0YcJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGoFYXbZVksS5rnwObnyt0Jb2GV509MkaVQrp+1cXkCq5idsq6+0AdWyWRjqPV12gK7g/9s8XBaMaaDjtH32C0R4WV73h0EV/7h3vgGmIX2THH09MM/G6q1HOi/+ycKW/xCoGQ3Mu3YWtBCVa/dLbkxsAfgCMOajIf7WUcvin74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2221439F1;
	Tue, 13 May 2025 09:39:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 9/9] client: Port "assistant" menu to pre_run
Date: Tue, 13 May 2025 11:38:19 +0200
Message-ID: <20250513093913.396876-10-hadess@hadess.net>
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

---
 client/assistant.c | 11 +++++++++--
 client/assistant.h |  1 -
 client/main.c      |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/client/assistant.c b/client/assistant.c
index 555ac6feb048..6d172a8d8e81 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -55,6 +55,8 @@ static DBusConnection *dbus_conn;
 
 static GList *assistants;
 
+static void assistant_menu_pre_run(const struct bt_shell_menu *menu);
+
 static char *proxy_description(GDBusProxy *proxy, const char *title,
 						const char *description)
 {
@@ -384,6 +386,7 @@ fail:
 static const struct bt_shell_menu assistant_menu = {
 	.name = "assistant",
 	.desc = "Media Assistant Submenu",
+	.pre_run = assistant_menu_pre_run,
 	.entries = {
 	{ "push", "<assistant>", cmd_push_assistant,
 					"Send stream information to peer" },
@@ -397,10 +400,12 @@ void assistant_add_submenu(void)
 	bt_shell_add_submenu(&assistant_menu);
 }
 
-void assistant_enable_submenu(void)
+static bool pre_run_done = false;
+
+static void assistant_menu_pre_run(const struct bt_shell_menu *menu)
 {
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
-	if (!dbus_conn || client)
+	if (pre_run_done || !dbus_conn || client)
 		return;
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
@@ -408,6 +413,8 @@ void assistant_enable_submenu(void)
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+
+	pre_run_done = true;
 }
 
 void assistant_remove_submenu(void)
diff --git a/client/assistant.h b/client/assistant.h
index c304abea0515..418b0b84031f 100644
--- a/client/assistant.h
+++ b/client/assistant.h
@@ -9,6 +9,5 @@
  */
 
 void assistant_add_submenu(void);
-void assistant_enable_submenu(void);
 void assistant_remove_submenu(void);
 
diff --git a/client/main.c b/client/main.c
index 06ae25c9d8e9..36a7446d52c1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3426,8 +3426,6 @@ int main(int argc, char *argv[])
 		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
 					(void *)endpoint_option);
 
-	assistant_enable_submenu();
-
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
-- 
2.49.0

