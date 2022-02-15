Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D93CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 01:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiBOBvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiBOBvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 20:51:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57DED557F
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 17:51:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z16so10417873pfh.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 17:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYLFXJJVUdf1MCkhX4cW9PUQU7zTnoLBGlCKhLcezGQ=;
        b=NnB26SpacoI16tcRk30qclLqN7UZgGaMdMUlm2ogoAQNalUrNpvhja5x8K5C+lz0u8
         /7JmJWJZ+YUV3iNd66JVu4PsDXU/xY1sxR7jJkav3H7zBUrQN3RH3KCBxakLOjdGgf0T
         OQbp/KizSrWALoFYxVHC7jEloIocEMJf1WTrbstzBxkk1bI2lCsErZEp4r8owvEoXgRw
         Ko5sHTWFmmVhiyeqVtnhKYpf0N4tJ6sucCPgpASSA9mmkjfhURQJ5P29lHx2rYBMGXWG
         ZHXOF3bJFgFW34cv2KNcotRM+xICt74lL7yaj6nFCMTc8ZbgjJqeYDdUmmHwTDECAts4
         CR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYLFXJJVUdf1MCkhX4cW9PUQU7zTnoLBGlCKhLcezGQ=;
        b=caAF88Hxjw3KjZAU/GL+6m+1mZoQmSam+8jxvYRjBgtnBC2/9zGJ24I6vKg9gNpze1
         bD62eD2BHitn3S82sXiiIXO+zgs0sqZmJdK2H2zUxwMUG3EpEDOid6oWHjnql/ikesSt
         oWNF3VlSJh5JCpDeRwxpebXcRR2lnsSh9/iLC4r+KCOWwG6L6/HGXt4MXejglk6vEp21
         vK5rdW/w2VfS50tW7BDqSJn2RTX/irseLGrVdhx/Y+Mb0Oluc6Dyr7ryQZPupuGsSELu
         uUYLl0gsOn5W/lrp4uTUy2vKO0irc82j0hfHaHtcFPc/Ch99/9AE2KDPHf7To20qIhvH
         8k4Q==
X-Gm-Message-State: AOAM531MwPc3kicWvsBuOLMoJcoIxbaPFs3YNtrW+fAxuB6O/ZQXlF+P
        0CqgTKg34xr9VW1fbf1SfsHMZT34L+vZpQ==
X-Google-Smtp-Source: ABdhPJyBYwKliS0qVQ3tPkPlF5ZJgdJAeEOeZ378ydZLO7O5nNGLJzq+JMwlKujG7iI3r2NxU1BmUg==
X-Received: by 2002:a63:7f1c:: with SMTP id a28mr1605775pgd.311.1644889897760;
        Mon, 14 Feb 2022 17:51:37 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q1sm20633434pfs.112.2022.02.14.17.51.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 17:51:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] rfcomm-tester: Increase amount of data from 8k to 32k
Date:   Mon, 14 Feb 2022 17:51:36 -0800
Message-Id: <20220215015136.1948793-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This forces the behavior where not all data can be written at once so it
is able to reproduce the from [1].

[1]https://bugzilla.kernel.org/show_bug.cgi?id=215594
---
 tools/rfcomm-tester.c | 90 +++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 650d33cb6..32c0d6058 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -37,8 +37,10 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
+	GIOChannel *io;
 	unsigned int io_id;
 	uint16_t conn_handle;
+	uint16_t send_len;
 	uint16_t recv_len;
 };
 
@@ -198,6 +200,9 @@ static void test_post_teardown(const void *test_data)
 		data->io_id = 0;
 	}
 
+	if (data->io)
+		g_io_channel_unref(data->io);
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -301,21 +306,21 @@ const struct rfcomm_client_data connect_send_success = {
 	.send_data = data,
 };
 
-const uint8_t data_8k[8192] = { [0 ... 1023] =  0x00,
-				[1024 ... 2047] =  0x01,
-				[2048 ... 3071] =  0x02,
-				[3072 ... 4095] =  0x03,
-				[4096 ... 5119] =  0x04,
-				[5120 ... 6143] =  0x05,
-				[6144 ... 7167] =  0x06,
-				[7168 ... 8191] =  0x07,
+const uint8_t data_32k[32768] = { [0 ... 4095] =  0x00,
+				[4096 ... 8191] =  0x01,
+				[8192 ... 12287] =  0x02,
+				[12288 ... 16383] =  0x03,
+				[16384 ... 20479] =  0x04,
+				[20480 ... 24575] =  0x05,
+				[24576 ... 28671] =  0x06,
+				[28672 ... 32767] =  0x07,
 };
 
-const struct rfcomm_client_data connect_send_8k_success = {
+const struct rfcomm_client_data connect_send_32k_success = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0c,
-	.data_len = sizeof(data_8k),
-	.send_data = data_8k,
+	.data_len = sizeof(data_32k),
+	.send_data = data_32k,
 };
 
 const struct rfcomm_client_data connect_read_success = {
@@ -438,6 +443,44 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
+static gboolean rc_write_data(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	const struct rfcomm_client_data *cli = data->test_data;
+	int sk;
+	ssize_t ret;
+
+	if (cond & G_IO_NVAL)
+		return false;
+
+	if (cond & (G_IO_HUP | G_IO_ERR))
+		goto done;
+
+	tester_print("Writing %u bytes of data",
+			cli->data_len - data->send_len);
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	ret = write(sk, cli->send_data + data->send_len,
+			cli->data_len - data->send_len);
+	if (ret < 0) {
+		tester_warn("Failed to write %u bytes: %s (%d)",
+				cli->data_len, strerror(errno), errno);
+		tester_test_failed();
+		goto done;
+	}
+
+	data->send_len += ret;
+
+	tester_print("Written %u/%u bytes", data->send_len, cli->data_len);
+
+	/* Don't retry write since that seems to block bthost from receiving */
+done:
+	data->io_id = 0;
+	return false;
+}
+
 static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -463,16 +506,9 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (cli->send_data) {
-		ssize_t ret;
-
-		tester_print("Writing %u bytes of data", cli->data_len);
-		ret = write(sk, cli->send_data, cli->data_len);
-		if (cli->data_len != ret) {
-			tester_warn("Failed to write %u bytes: %s (%d)",
-					cli->data_len, strerror(errno), errno);
-			tester_test_failed();
-		}
-
+		data->io = g_io_channel_ref(io);
+		cond = G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
+		data->io_id = g_io_add_watch(io, cond, rc_write_data, data);
 		return false;
 	} else if (cli->read_data) {
 		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
@@ -517,8 +553,14 @@ static void client_hook_func(const void *data, uint16_t len,
 	tester_print("bthost received progress %u/%u", test_data->recv_len,
 							cli->data_len);
 
-	if (cli->data_len != test_data->recv_len)
+	if (cli->data_len != test_data->recv_len) {
+		if (cli->data_len != test_data->send_len)
+			test_data->io_id = g_io_add_watch(test_data->io,
+						     G_IO_OUT | G_IO_HUP |
+						     G_IO_ERR | G_IO_NVAL,
+						     rc_write_data, test_data);
 		return;
+	}
 
 	test_data->recv_len = 0;
 
@@ -765,8 +807,8 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Client - Write Success",
 				&connect_send_success, setup_powered_client,
 				test_connect);
-	test_rfcomm("Basic RFCOMM Socket Client - Write 8k Success",
-				&connect_send_8k_success, setup_powered_client,
+	test_rfcomm("Basic RFCOMM Socket Client - Write 32k Success",
+				&connect_send_32k_success, setup_powered_client,
 				test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Read Success",
 				&connect_read_success, setup_powered_client,
-- 
2.34.1

