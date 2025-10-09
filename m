Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B025C81F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039938; cv=none; b=K0Eb7c648GXAjNYOAJiFbQmqMLVaofCleVVYq5dHS0x4uBqaL9YfYXwBK921WRNeFAKOqg4Zqo2KI1l5Ex48XdssGfPkCc6MxCXhgF9Hyt1uvFyTHnOE7iRkLBe0F5duwtxKoj811SCQfbm4ng9GkLG+ZuGVODDNiXOl+RvS8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039938; c=relaxed/simple;
	bh=snjuo5o4owg7km7scPjTQQ6hKf0wSkaPva2F/BXCGGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayUGXgzC5+7B1ZZLCh+4+UJB24/uhEaFaucAlERDqzvwAWEA273r57GYKCJxKJv2Wgta18U53zS0kfknZcjVldf4Mn35ux8cpw4TUbHxMXHApggjBSS3/+YJJyVmY2DXxXEiuOu747POT/BzU9jUrFYkRBg4PR5bLPrF60wGEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cftdoFgK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cftdoFgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760039929;
	bh=snjuo5o4owg7km7scPjTQQ6hKf0wSkaPva2F/BXCGGg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cftdoFgKqu92bn76o5SRrCifUd59R2OQfJdU9uPKtJ+zcWHDMePOtHy6XDtDMVLin
	 ftYXKZl28bDsa4JJ1io9n/gEtF653REVIyCb7S4zsXe/eVg18nXQSroQwEUuEuvI0C
	 joLKMvpIJbe2OKi3fAYEOCGiYpt1uyNfb/RgB7jhhYX1kGnIq2wI3lqAT0wQ3K0L0q
	 auAy8iXLn/LRJNYjKxGAcnWh9BkCohUF7iVgBcOsE++55j5a8Ab3RK3v3iRtdpgl0I
	 adFdGw+8UYU9n28BBDlTLdhBuUUXYU5R5kVhqind0v1HLEozHaOZl+Cx2T3z1wyUS5
	 JaRHBp4hi31aQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-aB6e-1eE8-0e0E-15d0.rev.sfr.net [IPv6:2a02:8428:af44:1001:ab6e:1ee8:e0e:15d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E6B417E12EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:58:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/6] unit/test-hfp: Add Answer Incoming Call with In-Band Ring tests for HF
Date: Thu,  9 Oct 2025 21:58:40 +0200
Message-ID: <20251009195842.776231-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009195842.776231-1-frederic.danis@collabora.com>
References: <20251009195842.776231-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following tests:
- /HFP/HF/ICA/BV-01-C
  Verify the incoming call is answered from HF, in-band ring tone.
- /HFP/HF/ICA/BV-02-C
  Verify that the AG can change its in-band ring tone setting.
- /HFP/HF/ICA/BV-03-C
  Verify that the HF alerts of an incoming call using the local ring
  signal regardless of the presence of the in-band ring tone.
- /HFP/HF/ICA/BV-04-C-full
  duplicate of /HFP/HF/ICA/BV-04-C test with full SLC setup.

/HFP/HF/ICA/BV-05-C (Verify that the HF alerts an incoming call using
a locally generated alert signal and can answer an incoming call in
the AG when the AG does not use an in-band ring tone as an alert
mechanism for the HF and the IUT allows an Audio Connection to be
present) is similar to /HFP/HF/TCA/BV-02-C/HFP/HF/ICA/BV-04-C-full for
the HF side.
---
 unit/test-hfp.c | 190 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 8afb15fa3..7667c525c 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -733,6 +733,37 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
+#define FULL_SLC_SESSION(service, call, callsetup, callheld) \
+	raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
+		' ', '1', '6', '3', '8', '3', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' ', \
+		'(', '\"', 's', 'e', 'r', 'v', 'i', 'c', 'e', '\"', ',', \
+		'(', '0', ',', '1', ')', ')', ',', \
+		'(', '\"', 'c', 'a', 'l', 'l', '\"', ',', '(', '0', ',', \
+		'1', ')', ')', ',', \
+		'(', '\"', 'c', 'a', 'l', 'l', 's', 'e', 't', 'u', 'p', \
+		'\"', ',', '(', '0', '-', '3', ')', ')', ',', \
+		'(', '\"', 'c', 'a', 'l', 'l', 'h', 'e', 'l', 'd', '\"', \
+		',', '(', '0', '-', '2', ')', ')', ',', \
+		'(', '\"', 's', 'i', 'g', 'n', 'a', 'l', '\"', ',', '(', \
+		'0', '-', '5', ')', ')', ',', \
+		'(', '\"', 'r', 'o', 'a', 'm', '\"', ',', '(', '0', ',', \
+		'1', ')', ')', ',', \
+		'(', '\"', 'b', 'a', 't', 't', 'c', 'h', 'g', '\"', ',', \
+		'(', '0', '-', '5', ')', ')', ',', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' ', service, ',', \
+		call, ',', callsetup, ',', callheld, ',', '5', ',', '0', \
+		',', '5', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' ', '0', ',', \
+		'0', ',', '\"', 'T', 'E', 'S', 'T', '\"', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
+
 static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -856,6 +887,25 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	}
 }
 
+static void hf_update_inband_ring(bool enabled, void *user_data)
+{
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
+	if (tester_use_debug())
+		tester_debug("in-band ring updated: %u", enabled);
+
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C"))
+		g_assert_cmpint(enabled, ==, true);
+	else if (g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full"))
+		g_assert_cmpint(enabled, ==, !!context->session.step);
+	else if (g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C")) {
+		g_assert_cmpint(enabled, ==, !!context->session.step);
+		context->session.step++;
+	}
+}
+
 static void hf_update_operator(const char *operator_name, void *user_data)
 {
 	struct context *context = user_data;
@@ -878,7 +928,11 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 		tester_debug("call %d added: status %u", id, status);
 
 	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
@@ -937,7 +991,11 @@ static void hf_call_line_id_updated(uint id, const char *number,
 	str = hfp_hf_call_get_number(context->hfp_hf, id);
 	g_assert_cmpstr(number, ==, str);
 
-	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		bool ret;
@@ -974,7 +1032,10 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 	if (tester_use_debug())
 		tester_debug("call %d updated: status %u", id, status);
 
-	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		const char *number;
@@ -983,6 +1044,25 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
 		number = hfp_hf_call_get_number(context->hfp_hf, id);
 		g_assert_cmpstr(number, ==, "1234567");
+	} else if (g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C")) {
+		const char *number;
+		bool ret;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, "1234567");
+
+		context->session.step++;
+
+		if (context->session.step == 1) {
+			if (tester_use_debug())
+				tester_debug("call %d: ending call", id);
+			ret = hfp_hf_call_hangup(context->hfp_hf, id,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+		}
 	} else if (g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C")) {
 		if (tester_use_debug())
 			tester_debug("Error: unexpected update");
@@ -1041,6 +1121,7 @@ static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hf_session_ready_cb,
 	.update_indicator = hf_update_indicator,
 	.update_operator = hf_update_operator,
+	.update_inband_ring = hf_update_inband_ring,
 	.call_added = hf_call_added,
 	.call_removed = hf_call_removed,
 	.call_status_updated = hf_call_status_updated,
@@ -1264,6 +1345,87 @@ int main(int argc, char *argv[])
 				',', '1', '2', '9', ',', ',', '\r', '\n'),
 			data_end());
 
+	/* Incoming call, in-band ring - HF */
+	define_hf_test("/HFP/HF/ICA/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Answer incoming call and accept in-band setting change - HF */
+	define_hf_test("/HFP/HF/ICA/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Answer incoming call on HF with ring muting - HF */
+	define_hf_test("/HFP/HF/ICA/BV-03-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Answer Incoming call on HF, no in-band ring - HF */
 	define_hf_test("/HFP/HF/ICA/BV-04-C", test_hf_session,
 			NULL, test_hf_session_done,
@@ -1283,6 +1445,30 @@ int main(int argc, char *argv[])
 				'2', ',', '0', '\r', '\n'),
 			data_end());
 
+	/* Answer Incoming call on HF, no in-band ring, full SLC setup - HF
+	 * idem for /HFP/HF/ICA/BV-05-C Audio Connection + answer incoming
+	 * call from HF with locally generated alert
+	 */
+	define_hf_test("/HFP/HF/ICA/BV-04-C-full", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'B', 'S', 'I', 'R', ':', ' ',
+				'0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Answer Incoming call on AG, no in-band ring - HF */
 	define_hf_test("/HFP/HF/ICA/BV-06-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

