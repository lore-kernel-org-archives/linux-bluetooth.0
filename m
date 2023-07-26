Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7EC001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGZVZh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGZVZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEC2691
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:27 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pc6ZBTz49QB3;
        Thu, 27 Jul 2023 00:25:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DNUUcIqQRI29RfL+gzzuUWprMVU8P/baS0HhcuDiT4=;
        b=p73JBeAE2lbmwSFvCkJSmd7EukEMr1bADTGU4QCxQaI6ljZUcfYXT5ZeD58ujc3qZiSwgE
        coFZFap2b8HmkkKtbwImjq72Ekp/912BODdc3kAIr6V/QeslgcQT+cw2hClY1cv4R+4kNv
        HpC27/kSx6eK9P76W9/Q0XvabjXVKa24sEwjDvL7Do1S7f0RD+HyZFY6TKdYIkyBsAFGv0
        xjtlGIP9Ypc4G00UlzBedq4IhHT8ybrGSjzYCbxf7QVNvR1wrlEkVMvFkDdYzbs9pLgSsL
        lom55gWV3IFzCKEY/qbae4eW5qxIJk1dSEPvTMNJ2FixLmuiOb+8U21Qk/HoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DNUUcIqQRI29RfL+gzzuUWprMVU8P/baS0HhcuDiT4=;
        b=ibMBBYN1QKFSUlbBGFTn499IfS7Z97Yb9INsvATQ9Osgqr+iv8eY6BsRmmJf6nmSYUCDDH
        cSwtwp6cE3jEaP9Hlc0CKMAnk9BeyKnXdiBNT302+xZZ2aD5+BfoL7nu36NHQE/0jgdvGB
        nnQn0q/m+h/m71jsB8Rie3gf5G9Meer1T75NEha7Ani5z9fukj5AnGcnKns1rmfBnjICWo
        tZdFEfj0ETTE87WF6OqeucmETsV3xzjUeK9i73qa2L/iEg3m8gkgaJOeY37W9Ow6pWkkQI
        dfLabeQoTF8CHYtg3XU05YwNOyDugm3XuMHdxN3cM2URL33sJmFDEpPgbkTypw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406724; a=rsa-sha256;
        cv=none;
        b=cIgTC2qsU7jjhDQma3YRsVUDDjMHbNC1UMGsJ317ok4FRAy0s6oP0jaA17IoIQqaTT83ym
        ZOThRYYG/TJQidr3xr1UB135e0KcuL2GnQlvGtv9Y424H7yFs5LkOoda1LP05I8uGCd3F+
        sPTLvX3aNUGVtaQTlk2ilngA5AWv9CjUyI8VscPTjCH/kZBZ+EJZsCNltukAP6dstCkxbp
        HyDLIYJIml7+R6g4a4LB3S5Prt80bN6LPgxn5m0uIZkSrMG4AVRJx/V4A5y2r5v5hvtMRl
        q/xYOMBFh9mB4Fx6YoWDO5lxWowsnbYf4EadDlzuhMIvs6tqMuGJq2MWBvElUQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID
Date:   Thu, 27 Jul 2023 00:25:17 +0300
Message-ID: <a2c050b5412db5692334d1c3e2e2563ee43bf3d1.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add test with a large CIS_ID and multiple CIS so it hits an error
condition in current kernels (which is why the AC configuration is
used).

Add tests for invalid configurations with bad or duplicate IDs, and for
trying to connect two CIS in same CIG without BT_DEFER_SETUP.

ISO QoS CIG 0xF0 - Invalid
ISO QoS CIS 0xF0 - Invalid
ISO Connect2 CIG 0x01 - Success/Invalid
ISO AC 6(ii) CIS 0xEF/auto - Success
ISO AC 6(ii) CIS 0xEF/0xEF - Invalid
---

Notes:
    Current bluetooth-next/master fails these tests with
    
    ISO QoS CIG 0xF0 - Invalid                           Timed out    2.301 seconds
    ISO QoS CIS 0xF0 - Invalid                           Failed       0.117 seconds
    ISO Connect2 CIG 0x01 - Success/Invalid              Failed       0.189 seconds
    ISO AC 6(ii) CIS 0xEF/auto - Success                 Failed       0.196 seconds

 tools/iso-tester.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 8f43d7bec..9f853a0f9 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -95,6 +95,10 @@
 	QOS_FULL(0x01, 0x02, \
 		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
+#define QOS_OUT_1_EF(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x01, 0xEF, \
+		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
 #define QOS_IN(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
@@ -172,6 +176,7 @@
  */
 #define AC_6ii_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
 #define AC_6ii_2 QOS_OUT_1(10000, 10, 40, 0x02, 2)
+#define AC_6ii_1_EF QOS_OUT_1_EF(10000, 10, 40, 0x02, 2)  /* different CIS ID */
 /* Two unidirectional CISes. Unicast Server is Audio Sink and Audio Source.
  * #1 - CIG 1 CIS 1 (input)
  * #2 - CIG 1 CIS 2 (output)
@@ -801,6 +806,16 @@ static const struct iso_client_data connect_reject = {
 	.expect_err = -ENOSYS
 };
 
+static const struct iso_client_data connect_cig_f0_invalid = {
+	.qos = QOS_FULL(0xF0, 0x00, {}, QOS_IO(10000, 10, 40, 0x02, 2)),
+	.expect_err = -EINVAL
+};
+
+static const struct iso_client_data connect_cis_f0_invalid = {
+	.qos = QOS_FULL(0x00, 0xF0, {}, QOS_IO(10000, 10, 40, 0x02, 2)),
+	.expect_err = -EINVAL
+};
+
 static const uint8_t data_16_2_1[40] = { [0 ... 39] = 0xff };
 static const struct iovec send_16_2_1 = {
 	.iov_base = (void *)data_16_2_1,
@@ -960,6 +975,22 @@ static const struct iso_client_data reconnect_ac_6ii = {
 	.disconnect = true,
 };
 
+static const struct iso_client_data connect_ac_6ii_cis_ef_auto = {
+	.qos = AC_6ii_1_EF,
+	.qos_2 = AC_6ii_2,
+	.expect_err = 0,
+	.mconn = true,
+	.defer = true,
+};
+
+static const struct iso_client_data connect_ac_6ii_cis_ef_ef = {
+	.qos = AC_6ii_1_EF,
+	.qos_2 = AC_6ii_1_EF,
+	.expect_err = -EINVAL,
+	.mconn = true,
+	.defer = true,
+};
+
 static const struct iso_client_data connect_ac_7i = {
 	.qos = AC_7i_1,
 	.qos_2 = AC_7i_2,
@@ -2371,6 +2402,29 @@ static void test_connect2_seq(const void *test_data)
 	setup_connect(data, 0, iso_connect2_seq_cb);
 }
 
+static void test_connect2_nodefer(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk, err;
+
+	/* Second connect() shall fail, because CIG is then busy,
+	 * but the first connect() shall succeed.
+	 */
+	setup_connect(data, 0, iso_connect_cb);
+
+	sk = create_iso_sock(data);
+	if (sk < 0) {
+		tester_test_failed();
+		return;
+	}
+
+	err = connect_iso_sock(data, 1, sk);
+	if (err != -EINVAL)
+		tester_test_failed();
+
+	close(sk);
+}
+
 static void test_bcast(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2518,6 +2572,12 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
+	test_iso("ISO QoS CIG 0xF0 - Invalid", &connect_cig_f0_invalid,
+			setup_powered, test_connect);
+
+	test_iso("ISO QoS CIS 0xF0 - Invalid", &connect_cis_f0_invalid,
+			setup_powered, test_connect);
+
 	test_iso_rej("ISO Connect - Reject", &connect_reject, setup_powered,
 			test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 
@@ -2545,6 +2605,10 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect2);
 
+	test_iso2("ISO Connect2 CIG 0x01 - Success/Invalid", &connect_1_16_2_1,
+							setup_powered,
+							test_connect2_nodefer);
+
 	test_iso("ISO Defer Send - Success", &connect_16_2_1_defer_send,
 							setup_powered,
 							test_connect);
@@ -2630,6 +2694,14 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_reconnect);
 
+	test_iso2("ISO AC 6(ii) CIS 0xEF/auto - Success",
+						&connect_ac_6ii_cis_ef_auto,
+						setup_powered, test_connect);
+
+	test_iso2("ISO AC 6(ii) CIS 0xEF/0xEF - Invalid",
+						&connect_ac_6ii_cis_ef_ef,
+						setup_powered, test_connect);
+
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
 	test_iso("ISO Broadcaster Encrypted - Success", &bcast_enc_16_2_1_send,
-- 
2.41.0

