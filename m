Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34573170850
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343257; cv=none; b=W6jMsm5Ltr2sGutbn4cpV3IBao94KEaOBkWZX3LqR4ScxOSbWzDCk0zXJIPmxMUY+W7fu2jirBbgf57bE+XUD6TbqR/REbHN8nYcdKiYc+G8dUoGoF6YsGjszdFnmuSxHAVARcAWg0AdmkXQP4SDLzy3mDBrZU4XG3nQzOVs25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343257; c=relaxed/simple;
	bh=UVmzgHwRrHupYFJb/Xbq0QuAhlgLC7EEyPNuRozn0po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgx1m/Y7Neyj0D/+qKpVqSmTRIY0zA0H8D9dJki/l6yLXMdny206r2P+CDKbzC+uoPazmI0Hd9Uo/2aerm4q0sgOimSo5s2lPm+GMOImgPjcBwsrY0TMblVSf9to/ahPXBtw82GrzEub7/sonuKTx95HvRPKiueVQ59Wo9uZUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A30066000C;
	Fri, 10 May 2024 12:13:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 13/20] client/player: Fix copy/paste error
Date: Fri, 10 May 2024 14:10:23 +0200
Message-ID: <20240510121355.3241456-14-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: COPY_PASTE_ERROR (CWE-398): [#def95] [important]
bluez-5.75/client/player.c:1846:6: original: "qos->sync_cte_type" looks like the original copy.
bluez-5.75/client/player.c:1852:6: copy_paste_error: "sync_cte_type" in "qos->sync_cte_type" looks like a copy-paste error.
bluez-5.75/client/player.c:1852:6: remediation: Should it say "mse" instead?
1850|		}
1851|
1852|->		if (qos->sync_cte_type) {
1853|			bt_shell_printf("MSE %u\n", qos->mse);
1854|			g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 6b70e9ed3f9d..7f67425aaf8f 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1849,7 +1849,7 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 					&qos->sync_cte_type);
 	}
 
-	if (qos->sync_cte_type) {
+	if (qos->mse) {
 		bt_shell_printf("MSE %u\n", qos->mse);
 		g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
 						&qos->mse);
-- 
2.44.0

