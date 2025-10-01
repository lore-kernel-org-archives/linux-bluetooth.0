Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE623BD13
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301680; cv=none; b=Iclu1HJM44giVkOZAz7QNgW60owW1/EG7MybvagrXv7EUJrCD5FQsLNkV/Hl5fBrzrtVb4zp/luiL/ZUyequlBQ36qXbpTA82bggrRjxe0WplOPqwFVW/IS8GDA8BvZJiNnvDqO89wAkGsuX6xKZBrs6ZMjS1aDtu1Bx3Kb3OQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301680; c=relaxed/simple;
	bh=fEZrdtwITvYqUAnXtge1pbZKqLjyGH1AUnzMvGl66O8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABnv9kvR0wUCoOfnag1w5cFWgoe2/5HHN0pZHYFHfrsDNQv5bQIrZDOxqW2xjqU6Zi2In3rPXOWrRIMCVoFapB6jISKgQ2GQ08rXwZpJqDhWcji7QYlGJSTSxlNasafMj+5SraWlEjzFXHfpYkucqjEAoZsOPPpKcBzmZsHlGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p2uQQX+f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p2uQQX+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759301675;
	bh=fEZrdtwITvYqUAnXtge1pbZKqLjyGH1AUnzMvGl66O8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p2uQQX+fyy+I/jhz8WjOoyt3qW8m/H3SA8P6VVDBy4CcXB9O26mhGIfrOsQg7JTny
	 iFciRVFwdbBPYUNvQlYylACoPZijwovW39p8I4b906W05+Wzs30+3w5D9v7UahSJcT
	 3L0hPEJkgp8nvRcOMTTDufO0Buam79MCNgAkfGnVnvfSGqw08k04RZghTcsSjgBayf
	 RkiItgRcDnID8ogW4pTCUyzO3fh0DtmLlSGIpJGYNO0zUb/zRMb+Ghq2p+yIrCFjl5
	 bmKQym+a4T+QcMxlujlH/14vu8Ddh1vUDMSZBnF7OD1Wm6fD84pobGltKS4UnPyLSg
	 EiLb32Qjri39A==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-2e77-3033-4926-5452.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e77:3033:4926:5452])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C224C17E00EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 08:54:35 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] unit/test-hfp: Add dial tests for HF
Date: Wed,  1 Oct 2025 08:54:25 +0200
Message-ID: <20251001065429.268068-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001065429.268068-1-frederic.danis@collabora.com>
References: <20251001065429.268068-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following tests:
- /HFP/HF/OCL/BV-01-C
  Initiate a call placed to the last number
- /HFP/HF/OCL/BV-02-C
  Handling ERROR response to a call placed to last number
- /HFP/HF/OCM/BV-01-C
  Initiate a request to place a call with a memory location
- /HFP/HF/OCM/BV-02-C
  Handling ERROR response to a call placed to an empty memory location
- /HFP/HF/OCN/BV-01-C
  HF places a call with a phone number
---
 unit/test-hfp.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 190604ba2..8afb15fa3 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -739,13 +739,62 @@ static void hf_cmd_complete(enum hfp_result res, enum hfp_error cme_err,
 	g_assert_cmpint(res, ==, HFP_RESULT_OK);
 }
 
+static void hf_cmd_error(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	g_assert_cmpint(res, ==, HFP_RESULT_ERROR);
+}
+
 static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
 	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
 
 	g_assert_cmpint(res, ==, HFP_RESULT_OK);
 	context->session.completed = true;
+
+	if (g_str_equal(test_name, "/HFP/HF/OCL/BV-01-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("calling last dialed number");
+		ret = hfp_hf_dial(context->hfp_hf, "", hf_cmd_complete,
+							context);
+		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCL/BV-02-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("calling last dialed number");
+		ret = hfp_hf_dial(context->hfp_hf, "", hf_cmd_error,
+							context);
+		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCM/BV-01-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("calling memory 1");
+		ret = hfp_hf_dial(context->hfp_hf, ">1", hf_cmd_complete,
+							context);
+		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCM/BV-02-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("calling memory 1");
+		ret = hfp_hf_dial(context->hfp_hf, ">1", hf_cmd_error,
+							context);
+		g_assert(ret);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCN/BV-01-C")) {
+		bool ret;
+
+		if (tester_use_debug())
+			tester_debug("calling number");
+		ret = hfp_hf_dial(context->hfp_hf, "1234567", hf_cmd_complete,
+							context);
+		g_assert(ret);
+	}
 }
 
 static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
@@ -836,6 +885,27 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		g_assert_cmpint(id, ==, 1);
 		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCL/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_DIALING);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_null(number);
+	} else if (g_str_equal(test_name, "/HFP/HF/OCM/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_DIALING);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, ">1");
+	} else if (g_str_equal(test_name, "/HFP/HF/OCN/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_DIALING);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, "1234567");
 	} else if (g_str_equal(test_name, "/HFP/HF/TCA/BV-04-C")) {
 		bool ret;
 
@@ -917,6 +987,39 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		if (tester_use_debug())
 			tester_debug("Error: unexpected update");
 		tester_test_failed();
+	} else if (g_str_equal(test_name, "/HFP/HF/OCL/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		if (context->session.step == 0)
+			g_assert_cmpint(status, ==, CALL_STATUS_ALERTING);
+		else
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_null(number);
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/OCM/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		if (context->session.step == 0)
+			g_assert_cmpint(status, ==, CALL_STATUS_ALERTING);
+		else
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, ">1");
+		context->session.step++;
+	} else if (g_str_equal(test_name, "/HFP/HF/OCN/BV-01-C")) {
+		const char *number;
+
+		g_assert_cmpint(id, ==, 1);
+		if (context->session.step == 0)
+			g_assert_cmpint(status, ==, CALL_STATUS_ALERTING);
+		else
+			g_assert_cmpint(status, ==, CALL_STATUS_ACTIVE);
+		number = hfp_hf_call_get_number(context->hfp_hf, id);
+		g_assert_cmpstr(number, ==, "1234567");
+		context->session.step++;
 	} else if (g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C")) {
 		const char *number;
 		bool ret;
@@ -1231,6 +1334,69 @@ int main(int argc, char *argv[])
 				'3', ',', '0', '\r', '\n'),
 			data_end());
 
+	/* Initiate a call placed to the last number - HF */
+	define_hf_test("/HFP/HF/OCL/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '2', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '3', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Handling ERROR response to a call placed to last number - HF */
+	define_hf_test("/HFP/HF/OCL/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'E', 'R', 'R', 'O', 'R'),
+			frg_pdu('\r', '\n'),
+			data_end());
+
+	/* Initiate a request to place a call with a memory location - HF */
+	define_hf_test("/HFP/HF/OCM/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '2', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '3', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
+	/* Handling ERROR response to a call placed to an empty memory
+	 * location - HF
+	 */
+	define_hf_test("/HFP/HF/OCM/BV-02-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'E', 'R', 'R', 'O', 'R'),
+			frg_pdu('\r', '\n'),
+			data_end());
+
+	/* HF places a call with a phone number - HF */
+	define_hf_test("/HFP/HF/OCN/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '2', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '3', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

