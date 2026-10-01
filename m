Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DA5372F6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889055; cv=none; b=CAfVTvLUnLjBBFXwOkP43VHisCxr5LWkCQ8yXNlBf60vOJfSDZZzWTQQ6JpNIbYrespnboSPdpNjOsgnH4oWv6D+s52oFckz8Ie9BqvnQoIfhRSD/8lX6XmB/tUlQatWjKmNH5BiHOuJFRsRog+4dY4C5Kp5gLaEE6tamv6y6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889055; c=relaxed/simple;
	bh=HCI7oX8knxg9MwrEfDFdPRf5qNWgZssUvz0RdINNlfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/2oTVCcbrjYEjeW5a20Wce4wZ+33vn5LzzSf3eIuGK+zovmB8rAqThsmeI7ojpqfKxW7hY6lr64RhVmLtrLlpChAkRTwrixGHIalmOeu7bvQlWU0KfwZJxpHfdHv2gZwarT1gq2eMqUyLSJwHo+Y6S9vRP6Fa92Us467xEfSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qKw+v0Nj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qKw+v0Nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889043;
	bh=HCI7oX8knxg9MwrEfDFdPRf5qNWgZssUvz0RdINNlfI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qKw+v0Nj0Ea9M2yMjYZd0TWnPaQSAmAFBZDPZH0W8fdgg58LuXhkfOLvogNGeJNP1
	 smYT7zy2rjRrT03XCqjlTRWJe/2i0ivOGXACvj0T1WDIe28lLO0/tqj+SO1aKUklE1
	 2gGop2hfFsuBr9Q3A1eMoLJblRzKuHu4fP3iM8wsn2opoTA7nfx3Kyoqyedvr/KK4U
	 8UfbRYEixFczYkF/FmyZ93mnPkXTqKasHWkHYnK48Csbcvx4Lcyf9yh+g+R1zvoLzB
	 4nusc2zl2HLhFJUq1hCfUqh1iIxuWM7WOH7xfeJAY8d3cCRAItzStumssiFPXlvFlw
	 opfu2Pwr5RKuw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2988217E0928
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/12] client/telephony: Add Send Tones menu entry
Date: Thu,  1 Oct 2026 23:10:32 +0200
Message-ID: <20261001211036.1760396-9-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
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

