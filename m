Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D1158D80
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jan 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871954; cv=none; b=CI0fmYRhXNGMPvPKsc+3IWDgVWG/6F0Yeo9M+Nh5r9TBIOfz6FNufxWW4aLMig5A73xjzV/9KRltPpifqIvALFfTu9mKNgNsLG5J+6mAcbe2fHjE/2XqdY12Q0508oi06WBnTmRBFeGJnLbFyGmnMrRhjjneCBpUF4fzhiEvlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871954; c=relaxed/simple;
	bh=4hFXu8Huk/kjbH67Anbe0jKhW8fMpPYIptavJwWzhJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EljB0OfgYxBZsHu0sGwkhKuT530EKXCTMzAZN8m/a8wpt+u9tIw/7VvcIBhWjfZxoeVAivIFb9VJyQwL3kkKc1RAx4qqucBvWjh+LtfH6qdlDkqrHS1ONRyyqM2RDCdOjZd3lRZmGXwHX3+eUQdqq98Trh5in9v70DLdMsXZorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZvvfRNv; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZvvfRNv"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eba0f09c3aso4007269b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2025 18:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735871952; x=1736476752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3KHne/Q5NTQ0UmweggjEiX+rrRlMypPs34+SbWOQQI=;
        b=aZvvfRNvGlFTPUo3O32PCbi1V/ZlG7o9MZhU57XhywsKfkbuH65Ni0LrsAXfccf8Jj
         fELnbTJEuF89ZBa6jK62S1diSksuSGfbfMbdkH4os1/jDelOybG30POmC0wNnghpP+wl
         /N93rNMnGTKxSIKEMAo9axqo2+9vFDvuTaTgDwJwUH/RFfrZg/apoUODxqu87oONtnbS
         muYVgcS9T2UX5TQQoRuHLg7ymMrwDWl4UC/PLNND6gIquvKyNjouPIwBYXyjm/pvUS2M
         za7m+HBQrcwQd8R+CagpOT1j4FRbj5uDhvi3Ynf+IxAaJihf6A16/3mrDYVO0xNLPP5p
         OaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735871952; x=1736476752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3KHne/Q5NTQ0UmweggjEiX+rrRlMypPs34+SbWOQQI=;
        b=aT9ack0b2FfxAacgRckoNDDIh7v9ee35T40cdYLqfb5QDh7yqe2S7U1M6pGQNBd9IV
         IB44CHYV68OtvltL53Wr2qinyYq7Twc+0M/YBJ6kt4z1LQ81NX1tIH4jV2tqmZksRldn
         SQEViPz5wiz+z4KyQ6QLEbvOjVDDitUyM5LHjwTcNtrKZGfIi+Oygc/sWXmJ00dQ+NgI
         JbszLn1yJPLwHRZdvS4RYG2jzXRk4ps5VgQaNhke7Jelk2QUv34jqFDscdRdCO1ncamK
         exbIMeoxfw/gn3yDrdwEAs7S2eic0tuyJ75zPUIQXPK+P61X/gpIBv/Ad2GqXsbq3k4v
         ldjQ==
X-Gm-Message-State: AOJu0YzcCH+U5gWe2nC5E+meQfdZW31HjNwNyr8LtGznujeUcfrf/BBr
	uQzAYMyEY2noaEGVcxWOIcOLEotUBsTQ/v7/bGB3s7p2S5Uof0JqlBEBxZfB
X-Gm-Gg: ASbGncuwoonrBJVcQDReAMRqBQamqfgv2CgvN0ZNkFsUrL2S40poRlUeXMZGTyFf7Dd
	MYYXqRKa+Pxj0T/q9szb1JrVmLH+uSnKOAPefSwoWZkyYaUtjWlEEKjC1Kw28pSRycCB0H0pTG7
	H4gG7JJRnHCUlTQCuJdUaS+iT8nJRFG+bA0XqZCM4jU7gd0NGQlI8L+r1tx5lPcG30hwlFwcLm+
	3HspJrlEcZcinJY7Lvxq6T77l8RxDyEQOx+HGcRHLOp3uHD+7dH7pCv5Q8bc1oa4k8df8NrllR3
	uUYGoQpP+GINsvHPZw0h0pI=
X-Google-Smtp-Source: AGHT+IEi0ap6xqZMXiR5meu7G2oToZAFOCGzqeXrQQA5XVbEr3ysdv6+UcgSj27m34YZIEA7AthAuw==
X-Received: by 2002:a05:6808:1887:b0:3eb:619f:1a87 with SMTP id 5614622812f47-3ed890a93e9mr28942918b6e.28.1735871952073;
        Thu, 02 Jan 2025 18:39:12 -0800 (PST)
Received: from localhost.localdomain (ip174-69-128-121.br.br.cox.net. [174.69.128.121])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc97cddc3sm8023118a34.29.2025.01.02.18.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 18:39:11 -0800 (PST)
From: Blaise Duszynski <blaised@gmail.com>
X-Google-Original-From: Blaise Duszynski <BlaiseD@GMail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Blaise Duszynski <BlaiseD@GMail.com>
Subject: [PATCH BlueZ] plugin: Order plugin init by priority
Date: Thu,  2 Jan 2025 20:37:08 -0600
Message-ID: <20250103023708.554604-1-BlaiseD@GMail.com>
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
 src/plugin.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index 00d3d7b6a..137b191c8 100644
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
@@ -86,7 +86,7 @@ static gboolean add_external_plugin(void *handle,
 
 	__btd_enable_debug(desc->debug_start, desc->debug_stop);
 
-	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	plugins = g_slist_append(plugins, plugin);
 	DBG("Plugin %s loaded", desc->name);
 
 	return TRUE;
@@ -109,7 +109,7 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
 		return;
 	}
 
-	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
+	plugins = g_slist_append(plugins, plugin);
 	DBG("Plugin %s loaded", desc->name);
 }
 
@@ -201,6 +201,7 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
 
 void plugin_init(const char *enable, const char *disable)
 {
+	GSList *builtins = NULL;
 	char **cli_disabled = NULL;
 	char **cli_enabled = NULL;
 	unsigned int i;
@@ -222,12 +223,16 @@ void plugin_init(const char *enable, const char *disable)
 								cli_disabled))
 			continue;
 
-		add_plugin(__bluetooth_builtin[i]);
+		builtins = g_slist_insert_sorted(builtins,
+			(void *) __bluetooth_builtin[i], compare_priority);
 	}
 
+	g_slist_foreach(builtins, (GFunc) add_plugin, NULL);
+
 	if IS_ENABLED(EXTERNAL_PLUGINS)
 		external_plugin_init(cli_enabled, cli_disabled);
 
+	g_slist_free(builtins);
 	g_strfreev(cli_enabled);
 	g_strfreev(cli_disabled);
 }
-- 
2.47.1

