Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D8C001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHAQiz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjHAQiu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 12:38:50 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521391FFD
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 09:38:48 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RFgm65yGkz49QCy;
        Tue,  1 Aug 2023 19:38:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5f3Az5ebVbCj29lMqMtIGN2PGzN3+1Ael6CcI4sAPvI=;
        b=KUsxc1dPYCXl+d9iOGmp0L+3/mh43DeL6+xDgw9tYgFja1m1TCeiJzIog2hoZ61n0m82S0
        ycAUinRCjxNglgE1zjXUrRmV0h6Plps5V+t+4TbAwVwp0rj0KdQvxCJibFnTOREGCwjAej
        AVZlr3zI6rbjGYDexMDv9wNMojrE+G4VrUOVvCmZSvM9SjNd47oDOBqK+dmar7Pobmgoyp
        RCsQdrNeR1sKLJ1XTfgrt6KN6eGxaR7DF6icH4FXt52YsdyenrUhXwL0vK8MnKpEduPQzR
        1rWKN2F+qRL2zTJjXzDWvipVYJGipFcOkndv/Kcz84v+QAaO9aG33R4A7naw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5f3Az5ebVbCj29lMqMtIGN2PGzN3+1Ael6CcI4sAPvI=;
        b=L8kFlcgDN5UAkI/MCyiPW+ubeVF1bmK34EuOZPsUFBdvcMUQZN8paXVeA0CvmhecduoJXT
        ewuythBMD489hCQee75pzgSwC/Tnxw0b7jDuZtEpa4U565Zw92XO9J7/L+lEqgEhWAuU1q
        IxPWlxl3tgg/a4Km1Ipc+HjSe124Q2OofqtIUbywEmKM4BQNyk9RQWvjaE8KMdYi3FxxVp
        45ZiBshd2KN23WY/TCtAgWeP3w2e6uzc0u+nawqhcPGFiRTtnsRbF67O6/NaGl2w95ba7V
        /m9nrhrjIT8h76I1XGy4VBPtwLV6GQehrKLeEGInos+QkoSUBinS9Zjv3Y2EYw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690907926; a=rsa-sha256;
        cv=none;
        b=hTK3kzkLXLfHiuHJXTq7Lk7bzrGMAvfDXmESG7VPj+E7ke6M+5SM9kPzUHXzlDywwvohTR
        uqzH7aC+HLO1fm0GmqZ3ypCUkzBR+BFiQuzuAtJYJGoPMvK9hhQxJ5GOISc7LAuCHDx9sD
        AgB4t+GB8Zncw1EGu1IfSqeeWx1llK5Ilai0lM4R2SYPndq4SyqL0lykKCLZy1bVaNkt7r
        JSClrKGBhONipR2TG8pFQi99RZxeb1JdXhhn6IjZuWyF7ODAqhx2O1uUGWI2J37Q6iPeL7
        T3tT+Ul3Cy6eDbxRf2YSZNdGjGbCCniTAcKBjOHogubJ7IPUSgRo1v3pnqDgFw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/5] iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID
Date:   Tue,  1 Aug 2023 19:38:41 +0300
Message-ID: <4126dc74da175954db56a40d4fa9cf47448c4e6c.1690907478.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690907478.git.pav@iki.fi>
References: <cover.1690907478.git.pav@iki.fi>
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
    v2: no change
    
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

