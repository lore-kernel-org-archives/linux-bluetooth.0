Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED86EEAA71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjINVKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjINVKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:10:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454CE269D
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:10:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so1358895b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725807; x=1695330607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JK+ZdGAxo+bR/VYK8dO5ZTBFJr0ZOvgzoKLYaaA3K2g=;
        b=sBD0Qyhma9RLiiPkbw87MlVXl0i+mGydWrcJ2u/J6yg+MQLD8oUWoeSHOqvgK2fMkN
         ar2TbOy4bz7It5p0AHGQIRJh6lUX/XkK2OZLpbBvlrR0nPiokdTqAElQ9WnWkq34nGrv
         nYRoENa9ylhqRMxxQIsdnVJJffsqL1F+ocqRKJIy/OT8lBDl2DyJTQdciB1PIlOHQ8Eq
         /SSuB+dTdXDJoyNrADxwHQFdg0ZEsLUNps1O4hjSeE1e/x1mGrkZrXPsP4DeRVjEyjlg
         lEiw0qiXlUgB079BiS96jkwjN4VM/E5Ba3tzWC5c9EnMsU+h3Vp2sPsKm8jytNKx6k7S
         9AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725807; x=1695330607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK+ZdGAxo+bR/VYK8dO5ZTBFJr0ZOvgzoKLYaaA3K2g=;
        b=LwVFdhTwaij0RBosj4pcNlV4aP2kChFddBFtgjPJtvQmC0rcYgzQv76u5/5Gz9OuG/
         euxumSSYXK29/xMKrcs/q0fEEZJN0UjTfwJuTF5j70Dff6O4isG8SepONpSEjRu+lZId
         xzcLsNCXgNXjw0hMPKRayh0hDY5vLzGpXzzn2fn9S26OrKYr0OaBqxRdR9aOcXqScvII
         kSCJlqHuEe8XcZ4QmcFKDsDV7Gb4VJlfShH+ylTTKbgPnFZ8LarFjjSIPOYXs/bN3vlR
         G/LpXhPOuSsthIpGX9+uPV0JxDqN43CSmYmJf6ZHW3ogthfl7Jag9PIODFnb9FyuE37u
         Nq+A==
X-Gm-Message-State: AOJu0YzWR6RKoH1mk/t85GqeFDCl903qvBgE3zJQeySlwfA1e8ifhPV5
        fVlA/emyeMPrU8GFQQa2lphQyiWJaCGG6Q==
X-Google-Smtp-Source: AGHT+IGdCFXosgpHeZ5EyPJCu5r36Il0HUC84YY6ckaW4kWO9pujqU0Ib4ATil+usiRt3OKsY3eRuA==
X-Received: by 2002:a05:6a00:1487:b0:68f:ca4a:efd with SMTP id v7-20020a056a00148700b0068fca4a0efdmr6736949pfu.9.1694725806845;
        Thu, 14 Sep 2023 14:10:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006862b2a6b0dsm1803805pfo.15.2023.09.14.14.10.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:10:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] l2cap-tester: Add tests for connection timeout
Date:   Thu, 14 Sep 2023 14:10:03 -0700
Message-ID: <20230914211003.3339238-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914211003.3339238-1-luiz.dentz@gmail.com>
References: <20230914211003.3339238-1-luiz.dentz@gmail.com>
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
index f4810e3eacea..461f2c27c456 100644
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
 
+	if (l2data && l2data->timeout) {
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

