Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0C1BFE01
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925868; cv=none; b=k4Ai2rB6wxkl9ensQDKXDbtx8Kc2eSKOLt/Sp2yyuHDizVDQsK2PpLApdhe+vlnXAqIbfWe8oRL65wekETHbn8noOrO1NoGpxewNhm37tzQYcH2roCe3VHNmjmLa+raFi7h3cjjMGxKovX9kvphfgWWNveu5pmbOk329SgEcuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925868; c=relaxed/simple;
	bh=NQycc6rXYYDiEqgPkJi5ivzooFBsQxGTti8OFF4BafY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GHsIJEL5EQ5k8L1psrPWV5Yg577F5I6qTf7cCJXGxcLLpexZThxf09I3rUagGEyJCZ57JVOqt0hebP8Uh90oGATP/CTiYAgIaxQ1dPOTnKUKDkSVmNmzd4mq+Xb7yNec1wMtBu3gsIJiKlRgXu9LRMDvXtXSGps7ZDstZH52NAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RTBsvw7f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RTBsvw7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728925863;
	bh=NQycc6rXYYDiEqgPkJi5ivzooFBsQxGTti8OFF4BafY=;
	h=From:To:Subject:Date:From;
	b=RTBsvw7fCZd3EI+DC+fWYxvOpTR16NPeTAgr1daPZXqhqtw21yLVsP538k5w9zUV5
	 7QM/YXVAoikhVcWYPW4v6DG3d4N4FRy3P5jBqa/vPIna2op2suEtiX7ixk8NFCIixD
	 9ZgVulT0zGd4JDB4/Bs0SMD0Q63msq/b5K/C5f8nJ3zGjRSoxoUNciOSHZoPDJxRpv
	 S7g5cMQrYa63tWpw7o4b5RfcR6pMaS408cmOucYuy8rawpO95YJ/tLNMAC71ZAOZQR
	 Qr9U2NSopa3wnbdoouIGrm7m5QwM+feN6eNXH99tQ36EHy00B5ZqgvSwWChpvu1XVq
	 4Uh/cj4AjMyaw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 718FD17E3638
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 19:11:03 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] tools/obexctl: Add support to connect using PSM port
Date: Mon, 14 Oct 2024 19:10:58 +0200
Message-Id: <20241014171058.75235-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Since commit 5d7d3ac25bd5 ("obexd: Add PSM support to session create")
obexd supports to connect the session using a L2CAP PSM.
---
 tools/obexctl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 56a76915c..c3db11b67 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -114,7 +114,7 @@ static void connect_reply(DBusMessage *message, void *user_data)
 struct connect_args {
 	char *dev;
 	char *target;
-	uint8_t channel;
+	uint16_t channel;
 };
 
 static void connect_args_free(void *data)
@@ -144,9 +144,14 @@ static void connect_setup(DBusMessageIter *iter, void *user_data)
 		g_dbus_dict_append_entry(&dict, "Target",
 					DBUS_TYPE_STRING, &args->target);
 
-	if (args->channel)
-		g_dbus_dict_append_entry(&dict, "Channel",
+	if (args->channel) {
+		if (args->channel > 31)
+			g_dbus_dict_append_entry(&dict, "PSM",
+					DBUS_TYPE_UINT16, &args->channel);
+		else
+			g_dbus_dict_append_entry(&dict, "Channel",
 					DBUS_TYPE_BYTE, &args->channel);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -169,8 +174,8 @@ static void cmd_connect(int argc, char *argv[])
 		char *endptr = NULL;
 
 		channel = strtol(argv[3], &endptr, 0);
-		if (!endptr || *endptr != '\0' || channel > UINT8_MAX) {
-			bt_shell_printf("Invalid channel\n");
+		if (!endptr || *endptr != '\0' || channel > UINT16_MAX) {
+			bt_shell_printf("Invalid channel or PSM\n");
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -1846,7 +1851,7 @@ static void cmd_mkdir(int argc, char *argv[])
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
-	{ "connect",      "<dev> [uuid] [channel]", cmd_connect,
+	{ "connect",      "<dev> [uuid] [channel|PSM]", cmd_connect,
 						"Connect session" },
 	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session",
 						session_generator },
-- 
2.34.1

