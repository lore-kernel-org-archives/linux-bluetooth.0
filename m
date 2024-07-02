Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AC146D65
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910150; cv=none; b=Ux1n9pFUZBed6DMGSmd2eqRbHEzAxNjMVKfrLrKxIo/h1tCs7CwSzdyPUR5uxcCdcwQuai9NvIFDm43Mh/KC9WZEhTCIumvAEV5yJR8UKzhPkSFNC2TH2QXyOE3OyFVgdCgAYQGonYFYgZEEt8bhe4+PstwPVvSLVQcKdT3Wm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910150; c=relaxed/simple;
	bh=SygPxPvYyqAKNBGu+ImyRhBldapxXCSzpjOLb0s9Gxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnsxDaEB7ENSr76/QIyjFIqqb8TLgMle1CZTkCrq1yD5R7bVWYPxNxGxO6ufCchzqzeCSeaeR7LQKPQ14eR10yRHWzkuPYMtk668VdT3kchlF/c/KXgPIF0oZjMD3zzly5u20ab4IDB8FRPa80gpUpid8Y5/XotBZ8MjjxXTDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28257E0004;
	Tue,  2 Jul 2024 08:49:01 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/9] main: Simplify parse_config_string()
Date: Tue,  2 Jul 2024 10:47:16 +0200
Message-ID: <20240702084900.773620-2-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084900.773620-1-hadess@hadess.net>
References: <20240702084900.773620-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

The memory management done by parse_config_string() was quite
complicated, as it expected to be able to free the value in the return
variable if it was already allocated.

That particular behaviour was only used for a single variable which was
set to its default value during startup and might be overwritten after
this function call.

Use an intermediate variable to check whether we need to free
btd_opts.name and simplify parse_config_string().

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
index 62453bffaf57..9db8d7000490 100644
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
@@ -1004,7 +1000,12 @@ static void parse_secure_conns(GKeyFile *config)
 
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
2.45.2

