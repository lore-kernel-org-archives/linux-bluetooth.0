Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177636CDF2
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784403786; cv=none; b=F3wN37ShLCWVUhb78qByDR20ueEAxwHNR73fR2t3lSl909doZhy0XtvY/mwIImmBJ91YizOSC/SraLmC1ZfdZ3CDKajSKgd7kTp0KZF96yqQX30gVlTtQik593w6Q+8wHsWCCWy7KaIXNO32CNOcyQfHkEPG8pJ1XDD2rPjvsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784403786; c=relaxed/simple;
	bh=WMnsRTAMumqPWG1UO2rXHCJf8ebEPm0QdryDqiML71g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqitvhSSkSe6nHQ48B3smTsgtfghC5K+rC6LURUM2ZdKR+WazMc8/To9NBh9vgIaOUzBl1rQZmbivKYVjMIVkRQbg8ZukC6oQ0j/hFI9sBYN8jh2O1N/KmoOtabVM4LpmwJp5ApO8SvE+X0dZZ5z6JnouDjPsQ/W/VYfA6ZCjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com; spf=pass smtp.mailfrom=pipobscure.com; dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b=T5+ac14x; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b="T5+ac14x"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h2cdK0p5ZzMlGx;
	Sat, 18 Jul 2026 21:43:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipobscure.com;
	s=MBO0001; t=1784403781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPVeJQYAyr2fJsaE0NTM0UNUXNov/vkXJ0nUaeOHlsA=;
	b=T5+ac14xxch1uJqNl+GYTbSJn4XVBHttbnQgkB0nbV0lIJl7FKLYOEpT9e9pXTl2LK3P5h
	vxK+QPXpy2AHFF6d81c813eyVWR12biqNweLc2lwCLzQdAaf4A0aSgEBfeEXaBbQquD6R1
	BpOSC4Q/0SkyHapAuxfjAyoDF05mYa/e25mYx/4KPlA4va0+wYJmUO2P3HHwrNGoHD1jxy
	Dr7Ycwzq7JnY1RkIieTjIQaHubXKjzw/xfnIVKaJed4zpBqN73T2yaRijUj795i6x2xK/C
	nmpfCGtEv4JMpE/sZb+fxDhS8Xf+i7ZgZKgdcwquHT8sKVO/fBt6zEWxCTXDWw==
From: Philipp Dunkel <pip@pipobscure.com>
To: linux-bluetooth@vger.kernel.org
Cc: Philipp Dunkel <pip@pipobscure.com>
Subject: [PATCH BlueZ 2/2] unit/test-gatt: cover no-auto-sec on auth error
Date: Sat, 18 Jul 2026 21:42:30 +0200
Message-ID: <20260718194230.35959-3-pip@pipobscure.com>
In-Reply-To: <20260718194230.35959-1-pip@pipobscure.com>
References: <20260718194230.35959-1-pip@pipobscure.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for bt_att_set_no_auto_sec(). The client reads a
characteristic and the peer answers with Insufficient Authentication
(0x05). Security is armed to BT_ATT_SECURITY_AUTO so a reactive elevation
would normally fire and retry the read, but no_auto_sec is set, so the
error must instead be delivered to the caller with no second request on
the wire.

This is the /auto variant (which does retry after elevating) with the
elevation forbidden. With the flag honoured the read fails once with
0x05; without it the client retries and the test aborts on the
unexpected Read Request, guarding the fix against regression.

Assisted-by: Claude:Opus-4.8
AI disclosure: this change was developed with the assistance of an AI
model (Claude Opus 4.8). The author reviewed every line. The test was
run against the built tree: it passes with patch 1 applied and was
confirmed to fail (client retries, harness aborts) without it.
---
 unit/test-gatt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 535baaf..3929bb9 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -755,6 +755,22 @@ static void test_read(struct context *context)
 						test_read_cb, context, NULL));
 }
 
+static void test_read_no_auto_sec(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	/* Arm reactive elevation (AUTO), then forbid it. An Insufficient
+	 * Authentication error must be delivered to the caller instead of
+	 * silently elevating security, which on a real unbonded link would
+	 * start SMP bonding that nobody requested.
+	 */
+	g_assert(bt_att_set_security(context->att, BT_ATT_SECURITY_AUTO));
+	bt_att_set_no_auto_sec(context->att, true);
+
+	g_assert(bt_gatt_client_read_value(context->client, step->handle,
+						test_read_cb, context, NULL));
+}
+
 static const uint8_t read_data_1[] = {0x01, 0x02, 0x03};
 
 static const struct test_step test_read_1 = {
@@ -795,6 +811,12 @@ static const struct test_step test_read_6 = {
 	.expected_att_ecode = 0x0c,
 };
 
+static const struct test_step test_read_no_auto_sec_1 = {
+	.handle = 0x0003,
+	.func = test_read_no_auto_sec,
+	.expected_att_ecode = 0x05,
+};
+
 static const struct test_step test_read_7 = {
 	.handle = 0x0004,
 	.func = test_read,
@@ -2803,6 +2825,12 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
+	define_test_client("/TP/GAR/CL/BI-04-C/no-auto-sec", test_client,
+			service_db_1, &test_read_no_auto_sec_1,
+			SERVICE_DATA_1_PDUS,
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05));
+
 	define_test_client("/TP/GAR/CL/BI-05-C", test_client, service_db_1,
 			&test_read_6,
 			SERVICE_DATA_1_PDUS,
-- 
2.55.0

