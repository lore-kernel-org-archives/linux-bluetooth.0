Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6C320CD6
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586646; cv=none; b=UUUaCKtfe4WEh/UrJzmHxSpFavr/RkZl0chK7NVvtEdopUw0Qk377v6cXA3aLAdGc/MWYJGEU3PqV0YIJz/sEUMANGVdU5OM6lHz4RaiJFBsf7BsWsVklUcEHU95H+vMhrReeu9GZUNhlSJNYaFkOSW5KM3Ye7uAKtSjTPdpZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586646; c=relaxed/simple;
	bh=vDZExDsYvd85jrARvydvhIWPHpWJS3wS6H6cytQw5Cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlFCmrOQyolibOyITKDQpkju4scSvZF7NA4nRvFwYUx9zZxKjLNxEDCpdyIcLroUMGh8RiedHaSuJ3szzsjPnvjgqi3ze6V6C3BvXmh1YrtCkruQ3q+NNrnkyEO7ABRMoQAJ9rTcPta6aS32oEGt4DWxBU8sANao/0B+bMvTNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GLKzP3K3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GLKzP3K3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757586643;
	bh=vDZExDsYvd85jrARvydvhIWPHpWJS3wS6H6cytQw5Cw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GLKzP3K30dyVDJRy6CsHHZK7Ojo8yeExu+acGaEiT7Ou5MJT090wbhGgxSWSvH42P
	 RuAXYbDF8I29+JfPCHZKSwVw2DmnebpkTgKYwIqm6FIT/ckAlET6U8S1TSSJDCxqtD
	 cCqUM7bxRS1MFcSfravGFTeNOjVMrsAAMJC7aV/ukRVQ2hx+WBWhQnC0oNK4b7MfPz
	 0z+nQC9wjY1pUaoLABFxKw7oVLA18GKVYFn/FIanMkSdGkcgvCPl4x6P8W7B8Mwmwh
	 4rui1VTv2zQENYUztTBt2+Pfd2sp4xdqg3ZkqlBcAbHISWsKs8hUVM1h3H5YAjwn04
	 lmWXmYEsuN2fQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-E0e2-6802-CeeF-9413.rev.sfr.net [IPv6:2a02:8428:af44:1001:e0e2:6802:ceef:9413])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F026A17E090D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:30:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] unit/test-hfp: Add Call Line Identification test for HF
Date: Thu, 11 Sep 2025 12:28:40 +0200
Message-ID: <20250911102840.2090361-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911102840.2090361-1-frederic.danis@collabora.com>
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
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
 unit/test-hfp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 8ab6c7bf5..060230196 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -730,7 +730,8 @@ static void test_hf_robustness(gconstpointer data)
 	raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
 	frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
 	frg_pdu('\"', '\r', '\n'), \
-	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
+	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
+	raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
 
 static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
@@ -812,10 +813,44 @@ static void hf_update_operator(const char *operator_name, void *user_data)
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
@@ -1023,6 +1058,18 @@ int main(int argc, char *argv[])
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

