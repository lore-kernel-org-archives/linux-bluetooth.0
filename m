Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD8433E7D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950644; cv=pass; b=j6tjHBlgoli1mGzMzTngq+bMGe2vPoOuLkFpqh2GoRcBZhJJ6IYua2Q9BfBgWDOS0L+CGteNRCAp5EYSN+5OygZN9lNEUIfD+aP1gyVfxAX4/DiRN+RBiYcXtuEvE+Bsi4Q1SCKYvwbYCY7FMQbfGpiN7SXqLCWWU3k4x975QTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950644; c=relaxed/simple;
	bh=Iuc0JAF0y9twX0FlX3O2JRXMiLqqzlx/Jc1ZOxIZ4wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZGwkm6dgcruzc9UIK5XnxQJ+WtcYudYtxydjM2NLqaN9EGgbnM3lzZYk+JwKiDY7yXBX73xofWVCZB/doiNrCgzDdhdz0Y194SgBNqfp3AVLoKjn0Uc062WBXIljJXR7TWg0PPzVfPxf7uNaEM18FOveLMStvkh9YMvL1JCApA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=f9P4TLSW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="f9P4TLSW"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzP344FdDz49Q4V;
	Mon, 13 Jul 2026 16:50:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783950640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI8xNkJSBYRMGpW0XhvamH/MDVvPqmR129C+CefdCr4=;
	b=f9P4TLSWwfwAila0EPZFVDTgZ3ycBddOQMoiInc9DD/tJAFy6cFQ0W1ieg8zlrTBh8ijWt
	MIFadboIN7TQNDKlxuHt2JHm/Az3NRRZDgJk3MFsblCrVANUuE8+3XfEddUyomJQHKluyK
	YdUdPxZZLiwOXuJ+noMr0A/Qx/GsVrCGWkJ89l4D9Z+Yp9Wa75xdTOf0/AaHRGMz3K+FpZ
	wXZFUMaKcjhS/OavUkfH5OsnUPExPLgA0VIQeGEvzlqfvYhRe2EdhMyfyLZ6kAZUT20Ja3
	zQI3PQ+lFq4EpmPnIUSpYPaYYKV2kNeV5wbuvZYjMNyOgju7ntKc7gxqI2IBlQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783950640;
	b=GGHOH76dy7dEzSH0E9giTJcYBfJFX9j+iYChLpWtTTI1YnA3czNdwZvuZGwZwu6VpSUJrQ
	AfBReN5MP+bAVGdmSAfQytYFlfm9suGoY6OSZpUZLJA2tlrbP46Q+MPr8pbO5b+71nIe4f
	JFNtXZvQUge7JMzUUdoKPfZtrM2OTV8yfaIXXOVyrnZsjwgGmZG3hf15SR/2zhj49NC414
	OqqymUqmg/ProOijnilT4sgamhd+TgDUW/Kmt+cbg/SmWwtmWB14dcwnYpRDljaRJ0CcP6
	fxED05RbSXx02DknY/QhQ405gWb8f6526nflR2OsijH9xpQQpy9uNUPOTBZkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783950640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI8xNkJSBYRMGpW0XhvamH/MDVvPqmR129C+CefdCr4=;
	b=clFR9DoooX298chwveXRpIYh4cc/ARJVRv13lYdv+ik8kPPPPhDY9SLnR5N8dMdJx+oQm2
	qTTs0mzW1AuwDLwdlkOSqtttD3Md4lahynqSGl1dq8CeQvuq8nGh7/UNkK6ktQ6BPbxwDd
	ryhGsy1AtNNtyo+O6kGAiLdwPfCocLOM0oRPwqIy5JIETSJDKUMJzZpsKFnekXXDYJWDBh
	VRImCnxIYyRzplhcON20qtVPnEJolDqzFkzasUVFbOwOeUpuo1bWfSzq4rsXxwG/pL38+J
	+JDNOdaWkd/I53dFILMvCwC8nwC4ClNx55juNRXUkM+mFj1HUUtwyBV0sxII4g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] tools/6lowpan-tester: add test for VHCI teardown without disable
Date: Mon, 13 Jul 2026 16:50:25 +0300
Message-ID: <44fd75c5d99186b6846e175f16867e19bd0c9242.1783950503.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
References: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check 6lowpan teardown when controller disappers with active devices.
Add test

Client Connect - No Disable
---
 tools/6lowpan-tester.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 738714d68..a8faf6eb5 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -76,6 +76,9 @@ struct client_data {
 
 	/* Interface listener socket type, SOCK_RAW / DGRAM */
 	int sk_type;
+
+	/* Don't disable 6lowpan before adapter teardown */
+	bool no_teardown_disable;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -264,6 +267,7 @@ static void test_pre_setup(const void *test_data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct client_data *cdata = data->test_data;
 	int ret;
 
 	if (data->io_id > 0) {
@@ -276,11 +280,13 @@ static void test_post_teardown(const void *test_data)
 		data->packet_fd = -1;
 	}
 
-	ret = write_6lowpan("6lowpan_enable", "0");
-	if (ret < 0) {
-		tester_warn("Failed to disable 6lowpan");
-		tester_post_teardown_failed();
-		return;
+	if (!cdata || !cdata->no_teardown_disable) {
+		ret = write_6lowpan("6lowpan_enable", "0");
+		if (ret < 0) {
+			tester_warn("Failed to disable 6lowpan");
+			tester_post_teardown_failed();
+			return;
+		}
 	}
 
 	hciemu_unref(data->hciemu);
@@ -317,6 +323,10 @@ static const struct client_data client_connect_disable = {
 	.disable_on_connect = true,
 };
 
+static const struct client_data client_connect_no_disable = {
+	.no_teardown_disable = true,
+};
+
 static const struct client_data client_connect_disconnect = {
 	.disconnect = true,
 };
@@ -653,6 +663,10 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 			data->dcid = 0;
 			tester_test_passed();
 		}
+	} else if (cdata->no_teardown_disable) {
+		data->handle = 0;
+		data->dcid = 0;
+		tester_test_passed();
 	}
 }
 
@@ -708,6 +722,10 @@ int main(int argc, char *argv[])
 							setup_powered_client,
 							test_connect);
 
+	test_6lowpan("Client Connect - No Disable", &client_connect_no_disable,
+							setup_powered_client,
+							test_connect);
+
 	test_6lowpan("Client Connect - Disconnect", &client_connect_disconnect,
 							setup_powered_client,
 							test_connect);
-- 
2.55.0

