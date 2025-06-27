Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550772E8DF5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035917; cv=none; b=nMSbBjCMU3fTWEzE8Kukw+N/5xceaIV7wRJIWbX7IPYZcaQtt1A/4ZPNMm8R/NrE25TCDI5U/Oci4Sz+goF/EgHaiNm+h8JU4Z2PzWdfpTkS3u3RdrVGyYpw7dVa5952ggZFR7j0TeeaU9+M6UwqEUCH0Sjav62i807EPMznAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035917; c=relaxed/simple;
	bh=MM4q2M5PmbAkTNZiaFwp0q2Gp2nbzlVdOmiNZD8M8MY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8gJiyhXD/hdOlgcXKhj3cenzFF6IAOe5UK5PAJnza64jsDEN1b4NiUaQP/GFbJeNAEyGZBugykJ9WC0V7Des1IbIeS4BItQJ0ndvGzwA0OE2MPrBs/uFaNLDoybfL/dYh5BA9TSlayG/p+olYte+HfGll/4S1N4t6NfT+NvRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VJYLugYe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VJYLugYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035905;
	bh=MM4q2M5PmbAkTNZiaFwp0q2Gp2nbzlVdOmiNZD8M8MY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VJYLugYeU8huyP32iYmEDCOIZ1aIX7CPYEXEqdoR809ERsiwEaa0/qXpe1DllSCbr
	 lpkoC7KvHdKmPh9b6NuoRVdD6pjXKCHQ3l0k102HWuWFlR+pndYciWuLbJqDsDzD0t
	 DKkj00YQY28g6yBQfnrf/Ii7dqc8PZpuCzRtT1+Mgzqs4BSEtHlhBTMzIKM1hC92hN
	 ISEu3Avj1uflQ3t+0JAJLmQsJOT+XvEhZX6VXb8oN1M6jjbW+QU6yPkz/Y9aTvduL1
	 GvanXPnxVwepKGK5dEVa7svMPNjiXXqvk07XrjbfF8LhDi331O1uBUC1o21rrJDzSd
	 Ui3jyJ45n2oJg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C63F017E09C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:45 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 13/27] client/telephony: Add hangup_active and hangup_held support
Date: Fri, 27 Jun 2025 16:51:22 +0200
Message-ID: <20250627145136.421853-14-frederic.danis@collabora.com>
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
 client/telephony.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/client/telephony.c b/client/telephony.c
index 45d46df79..eb633748f 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -275,6 +275,98 @@ static void cmd_hangupall(int argc, char *argv[])
 	bt_shell_printf("Attempting to hangup all calls\n");
 }
 
+static void hangupactive_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to hangup active calls: %s\n",
+							error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Hangup active successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_hangupactive(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "HangupActive", NULL,
+				hangupactive_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to hangup active calls\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to hangup active calls\n");
+}
+
+static void hangupheld_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to hangup held calls: %s\n",
+							error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Hangup held successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_hangupheld(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "HangupHeld", NULL,
+				hangupheld_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to hangup held calls\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to hangup held calls\n");
+}
+
 static void cmd_list_calls(int argc, char *arg[])
 {
 	g_list_foreach(calls, print_call, NULL);
@@ -505,6 +597,11 @@ static const struct bt_shell_menu telephony_menu = {
 						ag_generator},
 	{ "hangup-all",   "[audiogw]", cmd_hangupall, "Hangup all calls",
 						ag_generator},
+	{ "hangup-active", "[audiogw]", cmd_hangupactive,
+						"Hangup active calls",
+						ag_generator},
+	{ "hangup-held",  "[audiogw]", cmd_hangupheld, "Hangup held calls",
+						ag_generator},
 	{ "list-calls",   NULL, cmd_list_calls, "List calls" },
 	{ "show-call",    "<call>", cmd_show_call, "Show call information",
 						call_generator},
-- 
2.43.0

