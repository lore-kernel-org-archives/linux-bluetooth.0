Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BC1DE89B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610414; cv=none; b=qSzvTS6XMi4aDNLrrBgXi+z1/ggtfEsntj254HLPp4HLkXVVOWwFL6/fXSZBmPgTgekYsE/FBLGatD9RoKoSoYBz0IK+PGUkloNTxrRDBuY29JpBQTfDFT9GEjYp7PC0PXeUdLBorp8aU6pe/oWRKu24W4lsIhTcl8jl86LK5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610414; c=relaxed/simple;
	bh=2QG+83CuKnbIvyRt4viD9jfDQStbM79/i0yVQiKw8Os=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmFQbUJzqR6ZJYIUPTOFmtzEcv+0C+nWlLzhymkSEPom+a8yQQNRsb7fnml7vB+TnESAlt0bKNlrt2er5Gkd/opu1hu/FWWQ5FdiOIjC3CKsnDbO6Y7Zp5Hxda3mWgApbXBF4C7r1+El2M0Up6O4ABSmkhI6JIWRbF8LiLuYYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N28/5Mss; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N28/5Mss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755610410;
	bh=2QG+83CuKnbIvyRt4viD9jfDQStbM79/i0yVQiKw8Os=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N28/5Mss0T/CZ/s5NExrbg2V5eSX9JY9HJPQnf5pRmzS5QWdpSoYs9wBYU9qLpD2b
	 Etm4pZiLM0MatD78LXQ0zjroDD8gHzWyOvM+X8lyKIqFbXdaIriq448Oa9eGc1kLpr
	 BlGAV2uwRrUgceQk+mLEnOpc37M1OLqnJQKjBhblGCNZH0ZpHb8nVoDHhGc6Ct4EY2
	 VV78k8PTkBeuWb3LRiW8OZICMzgZyfpFWs5iUKTcHNmLIEdR1K9MqLg7Xwti4e+NQG
	 O0KUlj9Nrppd3mqB4NYfWzihexY8yyxVP1C1GGw94dySARr6QhxuQL4dmlwXOm14T4
	 38xdk+MPgEJPA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-110B-4649-b903-4EDe.rev.sfr.net [IPv6:2a02:8428:af44:1001:110b:4649:b903:4ede])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8901C17E0DE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 15:33:30 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ RESEND 2/4] unit/test-hfp: Add SLC connection test
Date: Tue, 19 Aug 2025 15:33:19 +0200
Message-ID: <20250819133321.382279-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819133321.382279-1-frederic.danis@collabora.com>
References: <20250819133321.382279-1-frederic.danis@collabora.com>
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

