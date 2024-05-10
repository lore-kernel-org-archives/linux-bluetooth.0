Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F3165FD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332709; cv=none; b=Vz65sskxuKK+cDLi9fnL1vk5E170S8Hj+7PcV+MlMkTFtah3zlEoT1OV0dYVtwkWjff5MiWOCIRSdur3Lar81YQMVF7xwoeXgkTgLbYLR79eql7RMTSrPm6EXIN9hjKsFP9lJomnSw5ntS8Hr9D1HIkZF8BPrlxbWtOLyazkzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332709; c=relaxed/simple;
	bh=UVmzgHwRrHupYFJb/Xbq0QuAhlgLC7EEyPNuRozn0po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgAg4R09TNdWuMA+cxpmIdZx44DEH0Hig+WzpoPyv8UhAU4OdCmsvaFWmnwEwrzu0KUoxnBoqRJWETELMHAa6GmxHvb1mW/DcfllWOxpArzbxvh5UKXNMLpkSzGZncrb9N04lEwTj949KJYsxC4UKOEabt7KFIcpokiQPFRmpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0205A1BF214
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:17 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 13/14] client/player: Fix copy/paste error
Date: Fri, 10 May 2024 11:11:11 +0200
Message-ID: <20240510091814.3172988-14-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
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

