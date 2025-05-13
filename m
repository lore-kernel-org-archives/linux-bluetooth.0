Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CA238C33
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129159; cv=none; b=bU9SYqL3nozL1SIjdmaZYRwhoy5D9qyoxGgKo3ue1Gk2TdlPRyeKstZEbqnv5wmpcBSkCLvaJ6qjurPWxLj+pF5K18bCk+rkmPyAE++gl4WjmWS56hI//DSoBWq+Ty1JJFydOsSWRNSJgfAPL8W9DCeB2ctn/x8j1D5WaR7OSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129159; c=relaxed/simple;
	bh=iz0MFim+MyzW6gg8EYY0wiGRImHHKAQbrX6XzNm+puA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2dtsME6ql618eiVQDBdkxBKsd1kE92wZaDtUfoDO3Kma3t37xEl5HvvfWenxTkM/yW3/UIxpFyyR8vN1G9eP9jdisGkJDg2FqtXIFojuM6oSBW1BWD4kSTWNK9jpLHavNMwfF6DovCmL23/qyJ3JNp76cX7aThjXmGRMRC4lC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B3D1439ED;
	Tue, 13 May 2025 09:39:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 6/9] client: Port "admin" menu to pre_run
Date: Tue, 13 May 2025 11:38:16 +0200
Message-ID: <20250513093913.396876-7-hadess@hadess.net>
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
 client/admin.c | 12 +++++++++++-
 client/admin.h |  1 -
 client/main.c  |  1 -
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/client/admin.c b/client/admin.c
index 614a492f1f5f..6bcbdc026906 100644
--- a/client/admin.c
+++ b/client/admin.c
@@ -27,6 +27,8 @@ static GList *admin_proxies;
 static GDBusProxy *set_proxy;
 static GDBusProxy *status_proxy;
 
+static void admin_menu_pre_run(const struct bt_shell_menu *menu);
+
 static void admin_policy_set_set_proxy(GDBusProxy *proxy)
 {
 	set_proxy = proxy;
@@ -140,6 +142,7 @@ static void cmd_admin_allow(int argc, char *argv[])
 static const struct bt_shell_menu admin_menu = {
 	.name = "admin",
 	.desc = "Admin Policy Submenu",
+	.pre_run = admin_menu_pre_run,
 	.entries = {
 	{ "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
 				"Allow service UUIDs and block rest of them"},
@@ -195,8 +198,13 @@ void admin_add_submenu(void)
 	bt_shell_add_submenu(&admin_menu);
 }
 
-void admin_enable_submenu(void)
+static bool pre_run_done = false;
+
+static void admin_menu_pre_run(const struct bt_shell_menu *menu)
 {
+	if (pre_run_done)
+		return;
+
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
 		return;
@@ -205,6 +213,8 @@ void admin_enable_submenu(void)
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							NULL, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+
+	pre_run_done = true;
 }
 
 void admin_remove_submenu(void)
diff --git a/client/admin.h b/client/admin.h
index 08cca585d466..0047770dc737 100644
--- a/client/admin.h
+++ b/client/admin.h
@@ -9,5 +9,4 @@
  */
 
 void admin_add_submenu(void);
-void admin_enable_submenu(void);
 void admin_remove_submenu(void);
diff --git a/client/main.c b/client/main.c
index c536a179dc7a..5d32b5218857 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3426,7 +3426,6 @@ int main(int argc, char *argv[])
 		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
 					(void *)endpoint_option);
 
-	admin_enable_submenu();
 	player_enable_submenu();
 	mgmt_enable_submenu();
 	assistant_enable_submenu();
-- 
2.49.0

