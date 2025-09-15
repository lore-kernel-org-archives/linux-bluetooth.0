Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338E21146C
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954077; cv=none; b=VObjzuKA7SAknL7DyWE6PlECJXl1UQ2vqpkSG5laJC1POnDuZy9r3YYAKaWgzoWim7mcdgow+O17A+XI1h4hoJ1vpC80P+CKB5652bd9iMRNwNBRq59woL/EB1qs+0yQw+4/ZmIRNKs+nbvhUlebCyXK5j5dkKK74RBn4UfzUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954077; c=relaxed/simple;
	bh=4EYzCh6F6jeAAFWK0pPCdpzlBYD16RlU5lB1Bk41ioQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2c4VbxwZgysnkOfB7gusG3IXHOWG1gDoqCRMo5PHRVzWJc930TdSMHn8soYPWqCojltACw1A2BheAcDj2w6Q+h8YsLzXgR/0yz3CKKp6WH8Mu97l8nP/kmHoGt57bAT2eeAjs0q1UGnyBcqwktJFW/e7FCGTkoLLHrpnsTr1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=akZhDI0r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="akZhDI0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757954073;
	bh=4EYzCh6F6jeAAFWK0pPCdpzlBYD16RlU5lB1Bk41ioQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=akZhDI0rEXZWK+a18OWjNsJubsPbCuRgHdMO/g7ozz4kHzZ0rbtEfZbOagfrLVtxz
	 Nq0eZ/YZ8wzPVDBYd63Gv5+JJDxe05MTDsYI94ULCSyQu42qQYmPpyA2VVZ2+LA3Yh
	 5XM2C0z6WB47QOWVHgQVBU5liV+CbuhvoAf3K9WNQt5YGJ+XzXybUzDSUpL25/zB/v
	 QgO394bivxHRoa0qQN+D8XThZUHMxBciN4ee2ga0G9HrgHS82VCdqp8EpmR3QDVcdX
	 COFPG8wn31JKafTTJVb2Wbmh43UOeQkSA63VKsxyuZa/eoZwNMRDMoW0+1HbDGkDR0
	 +9QL5PA8ZTbQw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-ed13-78a5-a1e8-7185.rev.sfr.net [IPv6:2a02:8428:af44:1001:ed13:78a5:a1e8:7185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5EADD17E1067
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:34:33 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] unit/test-hfp: Add Operator name test for HF
Date: Mon, 15 Sep 2025 18:34:25 +0200
Message-ID: <20250915163427.3589748-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915163427.3589748-1-frederic.danis@collabora.com>
References: <20250915163427.3589748-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- HFP/HF/PSI/BV-04-C
  Verify that the HF can query the currently selected operator name.

Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
callsetup and callheld indicators at connection time.
---
v1->v2 : Move some changes to patch 1 to fix unit/test-hfp in this patch

 unit/test-hfp.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 2a85ec575..8ab6c7bf5 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -699,7 +699,7 @@ static void test_hf_robustness(gconstpointer data)
 	context_quit(context);
 }
 
-#define MINIMAL_SLC_SESSION \
+#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
 	raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
 		' ', '0', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
@@ -722,8 +722,8 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
-	frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
-	frg_pdu(',', '0', ',', '5', '\r', '\n'), \
+	frg_pdu(service, ',', call, ',', callsetup, ',', callheld, ','), \
+	frg_pdu('5', ',', '0', ',', '5', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
@@ -750,7 +750,13 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	if (!context->session.completed) {
 		switch (indicator) {
 		case HFP_INDICATOR_SERVICE:
-			g_assert_cmpint(val, ==, 0);
+			if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-C") ||
+				g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C") ||
+				g_str_equal(test_name,
+						"/hfp_hf/test_session_minimal"))
+				g_assert_cmpint(val, ==, 0);
+			else
+				g_assert_cmpint(val, ==, 1);
 			break;
 		case HFP_INDICATOR_CALL:
 			g_assert_cmpint(val, ==, 0);
@@ -794,9 +800,22 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	}
 }
 
+static void hf_update_operator(const char *operator_name, void *user_data)
+{
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
+	if (tester_use_debug())
+		tester_debug("operator updated: %s", operator_name);
+
+	if (g_str_equal(test_name, "/HFP/HF/PSI/BV-04-C"))
+		g_assert_cmpstr(operator_name, ==, "TEST");
+}
+
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hf_session_ready_cb,
 	.update_indicator = hf_update_indicator,
+	.update_operator = hf_update_operator,
 };
 
 static void test_hf_session_done(enum hfp_result res, enum hfp_error cme_err,
@@ -1001,13 +1020,13 @@ int main(int argc, char *argv[])
 
 	define_hf_test("/hfp_hf/test_session_minimal", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('0', '0', '0', '0'),
 			data_end());
 
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
 			frg_pdu(' ', '5', ',', '3', '\r', '\n'),
 			data_end());
@@ -1015,7 +1034,7 @@ int main(int argc, char *argv[])
 	/* Transfer Roaming Status Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
 			frg_pdu(' ', '6', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
@@ -1025,15 +1044,21 @@ int main(int argc, char *argv[])
 	/* Transfer Battery Level Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-03-C", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('0', '0', '0', '0'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
 			frg_pdu(' ', '7', ',', '3', '\r', '\n'),
 			data_end());
 
+	/* Transfer Operator name - HF */
+	define_hf_test("/HFP/HF/PSI/BV-04-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			data_end());
+
 	/* Transfer Registration Status - HF */
 	define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('0', '0', '0', '0'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
 			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
-- 
2.43.0

