Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC01AAE02
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919350; cv=none; b=TO4ibuSbczjNR0cFtP8uP4Fw9C/eKb+LJzlr5ECfqze/7OexY9MvGWb5CZjdUSXLuuBzLLZAwbiFw4W6GrDJp7dGxX3+WidqiMFp/W4DsD2CHT7Kr4q48WGUjR7I8plTkVpe4wNCkZ5AUNpVCRSoaNY7vun60UTZr7zBi4KbKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919350; c=relaxed/simple;
	bh=E6oq2yfjMtwqMzR04MRXeShcM1pOwofotTGEl6KhoUI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PYY3tgT68Lt0FAME58NkOz2cVLQzLk3nElF2O3HN83rwCw+YIluzR4L4DH5LWnTEAMuz69YwJnmO7X4mzxw3bw4XRF60+H1/dEhxLf5ldNATpfCi3CwGYWjoaezYszY2IthzYgLGfAyriCx+zIh62xIo10P5jnuj3jnKiJo8U34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bwR7oG6J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bwR7oG6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728919346;
	bh=E6oq2yfjMtwqMzR04MRXeShcM1pOwofotTGEl6KhoUI=;
	h=From:To:Subject:Date:From;
	b=bwR7oG6JfMbxiW1AN3xY9lddjpQwUJzNCgyWJ5iZh12ryvP4vx13snj48sw8/k3eb
	 6SzhCnqv6Sd0ZdFXcSwboXI/PlYCf1UlOOOxrgspR4eSB9Cn5xmv6uHd1t7LrxIyiI
	 xngBXYQX75ZJkWQ5q0ZQrpSnpUNZnVH93oVtdxmxQDYZbxMcAIr1rLx2CjpIC4P9Ox
	 zvGoZTP1gsveS4afqHTpyOJv5pv8jFv3wC3ch8iBSukCtllwnvARM1+LTUi+jY5NRr
	 gs4nQaqVJNHzkgG3/bBYL/6oeSbSbRcvEHUPWOCLJkTHVV3TmCpUydjYsJtgPWEsYg
	 sonzOF5yhaBMA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DE1017E360F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 17:22:26 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/obexctl: Add support to connect using PSM port
Date: Mon, 14 Oct 2024 17:22:05 +0200
Message-Id: <20241014152205.66120-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Since 5d7d3ac25bd56684f4f8c7378b3ec2db0b0ce1ae obexd supports to connect
the session using a L2CAP PSM.
---
 tools/obexctl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 56a76915c..3dfb72856 100644
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
-					DBUS_TYPE_BYTE, &args->channel);
+	if (args->channel) {
+		if (args->channel > 31)
+			g_dbus_dict_append_entry(&dict, "PSM",
+						DBUS_TYPE_UINT16, &args->channel);
+		else
+			g_dbus_dict_append_entry(&dict, "Channel",
+						DBUS_TYPE_BYTE, &args->channel);
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

