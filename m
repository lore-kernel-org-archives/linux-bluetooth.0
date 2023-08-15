Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C9EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 22:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjHOWRr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjHOWRm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 18:17:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755341FF0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:17:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bddac1b7bfso18304055ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692137860; x=1692742660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2GGNUHxPfs0gRZZKe1YJ7DdUoT+B9tUTgGV0yBJ9pA=;
        b=HLUOzWbO9P7JXjN06qG8vjbMmXv9ZlRJy0Cje5Toe1XxOKZpC/7dA4ugi6ffdnmbSn
         ZtPR/UjhX0TrU3zxmaDItXLgiszupQszrvqp9FxMxGSBKzPVLWZLEIXk7B7yqMhiZBrN
         QgHoC+HB8XjSnL78SVRq+S02xU3ySpWDPByJluamXgQ7jKgd6ocUfiPbwJZ3/jpqGL18
         4m5dE3528l/YhpNsLDsTytuG0Ds8tAMbPxBoYZX0GaJFojiflIcUtKm8FEIhl3NN2Jjp
         KI5+yw+/MPEhc9wqLlHVCCX9EaaI27iQIL78lbGSXuODsmOeZqhgV+469an23sVatca7
         UNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137860; x=1692742660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2GGNUHxPfs0gRZZKe1YJ7DdUoT+B9tUTgGV0yBJ9pA=;
        b=N+kh5gS3SCM6OX/pjaGKFDCa03vBpF2Ne1O9D0MQ3RzJ11+yZik9rmA3Nc1249X2dP
         CSnM0SCX/7029T4Kdr8Cl/QxYKsrbxic5e4PUCIble264gmoRr5GtahDzuE4mkpm6Wsk
         fD7KJ9sERc7WIu/L1EkARHAu/BpxTATEkc4uCQliw2Z6/5sm8eEHevQJ81LHlTlMZz74
         GQA4CdmWqhROtX3MTOfURSnBYURyjWwiRkQ93TxbSYCsPDxKXNdTaL+XEvoIPNxeozGB
         p/7tDv9tswexqMrByR2rBLgtUWnYOdfP3MfaEF39OKJisb0pTxg2/MK4KEHm306lKZsH
         JFPA==
X-Gm-Message-State: AOJu0YwdXvPrw2J3oLxQIy7dJ9/wg+UZTVSfC1FuGpG1ODvD1JaQ63C5
        qQ4xCsxHmpyCixMwgP9hEPGaVs9mmf0=
X-Google-Smtp-Source: AGHT+IHJbqo/rw24teC46Wgc7pLgmvSZtusT7ohpQ91K3Gr6IEUjaRp72aUT+A6KkAvgiVOUlT22nw==
X-Received: by 2002:a17:903:22c6:b0:1bb:b2f7:e075 with SMTP id y6-20020a17090322c600b001bbb2f7e075mr358171plg.7.1692137860007;
        Tue, 15 Aug 2023 15:17:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001adf6b21c77sm11543606plf.107.2023.08.15.15.17.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:17:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Add suspend tests
Date:   Tue, 15 Aug 2023 15:17:38 -0700
Message-ID: <20230815221738.2491772-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following test which attempt to trigger suspend code path
while ISO sockets are connecting or have been connected:

ISO Connect Suspend - Success
ISO Connected Suspend - Success
ISO Connect2 Suspend - Success
ISO Connected2 Suspend - Success
---
 tools/iso-tester.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 5a8b1fe6857b..b1a2afba09e1 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -25,6 +25,7 @@
 #include "lib/mgmt.h"
 
 #include "monitor/bt.h"
+#include "emulator/vhci.h"
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
@@ -391,6 +392,7 @@ struct test_data {
 	uint8_t client_num;
 	int step;
 	bool reconnect;
+	bool suspending;
 };
 
 struct iso_client_data {
@@ -405,6 +407,7 @@ struct iso_client_data {
 	bool disconnect;
 	bool ts;
 	bool mconn;
+	bool suspend;
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
@@ -806,6 +809,11 @@ static const struct iso_client_data connect_reject = {
 	.expect_err = -ENOSYS
 };
 
+static const struct iso_client_data connect_suspend = {
+	.qos = QOS_16_2_1,
+	.expect_err = -ECONNRESET
+};
+
 static const struct iso_client_data connect_cig_f0_invalid = {
 	.qos = QOS_FULL(0xF0, 0x00, {}, QOS_IO(10000, 10, 40, 0x02, 2)),
 	.expect_err = -EINVAL
@@ -920,6 +928,11 @@ static const struct iso_client_data disconnect_16_2_1 = {
 	.disconnect = true,
 };
 
+static const struct iso_client_data suspend_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.suspend = true,
+};
+
 static const struct iso_client_data reconnect_16_2_1 = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1255,7 +1268,7 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 			continue;
 
 		if (isodata->send || isodata->recv || isodata->disconnect ||
-						data->accept_reason)
+				isodata->suspend || data->accept_reason)
 			bthost_set_iso_cb(host, iso_accept_conn, iso_new_conn,
 									data);
 
@@ -1892,6 +1905,46 @@ static void iso_shutdown(struct test_data *data, GIOChannel *io)
 	tester_print("Disconnecting...");
 }
 
+static bool hook_set_event_mask(const void *msg, uint16_t len, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("Set Event Mask");
+
+	--data->step;
+	if (!data->step)
+		tester_test_passed();
+
+	return true;
+}
+
+static void trigger_force_suspend(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	int err;
+
+	/* Make sure suspend is only triggered once */
+	if (data->suspending)
+		return;
+
+	data->suspending = true;
+
+	/* Triggers the suspend */
+	tester_print("Set the system into Suspend via force_suspend");
+	err = vhci_set_force_suspend(vhci, true);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		return;
+	}
+
+	data->step++;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_SET_EVENT_MASK,
+					hook_set_event_mask, data);
+}
+
 static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1954,6 +2007,8 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 			iso_recv(data, io);
 		else if (isodata->disconnect)
 			iso_shutdown(data, io);
+		else if (isodata->suspend)
+			trigger_force_suspend(data);
 		else
 			tester_test_passed();
 	}
@@ -2567,6 +2622,12 @@ static void test_connect_wait_close(const void *test_data)
 	setup_connect(data, 0, iso_connect_wait_close_cb);
 }
 
+static void test_connect_suspend(const void *test_data)
+{
+	test_connect(test_data);
+	trigger_force_suspend((void *)test_data);
+}
+
 static void test_bcast(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2590,6 +2651,12 @@ static void test_bcast_recv(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static void test_connect2_suspend(const void *test_data)
+{
+	test_connect2(test_data);
+	trigger_force_suspend((void *)test_data);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -2755,6 +2822,14 @@ int main(int argc, char *argv[])
 	test_iso("ISO Connect Wait Close - Success", &connect_16_2_1,
 					setup_powered, test_connect_wait_close);
 
+	test_iso("ISO Connect Suspend - Success", &connect_suspend,
+							setup_powered,
+							test_connect_suspend);
+
+	test_iso("ISO Connected Suspend - Success", &suspend_16_2_1,
+							setup_powered,
+							test_connect);
+
 	test_iso2("ISO Connect2 CIG 0x01 - Success", &connect_1_16_2_1,
 							setup_powered,
 							test_connect2);
@@ -2767,6 +2842,14 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect2);
 
+	test_iso2("ISO Connect2 Suspend - Success", &connect_suspend,
+							setup_powered,
+							test_connect2_suspend);
+
+	test_iso2("ISO Connected2 Suspend - Success", &suspend_16_2_1,
+							setup_powered,
+							test_connect2);
+
 	test_iso("ISO Defer Send - Success", &connect_16_2_1_defer_send,
 							setup_powered,
 							test_connect);
-- 
2.41.0

