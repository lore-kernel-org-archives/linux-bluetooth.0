Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627281BF3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8rhXA4d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4645C433B1;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414737;
	bh=HaGjKnQaE5oRrjuzO//sbiIK1DOk6UP981K4Mj7QLrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B8rhXA4dUvmc1Yt3DiYZMhCFky8sDe8vh4yykD3hmVou7xM9XEDGLDy44F7r0/m9X
	 456Ebr71XomeLs1zxRwdIhpEg/I3XMUTyxm5jRkwHgWNi86Om6JEXDd6rieGyNzHRs
	 T7z3SuSuvBJguLrlzTqDIxZOrAotFm3z0Nme887r9LfMXPLQs5ifxn5GEu1CyVv8Lp
	 Cxe3RGSdedmw/n2F3e3NLCI9wTnajh6GBu5m1kfDRVqrKvqSe5aR/09UOqmaxmJYkA
	 EGkUtYJIXU5ZNxhKKncNgTaLmdmdQqfvTwVOfd2KQWMjbSmGng9fzMLJgmoMAiPE/F
	 JgaC+ns/n85qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD0C47077;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:18:58 +0000
Subject: [PATCH BlueZ 6/8] bluetoothd: remove debug support for external
 plugins
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-rm-ext-plugins-v1-6-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414735; l=2192;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=fafLoCDAizTJJNOrgtnDZy+R8cR/ymoouOueLgEdSPU=;
 b=uXHogyiuOm10zo8UiUFx8oN1FqYNC6ia1emcchVEdm1fKJydj8B+h3KSqW0DAqPpGY2OIX+iz
 ujo+fbHT9UFD6H21Z91hRgpwDHZhcZWwqvYIC5aKwu3bTBGbm5cL70r
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

External plugins are gone, drop the associated debug support code.
---
 src/log.c    | 10 +++-------
 src/log.h    |  3 +--
 src/plugin.c |  2 --
 src/plugin.h |  2 --
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/src/log.c b/src/log.c
index 0155a6bba..db855d2b1 100644
--- a/src/log.c
+++ b/src/log.c
@@ -138,15 +138,11 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
 	return 0;
 }
 
-void __btd_enable_debug(struct btd_debug_desc *start,
-					struct btd_debug_desc *stop)
+void __btd_enable_debug(void)
 {
 	struct btd_debug_desc *desc;
 
-	if (start == NULL || stop == NULL)
-		return;
-
-	for (desc = start; desc < stop; desc++) {
+	for (desc = __start___debug; desc < __stop___debug; desc++) {
 		if (is_enabled(desc))
 			desc->flags |= BTD_DEBUG_FLAG_PRINT;
 	}
@@ -167,7 +163,7 @@ void __btd_log_init(const char *debug, int detach)
 	if (debug != NULL)
 		enabled = g_strsplit_set(debug, ":, ", 0);
 
-	__btd_enable_debug(__start___debug, __stop___debug);
+	__btd_enable_debug();
 
 	bt_log_open();
 
diff --git a/src/log.h b/src/log.h
index 1ed742a0d..303fb36df 100644
--- a/src/log.h
+++ b/src/log.h
@@ -36,8 +36,7 @@ struct btd_debug_desc {
 	unsigned int flags;
 } __attribute__((aligned(8)));
 
-void __btd_enable_debug(struct btd_debug_desc *start,
-					struct btd_debug_desc *stop);
+void __btd_enable_debug(void);
 
 /**
  * DBG:
diff --git a/src/plugin.c b/src/plugin.c
index 1631f201c..e3eb12c0c 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -62,8 +62,6 @@ static void add_plugin(struct bluetooth_plugin_desc *desc)
 	plugin->active = FALSE;
 	plugin->desc = desc;
 
-	__btd_enable_debug(desc->debug_start, desc->debug_stop);
-
 	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
 }
 
diff --git a/src/plugin.h b/src/plugin.h
index 7ff55e796..7a2d07b3d 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -17,8 +17,6 @@ struct bluetooth_plugin_desc {
 	int priority;
 	int (*init) (void);
 	void (*exit) (void);
-	void *debug_start;
-	void *debug_stop;
 };
 
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \

-- 
2.43.0

