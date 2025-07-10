Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F82F0E42
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167927; cv=none; b=GmyrssM9bpoAsq7YguU6XMsRGaSAqkLQME3sQ0h8KG/e/JOBkpoNpRVXTMnBMtWYPlvg/iFvTV+hbyNiUFPt9qECKmbNuRJ4aa/OOFqQFWHr612Tj9NqH6Q+5Diy7iV7QiksH7DdxoUZ+UwNVeioVVF57KOT73kWCJOmqCV57k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167927; c=relaxed/simple;
	bh=2QG+83CuKnbIvyRt4viD9jfDQStbM79/i0yVQiKw8Os=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk5tVNBTPdA3agDlQroibKABtFmsCPxpsSepSRByn/lpM7f/foVn60+kyZZfuMa0o5mCUQKbMUyk2t8CQKBoRT2/Aij/A/QUdKxvAfN84OekHhH3yR/yH8y8bjk8a6qohDvn5aW2b6gXX9YNjH19cG1Q8lPXi7iAxWK3WnsCRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WR71n+XD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WR71n+XD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752167923;
	bh=2QG+83CuKnbIvyRt4viD9jfDQStbM79/i0yVQiKw8Os=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WR71n+XDf+QxO5PuWBrQ7lO6kwp+tK1kQbTsrWokzepnaWT4zLQyCT/3pm3xZximj
	 +66tBh/IVJdRydOdnriqw+/tNnt2VuHOg1gP/M1MmW4nUm3won4zt0i12vqTx1g4Jv
	 RIQtIdDO6gLRnSfnouSdhnSa8sPpTdFjlogWePRq42wV6L6bCLPnu/5stqYY1q2Y4i
	 l4wqg8qmfmsv8F1MalfTDaHj+ebkK6HrRte7gogc7nS4bUjdlpNrWTDvDrxPvLKLZh
	 h8YAWbDzZdbptd+wzf9cKaU4tpg1fAgAVlQDvpO/VwHaZAKIVtdlzxlG3qkbG+ncJU
	 E6fi/XAB7fmWw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-9be2-7429-4d2E-B935.rev.sfr.net [IPv6:2a02:8428:af44:1001:9be2:7429:4d2e:b935])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D2CA17E0489
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 19:18:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] unit/test-hfp: Add SLC connection test
Date: Thu, 10 Jul 2025 19:18:36 +0200
Message-ID: <20250710171838.949803-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710171838.949803-1-frederic.danis@collabora.com>
References: <20250710171838.949803-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This adds minimal packet exchange to test the SLC establishment.
---
 unit/test-hfp.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index b4af99d53..2ea77e210 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -104,6 +104,14 @@ struct test_data {
 		data.test_handler = test_hf_handler;			\
 	} while (0)
 
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	if (tester_use_debug())
+		tester_debug("%s%s", prefix, str);
+}
+
 static void test_free(gconstpointer user_data)
 {
 	const struct test_data *data = user_data;
@@ -680,6 +688,110 @@ static void test_hf_robustness(gconstpointer data)
 	context_quit(context);
 }
 
+#define MINIMAL_SLC_SESSION \
+	raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
+		' ', '0', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
+	frg_pdu('(', '\"', 's', 'e', 'r', 'v', 'i', 'c', 'e'), \
+	frg_pdu('\"', '(', '0', ',', '1', ')', ')', ','), \
+	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', '\"'), \
+	frg_pdu('(', '0', ',', '1', ')', ')', ','), \
+	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', 's', 'e', 't'), \
+	frg_pdu('u', 'p', '\"', ',', '(', '0', '-', '3', ')'), \
+	frg_pdu(')', ','), \
+	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', 'h', 'e', 'l'), \
+	frg_pdu('d', '\"', ',', '(', '0', '-', '2', ')', ')'), \
+	frg_pdu(',', '(', '\"', 's', 'i', 'g', 'n', 'a', 'l'), \
+	frg_pdu('\"', '(', '0', '-', '5', ')', ')', ','), \
+	frg_pdu('(', '\"', 'r', 'o', 'a', 'm', '\"', ',', '('), \
+	frg_pdu('0', ',', '1', ')', ')', ','), \
+	frg_pdu('(', '\"', 'b', 'a', 't', 't', 'c', 'h', 'g'), \
+	frg_pdu('\"', '(', '0', '-', '5', ')', ')', ','), \
+	frg_pdu('\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
+	frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
+	frg_pdu(',', '0', ',', '5', '\r', '\n'), \
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
+
+static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert_cmpint(res, ==, HFP_RESULT_OK);
+
+	context->data->response_func(res, cme_err, context);
+}
+
+static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
+							void *user_data)
+{
+	switch (indicator) {
+	case HFP_INDICATOR_SERVICE:
+		g_assert_cmpint(val, ==, 1);
+		break;
+	case HFP_INDICATOR_CALL:
+		g_assert_cmpint(val, ==, 0);
+		break;
+	case HFP_INDICATOR_CALLSETUP:
+		g_assert_cmpint(val, ==, 0);
+		break;
+	case HFP_INDICATOR_CALLHELD:
+		g_assert_cmpint(val, ==, 0);
+		break;
+	case HFP_INDICATOR_SIGNAL:
+		g_assert_cmpint(val, ==, 5);
+		break;
+	case HFP_INDICATOR_ROAM:
+		g_assert_cmpint(val, ==, 0);
+		break;
+	case HFP_INDICATOR_BATTCHG:
+		g_assert_cmpint(val, ==, 5);
+		break;
+	case HFP_INDICATOR_LAST:
+	default:
+		tester_test_failed();
+	}
+}
+
+static struct hfp_hf_callbacks hf_session_callbacks = {
+	.session_ready = hf_session_ready_cb,
+	.update_indicator = hf_update_indicator,
+};
+
+static void test_hf_session_done(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	hfp_hf_disconnect(context->hfp_hf);
+}
+
+static void test_hf_session(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	bool ret;
+
+	context->hfp_hf = hfp_hf_new(context->fd_client);
+	g_assert(context->hfp_hf);
+
+	ret = hfp_hf_set_debug(context->hfp_hf, print_debug, "hfp-hf:", NULL);
+	g_assert(ret);
+
+	ret = hfp_hf_set_close_on_unref(context->hfp_hf, true);
+	g_assert(ret);
+
+	ret = hfp_hf_session_register(context->hfp_hf, &hf_session_callbacks,
+								context);
+	g_assert(ret);
+
+	ret = hfp_hf_session(context->hfp_hf);
+	g_assert(ret);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -850,5 +962,10 @@ int main(int argc, char *argv[])
 			frg_pdu('1', ',', '2', 'x', '\r', '\n'),
 			data_end());
 
+	define_hf_test("/hfp_hf/test_session_minimal", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION,
+			data_end());
+
 	return tester_run();
 }
-- 
2.43.0

