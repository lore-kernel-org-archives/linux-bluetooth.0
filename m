Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1F2ECE98
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270253; cv=none; b=l6uNjgoqJWLHMAKmjmYOODICpjNxlucsT9EdO57kBRao0CPujODhu4hpYnahT2rsG2OeE1LlM/SH0WN3+2940FEgUw9oSd9xARO7w+mfteq1uSGVNkl4xLAdYUxbZeyI52YjTaURluB9ZPOhhfrZpmXQMtSzFQnt2DCRFkYKfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270253; c=relaxed/simple;
	bh=80+968BEUIwNTTq1OxDadZtvgiHUEzj/i1vO7IVdGZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCR8PlyarTlilUFn4BjtvwYlx1yjHDubtGtl3ccKOKuVQj/Vp9b8uwkD+pD0pWb3y+u2WmaZRgcn1fOCoOII0j09eFgNRIkjhxh44OYVusInL4AkXqHXeyVMZnGWJuu1ELI0lV9l6nZo6lwkyDfZFMlWhG80iJmhDvcd6P3NYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iSGmGach; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iSGmGach"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758270249;
	bh=80+968BEUIwNTTq1OxDadZtvgiHUEzj/i1vO7IVdGZk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iSGmGachkUmwJclHACoJSzqKIMy7VSdMCIwePY9YV5eicKFRtVMR+vnxtkLvxa4JY
	 Hrpeccq3rM34iQxZ5AIo8aKJj0iRVta7DbuS/DxqOUzMIkeivUoGe9OREAel0VEai0
	 OgfhSUWnOoDerOxA2k0hfnP6ogjMNxjW8nu87L492YJfoDasQbi/+f9H5wrJXtxCGs
	 e01KQ5X6xuVVHXoWlRgbJBetWBacppe77e9fHRKWtKTdnzzNBbfgItbcOkJQTTzCv0
	 NduNMU/8ylVGMDPZ108R5aO5q4raH98OsONB9dXUqZpJ9iL7XqQcqHTjA+gYVJcLt3
	 wI2IH+j5/acVQ==
Received: from fdanis-ThinkPad-X1.. (unknown [IPv6:2a02:8428:af44:1001:17f0:5da3:acf8:a3c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D77417E1339
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 10:24:09 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] unit/test-hfp: Add Terminate Call tests for HF
Date: Fri, 19 Sep 2025 10:23:34 +0200
Message-ID: <20250919082334.1443310-5-frederic.danis@collabora.com>
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
- /HFP/HF/TCA/BV-01-C
  Verify that the HF can terminate an ongoing call in the AG.
- /HFP/HF/TCA/BV-02-C
  Verify that the AG, upon the corresponding action, terminates an
  ongoing call. The AG then indicates this event to the HF.
- /HFP/HF/TCA/BV-04-C
  Verify that the HF can release a call after dialing and prior to
  call completion.

/HFP/HF/TCA/BV-03-C (Verify that after a call is terminated from the
remote party, the HF receives the proper indication from the AG) is
similar to /HFP/HF/TCA/BV-02-C for the HF side.
---
 unit/test-hfp.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index a0faf98d7..190604ba2 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -831,9 +831,22 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C")) {
+		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		g_assert_cmpint(id, ==, 1);
 		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+	} else if (g_str_equal(test_name, "/HFP/HF/TCA/BV-04-C")) {
+		bool ret;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_DIALING);
+
+		if (tester_use_debug())
+			tester_debug("call %d: ending call", id);
+		ret = hfp_hf_call_hangup(context->hfp_hf, id, hf_cmd_complete,
+							context);
+		g_assert(ret);
 	}
 }
 
@@ -854,7 +867,9 @@ static void hf_call_line_id_updated(uint id, const char *number,
 	str = hfp_hf_call_get_number(context->hfp_hf, id);
 	g_assert_cmpstr(number, ==, str);
 
-	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C")) {
+	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
+		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		bool ret;
 
 		if (tester_use_debug())
@@ -890,7 +905,8 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		tester_debug("call %d updated: status %u", id, status);
 
 	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
-		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C")) {
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
+		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		const char *number;
 
 		g_assert_cmpint(id, ==, 1);
@@ -901,6 +917,20 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		if (tester_use_debug())
 			tester_debug("Error: unexpected update");
 		tester_test_failed();
+	} else if (g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C")) {
+		const char *number;
+		bool ret;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, "1234567");
+
+		if (tester_use_debug())
+			tester_debug("call %d: ending call", id);
+		ret = hfp_hf_call_hangup(context->hfp_hf, id, hf_cmd_complete,
+							context);
+		g_assert(ret);
 	}
 }
 
@@ -1233,6 +1263,58 @@ int main(int argc, char *argv[])
 			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
 			data_end());
 
+	/* Terminate ongoing call - HF */
+	define_hf_test("/HFP/HF/TCA/BV-01-C", test_hf_session,
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
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Terminate ongoing call on AG - HF
+	 * idem for /HFP/HF/TCA/BV-03-C Remote party terminates the call
+	 */
+	define_hf_test("/HFP/HF/TCA/BV-02-C", test_hf_session,
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
+	/* Abandon outgoing call - HF */
+	define_hf_test("/HFP/HF/TCA/BV-04-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '2', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Transfer Registration Status - HF */
 	define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

