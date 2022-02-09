Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2622CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 01:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiBJB2r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:28:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiBJB2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 20:28:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119420F7C
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:28:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y8so4756575pfa.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 17:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=128JU9ZRRKnPuOh1w064by2lJFlQlZWtP6zeO7W2M20=;
        b=YxyHGW3cijYGiVelG0kk5Rirc+2Ql5aHyRwJTENB1M8ffWLL2124U9jfJMLdAUB1hL
         cbKymfFtvkHWr9Bq/Rw5elxUg3c7gPcR2X4FTlIuERWQW5Tx+MWQVJwSIOD1/+uAKcVp
         o47cf8bIUr+htME+yhxtKF5DGtRNJxE+z3d7I7K/4MkuQp75XyRMGJaOmLe6PNuheO10
         AqNwrklTLuzUKVldlOQ8jNcb87Ge52A3vsKQ6ZzEqkunNTJkAFcamFcWMc6gYLCTli2J
         H91snKOrpDBIKb4t2BFRTqiQzFHcKfwoh1vzd+BqzX7ocOq853CiHcmAvrQvT/LOTeXK
         cnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=128JU9ZRRKnPuOh1w064by2lJFlQlZWtP6zeO7W2M20=;
        b=xT20TN2S9pSm9z28pTyYhhIDjoUDLgRtUluuT9OigKHDs5nqh2vGxBiFNy7aakpEzk
         7AcuoPi0YKO0hZ10fGlx0sZhgn2JoZOXft9F4J9EoHNFnmLSoAdey00na6UpwRsFWIDt
         rRSNwr3tstQ/Amcn6wN4hWVd1hBkUl4ZCzt/xabDrUC/pYNTeZfj8jBmbhk5mw9YlBK+
         oASx4W38Fgn9L3Nm5522pi+pAm01wCZi81RHNmmOgiH2iForMcUhcR2+X6QgZRqhBuFH
         UX4jBrogjGbUPfOkXo0BUSL1X2KuuF0CIpCXJK/JY10JCgQwiPqCOOhsXx1pJ4tVyRY9
         Uv3g==
X-Gm-Message-State: AOAM533XUG/xRxUltS2SvALdCeQpu+VW2JNgnWB3fUVyNKQUMtlefZIg
        yCERAznoUCWvW0/3q6IBUL9/RKRA5RgklA==
X-Google-Smtp-Source: ABdhPJybaFb4Eb8AzmsyZ1m5I6l9bqn/p3+yuKJ7d+vHnnwtnN/JADScnkI9eL/bT7S7VwD5HPaDGQ==
X-Received: by 2002:a17:903:230c:: with SMTP id d12mr4685510plh.74.1644450956731;
        Wed, 09 Feb 2022 15:55:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm3240799pfi.7.2022.02.09.15.55.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:55:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] rfcomm-tester: Add test to write big chunks of data
Date:   Wed,  9 Feb 2022 15:55:53 -0800
Message-Id: <20220209235553.150294-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209235553.150294-1-luiz.dentz@gmail.com>
References: <20220209235553.150294-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to test traffic similar to OBEX using big chunk of data.
---
 tools/rfcomm-tester.c | 47 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index ef47904de..650d33cb6 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -39,6 +39,7 @@ struct test_data {
 	const void *test_data;
 	unsigned int io_id;
 	uint16_t conn_handle;
+	uint16_t recv_len;
 };
 
 struct rfcomm_client_data {
@@ -297,7 +298,24 @@ const struct rfcomm_client_data connect_send_success = {
 	.server_channel = 0x0c,
 	.client_channel = 0x0c,
 	.data_len = sizeof(data),
-	.send_data = data
+	.send_data = data,
+};
+
+const uint8_t data_8k[8192] = { [0 ... 1023] =  0x00,
+				[1024 ... 2047] =  0x01,
+				[2048 ... 3071] =  0x02,
+				[3072 ... 4095] =  0x03,
+				[4096 ... 5119] =  0x04,
+				[5120 ... 6143] =  0x05,
+				[6144 ... 7167] =  0x06,
+				[7168 ... 8191] =  0x07,
+};
+
+const struct rfcomm_client_data connect_send_8k_success = {
+	.server_channel = 0x0c,
+	.client_channel = 0x0c,
+	.data_len = sizeof(data_8k),
+	.send_data = data_8k,
 };
 
 const struct rfcomm_client_data connect_read_success = {
@@ -448,7 +466,6 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		ssize_t ret;
 
 		tester_print("Writing %u bytes of data", cli->data_len);
-
 		ret = write(sk, cli->send_data, cli->data_len);
 		if (cli->data_len != ret) {
 			tester_warn("Failed to write %u bytes: %s (%d)",
@@ -483,16 +500,29 @@ static void client_hook_func(const void *data, uint16_t len,
 
 	tester_print("bthost received %u bytes of data", len);
 
-	if (cli->data_len != len) {
+	if (test_data->recv_len + len > cli->data_len) {
+		tester_print("received more data than expected");
 		tester_test_failed();
 		return;
 	}
 
-	ret = memcmp(cli->send_data, data, len);
-	if (ret)
+	ret = memcmp(cli->send_data + test_data->recv_len, data, len);
+	if (ret) {
 		tester_test_failed();
-	else
-		tester_test_passed();
+		return;
+	}
+
+	test_data->recv_len += len;
+
+	tester_print("bthost received progress %u/%u", test_data->recv_len,
+							cli->data_len);
+
+	if (cli->data_len != test_data->recv_len)
+		return;
+
+	test_data->recv_len = 0;
+
+	tester_test_passed();
 }
 
 static void server_hook_func(const void *data, uint16_t len,
@@ -735,6 +765,9 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Client - Write Success",
 				&connect_send_success, setup_powered_client,
 				test_connect);
+	test_rfcomm("Basic RFCOMM Socket Client - Write 8k Success",
+				&connect_send_8k_success, setup_powered_client,
+				test_connect);
 	test_rfcomm("Basic RFCOMM Socket Client - Read Success",
 				&connect_read_success, setup_powered_client,
 				test_connect);
-- 
2.34.1

