Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C501BDDB
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IflnjvBu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD66CC43330;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=C/GsgVYTO24HtdUD7Qa68p2BDP9gQb9IsuNnwC5g/I4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IflnjvBuooE0bhvtaCqRWx+gp/zeCru6pbnUVmtrSYAWKtU1UJqko1eOTgyRNS2oA
	 8QIPjDQCgBYYAsDND6KpWrWYV30Wr6lvUQHa2UgLI/1qE5/1+skG95D/JguykFHDJ/
	 eMV2i+OqrVWBre3CmoP75t0FmwZEsRvudFpUvsPpCqr9SpxNn56/5FHoqoVSnftwlo
	 Xz4+vPc2KmOJeuG09FR98wu3aH6bSw+qxi35dPCydslcbhxdpXyJ/q+I3HkImXZUs+
	 2O5hPAl8boz6WCgAmli9HUHb3rsGel1APrv4kZxaiuooGygBf/Z6eBxx302/t4Mv6m
	 PRb2//ZpIi54g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D73FC47DA9;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:00:33 +0000
Subject: [PATCH BlueZ 08/20] attrib: annotate immutable data as const
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-const-v1-8-17c87978f40b@gmail.com>
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=2060;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=r4UogXNZcqpBuo7KQeXLw6rUdfC5zty52k+yB4yl1Y0=;
 b=mcb7UxZAS4sKzhr8clOsa8yzBMZk2BwF27jvxTI5K8j3tC/6Wgv1EI5UQnd75d/catNnLTzad
 FKDbyDo5gtyB8i22pOqv89O7cIbPK4PnN/t01btFwkVOaq8KqxZTUeY
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 attrib/gatttool.c    | 8 ++++----
 attrib/interactive.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 2d03875b0..4309d20b1 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -454,7 +454,7 @@ static gboolean parse_uuid(const char *key, const char *value,
 	return TRUE;
 }
 
-static GOptionEntry primary_char_options[] = {
+static const GOptionEntry primary_char_options[] = {
 	{ "start", 's' , 0, G_OPTION_ARG_INT, &opt_start,
 		"Starting handle (optional)", "0x0001" },
 	{ "end", 'e' , 0, G_OPTION_ARG_INT, &opt_end,
@@ -464,7 +464,7 @@ static GOptionEntry primary_char_options[] = {
 	{ NULL },
 };
 
-static GOptionEntry char_rw_options[] = {
+static const GOptionEntry char_rw_options[] = {
 	{ "handle", 'a' , 0, G_OPTION_ARG_INT, &opt_handle,
 		"Read/Write characteristic by handle (required)", "0x0001" },
 	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
@@ -473,7 +473,7 @@ static GOptionEntry char_rw_options[] = {
 	{NULL},
 };
 
-static GOptionEntry gatt_options[] = {
+static const GOptionEntry gatt_options[] = {
 	{ "primary", 0, 0, G_OPTION_ARG_NONE, &opt_primary,
 		"Primary Service Discovery", NULL },
 	{ "characteristics", 0, 0, G_OPTION_ARG_NONE, &opt_characteristics,
@@ -494,7 +494,7 @@ static GOptionEntry gatt_options[] = {
 	{ NULL },
 };
 
-static GOptionEntry options[] = {
+static const GOptionEntry options[] = {
 	{ "adapter", 'i', 0, G_OPTION_ARG_STRING, &opt_src,
 		"Specify local adapter interface", "hciX" },
 	{ "device", 'b', 0, G_OPTION_ARG_STRING, &opt_dst,
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 171b95738..c0262e87c 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -760,7 +760,7 @@ static void cmd_mtu(int argcp, char **argvp)
 	gatt_exchange_mtu(attrib, opt_mtu, exchange_mtu_cb, NULL);
 }
 
-static struct {
+static const struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
 	const char *params;

-- 
2.43.0

