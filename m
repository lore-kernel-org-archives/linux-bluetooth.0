Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C402E8E08
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=etACvf1x2ywz8Da412FjpaBbAqcKDnd6GlGZUTeybsuDVP3BEITcb01sFbNsad4BNCaGRyK69JSVHogQbf8u93xnAqoZZd3mn1M6y6wpmZaXN0qReKSoHEfn+E2cgLJyDDpWLWsFzUwP60GXSyJCCKFhaQVa251VxQcLDMIZJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=pl9GgAbS9PFC+KJ/Q1jkuce8SDjWUveqv5qU6P7GcrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W21r+qAGCRzP9airzLkzW7cbecNsxvRyQygAIkjvMvaCnSFJCRFAtn/aEPgNRqLsmJiuzVSHovEhEsi8AhvTHBxao9ZEPrVbBGaJbkZC4batzMW60L/nhi/uvw5TRx93h32eJ+ju23HN/N1zZvG0BG35XVE2bwTNxaepjZ5pMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bxsh+id8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bxsh+id8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035906;
	bh=pl9GgAbS9PFC+KJ/Q1jkuce8SDjWUveqv5qU6P7GcrA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bxsh+id8F42C8sBj8UcNaxBd47zeYHnFEShjeLpClc8T4A56ZrCdheLTgNOsDRncK
	 CqUm68J93+1pXMTFZU+4h0mKEsZc94hBFvimW7qfvHis9uT4+NWd0FF6ugu0MLk+2X
	 RuhwSGr3UY00KIfrV3CQ+aNg32FHO12vefxanp4sfWfthSRS/k5nLC1wMQN0P1njuc
	 /qcdRxMCgjU7R6dGf3kCzzsirWggXtd/wBtJZM8DibEvdjXj5nj5QRzNihzMdOiQcJ
	 lbSkjCjb6MnMnKtBR5tiraPNknUDYNbCa2rTfuSYUtRawKM1OvwEy07VF2eaQkGBZa
	 egQRp1WCcXEYw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6659117E0A49
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 15/27] client/telephony: Add SendTones support
Date: Fri, 27 Jun 2025 16:51:24 +0200
Message-ID: <20250627145136.421853-16-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

---
 client/telephony.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/client/telephony.c b/client/telephony.c
index eb633748f..5af88c008 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -367,6 +367,58 @@ static void cmd_hangupheld(int argc, char *argv[])
 	bt_shell_printf("Attempting to hangup held calls\n");
 }
 
+static void send_tones_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to send tones: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Send tones successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void send_tones_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *tones = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &tones);
+}
+
+static void cmd_send_tones(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 3) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[2],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "SendTones", send_tones_setup,
+				send_tones_reply, argv[1], NULL) == FALSE) {
+		bt_shell_printf("Failed to send tones\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to send tones\n");
+}
+
 static void cmd_list_calls(int argc, char *arg[])
 {
 	g_list_foreach(calls, print_call, NULL);
@@ -602,6 +654,8 @@ static const struct bt_shell_menu telephony_menu = {
 						ag_generator},
 	{ "hangup-held",  "[audiogw]", cmd_hangupheld, "Hangup held calls",
 						ag_generator},
+	{ "send-tones",   "<tones> [audiogw]", cmd_send_tones, "Send tones",
+						ag_generator},
 	{ "list-calls",   NULL, cmd_list_calls, "List calls" },
 	{ "show-call",    "<call>", cmd_show_call, "Show call information",
 						call_generator},
-- 
2.43.0

