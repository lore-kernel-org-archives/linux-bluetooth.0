Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917004;
	b=5EsrEd75D8YnESCdGHN8lPkDh/6/GLFcRrcWV+xVwFLTIcSRmWndakkn/yagHxnLNwyX
	 XvitJaSLU1m4txsvIxSZxvXmI1PUH/6UBF1IkIIohvqRFQgFo3moU/e8zglM0LlWgjgSz
	 mZBb4UqeEuFcCZ981TiAonqBiVu9Q72H2rFTiqG81Pd6LBeYPKcttyn02PjjEl/c8R0KJ
	 WdLHsOsoR9Ngx3DJzX0UYwn6Tsw8I8+nDRjcwP492YjFrZE3HIMjuG81JazBFCThX/qco
	 bmMAP3ZafKOSpvWoNgLqf/U6DVHZUal1Hmxa4GNXslqLF1hEUYrkNyOMgoJJcutykfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
	b=OxtIU1IGh4hkIV0TfRDrgtxa+5q0zDog8YNo0SL4x3dE7Wyp2Js92S/1823/DlfGiYyc
	 zRsP2SuGYONBp4DbG4GXWrjaN9qHEXPokUg8JdJSXjEIPqXSPsWuD0vqAIqb7PLD9c6Ch
	 xO2xfyur2HwK4+G81pGDz9y5NtTjAWAn1SJj5eP1NgJbBLuh28qV6c7CfFUZJegUWCuDL
	 swCCnbh7moPaEQIcxWRK5mrH/t3K4y4A/kvO3+6QFasEJv2hobxlclZAbvm65UBNvyP5b
	 f0u5mD/DsuIVe5VrY8C0Hke7U7RAspYnQOCgnFRBbe85KbcMPwvGqbmTZFhUU0Hbr7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyO9+s1W;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873D606A332
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E873D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyO9+s1W
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d06763335aso21844137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917003; x=1794521803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
        b=eyO9+s1WHvh43nPJIhTZhYdGfUH5AIZoDWNg3R/jecLmDSHRqUPHGOQ8TPgviZr5gU
         r2fGA7i6tedOX7kmCRFhuNGHYiIEwPEPoCdIin8bfxF5/w82gMJvgZJXdNa6Aoh4geFS
         cYL3MfUCcqNgfx1AkENKnc6StN9FKfyoRAi1ViN28/nbS0e5cBYF2lvgZKUq0QLJGeSr
         O+IH0raQfolzv8879Nd6FTI8HKeaCLrMaN8BOAQd5UK42LUwP7nhfudMsZcaTIrj6Id1
         R63Vjp0UVS37ZjIVZwBWINz4ODuJyM3/6wLjGZz8plObDQdaF0+TQvzBxmNMPrBBXdWc
         SJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917003; x=1794521803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
        b=e9Xc4Hwn9jw5dyDa+f1XMk0gvqSbtcd5tq97ucZyG0cvvf1HbGQQuWlkJIEBkU0Se3
         krN9H/hW7uSb0DzsJuDWtAywtCzzoATEYWgBw44+L9TFPy0pdDoB03z5qs04NE8ZqA0U
         /SryJ0hdPoXU3GEvU/oZJMaDosqoODqs1TT1IhxUEepdnmrY0kwTchCaEa9DgSy1MFYt
         S1xP1YUU1dOuxq3zebpXA5EDuh+XEh5k15tT5pvWOpNsjAzM+1jxhO1r8ED0pgGQcMRK
         8UnYDJ0amjofzjTMRSzpc4/m8aeY0k/Zz3jA1JxyD8EB/cPCsQgXA/jBhVAqXdlYRTs8
         ZaoQ==
X-Gm-Message-State: APuU4Z8boicj8LIw/xFVa/sVk9LWyACCMrgRWdxVfjBfdF9MT8NaagrW
	LNj1ekaYCRAbOtzb/S1DwoWafXALT7wXM17sdtaEebsLn8NGNVO/7w6fZ8QlLw==
X-Gm-Gg: AYBFou0dY+2WjYYYHXyP8lH8dY3MINSq3xN8EZUkor3xDBjbzE/+e5rPFqL6FT4fx5g
	jLJuN2hmQUQQkTU5rlAcrfi7qYQZP6mytemsZbku2pT0CmDLH4YxWmLi0QeNZRszrYR71wsjBSE
	aNZrPZ/P0D68NUNo394c/FaJdcIxg3bESoYSqJeTylj8Oj6jXotFBJkI71z5yhsMLk42Zp3iCIy
	NpB/qFO0tBRO3FIDbfkYc/DfI6MDQIQNnf3RgATUo/lYbgWcnzM9vHEOgEfnfGGJqQ5CrH0UFrh
	KC788bDPj/KtG6zH8X9yRM7BLLDkxmgIfVzS7rnOcTqVgy4lMQwxWeR+92+dAk4AiP28qsTFwE5
	9RwBv14dj/F+NXge1RqX+nHIzaHZ2swecLM3j+v72McMRlvwSeeVpWrzsKl8+7dIkDjP3TvX+YQ
	iYDGEw1K25uCbfrdid6ABH3i8UWRHQVq1kD+JS1K7zsI/1xgD8AcDetxa0YW5Fu3cvu1Cga80dv
	m5oXQ30GZDvn6Ts8A31LTYBHXu4bVqqZnnM9GuE+kcG8u8eNc6MG6WcP1nz/tTEqa5uIWcbYnYH
	+cLOP8ymwXjrG7j8hWgiak7IrZw00gFCGOKNaE4H2mWMWK3QYVvGMXbX17T6H6E0j5szwanwsBy
	xA2Vam72tKIWtgH+Q7wdEK4e1YHGJOl7Z7TEIOzYJtkzmZ2d0LHrq6lnBj7j8tirGG1FQi50W9L
	fLRndL8MgjQl+7bliO3vDEGDpj
X-Received: by 2002:a67:e114:0:b0:7cc:a3a4:2a04 with SMTP id ada2fe7eead31-7d2a12d6d07mr667641137.3.1793917002744;
        Thu, 05 Nov 2026 14:16:42 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/8] unit/test-gatt: Add malformed Read By Type response tests
Date: Thu,  5 Nov 2026 17:16:32 -0500
Message-ID: <20261105221638.2332398-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
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

Add tests for Read By Type responses with invalid Attribute Data Length,
truncated data, empty values and an empty Server Features value.

Assisted-by: OpenCode:claude-opus-5.5
---
 unit/test-gatt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6d6d0c73ed40..26768e1aca82 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2064,6 +2064,18 @@ static const struct test_step test_read_by_type_6 = {
 	.expected_att_ecode = 0x0c,
 };
 
+static const struct test_step test_read_by_type_malformed = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+};
+
+static const struct test_step test_read_by_type_empty = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.expected_att_ecode = 0x0a,
+	.value = read_data_1,
+};
+
 static void multiple_read_cb(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
@@ -2146,6 +2158,7 @@ static void read_by_type_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_iter iter;
 
 	g_assert(att_ecode == step->expected_att_ecode);
+	g_assert(success == !!step->value);
 
 	if (success) {
 		uint16_t length, handle;
@@ -2957,6 +2970,81 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
 
+	define_test_att("/read-by-type/zero-data-length", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x00, 0x0a, 0x00));
+
+	define_test_att("/read-by-type/short-data-length", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x01, 0x0a, 0x00));
+
+	define_test_att("/read-by-type/missing-data", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x12));
+
+	define_test_att("/read-by-type/short-handle", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x02, 0x0a));
+
+	define_test_att("/read-by-type/oversized-data-length",
+			test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x04, 0x0a, 0x00));
+
+	define_test_att("/read-by-type/truncated-data", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_malformed,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x03, 0x0a, 0x00, 0x01, 0x0b));
+
+	define_test_att("/read-by-type/empty-value", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_empty,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x02, 0x0a, 0x00),
+			raw_pdu(0x08, 0x0b, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
+
+	define_test_client("/read-by-type/empty-server-features", test_client,
+			service_db_1, NULL,
+			MTU_EXCHANGE_CLIENT_PDUS,
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
+			raw_pdu(0x09, 0x02, 0xff, 0xff),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01,
+					0x18),
+			raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x05, 0x00, 0x08, 0x00, 0x0d,
+					0x18),
+			raw_pdu(0x10, 0x09, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x09, 0x00, 0x0a),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x08, 0x00, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x08, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x02, 0x03, 0x00,
+					0x00, 0x2a),
+			raw_pdu(0x08, 0x03, 0x00, 0x08, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x06, 0x00, 0x0a, 0x07, 0x00,
+					0x29, 0x2a),
+			raw_pdu(0x08, 0x07, 0x00, 0x08, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x07, 0x00, 0x0a),
+			raw_pdu(0x04, 0x04, 0x00, 0x04, 0x00),
+			raw_pdu(0x05, 0x01, 0x04, 0x00, 0x01, 0x29),
+			raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),
+			raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29));
+
 	define_test_server("/TP/GAR/SR/BV-03-C/small", test_server, ts_small_db,
 			NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.56.0

