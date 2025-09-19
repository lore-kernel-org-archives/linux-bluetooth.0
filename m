Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE42ECE85
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270252; cv=none; b=MA/1Khzv/YmC2k8tvcQpuZn9DdLYE1+DNE0nesgOpK8EcDWcfmlauDTr2moZi4iF7qIIeENWFrGeBKdNI6xsPGOboRGzojFWEVuLsUVUsA8fEFuOBslm/XtKsdpq1wKF8sAtCTdQNhfNT7+ig+lMdSsFQ4Ypft1mwYO2TOed8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270252; c=relaxed/simple;
	bh=sYqv2eLfUs8f84Ib/ijmE+RlfLkOnJ7Y4RjSUoPrj4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onTs6bLX/9uqiw3tJWhg5nsf6lIzvxy1V1T/KxDsoPQb/lb1IN1qr5ClljhYKmoPowMUwDo9Ylz2t0pAJsbvOPf0f5AnWvtneCJ+57y2J4WtxbP51yUnqu4sMKS6Aub3Tmqx6xYD5l2Ob+fKgDlJygWNoTX8L+QwshhfWx6ohAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TsoQyHoS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TsoQyHoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758270249;
	bh=sYqv2eLfUs8f84Ib/ijmE+RlfLkOnJ7Y4RjSUoPrj4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TsoQyHoSPBxXIzcqSuxMLrQYr/JBV7ASextyn0HFd7qEyafamYPo1YqMsGIVupvKh
	 /vKKbwvPNmJVsOzybqvVyjO0YRYpyvW9NVuBAjE9EwD7DbwiwnpiOy5UQDnA1peUf+
	 6yAHkj04+Drt0q3v/AOMdczipq2sDKX3dPW4hdLsq46enKI+X7fLnwIYuKDgYHsd1h
	 +4X/Ck0WicZKW9KbFvhrHG9klmRIDstxhgMuL4ZQRwdLtMO5HdsEAlR8L25DhS1E+a
	 TSHMqRtQQBPvsQ6Yx4FYadJW41e4+3wM7JSmCpdfPCNRZhlO8ziRU324RfuGyBCI0B
	 7/UedNcd96WDA==
Received: from fdanis-ThinkPad-X1.. (unknown [IPv6:2a02:8428:af44:1001:17f0:5da3:acf8:a3c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 443EE17E131D
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:24:09 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] unit/test-hfp: Add Reject Incoming Call tests for HF
Date: Fri, 19 Sep 2025 10:23:33 +0200
Message-ID: <20250919082334.1443310-4-frederic.danis@collabora.com>
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
- /HFP/HF/ICR/BV-01-C
  Verify that the HF can reject an incoming call after being alerted.
- /HFP/HF/ICR/BV-02-C
  Verify that the AG, upon the corresponding action, rejects an incoming
  call and properly indicates this event to the HF.
---
 unit/test-hfp.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index adbcfd2fc..a0faf98d7 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -830,7 +830,8 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 
 	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C")) {
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C")) {
 		g_assert_cmpint(id, ==, 1);
 		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
 	}
@@ -861,6 +862,14 @@ static void hf_call_line_id_updated(uint id, const char *number,
 		ret = hfp_hf_call_answer(context->hfp_hf, id, hf_cmd_complete,
 								context);
 		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("call %d: rejecting call", id);
+		ret = hfp_hf_call_hangup(context->hfp_hf, id, hf_cmd_complete,
+							context);
+		g_assert(ret);
 	}
 }
 
@@ -888,6 +897,10 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
 		number = hfp_hf_call_get_number(context->hfp_hf, id);
 		g_assert_cmpstr(number, ==, "1234567");
+	} else if (g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C")) {
+		if (tester_use_debug())
+			tester_debug("Error: unexpected update");
+		tester_test_failed();
 	}
 }
 
@@ -1159,6 +1172,35 @@ int main(int argc, char *argv[])
 				'2', ',', '0', '\r', '\n'),
 			data_end());
 
+	/* Initiate rejection of incoming call - HF */
+	define_hf_test("/HFP/HF/ICR/BV-01-C", test_hf_session,
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
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Accept AG rejection of incoming call - HF */
+	define_hf_test("/HFP/HF/ICR/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

