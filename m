Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684044;
	b=0KvGrvsoKCT2P+EHba7uYGnjS3hw90oBIsDRITyUYHRxEkZNhpObdidnDUz9+RmMmRsq
	 lSyo6cslgsvyq13IJ1wYKvAMd3VK8bO1mW5TdSaNff/FLyCjwHGJwlmxGccfoCiPGltfH
	 6DmKE9lN+MQ/C3dMQ0NKutuIRTjo3gguVyLKRB1KIU1N14NzllfI2R0Xaey+7UTwDLIho
	 E8YyGLvXADYAzAFtCNUjp1Rw5wmNy9GA5ELdXZGINZK55D7v7CLeQdHj9ohJ3szKKcouV
	 jWW4AEMGPd8iUBSjBc9kNJRMAE2C0rskLjoFQkmIq8meAoipm+EoZvYoKWY5oUyF/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oAudEZUbian2xL+CZEXpZ2MwnCHJr7dH7/nTvNlUNS4=;
	b=TeNCpun/g175gKpxZqvpovHf1Uc0MCVxewUdPjpM/bBirMmJPvtZTE/jsG20eG72AI7e
	 IPTSMpeM/WHR8EMiNuHNzJP0CaiLWh6HH3HaF9lfRkHNKzZZMRoWo+qU8lbMUahB7OQsT
	 EbwvJmEayhFGJqxV0snJO0Vp9ZfJYcksll1ZntYrMroKKZLRF0TQtBxuwi+zKTtM3mM7p
	 /LuKICtxjxv40xyjEboqKksjDN5EY6YCYZQdy4NpqzxhoVkR6oT7Ek2Zezn589uwsqZpZ
	 sZqDnyIYdNARn3pyVkH0nzLv8/7F/6NmkRfXtk8BnSxDLyB1rxbQxdMqMFD3Gp+W/3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S7PPySRo;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E2606A329
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A00E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S7PPySRo
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so28318e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684042; x=1793288842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oAudEZUbian2xL+CZEXpZ2MwnCHJr7dH7/nTvNlUNS4=;
        b=S7PPySRozAHBTJKemdyEBr8Yv7fpMz8aFmmW1xpJsiGS6+84RLwWhmTLx6KZ+Sd3ZV
         f3Hnjoov7WfEB78Gmy+3ENYLFXEVsF/YozQ1MEG7391ALjmULf57pwqv8taGptHIEXop
         ffHEx2UIlyyTlXdVKN0aLFOvoJCsDGAVyDB/LghNu0ZVJdHz8Wfnqbj+L/FTTYqFptbg
         qIn67OsV7TdvZ+AQUaR2zr3JURGqn0pRk7M2a5rQ9YMPV/qUus+kBFsgBUvBgeDif7uj
         +LbW8W013RsNdQ4I8PHodIED92j7DMrXZDgCb9afbdPwWVVChn2SLDRI8alpVGXCRlCr
         /Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684042; x=1793288842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oAudEZUbian2xL+CZEXpZ2MwnCHJr7dH7/nTvNlUNS4=;
        b=M16f+93rI4jGTAC+DftHNE9YckHnjkf9TGbQ1l6TgQImmS8Px6MSEi964Id3pShKlc
         N7se0aEV664JCDYftql4yqYcew/mF/1s2cSXWxORTHHg5jmRYCLCtKreqq0DOlQ7Iris
         1MSLSws9IqcDSj3JGJLwyegvgfK2x4Olj636IzevbiIJa8+5v21t6I4eZtX6IjGFxOa3
         MdGaXVDrX6gdaOUEyVFz3bIZQ0kAXpViHshw3WPHUpNOV5OqS4IPaSbyhHJ3DHxcFDQv
         xh+26ySfE8y+l0R0K81TTmhXv+kdaDP5Up/tRQaNJ2uxHmEtdixnMYQ1iiKjGLMHffgs
         KDWw==
X-Gm-Message-State: AFq9FYIY7VMijpDenSfBqPeQNP48UVVEzogHqTHgmqqU01cpmkd3dDX/
	zD9lgRWaqAi49FoFt6znoPKoPYhTvCON4OLndVkQPuoJ79g/HCtgO8OZpgs8aESarSM=
X-Gm-Gg: AYBFou2aAKnMZ3xajcBAnLEDrQxKrGUfNKGu4Mu2ou4uEwGWF1ZJ5tzkQvR307Nvtak
	31ake/kHnAFVdLm3TRM9b6/DWFkjuCBqbTif9ZOgs1IIroELxufjquWfKciAaQDW6TdUbgsWMgO
	YBihO9u2NNBZctgGzllmMc/Sw1Wp/OlnVviWVYb6fJo/uKN4/duxTNECIL3qvKW7Mx17OmL37Q4
	ldJ5PcySCW1X9XEIPdmKdEqvLDNy0BHqzpDFuwc/hEOZG4Zl8BinAQvzkxBg9MC98DyoH4oQDT1
	JSOdQKXAVwvLL6ZZmpQAaP9O0ajoSyM97mKJ4+q0p1Mm5jBwxPzKsVDTzVBaC55r4SmGXulH1k2
	3VfFp9LXRcVHLxalN8Uc4rK4JqzwEEXOJ45XOUA/SpU/AVfGeEWUqKFjA3qzmfrkcqfy1e+w+br
	3XbY1rVDiOByz1R4NVjsQlqmhOnZ50LzSMHA08jP+Mpke9V9gq2MIKbuv/VeiVNOJmzvki0bPUD
	8grrHXX6COANy0ophZVK6hHsLB9q/UFvrXAUJmtvw7d01m+PLp+6Pz5Xaaj+QPhLPbsd2v8VY7F
	5+TM8F/WA0WSc7yDUiEOwmB0PAFgedloshHXWqo0z3Zryw==
X-Received: by 2002:a05:6122:e1b2:b0:5ea:d2de:eff4 with SMTP id 71dfb90a1353d-5eaebe8a8edmr2154443e0c.22.1792684042169;
        Thu, 22 Oct 2026 08:47:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 13/27] emulator: Add time travel calendar to btvirt
Date: Thu, 22 Oct 2026 11:46:46 -0400
Message-ID: <20261022154701.3959500-14-luiz.dentz@gmail.com>
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

Add the --time option, which makes btvirt the time travel calendar of
User Mode Linux guests started with time-travel=ext, so they share a
simulated clock with btvirt without an external time controller. Time
only advances when every guest waits, and the timers of the emulated
controllers run on the simulated clock. A guest runs exactly at the
time it requested, and GET answers with the current time, which a guest
takes as the time of an interrupt.

The calendar only uses messages. UML uses the file descriptors of the
START acknowledgment without checking how many it received, so send a
shared memory it rejects and /dev/null.

In lock-step, send FREE_UNTIL with the next event of any other client
or timer before RUN, so a guest does not ask before each of its own
events, about four round trips each, and lower it when an earlier event
shows up. A guest sends UPDATE before each virtio notification, but does
not wait for it to be handled, so take its time from UPDATE and stop it
there before acknowledging: it may not run ahead of what the
notification causes, such as an interrupt from the device.

Add tt_set_skew() to let time advance up to a skew beyond the earliest
running guest, and a hold callback for pacing: while held, time advances
no faster than real time, and no FREE_UNTIL is given so pacing can stop
a guest.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools        |   4 +-
 doc/btvirt.rst        |  22 +-
 emulator/main.c       |  27 +-
 emulator/timeout.c    | 102 ++++++
 emulator/timetravel.c | 743 ++++++++++++++++++++++++++++++++++++++++++
 emulator/timetravel.h |  55 ++++
 emulator/virtio.c     |  33 ++
 7 files changed, 981 insertions(+), 5 deletions(-)
 create mode 100644 emulator/timeout.c
 create mode 100644 emulator/timetravel.c
 create mode 100644 emulator/timetravel.h

diff --git a/Makefile.tools b/Makefile.tools
index 6b2adb2f6556..bc92bc02b83d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -104,7 +104,9 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 				emulator/phy.h emulator/phy.c \
 				emulator/le.h emulator/le.c \
 				emulator/vhost.h emulator/vhost.c \
-				emulator/virtio.h emulator/virtio.c
+				emulator/virtio.h emulator/virtio.c \
+				emulator/timetravel.h emulator/timetravel.c \
+				emulator/timeout.c
 emulator_btvirt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
 
 emulator_b1ee_SOURCES = emulator/b1ee.c
diff --git a/doc/btvirt.rst b/doc/btvirt.rst
index c8e2b0be3cc2..16ef55dbb7a0 100644
--- a/doc/btvirt.rst
+++ b/doc/btvirt.rst
@@ -47,8 +47,8 @@ btvirt runs until it receives **SIGINT** or **SIGTERM**.
 OPTIONS
 =======
 
-At least one of **-l**, **-s**, **-t**, **-V**, **-S** or **-U** must be
-given.
+At least one of **-l**, **-s**, **-t**, **-V**, **-S**, **-U** or
+**--time** must be given.
 Optional arguments must be attached to the option, as in **-l2**,
 **-t45551** or **--server=/tmp/bt**.
 
@@ -89,6 +89,17 @@ Optional arguments must be attached to the option, as in **-l2**,
                             Bluetooth device. See **virtio** for how to
                             attach it to QEMU or User Mode Linux guests.
 
+--time[=path]               Create a time travel calendar socket ``bt-time``
+                            in the directory *path* (default: ``/tmp``) for
+                            User Mode Linux guests started with
+                            ``time-travel=ext:<path>/bt-time``. The guests
+                            and btvirt then share a simulated clock: time
+                            only advances when every guest waits, and the
+                            timers of the emulated controllers run on it.
+                            Notifications of **-V** controllers are
+                            exchanged in-band, so they are ordered with
+                            the guests' clocks.
+
 -S, --serial                Create a pseudo terminal with a BR/EDR/LE
                             controller attached as an H:4 stream. The path of
                             the terminal is printed on startup; attach it
@@ -151,6 +162,13 @@ devices, two from the same socket::
     $ linux ... virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40 \
                 virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40
 
+Run the same guests on a simulated clock shared with btvirt::
+
+    $ btvirt --time=/tmp/bt -V/tmp/bt
+    $ linux ... time-travel=ext:/tmp/bt/bt-time \
+                virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40 \
+                virtio_uml.device=/tmp/bt/bt-vhost-bredrle:40
+
 Emulate a Bluetooth 5.2 controller over TCP::
 
     $ btvirt -C 5.2 -t
diff --git a/emulator/main.c b/emulator/main.c
index b448b6c00723..a3b9456bb642 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -28,6 +28,7 @@
 #include "server.h"
 #include "vhci.h"
 #include "virtio.h"
+#include "timetravel.h"
 #include "le.h"
 
 static void signal_callback(int signum, void *user_data)
@@ -52,6 +53,8 @@ static void usage(void)
 		"\t-t[port=45550]        Create a TCP server\n"
 		"\t-V[path=/tmp]         Create local vhost-user virtio\n"
 		"\t                      server socket\n"
+		"\t--time[=path=/tmp]    Create time travel calendar socket\n"
+		"\t                      for User Mode Linux guests\n"
 		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
 		"\t-U[num]               Number of test LE controllers\n"
@@ -70,6 +73,7 @@ static const struct option main_options[] = {
 	{ "server",  optional_argument, NULL, 's' },
 	{ "tcp",     optional_argument, NULL, 't' },
 	{ "vhost",   optional_argument, NULL, 'V' },
+	{ "time",    optional_argument, NULL, 'I' },
 	{ "local",   optional_argument, NULL, 'l' },
 	{ "le",      no_argument,       NULL, 'L' },
 	{ "bredr",   no_argument,       NULL, 'B' },
@@ -131,6 +135,7 @@ int main(int argc, char *argv[])
 	const char *server_path = "/tmp";
 	uint16_t tcp_port = 0;
 	const char *vhost_path = NULL;
+	const char *time_path = NULL;
 	bool serial_enabled = false;
 	int letest_count = 0;
 	int vhci_count = 0;
@@ -145,7 +150,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::V::l::LBAC:U::vh",
+		opt = getopt_long(argc, argv, "dSs::t::V::I::l::LBAC:U::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -168,6 +173,9 @@ int main(int argc, char *argv[])
 			else
 				tcp_port = 45550;
 			break;
+		case 'I':
+			time_path = optarg ? optarg : "/tmp";
+			break;
 		case 'V':
 			vhost_path = optarg ? optarg : "/tmp";
 			break;
@@ -217,13 +225,28 @@ int main(int argc, char *argv[])
 		type = bredrle_type;
 
 	if (letest_count < 1 && vhci_count < 1 && !server_enabled &&
-				!tcp_port && !serial_enabled && !vhost_path) {
+				!tcp_port && !serial_enabled && !vhost_path &&
+				!time_path) {
 		fprintf(stderr, "No emulator specified\n");
 		return EXIT_FAILURE;
 	}
 
 	printf("Bluetooth emulator ver %s\n", VERSION);
 
+	/* Before any controller, so their timers use the simulated clock */
+	if (time_path) {
+		char path[PATH_MAX];
+
+		snprintf(path, sizeof(path), "%s/%s", time_path, "bt-time");
+		if (!tt_open(path)) {
+			fprintf(stderr, "Failed to open time travel socket\n");
+			return EXIT_FAILURE;
+		}
+
+		if (debug_enabled)
+			tt_set_debug(server_debug, "time");
+	}
+
 	for (i = 0; i < letest_count; i++) {
 		struct bt_le *le;
 
diff --git a/emulator/timeout.c b/emulator/timeout.c
new file mode 100644
index 000000000000..772cbfa4d4ce
--- /dev/null
+++ b/emulator/timeout.c
@@ -0,0 +1,102 @@
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
+/* Timeouts for btvirt: on the simulated clock of the time travel calendar
+ * when it is enabled, otherwise on the mainloop like
+ * src/shared/timeout-mainloop.c.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/util.h"
+#include "src/shared/timeout.h"
+
+#include "timetravel.h"
+
+/* Calendar timer IDs are kept apart from the mainloop ones */
+#define TT_TIMEOUT_ID	0x80000000U
+
+struct timeout_data {
+	int id;
+	timeout_func_t func;
+	timeout_destroy_func_t destroy;
+	unsigned int timeout;
+	void *user_data;
+};
+
+static void timeout_callback(int id, void *user_data)
+{
+	struct timeout_data *data = user_data;
+
+	if (data->func(data->user_data) &&
+			!mainloop_modify_timeout(data->id, data->timeout))
+		return;
+
+	mainloop_remove_timeout(data->id);
+}
+
+static void timeout_destroy(void *user_data)
+{
+	struct timeout_data *data = user_data;
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	free(data);
+}
+
+unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	struct timeout_data *data;
+
+	if (tt_enabled())
+		return TT_TIMEOUT_ID | tt_timeout_add(timeout, func, user_data,
+								destroy);
+
+	data = new0(struct timeout_data, 1);
+	data->func = func;
+	data->user_data = user_data;
+	data->timeout = timeout;
+	data->destroy = destroy;
+
+	data->id = mainloop_add_timeout(timeout, timeout_callback, data,
+							timeout_destroy);
+	if (data->id < 0) {
+		free(data);
+		return 0;
+	}
+
+	return (unsigned int) data->id;
+}
+
+void timeout_remove(unsigned int id)
+{
+	if (!id)
+		return;
+
+	if (id & TT_TIMEOUT_ID) {
+		tt_timeout_remove(id & ~TT_TIMEOUT_ID);
+		return;
+	}
+
+	mainloop_remove_timeout((int) id);
+}
+
+unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	return timeout_add(timeout * 1000, func, user_data, destroy);
+}
diff --git a/emulator/timetravel.c b/emulator/timetravel.c
new file mode 100644
index 000000000000..c1938ed23bdc
--- /dev/null
+++ b/emulator/timetravel.c
@@ -0,0 +1,743 @@
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
+#define _GNU_SOURCE
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+#include "timetravel.h"
+
+/* Protocol of include/uapi/linux/um_timetravel.h in Linux */
+#define TT_ACK		0
+#define TT_START	1
+#define TT_REQUEST	2
+#define TT_WAIT		3
+#define TT_GET		4
+#define TT_UPDATE	5
+#define TT_RUN		6
+#define TT_FREE_UNTIL	7
+#define TT_GET_TOD	8
+#define TT_BROADCAST	9
+
+#define TT_SHM_SIZE	4096
+
+struct tt_msg {
+	uint32_t op;
+	uint32_t seq;
+	uint64_t time;
+} __attribute__((packed));
+
+struct tt_client {
+	int fd;
+	uint16_t id;
+	bool waiting;
+	bool has_request;
+	uint64_t request;
+	/* Time the client runs at, as far as known */
+	uint64_t time;
+	/* Time the running client may run until without asking, 0 if none */
+	uint64_t free_until;
+};
+
+struct tt_flush {
+	tt_flush_func_t func;
+	void *user_data;
+};
+
+struct tt_timer {
+	unsigned int id;
+	uint64_t time;
+	uint64_t interval;
+	tt_timeout_func_t func;
+	tt_destroy_func_t destroy;
+	void *user_data;
+};
+
+static struct {
+	int fd;
+	struct queue *clients;
+	struct queue *timers;
+	uint64_t now;
+	uint64_t skew;
+	uint64_t tod;
+	uint16_t next_id;
+	unsigned int next_timer;
+	bool scheduling;
+	struct queue *flushes;
+	tt_hold_func_t hold;
+	void *hold_data;
+	/* While held, time advances no faster than real time from here */
+	bool held;
+	uint64_t held_sim;
+	uint64_t held_wall;
+	int pace_id;
+	tt_debug_func_t debug;
+	void *debug_data;
+} tt = { .fd = -1 };
+
+static void tt_debug(const char *format, ...)
+{
+	char str[128];
+	va_list ap;
+
+	if (!tt.debug)
+		return;
+
+	va_start(ap, format);
+	vsnprintf(str, sizeof(str), format, ap);
+	va_end(ap);
+
+	tt.debug(str, tt.debug_data);
+}
+
+static void send_msg(struct tt_client *client, uint32_t op, uint32_t seq,
+							uint64_t time)
+{
+	struct tt_msg msg = { .op = op, .seq = seq, .time = time };
+
+	if (write(client->fd, &msg, sizeof(msg)) < 0)
+		tt_debug("client %u: write failed", client->id);
+}
+
+/* The ACK to START may carry a shared memory and a log file descriptor.
+ * This calendar only uses messages, but UML uses the descriptors it
+ * receives without checking how many it got, so send a shared memory it
+ * rejects (version 0) and /dev/null.
+ */
+static void send_start_ack(struct tt_client *client, uint32_t seq)
+{
+	struct tt_msg msg = { .op = TT_ACK, .seq = seq, .time = client->id };
+	char control[CMSG_SPACE(sizeof(int) * 2)];
+	struct iovec iov = { &msg, sizeof(msg) };
+	struct msghdr mh = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg;
+	int fds[2];
+
+	fds[0] = memfd_create("bt-time-shm", MFD_CLOEXEC);
+	fds[1] = open("/dev/null", O_WRONLY | O_CLOEXEC);
+	if (fds[0] < 0 || fds[1] < 0 || ftruncate(fds[0], TT_SHM_SIZE) < 0) {
+		tt_debug("client %u: no file descriptors for START",
+								client->id);
+		send_msg(client, TT_ACK, seq, client->id);
+		goto done;
+	}
+
+	memset(control, 0, sizeof(control));
+	cmsg = CMSG_FIRSTHDR(&mh);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
+	if (sendmsg(client->fd, &mh, 0) < 0)
+		tt_debug("client %u: sendmsg failed", client->id);
+
+done:
+	if (fds[0] >= 0)
+		close(fds[0]);
+	if (fds[1] >= 0)
+		close(fds[1]);
+}
+
+static void find_running(void *data, void *user_data)
+{
+	struct tt_client *client = data;
+	uint64_t *min = user_data;
+
+	if (!client->waiting && client->time < *min)
+		*min = client->time;
+}
+
+static void find_next_client(void *data, void *user_data)
+{
+	struct tt_client *client = data;
+	struct tt_client **next = user_data;
+
+	if (!client->waiting || !client->has_request)
+		return;
+
+	if (!*next || client->request < (*next)->request)
+		*next = client;
+}
+
+static void find_next_timer(void *data, void *user_data)
+{
+	struct tt_timer *timer = data;
+	struct tt_timer **next = user_data;
+
+	if (!*next || timer->time < (*next)->time)
+		*next = timer;
+}
+
+static void timer_free(void *data)
+{
+	struct tt_timer *timer = data;
+
+	if (timer->destroy)
+		timer->destroy(timer->user_data);
+
+	free(timer);
+}
+
+static void fire_timer(struct tt_timer *timer)
+{
+	if (timer->func(timer->user_data)) {
+		/* The callback may have removed the timer */
+		if (queue_find(tt.timers, NULL, timer)) {
+			timer->time = tt.now + timer->interval;
+			return;
+		}
+	}
+
+	if (queue_remove(tt.timers, timer))
+		timer_free(timer);
+}
+
+static void run_flush(void *data, void *user_data)
+{
+	struct tt_flush *flush = data;
+
+	flush->func(flush->user_data);
+}
+
+static void schedule(void);
+
+struct free_limit {
+	struct tt_client *client;
+	uint64_t time;
+};
+
+static void find_free_limit(void *data, void *user_data)
+{
+	struct tt_client *client = data;
+	struct free_limit *limit = user_data;
+
+	if (client == limit->client)
+		return;
+
+	/* A client that has not waited yet may request any time */
+	if (!client->waiting)
+		limit->time = MIN(limit->time, tt.now);
+	else if (client->has_request)
+		limit->time = MIN(limit->time, client->request);
+}
+
+static void find_timer_limit(void *data, void *user_data)
+{
+	struct tt_timer *timer = data;
+	uint64_t *limit = user_data;
+
+	*limit = MIN(*limit, timer->time);
+}
+
+/* How far a client may run without asking: up to the earliest event of any
+ * other client or timer. Only in lock-step, and not while time may be
+ * paced, as pacing must be able to stop the client.
+ */
+static uint64_t free_until(struct tt_client *client)
+{
+	struct free_limit limit = { client, UINT64_MAX };
+
+	if (tt.skew || tt.hold)
+		return 0;
+
+	queue_foreach(tt.clients, find_free_limit, &limit);
+	queue_foreach(tt.timers, find_timer_limit, &limit.time);
+
+	return limit.time;
+}
+
+/* Lower the limit of a running client when an earlier event appeared. This
+ * happens in response to a client, e.g. while it waits for its virtio
+ * notification to be acknowledged, so it receives the new limit before it
+ * runs further.
+ */
+static void update_free_until(void *data, void *user_data)
+{
+	struct tt_client *client = data;
+	uint64_t limit;
+
+	if (client->waiting || !client->free_until)
+		return;
+
+	limit = free_until(client);
+	if (limit >= client->free_until)
+		return;
+
+	client->free_until = limit;
+	send_msg(client, TT_FREE_UNTIL, 0, limit);
+}
+
+static uint64_t wall_now(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+
+	return (uint64_t) ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static void pace_callback(int id, void *user_data)
+{
+	mainloop_remove_timeout(id);
+	tt.pace_id = 0;
+	schedule();
+}
+
+/* Limit of time while held: real time elapsed since the hold started */
+static uint64_t hold_limit(void)
+{
+	bool hold = tt.hold && tt.hold(tt.hold_data);
+
+	if (!hold) {
+		tt.held = false;
+		return UINT64_MAX;
+	}
+
+	if (!tt.held) {
+		tt.held = true;
+		tt.held_sim = tt.now;
+		tt.held_wall = wall_now();
+	}
+
+	return tt.held_sim + (wall_now() - tt.held_wall);
+}
+
+/* Schedule again when real time catches up with the next event */
+static void pace(uint64_t next, uint64_t limit)
+{
+	unsigned int msec = (next - limit) / 1000000ULL + 1;
+
+	if (tt.pace_id > 0)
+		return;
+
+	tt.pace_id = mainloop_add_timeout(MIN(msec, 100U), pace_callback,
+								NULL, NULL);
+}
+
+/* Run whichever is due first, a timer of this process or the client with
+ * the earliest request. In lock-step (no skew) time only advances when
+ * every client waits. With a skew, time may advance up to that much beyond
+ * the earliest running client, so clients run their own events in parallel
+ * while others compute, which takes no simulated time.
+ */
+static void schedule(void)
+{
+	if (tt.scheduling)
+		return;
+
+	tt.scheduling = true;
+
+	while (1) {
+		struct tt_client *client = NULL;
+		struct tt_timer *timer = NULL;
+		uint64_t running = UINT64_MAX;
+		uint64_t limit = UINT64_MAX;
+		uint64_t hold;
+		uint64_t next;
+
+		queue_foreach(tt.flushes, run_flush, NULL);
+
+		if (queue_isempty(tt.clients))
+			break;
+
+		queue_foreach(tt.clients, find_running, &running);
+		if (running != UINT64_MAX) {
+			if (!tt.skew) {
+				queue_foreach(tt.clients, update_free_until,
+									NULL);
+				break;
+			}
+			limit = running + tt.skew;
+		}
+
+		hold = hold_limit();
+
+		queue_foreach(tt.clients, find_next_client, &client);
+		queue_foreach(tt.timers, find_next_timer, &timer);
+
+		if (timer && (!client || timer->time <= client->request)) {
+			next = timer->time;
+			client = NULL;
+		} else if (client) {
+			next = client->request;
+			timer = NULL;
+		} else {
+			break;
+		}
+
+		if (next > limit)
+			break;
+
+		if (next > hold) {
+			pace(next, hold);
+			break;
+		}
+
+		if (next > tt.now)
+			tt.now = next;
+
+		if (timer) {
+			fire_timer(timer);
+			continue;
+		}
+
+		client->waiting = false;
+		client->has_request = false;
+		client->time = next;
+
+		/* Let the client run until the next event of another one,
+		 * instead of asking for each of its own events.
+		 */
+		client->free_until = free_until(client);
+		if (client->free_until)
+			send_msg(client, TT_FREE_UNTIL, 0, client->free_until);
+
+		send_msg(client, TT_RUN, 0, next);
+	}
+
+	tt.scheduling = false;
+}
+
+void tt_schedule(void)
+{
+	if (tt_enabled())
+		schedule();
+}
+
+static void handle_msg(struct tt_client *client, struct tt_msg *msg)
+{
+	switch (msg->op) {
+	case TT_ACK:
+		/* ACK of a RUN */
+		return;
+	case TT_START:
+		client->id = tt.next_id++;
+		client->time = tt.now;
+		tt_debug("client %u started", client->id);
+		send_start_ack(client, msg->seq);
+		return;
+	case TT_REQUEST:
+		client->has_request = true;
+		/* The guest must run exactly at the time of its event */
+		client->request = msg->time;
+		send_msg(client, TT_ACK, msg->seq, 0);
+		break;
+	case TT_WAIT:
+		client->waiting = true;
+		client->free_until = 0;
+		send_msg(client, TT_ACK, msg->seq, 0);
+		break;
+	case TT_GET:
+		/* The guest takes it as the time of an interrupt: the current
+		 * time, which no guest is ahead of.
+		 */
+		client->time = MAX(client->time, tt.now);
+		send_msg(client, TT_ACK, msg->seq, client->time);
+		return;
+	case TT_UPDATE:
+		if (msg->time > client->time)
+			client->time = msg->time;
+		/* In lock-step the running client sets the time, which may be
+		 * ahead of the calendar when it runs until a FREE_UNTIL.
+		 */
+		if (!tt.skew && !client->waiting && client->time > tt.now)
+			tt.now = client->time;
+		/* The guest sends UPDATE before a virtio notification, which
+		 * it does not wait for, and runs on meanwhile. Stop it at this
+		 * time before acknowledging, so it cannot run ahead of what
+		 * the notification causes, e.g. the device's interrupt.
+		 */
+		if (client->free_until && client->free_until > client->time) {
+			client->free_until = client->time;
+			send_msg(client, TT_FREE_UNTIL, 0, client->time);
+		}
+		send_msg(client, TT_ACK, msg->seq, 0);
+		break;
+	case TT_GET_TOD:
+		send_msg(client, TT_ACK, msg->seq, tt.tod + tt.now);
+		return;
+	default:
+		tt_debug("client %u: unsupported op %u", client->id, msg->op);
+		send_msg(client, TT_ACK, msg->seq, 0);
+		return;
+	}
+}
+
+/* Returns 1 if a message was handled, 0 if none is pending and -1 if the
+ * connection failed.
+ */
+static int read_msg(struct tt_client *client)
+{
+	struct tt_msg msg;
+	ssize_t len;
+
+	len = recv(client->fd, &msg, sizeof(msg), MSG_DONTWAIT);
+	if (len < 0 && (errno == EAGAIN || errno == EINTR))
+		return 0;
+
+	if (len != sizeof(msg)) {
+		tt_debug("client %u: read %zd", client->id, len);
+		return -1;
+	}
+
+	handle_msg(client, &msg);
+
+	return 1;
+}
+
+static void client_destroy(void *data)
+{
+	struct tt_client *client = data;
+
+	tt_debug("client %u disconnected", client->id);
+
+	queue_remove(tt.clients, client);
+	close(client->fd);
+	free(client);
+
+	/* Clients and back-ends are destroyed in any order on shutdown, so
+	 * only schedule while the calendar is open.
+	 */
+	if (tt.fd >= 0)
+		schedule();
+}
+
+static void client_callback(int fd, uint32_t events, void *user_data)
+{
+	struct tt_client *client = user_data;
+
+	int ret;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(client->fd);
+		return;
+	}
+
+	/* Process everything that is pending before scheduling, messages
+	 * may also have been processed already by tt_process().
+	 */
+	while ((ret = read_msg(client)) > 0)
+		;
+
+	if (ret < 0) {
+		mainloop_remove_fd(client->fd);
+		return;
+	}
+
+	schedule();
+}
+
+static void process_client(void *data, void *user_data)
+{
+	struct tt_client *client = data;
+
+	while (read_msg(client) > 0)
+		;
+}
+
+void tt_process(void)
+{
+	queue_foreach(tt.clients, process_client, NULL);
+}
+
+static void accept_callback(int fd, uint32_t events, void *user_data)
+{
+	struct tt_client *client;
+	int nfd;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(fd);
+		return;
+	}
+
+	nfd = accept(fd, NULL, NULL);
+	if (nfd < 0)
+		return;
+
+	client = new0(struct tt_client, 1);
+	client->fd = nfd;
+
+	if (mainloop_add_fd(nfd, EPOLLIN, client_callback, client,
+						client_destroy) < 0) {
+		close(nfd);
+		free(client);
+		return;
+	}
+
+	queue_push_tail(tt.clients, client);
+}
+
+static void tt_destroy(void *user_data)
+{
+	close(tt.fd);
+	tt.fd = -1;
+}
+
+bool tt_open(const char *path)
+{
+	struct sockaddr_un addr;
+	struct timespec ts;
+
+	if (tt.fd >= 0 || strlen(path) >= sizeof(addr.sun_path))
+		return false;
+
+	tt.fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (tt.fd < 0)
+		return false;
+
+	unlink(path);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, path, strlen(path));
+
+	if (bind(tt.fd, (struct sockaddr *) &addr, sizeof(addr)) < 0 ||
+						listen(tt.fd, 5) < 0)
+		goto fail;
+
+	if (mainloop_add_fd(tt.fd, EPOLLIN, accept_callback, NULL,
+							tt_destroy) < 0)
+		goto fail;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	tt.tod = (uint64_t) ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+	tt.clients = queue_new();
+	tt.timers = queue_new();
+	tt.next_id = 1;
+
+	return true;
+
+fail:
+	close(tt.fd);
+	tt.fd = -1;
+	return false;
+}
+
+void tt_close(void)
+{
+	if (tt.fd >= 0)
+		mainloop_remove_fd(tt.fd);
+}
+
+bool tt_enabled(void)
+{
+	return tt.fd >= 0;
+}
+
+uint64_t tt_now(void)
+{
+	return tt.now;
+}
+
+void tt_set_skew(unsigned int msec)
+{
+	tt.skew = (uint64_t) msec * 1000000ULL;
+}
+
+void tt_set_hold(tt_hold_func_t func, void *user_data)
+{
+	tt.hold = func;
+	tt.hold_data = user_data;
+}
+
+static bool match_flush(const void *data, const void *match_data)
+{
+	const struct tt_flush *flush = data;
+	const struct tt_flush *match = match_data;
+
+	return flush->func == match->func &&
+				flush->user_data == match->user_data;
+}
+
+void tt_remove_flush(tt_flush_func_t func, void *user_data)
+{
+	struct tt_flush match = { .func = func, .user_data = user_data };
+
+	free(queue_remove_if(tt.flushes, match_flush, &match));
+}
+
+void tt_add_flush(tt_flush_func_t func, void *user_data)
+{
+	struct tt_flush *flush;
+
+	if (!tt.flushes)
+		tt.flushes = queue_new();
+
+	flush = new0(struct tt_flush, 1);
+	flush->func = func;
+	flush->user_data = user_data;
+
+	queue_push_tail(tt.flushes, flush);
+}
+
+unsigned int tt_timeout_add(unsigned int msec, tt_timeout_func_t func,
+				void *user_data, tt_destroy_func_t destroy)
+{
+	struct tt_timer *timer;
+
+	timer = new0(struct tt_timer, 1);
+	timer->id = ++tt.next_timer;
+	timer->interval = (uint64_t) msec * 1000000ULL;
+	timer->time = tt.now + timer->interval;
+	timer->func = func;
+	timer->user_data = user_data;
+	timer->destroy = destroy;
+
+	queue_push_tail(tt.timers, timer);
+
+	return timer->id;
+}
+
+static bool match_timer(const void *data, const void *match_data)
+{
+	const struct tt_timer *timer = data;
+
+	return timer->id == PTR_TO_UINT(match_data);
+}
+
+void tt_timeout_remove(unsigned int id)
+{
+	struct tt_timer *timer;
+
+	timer = queue_remove_if(tt.timers, match_timer, UINT_TO_PTR(id));
+	if (timer)
+		timer_free(timer);
+}
+
+void tt_set_debug(tt_debug_func_t callback, void *user_data)
+{
+	tt.debug = callback;
+	tt.debug_data = user_data;
+}
diff --git a/emulator/timetravel.h b/emulator/timetravel.h
new file mode 100644
index 000000000000..45b9d4ef69f2
--- /dev/null
+++ b/emulator/timetravel.h
@@ -0,0 +1,55 @@
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
+#include <stdint.h>
+
+/* Time travel calendar for User Mode Linux (time-travel=ext) guests */
+
+bool tt_open(const char *path);
+void tt_close(void);
+bool tt_enabled(void);
+
+/* Let time advance up to msec beyond the earliest running guest, so guests
+ * run in parallel; 0 (default) is lock-step.
+ */
+void tt_set_skew(unsigned int msec);
+
+/* Current simulated time in nanoseconds */
+uint64_t tt_now(void);
+
+/* Called before advancing time, to process pending device input */
+typedef void (*tt_flush_func_t)(void *user_data);
+void tt_add_flush(tt_flush_func_t func, void *user_data);
+void tt_remove_flush(tt_flush_func_t func, void *user_data);
+
+/* While the hold function returns true, time advances no faster than real
+ * time. Used while a peer outside the simulation, e.g. a test driver, has
+ * not asked anything of the guests, so they don't run ahead of it.
+ */
+typedef bool (*tt_hold_func_t)(void *user_data);
+void tt_set_hold(tt_hold_func_t func, void *user_data);
+
+/* Advance time if every guest waits, e.g. after processing device input */
+void tt_schedule(void);
+
+/* Process pending calendar messages without advancing time, used while
+ * waiting for a guest that may itself be waiting for the calendar.
+ */
+void tt_process(void);
+
+typedef bool (*tt_timeout_func_t)(void *user_data);
+typedef void (*tt_destroy_func_t)(void *user_data);
+unsigned int tt_timeout_add(unsigned int msec, tt_timeout_func_t func,
+				void *user_data, tt_destroy_func_t destroy);
+void tt_timeout_remove(unsigned int id);
+
+typedef void (*tt_debug_func_t)(const char *str, void *user_data);
+void tt_set_debug(tt_debug_func_t callback, void *user_data);
diff --git a/emulator/virtio.c b/emulator/virtio.c
index 47889027075c..34c8f5d3f93c 100644
--- a/emulator/virtio.c
+++ b/emulator/virtio.c
@@ -27,6 +27,7 @@
 
 #include "btdev.h"
 #include "vhost.h"
+#include "timetravel.h"
 #include "virtio.h"
 
 /* Virtio device ID 40, see include/uapi/linux/virtio_bt.h in Linux */
@@ -160,6 +161,34 @@ static void queue_notify(struct vhost *vu, unsigned int index,
 		flush_pending(client);
 		break;
 	}
+
+	/* The guest may wait for the calendar now */
+	tt_schedule();
+}
+
+/* The guest acknowledges in-band notifications only after its calendar
+ * requests are answered, so keep serving the calendar meanwhile.
+ */
+static void vhost_wait(struct vhost *vu, void *user_data)
+{
+	tt_process();
+}
+
+static void flush_client(void *data, void *user_data)
+{
+	struct client *client = data;
+
+	vhost_process(client->vu);
+}
+
+/* Process guest notifications sent before the guest waited, so time does
+ * not advance past them.
+ */
+static void flush(void *user_data)
+{
+	struct vtio *vtio = user_data;
+
+	queue_foreach(vtio->clients, flush_client, NULL);
 }
 
 static void disconnect(struct vhost *vu, void *user_data)
@@ -182,6 +211,7 @@ static const struct vhost_ops vhost_ops = {
 	.config_len = sizeof(config),
 	.queue_notify = queue_notify,
 	.disconnect = disconnect,
+	.wait = vhost_wait,
 };
 
 static void vu_debug(const char *str, void *user_data)
@@ -247,6 +277,7 @@ static void vtio_destroy(void *user_data)
 {
 	struct vtio *vtio = user_data;
 
+	tt_remove_flush(flush, vtio);
 	queue_destroy(vtio->clients, detach_client);
 	close(vtio->fd);
 	free(vtio);
@@ -292,6 +323,8 @@ struct vtio *vtio_open(enum btdev_type type, const char *path)
 							vtio_destroy) < 0)
 		goto fail;
 
+	tt_add_flush(flush, vtio);
+
 	return vtio;
 
 fail:
-- 
2.56.0

