Return-Path: <SRS0=1XHc=MR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1ADC00449
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF620652
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyuhc5zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BF620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJEP6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:58:22 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34162 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeJEP6W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Oct 2018 11:58:22 -0400
Received: by mail-lf1-f54.google.com with SMTP id y10-v6so8828964lfj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Oct 2018 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=H20thavih0MQKoVL60EbAbsRKQAxJPO9G52b/qEP5pg=;
        b=kyuhc5zN+39gno/YimPpZCUlMKSzIZa8Y3c6nSPnI8T7YGGQJhnjh6yNUzHG5HJ9wq
         3QnFO2aM+qeRbnEMNjA8N6nW7J7+xBvA0CPbLuuS1D6Q7Zkw1vIg0t0uOdNkUvis9/fM
         lqAHCwOWOWUmC8izh5RNC25rg0spXxG9Zb6hEHQ4ulKmQEtQU1TW+4TB/27TbSSZwAgB
         3EiqX/LvabfE5mtoWldnMThuu70Hct+/4byr1kMID9ztb4pNEMm3Fn6JfSDK4btDwr8v
         tLk1XuWy49xisfeA74VCSjdLeBTlZKundK7FyC3yXbEwzuniPirSV9oK/j9KjTbUe1x+
         JuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=H20thavih0MQKoVL60EbAbsRKQAxJPO9G52b/qEP5pg=;
        b=olynNUIOGE5nWTj5Ts4lrC1K2RCkhwnkeMYIR3MN+Kp31+QVmEM+aZPSGPlncH2Dx6
         Cfyp/RAdu2qETwyB/HhuuAmIuCzR7Fov4CoGr0o6be343bE7XhvSWGTyGjoV+SGlTKjj
         ZEbbr00kzzaFcPG3hRbE6/sihnqxccEGAhGAk6B6fVhsrU7U0kA76mqF03JOJIemALaa
         dfPCcneKy3GvEY0iUXH5ynFwBloicXPLvN6gFBoxArxxZGuSnicdAwMcvkvrB6jRybsN
         ycSz6Fi2cBv3ImPLty08DsEnhSO5axGHboIQs8kfCitUIX209F9eOVcRJ0SzIj+GXf4S
         BkwQ==
X-Gm-Message-State: ABuFfoiR4MdzSrpATkmqYm2GM83VX/sloGcsdALhvFrXTXJboGEmqBDU
        eV+AaC65biiF2Ht9Vr1xG7t+vKYk
X-Google-Smtp-Source: ACcGV60DiI+XCUt4kFRyW5I2Mvy43auEDsWlR2qx/o3KTb9NzI/qgtnL4YLBB68KsC0h+o+fWnpqSg==
X-Received: by 2002:a19:1346:: with SMTP id j67-v6mr5736509lfi.93.1538730031257;
        Fri, 05 Oct 2018 02:00:31 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id a12-v6sm241355lfe.73.2018.10.05.02.00.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:00:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] unit: Make use of tester_monitor to print input/output PDUs
Date:   Fri,  5 Oct 2018 12:00:26 +0300
Message-Id: <20181005090026.7535-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005090026.7535-1-luiz.dentz@gmail.com>
References: <20181005090026.7535-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

tester_monitor will forward the data to btmon when -m/--monitor is
enabled which will attempt to decode the PDUs:

= test-gatt: /robustness/unkown-command - init                                                                                                                        11:44:53.464325
= test-gatt: /robustness/unkown-command - setup
= test-gatt: /robustness/unkown-command - setup complete
= test-gatt: /robustness/unkown-command - run
< test-gatt: User Data TX
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 23
> test-gatt: User Data RX
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 512
< test-gatt: User Data TX
      ATT: Unknown (0xff) len 1
        00                                               .
= test-gatt: /robustness/unkown-command - test passed
= test-gatt: /robustness/unkown-command - teardown
= test-gatt: /robustness/unkown-command - teardown complete
= test-gatt: /robustness/unkown-command - done
---
 unit/test-avctp.c | 11 ++---------
 unit/test-avdtp.c | 11 ++---------
 unit/test-avrcp.c | 21 +++++++--------------
 unit/test-gatt.c  |  6 +++---
 unit/test-sdp.c   | 11 ++---------
 5 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 3bc35696d..60fd6ad71 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -81,13 +81,6 @@ struct context {
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
-static void test_debug(const char *str, void *user_data)
-{
-	const char *prefix = user_data;
-
-	tester_debug("%s%s", prefix, str);
-}
-
 static void test_free(gconstpointer user_data)
 {
 	const struct test_data *data = user_data;
@@ -131,7 +124,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
+	tester_monitor('<', 0x0000, 0x0017, pdu->data, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -172,7 +165,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	util_hexdump('>', buf, len, test_debug, "AVCTP: ");
+	tester_monitor('>', 0x0000, 0x0017, buf, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index dd8aed73c..176852ae7 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -99,13 +99,6 @@ struct context {
 	const struct test_data *data;
 };
 
-static void test_debug(const char *str, void *user_data)
-{
-	const char *prefix = user_data;
-
-	tester_debug("%s%s", prefix, str);
-}
-
 static void test_free(gconstpointer user_data)
 {
 	const struct test_data *data = user_data;
@@ -158,7 +151,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	util_hexdump('<', pdu->data, len, test_debug, "AVDTP: ");
+	tester_monitor('<', 0x0000, 0x0019, pdu->data, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -215,7 +208,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	util_hexdump('>', buf, len, test_debug, "AVDTP: ");
+	tester_monitor('>', 0x0000, 0x0019, buf, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 01307e679..9ffd44cfd 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -113,13 +113,6 @@ struct context {
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
-static void test_debug(const char *str, void *user_data)
-{
-	const char *prefix = user_data;
-
-	tester_debug("%s%s", prefix, str);
-}
-
 static void test_free(gconstpointer user_data)
 {
 	const struct test_data *data = user_data;
@@ -164,12 +157,13 @@ static gboolean send_pdu(gpointer user_data)
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
-	if (pdu->browse)
+	if (pdu->browse) {
 		len = write(context->browse_fd, pdu->data, pdu->size);
-	else
+		tester_monitor('<', 0x0000, 0x001b, pdu->data, len);
+	} else {
 		len = write(context->fd, pdu->data, pdu->size);
-
-	util_hexdump('<', pdu->data, len, test_debug, "AVRCP: ");
+		tester_monitor('<', 0x0000, 0x0017, pdu->data, len);
+	}
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -215,8 +209,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "AVRCP: ");
+	tester_monitor('>', 0x0000, 0x0017, buf, len);
 
 	if (!pdu->continuing)
 		g_assert_cmpint(len, ==, pdu->size);
@@ -254,7 +247,7 @@ static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	util_hexdump('>', buf, len, test_debug, "AVRCP: ");
+	tester_monitor('>', 0x0000, 0x001b, buf, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c7e28f865..d8d007386 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -382,7 +382,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	util_hexdump('<', pdu->data, len, test_debug, "GATT: ");
+	tester_monitor('<', 0x0004, 0x0000, pdu->data, len);
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -440,7 +440,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	util_hexdump('>', buf, len, test_debug, "GATT: ");
+	tester_monitor('>', 0x0004, 0x0000, buf, len);
 
 	util_hexdump('=', pdu->data, pdu->size, test_debug, "PDU: ");
 
@@ -1910,7 +1910,7 @@ static void test_server(gconstpointer data)
 
 	g_assert_cmpint(len, ==, pdu.size);
 
-	util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
+	tester_monitor('<', 0x0004, 0x0000, pdu.data, len);
 }
 
 static void test_search_primary(gconstpointer data)
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index ac921a9a0..b67a55189 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -120,13 +120,6 @@ struct context {
 	const struct test_data *data;
 };
 
-static void sdp_debug(const char *str, void *user_data)
-{
-	const char *prefix = user_data;
-
-	tester_debug("%s%s\n", prefix, str);
-}
-
 static void destroy_context(struct context *context)
 {
 	sdp_svcdb_collect_all(context->fd);
@@ -186,7 +179,7 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 		return FALSE;
 	}
 
-	util_hexdump('<', buf, len, sdp_debug, "SDP: ");
+	tester_monitor('<', 0x0000, 0x0001, buf, len);
 
 	handle_internal_request(fd, context->data->mtu, buf, len);
 
@@ -254,7 +247,7 @@ static gboolean client_handler(GIOChannel *channel, GIOCondition cond,
 	if (len < 0)
 		return FALSE;
 
-	util_hexdump('>', buf, len, sdp_debug, "SDP: ");
+	tester_monitor('>', 0x0000, 0x0001, buf, len);
 
 	g_assert(len > 0);
 	g_assert((size_t) len == rsp_pdu->raw_size + rsp_pdu->cont_len);
-- 
2.17.1

