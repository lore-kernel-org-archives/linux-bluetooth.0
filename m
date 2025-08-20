Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E4327783
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696832; cv=none; b=Ztc5n2ecgz1KC7ktX0qSBlTuMy2FpVzrlIHJWSWC5NnRLpVloeT8rXi7yeb7Brk4hwt13iEJEtb8eisW6QI1+p5ynspzvE0daOhiGFuzmk05pwLwXHgfVAhMpjmpwVDn0oxPouXb+7e6WMpGjwFvLRczrj+q2b8Qc6ZxbrqDnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696832; c=relaxed/simple;
	bh=65cIcgm+hmUp3LusKIRMHVtW4vbjB83GSVdYwEYcDJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxuWnxxiAgeMiSpiarAGgYGRkgBvp7SCiGPr5kj+LQVKkZrUFYju3BNcVGnnaIJZhZgQQ/wcQHSwoHC+TUsMnInyL6pXmYWgjp4dWVGgi91A9eiTgUnhTYOuPNfF2PC6dWbiw6s+hjtX++jY95pUvlkCbExwZykcctaH/ulagLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kmOz3D/d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kmOz3D/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755696829;
	bh=65cIcgm+hmUp3LusKIRMHVtW4vbjB83GSVdYwEYcDJs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kmOz3D/d31+fBVYsb2zWq/teEXBfF47iJSu6gUz9ZKNDAaGLaD9iBSZb1QEsGdEXM
	 eThKkkjtzFuDKahShXZSGQ8VFIAVQiUgS4GrXkLd9KcKGaudcW4YquPtOPH+KZqnDu
	 w1QqZ+Wb0hlA4FWwYjC5p1DVcmBUNjWhLgKn5hufWFPS8cEh+cXhoLKwcrkrOdXhIp
	 onFewLtSN3v4H1nLOSex2fu01rZTO8AGiDtoeZCVxCCJPNxY4Kcu1NOLx+qF2Z/DIL
	 lDhT+WOyzEHKl70JldG/0eVa82RSFWijFhvh86azHlijDn6N2ZTfyUS4ZKy7whvWxC
	 pnvELcxg6H03Q==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-e86C-1c83-BFB8-e1aE.rev.sfr.net [IPv6:2a02:8428:af44:1001:e86c:1c83:bfb8:e1ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC2F117E155C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:33:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] unit/test-hfp: Add indicators tests for HF
Date: Wed, 20 Aug 2025 15:33:38 +0200
Message-ID: <20250820133338.1158203-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820133338.1158203-1-frederic.danis@collabora.com>
References: <20250820133338.1158203-1-frederic.danis@collabora.com>
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
index b79034642..9be1b05ae 100644
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
-		g_assert_cmpint(val, ==, 0);
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

