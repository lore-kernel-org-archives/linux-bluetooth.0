Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96B23817C
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129159; cv=none; b=k9mGBoNZvQQzvtY7gijVgShSoVGfaTL9GJX+5SC1KZWj+5Cf/I3LzoFMYu0sl1Jm1jkKzsLExpLywxnKBk570EahQq3pFfWibxrVqIcvOZvnr3ZksNqi5BeTX5G4ruSgTVLWH9znz72PWA8vE66HjSjwp87Cg/8J5Xmfz/Es+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129159; c=relaxed/simple;
	bh=pWcWdG7mMrFJlcUAVHYHi+xBZSf4ACHJnpsfCncrPEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMF5PJfeVG4RYBF9LA6ELyvNGKuJBKL8voD9JeqayKjJ6BWUAmFd0Q8c6/g7wq1LPHZ2lqcvSNL0KXDTS0QwnYs6lsZ4zYqzdaDymOapSyge0K78ixNTlzEgrA7LkciV7eoyKRmD6DrpAziDoJ/Yl5fBSIiiyF8Uv80Yril1WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA8B441D02;
	Tue, 13 May 2025 09:39:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 5/9] shared/shell: Add pre_run menu callback
Date: Tue, 13 May 2025 11:38:15 +0200
Message-ID: <20250513093913.396876-6-hadess@hadess.net>
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

This callback will be called every time the menu is called, and can be
used to make sure that, for example, a D-Bus connection, is setup for
the menu to use.

This means that it is now possible to install a menu without setting up
a D-Bus connexion, but still have access to that connexion when the menu
is activated.
---
 src/shared/shell.c | 9 +++++++++
 src/shared/shell.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 4e42bd69b4d7..3e5959fc1868 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1447,6 +1447,15 @@ static void env_destroy(void *data)
 int bt_shell_run(void)
 {
 	int status;
+	const struct queue_entry *submenu;
+
+	for (submenu = queue_get_entries(data.submenus); submenu;
+	     submenu = submenu->next) {
+		struct bt_shell_menu *menu = submenu->data;
+
+		if (menu->pre_run != NULL)
+			menu->pre_run(menu);
+	}
 
 	status = mainloop_run_with_signal(signal_callback, NULL);
 
diff --git a/src/shared/shell.h b/src/shared/shell.h
index eebbc71faffb..297fb69a6fb8 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -27,6 +27,7 @@ typedef void (*bt_shell_menu_disp_t) (char **matches, int num_matches,
 							int max_length);
 typedef void (*bt_shell_prompt_input_func) (const char *input, void *user_data);
 typedef bool (*bt_shell_menu_exists_t) (const struct bt_shell_menu *menu);
+typedef void (*bt_shell_menu_pre_run_t) (const struct bt_shell_menu *menu);
 
 struct bt_shell_menu_entry {
 	const char *cmd;
@@ -41,6 +42,7 @@ struct bt_shell_menu_entry {
 struct bt_shell_menu {
 	const char *name;
 	const char *desc;
+	bt_shell_menu_pre_run_t pre_run;
 	const struct bt_shell_menu_entry entries[];
 };
 
-- 
2.49.0

