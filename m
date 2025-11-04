Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76A2BCF41
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248504; cv=none; b=kmTazmZFGmxTBR5wKquruJo0hK5cPev9v2wFKz8Qy+YHjUQFYWApm0PX4PgHOSZ48g2yvrCCqvBcjb7EdPA4j8BXKOf8TGTYJeHWihOrcpqCrtOXMbD79N9BxHLlrkVfvVmIlzMcs1Z4PriTRqVnyyYAVcVnwhDcg6QoIDM+tho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248504; c=relaxed/simple;
	bh=7UfYqu9WBBUxUDphr6biE12F/To0cfKACGyurH4kdVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HV5TUWb38yKkGE6U284A6C+pb5txI1IJSN1BqU73S7B/VBtSh1QH0Q/ocYlrXv+QGEw830bXu5v8tomOLV9Z/5Lx+YMh8ieT2XZw9P1xEwi2wEuJ1+vN03hsuZDZB8XuMnJ39sE4LSjEpj/4wtG4VOmQ0Orm7LfmVI/bQ3PbPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NUwyAmXF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NUwyAmXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762248494;
	bh=7UfYqu9WBBUxUDphr6biE12F/To0cfKACGyurH4kdVg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NUwyAmXFJe41Xh7LqKh4A1C6NZ+9n+DKuIH1ZaMu0QMKla7PoQkaVw0fWajDhoxxD
	 S1d1XaqDhB7JkQhjxheXVXccjEIxbEPiNOdwiuSureEiN7s66RJBa19B+W2TnxggSg
	 VCJ5aJtK8OSDGHNzNkPFzcKg4SyTSDhrZ5YU+O39Elms4W07vyhthqouawsMGhP7H0
	 BIGwUPzTFINHvZDeVtU4LYOd7YhTKqFUqhhfbSQI9YUgnm5ZJBsEi5+ZccXRL7KkwZ
	 p1exOEdBSwXgWF4Ukxso/f16yau/QvCYwkji+uNBPOOtPBp5t80jFrdxIiGu4+Sygg
	 ast19RgCftOrA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-2EF7-962e-01c6-D201.rev.sfr.net [IPv6:2a02:8428:af44:1001:2ef7:962e:1c6:d201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5360B17E13BC
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 10:28:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] unit/test-hfp: Add ECNR off test
Date: Tue,  4 Nov 2025 10:28:08 +0100
Message-ID: <20251104092808.128726-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104092808.128726-1-frederic.danis@collabora.com>
References: <20251104092808.128726-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- /HFP/HF/ENO/BV-01-C
  Verify that the HF can disable the EC/NR function of the AG.
---
 unit/test-hfp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 94553d62c..c3f9ac4d0 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -787,6 +787,9 @@ static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 	g_assert_cmpint(res, ==, HFP_RESULT_OK);
 	context->session.completed = true;
 
+	if (tester_use_debug())
+		tester_debug("HF session ready");
+
 	if (g_str_equal(test_name, "/HFP/HF/OCL/BV-01-C")) {
 		bool ret;
 
@@ -998,7 +1001,8 @@ static void hf_call_line_id_updated(uint id, const char *number,
 	str = hfp_hf_call_get_number(context->hfp_hf, id);
 	g_assert_cmpstr(number, ==, str);
 
-	if (g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
+	if (g_str_equal(test_name, "/HFP/HF/ENO/BV-01-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-02-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
@@ -1368,6 +1372,23 @@ int main(int argc, char *argv[])
 				',', '1', '2', '9', ',', ',', '\r', '\n'),
 			data_end());
 
+	/* Disable EC/NR on the AG - HF */
+	define_hf_test("/HFP/HF/ENO/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			FULL_SLC_SESSION('1', '0', '0', '0'),
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
+			data_end());
+
 	/* Incoming call, in-band ring - HF */
 	define_hf_test("/HFP/HF/ICA/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

