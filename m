Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4D29E101
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936328; cv=none; b=D/1lwHJSvd5/cWgVVG1QyXyHUI2QxPzqDq1Vi2XJUVHWBc++nPEz7XurQENNd1JQhJzuqZYFKcRJiCbAoUWKpD+MDvTSUWX0wdcAQueK63PsDjdzLutwxYy9JxXthz2yfuWsReR+4jBGMh+OP93lvUP7ceVcNHy75roSpjvMoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936328; c=relaxed/simple;
	bh=BdbfgdWl/6BTc+akBOb42ngOnQJZYvxRjIbsvlKeDAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oj1bapsxW1RI1DH9sluEyPGZoeotbfpF+6GzHJi6xSTHgOfqMkPFS8y7AAGVPJGi0P5Wwwe6ag8RDHJxQ7GN9qpuTJa5oMW45uNj5iFByfNTKJoumbNJo5QNnaBDRHJPZqpzHXzJHb2xejIZdJOj1LhyZVo9ZcStxHAgXseMfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HyytPyj1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HyytPyj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762936318;
	bh=BdbfgdWl/6BTc+akBOb42ngOnQJZYvxRjIbsvlKeDAE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HyytPyj1Se8meH1+JLEzE7nLLAr/Z/1SQghejC2SV3GKbtuQWxBkdOHrvpGvjls87
	 5MSx36gtWyVinPpJUDXC583aSJ9KL41JYIIaUfwPM5flsUDbQwo5ED8tqSE5M37uRx
	 ZKdoKxtxLUF6b1QL69H3vqZ1skqV0c51B9IB5jZKjxNodHHYo59xrkeD6SDtGbzI7P
	 IYGu4+2PK4HaKK5KUN3XcfluXzsTL8SE4+cmiX41HxizYSJqt7qgoHYE2b3TLx9FC7
	 FtCxGIqCd5C95/LwpnFA4Q7OjJS4a9ESI+KLTIKTccvZSLO54bxFCmK5/p7p4W3y38
	 qGhH3or/tWI/Q==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-094F-3df2-fbF5-546C.rev.sfr.net [IPv6:2a02:8428:af44:1001:94f:3df2:fbf5:546c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EE5F17E1389
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:31:58 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] unit/test-hfp: Add tests for simple 3way support
Date: Wed, 12 Nov 2025 09:31:50 +0100
Message-ID: <20251112083150.54641-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112083150.54641-1-frederic.danis@collabora.com>
References: <20251112083150.54641-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following tests:
- /HFP/HF/TWC/BV-01-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting and that the HF sends the User Determined User Busy
  (UDUB) indication to the AG (AT+CHLD=0).
- /HFP/HF/TWC/BV-02-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can end an active call and accept the other
  (held or waiting) call (AT+CHLD=1).
- /HFP/HF/TWC/BV-03-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can place an active call on hold and accept
  a call waiting (AT+CHLD=2).
---
 unit/test-hfp.c | 402 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 401 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 5252ed316..d6c8cc617 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -996,6 +996,95 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 		ret = hfp_hf_call_hangup(context->hfp_hf, id, hf_cmd_complete,
 							context);
 		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-01-C")) {
+		bool ret;
+
+		switch (context->session.step) {
+		case 0:
+			g_assert_cmpint(id, ==, 1);
+			g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+			if (tester_use_debug())
+				tester_debug("call %d: answering call", id);
+			ret = hfp_hf_call_answer(context->hfp_hf, id,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		case 1:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_HELD);
+			if (tester_use_debug())
+				tester_debug("call %d: ending held call", id);
+			ret = hfp_hf_call_hangup(context->hfp_hf, id,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-02-C")) {
+		bool ret;
+
+		switch (context->session.step) {
+		case 0:
+			g_assert_cmpint(id, ==, 1);
+			g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+			if (tester_use_debug())
+				tester_debug("call %d: answering call", id);
+			ret = hfp_hf_call_answer(context->hfp_hf, id,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		case 1:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_HELD);
+			if (tester_use_debug())
+				tester_debug("call %d: "
+						"release and answer calls",
+						id);
+			ret = hfp_hf_release_and_accept(context->hfp_hf,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-03-C")) {
+		bool ret;
+
+		switch (context->session.step) {
+		case 0:
+			g_assert_cmpint(id, ==, 1);
+			g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+			if (tester_use_debug())
+				tester_debug("call %d: answering call", id);
+			ret = hfp_hf_call_answer(context->hfp_hf, id,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		case 2:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_HELD);
+			if (tester_use_debug())
+				tester_debug("call %d: swap calls", id);
+			ret = hfp_hf_swap_calls(context->hfp_hf,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
 	}
 }
 
@@ -1041,9 +1130,52 @@ static void hf_call_line_id_updated(uint id, const char *number,
 
 static void hf_call_removed(uint id, void *user_data)
 {
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
 	if (tester_use_debug())
 		tester_debug("call %d removed", id);
-	g_assert_cmpint(id, ==, 1);
+	if (g_str_equal(test_name, "/HFP/HF/TWC/BV-01-C")) {
+		switch (context->session.step) {
+		case 2:
+			g_assert_cmpint(id, ==, 2);
+			break;
+		case 3:
+			g_assert_cmpint(id, ==, 1);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-02-C")) {
+		switch (context->session.step) {
+		case 2:
+			g_assert_cmpint(id, ==, 1);
+			break;
+		case 3:
+			g_assert_cmpint(id, ==, 2);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-03-C")) {
+		switch (context->session.step) {
+		case 8:
+			g_assert_cmpint(id, ==, 1);
+			break;
+		case 9:
+			g_assert_cmpint(id, ==, 2);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
+	} else
+		g_assert_cmpint(id, ==, 1);
 }
 
 static void hf_call_status_updated(uint id, enum hfp_call_status status,
@@ -1139,6 +1271,48 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		ret = hfp_hf_call_hangup(context->hfp_hf, id, hf_cmd_complete,
 							context);
 		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/TWC/BV-03-C")) {
+		bool ret;
+
+		switch (context->session.step) {
+		case 1:
+		case 5:
+			g_assert_cmpint(id, ==, 1);
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+			break;
+		case 3:
+			g_assert_cmpint(id, ==, 1);
+			g_assert_cmpint(status, ==, CALL_STATUS_HELD);
+			break;
+		case 4:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+			if (tester_use_debug())
+				tester_debug("call %d: swap calls", id);
+			ret = hfp_hf_swap_calls(context->hfp_hf,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		case 6:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_HELD);
+			if (tester_use_debug())
+				tester_debug("call %d: swap calls", id);
+			ret = hfp_hf_release_and_accept(context->hfp_hf,
+							hf_cmd_complete,
+							context);
+			g_assert(ret);
+			break;
+		case 7:
+			g_assert_cmpint(id, ==, 2);
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+			break;
+		default:
+			tester_debug("Unexpected session.step");
+			tester_test_failed();
+		}
+		context->session.step++;
 	}
 }
 
@@ -1882,5 +2056,231 @@ int main(int argc, char *argv[])
 			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
 			data_end());
 
+	/* Call waiting – handling user busy by HF (AT+CHLD=0) - HF */
+	define_hf_test("/HFP/HF/TWC/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', ',', '\"', 'b',
+				'l', 'u', 'e', 'm', 'a', 'n', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'C', 'W', 'A', ':', ' ',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '1', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'4', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
+	/* Initiate request to drop the active and retrieve the waiting call
+	 * (AT+CHLD=1) - HF
+	 */
+	define_hf_test("/HFP/HF/TWC/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', ',', '\"', 'b',
+				'l', 'u', 'e', 'm', 'a', 'n', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'C', 'W', 'A', ':', ' ',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '1', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'4', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
+	/* Request the AG to hold the active and retrieve the waiting call
+	 * (AT+CHLD=2) - HF
+	 */
+	define_hf_test("/HFP/HF/TWC/BV-03-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', ',', '\"', 'b',
+				'l', 'u', 'e', 'm', 'a', 'n', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'C', 'W', 'A', ':', ' ',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '1', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'4', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '1', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'4', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'b', 'l', 'u',
+				'e', 'm', 'a', 'n', '\"', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '1', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'4', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '2',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'a', 's', 'e',
+				'c', 'o', 'n', 'd', 'c', 'a', 'l', 'l', '\"',
+				'\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
 	return tester_run();
 }
-- 
2.43.0

