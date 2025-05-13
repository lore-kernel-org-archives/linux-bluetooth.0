Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D921CA0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129160; cv=none; b=cqGgZW1YRsdznnbLiJVnN1PUyXk6XJKYgqaAi+2fE166rts5tP899/90g2jEvhL/wal/zwdU/t56MtySKZ1ca/KKWj20qtgzRzQRRbrHICvbjOKDoIb5DvD+suv7xHBx4q7wnI2vpHLcBwnnfdpv/8rojg2+Gqb4cNYesKUIwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129160; c=relaxed/simple;
	bh=X6/H8cwgL8HO9t19tqVd1eFI+bBujc6jfENilHdPc3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCHuoJyGji/upXMGJFQTraAnRtpqhA5a10PJw6t7LPlF33VQCNM2WOnLaaql/HLyvggP/2yV0LTCZNkIovMyc7kV6Dob4ojZKeCoyH8OaG7Q7y4LxaJ+GwtZmrTzs6vLeU7PHS/g7xlOMs487otbe9w4S7d8BDNIrSOF4js8Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F072432F5;
	Tue, 13 May 2025 09:39:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 8/9] client: Port "mgmt" menu to pre_run
Date: Tue, 13 May 2025 11:38:18 +0200
Message-ID: <20250513093913.396876-9-hadess@hadess.net>
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
 client/main.c  |  1 -
 client/mgmt.c  | 14 +++++++++++---
 client/mgmt.h  |  1 -
 tools/btmgmt.c |  5 -----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/client/main.c b/client/main.c
index ce753c1ac4c4..06ae25c9d8e9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3426,7 +3426,6 @@ int main(int argc, char *argv[])
 		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
 					(void *)endpoint_option);
 
-	mgmt_enable_submenu();
 	assistant_enable_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
diff --git a/client/mgmt.c b/client/mgmt.c
index 6c6d62f4bba1..eda68b25a3e9 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -71,6 +71,8 @@ static int pending_index = 0;
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 #endif
 
+static void mgmt_menu_pre_run(const struct bt_shell_menu *menu);
+
 #define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "> "
 
 static void update_prompt(uint16_t index)
@@ -5998,6 +6000,7 @@ static const struct bt_shell_menu monitor_menu = {
 static const struct bt_shell_menu mgmt_menu = {
 	.name = "mgmt",
 	.desc = "Management Submenu",
+	.pre_run = mgmt_menu_pre_run,
 	.entries = {
 	{ "select",		"<index>",
 		cmd_select,		"Select a different index"	},
@@ -6175,12 +6178,17 @@ void mgmt_add_submenu(void)
 	bt_shell_add_submenu(&monitor_menu);
 }
 
-bool mgmt_enable_submenu(void)
+static bool pre_run_done = false;
+
+static void mgmt_menu_pre_run(const struct bt_shell_menu *menu)
 {
+	if (pre_run_done)
+		return;
+
 	mgmt = mgmt_new_default();
 	if (!mgmt) {
 		fprintf(stderr, "Unable to open mgmt_socket\n");
-		return false;
+		return;
 	}
 
 	if (getenv("MGMT_DEBUG"))
@@ -6188,7 +6196,7 @@ bool mgmt_enable_submenu(void)
 
 	register_mgmt_callbacks(mgmt, mgmt_index);
 
-	return true;
+	pre_run_done = true;
 }
 
 void mgmt_remove_submenu(void)
diff --git a/client/mgmt.h b/client/mgmt.h
index b0f3cafd0777..6d235fbb1388 100644
--- a/client/mgmt.h
+++ b/client/mgmt.h
@@ -9,6 +9,5 @@
  */
 
 void mgmt_add_submenu(void);
-bool mgmt_enable_submenu(void);
 void mgmt_remove_submenu(void);
 void mgmt_set_index(const char *arg);
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0f6051d5befe..0f3de2880014 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -47,11 +47,6 @@ int main(int argc, char *argv[])
 	bt_shell_init(argc, argv, &opt);
 
 	mgmt_add_submenu();
-	if (!mgmt_enable_submenu()) {
-		fprintf(stderr, "Unable to open mgmt_socket\n");
-		return EXIT_FAILURE;
-	}
-
 	mgmt_set_index(index_option);
 	bt_shell_attach(fileno(stdin));
 	status = bt_shell_run();
-- 
2.49.0

