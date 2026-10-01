Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE795383C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889055; cv=none; b=K/TiFqBYvegFRVGV267X2fhe4c0eFuS37bqvDyKv6QgScSQrPgpSUQBlc/V9xyCJrRpga2RaZyRky3124Wx7yvG/LfcIKCFY6ZpHqoAkAhlt72d0U8uLp3bswg8r2EhXyaSV4sKY3gB0XLim3gHY/MJUMWs9SF4+ZFXr0fGnVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889055; c=relaxed/simple;
	bh=ioV+/P0rkfyJKrLbJrwcL4nXGZWDt9+mW4anJtgIExc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNE3NkGGa2F/ax6L4T4B9V0IN/keLgvueWi0BaLLxHOvl01/Py1j6+IBoZOSYhxW7sD5bDborEPLTlsOR64bsnjkHQerRM5X/DiQJkxH0GXvjLmTfbFQzyejD9LChSaAmeYHThKJaSst3Kgq7VgSesrOGeg6qOmvtnM3l4DuHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jKUq2jQA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jKUq2jQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889043;
	bh=ioV+/P0rkfyJKrLbJrwcL4nXGZWDt9+mW4anJtgIExc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jKUq2jQAUU/eaOsWfLrVinRIhlUY+HRiaMyAP94Z859ly2zI8TgRjRdRFNWL/l87z
	 V2pxTouVWI3gjGqJ4yQegyw4+Yg+J7w/puVTXSWnMjV7UZI3NRv6Vr7cb14CAWVu1k
	 dgrYP4k6Su0sZUkBSw7v7YD6KvuATV3gRn8agWQQuk8grBaxG+NRn4b9Rs21Noj8mF
	 oKyeCTLdUWuYU904lJNSXHC37L/awPoJEQQJ3sB2OoFOKrYUCsXmdpLtzVmXUhiHDM
	 xDmKfl98p/VNsf/nkcTjaw8TlsM+ggBny3gN88h7+HymvXGojxZ7n5M67RNKS10P0N
	 8mqBgQwGlQD3g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EF1A17E0967
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/12] client/telephony: Add multi calls support
Date: Thu,  1 Oct 2026 23:10:34 +0200
Message-ID: <20261001211036.1760396-11-frederic.danis@collabora.com>
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

This adds menu entries for the SwapCalls, ReleaseAndAnswer,
ReleaseAndSwap and HoldAndAnswer methods from org.bluez.Telephony1.
---
 client/telephony.c | 190 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/client/telephony.c b/client/telephony.c
index ab2a93430..858c02c0b 100644
--- a/client/telephony.c
+++ b/client/telephony.c
@@ -232,6 +232,187 @@ static void cmd_dial(int argc, char *argv[])
 	bt_shell_printf("Attempting to dial\n");
 }
 
+static void swap_calls_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to swap calls: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Swap calls successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_swap_calls(int argc, char *argv[])
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
+						BLUEZ_TELEPHONY_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "SwapCalls", NULL,
+				swap_calls_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to swap calls\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to swap calls\n");
+}
+
+static void release_answer_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to release and answer: %s\n",
+								error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Release and answer successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_release_answer(int argc, char *argv[])
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
+						BLUEZ_TELEPHONY_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "ReleaseAndAnswer", NULL,
+				release_answer_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to release and answer\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to release and answer\n");
+}
+
+static void release_swap_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to release and swap: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Release and swap successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_release_swap(int argc, char *argv[])
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
+						BLUEZ_TELEPHONY_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "ReleaseAndSwap", NULL,
+				release_swap_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to release and swap\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to release and swap\n");
+}
+
+static void hold_answer_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to hold and answer: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Hold and answer successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_hold_answer(int argc, char *argv[])
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
+						BLUEZ_TELEPHONY_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "HoldAndAnswer", NULL,
+				hold_answer_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to hold and answer\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to hold and answer\n");
+}
+
 static void hangupall_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -550,6 +731,15 @@ static const struct bt_shell_menu telephony_menu = {
 						ag_generator},
 	{ "dial",         "<number> [telephony]", cmd_dial, "Dial number",
 						ag_generator},
+	{ "swap-calls",   "[telephony]", cmd_swap_calls, "Swap calls",
+						ag_generator},
+	{ "release-answer", "[telephony]", cmd_release_answer,
+						"Release and answer",
+						ag_generator},
+	{ "release-swap", "[telephony]", cmd_release_swap, "Release and swap",
+						ag_generator},
+	{ "hold-answer",  "[telephony]", cmd_hold_answer, "Hold and answer",
+						ag_generator},
 	{ "hangup-all",   "[telephony]", cmd_hangupall, "Hangup all calls",
 						ag_generator},
 	{ "send-tones",   "<tones> [telephony]", cmd_send_tones, "Send tones",
-- 
2.43.0

