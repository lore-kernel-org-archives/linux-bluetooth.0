Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553472;
	b=MQAvHJbFrrLrGVXlfk3JzSY5js9iSnENY1uc2uUc8GAz5yldSqXF5Le5lKGBclInAA/K
	 Rsflis7GihNXKQXmmUOczHdlnXhFnOGhjDzj6xq/t/KQ+4Mc2JDA/SL5IuuMpnCKwhOWT
	 qh2FAGJ6CymtcLuj4foHFU6wdRTaJdZmOtrde5KF6iFOMBQ9L7Mp7HZWGdgZNCw6A9DvZ
	 SUzaQxoXFyEaMFBxjhkLhCn6dzcZhCYxvGH37HtWdYK0tQu5ZgLHftYWeGTAL0OG2dJlG
	 g8IoS56D1JR7q1DDBep2QkpoFDlORq9kvJ75KpOwFydHmRDsouB7iH3vQ6KYr7dguDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZBEOVCUIdv4jiYP+Y5y/zvHa0N4iK+lr00BBKEZiCXA=;
	b=kwVR8Bq/0I1veUUKBk2Jot22qsYjvjiRZumUrSxkEIIkYVxPU2SB9+aBdqvd94KaQ8v+
	 szJqJT2xbzcRn4tHHYO3xjTv8Q3J3DMsZnVu++1xJwdkNhIFB90xRigrO8KP/i+oiT0Oz
	 M8VMn+lFuimy0TdGwyqyIuIo9OrSANlNP0bs+I58GZ0kJAP43TbrMAwaJtHO/k40nTC4H
	 RMVPFnMcIFoqdAvUuY5zUAPVChwYCeciHAm4e0Emg1bn0GEc6gyWR3xA9cbJOiwLuRefR
	 2S4WVW7sEg8ER7wA1mAgWBMLtrJWVS7XsJhwyqaASkm3Yvn9NOyiKPpH9wMHCnRlpqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GlswI4Wy;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C3606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C9C3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GlswI4Wy
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso1567839241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553471; x=1796158271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZBEOVCUIdv4jiYP+Y5y/zvHa0N4iK+lr00BBKEZiCXA=;
        b=GlswI4Wy2KqbZBCA25jigxe7u1v6pPu+5y7yli7m12xnMauEGS8D84/0KNZp2qUuih
         Wf7WjyOhPhsGUItx5mRNO1U2dTtJlkd8SseEPcbYFCLHtgQLD8OI7VSEcQb6eq44Kcvs
         0gGM7vckdEtvu7txqQJzLtGpguYG+YvS5LQ4DwTOv2G/G4ZmonezJ66XESoqTkuBd78v
         Gh+7iDA6nFTsMGoiXEoKwVM8/b1m7fqwKGL7WRJG8g6vwq73ytQRBxUvwBDbn5xegQ8V
         YAlIDAONU07M9d6ydDKlQGKpjomC5KulxJ5Gn69QMXywGD1kzNGuGXqCzaoxIDZjFhCx
         Kmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553471; x=1796158271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZBEOVCUIdv4jiYP+Y5y/zvHa0N4iK+lr00BBKEZiCXA=;
        b=Uv5aO3A2W01+upyAUvE1xqn6KN5tWZ3enVoxsxuqTD8FQ/AJiGbyPSm/rp22+zy8OK
         lzFBMLn2q3s5A6ZwMOha23JqEwnw7dwEpBqhla4tzYRlbBEAk8AoPDyXEVlk6rupTwgx
         FR8krIZTCaQBYwYifGFGclJVdPhDWPGpfs8A63MTqaGYfMFXZpfQrjq7nWzvwesVBaVP
         1Nc4p78S6SlatZb2BePoa/thkv/NmgyUeJ7z652tsj5kE7uO10Kdd0aTJRmOi1URFEBp
         zG8xDqS+h3zk1hjTel2a9DOmITWAFXIJwEarJJp0RM3pwsDrX4BPRjKPJrUYgd9M1GOt
         BPwA==
X-Gm-Message-State: APuU4Z9UlDhtEO/0z0yZupeOhHWFwuhem8C69g9LCyEw8//3Lbf/lIlD
	hP3YOrBEgnhXk7RKMexMvL3SVRuHtIjxgpq5NKRDn9HQY4F9vbv99osl1QP9tg==
X-Gm-Gg: AZFdTZeGA9ZfGMkeeVtapNUkGs4CkCq5yUM91p8s9U25su4qFXpLyX5QQtfBjy2IXQ5
	xDsDvUb3o3gMaAHsjPi+90waX1kAeIn0RWcc4zKUAfyUzxsbtpha3agP4xMqtQS1yu8XqnAINq7
	OnFz9sfvwV4Gbg7rqn2Mj2uFN6meS12RTxcogbRQkSdEyTFt4nmx9IU4JwECdaDf7ogPCyhFF9x
	XIRHo3rxRoEsLs7K6Gyuai2kKRHc+EIyUw+RJUwPWE5O/fPTp4PQDTugsbfeS7pNtEVbj8AXj2D
	N0xzCakhLNjXSWhEo3ZV4mbtVX3C8IwMqvgmIYryUwUbRWLpcQPBPiKxqMr4yxitqdGiB3c6DdZ
	x81f2Upphv7jAEBqMnjihYpEpDqxb0mgqXN3Xh/f5l20ZlxJ4bI9tnzaUVoxBZYJtUj7/+kcX8R
	091hGk/ou4qX0mIu5P7jKnemgufaTmnR47QEflQHb+1QooGMpPfLCSlkEnEvU9kU6dV47v35IQ5
	hxaxoU80nv/YGDFJje9bo70vRIrXGuPSNnIcUdd6JW6XEh+uU1Y7e9/Mfqx4fwXchtVbtaTCQC0
	pstlhS2+f262ti7jRWxI3NJNrjLgRITLKGl0V/09e3jb7WDFm+goG1DdUVTsOBHOI4ucXV9Idl0
	R7jXGen8gMHX/HYJXrWrK3W88qhnprPh6SEni93A/zk6vQZPvUprIaTyfMkPWbTRKK80re0asoH
	uY2eE=
X-Received: by 2002:a05:6102:5cc4:b0:7d0:5688:f511 with SMTP id ada2fe7eead31-7d7393fdfc1mr8121641137.16.1795553471456;
        Tue, 24 Nov 2026 12:51:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm13929876e0c.13.2026.11.24.12.51.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:51:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] l2cap-tester: Set IO capability in Client SSP - Success 2
Date: Tue, 24 Nov 2026 15:51:02 -0500
Message-ID: <20261124205102.737384-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124205102.737384-1-luiz.dentz@gmail.com>
References: <20261124205102.737384-1-luiz.dentz@gmail.com>
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

L2CAP BR/EDR Client SSP - Success 2 connects with BT_SECURITY_HIGH but
doesn't set the IO capability, which defaults to NoInputNoOutput, so
pairing results in an unauthenticated key and the test only passes
because the kernel lowers the security level of the channel to the one
of the link.

Set the IO capability to DisplayYesNo so pairing results in an
authenticated key and the security level requested is met.

Assisted-by: OpenCode:claude-fable-5.2
---
 tools/l2cap-tester.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a83e98959093..2bafb7dbc222 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -98,6 +98,7 @@ struct l2cap_data {
 	const void *write_data;
 
 	bool enable_ssp;
+	uint8_t io_cap;
 	uint8_t client_io_cap;
 	int sec_level;
 	bool reject_ssp;
@@ -393,6 +394,7 @@ static const struct l2cap_data client_connect_ssp_success_test_2 = {
 	.server_psm = 0x1001,
 	.enable_ssp = true,
 	.sec_level  = BT_SECURITY_HIGH,
+	.io_cap = 0x01,
 	.client_io_cap = 0x04,
 };
 
@@ -2342,6 +2344,16 @@ static void setup_powered_common(void)
 				data->mgmt_index, pin_code_request_callback,
 				data, NULL);
 
+	if (test && test->io_cap) {
+		struct mgmt_cp_set_io_capability cp;
+
+		cp.io_capability = test->io_cap;
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_IO_CAPABILITY,
+				data->mgmt_index, sizeof(cp), &cp,
+				NULL, NULL, NULL);
+	}
+
 	if (test && test->client_io_cap)
 		bthost_set_io_capability(bthost, test->client_io_cap);
 
-- 
2.56.0

