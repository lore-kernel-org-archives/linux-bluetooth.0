Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931E227581
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129160; cv=none; b=kLggoz9O61gL7ihA6Ez9jmweDdncUd71k0SC1Rb4sgEoxAZvI2v9cWJ8vYiaNA+NWyLkd+bL3clkEsJYYOUqhXT9dd9ITRRpTd4s5Y0JSCyhS4NlBmNabEOA5j6CZSpLGhLIu8oBIQCsDQ4yvMt/3PfwQ4xjxqIJVE/BfBmMNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129160; c=relaxed/simple;
	bh=Q2vf5yICqTlGY8VMRGqQTFzWGnbPDoKDJfAP6kvIVrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4a7Pv5506Anuk/JN46FhLB8lw7LsWMaoD8s8pje0kvpeUPbxHGGzL4HWYp4sdepPFqyxJnjSzxUlc4Tw3atiKGgGl59EBoo/q6t69Nlv0zAZd8cYvW3fRL+/5bRWlpnQ2SyUxikkPRHM8o+yz1ZIGlAYiBYTgAN7hrNJLZMBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA74643316;
	Tue, 13 May 2025 09:39:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 2/9] client: Install submenus before contacting bluez daemon
Date: Tue, 13 May 2025 11:38:12 +0200
Message-ID: <20250513093913.396876-3-hadess@hadess.net>
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

So that the submenus are installed even if bluez isn't available.
---
 client/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/client/main.c b/client/main.c
index e35e89dd2362..9efa92380663 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3403,6 +3403,11 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
+	admin_add_submenu();
+	player_add_submenu();
+	mgmt_add_submenu();
+	assistant_add_submenu();
+	hci_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	if (agent_option)
@@ -3419,15 +3424,10 @@ int main(int argc, char *argv[])
 		bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
 					(void *)endpoint_option);
 
-	admin_add_submenu();
 	admin_enable_submenu();
-	player_add_submenu();
 	player_enable_submenu();
-	mgmt_add_submenu();
 	mgmt_enable_submenu();
-	assistant_add_submenu();
 	assistant_enable_submenu();
-	hci_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
-- 
2.49.0

