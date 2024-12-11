Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BC1FF1AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944941; cv=none; b=FrKXf7WCn1CueHvlJLNw9G4PScFrJWdOTJPrgCzB/V+6oRr+bDd6oIdu8RSEZU9THTpag2ng3PA87t1B+vcMxsv9a+r3CNPT0ZmLAvhhSo47ys0M+j3kvWtX8JAoWPZ8Epbw8OgN0aG2OYVXLbjxp2G0eY5/hmy1BKQJRTr+Y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944941; c=relaxed/simple;
	bh=3TZf2VVPG9j2nRnq7uHoKG76sCAYnh5tmXlrlygtsHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSzchiL2vY5ZvwUD8SjrgIVO03khKMG0TVw1miUywqyMVdO/2QN3yyutF9jxP6DtnVgbi+46LTC1xg3lvmlAToc46wt3B41p7rr9KXHhZm6MOwf9j7TwtuHbeKyFjXj78XW60e0OWuoAzMQlybHvjwN3tQU3wEPss1QlPEHUKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEWxEuJ8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEWxEuJ8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef0ef11aafso64776077b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944938; x=1734549738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ6czW7oqxG3C4Lh524NY3ogieEucE1ren2yz0aC2EU=;
        b=UEWxEuJ86w1yqr5oCA3BGWgUICf/cigP779YefFHbrT5hFiJOIlWWtjH6FQSWe+36k
         2KCDnqg3OF3NmaJcU83SU6rGZVAtM0gT6/GAkqZgY8tgkmkJvCDdZQw5GwQmVHDPileo
         VYK0+WC3LNuOriNz0WFrPRFSsUxzDpSk2K0zD732n8Yyg8seSA8bDwrCWJutk9RpoVTE
         O41w1I6kJAYHRCa3wxDCM4IZXeD35UD147k0OtnuNGQm1IrFydBCVRG4v5jq3zEJiH5z
         5hFwGoylLWLCM6VFwhPR6PE9D8TnNk3/NI+SrBeqzR4B/UbBuq1v13CasmGn1mfJFYEc
         1P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944938; x=1734549738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ6czW7oqxG3C4Lh524NY3ogieEucE1ren2yz0aC2EU=;
        b=QaBrWSzXEB2XtrcLzngIooD4v56pXgzaXl0DekC9hSsuomZSq9yZEbgI66lbif8HIw
         Yxg+avcw3j53/cIaiSSNe7gq1EVjFT3nVY2jgZhEfPCAuyNL02LcE0M6WtpWHgDnsLom
         ne9cQa8xbLm2athN3ufdbsGXaRiIq3KsPMEqbhe7TYQZGv7QIcKRY3brCalqOfhw/Mzo
         Sj2amBk59zXCYt3m3vNRnaheNlT3qkCJbzRCfMZwHsgxCHbC37IJPvwm/oymn9r95XH2
         i73UTkzWbWdyHZrjOmxqu3gEjikFe0ZfZ6nvR348aNdOfeKlPQEstJbIRnan3pUCyTTt
         WeEg==
X-Gm-Message-State: AOJu0YzK+NnVv9st4E2Qb5HlcqStHoWtZjhVUZeGLxoqE8VTPIBaw6G0
	IjLuS4xeJqBfwz86GTH11cemRQUFPaSf74pv4ie1Kk5a3hLTgrUHIxnfhQ==
X-Gm-Gg: ASbGncvxz97eyN7BdaOXezq4HLH3+T5jATInEfOiArMUjIE6+PgBQLsxjffi8rVx46c
	mhYLk2dqozComqJSQX2E6GGzpiO8PAkeof04+oM4M67TfISF7Z4giBGM9KcEC4jEVufDMjpeR/D
	wCuRsqs5Q3cHdjT9zNIlOxuiir4mnQBzOUup+wrUoKt/WuGm7ge3G8ONKAGJWJlgCLLn48ipO7t
	LbXZqJDSPh4dRPRC+khGVVRAGiKyjSjA0JkQgzjO3qnLCpRwxaVfexBvv33PADU7voOKWlwP0Au
	YSOSgA4FBvLvkaam9vhMmf22QQ==
X-Google-Smtp-Source: AGHT+IHTLJVdSvIl4HWQWyz+uZBSapI9w/YugMwbGA8py1Iy2U7Bg5mcuQcou/c9zfRYSJ5sLoGdnQ==
X-Received: by 2002:a05:690c:ecc:b0:6ef:60f4:3d41 with SMTP id 00721157ae682-6f19e4f5738mr9212517b3.16.1733944937944;
        Wed, 11 Dec 2024 11:22:17 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14ce8be30sm3670077b3.79.2024.12.11.11.22.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] client: Add HCI submenu
Date: Wed, 11 Dec 2024 14:22:09 -0500
Message-ID: <20241211192210.1864347-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds HCI submenu:

Menu hci:
Available commands:
-------------------
open <index> <chan=raw,user>                      Open HCI channel
cmd <opcode> [parameters...]                      Send HCI data
send <type=acl,sco,iso> <handle> [data...]        Send HCI data
register <event>                                  Register HCI event handler
unregister <event>                                Unregister HCI event handler
close                                             Close HCI channel

Examples:

In order to open a user channel the controller needs to be power off
first:
bluetooth# power off
bluetooth# hci.open 0 user
HCI index 0 user channel opened

Then commands can be sent hci.cmd, so the following is sending HCI reset:
bluetooth# hci.cmd 0x0c03
HCI Command complete:
  00

For sending data packets to specific handle hci.send can be used:
bluetooth# hci.send acl 0x0000
---
 Makefile.tools |   3 +-
 client/hci.c   | 333 +++++++++++++++++++++++++++++++++++++++++++++++++
 client/hci.h   |  12 ++
 client/main.c  |   3 +
 4 files changed, 350 insertions(+), 1 deletion(-)
 create mode 100644 client/hci.c
 create mode 100644 client/hci.h

diff --git a/Makefile.tools b/Makefile.tools
index 71033d6388cf..51a5af6af77e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -14,7 +14,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/admin.h client/admin.c \
 					client/player.h client/player.c \
 					client/mgmt.h client/mgmt.c \
-					client/assistant.h client/assistant.c
+					client/assistant.h client/assistant.c \
+					client/hci.h client/hci.c
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/hci.c b/client/hci.c
new file mode 100644
index 000000000000..69fc4ba91707
--- /dev/null
+++ b/client/hci.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/shell.h"
+#include "src/shared/hci.h"
+#include "monitor/bt.h"
+#include "hci.h"
+
+static struct bt_hci *hci;
+static struct queue *events;
+
+struct hci_event {
+	uint8_t event;
+	unsigned int id;
+};
+
+static void hci_open(int argc, char *argv[])
+{
+	long index;
+	char *endptr = NULL;
+
+	if (hci) {
+		bt_shell_printf("HCI channel already open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	index = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || index < 0 || index > UINT16_MAX) {
+		bt_shell_printf("Invalid index: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!strcasecmp(argv[2], "raw")) {
+		hci = bt_hci_new_raw_device(index);
+		if (!hci) {
+			bt_shell_printf("Unable to open raw channel\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	} else if (!strcasecmp(argv[2], "user")) {
+		hci = bt_hci_new_user_channel(index);
+		if (!hci) {
+			bt_shell_printf("Unable to open user channel\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	} else {
+		bt_shell_printf("Invalid channel: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("HCI index %ld %s channel opened\n", index, argv[2]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static uint8_t *str2bytearray(char *arg, size_t *val_len)
+{
+	uint8_t value[UINT8_MAX];
+	char *entry;
+	unsigned int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= G_N_ELEMENTS(value)) {
+			bt_shell_printf("Too much data\n");
+			return NULL;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			bt_shell_printf("Invalid value at index %d\n", i);
+			return NULL;
+		}
+
+		value[i] = val;
+	}
+
+	*val_len = i;
+
+	return util_memdup(value, i);
+}
+
+static void hci_cmd_complete(const void *data, uint8_t size, void *user_data)
+{
+	bt_shell_printf("HCI Command complete:\n");
+	bt_shell_hexdump(data, size);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void hci_cmd(int argc, char *argv[])
+{
+	long opcode;
+	struct iovec iov = {};
+	char *endptr = NULL;
+	unsigned int ret;
+
+	if (!hci) {
+		bt_shell_printf("HCI channel not open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	opcode = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || opcode < 0 || opcode > UINT16_MAX) {
+		bt_shell_printf("Invalid opcode: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc > 2) {
+		iov.iov_base = str2bytearray(argv[2], &iov.iov_len);
+		if (!iov.iov_base) {
+			bt_shell_printf("Invalid parameters: %s\n", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	ret = bt_hci_send(hci, opcode, iov.iov_base, iov.iov_len,
+				hci_cmd_complete, NULL, NULL);
+
+	free(iov.iov_base);
+
+	if (!ret)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void hci_send(int argc, char *argv[])
+{
+	uint8_t type;
+	long handle;
+	struct iovec iov = {};
+	char *endptr = NULL;
+	bool ret;
+
+	if (!hci) {
+		bt_shell_printf("HCI channel not open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!strcasecmp(argv[1], "acl")) {
+		type = BT_H4_ACL_PKT;
+	} else if (!strcasecmp(argv[1], "sco")) {
+		type = BT_H4_SCO_PKT;
+	} else if (!strcasecmp(argv[1], "iso")) {
+		type = BT_H4_ISO_PKT;
+	} else {
+		bt_shell_printf("Invalid type: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	handle = strtol(argv[2], &endptr, 0);
+	if (!endptr || *endptr != '\0' || handle < 0 || handle > UINT16_MAX) {
+		bt_shell_printf("Invalid handle: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc > 3) {
+		iov.iov_base = str2bytearray(argv[3], &iov.iov_len);
+		if (!iov.iov_base) {
+			bt_shell_printf("Invalid data: %s\n", argv[3]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	ret = bt_hci_send_data(hci, type, handle, iov.iov_base, iov.iov_len);
+
+	free(iov.iov_base);
+
+	return bt_shell_noninteractive_quit(ret ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+
+static bool match_event(const void *data, const void *match_data)
+{
+	const struct hci_event *evt = data;
+	uint8_t event = PTR_TO_UINT(match_data);
+
+	return evt->event == event;
+}
+
+static void hci_evt_received(const void *data, uint8_t size, void *user_data)
+{
+	struct hci_event *evt = user_data;
+
+	bt_shell_printf("HCI Event 0x%02x received:\n", evt->event);
+	bt_shell_hexdump(data, size);
+}
+
+static void hci_register(int argc, char *argv[])
+{
+	struct hci_event *evt;
+	long event;
+	char *endptr = NULL;
+
+	if (!hci) {
+		bt_shell_printf("HCI channel not open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	event = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || event < 0 || event > UINT8_MAX) {
+		bt_shell_printf("Invalid event: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!events)
+		events = queue_new();
+
+	evt = queue_find(events, match_event, UINT_TO_PTR(event));
+	if (evt) {
+		bt_shell_printf("Event already registered\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	evt = new0(struct hci_event, 1);
+	evt->event = event;
+	evt->id = bt_hci_register(hci, event, hci_evt_received, evt, NULL);
+
+	if (!evt->id) {
+		free(evt);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("HCI Event 0x%02x registered\n", (uint8_t)event);
+
+	queue_push_tail(events, evt);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void hci_unregister(int argc, char *argv[])
+{
+	struct hci_event *evt;
+	long event;
+	char *endptr = NULL;
+
+	if (!hci) {
+		bt_shell_printf("HCI channel not open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	event = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || event < 0 || event > UINT8_MAX) {
+		bt_shell_printf("Invalid event: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	evt = queue_find(events, match_event, UINT_TO_PTR(event));
+	if (!evt) {
+		bt_shell_printf("Event not registered\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_hci_unregister(hci, evt->id);
+	queue_remove(events, evt);
+	free(evt);
+
+	bt_shell_printf("HCI Event 0x%02x unregistered\n", (uint8_t)event);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void hci_close(int argc, char *argv[])
+{
+	if (!hci) {
+		bt_shell_printf("HCI channel not open\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_hci_unref(hci);
+	hci = NULL;
+
+	bt_shell_printf("HCI channel closed\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu hci_menu = {
+	.name = "hci",
+	.desc = "HCI Submenu",
+	.entries = {
+	{ "open",        "<index> <chan=raw,user>", hci_open,
+					"Open HCI channel" },
+	{ "cmd",         "<opcode> [parameters...]", hci_cmd,
+					"Send HCI command" },
+	{ "send",        "<type=acl,sco,iso> <handle> [data...]", hci_send,
+					"Send HCI data" },
+	{ "register",    "<event>", hci_register,
+					"Register HCI event handler" },
+	{ "unregister",  "<event>", hci_unregister,
+					"Unregister HCI event handler" },
+	{ "close",         NULL, hci_close, "Close HCI channel" },
+	{} },
+};
+
+void hci_add_submenu(void)
+{
+	bt_shell_add_submenu(&hci_menu);
+}
+
+void hci_remove_submenu(void)
+{
+	if (!hci)
+		return;
+
+	if (events) {
+		queue_destroy(events, free);
+		events = NULL;
+	}
+
+	bt_hci_unref(hci);
+	hci = NULL;
+}
diff --git a/client/hci.h b/client/hci.h
new file mode 100644
index 000000000000..5efd89802452
--- /dev/null
+++ b/client/hci.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 Intel Corporation
+ *
+ *
+ */
+
+void hci_add_submenu(void);
+void hci_remove_submenu(void);
diff --git a/client/main.c b/client/main.c
index 9258b44655dd..c4fc49427021 100644
--- a/client/main.c
+++ b/client/main.c
@@ -37,6 +37,7 @@
 #include "player.h"
 #include "mgmt.h"
 #include "assistant.h"
+#include "hci.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -3207,6 +3208,7 @@ int main(int argc, char *argv[])
 	player_add_submenu();
 	mgmt_add_submenu();
 	assistant_add_submenu();
+	hci_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
@@ -3229,6 +3231,7 @@ int main(int argc, char *argv[])
 	player_remove_submenu();
 	mgmt_remove_submenu();
 	assistant_remove_submenu();
+	hci_remove_submenu();
 
 	g_dbus_client_unref(client);
 
-- 
2.47.1

