Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96540C4320E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D4160F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhHMMVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbhHMMVU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BAC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:54 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h186-20020a37b7c30000b02903b914d9e335so7008260qkf.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9YbHZD8oFVJ4SyQ7U1LgzwXlC0VCGcs2qhoFwmYqzP0=;
        b=pMf5jEoNP+d7XwVMe3v0SnuqHC4rL6g37xgKsDk5/Mx0diZ0ol+uXNXYZyDOUdbFMA
         mEnj1f2rB3VjnNQ/Ju8snCmziKdVJIb5+VfmIY2foSs3Zyk9XKqnvirUXN3c827DkVBH
         Vdsau80H7ItOIDhQu0YhPVwKqxkB6y8A5WzAYJFq9oX6WzP6VfRwM/kiZBNTCKCtR0BA
         7gHofn568U9e/pL8Mq+OgpSRRT6aErfRqXbu1eB2Pr4GqabXgwaSO2vJspjVVtYVpYAL
         ENh0R517p3j5Q8hm+Kc4n3nB9yHN8Xn2x2pUQCHmO6rA7lD8Id+LVTKkzyyU0KVtlb4Q
         uBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9YbHZD8oFVJ4SyQ7U1LgzwXlC0VCGcs2qhoFwmYqzP0=;
        b=R36hinukvGp9UnaFxbLmDD/tSGB8Ua8aXZRtS4WOtuh578ZCEJ0NTO5zqFZmIoW7zM
         JwX6yKxOe/NknVPi/2uXC8brf5i7CRfLnA2cpXhWUKQxWr8ULe3qH/LP4aOJgk4dRkiE
         E8BAZRqa3S9iEIR+iw0+4OIuJ23RHICvVjCRKUk7nBDLmhKnyhzybgOF+9+IXCxsGY17
         warvbyGEgYdtlHtMA3TDaDxfspf1C6V05Qcj6PFQRFoGQZdGNK07OVU2VJ4xkDejGaT3
         libIexaW1l8i59PA6VkXJr7zdpld8hIG9wW1tPMarwr+3v4UMWujOWwICTo3HAITuzVA
         HNgw==
X-Gm-Message-State: AOAM532xxl7oHscO5xtGiShKXe9k/X/5+rpk6wAwr/ScDRF6edg47X+m
        I8zaq9X/1WV/j95p9vSfJJIjQ36c7vinhItVKuuQOHR9NmbEMTktQx04XP50ycysnqYEJELfa0z
        8/ekFYg0cnYjkti6T+Buvi+N2hC9HScuZYli9EePOiZcgpLuHD0i/mBctL6ISkNr/cCTwZ7y5bv
        uY
X-Google-Smtp-Source: ABdhPJyYSQ4YrZMQu7bdqlerbjr54d8OILLv1hHfAFpY9hRFVXpnOv+Y+4aBtrj+AVgiNVosiXeAMLDeqjy/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:580e:: with SMTP id
 dd14mr2401767qvb.2.1628857253249; Fri, 13 Aug 2021 05:20:53 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:06 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.21.Idde74d908204ede645812e49623e367d27c50e58@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 21/62] emulator: Inclusive language in naming
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 android/tester-main.c |  2 +-
 emulator/hciemu.c     | 21 +++++++++++----------
 emulator/hciemu.h     | 12 ++++++------
 tools/l2cap-tester.c  | 16 ++++++++--------
 tools/mgmt-tester.c   | 20 ++++++++++----------
 tools/rfcomm-tester.c |  4 ++--
 tools/sco-tester.c    |  2 +-
 tools/smp-tester.c    |  6 +++---
 8 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 2bfa770bb5..ff5ecdf834 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2786,7 +2786,7 @@ void emu_remote_connect_hci_action(void)
 	struct step *step = g_new0(struct step, 1);
 	const uint8_t *master_addr;
 
-	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+	master_addr = hciemu_get_central_bdaddr(data->hciemu);
 
 	tester_print("Trying to connect hci");
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index a3ec44243c..402d689d3c 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -84,7 +84,7 @@ static void run_command_hook(void *data, void *user_data)
 					run_data->len, hook->user_data);
 }
 
-static void master_command_callback(uint16_t opcode,
+static void central_command_callback(uint16_t opcode,
 				const void *data, uint8_t len,
 				btdev_callback callback, void *user_data)
 {
@@ -230,7 +230,7 @@ static bool create_vhci(struct hciemu *hciemu)
 	if (!btdev)
 		return false;
 
-	btdev_set_command_handler(btdev, master_command_callback, hciemu);
+	btdev_set_command_handler(btdev, central_command_callback, hciemu);
 
 	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0) {
@@ -462,7 +462,7 @@ static void bthost_debug(const char *str, void *user_data)
 					"bthost: %s", str);
 }
 
-static void btdev_master_debug(const char *str, void *user_data)
+static void btdev_central_debug(const char *str, void *user_data)
 {
 	struct hciemu *hciemu = user_data;
 
@@ -500,7 +500,7 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 	hciemu->debug_destroy = destroy;
 	hciemu->debug_data = user_data;
 
-	btdev_set_debug(hciemu->dev, btdev_master_debug, hciemu, NULL);
+	btdev_set_debug(hciemu->dev, btdev_central_debug, hciemu, NULL);
 
 	queue_foreach(hciemu->clients, hciemu_client_set_debug, hciemu);
 
@@ -528,7 +528,7 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu)
 	return btdev_get_features(hciemu->dev);
 }
 
-const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu)
+const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return NULL;
@@ -556,7 +556,7 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 	return hciemu_client_bdaddr(client);
 }
 
-uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
+uint8_t hciemu_get_central_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return 0;
@@ -564,7 +564,7 @@ uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu)
 	return btdev_get_scan_enable(hciemu->dev);
 }
 
-uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
+uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->dev)
 		return 0;
@@ -572,7 +572,8 @@ uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu)
 	return btdev_get_le_scan_enable(hciemu->dev);
 }
 
-void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t *le_states)
+void hciemu_set_central_le_states(struct hciemu *hciemu,
+						const uint8_t *le_states)
 {
 	if (!hciemu || !hciemu->dev)
 		return;
@@ -580,7 +581,7 @@ void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t *le_states
 	btdev_set_le_states(hciemu->dev, le_states);
 }
 
-bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
+bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
 	struct hciemu_command_hook *hook;
@@ -603,7 +604,7 @@ bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 	return true;
 }
 
-bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu)
+bool hciemu_clear_central_post_command_hooks(struct hciemu *hciemu)
 {
 	if (!hciemu)
 		return false;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 8bf2d070ea..3d3d93b4b0 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -50,14 +50,14 @@ struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
 
-const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
+const uint8_t *hciemu_get_central_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 
-uint8_t hciemu_get_master_scan_enable(struct hciemu *hciemu);
+uint8_t hciemu_get_central_scan_enable(struct hciemu *hciemu);
 
-uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu);
+uint8_t hciemu_get_central_le_scan_enable(struct hciemu *hciemu);
 
-void hciemu_set_master_le_states(struct hciemu *hciemu,
+void hciemu_set_central_le_states(struct hciemu *hciemu,
 						const uint8_t *le_states);
 
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
@@ -66,10 +66,10 @@ typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 typedef bool (*hciemu_hook_func_t)(const void *data, uint16_t len,
 							void *user_data);
 
-bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
+bool hciemu_add_central_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data);
 
-bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu);
+bool hciemu_clear_central_post_command_hooks(struct hciemu *hciemu);
 
 int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 				uint16_t opcode, hciemu_hook_func_t function,
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 11d549f22a..169a989f54 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1116,7 +1116,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		close(sk);
@@ -1301,7 +1301,7 @@ static void test_connect(const void *test_data)
 	}
 
 	if (l2data->direct_advertising)
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						direct_adv_cmd_complete, NULL);
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
@@ -1419,7 +1419,7 @@ static gboolean test_close_socket_1_part_3(gpointer arg)
 		return FALSE;
 	}
 
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Delayed check whether scann is off failed");
 		tester_test_failed();
 		return FALSE;
@@ -1440,7 +1440,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	 * was added to kernel whitelist, and scan was started. We
 	 * should be still scanning.
 	 */
-	if (!hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (!hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should be still scanning");
 		tester_test_failed();
 		return FALSE;
@@ -1467,7 +1467,7 @@ static gboolean test_close_socket_2_part_3(gpointer arg)
 	int err;
 
 	/* Scan should be already over, we're trying to create connection */
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should no longer scan");
 		tester_test_failed();
 		return FALSE;
@@ -1563,7 +1563,7 @@ static void test_close_socket(const void *test_data)
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 					test_close_socket_router, data);
 
 	if (l2data->client_bdaddr != NULL)
@@ -1668,7 +1668,7 @@ static void test_connect_2(const void *test_data)
 	test_2_connect_cb_cnt = 0;
 	test_scan_enable_counter = 0;
 
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 				test_connect_2_router, data);
 
 	if (l2data->server_psm) {
@@ -1869,7 +1869,7 @@ static void test_server(const void *test_data)
 		tester_print("Listening for connections");
 	}
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 26d78360d7..30db2b2179 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -365,7 +365,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
 
 	if (test && test->setup_le_states)
-		hciemu_set_master_le_states(data->hciemu, test->le_states);
+		hciemu_set_central_le_states(data->hciemu, test->le_states);
 }
 
 static void test_pre_setup(const void *test_data)
@@ -7098,7 +7098,7 @@ static void command_setup_hci_callback(uint16_t opcode, const void *param,
 		return;
 	}
 
-	hciemu_clear_master_post_command_hooks(data->hciemu);
+	hciemu_clear_central_post_command_hooks(data->hciemu);
 	test_setup_condition_complete(data);
 }
 
@@ -7164,7 +7164,7 @@ static void setup_command_generic(const void *test_data)
 		tester_print("Registering setup expected HCI command callback");
 		tester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
 		test_add_setup_condition(data);
 	}
@@ -9487,7 +9487,7 @@ static void setup_ll_privacy_device(const void *test_data)
 
 	tester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
-	hciemu_add_master_post_command_hook(data->hciemu,
+	hciemu_add_central_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
 	test_add_setup_condition(data);
 
@@ -9644,7 +9644,7 @@ static void test_command_generic(const void *test_data)
 
 	if (test->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
@@ -9678,13 +9678,13 @@ static void check_scan(void *user_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_le_scan_enable(data->hciemu)) {
 		tester_warn("LE scan still enabled");
 		tester_test_failed();
 		return;
 	}
 
-	if (hciemu_get_master_scan_enable(data->hciemu)) {
+	if (hciemu_get_central_scan_enable(data->hciemu)) {
 		tester_warn("BR/EDR scan still enabled");
 		tester_test_failed();
 		return;
@@ -9775,7 +9775,7 @@ static void test_pairing_acceptor(const void *test_data)
 		test_add_condition(data);
 	}
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -9840,7 +9840,7 @@ static void test_command_generic_connect(const void *test_data)
 	data->mgmt_alt_ev_id = id;
 	test_add_condition(data);
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -9919,7 +9919,7 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	if (test->client_enable_adv)
 		return;
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 9bae5b9d54..78b08663bd 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -542,7 +542,7 @@ static void test_connect(const void *test_data)
 	bthost_add_rfcomm_server(bthost, cli->server_channel,
 						rfcomm_connect_cb, NULL);
 
-	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+	master_addr = hciemu_get_central_bdaddr(data->hciemu);
 	client_addr = hciemu_get_client_bdaddr(data->hciemu);
 
 	sk = create_rfcomm_sock((bdaddr_t *) master_addr, 0);
@@ -680,7 +680,7 @@ static void test_server(const void *test_data)
 	GIOChannel *io;
 	int sk;
 
-	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+	master_addr = hciemu_get_central_bdaddr(data->hciemu);
 
 	sk = create_rfcomm_sock((bdaddr_t *) master_addr, srv->server_channel);
 	if (sk < 0) {
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 2b8dc0d4a8..7c83aee195 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -426,7 +426,7 @@ static int create_sco_sock(struct test_data *data)
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		return -ENODEV;
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 644c451c29..b075c5df8a 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -767,7 +767,7 @@ static void init_bdaddr(struct test_data *data)
 {
 	const uint8_t *master_bdaddr, *client_bdaddr;
 
-	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
 		tester_warn("No master bdaddr");
 		tester_test_failed();
@@ -808,7 +808,7 @@ static void test_client(const void *test_data)
 
 	if (smp->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
@@ -889,7 +889,7 @@ static void test_server(const void *test_data)
 
 	if (smp->expect_hci_command) {
 		tester_print("Registering HCI command callback");
-		hciemu_add_master_post_command_hook(data->hciemu,
+		hciemu_add_central_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
-- 
2.33.0.rc1.237.g0d66db33f3-goog

