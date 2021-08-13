Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC7FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C921560F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhHMMVc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbhHMMVc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954AC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so8956230ybs.18
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0PJBxrqEpDZD83Ayh9AokOZtgqrEoGdAMrmW3WZWTak=;
        b=EoWiVjjfHVQc8jDmb0yXXriGtYfebVzl1BjwaBL+IEETkJAAFRO0Tfn8K8Os47gw8O
         n2PaDeGa9B3YKc5YFohmpjIDMCEy9QCSagZGDHoQmeNnl15q0DZd38ILd7n3ghcwKMsI
         Lyo0dtNMoeo+BuEyZS2eyGAOrZU0G1g6d6m3CE/8n9H08p0BMQCby0aGlcGK0/L0D+F2
         +K3buDjpamc9zOAVALZR3GIltwtIskwqbC3N6p8mRpK4FGdws0A8feDVMdSVis4NYIAP
         istPDuw7n7pf+ItiFP4OfHU2wdhUKRi+w4gwBbGqtCn4nkKT02PlBzKlE9ItQbTzsmU1
         235A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0PJBxrqEpDZD83Ayh9AokOZtgqrEoGdAMrmW3WZWTak=;
        b=TAJmSl+//ipaUBz0qDsgrxYt0N436Ce02EQTP6dcYviG+TjKd3bYJ8VAr+ddjNsHUS
         nZCgLEPMkp2IGxDM9FigwOs/KwaJZY8fJCXNSIIxUT99HT+7K9nX+N2H+yzaZUDkJ3t9
         94aL7wYn4zFOVFfmEhwDSoEuI5SXrUayRzPU4AXFGqpdpiv47e3LhyFv7tudsNDAauK2
         zUFMKidNQgQBdDtj6gnbonVLG27Gy0tutlfwj+VTc9QGA8Rj2KNOjHVJ0GsrS4DvJVyj
         dACZ0tpUNxJMxj9G21mjdbnxhrKQeu81ZMghC/HfskIdN6xv+jsyCTieTk3Ta+Dn7phU
         zk+w==
X-Gm-Message-State: AOAM5300tOmj1nE7CxGDpryybqd9TfPn2c8G4P0fxgiYjOlf8vjAw3PA
        yJrbqwoq9WW9RunMhEtaf6bmlIE6deUf8rtcQg5gh46YHokOb3UQH/xDiddsNZ+SQJr9MXFN7R1
        hBYmRZJcu9+R+5m2TddLvUKUin6sLc6dNs2JGtLP0JVeSDbtmyl8yxjj9s5lgyIhQ9vGoF7T+qL
        oY
X-Google-Smtp-Source: ABdhPJzRI4sZXWRYvVV9+VAlOrsZHo/YXb/GOVGUSt4X2Tap+3iBoUmYVfX4n5XRt8w/ZjrSNA9fNA8fqI5M
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:ea51:: with SMTP id
 o17mr2518123ybe.192.1628857264963; Fri, 13 Aug 2021 05:21:04 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:09 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.24.Ifc20410999700c0b9377e6f8e368076d5917cd06@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 24/62] tools: Inclusive language in referring the
 central address
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

 tools/l2cap-tester.c  | 20 ++++++++++----------
 tools/mgmt-tester.c   | 33 +++++++++++++++++----------------
 tools/rfcomm-tester.c | 14 +++++++-------
 tools/sco-tester.c    | 10 +++++-----
 tools/smp-tester.c    | 12 ++++++------
 5 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 169a989f54..db662117e0 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1103,7 +1103,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 				uint16_t cid, int sec_level, uint8_t mode)
 {
 	const struct l2cap_data *l2data = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct sockaddr_l2 addr;
 	int sk, err;
 
@@ -1116,9 +1116,9 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		close(sk);
 		return -ENODEV;
 	}
@@ -1127,7 +1127,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm = htobs(psm);
 	addr.l2_cid = htobs(cid);
-	bacpy(&addr.l2_bdaddr, (void *) master_bdaddr);
+	bacpy(&addr.l2_bdaddr, (void *) central_bdaddr);
 
 	if (l2data && l2data->addr_type_avail)
 		addr.l2_bdaddr_type = l2data->addr_type;
@@ -1836,7 +1836,7 @@ static void test_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
 	GIOChannel *io;
@@ -1869,9 +1869,9 @@ static void test_server(const void *test_data)
 		tester_print("Listening for connections");
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -1884,7 +1884,7 @@ static void test_server(const void *test_data)
 	else
 		addr_type = BDADDR_LE_PUBLIC;
 
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static void test_getpeername_not_connected(const void *test_data)
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 30db2b2179..04c4393a09 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9759,7 +9759,7 @@ static void test_pairing_acceptor(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct bthost *bthost;
 	uint8_t addr_type;
 
@@ -9775,9 +9775,9 @@ static void test_pairing_acceptor(const void *test_data)
 		test_add_condition(data);
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -9790,7 +9790,7 @@ static void test_pairing_acceptor(const void *test_data)
 	else
 		addr_type = BDADDR_LE_PUBLIC;
 
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static void connected_event(uint16_t index, uint16_t length, const void *param,
@@ -9828,7 +9828,7 @@ static void test_command_generic_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	unsigned int id;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
 
@@ -9840,9 +9840,9 @@ static void test_command_generic_connect(const void *test_data)
 	data->mgmt_alt_ev_id = id;
 	test_add_condition(data);
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -9851,7 +9851,7 @@ static void test_command_generic_connect(const void *test_data)
 							BDADDR_LE_PUBLIC;
 	tester_print("ADDR TYPE: %d", addr_type);
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+	bthost_hci_connect(bthost, central_bdaddr, addr_type);
 }
 
 static bool test_adv_enable_hook(const void *data, uint16_t len,
@@ -9904,7 +9904,7 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	struct test_data *data = user_data;
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 
 	if (status != 0) {
 		tester_test_failed();
@@ -9919,18 +9919,19 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	if (test->client_enable_adv)
 		return;
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
-		bthost_hci_ext_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+		bthost_hci_ext_connect(bthost, central_bdaddr,
+		BDADDR_LE_PUBLIC);
 	else
-		bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+		bthost_hci_connect(bthost, central_bdaddr, BDADDR_LE_PUBLIC);
 }
 
 static void test_connected_and_advertising(const void *test_data)
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 78b08663bd..ef47904de0 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -534,7 +534,7 @@ static void test_connect(const void *test_data)
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const struct rfcomm_client_data *cli = data->test_data;
-	const uint8_t *client_addr, *master_addr;
+	const uint8_t *client_addr, *central_addr;
 	GIOChannel *io;
 	int sk;
 
@@ -542,10 +542,10 @@ static void test_connect(const void *test_data)
 	bthost_add_rfcomm_server(bthost, cli->server_channel,
 						rfcomm_connect_cb, NULL);
 
-	master_addr = hciemu_get_central_bdaddr(data->hciemu);
+	central_addr = hciemu_get_central_bdaddr(data->hciemu);
 	client_addr = hciemu_get_client_bdaddr(data->hciemu);
 
-	sk = create_rfcomm_sock((bdaddr_t *) master_addr, 0);
+	sk = create_rfcomm_sock((bdaddr_t *) central_addr, 0);
 
 	if (connect_rfcomm_sock(sk, (const bdaddr_t *) client_addr,
 					cli->client_channel) < 0) {
@@ -675,14 +675,14 @@ static void test_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
-	const uint8_t *master_addr;
+	const uint8_t *central_addr;
 	struct bthost *bthost;
 	GIOChannel *io;
 	int sk;
 
-	master_addr = hciemu_get_central_bdaddr(data->hciemu);
+	central_addr = hciemu_get_central_bdaddr(data->hciemu);
 
-	sk = create_rfcomm_sock((bdaddr_t *) master_addr, srv->server_channel);
+	sk = create_rfcomm_sock((bdaddr_t *) central_addr, srv->server_channel);
 	if (sk < 0) {
 		tester_test_failed();
 		return;
@@ -707,7 +707,7 @@ static void test_server(const void *test_data)
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_connect_cb(bthost, client_new_conn, data);
 
-	bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
+	bthost_hci_connect(bthost, central_addr, BDADDR_BREDR);
 }
 
 #define test_rfcomm(name, data, setup, func) \
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 7c83aee195..3e7bfc5e3a 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -413,7 +413,7 @@ end:
 
 static int create_sco_sock(struct test_data *data)
 {
-	const uint8_t *master_bdaddr;
+	const uint8_t *central_bdaddr;
 	struct sockaddr_sco addr;
 	int sk, err;
 
@@ -426,15 +426,15 @@ static int create_sco_sock(struct test_data *data)
 		return err;
 	}
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		return -ENODEV;
 	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sco_family = AF_BLUETOOTH;
-	bacpy(&addr.sco_bdaddr, (void *) master_bdaddr);
+	bacpy(&addr.sco_bdaddr, (void *) central_bdaddr);
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = -errno;
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index b075c5df8a..16fe0dfd7a 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -765,11 +765,11 @@ static void smp_new_conn(uint16_t handle, void *user_data)
 
 static void init_bdaddr(struct test_data *data)
 {
-	const uint8_t *master_bdaddr, *client_bdaddr;
+	const uint8_t *central_bdaddr, *client_bdaddr;
 
-	master_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
-	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
+	if (!central_bdaddr) {
+		tester_warn("No central bdaddr");
 		tester_test_failed();
 		return;
 	}
@@ -786,9 +786,9 @@ static void init_bdaddr(struct test_data *data)
 
 	if (data->out) {
 		memcpy(data->ia, client_bdaddr, sizeof(data->ia));
-		memcpy(data->ra, master_bdaddr, sizeof(data->ra));
+		memcpy(data->ra, central_bdaddr, sizeof(data->ra));
 	} else {
-		memcpy(data->ia, master_bdaddr, sizeof(data->ia));
+		memcpy(data->ia, central_bdaddr, sizeof(data->ia));
 		memcpy(data->ra, client_bdaddr, sizeof(data->ra));
 	}
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

