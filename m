Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D67C120
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741765; cv=none; b=N1xCNkR+0BN846XABovunsZrB5CEJfcphhJc4VeDU2hThemODzVQcO6PDsvgmsLB9LSqOu+vJp2Xg8Yg2LYkdiI0mRv3O2+y4wJhiTpkfURdwb5v7nr5HO7Mz5580uRSFjxPV8v0oZeaT7f5yPEFb+qJZHmWBZ2jyUNIQ43FH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741765; c=relaxed/simple;
	bh=b7f8uGwOn1dLlin8eeq9+E0H7C0nufuIEZ3IOn4LehM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHaMFDhSvJE2R7bfGZGLDOJaUCJdUWoS88QDZO83dKZvmnxmwdSo2yE7ywLEXbFDWfBJp50qDZJTOBKK/RQuOXQZzmEdBzR7YJPJA1TQ/pGBM/T4pRvvGlW968zU8N+zZ8RbyjPZTb9jl25aXvOQO5OWwZAsWK6Z8qS29gwPso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=prEFLQ4d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="prEFLQ4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756741761;
	bh=b7f8uGwOn1dLlin8eeq9+E0H7C0nufuIEZ3IOn4LehM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=prEFLQ4dnmIe4G69+fLmp5R3i36eTEhWFMcBzS5//g7f+D/fDsYDTwvyk+nogXC7G
	 PBr7huscUCKuyyGJOyDhDmhH3qHGwLXj8ok2FGfyVAzB+WO08DmZFENr7yNnTQ71AH
	 f0w3pUXsaNfDy9R0Q9Ba98KLEoi34UMjS05o5mnFOFjqoRlMTnaD/AHCfE0Zxyy2gb
	 8lqeELCt+TgaFvgfC0AX1h5pPnyWCZpo5SZEowc/2u6p70/FxRZRalQ4+pAjvtCKga
	 7q7rwoLchABG9mhAm4Wy1sod4/8F4h8tk+rytmqG2uxyFX4XTT3QGW9xjqSgDSYKDm
	 7JpL7Hms+/w4A==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-5631-59f6-fA6F-7AAD.rev.sfr.net [IPv6:2a02:8428:af44:1001:5631:59f6:fa6f:7aad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A507A17E0593
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 17:49:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] unit/test-hfp: Play PDUs up to the last one for HF tests
Date: Mon,  1 Sep 2025 17:49:03 +0200
Message-ID: <20250901154903.187038-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901154903.187038-1-frederic.danis@collabora.com>
References: <20250901154903.187038-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This will allows to create PDU set for TS tests which may end with
events not triggering actions, e.g. when receiving +CIEV:<callsetup>,0
where call status has already been updated by +CIEV:<call>,1

Free context->data only after completing hfp_*_unref calls.
---
 unit/test-hfp.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 0a6828b7c..9b4d60a3b 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -136,14 +136,14 @@ static void destroy_context(struct context *context)
 	if (context->watch_id)
 		g_source_remove(context->watch_id);
 
-	test_free(context->data);
-
 	if (context->hfp)
 		hfp_gw_unref(context->hfp);
 
 	if (context->hfp_hf)
 		hfp_hf_unref(context->hfp_hf);
 
+	test_free(context->data);
+
 	g_free(context);
 }
 
@@ -182,14 +182,19 @@ static gboolean send_pdu(gpointer user_data)
 	ssize_t len;
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
-	if (!pdu || !pdu->valid)
+	if (!pdu)
 		return FALSE;
 
+	if (!pdu->valid) {
+		context->data->response_func(HFP_RESULT_OK, 0, context);
+		return FALSE;
+	}
+
 	len = write(context->fd_server, pdu->data, pdu->size);
 	g_assert_cmpint(len, ==, pdu->size);
 
 	pdu = &context->data->pdu_list[context->pdu_offset];
-	if (pdu->fragmented)
+	if (pdu->fragmented || (!pdu->valid && context->data->response_func))
 		g_idle_add(send_pdu, context);
 
 	return FALSE;
@@ -726,13 +731,9 @@ static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
 	struct context *context = user_data;
-	const char *test_name = context->data->test_name;
 
 	g_assert_cmpint(res, ==, HFP_RESULT_OK);
 	context->session.completed = true;
-
-	if (g_str_equal(test_name, "/hfp_hf/test_session_minimal"))
-		context->data->response_func(res, cme_err, context);
 }
 
 static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
@@ -774,27 +775,17 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	if (g_str_equal(test_name, "/HFP/HF/PSI/BV-01-C")) {
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SIGNAL);
 		g_assert_cmpint(val, ==, 3);
-		context->data->response_func(HFP_RESULT_OK, 0, context);
 	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-02-C")) {
 		context->session.step++;
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_ROAM);
 		g_assert_cmpint(val, ==, context->session.step % 2);
-
-		if (context->session.step == 2)
-			context->data->response_func(HFP_RESULT_OK, 0,
-								context);
 	} else if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-C")) {
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_BATTCHG);
 		g_assert_cmpint(val, ==, 3);
-		context->data->response_func(HFP_RESULT_OK, 0, context);
 	} else if (g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C")) {
 		context->session.step++;
 		g_assert_cmpint(indicator, ==, HFP_INDICATOR_SERVICE);
 		g_assert_cmpint(val, ==, context->session.step % 2);
-
-		if (context->session.step == 3)
-			context->data->response_func(HFP_RESULT_OK, 0,
-								context);
 	}
 }
 
-- 
2.43.0

