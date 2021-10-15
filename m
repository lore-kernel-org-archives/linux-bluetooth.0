Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894D0611C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhJOFLn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhJOFLm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B0C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g14so7431038pfm.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w1mMCvF27i1shfq0x29JnQ90JoLQlHf6WTUx95RhffA=;
        b=WWJVDWilA/vMC9byqSQBzIVhSCsjlsRXd0Ge75wj+KVjO39euYJXJ/7iEbrNQnbJot
         o96ED9kSCQ72r6YG7bLN8oxuF+KFBC5ajKzOXED29Wnkkcf3DyBoXEsdLNmVQkxwb+TM
         +VJH+dy8YCDBKf/K/5z/qbORS4NwJ8b00mIUMqvuRCo0VJj6UIl7XhdmwHa4aDNQurA7
         8J4huz23uoARRyLaid8j7vFnQPHpdCGd7H7AoWl21YYEhFypqV3H2v5hAs2q8uTne1Wk
         NEn5b8yasg+yAcYvsLebALrPLi2rmhGpclLt4fE+DaQWSD0VLWKhgQjUMfRiFYaM8j0P
         TNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1mMCvF27i1shfq0x29JnQ90JoLQlHf6WTUx95RhffA=;
        b=Cm+lORLw/WXtXt3T6MwElVbWkDyPRCjrB/YJEj+ovp81nIJBIXSXUV0uYILvASJcz4
         3HL9mcaoFhprt1wPZohOnC0cGixN8OioH8YF6+oP1YzwuRPCOjWKMhYoCC8bEbm4hsYm
         0bWDjbmaIjYxaoJHdIu7eNF5D1OVvTzWuM608uQ8+UctkVJLYY5ZrEo5ZJa5WU1YzK5V
         WgiYIutVPsqoBvPmJ1YvUf58FPOk0Ki8y1ud2BH0PNEHIpIaMjMzlh6RGBpe3xL/uvXG
         DMMwXizfnYnHqbYnrlUJLh+7Xwgix3KmvNdN9QJ5jK8EuAACOonR56OJlOWhZhbn88MU
         iOpA==
X-Gm-Message-State: AOAM530lSohRNB6qg6SxRDx1XeZ3mRnrYaLLHQvjgaSU8IKxWu9baLaN
        js8voOWymbSeeM+esuRqOowjJ0f8Dd4=
X-Google-Smtp-Source: ABdhPJwlRUBrrfJrEGyrPk0HeC/Y9FtRWbG0lBZDJg3/2R8itotRfl/+9M6CXe9gSwJlriLeY39t+Q==
X-Received: by 2002:a63:4622:: with SMTP id t34mr7422329pga.293.1634274576017;
        Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] hciemu: Use vhci_open to instanciate a vhci btdev
Date:   Thu, 14 Oct 2021 22:09:27 -0700
Message-Id: <20211015050929.3130100-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of vhci_open to isntanciate the vhci btdev since that
has proper support for reading the index assigned to it.
---
 Makefile.tools      |   8 +++
 android/Makefile.am |   2 +
 emulator/btdev.c    |   8 ++-
 emulator/hciemu.c   | 127 ++++++++++++++++++++++++++------------------
 4 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 8cfaf8972..c7bdff83f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -115,6 +115,7 @@ tools_3dsp_LDADD = src/libshared-mainloop.la
 
 tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -123,6 +124,7 @@ tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -131,6 +133,7 @@ tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -139,6 +142,7 @@ tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
 
 tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -147,6 +151,7 @@ tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -155,6 +160,7 @@ tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -165,6 +171,7 @@ tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
 
 tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
@@ -176,6 +183,7 @@ tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
diff --git a/android/Makefile.am b/android/Makefile.am
index a370598a2..309910147 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -148,6 +148,7 @@ android_haltest_LDADD = -ldl -lm
 noinst_PROGRAMS += android/android-tester
 
 android_android_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c \
@@ -172,6 +173,7 @@ android_android_tester_LDFLAGS = $(AM_LDFLAGS) -pthread
 noinst_PROGRAMS += android/ipc-tester
 
 android_ipc_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c \
diff --git a/emulator/btdev.c b/emulator/btdev.c
index 148e32b7d..0c0ebde40 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -21,6 +21,8 @@
 #include <sys/uio.h>
 #include <stdint.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -44,6 +46,8 @@
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
 
+#define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
+
 struct hook {
 	btdev_hook_func handler;
 	void *user_data;
@@ -93,6 +97,7 @@ struct le_ext_adv {
 
 struct btdev {
 	enum btdev_type type;
+	uint16_t id;
 
 	struct queue *conns;
 
@@ -135,6 +140,7 @@ struct btdev {
 	uint8_t  le_features[8];
 	uint8_t  le_states[8];
 	const struct btdev_cmd *cmds;
+	uint16_t msft_opcode;
 
 	uint16_t default_link_policy;
 	uint8_t  event_mask[8];
@@ -6230,7 +6236,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	}
 
 	btdev->type = type;
-
+	btdev->id = id;
 	btdev->manufacturer = 63;
 	btdev->revision = 0x0000;
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index bd6bf1e63..3557efc93 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -28,6 +28,7 @@
 #include "lib/hci.h"
 
 #include "monitor/bt.h"
+#include "emulator/vhci.h"
 #include "emulator/btdev.h"
 #include "emulator/bthost.h"
 #include "src/shared/util.h"
@@ -45,9 +46,8 @@ struct hciemu_client {
 struct hciemu {
 	int ref_count;
 	enum btdev_type btdev_type;
-	struct btdev *dev;
+	struct vhci *vhci;
 	struct queue *clients;
-	guint source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
 
@@ -221,37 +221,15 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
 
 static bool create_vhci(struct hciemu *hciemu)
 {
-	struct btdev *btdev;
-	uint8_t create_req[2];
-	ssize_t written;
-	int fd;
-
-	btdev = btdev_create(hciemu->btdev_type, 0x00);
-	if (!btdev)
-		return false;
+	struct vhci *vhci;
 
-	btdev_set_command_handler(btdev, central_command_callback, hciemu);
-
-	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
-	if (fd < 0) {
-		perror("Opening /dev/vhci failed");
-		btdev_destroy(btdev);
-		return false;
-	}
-
-	create_req[0] = HCI_VENDOR_PKT;
-	create_req[1] = HCI_PRIMARY;
-
-	written = write(fd, create_req, sizeof(create_req));
-	if (written < 0) {
-		close(fd);
-		btdev_destroy(btdev);
+	vhci = vhci_open(hciemu->btdev_type);
+	if (!vhci)
 		return false;
-	}
 
-	hciemu->dev = btdev;
-
-	hciemu->source = create_source_btdev(fd, btdev);
+	btdev_set_command_handler(vhci_get_btdev(vhci),
+					central_command_callback, hciemu);
+	hciemu->vhci = vhci;
 
 	return true;
 }
@@ -448,8 +426,7 @@ void hciemu_unref(struct hciemu *hciemu)
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
 	queue_destroy(hciemu->clients, hciemu_client_destroy);
 
-	g_source_remove(hciemu->source);
-	btdev_destroy(hciemu->dev);
+	vhci_close(hciemu->vhci);
 
 	free(hciemu);
 }
@@ -462,12 +439,12 @@ static void bthost_print(const char *str, void *user_data)
 					"bthost: %s", str);
 }
 
-static void btdev_central_debug(const char *str, void *user_data)
+static void vhci_debug(const char *str, void *user_data)
 {
 	struct hciemu *hciemu = user_data;
 
 	util_debug(hciemu->debug_callback, hciemu->debug_data,
-					"btdev: %s", str);
+					"vhci: %s", str);
 }
 
 static void btdev_client_debug(const char *str, void *user_data)
@@ -475,7 +452,7 @@ static void btdev_client_debug(const char *str, void *user_data)
 	struct hciemu *hciemu = user_data;
 
 	util_debug(hciemu->debug_callback, hciemu->debug_data,
-					"btdev[bthost]: %s", str);
+					"btdev: %s", str);
 }
 
 static void hciemu_client_set_debug(void *data, void *user_data)
@@ -500,7 +477,7 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 	hciemu->debug_destroy = destroy;
 	hciemu->debug_data = user_data;
 
-	btdev_set_debug(hciemu->dev, btdev_central_debug, hciemu, NULL);
+	vhci_set_debug(hciemu->vhci, vhci_debug, hciemu, NULL);
 
 	queue_foreach(hciemu->clients, hciemu_client_set_debug, hciemu);
 
@@ -510,11 +487,16 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 const char *hciemu_get_address(struct hciemu *hciemu)
 {
 	const uint8_t *addr;
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
 
-	if (!hciemu || !hciemu->dev)
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
 		return NULL;
 
-	addr = btdev_get_bdaddr(hciemu->dev);
+	addr = btdev_get_bdaddr(dev);
 	sprintf(hciemu->bdaddr_str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
 			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
 	return hciemu->bdaddr_str;
@@ -522,18 +504,30 @@ const char *hciemu_get_address(struct hciemu *hciemu)
 
 uint8_t *hciemu_get_features(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->dev)
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
 		return NULL;
 
-	return btdev_get_features(hciemu->dev);
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return NULL;
+
+	return btdev_get_features(dev);
 }
 
 const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->dev)
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return NULL;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
 		return NULL;
 
-	return btdev_get_bdaddr(hciemu->dev);
+	return btdev_get_bdaddr(dev);
 }
 
 const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client)
@@ -558,27 +552,45 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 
 uint8_t hciemu_get_central_scan_enable(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->dev)
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return 0;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
 		return 0;
 
-	return btdev_get_scan_enable(hciemu->dev);
+	return btdev_get_scan_enable(dev);
 }
 
 uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu)
 {
-	if (!hciemu || !hciemu->dev)
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
 		return 0;
 
-	return btdev_get_le_scan_enable(hciemu->dev);
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return 0;
+
+	return btdev_get_le_scan_enable(dev);
 }
 
 void hciemu_set_central_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states)
 {
-	if (!hciemu || !hciemu->dev)
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
 		return;
 
-	btdev_set_le_states(hciemu->dev, le_states);
+	btdev_set_le_states(dev, le_states);
 }
 
 bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
@@ -619,10 +631,15 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 				void *user_data)
 {
 	enum btdev_hook_type hook_type;
+	struct btdev *dev;
 
-	if (!hciemu)
+	if (!hciemu || !hciemu->vhci)
 		return -1;
 
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return 0;
+
 	switch (type) {
 	case HCIEMU_HOOK_PRE_CMD:
 		hook_type = BTDEV_HOOK_PRE_CMD;
@@ -640,16 +657,20 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 		return -1;
 	}
 
-	return btdev_add_hook(hciemu->dev, hook_type, opcode, function,
-								user_data);
+	return btdev_add_hook(dev, hook_type, opcode, function, user_data);
 }
 
 bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 								uint16_t opcode)
 {
 	enum btdev_hook_type hook_type;
+	struct btdev *dev;
 
-	if (!hciemu)
+	if (!hciemu || !hciemu->vhci)
+		return false;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
 		return false;
 
 	switch (type) {
@@ -669,5 +690,5 @@ bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 		return false;
 	}
 
-	return btdev_del_hook(hciemu->dev, hook_type, opcode);
+	return btdev_del_hook(dev, hook_type, opcode);
 }
-- 
2.31.1

