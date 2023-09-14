Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07819EEAA78
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjINU75 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjINU74 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 16:59:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882CA1FE5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 13:59:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso11523405ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725191; x=1695329991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaARLFdxTSiuKff889Y4htH9Ow1j9hK1wqAsBnI10tQ=;
        b=lek08gIHvCOeQiuY+tuXsL+uxIAzFyISm1wOK/aMDpT8LRZCVvhhL5E9DYaJDnHgRd
         ZYsP4LfWawZxu1FZ/p3TaURbdyxZ0+st3VuoxOSi9hcSeljhJKs3aDZPRChYmbcKX6AF
         Pdt2ONxtOqLBzyqB/W6iK77sbgS54MNWvZrniR4c83sJKrhl4fBSi9L+zyPFjoztnNBH
         N1CJv7Wx+McIF/L56nMRyM5Zll094kXreIiS5ZdN0V7WWDCz+8vofMajMScq/savFhtW
         cOv8a3AwxOLgIKfcYJIUV8Ed3cPEAVy13BHht5aOQkXm2vazSVYj+PGSCLX9Y+V/ghRV
         kjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725191; x=1695329991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaARLFdxTSiuKff889Y4htH9Ow1j9hK1wqAsBnI10tQ=;
        b=XL02c+QMtQEyZohL4dYK8cIMBUstQR0qgbrj2KdsCRhiSzjk4X9uwdLhQ1pS+H7i9Z
         W4PvVF6YgcqaEyufRcfRUF729x+w9FA6ab+JyGZ2mW2MWC2JEcjP2i1tmkBOQFflyhHG
         fKYO2NGKazBIS6H9Qrj/LXP45DO7HjINqWfFWDL8OJof4ahJQ+CTjxyJr1Yj+EjyOJD2
         YJ6+j0Rf8xPmJhRKQBCO+vjCe+AVl4X17UixMGdd2jRWDEey4dACNwnXyKYsW+d2OpLA
         /DQxEwc7LIx6yc2hI4Ioj5WatjavooK57VwXXcuBtzZtJYK15AY/8aNrCZcEkUzaz9FJ
         3rzw==
X-Gm-Message-State: AOJu0Yy7tFdqFE4gr3EkGELbuSrSQ1mBnadSFzKSNAHYLK7mVveHOiIP
        Xz8HWhlGK+GtRm3Y2PTFUwpzUxs3+3QQKQ==
X-Google-Smtp-Source: AGHT+IGEOfwE7OmYEfhwMdqC8DxIwTbKSCC1VYdY1ps94mkPHUoWs+ti1eexxOJdhNDrNbTtJrtL+w==
X-Received: by 2002:a17:903:41c4:b0:1c3:3cde:7b44 with SMTP id u4-20020a17090341c400b001c33cde7b44mr7796109ple.12.1694725191217;
        Thu, 14 Sep 2023 13:59:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001c41e1e9ca7sm1189885plb.215.2023.09.14.13.59.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:59:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] l2cap-tester: Add tests for closing socket before connection completes
Date:   Thu, 14 Sep 2023 13:59:48 -0700
Message-ID: <20230914205949.3334335-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests which attempts to close/shutdown the
socket before the connection completes:

L2CAP BR/EDR Client - Close
L2CAP LE Client - Close
L2CAP Ext-Flowctl Client - Close
---
 tools/l2cap-tester.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 141dd570c3f6..f4810e3eacea 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -271,6 +271,10 @@ static const struct l2cap_data client_connect_success_test = {
 	.server_psm = 0x1001,
 };
 
+static const struct l2cap_data client_connect_close_test = {
+	.client_psm = 0x1001,
+};
+
 static const struct l2cap_data client_connect_ssp_success_test_1 = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -438,6 +442,10 @@ static const struct l2cap_data le_client_connect_success_test_1 = {
 	.server_psm = 0x0080,
 };
 
+static const struct l2cap_data le_client_connect_close_test_1 = {
+	.client_psm = 0x0080,
+};
+
 static const struct l2cap_data le_client_connect_adv_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -678,6 +686,11 @@ static const struct l2cap_data ext_flowctl_client_connect_success_test_1 = {
 	.mode = BT_MODE_EXT_FLOWCTL,
 };
 
+static const struct l2cap_data ext_flowctl_client_connect_close_test_1 = {
+	.client_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+};
+
 static const struct l2cap_data ext_flowctl_client_connect_adv_success_test_1 = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1094,6 +1107,10 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
+	int err, sk_err, sk;
+	socklen_t len = sizeof(sk_err);
+
+	tester_print("Disconnected");
 
 	if (l2data->shut_sock_wr) {
 		/* if socket is closed using SHUT_WR, L2CAP disconnection
@@ -1107,6 +1124,20 @@ static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+	data->io_id = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (-err != l2data->expect_err)
+		tester_test_failed();
+	else
+		tester_test_passed();
+
 	return FALSE;
 }
 
@@ -1454,6 +1485,38 @@ static void test_connect(const void *test_data)
 	tester_print("Connect in progress");
 }
 
+static void test_connect_close(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	GIOChannel *io;
+	int sk;
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
+
+	shutdown(sk, SHUT_RDWR);
+}
+
 static void test_connect_reject(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2122,6 +2185,11 @@ int main(int argc, char *argv[])
 					&client_connect_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - Close",
+					&client_connect_close_test,
+					setup_powered_client,
+					test_connect_close);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client SSP - Success 1",
 					&client_connect_ssp_success_test_1,
 					setup_powered_client, test_connect);
@@ -2188,6 +2256,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP LE Client - Success",
 				&le_client_connect_success_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP LE Client - Close",
+				&le_client_connect_close_test_1,
+				setup_powered_client, test_connect_close);
 	test_l2cap_le("L2CAP LE Client, Direct Advertising - Success",
 				&le_client_connect_adv_success_test_1,
 				setup_powered_client, test_connect);
@@ -2233,6 +2304,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
 				&ext_flowctl_client_connect_success_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_le("L2CAP Ext-Flowctl Client - Close",
+				&ext_flowctl_client_connect_close_test_1,
+				setup_powered_client, test_connect_close);
 	test_l2cap_le("L2CAP Ext-Flowctl Client, Direct Advertising - Success",
 				&ext_flowctl_client_connect_adv_success_test_1,
 				setup_powered_client, test_connect);
-- 
2.41.0

