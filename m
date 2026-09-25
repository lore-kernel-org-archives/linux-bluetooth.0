Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400B4A2638
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342755; cv=none; b=F0BX5iQ4T61sNxIkK0Z7PDU5PmzQIa+RuMMDY+hJXhTVzwnBDYJ4sCML/gUNXFbm+P0CCpaLrpbgpqq2apeV3o63Mc+rxSOVxjuSCmSMzvQn4FJDjM0xa9EX5iTUz+AKjPB/24AxkBMRO+ZDbU66SqvHylbtFgTiaWx0hXqwL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342755; c=relaxed/simple;
	bh=HCI7oX8knxg9MwrEfDFdPRf5qNWgZssUvz0RdINNlfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpF3HEJM1rYbpKmW91iXOSZtUaonxt2Wb+rwTCWP/3ISzwJ9ZoSJQMn8GrxRvQwzDz64m2wC7wmRF4TIz0GKs8NkY3nRI76e7XV4Om8QCkWliYHyCI5srP+gyX58m40ixkWkQN283vsrqrpDvZaa3Ff/CdQMRxExGNK2vc00qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iyV4wlYr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iyV4wlYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342738;
	bh=HCI7oX8knxg9MwrEfDFdPRf5qNWgZssUvz0RdINNlfI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iyV4wlYrEGiinOOrUni+Jice6+6s8VEx1l21/+qOcppQ0ZeQsVnY+ef40BtNTmYiB
	 mGlq8sC6I4GbJ7gq7DLSKREuCjuUNmX9gL5yhtcc8MRO3BWUGhQeNngIZ/vIeprzYw
	 jqvMEUz95op9YHnH5yw7IJnp6YveXnxCdmIqOOT3VN5vodCZML9KO7K2ApBAmtr1B2
	 uA6RD2icG+MjJQvB2wcG/st9Pvlo1dihMh0TxJQM2hjhTxLsthk3GAqtXrvewHMFTB
	 dzVoZVZO6KFKd0AT8gFLq1D6IRDHfAQHvYJ2STDAfdRN5YvNrbGJzlS0GIi5Qp5cz0
	 wB89V3dvrpUqw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1B4117E0DF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:37 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] client/telephony: Add Send Tones menu entry
Date: Fri, 25 Sep 2026 15:25:24 +0200
Message-ID: <20260925132528.3361517-9-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
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
 client/telephony.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/client/telephony.c b/client/telephony.c
index cc92fe33a..ab2a93430 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -277,6 +277,51 @@ static void cmd_hangupall(int argc, char *argv[])
 	bt_shell_printf("Attempting to hangup all calls\n");
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
+						BLUEZ_TELEPHONY_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "SendTones", dial_setup,
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
@@ -507,6 +552,8 @@ static const struct bt_shell_menu telephony_menu = {
 						ag_generator},
 	{ "hangup-all",   "[telephony]", cmd_hangupall, "Hangup all calls",
 						ag_generator},
+	{ "send-tones",   "<tones> [telephony]", cmd_send_tones, "Send tones",
+						ag_generator},
 	{ "list-calls",   NULL, cmd_list_calls, "List calls" },
 	{ "show-call",    "<call>", cmd_show_call, "Show call information",
 						call_generator},
-- 
2.43.0

