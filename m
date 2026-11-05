Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917006;
	b=zwFi7eTbG9mSyGunIH4FzHm5IU7bfPqtuoCiBoUscXYzZCbPMwNWh7y/0yhRIf7sOF+A
	 UZwn2BUbTBzaLq3mGru7TDlVOu44d+QzibsJqTQ7vh/2pFM0BAanZMyb2pnuguqovNl1v
	 5AiEXJ67/FHigXQR4sqRmTlwTwZSjTLdOk4NlfWDsHkrAJgt9SIUCCjv9hV7j7t/ElWdw
	 XBDrhmAJpRauShYB329mAcpAjKRfRr8XzZfV14zHNJ3XDDK6QXiEHxDcCn1GRZqv+1uf1
	 TN3fMX22x69Zw84YnZdR15yLeF2keC7dFh+Bl89OYtTJnVI4TwEeWU9fbW1rwlDYwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
	b=ZgDZiTvKhPAmJj+2OFkoraridOd4ujmKwcqSv4o+AAx/8rawojBaC9v8M360W+fpFncX
	 PW0phW2UA/tHsFUM4PY6SQJXBwjZDXbBjC6SJW9TMQ+VFKFz03JNvkNzBWRG9mXQ8CLtA
	 GrGFQRxCQnZukTVovH9rW3Q/xaiwCDZEMHtFK19wpIJiSPsgcT7rzcdYDNdFYRY4kwHCP
	 cfrF4bPhB0YZQeaRm/GnuEzIRaFQoFvLt22JT+VCsDmNDaLwvhl8HbteD7uzgvhdaIlMc
	 nt+Co17jNZycB5Pet5h0ouWx5wMs3U/wMCcEznlTnGAHB8TNxmS43eXIU4qdojoqaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klnTqtuC;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB75606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB75606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klnTqtuC
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-745497ac8fcso34415137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917005; x=1794521805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
        b=klnTqtuC01tXuDP50pgp7EjjDLcP+r5N4ZYjIAumLi2bVg1xo82vSsqdVQJYdKEv28
         I3gDff9qZa2tckOYUGBU+XXGsSPcIr9GwA4f10JVoRmF5p+2r3DBGLg94ILyvLsep0Vw
         43xgkLr/qee8WNs3K10h/WXaNDw7dC9Iv4Rb0NheOrCwrJ5u0O379OSh/BBQQ1QY33wI
         d2x5WWHIccHwK1Fk5CqF7iQ4YkKMu5gHFuNmOtzqvZUpV7xrBoFxrOwQehZ8GO9vvN+V
         mPsuraIqlhJjg47zmChFzJWT294VpYmFmfTXLdupBxywvZK6Eh6MObFqJJgWpSflW5bu
         2FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917005; x=1794521805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+CkIx6q6OfUme2dACbHe5/gP98sj2z4lAH16aF20qZg=;
        b=Xbc3O8M/h3plU1uVOykah4qVpFb4KRayKMvXC3XFT+d4O8faN9s55xXIvbtsVtkjU4
         BP3yFWFpMR66//MQfeHYhCkN9GGMZLFK80MaR6+W1WK2AL5JqE/SNAonaa3lIEZhuMJy
         XufBuj88v+pcAlCvla70Y7SYuPoYCDVYup9ckHGNhJxzZZbOHHFaE87mzzLpPloMpTRS
         ge2/iJl0QA8lXIWGvuXAnY4WHxeW1ZVcJdHEkNch67ja2ukp3V+w+G17mF5rM7dYa3Fb
         5aldZpZESZS2sUpkIdJJ1a0Mz8lqUnSYKBs3JfnPkWm7yJowQud5fmzHNEgYg1gCmD0H
         ycsw==
X-Gm-Message-State: APuU4Z+50DPSWuYlyQwJ5xfpd1UJkMlgtG9owF6sly3fLhuaR5P+Lmee
	PV342VrFKudsvC7IRkkavsvfeQS2F37m2a8jpr+usoaqU+nCHiWZpjfg264fUg==
X-Gm-Gg: AYBFou31/ZJtr7stwLuXABGg3XkURduNbv6PZAdJ34PwpIKroy79Xp9DFsWagqKxJSF
	P4qbyaXyVh3ibc3lMA7N8gPDGqPLicJNjbtGeCkevfvkaVkLXHUR0+eRqQWUfzPeCE8fIiAN/+H
	ksBbbLbhmuEx5ZV3Qq5bswxSKxSG7Mfz3qj8kQl8YPisKfTxv1snC1XI/ip+eOo/8llLM+wbv1+
	NXmCC14ME8RoDrVUTx+FZvRdKSytd/CS+WGszKkGbHGpmuo8UHacDvFpTjs72S8j/5UmLisZzXk
	fLaf7ethS30L14AWBJQU+AeP/I6Oas4pQJk+bN90yrVEIVuCtaftcgG2ICgz1+zCDfV+kwOWfj3
	9bzZEYyPgGYL8zJ1yn/OgcsxRR5qxfi+aedw/YhwG0Xk5y2JxvgfJtUgmyR+XwJtZ9vjCnb8E2o
	qTdFKWh6NIMcYrpYHaXCaEYiuK0d+uoGSK7WB8GzW17QSvgqI5ejoq24HihNAqji5oQgQUF7jOB
	aTnGpsnE/UK7WJNlB9hkVBhcgsV7E9aO772Vd/q4UCsqkRymPeTqMEBQp2o6KYh8C9SyQ4TmhJW
	pIkfxu8i56JiRwUYbyQKpAVS1D8qAFtdwwf0L37HomL+jMtzKN43mxyC0cfHtWwPT5S309Ud7nV
	zcLV0ZrcpMO6jHeCm+S+9YwZCcRQmwEx9LfMmQ8LV0mwMhqNBN1Z6ScAzAMZopmtMFsFuVpPmai
	eICjg=
X-Received: by 2002:a05:6102:c51:b0:7cc:2152:4f95 with SMTP id ada2fe7eead31-7d2a12c4598mr746798137.3.1793917004781;
        Thu, 05 Nov 2026 14:16:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/8] unit/test-gatt: Add short notification test
Date: Thu,  5 Nov 2026 17:16:34 -0500
Message-ID: <20261105221638.2332398-5-luiz.dentz@gmail.com>
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

