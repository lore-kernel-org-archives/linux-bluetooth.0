Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684053;
	b=07mJIVR4bm7lkkwcq49iE7x8AVHx0EhNyq71V4vmQrDerCnK6v2ZtusHVqyScswuF2c8
	 DOjnPS425DdZK2cNQXfX4BPFCgyi70PqOfa+fzKnJgSSvjlN5ikrhsldBsBdO+gy+NQA7
	 OawJdsA1tsWyUM1W0D4whEUVhThhhGxTcl/GY6b926jEMELEWown9PePDH7l0MdSHWvya
	 5J4idyYsAyTkj1TErRPnqMjhSfQID146HDG1/nPKEB9kuhD3sgsmWUxDJQu079sQlrrRn
	 6s08cUoMssVQY7F/zspv4NA1ToOLJzrUPdyhrj+Pn0aGb+OOAT5cfwhKN6u2/58GRfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=05zZQU27BSr1zg6gWOsDZB3ubg20YQbDEffEmYH7MhY=;
	b=kUetH6U6QOZC2VMcYTzK6TRXGRmrgaCfP28Ck3Ju2c26xW9gVzBUxzXHaQX02A7MSR89
	 OsnVcWqb6J56mIiEMkW+Anq2a9P3rrRHXCVhyhYajf8wZyPpEJSQYbgzg+te1hAnCFxFm
	 ggRJTUv70uiMAyq99AOnUfFN+q1aKpwdDW7EVepEdQG3HZBq4wWpCxSmhhmj3YzPVLzyq
	 cUA5g4ssu9T1H7sUIzvZJBaZHRc2z0N6OwEr/zyUNnLz5mE0Zs5c/nObmRMXyV6KffEzd
	 N+RJvGj2BiebeH8mF/38JPu//owpqeUjn+RADWrlTzCDhq55k2KgJsCrt6i1FCxbC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peo7xRFQ;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB701606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB701606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peo7xRFQ
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso1326e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684052; x=1793288852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=05zZQU27BSr1zg6gWOsDZB3ubg20YQbDEffEmYH7MhY=;
        b=peo7xRFQi3Jr6ETG/k9vVshX01qpLQOeRIIW0Uru6gfQPVu+plRo8MXh3UpenxpZ/4
         cvgzlc6onlQ4ifAwkxBSP+ml+BkVqmXNyXbbwUB5fHOxftZONisz1hEiw8Ua0uZ3Vw7u
         7sf5x+/KdHOPF3ijczowpJ3qONh7LqvHRRz8Il6uMHC6gr3PzP8lM4NJGT1KAPwcAVi4
         wyWahaWYu9V0tgaA9IDKLo8NLICYseYaSkFPt4KVqvl+2MSoCkO3Mt9jjPKUEb2bRF06
         oOxPNNKSKTM7uUjXf/sdI6Mu7TiVTlHYuxonx+pZHSgq82x/huMbuVmVkmZXiGLKcPnN
         U/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684052; x=1793288852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=05zZQU27BSr1zg6gWOsDZB3ubg20YQbDEffEmYH7MhY=;
        b=kWM4QYMDLVfEmyZ0/YS2zX6BJwRwMbdlGn3h3ci6+xV7wjIrKRGieQKLAljyB3CPbq
         2kDriwQMTzVoZ2pdM4TJ0JLdJYP3opfGUGug0QP5vARLnx9VFXyIP1FM+KRTIHGMZY0n
         d7TI834QH/LT3udtBwcg4iIWW+DDJprz34+hndMScX2Vw7NHBckU2a/Wp0qv8sXgiHQW
         X9vxCk1+6T2o6mBJW64ksfZoRqSeR5V8JXZndnNONClnFQs6PS1Rv8rwq7U9aeQTYS0f
         hlEc0NgklZuX8+cRRwtw1M4PfB1VTYqY83isLX5DU/d7lu4ddV5BFPHv0sLNJHktvXWy
         K2GA==
X-Gm-Message-State: AFq9FYKDbIYJQp4dhWANjWp6eheAPmqKG0Kyv5crIY8RsjsLsr28mtBd
	1KK7KOpvRJL7mSYGPkoI+TiitAysrhzTTZphWP2yvxEv5CWlBrIWzQMNm0wRxFwxM4g=
X-Gm-Gg: AYBFou1aN9roc/Tvs2Qwoq96SiMc/S7V4QFyjI01/oC1XcO2Le6rKIzMPpIEmZEIM1E
	P7c8RFApw+keII43vEwR1u7goBFWJfOfRogegBwI6csHSJuvS6D3P6afF6meqEvDunux6qvCdbP
	E19JUq82Q8Qw1gnOTyXF+CMw1v3hBszjvWFZecm0Ay11zhy3Zn9wKjOTY5c7vJ/J4Qvgv+XDI2+
	/CPclOU5s4h5kbWmzSLPcNzse2fDs74v8HWk93LtYL58442efDnYVKLWzDejL9EmuFRTFOVPqKg
	BHeR2KVfef+YhnxCdaHnTcDUoFQLiXtDy8OnPVrd6XyDK/PA4jBa144NYErx1kx8LN+hFlLS4ft
	JcT9i6ZKvkNoFsqaWmIxCPrVDFIQbQ7jFPwvwUs9F6kYsx3GHrnuV5I7CUgO7onptmxeJk7TaQT
	+KFUHSgfHnms2SzGyiXl6oTrPVUbdk5f+oblZD982lwZ09VWKw128MA9SwbhNgtCKqOt+zOGkcm
	KO/SE2Ipehass63W45XcAZiJOisX4bdYDW0sy0bk0WhjALhTQOJF7AC2AnlBjrnuaEc2/PQ0AdS
	C9qfCgIdmsq+jEC/opnoFgR7UTTzQ+JkLWlr6X24KCgXDpn9n0mKHyFAgWJcQ0146E0=
X-Received: by 2002:a05:6122:130a:b0:5e5:29f7:489 with SMTP id 71dfb90a1353d-5eaebede7f3mr2211957e0c.22.1792684051276;
        Thu, 22 Oct 2026 08:47:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 24/27] tools: Run sco-tester, rfcomm-tester and 6lowpan-tester on the mainloop
Date: Thu, 22 Oct 2026 11:46:57 -0400
Message-ID: <20261022154701.3959500-25-luiz.dentz@gmail.com>
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
timeout_add(), and link them with libshared-mainloop. rfcomm-tester
closes its socket with tester_io_close(), as the mainloop cannot tell
that a descriptor was closed.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools         |  15 +++---
 tools/6lowpan-tester.c |  51 ++++++++++---------
 tools/rfcomm-tester.c  | 105 ++++++++++++++++++++-------------------
 tools/sco-tester.c     | 108 +++++++++++++++++++++--------------------
 4 files changed, 148 insertions(+), 131 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 9f0dd897c607..5a04987ea3ea 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -156,14 +156,15 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c tools/tester.h monitor/bt.h \
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
-tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
+tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c \
+				tools/tester-io.h tools/tester-io.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -194,14 +195,15 @@ tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
 				src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS)
 
-tools_sco_tester_SOURCES = tools/sco-tester.c tools/tester.h monitor/bt.h \
+tools_sco_tester_SOURCES = tools/sco-tester.c \
+				tools/tester-io.h tools/tester-io.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
 tools_hci_tester_LDADD = src/libshared-mainloop.la
@@ -233,14 +235,15 @@ tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
 tools_ioctl_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la
 
-tools_6lowpan_tester_SOURCES = tools/6lowpan-tester.c monitor/bt.h \
+tools_6lowpan_tester_SOURCES = tools/6lowpan-tester.c \
+				tools/tester-io.h tools/tester-io.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_6lowpan_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 endif
 
 if TOOLS
diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index e407684a9e4b..3bb537f1ceaf 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -22,9 +22,10 @@
 #include <net/if.h>
 #include <linux/if_packet.h>
 #include <sys/ioctl.h>
-#include <dirent.h>
 
-#include <glib.h>
+#include <assert.h>
+#include <limits.h>
+#include <dirent.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/mgmt.h"
@@ -34,6 +35,8 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 
@@ -272,7 +275,7 @@ static void test_post_teardown(const void *test_data)
 	int ret;
 
 	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
+		tester_remove_source(data->io_id);
 		data->io_id = 0;
 	}
 
@@ -531,7 +534,7 @@ error:
 	return -EIO;
 }
 
-static gboolean client_do_disconnect(gpointer user_data)
+static bool client_do_disconnect(void *user_data)
 {
 	struct test_data *data = user_data;
 	const uint8_t *client_bdaddr;
@@ -549,11 +552,11 @@ static gboolean client_do_disconnect(gpointer user_data)
 	if (write_6lowpan("6lowpan_control", "disconnect %s 0", addr))
 		tester_test_failed();
 
-	return FALSE;
+	return false;
 }
 
-static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool recv_iface_packet(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct client_data *cdata = data->test_data;
@@ -561,10 +564,10 @@ static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
 	int fd;
 	ssize_t ret;
 
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+	if (cond & (TESTER_IO_ERR | TESTER_IO_HUP | TESTER_IO_NVAL))
 		goto done;
 
-	fd = g_io_channel_unix_get_fd(io);
+	fd = tester_io_get_fd(io);
 	ret = recv(fd, buf, sizeof(buf), 0);
 	if (ret < 0) {
 		tester_print("recv failed");
@@ -575,9 +578,9 @@ static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
 	tester_print("Recv %d bytes", (int)ret);
 
 	if (ret != cdata->send_expect_data_len)
-		return TRUE;
+		return true;
 	if (memcmp(buf, cdata->send_expect_data, ret))
-		return TRUE;
+		return true;
 
 	tester_print("Received sent packet");
 
@@ -588,7 +591,7 @@ static gboolean recv_iface_packet(GIOChannel *io, GIOCondition cond,
 
 done:
 	data->io_id = 0;
-	return FALSE;
+	return false;
 }
 
 /* Find the interface of the controller of this test, the most recent one,
@@ -646,7 +649,7 @@ static bool find_iface(struct test_data *data, char *ifname, size_t len)
 	return best >= 0;
 }
 
-static gboolean client_open_iface(gpointer user_data)
+static bool client_open_iface(void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct client_data *cdata = data->test_data;
@@ -660,30 +663,30 @@ static gboolean client_open_iface(gpointer user_data)
 		data->packet_fd = open_iface(ifname, cdata->sk_type);
 	if (data->packet_fd < 0) {
 		tester_print("Wait for interface...");
-		data->io_id = g_timeout_add(500, client_open_iface, data);
-		return FALSE;
+		data->io_id = timeout_add(500, client_open_iface, data, NULL);
+		return false;
 	}
 
 	if (cdata->send_data) {
 		struct bthost *bthost;
-		GIOChannel *io;
+		struct tester_io *io;
 
 		bthost = hciemu_client_get_host(data->hciemu);
 
-		io = g_io_channel_unix_new(data->packet_fd);
-		data->io_id = g_io_add_watch(io,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				recv_iface_packet, data);
-		g_io_channel_unref(io);
+		io = tester_io_new(data->packet_fd);
+		data->io_id = tester_io_add_watch(io,
+				TESTER_IO_IN | TESTER_IO_ERR | TESTER_IO_HUP |
+				TESTER_IO_NVAL, recv_iface_packet, data);
+		tester_io_unref(io);
 
 		tester_debug("Send %u bytes", cdata->send_data_len);
 		bthost_send_cid(bthost, data->handle, data->dcid,
 				cdata->send_data, cdata->send_data_len);
 	} else if (cdata->disconnect) {
-		data->io_id = g_idle_add(client_do_disconnect, data);
+		data->io_id = timeout_add(0, client_do_disconnect, data, NULL);
 	}
 
-	return FALSE;
+	return false;
 }
 
 static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
@@ -713,7 +716,7 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 
 	/* Wait until kernel handles L2CAP connect RSP */
 	if (cdata->send_data || cdata->disconnect)
-		data->io_id = g_idle_add(client_open_iface, data);
+		data->io_id = timeout_add(0, client_open_iface, data, NULL);
 
 	if (cdata->disable_on_connect) {
 		if (write_6lowpan("6lowpan_enable", "0"))
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index b7f7d9ebd794..998d698c1bb2 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/rfcomm.h"
@@ -29,6 +29,8 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 
@@ -38,7 +40,7 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	unsigned int io_id;
 	uint16_t conn_handle;
 	uint16_t send_len;
@@ -204,12 +206,12 @@ static void test_post_teardown(const void *test_data)
 	struct test_data *data = tester_get_data();
 
 	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
+		tester_remove_source(data->io_id);
 		data->io_id = 0;
 	}
 
 	if (data->io)
-		g_io_channel_unref(data->io);
+		tester_io_unref(data->io);
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
@@ -432,8 +434,8 @@ static int connect_rfcomm_sock(int sk, const bdaddr_t *bdaddr, uint8_t channel)
 	return 0;
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool client_received_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *cli = data->test_data;
@@ -441,7 +443,7 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	ssize_t ret;
 	char buf[248];
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	ret = read(sk, buf, cli->data_len);
 	if (cli->data_len != ret) {
@@ -457,24 +459,24 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
-static gboolean rc_write_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rc_write_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct rfcomm_client_data *cli = data->test_data;
 	int sk;
 	ssize_t ret;
 
-	if (cond & G_IO_NVAL)
+	if (cond & TESTER_IO_NVAL)
 		return false;
 
-	if (cond & (G_IO_HUP | G_IO_ERR))
+	if (cond & (TESTER_IO_HUP | TESTER_IO_ERR))
 		goto done;
 
 	tester_print("Writing %u bytes of data",
 			cli->data_len - data->send_len);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	ret = write(sk, cli->send_data + data->send_len,
 			cli->data_len - data->send_len);
@@ -495,8 +497,8 @@ done:
 	return false;
 }
 
-static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rc_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *cli = data->test_data;
@@ -507,7 +509,7 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -520,12 +522,15 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (cli->send_data) {
-		data->io = g_io_channel_ref(io);
-		cond = G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-		data->io_id = g_io_add_watch(io, cond, rc_write_data, data);
+		data->io = tester_io_ref(io);
+		cond = TESTER_IO_OUT | TESTER_IO_HUP | TESTER_IO_ERR |
+							TESTER_IO_NVAL;
+		data->io_id = tester_io_add_watch(io, cond, rc_write_data,
+									data);
 		return false;
 	} else if (cli->read_data) {
-		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+		tester_io_add_watch(io, TESTER_IO_IN, client_received_data,
+									NULL);
 		bthost_send_rfcomm_data(hciemu_client_get_host(data->hciemu),
 						data->conn_handle,
 						cli->client_channel,
@@ -543,8 +548,8 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
-static gboolean rc_close_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rc_close_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
@@ -585,10 +590,10 @@ static void client_hook_func(const void *data, uint16_t len,
 
 	if (cli->data_len != test_data->recv_len) {
 		if (cli->data_len != test_data->send_len)
-			test_data->io_id = g_io_add_watch(test_data->io,
-						     G_IO_OUT | G_IO_HUP |
-						     G_IO_ERR | G_IO_NVAL,
-						     rc_write_data, test_data);
+			test_data->io_id = tester_io_add_watch(test_data->io,
+					TESTER_IO_OUT | TESTER_IO_HUP |
+					TESTER_IO_ERR | TESTER_IO_NVAL,
+					rc_write_data, test_data);
 		return;
 	}
 
@@ -637,7 +642,7 @@ static void test_connect(const void *test_data)
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const struct rfcomm_client_data *cli = data->test_data;
 	const uint8_t *client_addr, *central_addr;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL, NULL);
@@ -656,25 +661,26 @@ static void test_connect(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
+	io = tester_io_new(sk);
 
 	tester_print("Connect in progress %d", sk);
 
 	if (cli->close) {
-		data->io_id = g_io_add_watch(io, G_IO_NVAL, rc_close_cb, NULL);
-		close(sk);
+		data->io_id = tester_io_add_watch(io, TESTER_IO_NVAL,
+							rc_close_cb, NULL);
+		tester_io_close(io);
 		tester_print("Close socket %d", sk);
 	} else {
-		g_io_channel_set_close_on_unref(io, TRUE);
-		data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb,
-						NULL);
+		tester_io_set_close_on_unref(io, true);
+		data->io_id = tester_io_add_watch(io, TESTER_IO_OUT,
+							rc_connect_cb, NULL);
 	}
 
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool server_received_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
@@ -682,7 +688,7 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	ssize_t ret;
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	ret = read(sk, buf, srv->data_len);
 	if (ret != srv->data_len) {
@@ -698,8 +704,8 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
-static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rfcomm_listen_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
@@ -707,7 +713,7 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
@@ -725,15 +731,15 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 		close(new_sk);
 		return false;
 	} else if (srv->read_data) {
-		GIOChannel *new_io;
+		struct tester_io *new_io;
 
-		new_io = g_io_channel_unix_new(new_sk);
-		g_io_channel_set_close_on_unref(new_io, TRUE);
+		new_io = tester_io_new(new_sk);
+		tester_io_set_close_on_unref(new_io, true);
 
-		data->io_id = g_io_add_watch(new_io, G_IO_IN,
+		data->io_id = tester_io_add_watch(new_io, TESTER_IO_IN,
 						server_received_data, NULL);
 
-		g_io_channel_unref(new_io);
+		tester_io_unref(new_io);
 		return false;
 	}
 
@@ -786,7 +792,7 @@ static void test_server(const void *test_data)
 	const struct rfcomm_server_data *srv = data->test_data;
 	const uint8_t *central_addr;
 	struct bthost *bthost;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	central_addr = hciemu_get_central_bdaddr(data->hciemu);
@@ -805,11 +811,12 @@ static void test_server(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_IN, rfcomm_listen_cb, NULL);
-	g_io_channel_unref(io);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_IN, rfcomm_listen_cb,
+									NULL);
+	tester_io_unref(io);
 
 	tester_print("Listening for connections");
 
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index fca99a91c20f..3604e10f0647 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -18,7 +18,7 @@
 #include <poll.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/sco.h"
@@ -29,6 +29,8 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/tester.h"
+#include "src/shared/timeout.h"
+#include "tools/tester-io.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 
@@ -260,7 +262,7 @@ static void test_data_free(void *test_data)
 	struct test_data *data = test_data;
 
 	if (data->io_id > 0)
-		g_source_remove(data->io_id);
+		tester_remove_source(data->io_id);
 
 	free(data);
 }
@@ -850,29 +852,29 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	return 0;
 }
 
-static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool recv_errqueue(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct sco_client_data *scodata = data->test_data;
-	int sk = g_io_channel_unix_get_fd(io);
+	int sk = tester_io_get_fd(io);
 	int err;
 
 	data->step--;
 
 	err = tx_tstamp_recv(&data->tx_ts, sk, scodata->data_len);
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
 
-static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
+static void sco_tx_timestamping(struct test_data *data, struct tester_io *io)
 {
 	const struct sco_client_data *scodata = data->test_data;
 	int so = scodata->so_timestamping;
@@ -883,7 +885,7 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 	if (!(scodata->so_timestamping & TS_TX_RECORD_MASK))
 		return;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	tester_print("Enabling TX timestamping");
 
@@ -900,11 +902,12 @@ static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
 		return;
 	}
 
-	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
+	data->err_io_id = tester_io_add_watch(io, TESTER_IO_ERR, recv_errqueue,
+									data);
 }
 
-static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sock_received_data(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
@@ -913,20 +916,20 @@ static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
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
 
 	tester_debug("read: %d", (int)len);
 
 	if (len != scodata->data_len) {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	--data->step;
@@ -937,35 +940,35 @@ static gboolean sock_received_data(GIOChannel *io, GIOCondition cond,
 	else if (!data->step)
 		tester_test_passed();
 	else
-		return TRUE;
+		return true;
 
-	return FALSE;
+	return false;
 }
 
-static void sco_recv_data(struct test_data *data, GIOChannel *io)
+static void sco_recv_data(struct test_data *data, struct tester_io *io)
 {
 	const struct sco_client_data *scodata = data->test_data;
 
 	data->step = 0;
 
-	if (rx_timestamping_init(g_io_channel_unix_get_fd(io),
+	if (rx_timestamping_init(tester_io_get_fd(io),
 						scodata->so_timestamping))
 		return;
 
-	g_io_add_watch(io, G_IO_IN, sock_received_data, NULL);
+	tester_io_add_watch(io, TESTER_IO_IN, sock_received_data, NULL);
 
 	++data->step;
 }
 
-static gboolean sco_connect(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sco_connect(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1003,7 +1006,7 @@ static gboolean sco_connect(GIOChannel *io, GIOCondition cond,
 		}
 
 		/* Don't close the socket until all data is sent */
-		g_io_channel_set_close_on_unref(io, FALSE);
+		tester_io_set_close_on_unref(io, false);
 	}
 
 	if (scodata->shutdown) {
@@ -1016,24 +1019,24 @@ static gboolean sco_connect(GIOChannel *io, GIOCondition cond,
 	else if (!data->step)
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
-static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sco_connect_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
 	data->io_id = 0;
 	sco_connect(io, cond, user_data);
-	return FALSE;
+	return false;
 }
 
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
-	GIOChannel *io;
+	struct tester_io *io;
 	int sk;
 
 	sk = create_sco_sock(data);
@@ -1056,12 +1059,13 @@ static void test_connect(const void *test_data)
 
 	data->sk = sk;
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_OUT, sco_connect_cb, NULL);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_OUT, sco_connect_cb,
+									NULL);
 
-	g_io_channel_unref(io);
+	tester_io_unref(io);
 
 	tester_print("Connect in progress");
 }
@@ -1155,7 +1159,7 @@ end:
 static bool hook_delay_evt(const void *msg, uint16_t len, void *user_data)
 {
 	tester_print("Delaying emulator response...");
-	g_usleep(500000);
+	usleep(500000);
 	tester_print("Delaying emulator response... Done.");
 	return true;
 }
@@ -1259,7 +1263,7 @@ static bool hook_simult_disc(const void *msg, uint16_t len, void *user_data)
 static bool hook_delay_cmd(const void *data, uint16_t len, void *user_data)
 {
 	tester_print("Delaying emulator response...");
-	g_usleep(250000);
+	usleep(250000);
 	tester_print("Delaying emulator response... Done.");
 	return true;
 }
@@ -1377,13 +1381,13 @@ fail:
 	return err;
 }
 
-static bool sco_defer_accept(struct test_data *data, GIOChannel *io)
+static bool sco_defer_accept(struct test_data *data, struct tester_io *io)
 {
 	int sk;
 	char c;
 	struct pollfd pfd;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sk;
@@ -1406,20 +1410,20 @@ static bool sco_defer_accept(struct test_data *data, GIOChannel *io)
 	return true;
 }
 
-static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sco_accept_cb(struct tester_io *io, uint32_t cond,
+							void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
 	int sk, new_sk;
-	gboolean ret;
-	GIOChannel *new_io;
+	bool ret;
+	struct tester_io *new_io;
 
 	data->io_id = 0;
 
 	tester_debug("New connection");
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = tester_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
@@ -1427,12 +1431,12 @@ static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
-	new_io = g_io_channel_unix_new(new_sk);
-	g_io_channel_set_close_on_unref(new_io, TRUE);
+	new_io = tester_io_new(new_sk);
+	tester_io_set_close_on_unref(new_io, true);
 
 	if (scodata->defer) {
 		if (scodata->expect_err < 0) {
-			g_io_channel_unref(new_io);
+			tester_io_unref(new_io);
 			tester_test_passed();
 			return false;
 		}
@@ -1446,16 +1450,16 @@ static gboolean sco_accept_cb(GIOChannel *io, GIOCondition cond,
 
 	ret = sco_connect(new_io, cond, user_data);
 
-	g_io_channel_unref(new_io);
+	tester_io_unref(new_io);
 	return ret;
 }
 
-static void setup_listen(struct test_data *data, GIOFunc func)
+static void setup_listen(struct test_data *data, tester_io_func_t func)
 {
 	struct hciemu_client *client;
 	struct bthost *host;
 	int sk;
-	GIOChannel *io;
+	struct tester_io *io;
 
 	sk = listen_sco_sock(data);
 	if (sk < 0) {
@@ -1466,11 +1470,11 @@ static void setup_listen(struct test_data *data, GIOFunc func)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	io = tester_io_new(sk);
+	tester_io_set_close_on_unref(io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_IN, func, NULL);
-	g_io_channel_unref(io);
+	data->io_id = tester_io_add_watch(io, TESTER_IO_IN, func, NULL);
+	tester_io_unref(io);
 
 	tester_print("Listen in progress");
 
-- 
2.56.0

