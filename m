Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990035;
	b=AprXGH04doJwJ71nzJ+X0tGmZ1apQos1KsmBNQ0D+MlhYDO2gnddGnnqeJLe5SMtsEDn
	 wzrXA/Fa3bmifLrvd/101r5x2cX6WSl6GugX3JVdso9fhFp5LP3RhqPNOs3wmTiaz6x6H
	 X6V+NWH/Drv5smkT2rOAHqqPtw2OlCEByPgM6gUKXfXVLxwOlgteMOI1zi/+3oPQPcT7m
	 asG1akHqqLNJOYFczuDOAVgotM6bjNfVIb0I91mDnCFc1B4c8Kf6U4IluJwkjGUNBwZpn
	 iwYjwXFvntDR9kURm+hE0zV1OkKY6ZxauO1HNQ76xboe+oupnrCOmhxE/rvMzLRnZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
	b=AdnKrlXNNoDsGcyM4xEL2XVmaK2PnEjMxWmQmFNrAdNHCY/3A0u+elZD0P7mFGf0avV6
	 HFX19H7FFzkSwMuH2+ZdaEpzGk4ItmvkimGIq9peZlQVICCW9/9+cLiGxaPFoZdR4hwZv
	 8vLWgEO2pJKr+k/Corr7QpadztF2D1UVZDvT91wzqKEb1NyLtaYJCCdNgIPjLLTtrFaES
	 vMAhJO7pzs6pyyH+poK1YT+TIjh+aIhtyDljWmZF7JATTS7o4Imp5A3XaBXb1dbCaJ3zk
	 5Jv53Uu6ZpVDmaMKbvUFSf3mayYCeSnoSxl2xMPD+M7+DMf2UW1o+x2suxqNav78p6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wN3cny6F;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D1606A332
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4D1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wN3cny6F
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc81984fceso346941137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990034; x=1794594834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
        b=wN3cny6FM8RtzvgPE5ctPTH5FeslKZvrl7Msvl8Te1/WRm4Y8512w6tYFKq+gFXaYz
         lJbSVg+c3Gbiip3+baaDKI/JEqoKBQHzh+BDLnhVqn5WNPmLSdRNdtNpPRd0dmLELHW4
         7iW/1HU1G/drQaCikRJ6NlQliT5Vmbr8uBEDEDqRTDJXYMLmfJs4eIR6yTW6CC+MAdHk
         EjjtOTNA4ib/wyRJ5FXyRDCRZTlowpL+bIJjLhc7ddDJrtMA+rQhEt6Rax9rtlN6Wbo4
         O7ysP4EXwZjpKa+BvQnjKfRVqRTsOPu1w1TWlTyjXcjiW4G9n+vmQIoLUXOOHr4Zjy2Q
         Dfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990034; x=1794594834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bzS+SjN3Y8Enl5m9zEwLGXmnA33H6ppVXksHbwSTwdA=;
        b=FfZrHWrPBQVh3KZfH+q3VZKAo8YNd21vBjOKMO/zdmzulllGuuSFnX3v4FdlxAbqZD
         JlbPYlpjjJqN2c7YWlkovlRfxcrtb06rSB+ALuK/oQ0erQRi0eflC8vkKtuonLQ3S7aG
         bJ0Q3RQbbsntXa7TjUYsThbkzN25gOLKWMQtu53QcIeJ8ymtQ6Wtvu4cpJxpK9g0zybA
         ZhTKdGppgzRBmGSiLQF6Yn8K5F2deNJ081Owi+uZiTHERFec1FbtmAXtCDpwQqbC/Ap7
         OoefiSUYHIbi11DQsb+uX6eU0D3cAj9Mrk/IF558jYZ0HnW2ek5zDmSrck1m8sLfb2Fi
         I8Lw==
X-Gm-Message-State: APuU4Z/TS2y5bZ1kPKMKtHu4MWK/UyHi6EM5V9mEFBBz62jcZopjeXAu
	geIBtj7SIRmYnzmw2Yd7tA6OQhRpsUUak74T8enWkrm1BmQMqTC9hZoNiJSvXQ==
X-Gm-Gg: AYBFou2k8YBNy9D01P0Uth/7XQaACqqJ5zzwaBe7ufo7B6e8CfXp1lLECLkUhtmMVni
	Dm/8RY2Jn7tCmK9FJ7WmRgyJOnNjboDHxkbOTehXF1+dAQAbQKX+HpbflivAmmaKJMimW7p0cAd
	J82u0m07XfDD9DzA56KD0mOE0Z72kLsAc6XQxI3/zlBDcoqiPxoenApP/eSecQyBzwJnTD/S2AZ
	BwSJENqieU1mIXiI6Yrm25S2P7sAMJPOYv/4T4/Ed0yY0FUJgJBNfpMoSzXu+bNtv+rAhKeHNuU
	Oohxh4hwHfKvx5IyyBITxESHpGxWDqu0b0axPbgX2LgoU4F81AV8sJLcrIdHXQsL/FN69yIb+BR
	mVRgipVLN77lAwsozdXo7Z48N8PnRVv7AYoFy3h70xDbfx0+C5btJVPtygwLHTnhMQZ9md+IjqC
	x+kj/Aos2khuwU10sTMTUnGOg4QpRfMgvL+lkspCjaM7Ktym0F0GDyiKXYOnLxFTN0cLNS7YK0E
	StxVCE6E18aoGNyzGvNlAqQHmE3/jrJAn56qI/x8jbegY9+AkESbc5DVVztncXjn6OfEej3DyZ6
	ax8EK9njsOIgTvxmw5xpZRe5sQ/jX8+0n+r9syTYICps57N9UgdcZ0di13wnsRpX0/KFURVFRx1
	YZ69/yj+uzP5x2elmlfHKnTfOKGh0hZK7VRTFKB8yMBcE2uPnj16cM9mKQioGB44AuZTgj4nv2p
	TaW2E=
X-Received: by 2002:a05:6102:3ec9:b0:7cc:232b:f5a9 with SMTP id ada2fe7eead31-7d2a163a36bmr1621357137.24.1793990033835;
        Fri, 06 Nov 2026 10:33:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] unit/test-gatt: Add malformed Read By Type response tests
Date: Fri,  6 Nov 2026 13:33:44 -0500
Message-ID: <20261106183350.3155282-3-luiz.dentz@gmail.com>
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

