Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023DC7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEUP1r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEUP1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:27:45 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB2D7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:27:43 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4BA03240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:27:42 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPPbK61Hhz9rxF;
        Sun, 21 May 2023 17:27:41 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] iso-tester: add tests for multiple simultaneous CIG
Date:   Sun, 21 May 2023 15:27:38 +0000
Message-Id: <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add tests connecting two CIS using different CIG_ID, with fixed and
auto-allocated IDs.

ISO Connect2 CIG 0x01/0x02 Seq - Success
ISO Connect2 CIG auto/auto Seq - Success

The CIS are connected sequentially so that the first is closed after the
second is connected. In the auto/auto case the kernel shall pick a new
CIG_ID since the first CIG_ID is no longer in a configurable state.
---

Notes:
    The second tests hits a bug in kernel CIG auto-allocation, which always
    picks CIG_ID 0 even if it is not in a configurable state.
    
    ISO Connect2 CIG auto/auto Seq - Success - setup complete
    ISO Connect2 CIG auto/auto Seq - Success - run
      Connecting to 00:AA:01:01:00:00...
      Connect 0 in progress
      Connecting to 00:AA:01:02:00:01...
      Connect 1 in progress
      Successfully connected
      Step 1
      Connect failed: Device or resource busy (16)
      Expect error: Success (0) != Device or resource busy (16)

 tools/iso-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 164cb465f..fc2a84215 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -64,6 +64,11 @@
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
+#define QOS_2(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
 #define QOS_1_1(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(0x01, 0x01, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
@@ -109,6 +114,7 @@
 #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
 #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
 #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
+#define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
 #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
 #define QOS_24_1_1 QOS(7500, 8, 45, 0x02, 2)
 #define QOS_24_2_1 QOS(10000, 10, 60, 0x02, 2)
@@ -546,6 +552,20 @@ static const struct iso_client_data connect_1_16_2_1 = {
 	.expect_err = 0
 };
 
+static const struct iso_client_data connect_2_16_2_1 = {
+	.qos = QOS_1_16_2_1,
+	.qos_2 = QOS_2_16_2_1,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_2a_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.qos_2 = QOS_16_2_1,
+	.expect_err = 0,
+	.mcis = true,
+};
+
 static const struct iso_client_data connect_1_1_16_2_1 = {
 	.qos = QOS_1_1_16_2_1,
 	.expect_err = 0
@@ -2126,6 +2146,25 @@ static void test_connect2(const void *test_data)
 	setup_connect_many(data, 2, num, funcs);
 }
 
+static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id[0] = 0;
+
+	setup_connect(data, 1, iso_connect2_cb);
+
+	return iso_connect(io, cond, user_data);
+}
+
+static void test_connect2_seq(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup_connect(data, 0, iso_connect2_seq_cb);
+}
+
 static void test_bcast(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2264,6 +2303,15 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
+	test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &connect_2_16_2_1,
+							setup_powered,
+							test_connect2_seq);
+
+	test_iso2("ISO Connect2 CIG auto/auto Seq - Success",
+							&connect_2a_16_2_1,
+							setup_powered,
+							test_connect2_seq);
+
 	test_iso_rej("ISO Connect - Reject", &connect_reject, setup_powered,
 			test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 
-- 
2.40.1

