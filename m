Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA154233D85
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954077; cv=none; b=b2pl+UFPmgZs0AmoHdOpzjTtzXc6hHYWlrsLJtDNp+EGNG61WWTl49sUgeDJqLlvK4DH8vS4cdoi3T1H15qH4m8Q0XVyONg4PZ50jeWpMXuePjLYACmqO5YWn1v6HuTcjJ7zIkumaxczByhiC+p+8lIVlDPtENIbaDECjbk0dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954077; c=relaxed/simple;
	bh=1qQHA3Y+RYnF0jeKXcKICtjEt+7l1Wc0NLAGvTBH1YU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTxMkXzXz9wiKEZ06+3bxB+CfI0jLP28OmdfxrA7r80blxbBtqN2iqLvOZrqQErCJxlmL1lncS/2j9Zz0vOYmsqurXStSPHs1/xAIErv+qBzE0kIy6LMCesdRcRtO8N7vEtL/QScnhZUH5UsBzPxnpJAdGQcz9sLY3X6/zji8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qD73kgUM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qD73kgUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757954074;
	bh=1qQHA3Y+RYnF0jeKXcKICtjEt+7l1Wc0NLAGvTBH1YU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qD73kgUMHUDmmtnxVd/REsGxunabZL2t1DPIngLSfRcWVX5abhrnbIbzPJRKrMyNd
	 h57TdmzMSlS9gQp1sEjbCL44kixD35R//0pvVhS0PT12wBpRVlbdLA9ctaC7RIaDR6
	 pDnnRUjzbDP990Mpim0sYLxzDTvh4WcalEsYcRYE1OxiTpx6WMGbgm6uAxBtF0yv4z
	 KFre9VCz0MAoqZQ48s9AYtpXbCEXf2Xz02Z+95PZ9tLmopVoBbRPXLl70S+cCWFYYb
	 6eVFKkF5vlh8M8Gonu9Ip3SlwPMjxkXPTbGEzdOMMtJbYhMWxPJmP2aRjX4nhTqF6q
	 l1+V+0iYqq0oQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-ed13-78a5-a1e8-7185.rev.sfr.net [IPv6:2a02:8428:af44:1001:ed13:78a5:a1e8:7185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F03EC17E132A
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 18:34:33 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] unit/test-hfp: Add Call Line Identification test for HF
Date: Mon, 15 Sep 2025 18:34:27 +0200
Message-ID: <20250915163427.3589748-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915163427.3589748-1-frederic.danis@collabora.com>
References: <20250915163427.3589748-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- HFP/HF/CLI/BV-01-C
  Verify that the HF receives the caller ID.
---
v1->v2 : Move some changes to patch 3 to fix unit/test-hfp in this patch

 unit/test-hfp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index f22a687d5..060230196 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -813,10 +813,44 @@ static void hf_update_operator(const char *operator_name, void *user_data)
 		g_assert_cmpstr(operator_name, ==, "TEST");
 }
 
+static void hf_call_added(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct context *context = user_data;
+	const char *test_name = context->data->test_name;
+
+	if (tester_use_debug())
+		tester_debug("call %d added: status %u", id, status);
+
+	if (g_str_equal(test_name, "/HFP/HF/CLI/BV-01-C")) {
+		g_assert_cmpint(id, ==, 1);
+		g_assert_cmpint(status, ==, CALL_STATUS_INCOMING);
+	}
+}
+
+static void hf_call_line_id_updated(uint id, const char *number,
+							unsigned int type,
+							void *user_data)
+{
+	struct context *context = user_data;
+	const char *str;
+
+	if (tester_use_debug())
+		tester_debug("call %d line id updated: %s, %u", id, number,
+									type);
+	g_assert_cmpint(id, ==, 1);
+	g_assert_cmpstr(number, ==, "1234567");
+	g_assert_cmpint(type, ==, 129);
+	str = hfp_hf_call_get_number(context->hfp_hf, id);
+	g_assert_cmpstr(number, ==, str);
+}
+
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hf_session_ready_cb,
 	.update_indicator = hf_update_indicator,
 	.update_operator = hf_update_operator,
+	.call_added = hf_call_added,
+	.call_line_id_updated = hf_call_line_id_updated,
 };
 
 static void test_hf_session_done(enum hfp_result res, enum hfp_error cme_err,
@@ -1024,6 +1058,18 @@ int main(int argc, char *argv[])
 			MINIMAL_SLC_SESSION('0', '0', '0', '0'),
 			data_end());
 
+	/* Calling Line Identification - HF */
+	define_hf_test("/HFP/HF/CLI/BV-01-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '0', '0'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', '\r', '\n'),
+			data_end());
+
 	/* Transfer Signal Strength Indication - HF */
 	define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

