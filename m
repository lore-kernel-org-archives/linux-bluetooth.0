Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CC2D73A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760299; cv=none; b=Lfpew5l4fX+huC8j4dA+IAKAhUEX0r7xTr7dDwSDeAAwDbk6xpa82pa3QXui5X/9ngLAmAmmZm6yWRpdWooOfOBbAkQm1dSfo4jGtm6NR0q/hkeIAhzy3hilb5qyf0a0Kql4v6+3kjLnvEOlc21jkgX0977QwnFxn7ZIKZ55xfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760299; c=relaxed/simple;
	bh=WoOtfu7a1ssBTzT+qzGFpj+0l4UXlYq+r/7TB/K474k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PygkZ8EB5KW7kmJ4bBBLg/3od5Tf00YsJAF0C6+O0LUeYcQDUlJpyUV5ZoXfJSwpLqOmyPA0qhcxjXfGUFjtFuZtItfIKSBNte/aGGnJtQ8veLrMTf6ppWpL/8nadJXyflSN+wddhmE/3U+N6ZpWPkjP3AQAbIn25iu5nkQ/NLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ovLLGZud; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ovLLGZud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762760295;
	bh=WoOtfu7a1ssBTzT+qzGFpj+0l4UXlYq+r/7TB/K474k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ovLLGZudce5ZMfzum29wONPnhYLHVz6+Q6aueHsYbWEelbU8J597C6s67R1VbZPzO
	 UXQQ07oFKlvGHAjKOQyHL+GOUDFLJPah5pPU6biEs5OGgawlOfcXljRqzBbSrmzWsm
	 oDQ/jSiDWB+P5gPZb01UcqflJ3jR/1Z87mENumRd/OQZCHylbpdPJDHN1zJBstXn7O
	 WgqnzGECrnOd6d5JFyVyByJJWwHsGALjXlb3t3Rg1yL01phCgZzSycs65dHGIdiZQK
	 KegWgMRCg64PTyrFJHF1gUCId9P/QFcHFRHcJJlY7uLrMjggEU2sJLfEDdDLP0GMnG
	 CogwrxjanQgAA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-573E-e254-BC4f-0fC8.rev.sfr.net [IPv6:2a02:8428:af44:1001:573e:e254:bc4f:fc8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 234D017E090D
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 08:38:15 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] unit/test-hfp: Add Enhanced Call Status tests
Date: Mon, 10 Nov 2025 08:38:04 +0100
Message-ID: <20251110073804.49651-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110073804.49651-1-frederic.danis@collabora.com>
References: <20251110073804.49651-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- /HFP/HF/ECS/BV-01-C
  Verify that the HF can request the status of current calls in the AG.
- /HFP/HF/ECS/BV-02-C
  Verify that the AG can send the correct call status when an SLC is
  initialized.
- /HFP/HF/ICA/BV-07-C-full
  Verify that HF can connect to an AG that is receiving an in-coming
  call.
---
 unit/test-hfp.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index b25b67379..67a88a1cc 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -948,7 +948,8 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 	} else if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full")) {
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C-full")) {
 		bool ret;
 
 		g_assert_cmpint(id, ==, 1);
@@ -1055,6 +1056,7 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		const char *number;
 
@@ -1377,6 +1379,38 @@ int main(int argc, char *argv[])
 				',', '1', '2', '9', ',', ',', '\r', '\n'),
 			data_end());
 
+	/* Query list of current calls - HF */
+	define_hf_test("/HFP/HF/ECS/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'A', 'n', 'A',
+				'c', 't', 'i', 'v', 'e', 'c', 'a', 'l', 'l',
+				'\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
+	/* Receiving call status on SLC initialization - HF */
+	define_hf_test("/HFP/HF/ECS/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '1', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '7', '6', '5', '4', '3', '2', '1', '\"',
+				',', '1', '2', '9', ',', '\"', 'A', 'n', 'A',
+				'c', 't', 'i', 'v', 'e', 'c', 'a', 'l', 'l',
+				'\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
 	/* Disable EC/NR on the AG - HF */
 	define_hf_test("/HFP/HF/ENO/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
@@ -1622,6 +1656,39 @@ int main(int argc, char *argv[])
 				'2', ',', '0', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/HFP/HF/ICA/BV-07-C-full", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '1', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '4', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'A', 'i', 'n',
+				'c', 'o', 'm', 'i', 'n', 'g', 'c', 'a', 'l',
+				'l', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', ',', '\"', 'A',
+				'i', 'n', 'c', 'o', 'm', 'i', 'n', 'g', 'c',
+				'a', 'l', 'l', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'C', 'C', ':', '1',
+				',', '1', ',', '0', ',', '0', ',', '0', ',',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', '\"', 'A', 'i', 'n',
+				'c', 'o', 'm', 'i', 'n', 'g', 'c', 'a', 'l',
+				'l', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			data_end());
+
 	/* Initiate rejection of incoming call - HF */
 	define_hf_test("/HFP/HF/ICR/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

