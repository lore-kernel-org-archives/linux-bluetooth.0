Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F1EEAA71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 20:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjINU77 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 16:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjINU76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 16:59:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7691FE5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 13:59:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c4194f769fso7456495ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725193; x=1695329993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqKHbbes1gZ7xOcjb2J4XO9bZrI7ScLNJSAy2Zza/K0=;
        b=W4J5rDHepoRee4j2zAdmWmWhGKidjTdfnvHqtfkEW2icGt3HnVvBXgZ7JAqjq9FW9a
         SQ0sBCem52keYhnyEbwxHwNxUCeBz1gVE4NDej1dcCBHPQvUoWIZun5uo+ANIGO1gku0
         G21xpogwh1Xu411D+l39Pm+SIe5LuNDB93hRa0E0E8ksC1Rf0fSwmxvNgfeTRdwKqQgG
         vtOH4YpwSv3wS/gNur06UcKTfoIwbn/CHS+Sa/TX5NSOpQukskZagRShGwzm2X14HZ/O
         PAEoBvNQD+7TLekdUfHGWJVorNdmdEDYbQR41HMxHuOZTO6GjqIH9quetHsuBobMLST6
         B+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725193; x=1695329993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqKHbbes1gZ7xOcjb2J4XO9bZrI7ScLNJSAy2Zza/K0=;
        b=GDzmhcvLPUfjlsbxh22WF3TS5gBjl4UL/M+dqGLfATN7iIxnGlnfLjf10UbudOIvEZ
         J2eXBiMbXJynTce+eykCPeGhu3eSSNxpzphByowGh59AQMAgUuoyGGR3Jsk6Vn8/bTVo
         VRBm/4i4NHBXEtQ8i/GRl80/NAQuhzIUttU0SnZhw+EN8PkItVWYekPzDT8pTJr/O6mf
         amZGPiziZacIhXeVCS/R6iHa2/ru27mHciIegoR15fdU4DHwnDglaDWAIlh6E3dm71FE
         z4fNADGHqNZqhsaOb1Bw3wev0ckvTtGHXVW0U4R0FBDo0etLNkHoSyAIszs04wx90eYf
         MmbA==
X-Gm-Message-State: AOJu0Ywa+ZpQH47fH3bLrzBbpArPlTbfItV1s9uJUlLBTNN3PVu9y+Ei
        A9BUFH+M6P44tncnWF7zO+pf/zbpN+fxGg==
X-Google-Smtp-Source: AGHT+IFV8BxBxE5EWQTLaFrSFzHDnFsg4a3+t5AFEMFD7i6ygC5N176tX0usbRqhqRbstCXI/SeW1A==
X-Received: by 2002:a17:902:f689:b0:1c4:1cd3:803a with SMTP id l9-20020a170902f68900b001c41cd3803amr2050244plg.54.1694725192931;
        Thu, 14 Sep 2023 13:59:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001c41e1e9ca7sm1189885plb.215.2023.09.14.13.59.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:59:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] l2cap-tester: Add tests for connection timeout
Date:   Thu, 14 Sep 2023 13:59:49 -0700
Message-ID: <20230914205949.3334335-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914205949.3334335-1-luiz.dentz@gmail.com>
References: <20230914205949.3334335-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests which attempts to use SO_SNDTIMEO so the
socket times out before the connection completes:

L2CAP BR/EDR Client - Timeout
L2CAP LE Client - Timeout
L2CAP Ext-Flowctl Client - Timeout
---
 tools/l2cap-tester.c | 82 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index f4810e3eacea..d4bbf2105e19 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -52,6 +52,7 @@ struct l2cap_data {
 	uint16_t cid;
 	uint8_t mode;
 	int expect_err;
+	int timeout;
 
 	uint8_t send_cmd_code;
 	const void *send_cmd;
@@ -275,6 +276,11 @@ static const struct l2cap_data client_connect_close_test = {
 	.client_psm = 0x1001,
 };
 
+static const struct l2cap_data client_connect_timeout_test = {
+	.client_psm = 0x1001,
+	.timeout = 1
+};
+
 static const struct l2cap_data client_connect_ssp_success_test_1 = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -446,6 +452,11 @@ static const struct l2cap_data le_client_connect_close_test_1 = {
 	.client_psm = 0x0080,
 };
 
+static const struct l2cap_data le_client_connect_timeout_test_1 = {
+	.client_psm = 0x0080,
+	.timeout = 1,
+};
+
 static const struct l2cap_data le_client_connect_adv_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -691,6 +702,12 @@ static const struct l2cap_data ext_flowctl_client_connect_close_test_1 = {
 	.mode = BT_MODE_EXT_FLOWCTL,
 };
 
+static const struct l2cap_data ext_flowctl_client_connect_timeout_test_1 = {
+	.client_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.timeout = 1,
+};
+
 static const struct l2cap_data ext_flowctl_client_connect_adv_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -793,6 +810,11 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
 	tester_print("Controller powered on");
 
+	if (!l2data->server_psm && !l2data->cid) {
+		tester_setup_complete();
+		return;
+	}
+
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
 
@@ -1133,9 +1155,11 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 	else
 		err = -sk_err;
 
-	if (-err != l2data->expect_err)
+	if (!l2data->timeout && -err != l2data->expect_err) {
+		tester_print("err %d != %d expected_err", -err,
+						l2data->expect_err);
 		tester_test_failed();
-	else
+	} else
 		tester_test_passed();
 
 	return FALSE;
@@ -1517,6 +1541,50 @@ static void test_connect_close(const void *test_data)
 	shutdown(sk, SHUT_RDWR);
 }
 
+static void test_connect_timeout(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	GIOChannel *io;
+	int sk;
+	struct timeval sndto;
+	socklen_t len;
+
+	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
+							l2data->mode);
+	if (sk < 0) {
+		if (sk == -ENOPROTOOPT)
+			tester_test_abort();
+		else
+			tester_test_failed();
+		return;
+	}
+
+	memset(&sndto, 0, sizeof(sndto));
+
+	sndto.tv_sec = l2data->timeout;
+	len = sizeof(sndto);
+	if (setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO, &sndto, len) < 0) {
+		tester_print("Can't set SO_SNDTIMEO: %s (%d)", strerror(errno),
+								errno);
+		close(sk);
+		tester_test_failed();
+		return;
+	}
+
+	if (connect_l2cap_sock(data, sk, l2data->client_psm,
+							l2data->cid) < 0) {
+		close(sk);
+		tester_test_failed();
+		return;
+	}
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io_id = g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
+	g_io_channel_unref(io);
+}
+
 static void test_connect_reject(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2189,6 +2257,10 @@ int main(int argc, char *argv[])
 					&client_connect_close_test,
 					setup_powered_client,
 					test_connect_close);
+	test_l2cap_bredr("L2CAP BR/EDR Client - Timeout",
+					&client_connect_timeout_test,
+					setup_powered_client,
+					test_connect_timeout);
 
 	test_l2cap_bredr("L2CAP BR/EDR Client SSP - Success 1",
 					&client_connect_ssp_success_test_1,
@@ -2259,6 +2331,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Close",
 				&le_client_connect_close_test_1,
 				setup_powered_client, test_connect_close);
+	test_l2cap_le("L2CAP LE Client - Timeout",
+				&le_client_connect_timeout_test_1,
+				setup_powered_client, test_connect_timeout);
 	test_l2cap_le("L2CAP LE Client, Direct Advertising - Success",
 				&le_client_connect_adv_success_test_1,
 				setup_powered_client, test_connect);
@@ -2307,6 +2382,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Close",
 				&ext_flowctl_client_connect_close_test_1,
 				setup_powered_client, test_connect_close);
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Timeout",
+				&ext_flowctl_client_connect_timeout_test_1,
+				setup_powered_client, test_connect_timeout);
 	test_l2cap_le("L2CAP Ext-Flowctl Client, Direct Advertising - Success",
 				&ext_flowctl_client_connect_adv_success_test_1,
 				setup_powered_client, test_connect);
-- 
2.41.0

