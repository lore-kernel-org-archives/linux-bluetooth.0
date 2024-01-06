Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44BF9D1
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jan 2024 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willowbarraco.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willowbarraco.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willowbarraco.fr header.i=@willowbarraco.fr header.b="hV/FbFdh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willowbarraco.fr;
	s=key1; t=1704579388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JAc7QQqhNz5Zj4cb12lhuRYai8jctwBOa1xN96v+y/0=;
	b=hV/FbFdhohMWQOxdH17Riryy77P3Tks2K5L+hx+RvSusPZWJRJt55WfpjOcqXcsrDxJxi9
	cBU2oR2FOxYq092yfd1EEfV9ZsoqE5UI5VZViuumba2Sjyfyx5LiAofbm/wocMw4IaNbwx
	GX7BMnF8wjhN70Tp19Gu3jv2BW1kZIyp9/XQ1R1EbF5L4+k1EtW0ZtYf3DqrhTi2wiqLUK
	mnxJ1lAV9ZqBgxqaxTjXmI4Gws2ENTZ8lc3+2QuKX5HD9J5VBMPUruzkorTcFNQJx3W/8+
	1xkyuO29/21oT32AuoFGUAAxX222lcNR2rxxpR3UOpaOB9SQVpNfmoRydSY74w==
From: Willow Barraco <contact@willowbarraco.fr>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] mpris-proxy: add --target to target a specific player
Date: Sat,  6 Jan 2024 23:15:47 +0100
Message-ID: <20240106221626.8140-2-contact@willowbarraco.fr>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Willow Barraco <contact@willowbarraco.fr>
---
v2: Fix CI warning
 tools/mpris-proxy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e5fc91fdb..dc328031b 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -53,6 +53,7 @@ static GSList *transports = NULL;
 
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
+static gchar *option_target = "";
 
 struct tracklist {
 	GDBusProxy *proxy;
@@ -428,6 +429,11 @@ static void add_player(DBusConnection *conn, const char *name,
 	if (!adapter)
 		return;
 
+	if (strcmp(option_target, "") && strcmp(name, option_target)) {
+		printf("Not the target player, skipped\n");
+		return;
+	}
+
 	player = find_player_by_bus_name(name);
 	if (player == NULL) {
 		reply = get_all(conn, name);
@@ -733,6 +739,8 @@ static GOptionEntry options[] = {
 				"Show version information and exit" },
 	{ "export", 'e', 0, G_OPTION_ARG_NONE, &option_export,
 				"Export remote players" },
+	{ "target", 't', 0, G_OPTION_ARG_STRING, &option_target,
+				"Target a specific player" },
 	{ NULL },
 };
 
-- 
2.43.0

