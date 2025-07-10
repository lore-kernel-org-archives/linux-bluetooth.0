Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C72F1FC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167927; cv=none; b=GbkqLsdTd/4+eyKesnlXZjx4xe7dHzMPyL4Nyb/WIwZ0XvX+Fcxf0YquCKQOtM8zlHIWbeEpjajBjwt49wypshBORV9hlVXz5NAaFTstLq453g0BY+Xxv9gmESMvDzLaqkkuqLADrmBsX6ao8DbE7SpT5ErUUsnj1R35uRnZyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167927; c=relaxed/simple;
	bh=a4ExgorHGfSSDA3Mjaq1Y1tJR2yvJhZNpn44jpgaAwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY077DgECkbLdTxT1jNLhyO2e8zzUhixmRrW1miCcAWaXgh/6Av75D86MFeGU9qUMH8JVFnHhc6IPsQp9R8qtYgaRnsmQi1cufYzoDppJqHqRJMDsQFn2WzvdHrjoZio3GXwbOWBC/GTIR217D3y0N7WHK9Wup7SweTVst3STxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ryf+0d1x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ryf+0d1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752167923;
	bh=a4ExgorHGfSSDA3Mjaq1Y1tJR2yvJhZNpn44jpgaAwk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ryf+0d1xsD35MSMXqREhCsiur6XWe7++drJuNKzmaj+ctC+xgta899+pkSU7hFT2D
	 p5NcGIvX7o8rxuBM0HWEN3rOlOicRHhNRZ4a6GT9WlNelBMzSM6miHTXRIJ+fTqYQV
	 +cR5uBJuwiGRRG3sZiaqcdi5Ivcgw8qdoFZxv7IfLnob7F3ARNFrQnCHITX462TK4m
	 ItDkUSqIPvjtUticokAZwfUx5pFDDVCJqeTPMktZWroB5w9BtAD6020vQt3j2inPeb
	 QDTmeADedari/204Ah3ylXZ8g5ViS5v21PtnGDI9Kcjx/TVclWFIRoGm6nA1PK7tWT
	 35FrXhd3G6/cg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-9be2-7429-4d2E-B935.rev.sfr.net [IPv6:2a02:8428:af44:1001:9be2:7429:4d2e:b935])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B4C6E17E1090
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 19:18:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] unit/test-hfp: Add indicators tests for HF
Date: Thu, 10 Jul 2025 19:18:38 +0200
Message-ID: <20250710171838.949803-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710171838.949803-1-frederic.danis@collabora.com>
References: <20250710171838.949803-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This adds the following tests:
- /HFP/HF/TRS/BV-01-C
  Verify that  the HF accepts the registration status indication.
- /HFP/HF/PSI/BV-01-C
  Verify that the HF successfully receives the signal strength status of
  the AG.
- /HFP/HF/PSI/BV-02-C
  Verify that the HF successfully receives the roaming status of the AG.
- /HFP/HF/PSI/BV-03-C
  Verify that the HF successfully receives the battery level status of
  the AG.
---
 unit/test-hfp.c | 131 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 26 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 2ea77e210..9be1b05ae 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -19,6 +19,11 @@
 #include "src/shared/tester.h"
 #include "src/shared/util.h"
 
+struct session {
+	bool completed;
+	guint step;
+};
+
 struct context {
 	guint watch_id;
 	int fd_server;
@@ -27,6 +32,7 @@ struct context {
 	struct hfp_hf *hfp_hf;
 	const struct test_data *data;
 	unsigned int pdu_offset;
+	struct session session;
 };
 
 struct test_pdu {
@@ -720,40 +726,75 @@ static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
 	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
 
 	g_assert_cmpint(res, ==, HFP_RESULT_OK);
+	context->session.completed = true;
 
-	context->data->response_func(res, cme_err, context);
+	if (g_str_equal(test_name, "/hfp_hf/test_session_minimal"))
+		context->data->response_func(res, cme_err, context);
 }
 
 static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 							void *user_data)
 {
-	switch (indicator) {
-	case HFP_INDICATOR_SERVICE:
-		g_assert_cmpint(val, ==, 1);
-		break;
-	case HFP_INDICATOR_CALL:
-		g_assert_cmpint(val, ==, 0);
-		break;
-	case HFP_INDICATOR_CALLSETUP:
-		g_assert_cmpint(val, ==, 0);
-		break;
-	case HFP_INDICATOR_CALLHELD:
-		g_assert_cmpint(val, ==, 0);
-		break;
-	case HFP_INDICATOR_SIGNAL:
-		g_assert_cmpint(val, ==, 5);
-		break;
-	case HFP_INDICATOR_ROAM:
-		g_assert_cmpint(val, ==, 0);
-		break;
-	case HFP_INDICATOR_BATTCHG:
-		g_assert_cmpint(val, ==, 5);
-		break;
-	case HFP_INDICATOR_LAST:
-	default:
-		tester_test_failed();
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
+	if (!context->session.completed) {
+		switch (indicator) {
+		case HFP_INDICATOR_SERVICE:
+			g_assert_cmpint(val, ==, 0);
+			break;
+		case HFP_INDICATOR_CALL:
+			g_assert_cmpint(val, ==, 0);
+			break;
+		case HFP_INDICATOR_CALLSETUP:
+			g_assert_cmpint(val, ==, 0);
+			break;
+		case HFP_INDICATOR_CALLHELD:
+			g_assert_cmpint(val, ==, 0);
+			break;
+		case HFP_INDICATOR_SIGNAL:
+			g_assert_cmpint(val, ==, 5);
+			break;
+		case HFP_INDICATOR_ROAM:
+			g_assert_cmpint(val, ==, 0);
+			break;
+		case HFP_INDICATOR_BATTCHG:
+			g_assert_cmpint(val, ==, 5);
+			break;
+		case HFP_INDICATOR_LAST:
+		default:
+			tester_test_failed();
+		}
+		return;
+	}
+
+	if (g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C")) {
+		context->session.step++;
+		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SERVICE);
+		g_assert_cmpint(val, ==, context->session.step % 2);
+
+		if (context->session.step == 3)
+			context->data->response_func(HFP_RESULT_OK, 0,
+								context);
+	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-01-C")) {
+		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SIGNAL);
+		g_assert_cmpint(val, ==, 3);
+		context->data->response_func(HFP_RESULT_OK, 0, context);
+	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-02-C")) {
+		context->session.step++;
+		g_assert_cmpint(indicator, ==, HFP_INDICATOR_ROAM);
+		g_assert_cmpint(val, ==, context->session.step % 2);
+
+		if (context->session.step == 2)
+			context->data->response_func(HFP_RESULT_OK, 0,
+								context);
+	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-C")) {
+		g_assert_cmpint(indicator, ==, HFP_INDICATOR_BATTCHG);
+		g_assert_cmpint(val, ==, 3);
+		context->data->response_func(HFP_RESULT_OK, 0, context);
 	}
 }
 
@@ -967,5 +1008,43 @@ int main(int argc, char *argv[])
 			MINIMAL_SLC_SESSION,
 			data_end());
 
+	/* Transfer Registration Status - HF */
+	define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION,
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '1', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
+			data_end());
+
+	/* Transfer Signal Strength Indication - HF */
+	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION,
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '5', ',', '3', '\r', '\n'),
+			data_end());
+
+	/* Transfer Roaming Status Indication - HF */
+	define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION,
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '6', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '6', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Transfer Battery Level Indication - HF */
+	define_hf_test("/HFP/HF/PSI/BV-03-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION,
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
+			frg_pdu(' ', '7', ',', '3', '\r', '\n'),
+			data_end());
+
 	return tester_run();
 }
-- 
2.43.0

