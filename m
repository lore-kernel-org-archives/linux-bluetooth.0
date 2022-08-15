Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6DC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Aug 2022 20:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiHOUaH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbiHOU21 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Aug 2022 16:28:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D6A0309
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 12:04:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so15266340pjm.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=cuPRCkvQeG5HIhqrSQM6cMW0/VGQY5Sj+xUZuti1SOY=;
        b=JUb2hnAIlEZbVDczAlCoB0R7G02QqigjL6A8uO43nz8p+WNfyxx4vDycJ7yjUQIGvp
         GfSSwSxvFHhwajOlhAXWqHyXNPlIQc9SbcyNFKfOarVhj93Q8HAQcJtQkHA3RgcnoSzr
         oAkQtFxlo+Ei1iJ6KPVkIpKr6g+wWM5JkureHKOynUu4STIVL1Bfp4a0CZKEQOw72DBB
         WbsTLIkVNYI5AitRB6pZr4X638c97kNV1EoAiAlUEoczHLyqhX8R8whkEIVTxSnOmERf
         hn/JyR0EG9hPCfCbulN023utNZPgscmCrrssCFuVfw5LVXZ38+ftkP47lDaaUgomosxt
         wthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=cuPRCkvQeG5HIhqrSQM6cMW0/VGQY5Sj+xUZuti1SOY=;
        b=leP3walCNlLofbGGyJfN+F/vODJIPkw3axmxU7naMIairIvU6gMHVt/20QnNEL98Tj
         2oCSZp+UvMKd66GEk8j0Bo0WcDGNTVuTeMXVxshmv2UxAZSGLZYce0GYWvXxWFV5yokS
         FjmwimfU91JjcNG0fBmCvo8c5LVZk0O14F1MuPnZw2ASw7zf8QO6mj0dGVkNI5mZTkN5
         ARbpzSRCXA3j5glUVz3MRBnb06hHIEkgVsx4287Y6dewrdw3QyGJp2An1WxP+10bHQzG
         6C96+5iM3GrkA9jspNAbdLKsEdWN7J3uNywLeUkoSAILBjBB6LyIbQPr7mxE54gupwtG
         6EkQ==
X-Gm-Message-State: ACgBeo1MlesYL5RvC08MxuVs2lEWiuxZXmUYFqeCc+123kEWPzu6PWzc
        MwFf2uTSlkyKjSEEDJHBps5oJJmVMWoM8w==
X-Google-Smtp-Source: AA6agR78u8sw6daXSos1x6kvRjDyvtcJ4XH3ia8Ri6jv7OcNiQELLfUgiDUiUUYRddBoNMIIUYs6rA==
X-Received: by 2002:a17:902:ed93:b0:170:a752:47ba with SMTP id e19-20020a170902ed9300b00170a75247bamr18005194plj.99.1660590247028;
        Mon, 15 Aug 2022 12:04:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a284e00b001f31776ccf3sm4917609pjf.12.2022.08.15.12.04.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:04:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Introduce tests for Disconnect/Reconnect
Date:   Mon, 15 Aug 2022 12:04:01 -0700
Message-Id: <20220815190401.1176081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces a test that do use shutdown to disconnect an ISO socket
and then another one that attempts to reconnect it again to emulate
upper profile transitions.
---
 tools/iso-tester.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index df46bc953f37..e4950ead7c69 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -136,6 +136,7 @@ struct test_data {
 	unsigned int io_id[2];
 	uint8_t client_num;
 	int step;
+	bool reconnect;
 };
 
 struct iso_client_data {
@@ -146,6 +147,7 @@ struct iso_client_data {
 	bool server;
 	bool bcast;
 	bool defer;
+	bool disconnect;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -611,6 +613,18 @@ static const struct iso_client_data connect_16_2_1_send_recv = {
 	.recv = &send_16_2_1,
 };
 
+static const struct iso_client_data disconnect_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.disconnect = true,
+};
+
+static const struct iso_client_data reconnect_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.disconnect = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_send = {
 	.qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
@@ -1142,6 +1156,49 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 		iso_recv(data, io);
 }
 
+static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func);
+static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data);
+
+static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+
+	data->io_id[0] = 0;
+
+	if (cond & G_IO_HUP) {
+		tester_print("Successfully disconnected");
+
+		if (data->reconnect) {
+			data->reconnect = false;
+			setup_connect(data, 0, iso_connect_cb);
+			return FALSE;
+		}
+
+		tester_test_passed();
+	} else
+		tester_test_failed();
+
+	return FALSE;
+}
+
+static void iso_shutdown(struct test_data *data, GIOChannel *io)
+{
+	int sk, cl;
+
+	sk = g_io_channel_unix_get_fd(io);
+	cl = dup(sk);
+
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+
+	/* Shutdown clone fd so the original fd don't HUP immediately and
+	 * properly wait for socket to be closed.
+	 */
+	shutdown(cl, SHUT_RDWR);
+	close(cl);
+}
+
 static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1195,6 +1252,8 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			iso_send(data, io);
 		else if (isodata->recv)
 			iso_recv(data, io);
+		else if (isodata->disconnect)
+			iso_shutdown(data, io);
 		else
 			tester_test_passed();
 	}
@@ -1306,6 +1365,19 @@ static void test_connect(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb);
 }
 
+static void setup_reconnect(struct test_data *data, uint8_t num, GIOFunc func)
+{
+	data->reconnect = true;
+	setup_connect(data, num, func);
+}
+
+static void test_reconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup_reconnect(data, 0, iso_connect_cb);
+}
+
 static void test_defer(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1726,6 +1798,14 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect);
 
+	test_iso("ISO Disconnect - Success", &disconnect_16_2_1,
+							setup_powered,
+							test_connect);
+
+	test_iso("ISO Reconnect - Success", &reconnect_16_2_1,
+							setup_powered,
+							test_reconnect);
+
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
 	test_iso("ISO Broadcaster BIG 0x01 - Success", &bcast_1_16_2_1_send,
-- 
2.37.2

