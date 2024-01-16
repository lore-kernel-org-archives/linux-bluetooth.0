Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CB1BF20
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD7RzYfg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F77C41674;
	Tue, 16 Jan 2024 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413640;
	bh=ncr/8HTu9GduEUF79z9mYZHMTbDjQDdyTAeE4RZ7gJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AD7RzYfgukWXTqDXTMi/E+Gm4O88lCiDq6mbJ8IEVIxA4Rr80gyZRtph0hJfgyMLZ
	 7REsc3V7/ehyHasHDYCchAIMNJpzjT2B9yHspX97npJqtvALzK9oeD2zsR8QOANIS7
	 vUFs5w+FWtCspmEPKpjvzpcakDOelOoaroRwwgJmWfaaqXprK+UhEOo6yCR5V0PsNA
	 oWfNsPiqi4Oio/WuqYFALMY9SG4Ijru9ZJJGIcEaLb4SqVW3jQN9fuswz8VJlkellh
	 IV4Iotj46gUj8Bywg9Ph13dOiC3Uq+plCja/dRmhMpH0NIpmd+DTOSNtyW5/xb6FbA
	 iZMvIqBnQTofw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C2BC47077;
	Tue, 16 Jan 2024 14:00:40 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:45 +0000
Subject: [PATCH BlueZ 20/20] obexd: const annotate obex_plugin_desc
 entrypoint
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-20-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=2465;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=NqOjgJzWeyVBPk28dTgOSntse3r5l3o0yfOgLtILLQY=;
 b=xeyoPUXasnGeNeZ/P9F3naSPrGJAwtxNp0n5k37lCwevB+fJIkRYGYrNf6xkaWYCH+YeBf+u3
 sPqffyCUj1yBqKGbUAK+Z0lQEwRHpFBUrhqKc5LJMIgKJXIdFfqO4ic
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 obexd/src/genbuiltin | 4 ++--
 obexd/src/plugin.c   | 8 ++++----
 obexd/src/plugin.h   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/obexd/src/genbuiltin b/obexd/src/genbuiltin
index 39f773527..e60b5189a 100755
--- a/obexd/src/genbuiltin
+++ b/obexd/src/genbuiltin
@@ -2,11 +2,11 @@
 
 for i in $*
 do
-	echo "extern struct obex_plugin_desc __obex_builtin_$i;"
+	echo "extern const struct obex_plugin_desc __obex_builtin_$i;"
 done
 
 echo
-echo "static struct obex_plugin_desc *__obex_builtin[] = {"
+echo "static const struct obex_plugin_desc *__obex_builtin[] = {"
 
 for i in $*
 do
diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index 0df9d5258..a3eb24753 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -38,10 +38,10 @@ static GSList *plugins = NULL;
 
 struct obex_plugin {
 	void *handle;
-	struct obex_plugin_desc *desc;
+	const struct obex_plugin_desc *desc;
 };
 
-static gboolean add_plugin(void *handle, struct obex_plugin_desc *desc)
+static gboolean add_plugin(void *handle, const struct obex_plugin_desc *desc)
 {
 	struct obex_plugin *plugin;
 
@@ -66,7 +66,7 @@ static gboolean add_plugin(void *handle, struct obex_plugin_desc *desc)
 	return TRUE;
 }
 
-static gboolean check_plugin(struct obex_plugin_desc *desc,
+static gboolean check_plugin(const struct obex_plugin_desc *desc,
 				char **patterns, char **excludes)
 {
 	if (excludes) {
@@ -132,7 +132,7 @@ gboolean plugin_init(const char *pattern, const char *exclude)
 	}
 
 	while ((file = g_dir_read_name(dir)) != NULL) {
-		struct obex_plugin_desc *desc;
+		const struct obex_plugin_desc *desc;
 		void *handle;
 		char *filename;
 
diff --git a/obexd/src/plugin.h b/obexd/src/plugin.h
index 703878460..a91746cbc 100644
--- a/obexd/src/plugin.h
+++ b/obexd/src/plugin.h
@@ -16,14 +16,14 @@ struct obex_plugin_desc {
 
 #ifdef OBEX_PLUGIN_BUILTIN
 #define OBEX_PLUGIN_DEFINE(name, init, exit) \
-		struct obex_plugin_desc __obex_builtin_ ## name = { \
+		const struct obex_plugin_desc __obex_builtin_ ## name = { \
 			#name, init, exit \
 		};
 #else
 #define OBEX_PLUGIN_DEFINE(name,init,exit) \
 		extern struct obex_plugin_desc obex_plugin_desc \
 				__attribute__ ((visibility("default"))); \
-		struct obex_plugin_desc obex_plugin_desc = { \
+		const struct obex_plugin_desc obex_plugin_desc = { \
 			#name, init, exit \
 		};
 #endif

-- 
2.43.0

