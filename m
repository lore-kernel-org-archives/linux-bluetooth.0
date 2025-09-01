Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66D32F75E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741765; cv=none; b=FJiq3ALQ4skSOoXRhy8xJwJ9vW5Kxv97fxrOKLWxES5ETvpSqQE0XFyMEHvv+sJ98KcQw1Fhg3l//42paVXw4r4xdFP97Z1Z+2uwto7APZQS7ljCTTQKaqSVAmq4ef7rZoDdSs5VeqbHWmwlaDuqYEBgCmLKzL5kJuR+HesxW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741765; c=relaxed/simple;
	bh=27JkvEVwybGLCURQdc8esFuoMQUaFGQYwHpIfw2UsqY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHEqFmTVhwfw4dVPh/oY4Fwzbp9cSQCxDe5R2kMRfbE4siuCJJ8wt+oZXnAZ88PbHg0sf0ZHIQ9o/bEcHcZ7pj9pVUZVu6hu6bR3snWmhDYPenVoJPyx0cH9VSIq7qRqOSWrzr3wykaeNVRzIwpZVDFdpC1eoKpf5dHagq8PYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bVKdy4Mb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bVKdy4Mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756741761;
	bh=27JkvEVwybGLCURQdc8esFuoMQUaFGQYwHpIfw2UsqY=;
	h=From:To:Subject:Date:From;
	b=bVKdy4MbytEg4upKek0ESOkLHTUDxAEAOzLWx8zYttHPkdeZ+X/TmN2S7ncF0f7TR
	 2DgQrfiktO9jlX6vN7VR9ElA3lU/vTLFW6jbjGvZopWfqGwSgxxMh0eubOepyAqVaJ
	 B1OiO6MSNrmXVSpn+0yT4dtIO2pJf+urwDIA+Org9KWQYQ8VeHiIHWOO7zEHpRxHM4
	 WB78J51UgBxLg5BaGJa+7MWo/GlLcI1POnFhDKPnpzBvuM08WqKyQp5ChLzFgy+V9b
	 62lMIAeqcYpwKkI6N62vlphldmdfvnUlV5FWOAM3L4sp+u11AagJZLW9pOF6kDu/q+
	 W+m0Km2nXoPmQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-5631-59f6-fA6F-7AAD.rev.sfr.net [IPv6:2a02:8428:af44:1001:5631:59f6:fa6f:7aad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10C2117E0483
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 17:49:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] unit/test-hfp: Re-order TS tests in alphabetical order
Date: Mon,  1 Sep 2025 17:49:01 +0200
Message-ID: <20250901154903.187038-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This will simplify when looking for a test.
---
 unit/test-hfp.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 9be1b05ae..0a6828b7c 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -771,15 +771,7 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 		return;
 	}
 
-	if (g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C")) {
-		context->session.step++;
-		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SERVICE);
-		g_assert_cmpint(val, ==, context->session.step % 2);
-
-		if (context->session.step == 3)
-			context->data->response_func(HFP_RESULT_OK, 0,
-								context);
-	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-01-C")) {
+	if (g_str_equal(test_name, "/HFP/HF/PSI/BV-01-C")) {
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SIGNAL);
 		g_assert_cmpint(val, ==, 3);
 		context->data->response_func(HFP_RESULT_OK, 0, context);
@@ -795,6 +787,14 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_BATTCHG);
 		g_assert_cmpint(val, ==, 3);
 		context->data->response_func(HFP_RESULT_OK, 0, context);
+	} else if (g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C")) {
+		context->session.step++;
+		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SERVICE);
+		g_assert_cmpint(val, ==, context->session.step % 2);
+
+		if (context->session.step == 3)
+			context->data->response_func(HFP_RESULT_OK, 0,
+								context);
 	}
 }
 
@@ -1008,18 +1008,6 @@ int main(int argc, char *argv[])
 			MINIMAL_SLC_SESSION,
 			data_end());
 
-	/* Transfer Registration Status - HF */
-	define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
-			NULL, test_hf_session_done,
-			MINIMAL_SLC_SESSION,
-			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
-			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
-			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
-			frg_pdu(' ', '1', ',', '0', '\r', '\n'),
-			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
-			frg_pdu(' ', '1', ',', '1', '\r', '\n'),
-			data_end());
-
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
@@ -1046,5 +1034,17 @@ int main(int argc, char *argv[])
 			frg_pdu(' ', '7', ',', '3', '\r', '\n'),
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
 	return tester_run();
 }
-- 
2.43.0

