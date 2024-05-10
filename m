Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6A16F26E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343258; cv=none; b=sg/Oaptg5TNYOVxjRWkMOqBtAADql0j4zrcqGUIuoqg7yKQpqhaJ+Gxvbwou/DTtTaEI+qmJZ9SE2zGcHY4B1Sgmp1Nem9MgWf7N1HKcQ6Kg20gBT1BsYwpOABla9DWkoL10pTHjbZ1qv7lP5isBiFgvUY7nfUW0AqqPhHoC/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343258; c=relaxed/simple;
	bh=vEdzOFOfj6cU3KZYSAw5Qn4GRuDd16JZXvr2cYFm7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiLqOPM9OfHXTmH2LMi56h6h7fvzNCf1Ao4ZvUspL3jiRx/FsHdAQFIOlwn9tmX9RlPoPQsvIxdMUDcZilsCtaGa/vvTRkvgHa/5m1hufopIiP7NC6o57uzwRQKJ++wHG2pOQp6fn67JwRq5UikgEESQDOnUNf5nBuf/E2z8wPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC08560019;
	Fri, 10 May 2024 12:14:01 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 20/20] main: Simplify variable assignment
Date: Fri, 10 May 2024 14:10:30 +0200
Message-ID: <20240510121355.3241456-21-hadess@hadess.net>
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
 src/main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/main.c b/src/main.c
index ac840d684f6d..a31740179941 100644
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
-- 
2.44.0

