Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7E2ECD2B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270252; cv=none; b=AEHc8oFCYuPewQx2YaEqF1wZzyOvCl9xl41Ne3nm8Vk6gl2oLohtCLBOLfi3p4Fjy1DbxPXSpPBVzvQlPbogR0n6EbC0p0reR84WwtJ/78LoVyN1XJAy/iDxLG75LPLZ7c+K39zdgwSDeDAWU7VnaYD3RFRZXJSV54KyKAcEa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270252; c=relaxed/simple;
	bh=dIJSr7wPkygpuV2ZSUbFKZdt4yUlX1byEZP0cMO+DDY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luaIOolP8kQ7feOQsAxIPk03C/Oq2Lu64l4ai2QEQQPZvcKD7Jpn/6d8e41jvv+VzJe+br+Y961fMcERZnUWe/NO82i8cMTjNLbObtrtyquUzfzKxlyPv0jYbS3RfoWr91WkpCP4Y81gtW3yh8h+UVl1JtsaA6wDCEFJxBXaE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A26p32Zo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A26p32Zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758270248;
	bh=dIJSr7wPkygpuV2ZSUbFKZdt4yUlX1byEZP0cMO+DDY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A26p32Zo4ILbM4JXYybyUzDIXLIdo6djNGyBD2ozhpIRj1RL3l3RXNvme5oBR95JR
	 1+e6T9WBLwZM0x8aTrx0s4/GbiOKZDtFqRiIL1/vaerI96K31onHXaMIi4jKUwTOx1
	 KsIsL7MppwhfveCgVz0Ksxq1QTt+3WPRpycTzX5ISbhxaDudvHO4GK3Gjnh4P/xDjQ
	 PrRuwZEZSt5AqEWD6qOs82t0AApTOzRTnKN9SHjvhGsJDM1MxNc9o+rDEjuIo0pA9J
	 uRad2gjsb1ACfTgggA7E6tZypBH2ENCxKW02Ug6sQwOWuIJP7+t5lyP23WoJ5D3IpP
	 bscQZJXEb0yZw==
Received: from fdanis-ThinkPad-X1.. (unknown [IPv6:2a02:8428:af44:1001:17f0:5da3:acf8:a3c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A5B4617E05BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:24:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] unit/test-hfp: Add Answer Incoming Call tests for HF
Date: Fri, 19 Sep 2025 10:23:31 +0200
Message-ID: <20250919082334.1443310-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919082334.1443310-1-frederic.danis@collabora.com>
References: <20250919082334.1443310-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following tests:
- HFP/HF/ICA/BV-04-C
  Verify the incoming call is answered from HF, no in-band ring.
- HFP/HF/ICA/BV-06-C
  Verify the incoming call is answered from AG, no in-band ring.
---
 unit/test-hfp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 060230196..adbcfd2fc 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -733,6 +733,12 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
+static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	g_assert_cmpint(res, ==, HFP_RESULT_OK);
+}
+
 static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -822,7 +828,9 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 	if (tester_use_debug())
 		tester_debug("call %d added: status %u", id, status);
 
-	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C")) {
+	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C")) {
 		g_assert_cmpint(id, ==, 1);
 		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
 	}
@@ -833,6 +841,7 @@ static void hf_call_line_id_updated(uint id, const char *number,
 							void *user_data)
 {
 	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
 	const char *str;
 
 	if (tester_use_debug())
@@ -843,6 +852,43 @@ static void hf_call_line_id_updated(uint id, const char *number,
 	g_assert_cmpint(type, ==, 129);
 	str = hfp_hf_call_get_number(context->hfp_hf, id);
 	g_assert_cmpstr(number, ==, str);
+
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("call %d: answering call", id);
+		ret = hfp_hf_call_answer(context->hfp_hf, id, hf_cmd_complete,
+								context);
+		g_assert(ret);
+	}
+}
+
+static void hf_call_removed(uint id, void *user_data)
+{
+	if (tester_use_debug())
+		tester_debug("call %d removed", id);
+	g_assert_cmpint(id, ==, 1);
+}
+
+static void hf_call_status_updated(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
+	if (tester_use_debug())
+		tester_debug("call %d updated: status %u", id, status);
+
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, "1234567");
+	}
 }
 
 static struct hfp_hf_callbacks hf_session_callbacks = {
@@ -850,6 +896,8 @@ static struct hfp_hf_callbacks hf_session_callbacks = {
 	.update_indicator = hf_update_indicator,
 	.update_operator = hf_update_operator,
 	.call_added = hf_call_added,
+	.call_removed = hf_call_removed,
+	.call_status_updated = hf_call_status_updated,
 	.call_line_id_updated = hf_call_line_id_updated,
 };
 
@@ -1070,6 +1118,47 @@ int main(int argc, char *argv[])
 				',', '1', '2', '9', ',', ',', '\r', '\n'),
 			data_end());
 
+	/* Answer Incoming call on HF, no in-band ring - HF */
+	define_hf_test("/HFP/HF/ICA/BV-04-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
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
+	/* Answer Incoming call on AG, no in-band ring - HF */
+	define_hf_test("/HFP/HF/ICA/BV-06-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

