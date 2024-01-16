Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8E1BF22
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOBE93on"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 653A8C43390;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=cY1EFVtNLYb6BnE4vY936MpLQpP0/+KwBPVabl5ffKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EOBE93onrejdTMpfclbXdi7VLrBcHAhK+G0WSR1lQRZd2UmhB3l9tGo8RRB+tpSo7
	 u/49JaihkRlNZNclHlYyP6xo4jEgOsbQa1bUj9z4tOjGYLW4KYjsHZihW/GzNRxZ/r
	 7fIR4TTw2faDbjy1CDhwO9qLwCGL4mI1oTMFnZRev5LBuxof71jxWk0BZ8vnRT9aYf
	 harR5Q8r3TmX0GQNDrM2TUfDATskDJDAcMo8TD8WDWgqg2s2A/m7DzyVqCGUnZ10DI
	 3gdfkoR28yQhBbBFVdd62AmIo5jThT77W0hIts6DpxKYUTwlSMOhBer9Nkr7tavJb4
	 B/2/T3wz01JUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55AC47077;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:26 +0000
Subject: [PATCH BlueZ 01/20] src: const annotate the bluetooth plugin API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-1-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=3210;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=I/Oyu/RLwK0OSGqSTjaoDbqWB2lkqBZyCxJ1p08rwK0=;
 b=B4d7cr/nEAueGQRAzNE6jXDNbg/BF+MsrQJuV3PGUMU58kDpixDvokem2nLIHF1Mcshsz2RN0
 m5a2Pe0JHSuCGMXYZtL9lxOfOlTEmcCfzumhnXPLpcyHUdgLWp+/8ls
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The data was never mutable, so there's no API/ABI breakage here.
---
 src/genbuiltin | 4 ++--
 src/log.c      | 2 +-
 src/plugin.c   | 6 +++---
 src/plugin.h   | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/genbuiltin b/src/genbuiltin
index 8b6f04761..010e4ed2f 100755
--- a/src/genbuiltin
+++ b/src/genbuiltin
@@ -2,11 +2,11 @@
 
 for i in $*
 do
-	echo "extern struct bluetooth_plugin_desc __bluetooth_builtin_$i;"
+	echo "extern const struct bluetooth_plugin_desc __bluetooth_builtin_$i;"
 done
 
 echo
-echo "static struct bluetooth_plugin_desc *__bluetooth_builtin[] = {"
+echo "static const struct bluetooth_plugin_desc *__bluetooth_builtin[] = {"
 
 for i in $*
 do
diff --git a/src/log.c b/src/log.c
index 0155a6bba..ca8ae2d0e 100644
--- a/src/log.c
+++ b/src/log.c
@@ -123,7 +123,7 @@ extern struct btd_debug_desc __stop___debug[];
 
 static char **enabled = NULL;
 
-static gboolean is_enabled(struct btd_debug_desc *desc)
+static gboolean is_enabled(const struct btd_debug_desc *desc)
 {
 	int i;
 
diff --git a/src/plugin.c b/src/plugin.c
index 80990f8c3..69c4138f0 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -31,7 +31,7 @@ static GSList *plugins = NULL;
 struct bluetooth_plugin {
 	void *handle;
 	gboolean active;
-	struct bluetooth_plugin_desc *desc;
+	const struct bluetooth_plugin_desc *desc;
 };
 
 static int compare_priority(gconstpointer a, gconstpointer b)
@@ -42,7 +42,7 @@ static int compare_priority(gconstpointer a, gconstpointer b)
 	return plugin2->desc->priority - plugin1->desc->priority;
 }
 
-static gboolean add_plugin(void *handle, struct bluetooth_plugin_desc *desc)
+static gboolean add_plugin(void *handle, const struct bluetooth_plugin_desc *desc)
 {
 	struct bluetooth_plugin *plugin;
 
@@ -141,7 +141,7 @@ gboolean plugin_init(const char *enable, const char *disable)
 		goto start;
 
 	while ((file = g_dir_read_name(dir)) != NULL) {
-		struct bluetooth_plugin_desc *desc;
+		const struct bluetooth_plugin_desc *desc;
 		void *handle;
 		char *filename;
 
diff --git a/src/plugin.h b/src/plugin.h
index a5f92a557..dcf54a5bf 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -23,7 +23,7 @@ struct bluetooth_plugin_desc {
 
 #ifdef BLUETOOTH_PLUGIN_BUILTIN
 #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
-		struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \
+		const struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \
 			#name, version, priority, init, exit \
 		};
 #else
@@ -32,9 +32,9 @@ struct bluetooth_plugin_desc {
 				__attribute__ ((weak, visibility("hidden"))); \
 		extern struct btd_debug_desc __stop___debug[] \
 				__attribute__ ((weak, visibility("hidden"))); \
-		extern struct bluetooth_plugin_desc bluetooth_plugin_desc \
+		extern const struct bluetooth_plugin_desc bluetooth_plugin_desc \
 				__attribute__ ((visibility("default"))); \
-		struct bluetooth_plugin_desc bluetooth_plugin_desc = { \
+		const struct bluetooth_plugin_desc bluetooth_plugin_desc = { \
 			#name, version, priority, init, exit, \
 			__start___debug, __stop___debug \
 		};

-- 
2.43.0

