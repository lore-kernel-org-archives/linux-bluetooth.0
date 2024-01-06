Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83CF4F8
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jan 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willowbarraco.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willowbarraco.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willowbarraco.fr header.i=@willowbarraco.fr header.b="j5GKYxQ6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willowbarraco.fr;
	s=key1; t=1704572968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=71sKIPr9fv1bVl0DoM2vKNgk3xAsrZjltCuYEbdD/js=;
	b=j5GKYxQ6it36HrQbz0WLsBJpXzsDfV0MC2zxQEKbRL+U+ew9iyLnQc6Nw0SJ3bRCvSaUm7
	koac4JJ4aYtfVs7CzPI9DWnz+oWgTC+RE5whvgasn7XU/Neaqgcy5I3cwyxFCscF4A6nZW
	WuTcERecL8U7fPGzXCrY7Mika+V5mY1lnPHpANHMcVmV7qLA0f0ljet4Id+mZY6sCQUazY
	i8/DFz7WRpmC67zwCR1z2GzildGW27BHLpnACaSwO2znx43PL1elvDHGYTUQSaqxjhwvB+
	zBR0kcqDsxSw7RJS6jb0xOH9da/+nS+l2MMGkH18ntT2MTE7v7DxRngK54nztA==
From: Willow Barraco <contact@willowbarraco.fr>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mpris-proxy: add --target to target a specific player
Date: Sat,  6 Jan 2024 21:28:42 +0100
Message-ID: <20240106202926.8106-2-contact@willowbarraco.fr>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fixes: https://github.com/bluez/bluez/issues/709

Signed-off-by: Willow Barraco <contact@willowbarraco.fr>
---
 tools/mpris-proxy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e5fc91fdb..c7a22c121 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -53,6 +53,7 @@ static GSList *transports = NULL;
 
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
+static gchar *option_target = NULL;
 
 struct tracklist {
 	GDBusProxy *proxy;
@@ -428,6 +429,11 @@ static void add_player(DBusConnection *conn, const char *name,
 	if (!adapter)
 		return;
 
+	if (option_target && strcmp(name, option_target)) {
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

