Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D4C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjE1Rjf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE1Rje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:39:34 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC4D8
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:39:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DA38C240028
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:39:18 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTm9y1lCwz6tm4;
        Sun, 28 May 2023 19:39:18 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] iso-tester: Add tests for AC configuration reconnect
Date:   Sun, 28 May 2023 17:39:13 +0000
Message-Id: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add test for reconnecting a CIG with two CIS, either both with same peer
or with different peers.

ISO Reconnect AC 6(i) - Success
ISO Reconnect AC 6(ii) - Success
---

Notes:
    The intent here was to trigger the kernel to send Remove CIG and Set CIG
    Parameters in the wrong order, but it doesn't hit the right timing in
    the emulator. It occurs on real hardware when BlueZ recreates multiple
    CIS at the same time.
    
    This can occur because Remove CIG is sent via hci_sync queue and
    queueing its request may be delayed until hci_cmd_sync_work runs,
    whereas Set CIG Parameters request is queued directly via hci_send_cmd.
    
    However, these tests were useful to have, as they hit Create CIS timing
    issues if Set CIG Parameters is moved to hci_sync.

 tools/iso-tester.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 63c37bd52..776d87fc1 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -839,6 +839,15 @@ static const struct iso_client_data connect_ac_6i = {
 	.defer = true,
 };
 
+static const struct iso_client_data reconnect_ac_6i = {
+	.qos = AC_6i_1,
+	.qos_2 = AC_6i_2,
+	.expect_err = 0,
+	.mcis = true,
+	.defer = true,
+	.disconnect = true,
+};
+
 static const struct iso_client_data connect_ac_6ii = {
 	.qos = AC_6ii_1,
 	.qos_2 = AC_6ii_2,
@@ -847,6 +856,15 @@ static const struct iso_client_data connect_ac_6ii = {
 	.defer = true,
 };
 
+static const struct iso_client_data reconnect_ac_6ii = {
+	.qos = AC_6ii_1,
+	.qos_2 = AC_6ii_2,
+	.expect_err = 0,
+	.mcis = true,
+	.defer = true,
+	.disconnect = true,
+};
+
 static const struct iso_client_data connect_ac_7i = {
 	.qos = AC_7i_1,
 	.qos_2 = AC_7i_2,
@@ -1626,7 +1644,7 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 		iso_recv(data, io);
 }
 
-static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func);
+static void test_connect(const void *test_data);
 static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data);
 
@@ -1642,7 +1660,7 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 
 		if (data->reconnect) {
 			data->reconnect = false;
-			setup_connect(data, 0, iso_connect_cb);
+			test_connect(data->test_data);
 			return FALSE;
 		}
 
@@ -1885,17 +1903,12 @@ static void test_connect(const void *test_data)
 	setup_connect_many(data, n, num, func);
 }
 
-static void setup_reconnect(struct test_data *data, uint8_t num, GIOFunc func)
-{
-	data->reconnect = true;
-	setup_connect(data, num, func);
-}
-
 static void test_reconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	setup_reconnect(data, 0, iso_connect_cb);
+	data->reconnect = true;
+	test_connect(test_data);
 }
 
 static void test_defer(const void *test_data)
@@ -2410,6 +2423,14 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect2_seq);
 
+	test_iso2("ISO Reconnect AC 6(i) - Success", &reconnect_ac_6i,
+							setup_powered,
+							test_reconnect);
+
+	test_iso2("ISO Reconnect AC 6(ii) - Success", &reconnect_ac_6ii,
+							setup_powered,
+							test_reconnect);
+
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
 	test_iso("ISO Broadcaster Encrypted - Success", &bcast_enc_16_2_1_send,
-- 
2.40.1

