Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644672D978C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701633; cv=none; b=WmeIF8snuz7lQpVOvdMo6VKgESMadk6pXSAqfo2RtDPgvAbyDy/JtfZXCM6MubzGAj1AhUm+jv629lOOs7XNsxEAcbN2SWfq0R2EBRyoyGY4IWl+d7zfsWC9ovxnDhyzXVJcN4NBhE/1/yP/xD1Yst2Bbuy3iNEjcQDUEsA3bGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701633; c=relaxed/simple;
	bh=B4sqWzRWtgjVHfe3pqg9kFZG4a83MFWTVLk9FlnDLW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkv1gIIGEUR+OoI53nNN6k9q+vBDesPi0Q+4fUyuVXg5BVHiAPRYYUYYLpQXaYjlTzk3Q+zkicET1+qzBBZbcJ0b/Zsz81se9r+R7/mAbKZa91bc64eryrvmD5E8tnYUX/rPCfXjkIBGrlDwgqJO1ejPgGFM8JRZqJUAvpyQgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nb0VdeSq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nb0VdeSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776701630;
	bh=B4sqWzRWtgjVHfe3pqg9kFZG4a83MFWTVLk9FlnDLW4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nb0VdeSqH1mm0FYIt29Fqu94gW0NOdPOdus8g1AeGBfMOyIDc5Q8VJIquPpVYMq/F
	 YisQJN71aXfvHgmw1rUfJxYHtMt2nxukUPljNtGX6kfQmTs8JKK/mISHUe7n71zXpa
	 SOZgUh0sI3Lm71TyLOIkrewFz8m9vZYY7rhCRKHP60aouaq3YKK6Ur07UzyzcFTb7p
	 zW4a/SXRU5m/x1dkIFZiQgqSLPijRhapEQLzaBF6A7+a5zt2OOQ4NKuaffvavE+au9
	 uiJjHnqUSblBHHZtBb+QxpL1K1TA9CwG6pK/db64t7M48HJsuVyShK1AuWkWEh1oVA
	 C9dqRF5dH22ng==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C12AB17E1428
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 18:13:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/player: Add support to unlink transports
Date: Mon, 20 Apr 2026 18:13:45 +0200
Message-ID: <20260420161345.145089-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420161345.145089-1-frederic.danis@collabora.com>
References: <20260420161345.145089-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
---
 client/player.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 1444e939d..e3bd28fea 100644
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
@@ -5014,7 +5017,23 @@ static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
 
 	io_set_disconnect_handler(transport->io, transport_disconnected,
 							transport, NULL);
-	io_set_read_handler(transport->io, transport_recv, transport, NULL);
+
+	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	/* For BAP testing, streams may have been manually unlinked.
+	 * In this case source and sink streams are acquired separately and
+	 * read handler should not be started for source local endpoint.
+	 */
+	if (!g_dbus_proxy_get_property(proxy, "Links", &iter) &&
+			!strcmp(uuid, PAC_SOURCE_UUID))
+		reader = false;
+
+	if (reader)
+		io_set_read_handler(transport->io, transport_recv, transport,
+									NULL);
 
 	if (!ios)
 		ios = queue_new();
@@ -6091,6 +6110,39 @@ static void cmd_metadata_transport(int argc, char *argv[])
 	}
 }
 
+static void unlink_cb(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to unlink: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Unlink succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_unlink_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char *value[0];
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_set_property_array(proxy, "Links",
+				DBUS_TYPE_OBJECT_PATH,
+				value, 0, unlink_cb,
+				NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to unlink transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static const struct bt_shell_menu transport_menu = {
 	.name = "transport",
 	.desc = "Media Transport Submenu",
@@ -6126,6 +6178,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "metadata",    "<transport> [value...]", cmd_metadata_transport,
 						"Get/Set Transport Metadata",
 						transport_generator },
+	{ "unlink",      "<transport>", cmd_unlink_transport,
+						"Unlink Transport",
+						transport_generator },
 	{} },
 };
 
-- 
2.43.0

