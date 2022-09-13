Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A2ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIMXdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIMXdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 19:33:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3571BD9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:33:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d82so13177706pfd.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=cO4S3HGMCW2bmXO2A1nH9xumywBS+ZKXPEO1bh8+Hic=;
        b=n7af0qC04QCSg7XfEE9wufuFvoxRTCLNTBngQ/eAoO6ljfGQT1VbFQ5GIPwo16ehwH
         L+HQlFnvkFmsPiBRd2MXDXtxeKOzG7GyEODArpNAeyw2cqLfW1buQF1uYFRbshOKPbE0
         opI8upANrvtw0f/vz6BQAZpy/bY4qGYactfafRfyuWQJVLr9p6I8xuTl2ipmjMg8rUfj
         6jAyk2wpRRSo0Na2afZPL+nDC7WJfLH0Ci48CowKvWzRemehOb6j17XjF5ctEkoOyiUA
         12OdfHwBQahb3JrJ//FTZDusF/ewmMt2x2Yxzq3EURAy1U54VNGTdoKGRJuxvnnUpInK
         bvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=cO4S3HGMCW2bmXO2A1nH9xumywBS+ZKXPEO1bh8+Hic=;
        b=Pkx/BqvyNFO839fIsOcnMtyRvk7E0SH/6dQZnOynfi5Gi93IjwNtzJtc/5elttYTpt
         rE/bPTRsb9aFoh6HKRQzhlU6N909uh5cjE9c8alv9XHRmCSByx/RtviHaBgMLpICjv3y
         BMeVPdePoyZ2xSS4BVv4rHbQwuHatxRM6chvOkfpPecaVeE5LYDRFRvBi+D6+uYeq3Mf
         Da4I5ipwahVP/P1qQRGh9MsRiCnG0wBQQ42ya0F/mZ+HyNlzALikr95dClbbjtOIDCan
         +GjK+w1jcBJ/L6w57atyfP1fVch4aQou9W7UPTL718QPcf+fuY8aaVmg3f2EN/wGStUs
         GhRA==
X-Gm-Message-State: ACgBeo1STbr82bEe25JijN58oNqajeEuOymNKy/Lc42KmJqP9e9VHN3/
        hiT9WB+O/9elLQVozZOiaOcYYKzhp9N5QYLY
X-Google-Smtp-Source: AA6agR5br7pwJITOw4NNB3e3ZsHM0ELW5oNL3PXEw/mIf1F25UwtbOc7Q9IX4IEmTzAuav9F3WCzDA==
X-Received: by 2002:a63:e055:0:b0:438:cd8e:f263 with SMTP id n21-20020a63e055000000b00438cd8ef263mr14431373pgj.378.1663112031335;
        Tue, 13 Sep 2022 16:33:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ce9-20020a17090aff0900b001f1f5e812e9sm7963245pjb.20.2022.09.13.16.33.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 16:33:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] rfcomm-tester: Add test to close socket while connecting
Date:   Tue, 13 Sep 2022 16:33:49 -0700
Message-Id: <20220913233349.526675-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Basic RFCOMM Socket Client - Close test which attempt to close
socket while connecting.
---
 tools/rfcomm-tester.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index d594ebf345ce..a9adf7f0f52d 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -47,6 +47,7 @@ struct test_data {
 struct rfcomm_client_data {
 	uint8_t server_channel;
 	uint8_t client_channel;
+	bool close;
 	int expected_connect_err;
 	const uint8_t *send_data;
 	const uint8_t *read_data;
@@ -297,6 +298,12 @@ const struct rfcomm_client_data connect_success = {
 	.client_channel = 0x0c
 };
 
+const struct rfcomm_client_data connect_close = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.close = true
+};
+
 const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
 
 const struct rfcomm_client_data connect_send_success = {
@@ -519,6 +526,8 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
+	data->io = NULL;
+
 	if (err < 0)
 		tester_test_failed();
 	else
@@ -527,6 +536,20 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
+static gboolean rc_close_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id = 0;
+
+	tester_print("Closed");
+
+	tester_test_passed();
+
+	return false;
+}
+
 static void client_hook_func(const void *data, uint16_t len,
 							void *user_data)
 {
@@ -627,13 +650,20 @@ static void test_connect(const void *test_data)
 	}
 
 	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb, NULL);
-
-	g_io_channel_unref(io);
 
 	tester_print("Connect in progress %d", sk);
+
+	if (cli->close) {
+		data->io_id = g_io_add_watch(io, G_IO_NVAL, rc_close_cb, NULL);
+		close(sk);
+		tester_print("Close socket %d", sk);
+	} else {
+		g_io_channel_set_close_on_unref(io, TRUE);
+		data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb,
+						NULL);
+	}
+
+	g_io_channel_unref(io);
 }
 
 static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
@@ -815,6 +845,9 @@ int main(int argc, char *argv[])
 				test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Conn Refused",
 			&connect_nval, setup_powered_client, test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Close",
+				&connect_close, setup_powered_client,
+				test_connect);
 	test_rfcomm("Basic RFCOMM Socket Server - Success", &listen_success,
 					setup_powered_server, test_server);
 	test_rfcomm("Basic RFCOMM Socket Server - Write Success",
-- 
2.37.3

