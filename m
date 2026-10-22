Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684055;
	b=X67izlfuvB9ZrX+J0LGa0voUHx3D7uufByvl3XnALQnvG6DOWZxzGr2f2RxgPpuUvKEh
	 /k7/NMISnRbH7n95aCzYyQSyZoRRuPBDjHC2Y9XmxxN6cvCcP/FbsfcsGzFs5veZLJoj4
	 YArO+ysBGrKSu30qHLO506VK+kPmpZ9hjK7HePmpXcB1oXkK+rXLJSV2nL7PuRYlmGqn/
	 1IY0HWYewRiuIG96AaYHf5y6k3jK9aEvqBxWSWwaOd+oKXrlmCfC2nytXSi+S2swXVlza
	 aMfk6K3+yzZrtV2i3hzPaCrn/WlBLSSMT+xTQVLRYQdLGi11iucPsZssOd+uTbF5LvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s0YjUoOluBFCaX7LOBghB7/zBcCtKBROP9dvIVzsrFI=;
	b=XAthE56EUF2nAr3Ch+jhQ7yoR6nSc0ykXA9pYZXBtAkaAAO2/t0pBdpcib03QRqqoFBE
	 4KVeUk5u3IjknrPG51Ht0BhhVV3BNRxJqWU5FAR4xL6a/zmv2XpfVnupS4pDKKRnHZ24R
	 0YPAnNfbd0GotOmTFjVcHu9sGYq5bf6VN3ibKPQpubgE38JBrSlBHBIJSqbyb8HjJXjPY
	 5Fdoj9WXBUZCCLwrOnM32SpY4ARUCea3ZwEOsr7wI3KABfQ9IfJY66GtbTHzZwgc02NcG
	 LbEvU7yd41l8QSz2DYIFLFfybl2tooUw9vfDy3KTSTjNq8yQgNuPyXQaLgszr4/mXqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fElCtpZh;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1F606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8D1F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fElCtpZh
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eafb65e204so4303e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684053; x=1793288853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s0YjUoOluBFCaX7LOBghB7/zBcCtKBROP9dvIVzsrFI=;
        b=fElCtpZhr8oCSwqorRhr5ZU5WpTWa5turQzCmZ8vUPzBBT3orEQtHNkswiMCZh8sRx
         20lop9waVDs95miVmWwoFAAIhhz1v2zoGn7Xw1Ol04Y7hPtp9WY27hoJFugMmSPzBnY6
         Ns+B+1nAGmdyLRd1l1rbVDcp4b231M2jgRPCrWt4QjdL9kTcn9ucXF3KeqPJRuSyQzsk
         Dmo12OIKC6pt7ofyEdJMfzL5hAlQjx8i/8fferuGzCLOlNdCYkf69h4DFIpxCfuJpOlj
         CcXYnHERC1UeAAB5wIW3M2me37AMc5sNVU4K6insktkrXzjV61ZRIYwoJogtoHqLjbPz
         H6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684053; x=1793288853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s0YjUoOluBFCaX7LOBghB7/zBcCtKBROP9dvIVzsrFI=;
        b=GLTl5KbhQ05C7Fn9p6Z5sSFp/AwoxBGsV4YZTWb86t8rVy9kJLykngAJRO5ruRl0JR
         vyBGGLWxlg/fLCZ0ZAS3Ptx/NCRFOuU7sdrLD4jU0bf2UzNvX9N4F+wRkefwOVu5SJ6G
         PNg8grwopo6T+crP0Irr+RGAvyDheHpUUa5kJYj8LD7eZ1TOhmevKGwPmTq+lOPNeHxl
         W5l/yAEI378Vn+zarESb0XRiPJmg+q12dBzBOz9/STFXjP7Ldvnj0SZyeH3v2VRiuLs9
         qwbifUoTQm17AJV07oCQj+Ulc5R5H3IxgDfrKwH+96PHQddT1z1Dg05YMyxMlj2aJRXt
         OpgA==
X-Gm-Message-State: AFq9FYJfAVjqwaVV4d68ZSeUoLunIaPMYw1T0rPBkTgdrqM3LXH4PwUv
	6v1YgOoi5zWLebu9IFhwyDfTURJvDKgnZ/lSnQ2gU3SXLX63HlveZa02fWvuE+M3un4=
X-Gm-Gg: AYBFou10Lsq/Rz15YQtjtam+jPZ6dQ5sJfM+xLL+9RVETpiemWS1k0T0BRAOkF8dLo3
	AvkWeCOIaSBKgBGfqpJzE/98taF0oT5LaXvq1NeyY7bcBxJqvL58eMdMurOEeRt8oFvMrDjqsox
	5rPrWdbnqJH2L/doI52ckjO68K0Ub0ZVAdjCg+RjW3NfBk0xowAY3XsHRx/sIfFzTmB9FZNidvU
	JFvN1EFYjXozzQufAiVqNtwzYMXA4ZVWTLEvYTJm0iL2MoTX8gvyCIq3tLbFN2j+KyN5LH3fPRU
	VpTnw7KS8XIU36kDlfxmu+QT/YUGX8huL5x4vQDnFVvN7sNa9ZK24FT7UZFuHHbGdGaBAs1j8So
	6J3ruF/or9Rg4p/Lh4FC5qudjso58COtzWw9Izh0eCxiINeeFx9WMpaYn46PmF8nihPTZXCJpFm
	pixi/Zn2jlnBmOzd9ngrTvSW2B2wZC3XRdXI/vUy2lUwiYDOxFDg9NNfYrvZ0bd86i6/9Z3MIuR
	er3a8+vfu1yWxI/zq6h4VkB6Bs1xVcSU1glRWSbcOf/z2lva4tpGn5JSMaRbu4ALmiAz+CsTru0
	TQhjf4npIgjHwfZkQM5ihFpl/2ksI69QPHGzqUe4Pb5W7FblebzrAYO4JeKkTs2aVfo=
X-Received: by 2002:a05:6122:288a:b0:5eb:2a6e:d3a7 with SMTP id 71dfb90a1353d-5eb2a6eed9amr1012671e0c.12.1792684052212;
        Thu, 22 Oct 2026 08:47:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 25/27] tools: Run l2cap-tester and iso-tester on the mainloop
Date: Thu, 22 Oct 2026 11:46:58 -0400
Message-ID: <20261022154701.3959500-26-luiz.dentz@gmail.com>
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

Replace their GIOChannel watches with tester_io and GLib timeouts with
timeout_add(), and link them with libshared-mainloop, which unlike GLib
does not read the clock on every iteration.

Under User Mode Linux with test-runner -T:

  l2cap-tester  10.2 s -> 5.6 s
  iso-tester    16.3 s -> 7.6 s

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools       |  10 +-
 tools/iso-tester.c   | 337 ++++++++++++++++++++++---------------------
 tools/l2cap-tester.c | 333 ++++++++++++++++++++++--------------------
 3 files changed, 355 insertions(+), 325 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 5a04987ea3ea..3a376b3d00c6 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -147,14 +147,15 @@ tools_mesh_tester_SOURCES = tools/mesh-tester.c monitor/bt.h \
 tools_mesh_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la
 
-tools_l2cap_tester_SOURCES = tools/l2cap-tester.c tools/tester.h monitor/bt.h \
+tools_l2cap_tester_SOURCES = tools/l2cap-tester.c \
+				tools/tester-io.h tools/tester-io.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c \
 				tools/tester-io.h tools/tester-io.c monitor/bt.h \
@@ -217,14 +218,15 @@ tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la
 
-tools_iso_tester_SOURCES = tools/iso-tester.c tools/tester.h monitor/bt.h \
+tools_iso_tester_SOURCES = tools/iso-tester.c \
+				tools/tester-io.h tools/tester-io.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_iso_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 7149232d17f4..333c894ea06e 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -22,7 +22,7 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/iso.h"
@@ -35,6 +35,8 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -471,7 +473,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t acl_handle;
 	struct queue *io_queue;
-	GIOChannel *past_io;
+	struct tester_io *past_io;
 	unsigned int io_id[4];
 	uint8_t client_num;
 	int step;
@@ -525,8 +527,9 @@ struct iso_client_data {
 	unsigned int repeat_send;
 };
 
-typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
-						uint8_t num, GIOFunc func);
+typedef bool (*iso_defer_accept_t)(struct test_data *data, struct tester_io *io,
+						uint8_t num,
+							tester_io_func_t func);
 
 static void mgmt_debug(const char *str, void *user_data)
 {
@@ -700,9 +703,9 @@ static void test_pre_setup(const void *test_data)
 
 static void io_free(void *data)
 {
-	GIOChannel *io = data;
+	struct tester_io *io = data;
 
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 }
 
 static void test_post_teardown(const void *test_data)
@@ -713,10 +716,8 @@ static void test_post_teardown(const void *test_data)
 	if (data->io_queue)
 		queue_remove_all(data->io_queue, NULL, NULL, io_free);
 
-	if (data->past_io) {
-		g_io_channel_unref(data->past_io);
-		data->past_io = NULL;
-	}
+	tester_io_unref(data->past_io);
+	data->past_io = NULL;
 
 	/* Remove the watches with the test, as the sockets they keep open
 	 * hang up once the controller is removed, which would wake up the
@@ -724,7 +725,7 @@ static void test_post_teardown(const void *test_data)
 	 */
 	for (i = 0; i < ARRAY_SIZE(data->io_id); ++i) {
 		if (data->io_id[i] > 0) {
-			g_source_remove(data->io_id[i]);
+			tester_remove_source(data->io_id[i]);
 			data->io_id[i] = 0;
 		}
 	}
@@ -747,7 +748,7 @@ static void test_data_free(void *test_data)
 
 	for (i = 0; i < ARRAY_SIZE(data->io_id); ++i)
 		if (data->io_id[i] > 0)
-			g_source_remove(data->io_id[i]);
+			tester_remove_source(data->io_id[i]);
 
 	free(data);
 }
@@ -1722,7 +1723,7 @@ static void bthost_iso_disconnected(void *user_data)
 	data->handle = 0x0000;
 }
 
-static void iso_send(struct test_data *data, GIOChannel *io);
+static void iso_send(struct test_data *data, struct tester_io *io);
 
 static void iso_new_conn(uint16_t handle, void *user_data)
 {
@@ -1737,7 +1738,7 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 
 	if (data->past_io) {
 		iso_send(data, data->past_io);
-		g_io_channel_unref(data->past_io);
+		tester_io_unref(data->past_io);
 		data->past_io = NULL;
 	}
 
@@ -2382,22 +2383,23 @@ static bool check_bcast_qos(const struct bt_iso_qos *qos1,
 }
 
 static void test_connect(const void *test_data);
-static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data);
-static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data);
-static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
-						uint8_t num, GIOFunc func);
+static bool iso_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data);
+static bool iso_accept_cb(struct tester_io *io, uint32_t cond,
+							void *user_data);
+static bool iso_defer_accept_bcast(struct test_data *data, struct tester_io *io,
+						uint8_t num,
+							tester_io_func_t func);
 
-static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_disconnected(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
 
 	data->io_id[0] = 0;
 
-	if (cond & G_IO_HUP) {
+	if (cond & TESTER_IO_HUP) {
 		if (!isodata->bcast && data->handle)
 			tester_test_failed();
 
@@ -2411,34 +2413,35 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 			if (!isodata->server)
 				test_connect(data->test_data);
 			else {
-				GIOChannel *parent =
+				struct tester_io *parent =
 					queue_peek_head(data->io_queue);
 
 				data->step++;
 
 				if (!iso_defer_accept_bcast(data,
-						g_io_channel_ref(parent), 0,
+						tester_io_ref(parent), 0,
 						iso_accept_cb))
-					g_io_channel_unref(parent);
+					tester_io_unref(parent);
 			}
 
-			return FALSE;
+			return false;
 		}
 
 		tester_test_passed();
 	} else
 		tester_test_failed();
 
-	return FALSE;
+	return false;
 }
 
-static void iso_shutdown(struct test_data *data, GIOChannel *io)
+static void iso_shutdown(struct test_data *data, struct tester_io *io)
 {
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
-	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_HUP,
+							iso_disconnected, data);
 
 	/* Shutdown using SHUT_WR as SHUT_RDWR cause the socket to HUP
 	 * immediately instead of waiting for Disconnect Complete event.
@@ -2448,12 +2451,13 @@ static void iso_shutdown(struct test_data *data, GIOChannel *io)
 	tester_print("Disconnecting...");
 }
 
-static void iso_terminate(struct test_data *data, GIOChannel *io)
+static void iso_terminate(struct test_data *data, struct tester_io *io)
 {
 	struct bthost *host;
 
 	/* Setup watcher to check if fd is closed properly after termination */
-	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_HUP,
+							iso_disconnected, data);
 
 	tester_print("Terminating...");
 
@@ -2463,12 +2467,12 @@ static void iso_terminate(struct test_data *data, GIOChannel *io)
 	bthost_terminate_big(host, BT_HCI_ERR_LOCAL_HOST_TERM);
 }
 
-static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_recv_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
-	int sk = g_io_channel_unix_get_fd(io);
+	int sk = tester_io_get_fd(io);
 	unsigned char control[256];
 	ssize_t ret;
 	char buf[1024];
@@ -2491,7 +2495,7 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		tester_warn("Failed to read %zu bytes: %s (%d)",
 				isodata->recv->iov_len, strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (isodata->pkt_status) {
@@ -2520,7 +2524,7 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		} else
 			tester_test_passed();
 
-		return FALSE;
+		return false;
 	}
 
 	if (isodata->pkt_seqnum) {
@@ -2550,28 +2554,28 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 			tester_warn("isodata->pkt_seqnum 0x%2.2x != 0x%2.2x "
 					"pkt_seqnum", pkt_seqnum, data->seqnum);
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 	}
 
 	if (rx_timestamp_check(&msg, isodata->so_timestamping, 1000) < 0) {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (data->step) {
 		data->step--;
 	} else {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (memcmp(buf, isodata->recv->iov_base, ret))
 		tester_test_failed();
 	else if (data->step) {
 		/* Keep the watch, and its id so teardown can remove it */
-		data->io_id[0] = g_source_get_id(g_main_current_source());
-		return TRUE;
+		data->io_id[0] = tester_current_source();
+		return true;
 	} else if (isodata->disconnect)
 		iso_shutdown(data, io);
 	else if (isodata->terminate)
@@ -2579,10 +2583,10 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
-static void iso_recv(struct test_data *data, GIOChannel *io)
+static void iso_recv(struct test_data *data, struct tester_io *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	struct bthost *host;
@@ -2597,7 +2601,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 		return;
 	}
 
-	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+	if (rx_timestamping_init(tester_io_get_fd(io),
 						isodata->so_timestamping))
 		return;
 
@@ -2610,32 +2614,33 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 		data->step++;
 	}
 
-	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_IN, iso_recv_data,
+									data);
 }
 
-static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_recv_errqueue(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
-	int sk = g_io_channel_unix_get_fd(io);
+	int sk = tester_io_get_fd(io);
 	int err;
 
 	data->step--;
 
 	err = tx_tstamp_recv(&data->tx_ts, sk, isodata->send->iov_len);
 	if (err > 0)
-		return TRUE;
+		return true;
 	else if (err)
 		tester_test_failed();
 	else if (!data->step)
 		tester_test_passed();
 
 	data->io_id[2] = 0;
-	return FALSE;
+	return false;
 }
 
-static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
+static void iso_tx_timestamping(struct test_data *data, struct tester_io *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	int so = isodata->so_timestamping;
@@ -2653,9 +2658,10 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	for (count = 0; count < isodata->repeat_send + 1; ++count)
 		data->step += tx_tstamp_expect(&data->tx_ts, 0);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
-	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
+	data->io_id[2] = tester_io_add_watch(io, TESTER_IO_ERR,
+						iso_recv_errqueue, data);
 
 	if (isodata->cmsg_timestamping)
 		so &= ~TS_TX_RECORD_MASK;
@@ -2669,7 +2675,7 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 	}
 }
 
-static void iso_send_data(struct test_data *data, GIOChannel *io)
+static void iso_send_data(struct test_data *data, struct tester_io *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	char control[CMSG_SPACE(sizeof(uint32_t))];
@@ -2683,7 +2689,7 @@ static void iso_send_data(struct test_data *data, GIOChannel *io)
 
 	tester_print("Writing %zu bytes of data", isodata->send->iov_len);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (isodata->cmsg_timestamping) {
 		memset(control, 0, sizeof(control));
@@ -2710,8 +2716,8 @@ static void iso_send_data(struct test_data *data, GIOChannel *io)
 	data->step++;
 }
 
-static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
-				gpointer user_data)
+static bool iso_pollout(struct tester_io *io, uint32_t cond,
+				void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
@@ -2723,8 +2729,8 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 	 * iso_new_conn(), rather than waking up for good until then.
 	 */
 	if (isodata->past && !data->handle) {
-		data->past_io = g_io_channel_ref(io);
-		return FALSE;
+		data->past_io = tester_io_ref(io);
+		return false;
 	}
 
 	tester_print("POLLOUT event received");
@@ -2739,20 +2745,21 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 
 	if (isodata->bcast) {
 		if (isodata->past)
-			return FALSE;
+			return false;
 		tester_test_passed();
-		return FALSE;
+		return false;
 	}
 
 	if (isodata->recv)
 		iso_recv(data, io);
 
-	return FALSE;
+	return false;
 }
 
-static void iso_send(struct test_data *data, GIOChannel *io)
+static void iso_send(struct test_data *data, struct tester_io *io)
 {
-	data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_pollout, data);
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_OUT, iso_pollout,
+									data);
 }
 
 static bool hook_set_event_mask(const void *msg, uint16_t len, void *user_data)
@@ -2873,8 +2880,8 @@ static bool check_rpa(struct test_data *data, int sk)
 	return true;
 }
 
-static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
@@ -2884,7 +2891,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	bool ret = true;
 	uint8_t base[BASE_MAX_LENGTH] = {0};
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	len = sizeof(qos);
 	memset(&qos, 0, len);
@@ -2895,7 +2902,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 							strerror(errno), errno);
 		data->step = 0;
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (!isodata->bcast) {
@@ -2911,7 +2918,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		tester_warn("Unexpected QoS parameter");
 		data->step = 0;
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (isodata->bcast && isodata->server && isodata->base) {
@@ -2923,7 +2930,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 						strerror(errno), errno);
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 
 		if (len != isodata->base_len ||
@@ -2931,7 +2938,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			tester_warn("Unexpected BASE");
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 	}
 
@@ -2950,7 +2957,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 					strerror(errno), errno);
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 
 		if (olen != sizeof(addr)) {
@@ -2958,14 +2965,14 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 					olen, sizeof(addr));
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 
 		if (addr.bc.bc_sid > 0x0f) {
 			tester_warn("Invalid SID: %d", addr.bc.bc_sid);
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 
 		tester_print("SID: 0x%02x", addr.bc.bc_sid);
@@ -2984,7 +2991,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		if (!check_rpa(data, sk)) {
 			data->step = 0;
 			tester_test_failed();
-			return FALSE;
+			return false;
 		}
 
 		tester_print("Successfully connected");
@@ -3012,11 +3019,11 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			tester_test_passed();
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3025,8 +3032,8 @@ static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
 	return iso_connect(io, cond, user_data);
 }
 
-static gboolean iso_connect2_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect2_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3106,11 +3113,11 @@ static int connect_deferred(int sk)
 }
 
 static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
-								GIOFunc *func)
+							tester_io_func_t *func)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	int sk[256];
-	GIOChannel *io;
+	struct tester_io *io;
 	unsigned int i;
 
 	for (i = 0; i < n; ++i) {
@@ -3126,10 +3133,11 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 	}
 
 	for (i = 0; i < n; ++i) {
-		io = g_io_channel_unix_new(sk[i]);
-		g_io_channel_set_close_on_unref(io, TRUE);
+		io = tester_io_new(sk[i]);
+		tester_io_set_close_on_unref(io, true);
 
-		data->io_id[num[i]] = g_io_add_watch(io, G_IO_OUT, func[i],
+		data->io_id[num[i]] = tester_io_add_watch(io, TESTER_IO_OUT,
+									func[i],
 									NULL);
 
 		if (data->io_queue)
@@ -3140,7 +3148,7 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 			 */
 			queue_push_tail(data->io_queue, io);
 		else
-			g_io_channel_unref(io);
+			tester_io_unref(io);
 
 		tester_print("Connect %d in progress", num[i]);
 
@@ -3148,7 +3156,8 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 	}
 }
 
-static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
+static void setup_connect(struct test_data *data, uint8_t num,
+							tester_io_func_t func)
 {
 	return setup_connect_many(data, 1, &num, &func);
 }
@@ -3158,7 +3167,7 @@ static void test_connect(const void *test_data)
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = test_data;
 	uint8_t n = 0;
-	GIOFunc func[2];
+	tester_io_func_t func[2];
 	uint8_t num[2] = {0, 1};
 
 	func[n++] = iso_connect_cb;
@@ -3320,7 +3329,7 @@ fail:
 	return err;
 }
 
-static gboolean test_listen_past(gpointer user_data)
+static bool test_listen_past(void *user_data)
 {
 	struct test_data *data = user_data;
 	struct bthost *host;
@@ -3332,15 +3341,15 @@ static gboolean test_listen_past(gpointer user_data)
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_past_set_info(host, data->acl_handle);
 
-	return FALSE;
+	return false;
 }
 
 static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
-								GIOFunc *func)
+							tester_io_func_t *func)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	int sk[256];
-	GIOChannel *io;
+	struct tester_io *io;
 	unsigned int i;
 
 	for (i = 0; i < n; ++i) {
@@ -3353,13 +3362,13 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 			return;
 		}
 
-		io = g_io_channel_unix_new(sk[i]);
-		g_io_channel_set_close_on_unref(io, TRUE);
+		io = tester_io_new(sk[i]);
+		tester_io_set_close_on_unref(io, true);
 
-		data->io_id[num[i]] = g_io_add_watch(io, G_IO_IN,
+		data->io_id[num[i]] = tester_io_add_watch(io, TESTER_IO_IN,
 							func[i], NULL);
 
-		g_io_channel_unref(io);
+		tester_io_unref(io);
 
 		tester_print("Listen %d in progress", num[i]);
 
@@ -3391,25 +3400,27 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 		/* Wait for listen to take effect before initiating PAST
 		 * procedure.
 		 */
-		g_assert(data->io_id[3] == 0);
-		data->io_id[3] = g_timeout_add(250, test_listen_past, data);
+		assert(data->io_id[3] == 0);
+		data->io_id[3] = timeout_add(250, test_listen_past, data, NULL);
 	}
 }
 
-static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
+static void setup_listen(struct test_data *data, uint8_t num,
+							tester_io_func_t func)
 {
 	return setup_listen_many(data, 1, &num, &func);
 }
 
-static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
-						uint8_t num, GIOFunc func)
+static bool iso_defer_accept_bcast(struct test_data *data, struct tester_io *io,
+						uint8_t num,
+							tester_io_func_t func)
 {
 	int sk;
 	char c;
 	const struct iso_client_data *isodata = data->test_data;
 	struct sockaddr_iso *addr = NULL;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (isodata->pa_bind) {
 		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
@@ -3442,20 +3453,21 @@ static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
 	if (data->io_queue)
 		queue_push_tail(data->io_queue, io);
 
-	data->io_id[num] = g_io_add_watch(io, G_IO_IN,
+	data->io_id[num] = tester_io_add_watch(io, TESTER_IO_IN,
 				func, NULL);
 
 	return true;
 }
 
-static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io,
-						uint8_t num, GIOFunc func)
+static bool iso_defer_accept_ucast(struct test_data *data, struct tester_io *io,
+						uint8_t num,
+							tester_io_func_t func)
 {
 	int sk;
 	char c;
 	struct pollfd pfd;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sk;
@@ -3479,25 +3491,26 @@ static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io,
 	if (data->io_queue)
 		queue_push_tail(data->io_queue, io);
 
-	data->io_id[num] = g_io_add_watch(io, G_IO_OUT,
+	data->io_id[num] = tester_io_add_watch(io, TESTER_IO_OUT,
 				func, NULL);
 
 	return true;
 }
 
-static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
-				gpointer user_data, uint8_t num, GIOFunc func)
+static bool iso_accept(struct tester_io *io, uint32_t cond,
+				void *user_data, uint8_t num,
+							tester_io_func_t func)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
-	gboolean ret;
-	GIOChannel *new_io;
+	bool ret;
+	struct tester_io *new_io;
 	iso_defer_accept_t iso_defer_accept = isodata->bcast ?
 						iso_defer_accept_bcast :
 						iso_defer_accept_ucast;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
@@ -3505,12 +3518,12 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
-	new_io = g_io_channel_unix_new(new_sk);
-	g_io_channel_set_close_on_unref(new_io, TRUE);
+	new_io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(new_io, true);
 
 	if (isodata->defer) {
 		if (isodata->expect_err < 0) {
-			g_io_channel_unref(new_io);
+			tester_io_unref(new_io);
 			tester_test_passed();
 			return false;
 		}
@@ -3519,13 +3532,13 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 			iso_connect(new_io, cond, user_data);
 
 			if (!data->step) {
-				g_io_channel_unref(new_io);
+				tester_io_unref(new_io);
 				return false;
 			}
 
 			/* Return if connection has already been accepted */
 			if (queue_find(data->io_queue, NULL, io)) {
-				g_io_channel_unref(new_io);
+				tester_io_unref(new_io);
 				return false;
 			}
 		}
@@ -3533,7 +3546,7 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		if (!iso_defer_accept(data, new_io, num, func)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
-			g_io_channel_unref(new_io);
+			tester_io_unref(new_io);
 		}
 		return false;
 	}
@@ -3566,12 +3579,12 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 
 	ret = iso_connect(new_io, cond, user_data);
 
-	g_io_channel_unref(new_io);
+	tester_io_unref(new_io);
 	return ret;
 }
 
-static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_accept_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
@@ -3584,8 +3597,8 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		return iso_accept(io, cond, user_data, 0, iso_connect_cb);
 }
 
-static gboolean iso_accept2_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_accept2_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3605,13 +3618,13 @@ static void test_connect2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[2] = {0, 1};
-	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+	tester_io_func_t funcs[2] = {iso_connect_cb, iso_connect2_cb};
 
 	setup_connect_many(data, 2, num, funcs);
 }
 
-static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect2_seq_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3629,7 +3642,7 @@ static void test_connect2_seq(const void *test_data)
 	setup_connect(data, 0, iso_connect2_seq_cb);
 }
 
-static gboolean test_connect2_busy_done(gpointer user_data)
+static bool test_connect2_busy_done(void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3637,18 +3650,18 @@ static gboolean test_connect2_busy_done(gpointer user_data)
 
 	if (data->io_id[0] > 0) {
 		/* First connection still exists */
-		g_source_remove(data->io_id[0]);
+		tester_remove_source(data->io_id[0]);
 		data->io_id[0] = 0;
 		tester_test_passed();
 	} else {
 		tester_test_failed();
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean iso_connect_cb_busy_disc(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_cb_busy_disc(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -3656,11 +3669,11 @@ static gboolean iso_connect_cb_busy_disc(GIOChannel *io, GIOCondition cond,
 
 	tester_print("Disconnected 1");
 	tester_test_failed();
-	return FALSE;
+	return false;
 }
 
-static gboolean iso_connect_cb_busy_2(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_cb_busy_2(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	int err, sk_err, sk;
@@ -3668,7 +3681,7 @@ static gboolean iso_connect_cb_busy_2(GIOChannel *io, GIOCondition cond,
 
 	data->io_id[1] = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	len = sizeof(sk_err);
 
@@ -3681,22 +3694,22 @@ static gboolean iso_connect_cb_busy_2(GIOChannel *io, GIOCondition cond,
 
 	if (err == -EBUSY && data->io_id[0] > 0) {
 		/* Wait in case first connection still gets disconnected */
-		data->io_id[1] = g_timeout_add(250, test_connect2_busy_done,
-									data);
+		data->io_id[1] = timeout_add(250, test_connect2_busy_done,
+								data, NULL);
 	} else {
 		tester_test_failed();
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean iso_connect_cb_busy(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_cb_busy(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
 	/* First connection shall not be disconnected */
-	data->io_id[0] = g_io_add_watch(io, G_IO_ERR | G_IO_HUP,
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_ERR | TESTER_IO_HUP,
 						iso_connect_cb_busy_disc, data);
 
 	/* Second connect shall fail since CIG is now busy */
@@ -3712,8 +3725,8 @@ static void test_connect2_busy(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb_busy);
 }
 
-static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_close_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 
@@ -3725,7 +3738,7 @@ static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
 	if (!data->step)
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
 static bool hook_remove_cig(const void *msg, uint16_t len, void *user_data)
@@ -3745,7 +3758,7 @@ static void test_connect_close(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	int sk;
-	GIOChannel *io;
+	struct tester_io *io;
 
 	data->step = 2;
 
@@ -3757,31 +3770,33 @@ static void test_connect_close(const void *test_data)
 	if (sk < 0)
 		return;
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_connect_close_cb,
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_HUP,
+							iso_connect_close_cb,
 									data);
 
 	shutdown(sk, SHUT_RDWR);
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 }
 
-static gboolean iso_connect_wait_close_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool iso_connect_wait_close_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	int sk;
 
 	tester_print("Connected");
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
-	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_connect_close_cb,
+	data->io_id[0] = tester_io_add_watch(io, TESTER_IO_HUP,
+							iso_connect_close_cb,
 									data);
 
 	shutdown(sk, SHUT_RDWR);
 
-	return FALSE;
+	return false;
 }
 
 static void test_connect_wait_close(const void *test_data)
@@ -3848,7 +3863,7 @@ static void test_past(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[1] = { 1 };
-	GIOFunc funcs[1] = { iso_accept2_cb };
+	tester_io_func_t funcs[1] = { iso_accept2_cb };
 
 	if (data->client_num > 1)
 		setup_listen_many(data, 1, num, funcs);
@@ -3868,7 +3883,7 @@ static void test_bcast2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[2] = {0, 1};
-	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+	tester_io_func_t funcs[2] = {iso_connect_cb, iso_connect2_cb};
 
 	setup_connect_many(data, 2, num, funcs);
 }
@@ -3877,7 +3892,7 @@ static void test_bcast2_reconn(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[2] = {0, 1};
-	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+	tester_io_func_t funcs[2] = {iso_connect_cb, iso_connect2_cb};
 
 	data->io_queue = queue_new();
 
@@ -3896,7 +3911,7 @@ static void test_bcast_recv2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[2] = {0, 1};
-	GIOFunc funcs[2] = {iso_accept_cb, iso_accept2_cb};
+	tester_io_func_t funcs[2] = {iso_accept_cb, iso_accept2_cb};
 
 	setup_listen_many(data, 2, num, funcs);
 }
@@ -3924,7 +3939,7 @@ static void test_bcast_recv2_defer(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	uint8_t num[2] = {0, 1};
-	GIOFunc funcs[2] = {iso_accept_cb, iso_accept2_cb};
+	tester_io_func_t funcs[2] = {iso_accept_cb, iso_accept2_cb};
 
 	data->step = 2;
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index c2643b4182b0..4002ca561db8 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -18,7 +18,7 @@
 #include <poll.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/l2cap.h"
@@ -29,6 +29,8 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
@@ -271,7 +273,7 @@ static void test_pre_setup(const void *test_data)
 
 static void io_channel_unref(void *data)
 {
-	g_io_channel_unref(data);
+	tester_io_unref(data);
 }
 
 static void test_post_teardown(const void *test_data)
@@ -279,12 +281,12 @@ static void test_post_teardown(const void *test_data)
 	struct test_data *data = tester_get_data();
 
 	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
+		tester_remove_source(data->io_id);
 		data->io_id = 0;
 	}
 
 	if (data->err_io_id > 0) {
-		g_source_remove(data->err_io_id);
+		tester_remove_source(data->err_io_id);
 		data->err_io_id = 0;
 	}
 
@@ -1798,8 +1800,8 @@ static void received_data(struct test_data *tdata, const void *buf,
 	iov.iov_len = 0;
 }
 
-static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sock_received_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -1808,21 +1810,21 @@ static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
 	int sk;
 	ssize_t len;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	len = recv_tstamp(sk, buf, sizeof(buf), tstamp);
 	if (len < 0) {
 		tester_warn("Unable to read: %s (%d)", strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	received_data(data, buf, len, l2data->read_data, l2data->data_len);
 
 	if (data->step)
-		return TRUE;
+		return true;
 
-	return FALSE;
+	return false;
 }
 
 static void bthost_received_data(const void *buf, uint16_t len,
@@ -1834,8 +1836,8 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	received_data(data, buf, len, l2data->write_data, l2data->data_len);
 }
 
-static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool socket_closed_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -1846,19 +1848,19 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 
 	if (l2data->shut_sock_wr) {
 		/* if socket is closed using SHUT_WR, L2CAP disconnection
-		 * response must be received first before G_IO_HUP event.
+		 * response must be received first before TESTER_IO_HUP event.
 		 */
 		if (data->host_disconnected)
 			tester_test_passed();
 		else {
-			tester_warn("G_IO_HUP received before receiving L2CAP disconnection");
+			tester_warn("TESTER_IO_HUP received before receiving L2CAP disconnection");
 			tester_test_failed();
 		}
 	}
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1874,7 +1876,7 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_failed();
 
-	return FALSE;
+	return false;
 }
 
 static bool check_mtu(struct test_data *data, int sk)
@@ -1923,7 +1925,7 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
-static gboolean check_phy_and_sec(gpointer args)
+static bool check_phy_and_sec(void *args)
 {
 	int sk = PTR_TO_INT(args);
 	struct test_data *data = tester_get_data();
@@ -1947,7 +1949,7 @@ static gboolean check_phy_and_sec(gpointer args)
 		tester_print("phy 0x%08x != 0x%08x", l2data->phy, data->phys);
 
 		/* Retry */
-		return TRUE;
+		return true;
 	}
 
 	tester_print("Checking security level...");
@@ -1965,7 +1967,7 @@ static gboolean check_phy_and_sec(gpointer args)
 						l2data->change_sec_level);
 
 		/* Retry */
-		return TRUE;
+		return true;
 	}
 
 	data->step--;
@@ -1973,7 +1975,7 @@ static gboolean check_phy_and_sec(gpointer args)
 done:
 	shutdown(sk, SHUT_WR);
 
-	return FALSE;
+	return false;
 }
 
 static int check_phys_and_sec(struct test_data *data, int sk)
@@ -2031,7 +2033,7 @@ static int check_phys_and_sec(struct test_data *data, int sk)
 	if (changed) {
 		/* Wait for the change */
 		data->step++;
-		g_timeout_add(50, check_phy_and_sec, INT_TO_PTR(sk));
+		timeout_add(50, check_phy_and_sec, INT_TO_PTR(sk), NULL);
 
 		return -EINPROGRESS;
 	}
@@ -2039,29 +2041,29 @@ static int check_phys_and_sec(struct test_data *data, int sk)
 	return 0;
 }
 
-static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool recv_errqueue(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct l2cap_data *l2data = data->test_data;
-	int sk = g_io_channel_unix_get_fd(io);
+	int sk = tester_io_get_fd(io);
 	int err;
 
 	data->step--;
 
 	err = tx_tstamp_recv(&data->tx_ts, sk, l2data->data_len);
 	if (err > 0)
-		return TRUE;
+		return true;
 	else if (err)
 		tester_test_failed();
 	else if (!data->step)
 		tester_test_passed();
 
 	data->err_io_id = 0;
-	return FALSE;
+	return false;
 }
 
-static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
+static void l2cap_tx_timestamping(struct test_data *data, struct tester_io *io)
 {
 	const struct l2cap_data *l2data = data->test_data;
 	int so = l2data->so_timestamping;
@@ -2072,7 +2074,7 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 	if (!(l2data->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	tester_print("Enabling TX timestamping");
 
@@ -2090,7 +2092,8 @@ static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
 		return;
 	}
 
-	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
+	data->err_io_id = tester_io_add_watch(io, TESTER_IO_ERR, recv_errqueue,
+									data);
 }
 
 static int l2cap_send(int sk, const void *data, size_t len, uint16_t mtu)
@@ -2115,7 +2118,7 @@ static int l2cap_send(int sk, const void *data, size_t len, uint16_t mtu)
 	return total;
 }
 
-static void l2cap_read_data(struct test_data *data, GIOChannel *io,
+static void l2cap_read_data(struct test_data *data, struct tester_io *io,
 							uint16_t cid)
 {
 	const struct l2cap_data *l2data = data->test_data;
@@ -2125,12 +2128,12 @@ static void l2cap_read_data(struct test_data *data, GIOChannel *io,
 
 	data->step = 0;
 
-	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+	if (rx_timestamping_init(tester_io_get_fd(io),
 						l2data->so_timestamping))
 		return;
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
+	tester_io_add_watch(io, TESTER_IO_IN, sock_received_data, NULL);
 
 	len = MIN(iov.iov_len, data->l2o.imtu);
 
@@ -2144,7 +2147,7 @@ static void l2cap_read_data(struct test_data *data, GIOChannel *io,
 	++data->step;
 }
 
-static void l2cap_write_data(struct test_data *data, GIOChannel *io,
+static void l2cap_write_data(struct test_data *data, struct tester_io *io,
 							uint16_t cid)
 {
 	const struct l2cap_data *l2data = data->test_data;
@@ -2154,7 +2157,7 @@ static void l2cap_write_data(struct test_data *data, GIOChannel *io,
 	unsigned int count;
 	socklen_t len = sizeof(size);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	data->step = 0;
 
@@ -2185,8 +2188,8 @@ static void l2cap_write_data(struct test_data *data, GIOChannel *io,
 	}
 }
 
-static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool l2cap_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -2195,7 +2198,7 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -2211,30 +2214,31 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (!check_mtu(data, sk)) {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	err = check_phys_and_sec(data, sk);
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
-			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
-			return FALSE;
+			tester_io_add_watch(io, TESTER_IO_HUP, socket_closed_cb,
+									NULL);
+			return false;
 		}
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (l2data->read_data) {
 		l2cap_read_data(data, io, data->dcid);
-		return FALSE;
+		return false;
 	} else if (l2data->write_data) {
 		l2cap_write_data(data, io, data->dcid);
-		return FALSE;
+		return false;
 	} else if (l2data->shut_sock_wr) {
-		g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
+		tester_io_add_watch(io, TESTER_IO_HUP, socket_closed_cb, NULL);
 		shutdown(sk, SHUT_WR);
 
-		return FALSE;
+		return false;
 	}
 
 failed:
@@ -2243,7 +2247,7 @@ failed:
 	else
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
 static int create_l2cap_sock(struct test_data *data, uint16_t psm,
@@ -2434,7 +2438,7 @@ static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	if (l2data->server_psm) {
@@ -2485,12 +2489,13 @@ static void test_connect(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_OUT, l2cap_connect_cb, NULL);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_OUT, l2cap_connect_cb,
+									NULL);
 
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 
 	tester_print("Connect in progress");
 }
@@ -2499,7 +2504,7 @@ static void test_connect_close(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
@@ -2519,10 +2524,11 @@ static void test_connect_close(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-	data->io_id = g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
-	g_io_channel_unref(io);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_HUP, socket_closed_cb,
+									NULL);
+	tester_io_unref(io);
 
 	shutdown(sk, SHUT_RDWR);
 }
@@ -2531,7 +2537,7 @@ static void test_connect_timeout(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 	struct timeval sndto;
 	socklen_t len;
@@ -2565,10 +2571,11 @@ static void test_connect_timeout(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-	data->io_id = g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
-	g_io_channel_unref(io);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_HUP, socket_closed_cb,
+									NULL);
+	tester_io_unref(io);
 }
 
 static void test_connect_reject(const void *test_data)
@@ -2593,12 +2600,13 @@ static void test_connect_reject(const void *test_data)
 	close(sk);
 }
 
-static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
+static int connect_socket(const uint8_t *client_bdaddr,
+						tester_io_func_t connect_cb,
 								bool defer)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
@@ -2634,12 +2642,13 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 	}
 
 	if (connect_cb) {
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
+		io = tester_io_new(sk);
+		tester_io_set_close_on_unref(io, true);
 
-		data->io_id = g_io_add_watch(io, G_IO_OUT, connect_cb, NULL);
+		data->io_id = tester_io_add_watch(io, TESTER_IO_OUT, connect_cb,
+									NULL);
 
-		g_io_channel_unref(io);
+		tester_io_unref(io);
 	}
 
 	tester_print("Connect in progress, sk = %d %s", sk,
@@ -2648,7 +2657,7 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 	return sk;
 }
 
-static gboolean test_close_socket_1_part_3(gpointer arg)
+static bool test_close_socket_1_part_3(void *arg)
 {
 	struct test_data *data = tester_get_data();
 
@@ -2657,20 +2666,20 @@ static gboolean test_close_socket_1_part_3(gpointer arg)
 	if (data->sk != -1) {
 		tester_print("Error - scan was not enabled yet");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Delayed check whether scann is off failed");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	tester_test_passed();
-	return FALSE;
+	return false;
 }
 
-static gboolean test_close_socket_1_part_2(gpointer args)
+static bool test_close_socket_1_part_2(void *args)
 {
 	struct test_data *data = tester_get_data();
 	int sk = data->sk;
@@ -2684,7 +2693,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	if (!hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should be still scanning");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	/* Calling close() should remove device from  accept list, and stop
@@ -2693,15 +2702,15 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	if (close(sk) < 0) {
 		tester_print("Error when closing socket");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	data->sk = -1;
 	/* tester_test_passed will be called when scan is stopped. */
-	return FALSE;
+	return false;
 }
 
-static gboolean test_close_socket_2_part_3(gpointer arg)
+static bool test_close_socket_2_part_3(void *arg)
 {
 	struct test_data *data = tester_get_data();
 	int sk = data->sk;
@@ -2711,7 +2720,7 @@ static gboolean test_close_socket_2_part_3(gpointer arg)
 	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should no longer scan");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	/* Calling close() should eventually cause CMD_LE_CREATE_CONN_CANCEL */
@@ -2719,11 +2728,11 @@ static gboolean test_close_socket_2_part_3(gpointer arg)
 	if (err < 0) {
 		tester_print("Error when closing socket");
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	/* CMD_LE_CREATE_CONN_CANCEL will trigger test pass. */
-	return FALSE;
+	return false;
 }
 
 static bool test_close_socket_cc_hook(const void *data, uint16_t len,
@@ -2732,7 +2741,7 @@ static bool test_close_socket_cc_hook(const void *data, uint16_t len,
 	return false;
 }
 
-static gboolean test_close_socket_2_part_2(gpointer arg)
+static bool test_close_socket_2_part_2(void *arg)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
@@ -2748,7 +2757,7 @@ static gboolean test_close_socket_2_part_2(gpointer arg)
 	 */
 	bthost_set_adv_enable(bthost, 0x01);
 	bthost_set_adv_enable(bthost, 0x00);
-	return FALSE;
+	return false;
 }
 
 static void test_close_socket_scan_enabled(void)
@@ -2757,9 +2766,9 @@ static void test_close_socket_scan_enabled(void)
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_2, NULL);
+		timeout_add(0, test_close_socket_1_part_2, NULL, NULL);
 	else if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_2, NULL);
+		timeout_add(0, test_close_socket_2_part_2, NULL, NULL);
 }
 
 static void test_close_socket_scan_disabled(void)
@@ -2768,7 +2777,7 @@ static void test_close_socket_scan_disabled(void)
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_3, NULL);
+		timeout_add(0, test_close_socket_1_part_3, NULL, NULL);
 }
 
 /* The kernel creates the connection once the scan is disabled, close the
@@ -2780,7 +2789,7 @@ static void test_close_socket_create_conn(void)
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_3, NULL);
+		timeout_add(0, test_close_socket_2_part_3, NULL, NULL);
 }
 
 static void test_close_socket_conn_cancel(void)
@@ -2828,8 +2837,8 @@ static void test_close_socket(const void *test_data)
 }
 
 static uint8_t test_2_connect_cb_cnt;
-static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool test_2_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -2838,7 +2847,7 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -2848,7 +2857,7 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 	if (err < 0) {
 		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Successfully connected");
@@ -2865,16 +2874,16 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 		tester_test_passed();
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean enable_advertising(gpointer args)
+static bool enable_advertising(void *args)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_set_adv_enable(bthost, 0x01);
-	return FALSE;
+	return false;
 }
 
 static void test_connect_2_part_2(void)
@@ -2891,7 +2900,7 @@ static void test_connect_2_part_2(void)
 		close(data->sk);
 	}
 
-	g_idle_add(enable_advertising, NULL);
+	timeout_add(0, enable_advertising, NULL, NULL);
 }
 
 static uint8_t test_scan_enable_counter;
@@ -2907,7 +2916,7 @@ static void test_connect_2_router(uint16_t opcode, const void *param,
 		if (test_scan_enable_counter == 1)
 			test_connect_2_part_2();
 		else if (test_scan_enable_counter == 2)
-			g_idle_add(enable_advertising, NULL);
+			timeout_add(0, enable_advertising, NULL, NULL);
 	}
 }
 
@@ -2942,26 +2951,27 @@ static void test_connect_2(const void *test_data)
 								defer);
 }
 
-static gboolean watch_no_track_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool watch_no_track_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
-	int sk = g_io_channel_unix_get_fd(io);
+	int sk = tester_io_get_fd(io);
 
 	tester_print("Ready sk = %d", sk);
-	return FALSE;
+	return false;
 }
 
 static int watch_and_close_sk(int sk)
 {
-	GIOChannel *io;
+	struct tester_io *io;
 
 	if (sk < 0)
 		return sk;
 
-	io = g_io_channel_unix_new(sk);
-	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	io = tester_io_new(sk);
+	tester_io_add_watch(io,
+		TESTER_IO_OUT | TESTER_IO_ERR | TESTER_IO_HUP | TESTER_IO_NVAL,
 						watch_no_track_cb, NULL);
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 
 	return sk;
 }
@@ -3028,8 +3038,8 @@ static void test_connect_ext_defer_limit(const void *test_data)
 	}
 }
 
-static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool l2cap_accept_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -3037,46 +3047,47 @@ static gboolean l2cap_accept_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (!check_mtu(data, sk)) {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	err = check_phys_and_sec(data, sk);
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
-			g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
-			return FALSE;
+			tester_io_add_watch(io, TESTER_IO_HUP, socket_closed_cb,
+									NULL);
+			return false;
 		}
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (l2data->read_data) {
 		l2cap_read_data(data, io, data->dcid);
-		return FALSE;
+		return false;
 	} else if (l2data->write_data) {
 		l2cap_write_data(data, io, data->scid);
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Successfully connected");
 
 	tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
-static bool defer_accept(struct test_data *data, GIOChannel *io,
-							GIOFunc accept_cb)
+static bool defer_accept(struct test_data *data, struct tester_io *io,
+						tester_io_func_t accept_cb)
 {
 	int sk;
 	char c;
 	struct pollfd pfd;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sk;
@@ -3095,17 +3106,18 @@ static bool defer_accept(struct test_data *data, GIOChannel *io,
 	}
 
 	if (accept_cb)
-		data->io_id = g_io_add_watch(io, G_IO_OUT, accept_cb, NULL);
+		data->io_id = tester_io_add_watch(io, TESTER_IO_OUT, accept_cb,
+									NULL);
 
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 
 	tester_print("Accept deferred setup sk = %d", sk);
 
 	return true;
 }
 
-static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool l2cap_listen_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
@@ -3113,31 +3125,31 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
 		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Accept sk = %d", new_sk);
 
-	io = g_io_channel_unix_new(new_sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(io, true);
 
 	if (l2data->defer) {
 		if (l2data->expect_err < 0) {
-			g_io_channel_unref(io);
-			return FALSE;
+			tester_io_unref(io);
+			return false;
 		}
 
 		if (!defer_accept(data, io, l2cap_accept_cb)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 		}
-		return FALSE;
+		return false;
 	}
 
 	return l2cap_accept_cb(io, cond, user_data);
@@ -3243,14 +3255,14 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 }
 
 static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
-							GIOFunc listen_cb)
+						tester_io_func_t listen_cb)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *central_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	if (l2data->server_psm || l2data->cid) {
@@ -3281,11 +3293,12 @@ static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
 			return;
 		}
 
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
+		io = tester_io_new(sk);
+		tester_io_set_close_on_unref(io, true);
 
-		data->io_id = g_io_add_watch(io, G_IO_IN, listen_cb, NULL);
-		g_io_channel_unref(io);
+		data->io_id = tester_io_add_watch(io, TESTER_IO_IN, listen_cb,
+									NULL);
+		tester_io_unref(io);
 
 		tester_print("Listening for connections");
 	}
@@ -3313,39 +3326,39 @@ static void test_server(const void *test_data)
 	start_test_server(test_data, send_req_new_conn, l2cap_listen_cb);
 }
 
-static gboolean ext_flowctl_accept_2_close_1_listen_cb(GIOChannel *io,
-					GIOCondition cond, gpointer user_data)
+static bool ext_flowctl_accept_2_close_1_listen_cb(struct tester_io *io,
+					uint32_t cond, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	int sk, new_sk;
 	int err = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (err < 0) {
 		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
-	if (!defer_accept(data, g_io_channel_unix_new(new_sk), NULL))
+	if (!defer_accept(data, tester_io_new(new_sk), NULL))
 		goto fail;
 
 	close(new_sk);
 
 	if (data->step--)
-		return TRUE;
+		return true;
 
 	tester_test_passed();
 
 	data->io_id = 0;
-	return FALSE;
+	return false;
 
 fail:
 	tester_test_failed();
 	close(new_sk);
-	return FALSE;
+	return false;
 }
 
 static void test_ext_flowctl_server_accept_2_close_1(const void *test_data)
@@ -3357,14 +3370,14 @@ static void test_ext_flowctl_server_accept_2_close_1(const void *test_data)
 					ext_flowctl_accept_2_close_1_listen_cb);
 }
 
-static gboolean ext_flowctl_nval_conn_req_ready_cb(gpointer ptr)
+static bool ext_flowctl_nval_conn_req_ready_cb(void *ptr)
 {
 	struct test_data *data = tester_get_data();
 	const struct queue_entry *entry;
-	GIOFunc cb = l2cap_accept_cb;
+	tester_io_func_t cb = l2cap_accept_cb;
 
 	if (data->io_id) {
-		g_source_remove(data->io_id);
+		tester_remove_source(data->io_id);
 		data->io_id = 0;
 	}
 
@@ -3375,10 +3388,10 @@ static gboolean ext_flowctl_nval_conn_req_ready_cb(gpointer ptr)
 
 	entry = queue_get_entries(data->io_channels);
 	for (; entry; entry = entry->next) {
-		GIOChannel *io = entry->data;
+		struct tester_io *io = entry->data;
 
-		if (!defer_accept(data, g_io_channel_ref(io), cb)) {
-			g_io_channel_unref(io);
+		if (!defer_accept(data, tester_io_ref(io), cb)) {
+			tester_io_unref(io);
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 			break;
@@ -3388,39 +3401,39 @@ static gboolean ext_flowctl_nval_conn_req_ready_cb(gpointer ptr)
 		cb = NULL;
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean ext_flowctl_nval_conn_req_listen_cb(GIOChannel *io,
-					GIOCondition cond, gpointer user_data)
+static bool ext_flowctl_nval_conn_req_listen_cb(struct tester_io *io,
+					uint32_t cond, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	int sk, new_sk;
-	GIOChannel *new_io;
+	struct tester_io *new_io;
 
 	if (!data->step)
-		return FALSE;
+		return false;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
 		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Accept sk = %d", new_sk);
 
-	new_io = g_io_channel_unix_new(new_sk);
-	g_io_channel_set_close_on_unref(new_io, TRUE);
+	new_io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(new_io, true);
 
 	if (!data->io_channels)
 		data->io_channels = queue_new();
 	queue_push_tail(data->io_channels, new_io);
 
 	if (data->err_io_id) {
-		g_source_remove(data->err_io_id);
+		tester_remove_source(data->err_io_id);
 		data->err_io_id = 0;
 	}
 
@@ -3429,13 +3442,13 @@ static gboolean ext_flowctl_nval_conn_req_listen_cb(GIOChannel *io,
 	if (!data->step) {
 		data->io_id = 0;
 		ext_flowctl_nval_conn_req_ready_cb(NULL);
-		return FALSE;
+		return false;
 	}
 
-	data->err_io_id = g_timeout_add(1000,
-				ext_flowctl_nval_conn_req_ready_cb, NULL);
+	data->err_io_id = timeout_add(1000,
+				ext_flowctl_nval_conn_req_ready_cb, NULL, NULL);
 
-	return TRUE;
+	return true;
 }
 
 static void ext_flowctl_nval_conn_req_conn_cb(uint16_t handle, void *user_data)
-- 
2.56.0

