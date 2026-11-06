Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990037;
	b=x2zrs3HOzUkLJcvJXWjoVKDPrn0bEfrw+JGA9mP7dpVPO+ngxfeCO9UoH49m+AAENJg1
	 ambtocUm907Ti95IdzDfsRUnkGKk1FN1syvvy70dOnDOj9ImLP8Xwikhgb7RrM4/7EIn1
	 BGm+8RLGwOfa0ylNJmrWYkAA+0dRi4AottNdrG/0PPee4ufQpxFPNi8mvzxh0+GUbID7Q
	 1vA8/I1d4EF6rE1dareJRrs3pOPUnzcmXgKuv4jJcPaFsClQAMufBULf1OmizEBUyP9v2
	 YMfOO4IM3UidMZnPQE3Up2VV44af9jl4PH6WN/YY7nrD0vZQH8e+fsU9qT3AIDaER5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
	b=W++Y1SU3S+9C+HzdixKS6IrWmu54JJsxoq+DuZObB304bpQWOC57PfJm6+HBx9SIc3Tx
	 IhDv2WBnHRPIl0iztJYPDivU3+soAXlULLFr9b8tv++qKr1zmTkxhkjH3GIIex40d4FUQ
	 yBwt8m5H/h81tD3Mg9ogzlsVo6dWUJ+Yb6dub05yb/gM2HkKlr4/B9ygnMOdRvLmfoqSB
	 2hJuPeVLHzKhi/bz0Y08VlK373uzySxKD5Kl/2+7MZWbxKZXJDj6XviwwvescS4FMmCJ7
	 OV5TW6T3ZcR41gSdkqmHW/f28CrMt5pkMNtb0/IzrHLox9QArzRtmUos/d+31kJ8FYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ajosgvlk;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E71606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E71606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ajosgvlk
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso351164e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990036; x=1794594836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
        b=Ajosgvlkl2jBPFEHH5FxXBxcrw7P3HLU7dxTKsikvvih1LMfPl6tfiq4FPdRRN3qvb
         eqpDyRiu4TbpZMK1LTgJpdfjtPw2VTigZiDKZ+9frDjebzoHKjcCNtrVpK9KjKSTugUM
         yzqH3gGVX720d9SNTDMYHzY8btMMOI8uqJAgR3niIvnPeyKlUd/e1XXLlA/goYy3UqYU
         P+oe9d6hyhq8jhD7rc3SYxfikgyrD3ykwXEqwaCU/qJGvV4VSHbad8chYgR189RXygdT
         UfBfsxpjFRCXorjdmGXsnqIl+bi9PMjurX78icJw7iTZV2rYL2k0P63tyJl6nkifZCzr
         kKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990036; x=1794594836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
        b=xOVHGR3EKT1+0ZU1TyHN0vfYLzwSuO4/XAJcc3eSDEbOboz3a54KsZC73OfcTITl9Z
         5bWX6kZ1gGmgZpHxOTffuUD9r3Be3f/Gvf97df2EDwZ4t1pflD516koXrriOOH7dPY7+
         J6tc5yOo3V8DxIvne2hcBNFly8zHe8kUHJbgMX+MwpplcAMkEKqBVQkr4KL+luBeg5A4
         Tutg43dIkU19RpT2ZQKUMY1Jvcmyz/e7Pq3gK0mMHNH7bMApp9Kt9E4H61o9f5UIE8Fk
         Vxel1mjStaXiQ3qbzC6yxlWS70Yi09535XvPAjUnFU4zDNB526I/II0rIQNFrC3i8pkS
         uBtg==
X-Gm-Message-State: APuU4Z9pGB5oclXv0XUTIXeahizTqBamW4XbGYMsBJDaxabnn56F+flz
	h6qiYZbn2+2GiQVwGdflkWnAnqlGPBIpFKAFL8O5u37kCZyTVba1S+v5YIq07w==
X-Gm-Gg: AYBFou1xhUf+PL7x9l68GHfc7GjKvUsIwgnsSSDfO3kUnbV6aQa5/kQYgaHXhREYAkY
	LSJTi8S93+SSKSxZEekNfEOWe46WNELAoKT+Y13C0lBBBMAnc1DpHMiWcOZLnFMT3PkJibXJ7Vn
	oLpF//o7rsWWIA/EP7z9WTyOnSVNYMH96EhoTrjgcwayDW9IdKYpMIoykOlQO4Bxd9H4KeTV+8A
	VC8xyErKOgi7czqCVynezHVI99OHlfFEqPe0VUI3QS34U/Z4bvgKFwY5N2aVtK+txEItPuy7xWy
	vYaIFdfCYoRVFsvabuZF4eV+fplVrXNjkomLz7otC4037u087+xa7T6DvwPwKBHYeJN/sFAHyQ0
	5HsNg6pGkGf6f90/X8CyZF1dXLGgQOT1FE8kLV71LOO3R2tI8VMbbdOT4XLdSrWwaQt0Z+varTh
	nGMXqfJaTqsJ6h3MlPJYtOd7F8qGlzzdwz/Qfa+tRsdwH67I5y3yf42N0dsygwUaFibKVerwS8M
	PkQVXo2v0JSMMN0NYNzmMLFRKUI0Pev7FiIL+TFytQZA3NqlFlGNsdcYEMwe3WDcrPajkKRkvgH
	KMx8QFYzb8MU3CEml/Gnvh+3jEsQYcZlANpR9qezQa+5pn54EEebFfMui87xh95oAbcRGBEP3rS
	sQ2skt3Fny7P5S3ijNDzEAo+E6YxLPH0ykqTRcFIuKE4htqcOiL7w7IRuAlr83wukn9U9oKVLs3
	7V1kZggKKw2GmLc1/nA6WUEryS
X-Received: by 2002:a05:6122:4201:b0:5ec:3e18:a8da with SMTP id 71dfb90a1353d-5ecc441b1fcmr1779606e0c.17.1793990035270;
        Fri, 06 Nov 2026 10:33:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/8] unit/test-gatt: Add short notification test
Date: Fri,  6 Nov 2026 13:33:46 -0500
Message-ID: <20261106183350.3155282-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Assisted-by: OpenCode:claude-opus-5.5
---
 unit/test-gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 26768e1aca82..d032e7598f9b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2334,6 +2334,41 @@ static const struct test_step test_notification_1 = {
 	.length = 0x03,
 };
 
+static void notification_short_cb(uint16_t value_handle,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+	static int count;
+
+	g_assert_cmpint(value_handle, ==, step->handle);
+	g_assert_cmpint(length, ==, step->length);
+	g_assert(memcmp(value, step->value, length) == 0);
+
+	if (++count == 2) {
+		count = 0;
+		context_quit(context);
+	}
+}
+
+static void test_notification_short(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_client_register_notify(context->client, step->handle,
+						notification_register_cb,
+						notification_short_cb, context,
+						NULL));
+}
+
+static const struct test_step test_notification_short_1 = {
+	.handle = 0x0003,
+	.func = test_notification_short,
+	.value = read_data_1,
+	.length = 0x03,
+};
+
 static void test_server_notification(struct context *context)
 {
 	const struct test_step *step = context->data->step;
@@ -3481,6 +3516,21 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	define_test_client("/robustness/notify-short", test_client,
+			ts_small_db, &test_notification_short_1,
+			CLIENT_INIT_PDUS,
+			SMALL_DB_DISCOVERY_PDUS,
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu(),
+			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(),
+			raw_pdu(0x1B),
+			raw_pdu(),
+			raw_pdu(0x1B, 0x03),
+			raw_pdu(),
+			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
+
 	define_test_server("/TP/GAN/SR/BV-01-C", test_server, ts_small_db,
 			&test_notification_server_1,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.56.0

