Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5A3B27C9
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177850; cv=pass; b=QsGwfonYohK+1q5cF40fyMFfdTZJf5PjAHdJAeHuyz6Hv76/R3QpGfRjlx+CJmyX8kVye4AUamKB5lNBUA9H2vmmlXc6wjNJn5qdJVMzndt0Q/HHhRoKd93Yfx3S+hVw1NF8R5rjX7r5Plq43/KMQPdNNtVCAV277Xq4W4TG1e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177850; c=relaxed/simple;
	bh=Da9BGpVBMFddF1qGiGluWnw/RovQvvUbxFtj8dAUD7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiVa25mNPmrWhqMe9b1ElOzHCdoCmnOQHwKPlTXfBtykJYJTPsS4bR2x9iXR4z84Sj4FsfXPRYVsmyeHHQ5svMYkDefU8EWUSV2Fx4Nw60ssZTbh7Ce2OcchvHoJ3zR3ED9af27Tn3NOqustxdoPeVZUW7JvnzUl5WmctSmQzgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g0Z33ZGl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g0Z33ZGl"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hHDjl06ZyzyQZ;
	Sat, 08 Aug 2026 11:30:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786177835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1+VKyKjWweCWGXrC+Py45Q3vh6gJStxqoGueway4/bE=;
	b=g0Z33ZGlXv+GkERarj2aFYh6vMwKAWL8qibZ3B4UH/c0HK8rZnymIoUDT+lBFk+TT6PVpI
	mkhJJJ//BIXbAcZkzankPJKiNpsgtGtGDmpOQ7GNt5MIUxwJKkrA+wbZT5/6W9tkz2h8j/
	xy33lbdVPImb1npTqpRSn5+4ivs5Ujo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786177835;
	b=muyAGCCe0h8BfwqW89cvHu8tSsACu4TLNfeaXj1a3FPfKO9Gs9r7XRFqILoNQs83Mbs/mS
	Gcm5NC2//4Yk3kMaAB7x1Zm4aGZAAmF7/9I0weUd39c2ixy86LO/W+MC2YNCvaBVV/ReZW
	N4IxlUN2DX6jVxHC2z2it3Zqcegu47M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786177835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1+VKyKjWweCWGXrC+Py45Q3vh6gJStxqoGueway4/bE=;
	b=iuO9yaKxNjftv24QX0kvLD9OHyo3XWC2gc+v0UavwAeq84DJlV07koBQ8qV1VkFQQSwcFP
	ggKDeB8EZcemk+I6XGq8pxgT5r9GaI13E58FrBQVAUUSefF7WFlzGxFY0U4Bvfe6T2t0P7
	yA5NO4mN0Q2i8uQgvBym0QzmNqsEKnI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] emulator: btvirt: support debug for -s socket server
Date: Sat,  8 Aug 2026 11:30:33 +0300
Message-ID: <3a0785ebc5ceef448c52d25545b142659d25ce24.1786177678.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support btdev debug -d when using socket server -s.

$ btvirt -d -s
Bluetooth emulator ver 5.87
Request for /tmp/bt-server-bredrle
bredrle: host10: > 01 01 10 00                                      ....
bredrle: host10: command 0x1001
bredrle: host10: event 0x0e opcode 0x1001
...
---

Notes:
    v2:
    - Handle closing server with active clients correctly,
      in case this is used from elsewhere than main.c

 emulator/main.c   | 16 ++++++++++++++
 emulator/server.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/server.h |  5 +++++
 3 files changed, 77 insertions(+)

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
index 7790867b7..e3eda8458 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -30,6 +30,7 @@
 #include "bluetooth/hci.h"
 
 #include "src/shared/mainloop.h"
+#include "src/shared/queue.h"
 #include "btdev.h"
 #include "server.h"
 
@@ -39,10 +40,15 @@ struct server {
 	enum server_type type;
 	uint16_t id;
 	int fd;
+	struct queue *clients;
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
@@ -51,10 +57,22 @@ struct client {
 	uint16_t pkt_offset;
 };
 
+static void detach_client(void *data)
+{
+	struct client *client = data;
+
+	client->server = NULL;
+}
+
 static void server_destroy(void *user_data)
 {
 	struct server *server = user_data;
 
+	queue_destroy(server->clients, detach_client);
+
+	if (server->debug_destroy)
+		server->debug_destroy(server->debug_data);
+
 	close(server->fd);
 
 	free(server);
@@ -64,6 +82,9 @@ static void client_destroy(void *user_data)
 {
 	struct client *client = user_data;
 
+	if (client->server)
+		queue_remove(client->server->clients, client);
+
 	btdev_destroy(client->btdev);
 
 	close(client->fd);
@@ -223,6 +244,18 @@ static int accept_client(int fd)
 	return nfd;
 }
 
+static void dev_debug(const char *str, void *user_data)
+{
+	struct client *client = user_data;
+	struct server *server = client->server;
+	char buf[512];
+
+	if (server && server->debug_callback) {
+		snprintf(buf, sizeof(buf), "host%d: %s", client->fd, str);
+		server->debug_callback(buf, server->debug_data);
+	}
+}
+
 static void server_accept_callback(int fd, uint32_t events, void *user_data)
 {
 	struct server *server = user_data;
@@ -279,6 +312,11 @@ done:
 		close(client->fd);
 		free(client);
 	}
+
+	client->server = server;
+	queue_push_tail(server->clients, client);
+
+	btdev_set_debug(client->btdev, dev_debug, client, NULL);
 }
 
 static int open_unix(const char *path)
@@ -338,6 +376,8 @@ struct server *server_open_unix(enum server_type type, const char *path)
 		return NULL;
 	}
 
+	server->clients = queue_new();
+
 	return server;
 }
 
@@ -414,3 +454,19 @@ void server_close(struct server *server)
 
 	mainloop_remove_fd(server->fd);
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
2.55.0

