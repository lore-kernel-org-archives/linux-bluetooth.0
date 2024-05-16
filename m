Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32938142E94
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=C5JE6EucNTatLTbNQDnREZ1HpmcbEh56Iw3MV1pCu3Rtv/K2ksNIrh8SS9o+Vgb0J6H5mgAyFwblEwU6Ta+wm5vVLJk1pPW53E4TmdT6hrXNUihIF1ansu1J12P2SZgEsG5kDE0wzg4nCilh50T22YP/1+erjvxU5XnZh9eOYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=gH4GoI2T/j0yiZYxFEnxRxCV+ZsffcBK9aBmxKu8sJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khfXItFMgJYcp43u0rMwiGOEPjbFjhuWw0wKpCxcTiZl/FeEcGa2s1vcWtPOiM/t4kCOeWHQPno55xAfWOF0F3/FfVbeaTaJuZO8R+W5RMk2o2qviZ4gimKzw3Uiz1WBaWLVdO1IwBLibE2LYukJwSWHF/h+9w1XvK3beLpSDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 466171C000D;
	Thu, 16 May 2024 09:03:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 01/15] main: Simplify variable assignment
Date: Thu, 16 May 2024 11:03:05 +0200
Message-ID: <20240516090340.61417-2-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
bluez-5.75/src/main.c:425:2: alloc_fn: Storage is returned from allocation function "g_key_file_get_string".
bluez-5.75/src/main.c:425:2: var_assign: Assigning: "tmp" = storage returned from "g_key_file_get_string(config, group, key, &err)".
bluez-5.75/src/main.c:433:2: noescape: Assuming resource "tmp" is not freed or pointed-to as ellipsis argument to "btd_debug".
bluez-5.75/src/main.c:440:2: leaked_storage: Variable "tmp" going out of scope leaks the storage it points to.
438|	}
439|
440|->	return true;
441|   }
442|
---
 src/main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/main.c b/src/main.c
index ac840d684f6d..f6369a20d879 100644
--- a/src/main.c
+++ b/src/main.c
@@ -420,9 +420,10 @@ static bool parse_config_string(GKeyFile *config, const char *group,
 					const char *key, char **val)
 {
 	GError *err = NULL;
-	char *tmp;
 
-	tmp = g_key_file_get_string(config, group, key, &err);
+	g_return_val_if_fail(val, false);
+
+	*val = g_key_file_get_string(config, group, key, &err);
 	if (err) {
 		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
 			DBG("%s", err->message);
@@ -430,12 +431,7 @@ static bool parse_config_string(GKeyFile *config, const char *group,
 		return false;
 	}
 
-	DBG("%s.%s = %s", group, key, tmp);
-
-	if (val) {
-		g_free(*val);
-		*val = tmp;
-	}
+	DBG("%s.%s = %s", group, key, *val);
 
 	return true;
 }
@@ -1005,7 +1001,12 @@ static void parse_secure_conns(GKeyFile *config)
 
 static void parse_general(GKeyFile *config)
 {
-	parse_config_string(config, "General", "Name", &btd_opts.name);
+	char *str = NULL;
+
+	if (parse_config_string(config, "General", "Name", &str)) {
+		g_free(btd_opts.name);
+		btd_opts.name = str;
+	}
 	parse_config_hex(config, "General", "Class", &btd_opts.class);
 	parse_config_u32(config, "General", "DiscoverableTimeout",
 						&btd_opts.discovto,
-- 
2.44.0

