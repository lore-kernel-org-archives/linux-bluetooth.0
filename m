Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2402FC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 21:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYVm6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 16:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBYVm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 16:42:57 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC1A5CD
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 13:42:54 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6A2D3240174
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 22:42:53 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PPKxT07cPz9rxF;
        Sat, 25 Feb 2023 22:42:52 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] iso-tester: Add test for central receiving timestamped ISO packet
Date:   Sat, 25 Feb 2023 21:42:51 +0000
Message-Id: <b0e2347cc5092c800c083c20b29cd6bbce9295d5.1677361002.git.pav@iki.fi>
In-Reply-To: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
References: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This attempts to receive a timestamped HCI ISO data packet on central.

With kernel 6.2 HCI ISO packet parsing this test fails with
Bluetooth: Frame malformed (len 40, expected len 0)

Link: https://lore.kernel.org/linux-bluetooth/1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi/
---
 tools/iso-tester.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index dcfd6a045..7bcb1b3ca 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -149,6 +149,7 @@ struct iso_client_data {
 	bool bcast;
 	bool defer;
 	bool disconnect;
+	bool ts;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -572,6 +573,14 @@ static const struct iso_client_data listen_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data listen_16_2_1_recv_ts = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+	.ts = true,
+};
+
 static const struct iso_client_data defer_16_2_1 = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1157,7 +1166,8 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 	}
 
 	host = hciemu_client_get_host(data->hciemu);
-	bthost_send_iso(host, data->handle, false, sn++, 0, isodata->recv, 1);
+	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
+							isodata->recv, 1);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
@@ -1809,6 +1819,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
+	test_iso("ISO Receive Timestamped - Success", &listen_16_2_1_recv_ts,
+							setup_powered,
+							test_listen);
+
 	test_iso("ISO Defer - Success", &defer_16_2_1, setup_powered,
 							test_defer);
 
-- 
2.39.2

