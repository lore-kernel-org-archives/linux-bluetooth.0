Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02A316189
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364024; cv=pass; b=C3x3fLsbeJbwg+n07yncE36og7y+8LYMytbUpPhoIeLmR08U4/xeclzeAWsx3RWK5iCCR9I/A5VTrE9Z3UDH05qFSQEtwA68mZ3oYzRhjpqNcc0ISx14Jt3ddaUQB7871ab1O7WKnfbmlJWjZyQTn8Pgxbu2QU0EU0dOgxzMP0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364024; c=relaxed/simple;
	bh=LomUNveBJXsYF7kdteWgCADSXy+uNV8SRAzlr32cswQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USuBMeUN/HLnKZ20Jx7rVhNpZmN8zYSumIfd75IZEt58MEWlv4/XuhVIs2oSjqQKzrOM15Se2esdipiWaDvAqm30R+bntDLvU0OPBvj9km0ue7SEB0cDfeS+aHcu0FtQs9N/fjwLpJYQYz5WdxlFk1LuORhmWU2deUWxwggGLAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lvydhAoc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lvydhAoc"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd0SG0vxrzyWH;
	Sat, 13 Jun 2026 18:20:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781364014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tlpOXuihhUVZbyMIbMj3bi9i3CWarBMsCIJDwzy4I70=;
	b=lvydhAoclpUjkgW0+zAHdek/lKVVztbvDfwxy4/okMa6DGKgjTlEhaCo5Cp+eetQpxSyXH
	bLPKZ/3dJd/3uB5Ddb8cGP8yBe2lt7etRKICsqiDjknWwZp1kJdHudUeFj6KQocmfWBjdy
	LSeqcTXdSzeB88/ala1o6aEz3Qqskbg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781364014;
	b=fgeWDwS/blzzKiKSXLWBvecDOkzmQun8KYhQ5e/kQdqFFIQxClKMMBBC7UKskSNtwqNXf0
	dzNsD0tFcy9qliDKPm/rGZdJT5G3lBn/Y70wg7uvaLstsTV1TBhG2PoqS6/3Qh+SogwXks
	CykhtKFxJwKqtskcg1JjgLfcdyrxuWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781364014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tlpOXuihhUVZbyMIbMj3bi9i3CWarBMsCIJDwzy4I70=;
	b=lOMNuxy3F02xm7Eh9L+L6iC8om5qGviAJN41rfaGK28tlJC48xSDMcSDzU2PZGS2BpLaFH
	AXrMyXPINNnZ/yasAcBTSBSwqmbedtg5KfPkGVLzyZwKNqC82YMBn5qx82DEe3iHL2jGMI
	SOOMqqxVrznBI9zerVZ/TyrbwFX7aTA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] emulator: btvirt: support debug for -s socket server
Date: Sat, 13 Jun 2026 18:20:09 +0300
Message-ID: <11cf79f1f980e5da2202f84bf66e3847048cc34d.1781363977.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support btdev debug -d when using socket server -s.

$ btvirt -d -s
...
bredrle: host10: > 01 13 0c f8 00 00 00 00 00 00 00 00 00 00 00 00  ................
bredrle: host10:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
...
---
 emulator/main.c   | 16 ++++++++++++++++
 emulator/server.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 emulator/server.h |  5 +++++
 3 files changed, 66 insertions(+)

diff --git a/emulator/main.c b/emulator/main.c
index 09d6e9adb..c21640adc 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -80,6 +80,13 @@ static void vhci_debug(const char *str, void *user_data)
 	printf("vhci%u: %s\n", i, str);
 }
 
+static void server_debug(const char *str, void *user_data)
+{
+	const char *name = user_data;
+
+	printf("%s: %s\n", name, str);
+}
+
 int main(int argc, char *argv[])
 {
 	struct server *server1;
@@ -231,6 +238,15 @@ int main(int argc, char *argv[])
 		server5 = server_open_unix(SERVER_TYPE_MONITOR, path);
 		if (!server5)
 			fprintf(stderr, "Failed to open monitor server\n");
+
+		if (debug_enabled) {
+			server_set_debug(server1, server_debug, "bredrle",
+									NULL);
+			server_set_debug(server2, server_debug, "bredr", NULL);
+			server_set_debug(server3, server_debug, "amp", NULL);
+			server_set_debug(server4, server_debug, "le", NULL);
+			server_set_debug(server5, server_debug, "mon", NULL);
+		}
 	}
 
 	if (tcp_port) {
diff --git a/emulator/server.c b/emulator/server.c
index 7790867b7..4538e8f04 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -39,10 +39,14 @@ struct server {
 	enum server_type type;
 	uint16_t id;
 	int fd;
+	server_debug_func_t debug_callback;
+	server_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct client {
 	int fd;
+	struct server *server;
 	struct btdev *btdev;
 	uint8_t *pkt_data;
 	uint8_t pkt_type;
@@ -223,6 +227,18 @@ static int accept_client(int fd)
 	return nfd;
 }
 
+static void dev_debug(const char *str, void *user_data)
+{
+	struct client *client = user_data;
+	struct server *server = client->server;
+	char buf[512];
+
+	if (server->debug_callback) {
+		snprintf(buf, sizeof(buf), "host%d: %s", client->fd, str);
+		server->debug_callback(buf, server->debug_data);
+	}
+}
+
 static void server_accept_callback(int fd, uint32_t events, void *user_data)
 {
 	struct server *server = user_data;
@@ -240,6 +256,8 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 
 	memset(client, 0, sizeof(*client));
 
+	client->server = server;
+
 	client->fd = accept_client(server->fd);
 	if (client->fd < 0) {
 		free(client);
@@ -271,6 +289,7 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 	}
 
 	btdev_set_send_handler(client->btdev, client_write_callback, client);
+	btdev_set_debug(client->btdev, dev_debug, client, NULL);
 
 done:
 	if (mainloop_add_fd(client->fd, EPOLLIN, client_read_callback,
@@ -413,4 +432,30 @@ void server_close(struct server *server)
 		return;
 
 	mainloop_remove_fd(server->fd);
+
+	if (server->debug_destroy)
+		server->debug_destroy(server->debug_data);
+
+	server->debug_callback = NULL;
+	server->debug_destroy = NULL;
+	server->debug_data = NULL;
+
+	free(server);
 }
+
+bool server_set_debug(struct server *server, server_debug_func_t callback,
+			void *user_data, server_destroy_func_t destroy)
+{
+	if (!server)
+		return false;
+
+	if (server->debug_destroy)
+		server->debug_destroy(server->debug_data);
+
+	server->debug_callback = callback;
+	server->debug_destroy = destroy;
+	server->debug_data = user_data;
+
+	return true;
+}
+
diff --git a/emulator/server.h b/emulator/server.h
index 7d6b7be74..1844a9871 100644
--- a/emulator/server.h
+++ b/emulator/server.h
@@ -24,3 +24,8 @@ struct server;
 struct server *server_open_unix(enum server_type type, const char *path);
 struct server *server_open_tcp(enum server_type type, uint16_t port);
 void server_close(struct server *server);
+
+typedef void (*server_debug_func_t)(const char *str, void *user_data);
+typedef void (*server_destroy_func_t)(void *user_data);
+bool server_set_debug(struct server *server, server_debug_func_t callback,
+				void *user_data, server_destroy_func_t destroy);
-- 
2.54.0

