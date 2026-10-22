Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684043;
	b=KRm1IsEVJHPJhJ7vvsuDvFkg4oGS+kH6qlHQe1+bEJv18Uw6f50V8nYe4OSIN8Rb1zqA
	 gyOgkf3i07uTIDlAbtieXOV9hn+u9Ai/0Q7fGVJrqkFsNCLNS/28fprE2DsqwJki0k5bX
	 MZ+2nZt/zJSDLiFFxvGUK/fNSXn2J9Nc/p9o/50Neq48IYoHX/JS+OpAIIti1sc6Xpd30
	 az+MNJgLsExPmwMQFvRIMC5Fj5Oi5g206HqGWEhu6CnskZ/E7y516Pdf/wemQt6ImkhgU
	 kw0e4WNxnfcklUo+wHyBT0L27/FLO8k6G5nOB3tFywz7FGAtZpoUY3ZYrAMbduhd3dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g47dLRJ93zqZ83DD8nKV2i525EfDzeXXU6ezqIbEeBk=;
	b=Si5Sm4pwrTYpFYV/2Bbuf0tEUaGvvk5HkLMDVSa51GusjQZS0UGCVGKOaBB6uxDUNHOo
	 QhJrLyNl5LuLcAaL+mZcUesyKFvxDxxVyPh67JnomvaSbH5N2Cf2X1/0TVS7mlR8PJC0u
	 KGG9w8UzozKH3xXajhejk6OS5OahRrL34WWKf0TKPZDnhxsMfVQPPJHychKyTaQNZpy7P
	 pD6NgAr/QoVpYu6M2lI3kRIZLC+mctA0tkLdM+5r+wMAkQc8UUOn8uaKGppoqy9I52n4k
	 Ne53EsYss58VGwvdD2hdngSmuFfnKJDnOQg2JOk9uUrYMAxIQ/QV7yHRe5ACkou1pTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ej1tEO/I";
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B9606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ej1tEO/I
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eadea8f0edso670323e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684041; x=1793288841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g47dLRJ93zqZ83DD8nKV2i525EfDzeXXU6ezqIbEeBk=;
        b=ej1tEO/IfWusFg4YDF22Kbx3NKEi5z3agc7waJPOMKCHssRCiPhNezConouqExXMmr
         TksUvwON9REqZNCVSepztA1dbSfKMzAXFpXpQMacQF8kti/CV6bFBLmx40q9QHyn6pap
         tIHUMatWGtR9uG91E5g+DKiIWZx2CTsXnvCObTTDECXXl8Ui6dmPK3xfTewAujBHsXsS
         UlKtAQGdlcT2lsYgBd+giOQhLLIaPiqlHjQzlVVrsZHzs85UIku4S3hKLdM+2QW9D4CD
         nlJYUzPtV5k0GsSX5XE4mJ/M0cvYTGkYh1a2N82otpKrrUlHftOL4t6Ol0i/zyydVN3L
         1IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684041; x=1793288841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g47dLRJ93zqZ83DD8nKV2i525EfDzeXXU6ezqIbEeBk=;
        b=ybKowhZB6DBBcJUow/63nC8bc0f89f2ru9Uh8jpnQJGWzIrnaCfqLO+/BrbtH7dnKk
         mvxPB9z6Kk4LZ4w0NjZli0x6wJeHwMX/YFbvajL/RH+sQsHm/4Ux8qcyg+yGzKUZVyvs
         q/XnUUeHWNuatMZVRk38EmP6tj7J2zeUM1xN65KryS6lYAJtfprT0qAD8F0vruZr4g3J
         DHybc5dYRT0KK9vjnTmkINRl3G2To5ksVbPezth2a2xzaEFPVLRBYxIt58snPdEISv/h
         VMxe2cy0E2czePLr6vwU+GgR4XezrENmIv9PansWO+oOMk2nKu+UMqz/QfjAD/Csd7/T
         31xQ==
X-Gm-Message-State: AFq9FYKTwG8KGqLZ9DP6xnebL4iH6XikVUfPp4huVE49Af7dZw3PXhcA
	xyHgl+g8YGLh7bhlo7n4BJs4f5Ho7z2IkMRUndpln3rnMlXu+SBuvMNTfMWyEDTPU18=
X-Gm-Gg: AYBFou3GFECGKCaQRpr1i6vtxQ1VeRz0lMA8wJIFk7hyGYwK8bjnCfq5IC9CVf+yXmF
	uUiojzTZVi9N3zLom8oo6toMLZhHhHv8RFDpver1D4L1+0FPGuZl+vALGIh3POvhlj63bKXkt+v
	7BScEXT5UouO6Yuc+UlmpuEOCoEORhSEf3A+SywhWRcYizYXhNwwliSsOF9M3xLbqiGXGRLVXNX
	6d2zu8h2QO/2PCqW48ERqvTgx+Qcy0PWfyLMlmeZsVoYu0R8o2jEfn1qb14KsKassDwpvMzvEtw
	X/yG1iJw23Pb3oRq57ZG0W3B1bTTisMs7YM6eidjcueA2Gg1LkCe+Itlqm7LENyjVAUC/qjGEE2
	xqoVao6Ay7oyiCyIElXJz7IZo4uwd6Wf1pAq76lcaZBlEYqtI4LsWRK5U5m0E4t6W+WPqxn4u3n
	nU2NAH2ggRydnf1/wfMBPx76zkuaRvb0SqmvSFXv+PxsRJZswQDApjKLZt/QVGoY0bDzcVcVFCf
	NpntRm4661uZj3IFp9ExPT39z6cgqFng93z/usqIg1kwwrEwWGHy2Tqjd06j4Y/VZ+xgA9HZhxg
	6qOjZrgKMTVLrIoFW/ncSm59+ve7KM0lWEqPAWurAA4JrA==
X-Received: by 2002:a05:6122:85:b0:5ea:a09b:39cc with SMTP id 71dfb90a1353d-5eafa52ad31mr659266e0c.19.1792684041319;
        Thu, 22 Oct 2026 08:47:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 12/27] emulator: Add vhost-user virtio server to btvirt
Date: Thu, 22 Oct 2026 11:46:45 -0400
Message-ID: <20261022154701.3959500-13-luiz.dentz@gmail.com>
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

Add the -V option, which creates a vhost-user server socket on which
each connection gets a new controller, provided to the guest as a virtio
Bluetooth device. This is how User Mode Linux guests, which can only
attach external devices through vhost-user, get emulated controllers.

Packets for the driver are queued until it posts receive buffers, since
the Linux driver keeps only one posted.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools    |   3 +-
 doc/btvirt.rst    |  26 +++-
 emulator/main.c   |  27 +++-
 emulator/virtio.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++
 emulator/virtio.h |  20 +++
 5 files changed, 391 insertions(+), 8 deletions(-)
 create mode 100644 emulator/virtio.c
 create mode 100644 emulator/virtio.h

diff --git a/Makefile.tools b/Makefile.tools
index cb6c01e5e0d9..6b2adb2f6556 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -103,7 +103,8 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				emulator/smp.c \
 				emulator/phy.h emulator/phy.c \
 				emulator/le.h emulator/le.c \
-				emulator/vhost.h emulator/vhost.c
+				emulator/vhost.h emulator/vhost.c \
+				emulator/virtio.h emulator/virtio.c
 emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
 
 emulator_b1ee_SOURCES = emulator/b1ee.c
diff --git a/doc/btvirt.rst b/doc/btvirt.rst
index 2e016406a4fc..c8e2b0be3cc2 100644
--- a/doc/btvirt.rst
+++ b/doc/btvirt.rst
@@ -32,6 +32,8 @@ and speak HCI. They can be exposed to a Bluetooth stack in several ways:
   appear as ``hciN`` on the machine running btvirt;
 - as H:4 streams on Unix socket servers (**-s**) or a TCP server (**-t**),
   one controller per client connection;
+- as virtio Bluetooth devices on a vhost-user server (**-V**), one
+  controller per connection, for virtual machines;
 - as an H:4 stream on a pseudo terminal (**-S**).
 
 All controllers created by one btvirt process share an emulated air
@@ -45,7 +47,8 @@ btvirt runs until it receives **SIGINT** or **SIGTERM**.
 OPTIONS
 =======
 
-At least one of **-l**, **-s**, **-t**, **-S** or **-U** must be given.
+At least one of **-l**, **-s**, **-t**, **-V**, **-S** or **-U** must be
+given.
 Optional arguments must be attached to the option, as in **-l2**,
 **-t45551** or **--server=/tmp/bt**.
 
@@ -78,6 +81,14 @@ Optional arguments must be attached to the option, as in **-l2**,
                             attached as an H:4 stream. The server listens on
                             127.0.0.1 only.
 
+-V[path], --vhost[=path]    Create a vhost-user server socket
+                            ``bt-vhost-bredrle`` in the directory *path*
+                            (default: ``/tmp``). Each connection gets a new
+                            BR/EDR/LE controller, of the version given with
+                            **-C**, provided to the guest as a virtio
+                            Bluetooth device. See **virtio** for how to
+                            attach it to QEMU or User Mode Linux guests.
+
 -S, --serial                Create a pseudo terminal with a BR/EDR/LE
                             controller attached as an H:4 stream. The path of
                             the terminal is printed on startup; attach it
@@ -99,12 +110,12 @@ Optional arguments must be attached to the option, as in **-l2**,
 
 -C version, --core=version  Core Specification version of the BR/EDR/LE
                             controllers created with **-l**, **-s** (on
-                            ``bt-server-bredrle``) and **-t**. Supported
+                            ``bt-server-bredrle``), **-t** and **-V**. Supported
                             values are ``5.0``, ``5.2``, ``6.0`` and ``6.2``
                             (default).
 
--d, --debug                 Enable debug output for the **-l** and **-s**
-                            controllers.
+-d, --debug                 Enable debug output for the **-l**, **-s** and
+                            **-V** controllers.
 
 -v, --version               Show version.
 
@@ -133,6 +144,13 @@ Serve controllers to virtual machines, one per connecting VM, the way
     $ btvirt --server=/tmp/bt
     $ test-runner -u/tmp/bt/bt-server-bredrle -k bzImage -- ...
 
+Provide controllers to User Mode Linux guests as virtio Bluetooth
+devices, two from the same socket::
+
+    $ btvirt -V/tmp/bt
+    $ linux ... virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40 \
+                virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40
+
 Emulate a Bluetooth 5.2 controller over TCP::
 
     $ btvirt -C 5.2 -t
diff --git a/emulator/main.c b/emulator/main.c
index 61c2f0d5c33d..b448b6c00723 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -27,6 +27,7 @@
 #include "btdev.h"
 #include "server.h"
 #include "vhci.h"
+#include "virtio.h"
 #include "le.h"
 
 static void signal_callback(int signum, void *user_data)
@@ -49,6 +50,8 @@ static void usage(void)
 		"\t-S                    Create local serial port\n"
 		"\t-s[path=/tmp]         Create local server sockets\n"
 		"\t-t[port=45550]        Create a TCP server\n"
+		"\t-V[path=/tmp]         Create local vhost-user virtio\n"
+		"\t                      server socket\n"
 		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
 		"\t-U[num]               Number of test LE controllers\n"
@@ -56,7 +59,7 @@ static void usage(void)
 		"\t-A                    Create AMP controller\n"
 		"\t-C, --core=<version>  Core Specification version of the\n"
 		"\t                      BR/EDR/LE controllers created with\n"
-		"\t                      -l, -s and -t:\n"
+		"\t                      -l, -s, -t and -V:\n"
 		"\t                      5.0, 5.2, 6.0 or 6.2 (default)\n"
 		"\t-h, --help            Show help options\n");
 }
@@ -66,6 +69,7 @@ static const struct option main_options[] = {
 	{ "serial",  no_argument,       NULL, 'S' },
 	{ "server",  optional_argument, NULL, 's' },
 	{ "tcp",     optional_argument, NULL, 't' },
+	{ "vhost",   optional_argument, NULL, 'V' },
 	{ "local",   optional_argument, NULL, 'l' },
 	{ "le",      no_argument,       NULL, 'L' },
 	{ "bredr",   no_argument,       NULL, 'B' },
@@ -126,6 +130,7 @@ int main(int argc, char *argv[])
 	bool server_enabled = false;
 	const char *server_path = "/tmp";
 	uint16_t tcp_port = 0;
+	const char *vhost_path = NULL;
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
@@ -140,7 +145,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::l::LBAC:U::vh",
+		opt = getopt_long(argc, argv, "dSs::t::V::l::LBAC:U::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -163,6 +168,9 @@ int main(int argc, char *argv[])
 			else
 				tcp_port = 45550;
 			break;
+		case 'V':
+			vhost_path = optarg ? optarg : "/tmp";
+			break;
 		case 'l':
 			if (optarg)
 				vhci_count = atoi(optarg);
@@ -209,7 +217,7 @@ int main(int argc, char *argv[])
 		type = bredrle_type;
 
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
-						!tcp_port && !serial_enabled) {
+				!tcp_port && !serial_enabled && !vhost_path) {
 		fprintf(stderr, "No emulator specified\n");
 		return EXIT_FAILURE;
 	}
@@ -306,5 +314,18 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Listening TCP on 127.0.0.1:%d\n", tcp_port);
 	}
 
+	if (vhost_path) {
+		struct vtio *vtio;
+		char path[PATH_MAX];
+
+		snprintf(path, sizeof(path), "%s/%s", vhost_path,
+							"bt-vhost-bredrle");
+		vtio = vtio_open(bredrle_type, path);
+		if (!vtio)
+			fprintf(stderr, "Failed to open vhost-user server\n");
+		else if (debug_enabled)
+			vtio_set_debug(vtio, server_debug, "vhost");
+	}
+
 	return mainloop_run_with_signal(signal_callback, NULL);
 }
diff --git a/emulator/virtio.c b/emulator/virtio.c
new file mode 100644
index 000000000000..47889027075c
--- /dev/null
+++ b/emulator/virtio.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+#include "btdev.h"
+#include "vhost.h"
+#include "virtio.h"
+
+/* Virtio device ID 40, see include/uapi/linux/virtio_bt.h in Linux */
+#define VTIO_F_MSFT_EXT	1
+
+#define VTIO_VQ_TX		0
+#define VTIO_VQ_RX		1
+#define VTIO_NUM_VQS	2
+
+#define VTIO_MSFT_OPCODE	0xfc1e
+
+/* The Linux driver posts receive buffers of this size */
+#define VTIO_MAX_PKT	1000
+
+struct vtio_config {
+	uint8_t  type;
+	uint16_t vendor;
+	uint16_t msft_opcode;
+} __attribute__((packed));
+
+struct vtio {
+	enum btdev_type type;
+	int fd;
+	struct queue *clients;
+	vtio_debug_func_t debug_callback;
+	void *debug_data;
+};
+
+struct client {
+	struct vtio *vtio;
+	struct vhost *vu;
+	struct btdev *btdev;
+	/* Packets for the driver, waiting for receive buffers */
+	struct queue *pending;
+};
+
+struct packet {
+	size_t len;
+	uint8_t data[];
+};
+
+static struct vtio_config config;
+
+static void vtio_debug(struct vtio *vtio, const char *format, ...)
+{
+	char str[128];
+	va_list ap;
+
+	if (!vtio || !vtio->debug_callback)
+		return;
+
+	va_start(ap, format);
+	vsnprintf(str, sizeof(str), format, ap);
+	va_end(ap);
+
+	vtio->debug_callback(str, vtio->debug_data);
+}
+
+static void client_free(void *data)
+{
+	struct client *client = data;
+
+	vhost_free(client->vu);
+	btdev_destroy(client->btdev);
+	queue_destroy(client->pending, free);
+	free(client);
+}
+
+static void flush_pending(struct client *client)
+{
+	struct packet *pkt;
+
+	while ((pkt = queue_peek_head(client->pending))) {
+		struct iovec iov = { pkt->data, pkt->len };
+
+		if (!vhost_push(client->vu, VTIO_VQ_RX, &iov, 1))
+			break;
+
+		queue_pop_head(client->pending);
+		free(pkt);
+	}
+}
+
+static void btdev_send(const struct iovec *iov, int iovlen, void *user_data)
+{
+	struct client *client = user_data;
+	struct packet *pkt;
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < iovlen; i++)
+		len += iov[i].iov_len;
+
+	if (len > VTIO_MAX_PKT) {
+		vtio_debug(client->vtio, "dropping %zu bytes packet", len);
+		return;
+	}
+
+	pkt = malloc(sizeof(*pkt) + len);
+	if (!pkt)
+		return;
+
+	pkt->len = 0;
+	for (i = 0; i < iovlen; i++) {
+		memcpy(pkt->data + pkt->len, iov[i].iov_base, iov[i].iov_len);
+		pkt->len += iov[i].iov_len;
+	}
+
+	/* The driver may have no receive buffer posted, e.g. for back to
+	 * back events, so keep the packet until it posts one.
+	 */
+	queue_push_tail(client->pending, pkt);
+	flush_pending(client);
+}
+
+static void queue_notify(struct vhost *vu, unsigned int index,
+							void *user_data)
+{
+	struct client *client = user_data;
+	uint8_t buf[VTIO_MAX_PKT + 4];
+	ssize_t len;
+
+	switch (index) {
+	case VTIO_VQ_TX:
+		while ((len = vhost_pop(vu, index, buf, sizeof(buf)))) {
+			if (len > 0)
+				btdev_receive_h4(client->btdev, buf, len);
+		}
+		break;
+	case VTIO_VQ_RX:
+		flush_pending(client);
+		break;
+	}
+}
+
+static void disconnect(struct vhost *vu, void *user_data)
+{
+	struct client *client = user_data;
+
+	vtio_debug(client->vtio, "client disconnected");
+
+	/* vu is being torn down by the mainloop and freed by client_free */
+	if (client->vtio)
+		queue_remove(client->vtio->clients, client);
+
+	client_free(client);
+}
+
+static const struct vhost_ops vhost_ops = {
+	.features = 1ULL << VTIO_F_MSFT_EXT,
+	.num_queues = VTIO_NUM_VQS,
+	.config = &config,
+	.config_len = sizeof(config),
+	.queue_notify = queue_notify,
+	.disconnect = disconnect,
+};
+
+static void vu_debug(const char *str, void *user_data)
+{
+	struct client *client = user_data;
+
+	vtio_debug(client->vtio, "vhost-user: %s", str);
+}
+
+static void accept_callback(int fd, uint32_t events, void *user_data)
+{
+	struct vtio *vtio = user_data;
+	struct client *client;
+	int nfd;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(vtio->fd);
+		return;
+	}
+
+	nfd = accept(vtio->fd, NULL, NULL);
+	if (nfd < 0)
+		return;
+
+	client = new0(struct client, 1);
+	client->vtio = vtio;
+	client->pending = queue_new();
+
+	client->btdev = btdev_create(vtio->type, 0x42);
+	if (!client->btdev)
+		goto fail;
+
+	btdev_set_msft_opcode(client->btdev, VTIO_MSFT_OPCODE);
+	btdev_set_send_handler(client->btdev, btdev_send, client);
+
+	client->vu = vhost_new(nfd, &vhost_ops, client);
+	if (!client->vu)
+		goto fail;
+
+	vhost_set_debug(client->vu, vu_debug, client);
+
+	queue_push_tail(vtio->clients, client);
+
+	vtio_debug(vtio, "client connected");
+
+	return;
+
+fail:
+	close(nfd);
+	btdev_destroy(client->btdev);
+	queue_destroy(client->pending, free);
+	free(client);
+}
+
+static void detach_client(void *data)
+{
+	struct client *client = data;
+
+	client->vtio = NULL;
+}
+
+static void vtio_destroy(void *user_data)
+{
+	struct vtio *vtio = user_data;
+
+	queue_destroy(vtio->clients, detach_client);
+	close(vtio->fd);
+	free(vtio);
+}
+
+struct vtio *vtio_open(enum btdev_type type, const char *path)
+{
+	struct vtio *vtio;
+	struct sockaddr_un addr;
+
+	if (strlen(path) >= sizeof(addr.sun_path))
+		return NULL;
+
+	config.msft_opcode = cpu_to_le16(VTIO_MSFT_OPCODE);
+
+	vtio = new0(struct vtio, 1);
+	vtio->type = type;
+	vtio->clients = queue_new();
+
+	vtio->fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (vtio->fd < 0) {
+		perror("Failed to open vhost-user socket");
+		goto fail;
+	}
+
+	unlink(path);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, path, strlen(path));
+
+	if (bind(vtio->fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind vhost-user socket");
+		goto fail;
+	}
+
+	if (listen(vtio->fd, 5) < 0) {
+		perror("Failed to listen on vhost-user socket");
+		goto fail;
+	}
+
+	if (mainloop_add_fd(vtio->fd, EPOLLIN, accept_callback, vtio,
+							vtio_destroy) < 0)
+		goto fail;
+
+	return vtio;
+
+fail:
+	if (vtio->fd >= 0)
+		close(vtio->fd);
+	queue_destroy(vtio->clients, NULL);
+	free(vtio);
+	return NULL;
+}
+
+void vtio_close(struct vtio *vtio)
+{
+	if (!vtio)
+		return;
+
+	mainloop_remove_fd(vtio->fd);
+}
+
+bool vtio_set_debug(struct vtio *vtio,
+			vtio_debug_func_t callback, void *user_data)
+{
+	if (!vtio)
+		return false;
+
+	vtio->debug_callback = callback;
+	vtio->debug_data = user_data;
+
+	return true;
+}
diff --git a/emulator/virtio.h b/emulator/virtio.h
new file mode 100644
index 000000000000..1e1b44f0006a
--- /dev/null
+++ b/emulator/virtio.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#include <stdbool.h>
+
+struct vtio;
+
+struct vtio *vtio_open(enum btdev_type type, const char *path);
+void vtio_close(struct vtio *vtio);
+
+typedef void (*vtio_debug_func_t)(const char *str, void *user_data);
+bool vtio_set_debug(struct vtio *vtio,
+			vtio_debug_func_t callback, void *user_data);
-- 
2.56.0

