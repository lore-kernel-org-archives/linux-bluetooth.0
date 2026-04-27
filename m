Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9235FF58
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310465; cv=none; b=mNyup4gHiN3GkwdZoHFE1nVyvYD0wir5MJf2Z1DZIJ6rHgol0P/9YPv4usiUhRG5nt06S7LgR0JWDQH22clgva0Quct5sGrIx+Nk7mKFQLLMfAgbfk801PdBB5iFgJnyDFgzer4NpJ3nzfko/GJm13lcfmiWDV9coIo2JI7YpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310465; c=relaxed/simple;
	bh=5re2C+Zy2htsnEULwofXeXJ90HxTTnk/22adsd7WCWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmFDze29OUzKB7+Ek3mxqCDVt1ag+03NdpzbMZIau1emdkAUi/OkyGof54nFdXfFl/X27phfK+7OB26RDg7kUmsVGJntAd8yMaJVK7t7g6cQ9R80jeN8lZFO9z38JqbIhofqJ4XBEFl750RIC9Qr46pLRaeS6CofGxC60Hittik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R1A0A07c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R1A0A07c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777310462;
	bh=5re2C+Zy2htsnEULwofXeXJ90HxTTnk/22adsd7WCWQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R1A0A07cKk6yeeGGjGau+jfTAGN95jO8J0aYinFrkK4TvGi4/qfaQPDtG3wg6VJjX
	 uftd6p+D+jP/ulBg4GkXVCB5aR99M+nKQpEs2Iy8+H48+bNxiqBhfg91l41Emy6pZp
	 OcyPmURc9HeeV0XdgaJesaF97lbmeDPpK7KlFCEqwae7MNEbP3FeKHDtXRW1VK11am
	 raooaaG1CgZlTshPtbBXlvCKWcbR+lj4CSgGyO2ZWQ8Us+pkcTi9BpK0A/c2hrWgN1
	 T1MivkEAlZdJMXa00YcvT/gWh9M10dkud3WZPSfNvGSxoZY4ss9SodVNinQCwodkR/
	 qMt8B/LUnmccQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C79D317E1201
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:21:02 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/player: Add support to desynchronize linked transports
Date: Mon, 27 Apr 2026 19:20:56 +0200
Message-ID: <20260427172056.148115-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427172056.148115-1-frederic.danis@collabora.com>
References: <20260427172056.148115-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After linked transports has been desynchronized, they should be acquired
separately and read handler should only be started for source local
endpoint.

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
---
 client/player.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 1444e939d..c5e4beef0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5003,6 +5003,9 @@ static bool transport_recv(struct io *io, void *user_data)
 static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
 {
 	struct transport *transport;
+	DBusMessageIter iter;
+	const char *uuid;
+	bool reader = true;
 
 	transport = new0(struct transport, 1);
 	transport->proxy = proxy;
@@ -5014,7 +5017,27 @@ static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
 
 	io_set_disconnect_handler(transport->io, transport_disconnected,
 							transport, NULL);
-	io_set_read_handler(transport->io, transport_recv, transport, NULL);
+
+	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	/* For BAP testing, streams may have been manually desynchronized.
+	 * In this case source and sink streams are acquired separately and
+	 * read handler should not be started for source local endpoint.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "Desynchronized", &iter)) {
+		dbus_bool_t desync;
+
+		dbus_message_iter_get_basic(&iter, &desync);
+		if (desync && !strcmp(uuid, PAC_SOURCE_UUID))
+			reader = false;
+	}
+
+	if (reader)
+		io_set_read_handler(transport->io, transport_recv, transport,
+									NULL);
 
 	if (!ios)
 		ios = queue_new();
@@ -5325,6 +5348,7 @@ static void print_transport_properties(GDBusProxy *proxy)
 	print_property(proxy, "QoS");
 	print_property(proxy, "Location");
 	print_property(proxy, "Links");
+	print_property(proxy, "Desynchronized");
 }
 
 static void print_transports(void *data, void *user_data)
@@ -6091,6 +6115,53 @@ static void cmd_metadata_transport(int argc, char *argv[])
 	}
 }
 
+static void desync_cb(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to desynchronize: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Desynchronize succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_desync_transport(int argc, char *argv[])
+{
+	dbus_bool_t desync;
+	GDBusProxy *proxy;
+
+	if (argc < 3) {
+		bt_shell_printf("Missing argument to %s\n", argv[0]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!strcmp(argv[2], "on") || !strcmp(argv[2], "yes")) {
+		desync = TRUE;
+	} else if (!strcmp(argv[2], "off") || !strcmp(argv[2], "no")) {
+		desync = FALSE;
+	} else {
+		bt_shell_printf("Invalid argument %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_set_property_basic(proxy, "Desynchronized",
+							DBUS_TYPE_BOOLEAN,
+							&desync, desync_cb,
+							NULL, NULL)) {
+		bt_shell_printf("Failed to desynchronize transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static const struct bt_shell_menu transport_menu = {
 	.name = "transport",
 	.desc = "Media Transport Submenu",
@@ -6126,6 +6197,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "metadata",    "<transport> [value...]", cmd_metadata_transport,
 						"Get/Set Transport Metadata",
 						transport_generator },
+	{ "desync",      "<transport> <on/off>", cmd_desync_transport,
+						"Desynchronize Transport",
+						transport_generator },
 	{} },
 };
 
-- 
2.43.0

