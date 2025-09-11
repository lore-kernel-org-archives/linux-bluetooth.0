Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E2320CC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586646; cv=none; b=dE/CtR+GmPxSR2p1mP6Mksaoa5P4gVus2mREmM5eeYjHlj+wNwEpUFnFZaekURcWbuZxqdJh5FT43JS1WWryCM41jZOKHg0NudDBjshVnsomg3Tyk4yn116upUv3/wJuDA4jxBLULV7GLj4zBmszPsM7enjowj9IvuCwL6pJdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586646; c=relaxed/simple;
	bh=jX5y4QRJubQoLt92GRz67nJ8Kqmm4GLUii6jvpQT/Tc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLAcFwQ5XoT85plAMK4aY/ZXmPq577CTUHUdaHOttaefZ6+mdy88mGhV9LUCYu/KzFlquPehB+VG1NsShUwWxdJTxuO9ghONCbAEy0ygO+BA4YKUPnaj9PP1v87GLtG9eC3VZn46PvUDUbz8v+KA07T0h2geLFShEYXfe7TC8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TzVIw5Mh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TzVIw5Mh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757586642;
	bh=jX5y4QRJubQoLt92GRz67nJ8Kqmm4GLUii6jvpQT/Tc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TzVIw5Mh1VXYV4NUCTBuIxnvCgIcG0G9clXNvvKWNEE/QvWQvE8jnhH/vIdWz1kyB
	 KXve1t93LbOCM+3WemaVfwlNBRRQ9JYsH8vl4QWwsliqttcuBi7DUmvfh7cDQpvRVx
	 Qcld1XPS5e0GFeRhi0wQ6/FZYBwnbJS7Uxd9Kgtq09SxzHMtWdx8pVQxDrKGZ+kTAB
	 DVtE56suKtmqZR0C11BclqXwD92PbbCOww9Zx8vliyWqlHtFwy1iUpzd4dJ3bXhke9
	 X8VgvN/qNz/sk+TRSkDxRlqjDgkl/qtzTj95R0gNYaYYQdIOIpsze/Xpoks5c0pbih
	 QTZcdH2Wd2yrQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-E0e2-6802-CeeF-9413.rev.sfr.net [IPv6:2a02:8428:af44:1001:e0e2:6802:ceef:9413])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A17B17E04D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:30:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] unit/test-hfp: Add Operator name test for HF
Date: Thu, 11 Sep 2025 12:28:38 +0200
Message-ID: <20250911102840.2090361-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911102840.2090361-1-frederic.danis@collabora.com>
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
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
 unit/test-hfp.c | 50 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 371415a68..8ab6c7bf5 100644
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
@@ -722,10 +722,15 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
-	frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
-	frg_pdu(',', '0', ',', '5', '\r', '\n'), \
+	frg_pdu(service, ',', call, ',', callsetup, ',', callheld, ','), \
+	frg_pdu('5', ',', '0', ',', '5', '\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
-	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
+	frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
+	frg_pdu('\"', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
@@ -745,7 +750,13 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
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
@@ -789,9 +800,22 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
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
@@ -996,13 +1020,13 @@ int main(int argc, char *argv[])
 
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
@@ -1010,7 +1034,7 @@ int main(int argc, char *argv[])
 	/* Transfer Roaming Status Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
 			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
 			frg_pdu(' ', '6', ',', '1', '\r', '\n'),
 			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
@@ -1020,15 +1044,21 @@ int main(int argc, char *argv[])
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

