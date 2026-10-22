Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684049;
	b=HaGZZOmTJTad98LU5NDe8Hv0xT7kqEDHMbXRA9uIAwEoqqSYWUnlop7QDSDUfvrDQTK1
	 06nGWRKuG4TABboDV8lE6valMd4eiZbcNxwW5MvVWW4rEkK1ot8RSxV+PH5uMA1bdr0La
	 NPzTfC6CvkFKTfr5OG3oK4ErmO0tXm0hYy4pIIR3TI584kgkPY3k10FKumDRQE7oNsI0s
	 xn44r0Wt6m/L0ZN5RY7W2ERC7PTLBo2at8oMZNAPbdkFT55R1igxDSTHB2acpeBA6p8Nr
	 392Y7RHDCNW6l0aAX5pKFk4CcG87irlh+mt7IgsQ+Seh818hI4Los0Djft7ZTMy0wcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJBsN3LQougdf4dKQhgmDINoZ89vxcCCTRUPTcItNCo=;
	b=bRQXt8FxdE5/LSNzWTGd91xVnzIdoEFUa4030NXfS74C7/YGiaKsc0QqGtALnzbxoqdI
	 8LZjnlEo/JPHCKdkB048nlTURacPeog0qJ6Gd6f1Nq9VqfqdcPtxGGUtQHftXZcTgZSYN
	 tqzUMhJCh7dCOAp9mEZk90S7Kcmy7AolGFyIvJk5pwkUMylpN54qq6XPEos7GUlkdwT93
	 IE7WZGHJEFlqBC1GcDpY5jOFi/Bc+B6vF0X3pL0pwa39rB8JVHefFqtpyZ8gw6fLhxSFS
	 0kXGXf0tEWV26KTBSKR02l9fTpa0uUBekMZuQFLx6XI7KX7PMKWZ6o4BYaA10IqwPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IZWeZWGd;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55007606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55007606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IZWeZWGd
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc7938c5e9so416338137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684048; x=1793288848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qJBsN3LQougdf4dKQhgmDINoZ89vxcCCTRUPTcItNCo=;
        b=IZWeZWGdCeGw8bwT5mEH3t7yDj34+Mj7ihXyf2wQP7WplGYH8SoQaQ1s+rUHSZX1ER
         RBNlRHh9UeZbxqRTxeuocmYl+Z1fJNJV0pxSILuk0VCcYMTRxQboQVnmEjdty05/2VsG
         QblOoOnVDk3kjqDJWTThIPgLD6Yt5RWYWh93reBJMs3cEU/gHP6+SqKpnJuvgM7LOmiE
         GkLqNhD8zmNLkSG70os8tfsvSCgFCd88WoPp+6+2thqsrXTvZbmi7npvS9w5BGrrnMai
         ry7trjICU2BHdokTyXE644Z3IxPAc0FEc0+LM0xZalTZokLmhTMgeuTqb15SOrKzZ9sW
         kIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684048; x=1793288848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qJBsN3LQougdf4dKQhgmDINoZ89vxcCCTRUPTcItNCo=;
        b=c1h6itnEjfBDpJKJClBsWValiVchK8ZG1K74ZmNZkBPMumdm5b4OfXX+PVcCAvRqXr
         VAGDUUaXEohR/K5JeZS6R229jTBKvmzjCcfi8+JR7xSA2UbdUa33PQA0+ufdOLDYymCm
         aRh5wiIUB2n3S6yo3Uwm8mRN63uMzkYMjEqerPyZ+VcibHu0gTvdevkDhRHbMU/4SmmI
         m1Dqsrq5hiirCCMURry88Lxx9CASvSX2rl68LyKITDxY+9zXkN77PoUR0IIBCRS/VsTs
         /o4POshTT+R0qB06Fb7vbv5BRzKOV0GLVbbCi/psTJSjyhm+m1PcTd0UD3zvRH161pVH
         FBUg==
X-Gm-Message-State: AFq9FYK6fU+Vio297eDpychrZHkgj2cSuZd9gxmz7QVf1WJ5AAe1NF1y
	GJ07z9EfVsCA+6UipOR5qPzGYEBaFmDiT3/HQxAMss6vEFAab+fSO9Kk13x3Lu2YWsE=
X-Gm-Gg: AYBFou27cxeVMJtyS5TnGeGkWwsrXlCEdcOrx0dqiOdPhYHCXu5W8vJdPLrzeOgwSf2
	5UPwVLCV+7sv0Eay3OEFu3mC5BZUZZIvfBAEUsah+zw95cD3eDC0/f7+zf78PozAgLm9pOrLPit
	aOhtzLwNhR4SdR2UZlavlEIytd2SYF8arDpaHPKzF/EhPjQlIs/G6BppIUuBQ7/v+TjeHLEy87R
	MqFKekt9UI5fptRxVSAhW4H11on11ssRxGMmPhrGP71zLni+oCSoSDJfXRIF+geho5meDWkAdvR
	e00jGnaUUfRNlepaIE0wty6LR/Tr0HEbOOswMsgy7dt3L215Rw6t6JFfGFOehB/BVnTb7bXf/Hm
	yvv8tztoZcVQjjiQRDyx6CZlN9YxBIA5m3Q+OhRHPwF3UDh1Kz1b8EbScmJz9Nd8HcyMsb9xO3b
	R6GpSP68HDV/FogW7yNnpWZ/ofTE3TL6wmLgsULCOnWU0aBaONpwMdFaV8A0+7hZo+00/BNzb7V
	Ki/xmZHvL9vUDs3Dt/aT1as7CDoflALKlEqdxFqAH+fWancWz+VSRHCWJLYssPukFfCxSDw92Ju
	gwkztvRcZ2fCbS1EUOni1e/1mmL0V8zkUQBqi8vG6nGOqxGcjUsYsLgXPzOwFuG8Lf4=
X-Received: by 2002:a05:6102:6f06:b0:7cc:148f:c531 with SMTP id ada2fe7eead31-7cca9b16518mr671203137.26.1792684048223;
        Thu, 22 Oct 2026 08:47:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 20/27] emulator/hciemu: Remove GLib dependency
Date: Thu, 22 Oct 2026 11:46:53 -0400
Message-ID: <20261022154701.3959500-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use struct io for the sockets between the emulated controllers and
hosts, and timeout_add() with 0 for the deferred host start and the
flushing of client events, so hciemu works with any mainloop backend.

Assisted-by: Claude:claude-opus-5-5
---
 emulator/hciemu.c | 122 +++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 77 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 48ed63b413f4..2f544f319bf2 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -24,8 +24,6 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
 
@@ -35,14 +33,16 @@
 #include "emulator/bthost.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/io.h"
+#include "src/shared/timeout.h"
 #include "emulator/hciemu.h"
 
 struct hciemu_client {
 	struct bthost *host;
 	struct btdev *dev;
-	guint start_source;
-	guint host_source;
-	guint source;
+	unsigned int start_source;
+	struct io *host_io;
+	struct io *io;
 	int sock[2];
 };
 
@@ -124,11 +124,11 @@ static void client_command_callback(uint16_t opcode,
 static void writev_callback(const struct iovec *iov, int iovlen,
 								void *user_data)
 {
-	GIOChannel *channel = user_data;
+	struct io *io = user_data;
 	ssize_t written;
 	int fd;
 
-	fd = g_io_channel_unix_get_fd(channel);
+	fd = io_get_fd(io);
 
 	written = writev(fd, iov, iovlen);
 	if (written < 0) {
@@ -162,99 +162,69 @@ static void writev_callback(const struct iovec *iov, int iovlen,
 	}
 }
 
-static gboolean receive_bthost(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
+static bool receive_bthost(struct io *io, void *user_data)
 {
 	struct bthost *bthost = user_data;
 	unsigned char buf[4096];
 	ssize_t len;
-	int fd;
 
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
-		return FALSE;
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	len = read(fd, buf, sizeof(buf));
+	len = read(io_get_fd(io), buf, sizeof(buf));
 	if (len < 0)
-		return FALSE;
+		return false;
 
 	bthost_receive_h4(bthost, buf, len);
 
-	return TRUE;
+	return true;
 }
 
-static guint create_source_bthost(int fd, struct bthost *bthost)
+static struct io *create_io_bthost(int fd, struct bthost *bthost)
 {
-	GIOChannel *channel;
-	guint source;
+	struct io *io;
 
-	channel = g_io_channel_unix_new(fd);
+	io = io_new(fd);
+	io_set_close_on_destroy(io, true);
 
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
+	bthost_set_send_handler(bthost, writev_callback, io);
 
-	bthost_set_send_handler(bthost, writev_callback, channel);
+	io_set_read_handler(io, receive_bthost, bthost, NULL);
 
-	source = g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				receive_bthost, bthost, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
+	return io;
 }
 
-static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
+static bool receive_btdev(struct io *io, void *user_data)
 {
 	struct btdev *btdev = user_data;
 	unsigned char buf[4096];
 	ssize_t len;
-	int fd;
 
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
-		return FALSE;
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	len = read(fd, buf, sizeof(buf));
+	len = read(io_get_fd(io), buf, sizeof(buf));
 	if (len < 0) {
 		if (errno == EAGAIN || errno == EINTR)
-			return TRUE;
+			return true;
 
-		return FALSE;
+		return false;
 	}
 
 	if (len < 1)
-		return FALSE;
+		return false;
 
 	btdev_receive_h4(btdev, buf, len);
 
-	return TRUE;
+	return true;
 }
 
-static guint create_source_btdev(int fd, struct btdev *btdev)
+static struct io *create_io_btdev(int fd, struct btdev *btdev)
 {
-	GIOChannel *channel;
-	guint source;
+	struct io *io;
 
-	channel = g_io_channel_unix_new(fd);
+	io = io_new(fd);
+	io_set_close_on_destroy(io, true);
 
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
+	btdev_set_send_handler(btdev, writev_callback, io);
 
-	btdev_set_send_handler(btdev, writev_callback, channel);
+	io_set_read_handler(io, receive_btdev, btdev, NULL);
 
-	source = g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				receive_btdev, btdev, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
+	return io;
 }
 
 static bool create_vhci(struct hciemu *hciemu)
@@ -318,7 +288,7 @@ struct bthost *hciemu_client_get_host(struct hciemu *hciemu)
 	return hciemu_client_host(client);
 }
 
-static gboolean start_host(gpointer user_data)
+static bool start_host(void *user_data)
 {
 	struct hciemu_client *client = user_data;
 
@@ -326,18 +296,17 @@ static gboolean start_host(gpointer user_data)
 
 	bthost_start(client->host);
 
-	return FALSE;
+	return false;
 }
 
 static void hciemu_client_destroy(void *data)
 {
 	struct hciemu_client *client = data;
 
-	if (client->start_source)
-		g_source_remove(client->start_source);
+	timeout_remove(client->start_source);
 
-	g_source_remove(client->host_source);
-	g_source_remove(client->source);
+	io_destroy(client->host_io);
+	io_destroy(client->io);
 
 	bthost_destroy(client->host);
 	btdev_destroy(client->dev);
@@ -385,9 +354,9 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 	client->sock[0] = sv[0];
 	client->sock[1] = sv[1];
 
-	client->source = create_source_btdev(sv[0], client->dev);
-	client->host_source = create_source_bthost(sv[1], client->host);
-	client->start_source = g_idle_add(start_host, client);
+	client->io = create_io_btdev(sv[0], client->dev);
+	client->host_io = create_io_bthost(sv[1], client->host);
+	client->start_source = timeout_add(0, start_host, client, NULL);
 
 	btdev_get_mtu(client->dev, &acl_mtu, NULL, &iso_mtu);
 	bthost_set_acl_mtu(client->host, acl_mtu);
@@ -512,8 +481,7 @@ void hciemu_unref(struct hciemu *hciemu)
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
 	queue_destroy(hciemu->clients, hciemu_client_destroy);
 
-	if (hciemu->flush_id)
-		g_source_remove(hciemu->flush_id);
+	timeout_remove(hciemu->flush_id);
 
 	vhci_close(hciemu->vhci);
 
@@ -853,7 +821,7 @@ static bool client_is_pending(const void *data, const void *match_data)
 	struct hciemu_client *client = (struct hciemu_client *)data;
 	int used, i;
 
-	if (!client->source || !client->host_source)
+	if (!client->io || !client->host_io)
 		return false;
 
 	for (i = 0; i < 2; ++i) {
@@ -866,12 +834,12 @@ static bool client_is_pending(const void *data, const void *match_data)
 	return false;
 }
 
-static gboolean flush_client_events(gpointer user_data)
+static bool flush_client_events(void *user_data)
 {
 	struct hciemu *hciemu = user_data;
 
 	if (queue_find(hciemu->clients, client_is_pending, NULL))
-		return TRUE;
+		return true;
 
 	hciemu->flush_id = 0;
 
@@ -879,7 +847,7 @@ static gboolean flush_client_events(gpointer user_data)
 	if (hciemu->vhci)
 		vhci_pause_input(hciemu->vhci, false);
 
-	return FALSE;
+	return false;
 }
 
 void hciemu_flush_client_events(struct hciemu *hciemu)
@@ -889,5 +857,5 @@ void hciemu_flush_client_events(struct hciemu *hciemu)
 
 	util_debug(hciemu->debug_callback, hciemu->debug_data, "vhci: pause");
 	vhci_pause_input(hciemu->vhci, true);
-	hciemu->flush_id = g_idle_add(flush_client_events, hciemu);
+	hciemu->flush_id = timeout_add(0, flush_client_events, hciemu, NULL);
 }
-- 
2.56.0

