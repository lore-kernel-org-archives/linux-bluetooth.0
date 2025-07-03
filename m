Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCB2D3A75
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533010; cv=none; b=pkOWxflVVcuxKOENm76RBlM7SJOqpz+Kr3B++SKiq8cLwEktxzoMbJed8glJWyx5wdWLf91uppSi+Fc2DD1N2BL17/XLHR8jJax8vmisD4aWzfJU0DOnEATa3MuZEfNjydn4mweTO88IxKVPhICOtaZ/yd1lQBz1LsxT4v2L5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533010; c=relaxed/simple;
	bh=mAWgkUrBVnVHPcN5fYmFRyhCo9R8ApMoDdhDW2t/69U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkaSD8ooVbYFHUarSerPiApjOj++LZgVy0Ii5vgFszZPghKZr5h1Nagdm61/4pezH7wJMvZsbfvdov9fyIj2NnSQdNPP3DQyOzG9+cv/z4Oaa8uuU68/DTo6+r9qjZAsdFXkXKCOOk4xh9Ay/padqA1BkpkPBJm/y46GtdFsMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 062F243187;
	Thu,  3 Jul 2025 08:56:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 05/19] client: Fix typos
Date: Thu,  3 Jul 2025 10:53:13 +0200
Message-ID: <20250703085630.935452-6-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 client/adv_monitor.c             | 2 +-
 client/mgmt.c                    | 6 +++---
 client/player.c                  | 2 +-
 client/scripts/scan-delegator.bt | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 29e67096018b..58f379f1bfb1 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -758,7 +758,7 @@ void adv_monitor_get_supported_info(void)
 	print_supported_list(manager.supported_features);
 	bt_shell_printf("\n");
 
-	bt_shell_printf("Supported Moniter Types:");
+	bt_shell_printf("Supported Monitor Types:");
 	print_supported_list(manager.supported_types);
 	bt_shell_printf("\n");
 }
diff --git a/client/mgmt.c b/client/mgmt.c
index 0a9cc589f09f..d07f7d8c0ea3 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -4243,7 +4243,7 @@ static void clock_info_rsp(uint8_t status, uint16_t len, const void *param,
 
 	print("Local Clock:   %u", le32_to_cpu(rp->local_clock));
 	print("Piconet Clock: %u", le32_to_cpu(rp->piconet_clock));
-	print("Accurary:      %u", le16_to_cpu(rp->accuracy));
+	print("Accuracy:      %u", le16_to_cpu(rp->accuracy));
 
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -6033,7 +6033,7 @@ static const struct bt_shell_menu mgmt_menu = {
 	{ "ssp",		"<on/off>",
 		cmd_ssp,		"Toggle SSP mode"		},
 	{ "sc",			"<on/off/only>",
-		cmd_sc,			"Toogle SC support"		},
+		cmd_sc,			"Toggle SC support"		},
 	{ "hs",			"<on/off>",
 		cmd_hs,			"Toggle HS support"		},
 	{ "le",			"<on/off>",
@@ -6095,7 +6095,7 @@ static const struct bt_shell_menu mgmt_menu = {
 	{ "ext-config",		"<on/off>",
 		cmd_ext_config,		"External configuration"	},
 	{ "debug-keys",		"<on/off>",
-		cmd_debug_keys,		"Toogle debug keys"		},
+		cmd_debug_keys,		"Toggle debug keys"		},
 	{ "conn-info",		"[-t type] <remote address>",
 		cmd_conn_info,		"Get connection information"	},
 	{ "io-cap",		"<cap>",
diff --git a/client/player.c b/client/player.c
index 2702ea54247b..e4c2d451acca 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5359,7 +5359,7 @@ static void set_links_cb(const DBusError *error, void *user_data)
 	/* Enqueue link to mark that it is ready to be selected */
 	queue_push_tail(args->selecting, link);
 
-	/* Continue setting the remanining links */
+	/* Continue setting the remaining links */
 	transport_set_links(args);
 }
 
diff --git a/client/scripts/scan-delegator.bt b/client/scripts/scan-delegator.bt
index 5ff7bcb892b4..cc2b5afc98a3 100644
--- a/client/scripts/scan-delegator.bt
+++ b/client/scripts/scan-delegator.bt
@@ -16,7 +16,7 @@ advertise on
 #
 #
 # After the connection has been established, transports will
-# be created for streams added by the Bradcast Assistant that
+# be created for streams added by the Broadcast Assistant that
 # match the audio capabilities chosen at endpoint register.
 # Select the desired transport. If the stream is encrypted,
 # a prompt will be displayed to enter the Broadacast Code for
@@ -40,4 +40,4 @@ advertise on
 #
 # Check that the transport has transitioned to "active" state
 #
-# [CHG] Transport /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m State: active
\ No newline at end of file
+# [CHG] Transport /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m State: active
-- 
2.50.0

