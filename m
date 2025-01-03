Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5A1FA259
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jan 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909126; cv=none; b=L2n8GHEAvQRbyc1V/9PnXVJPjVmTxEAO7PHZZUkeAuDe/E9xDdaCiFOLFVSQ5iWc0zJBgc81RV4ZA/WmEdKz8pEDKAWv5sMRuiG322gj0MYRosEXRntOINrB+veCTWBudcvfVlnxupOTvZXos/+Gf2GOtruvkyWBWWvR8HCpfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909126; c=relaxed/simple;
	bh=Bpr8Ay5o9PYOzvHmKzyCanmxiFAI0XfbRfq5FldE6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDnTRaX7BxWg8SppveRRLwzuK5HVy40Of1SIlxLP5tdWqoARknxwQjlP+kmFIsTBkJ6dLPh8JKIZHoYRtWyOpBS3DmVuTbTpPngbKJVyLilKR6Oph1qeYfzBzEB5jIyZLlcxLbON2Az1ztJThr+MOQl5KWl/Wi3yPFEsWJugJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSo3brN1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSo3brN1"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso5710347fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jan 2025 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735909124; x=1736513924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCKCrsAfdA0CEvMsLZZl7v1GTc7dP+bHu9+3CI8AdE4=;
        b=TSo3brN198vmCRJBi2uOiz8t2rsHMtk9mDu/IVU7vDVmpqVjsUo8uS61iwpLTSzjhn
         XAIJpyZFeIMjbcDxKpfFmzALmcXVwCoUYNfuHyAQKcYxnvKTDXtcIIg0kGeO9Hadibvh
         uJdr8vvU2BhMKSYIZQrpnJ6IdGfJgiROa3KEQm9RIjiNug60crE6oCSrrCg9UnfAosyg
         YtKLCYqjNmo6uP6BBZFF14UmdGwAJB1WHvSwkKEYzaVOj14JRU9F98PtDkpAwfv/oxog
         krCuiyCWYNbjyXsFHg2qeH0ouOwEDlUOAqy5ARvqqY2Cm4+DY2rQKfPgQZcgiuFBW4v9
         REaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909124; x=1736513924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCKCrsAfdA0CEvMsLZZl7v1GTc7dP+bHu9+3CI8AdE4=;
        b=rsJZ5h1gvztdKtNiLrOMv/BP3/SHHmaQrJO2hurB7EpzGihvNIJzWY65D0bAV1CCR1
         N7MpiRrPehoTHSQSF6kJJqp/Mejt/ufhKnFlppKw0ewqbcXp8zhvldh/+ixN0XCb4t5R
         Bc9BwyFpW5iQ15B7PKfAsyAp31+GuSOPKHnZOh/Ujn6PUFnB/JyyP/UDrELn4vkQ8JEy
         PlE3CEDfUD1kFaHzHTbA2mjUcZWX8YS0h1llUNn5J0fK5ZBRpeeAQhjjKeWt/ZT6XgK9
         ngLuV4o6HozALn/WEhOb8QYETiSUMR5hmXEokWTfcd1TagvJO2jKvfwu1KBaizAOKIDC
         XK9g==
X-Gm-Message-State: AOJu0Yyq7r9BJaqMwBmaxbsbNdMFen2OqKK4POafTMlr02Y7iJ/bHrMl
	E+LifRiTvblxnTS0dhBnBE9Ku41D7bqWqf/pbN7cj2Sp+V3JLHLH7xpg8oCi
X-Gm-Gg: ASbGncujaSycOiayOUtMzkBO6rYXZdIc1tZvX67mHSiuYrn+pShEZY3GbxxIHe85nCX
	W6Ik0phXREAIG1r8zPxZWWR8RbsqJezsm5zqgWyyflMGsSTMxL8gAJTXafI7aO4A1UxRht4F1LS
	2jmmfup/GBWZWIsxJ34wl3r2r20EsR+72nWKNjqjUgzvp9EDV1c3bTepz6Nz868JrWH7mzggg2v
	NPs7nugjb25H+5Koi5d6pQVyKk84x7YAHmwmeosv60XVcF2G7c4kNLBdb5RjZHzvL7Q07ElWkv0
	s/crItjqqcnJpJ+wb5QwYkU=
X-Google-Smtp-Source: AGHT+IG+CotdjldtfEkRlD/VTw0/xIVSpKbO5F1njt9nHmCt+Od04iu8hVY/yk8n4in34vgGtageUw==
X-Received: by 2002:a05:6871:42c9:b0:29e:62a6:ddb with SMTP id 586e51a60fabf-2a7fb08cf80mr22882026fac.16.1735909123692;
        Fri, 03 Jan 2025 04:58:43 -0800 (PST)
Received: from localhost.localdomain (ip174-69-128-121.br.br.cox.net. [174.69.128.121])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db74e8e3sm7728467eaf.35.2025.01.03.04.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:58:43 -0800 (PST)
From: Blaise Duszynski <blaised@gmail.com>
X-Google-Original-From: Blaise Duszynski <BlaiseD@GMail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Blaise Duszynski <BlaiseD@GMail.com>
Subject: [PATCH BlueZ v2] plugin: Order plugin init by priority
Date: Fri,  3 Jan 2025 06:55:32 -0600
Message-ID: <20250103125833.58396-1-BlaiseD@GMail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The init order matters for some plugins, e.g. wiimote
Add them to a sorted list before calling add_plugin
---
Cast has been removed and add_plugin is adjusted for g_slist_foreach

 src/plugin.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index 00d3d7b6a..a566bd2f4 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -37,10 +37,10 @@ struct bluetooth_plugin {
 
 static int compare_priority(gconstpointer a, gconstpointer b)
 {
-	const struct bluetooth_plugin *plugin1 = a;
-	const struct bluetooth_plugin *plugin2 = b;
+	const struct bluetooth_plugin_desc *plugin1 = a;
+	const struct bluetooth_plugin_desc *plugin2 = b;
 
-	return plugin2->desc->priority - plugin1->desc->priority;
+	return plugin2->priority - plugin1->priority;
 }
 
 static int init_plugin(const struct bluetooth_plugin_desc *desc)
@@ -86,14 +86,15 @@ static gboolean add_external_plugin(void *handle,
 
 	__btd_enable_debug(desc->debug_start, desc->debug_stop);
 
-	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	plugins = g_slist_append(plugins, plugin);
 	DBG("Plugin %s loaded", desc->name);
 
 	return TRUE;
 }
 
-static void add_plugin(const struct bluetooth_plugin_desc *desc)
+static void add_plugin(void *data, void *user_data)
 {
+	struct bluetooth_plugin_desc *desc = data;
 	struct bluetooth_plugin *plugin;
 
 	DBG("Loading %s plugin", desc->name);
@@ -109,7 +110,7 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
 		return;
 	}
 
-	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	plugins = g_slist_append(plugins, plugin);
 	DBG("Plugin %s loaded", desc->name);
 }
 
@@ -201,6 +202,7 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 
 void plugin_init(const char *enable, const char *disable)
 {
+	GSList *builtins = NULL;
 	char **cli_disabled = NULL;
 	char **cli_enabled = NULL;
 	unsigned int i;
@@ -222,12 +224,16 @@ void plugin_init(const char *enable, const char *disable)
 								cli_disabled))
 			continue;
 
-		add_plugin(__bluetooth_builtin[i]);
+		builtins = g_slist_insert_sorted(builtins,
+			(void *) __bluetooth_builtin[i], compare_priority);
 	}
 
+	g_slist_foreach(builtins, add_plugin, NULL);
+
 	if IS_ENABLED(EXTERNAL_PLUGINS)
 		external_plugin_init(cli_enabled, cli_disabled);
 
+	g_slist_free(builtins);
 	g_strfreev(cli_enabled);
 	g_strfreev(cli_disabled);
 }
-- 
2.47.1

