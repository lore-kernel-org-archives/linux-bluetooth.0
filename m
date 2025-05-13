Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE46238C34
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129160; cv=none; b=uVwqRquQDEgTCxG1siK1ztKcT9nnlbN+MWRILpr6m94PSzvbonYHJPMAqmT/sXWCMwz5I+ysihOeRBOmTadr41mieTG01NN41yI8T8npjfm9UtUzSAwmTMDq45WxvCCY7qcVV3OwBPIoppaiHS/jle6dcaPAfpTo0/D939OQvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129160; c=relaxed/simple;
	bh=rpe8KIlP1tRoeu930dsvCFkBZNFFh/h0Y8ltBedxnvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7kXcnuLkjwOes4I0Qxb4wajKAWMhS0op9lxjP0TzGt+Q+OCj4yoNMklB2Yb84kZ04145/sYJ9/HGYG6E2hy4QI3EUT4QfNHsXC42stWptmyqqYwYX4fY8lH8AbTCGW3T4rvAI2OU81GEtK9xPlzp19HBFKdF53KKKjDTc6bgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FB7642EF5;
	Tue, 13 May 2025 09:39:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 7/9] client: Port "player" menu to pre_run
Date: Tue, 13 May 2025 11:38:17 +0200
Message-ID: <20250513093913.396876-8-hadess@hadess.net>
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
 client/main.c   |  1 -
 client/player.c | 10 ++++++++--
 client/player.h |  1 -
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 5d32b5218857..ce753c1ac4c4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3426,7 +3426,6 @@ int main(int argc, char *argv[])
 		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
 					(void *)endpoint_option);
 
-	player_enable_submenu();
 	mgmt_enable_submenu();
 	assistant_enable_submenu();
 
diff --git a/client/player.c b/client/player.c
index 7aab4af6d861..41bf45bf88d0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -154,6 +154,7 @@ struct transport_select_args {
 	struct queue *selecting;
 };
 
+static void player_menu_pre_run(const struct bt_shell_menu *menu);
 static void transport_set_links(struct transport_select_args *args);
 static void transport_select(struct transport_select_args *args);
 
@@ -5838,6 +5839,7 @@ static void cmd_volume_transport(int argc, char *argv[])
 static const struct bt_shell_menu transport_menu = {
 	.name = "transport",
 	.desc = "Media Transport Submenu",
+	.pre_run = player_menu_pre_run,
 	.entries = {
 	{ "list",         NULL,    cmd_list_transport,
 						"List available transports" },
@@ -5878,10 +5880,12 @@ void player_add_submenu(void)
 	bt_shell_add_submenu(&transport_menu);
 }
 
-void player_enable_submenu(void)
+static bool pre_run_done = false;
+
+static void player_menu_pre_run(const struct bt_shell_menu *menu)
 {
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
-	if (!dbus_conn || client)
+	if (pre_run_done || !dbus_conn || client)
 		return;
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
@@ -5889,6 +5893,8 @@ void player_enable_submenu(void)
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+
+	pre_run_done = true;
 }
 
 void player_remove_submenu(void)
diff --git a/client/player.h b/client/player.h
index c09ffa94cbff..e7778cb1efd9 100644
--- a/client/player.h
+++ b/client/player.h
@@ -9,5 +9,4 @@
  */
 
 void player_add_submenu(void);
-void player_enable_submenu(void);
 void player_remove_submenu(void);
-- 
2.49.0

