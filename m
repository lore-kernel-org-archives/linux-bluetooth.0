Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FF190675
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132978; cv=none; b=qs1yR/MuWAW+pnR5TkSEYUxEjK9lqUWnPjfbUu7DNL7NrUJfpzCmMlvYUmJEHz7SoV/DE1em9QjqjWSUsa9U90n8FEHB9aSHlv122DT97jLIhAt9T/t5PTtASzku+EUMUgoZmDu9VdRkNjeyfP0QYBHpOf+BtNEWSomze1ng7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132978; c=relaxed/simple;
	bh=mqvZER0IR3Z6x9XwA8EbbbUqz6rU9qlsiP0zPZU/uHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2HqlijcbRsawRRX6r+8N3i9rcKMydM4rvsKZIrHCR8g5nbVnQnfBfZtrZtPpHzJelZpY7oEsup9q+Vp3THFPv8gbsUl7a2Q5/ZkWuZK/rWH036akVYCDDKxX5pFnxtUJKlQ1X5CKO3t4H+RsMctdpjOnbLk8OW/XFGwIdwsb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D382920010;
	Thu, 12 Sep 2024 09:22:54 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 2/3] client: Respect --timeout when bluetoothd isn't running
Date: Thu, 12 Sep 2024 11:20:11 +0200
Message-ID: <20240912092253.119754-3-hadess@hadess.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912092253.119754-1-hadess@hadess.net>
References: <20240912092253.119754-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Exit after <timeout> seconds if bluetoothd isn't available. This
functionality is useful for non-interactive uses of bluetoothctl.
---
 client/main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index a96a4263849d..8791466e49ff 100644
--- a/client/main.c
+++ b/client/main.c
@@ -22,7 +22,9 @@
 
 #include <glib.h>
 
+#include "src/shared/mainloop.h"
 #include "src/shared/shell.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "src/shared/ad.h"
 #include "gdbus/gdbus.h"
@@ -3173,13 +3175,25 @@ static const struct bt_shell_opt opt = {
 
 static void client_ready(GDBusClient *client, void *user_data)
 {
+	unsigned int *timeout_id = user_data;
+
+	if (*timeout_id > 0)
+		timeout_remove(*timeout_id);
 	setup_standard_input();
 }
 
+static bool timeout_quit(void *user_data)
+{
+	mainloop_exit_failure();
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
 	int status;
+	int timeout;
+	unsigned int timeout_id;
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
@@ -3217,8 +3231,11 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
 
-	g_dbus_client_set_ready_watch(client, client_ready, NULL);
-
+	timeout = bt_shell_get_timeout();
+	timeout_id = 0;
+	if (timeout > 0)
+		timeout_id = timeout_add(timeout * 1000, timeout_quit, NULL, NULL);
+	g_dbus_client_set_ready_watch(client, client_ready, &timeout_id);
 	status = bt_shell_run();
 
 	admin_remove_submenu();
-- 
2.46.0

