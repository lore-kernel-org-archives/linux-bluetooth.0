Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995419B3C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598462; cv=none; b=eKXDihi7wxhp7atu4+DDMejcHKGlQlndyDstGOX2IcTtkLfZXUUhmHEa8mmGZDB9/LehLgv1odR8V9cBKfCVmalfDw6lpn3aIcR9gVHHPXBu9xxKjggfD3PwpzrHssbj+zhstdlX4bCdgdEHPhPgi6q86Dw60HnpYtOT403yFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598462; c=relaxed/simple;
	bh=ejRH2MiZ1eZIklxRoMOTeEhvvwndTs9rocDCNpLyj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5Be5IviwFy+0zv/GrFVAqTI2F8t774VqRSGxmbPY5z1kTDNfaoZ6+fFiQ8LWbIug3KVIeJZvwZRAFvhAdNimd9l6dg3JBArg8UsPTgmZa+kWh1ARjVUUjr0A+um4mbNHVnlnPwWlVwHVThpchOxuLhSbRTroQLOGYEK3Tz0bIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEB2F1C0026;
	Tue, 22 Oct 2024 12:00:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 4/7] client: Install submenus before contacting bluez daemon
Date: Tue, 22 Oct 2024 13:58:34 +0200
Message-ID: <20241022120051.123888-5-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022120051.123888-1-hadess@hadess.net>
References: <20241022120051.123888-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

So that the submenus are installed even if bluez isn't available.
---
 client/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 4ae6f121d424..144e17622e95 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3187,6 +3187,10 @@ int main(int argc, char *argv[])
 	bt_shell_add_submenu(&advertise_monitor_menu);
 	bt_shell_add_submenu(&scan_menu);
 	bt_shell_add_submenu(&gatt_menu);
+	admin_add_submenu();
+	player_add_submenu();
+	mgmt_add_submenu();
+	assistant_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	if (agent_option)
@@ -3203,13 +3207,9 @@ int main(int argc, char *argv[])
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
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
-- 
2.47.0

