Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31A21D5B2
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753705; cv=none; b=fzpf8rqrVu4+T6ok+zy9wUWqusa+3ZIBZ3NVkTOZuTsXpZ5fDb2sgD4QE7VlkePnEDNy0ZHQRR99uaWn22YzIfrWZnJJrp2j9PxmUaiyGHFIz3sCD1sMd7+2t4fkKYmdvVtq4pUtY2f8PyuX1NO8f0eCbgRtCJTvMG3Pvjm3bnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753705; c=relaxed/simple;
	bh=DPZ4Fy8hFB79kXhQkjjsaUMg1+lmOHgCZ9nLOHWNdV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stT3UJypUoIWqx7yaL9tdgdkalhEcbM76j2RBXwGTrJpjhB+QeL2vd2VoLO1a0CCrJRSWo4p4EQuZenkdhKhndLhImuCdtPn1Ar6tGmVgo0+4nka4nUBw8yDZaYc7yvm88FNo1GDnyHpuhbWzHkyi0ah6YO4gJIDx8ZQ1xM/oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fawZUGjX; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fawZUGjX"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-525da75d902so2289378e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753701; x=1745358501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEjjwG5jx2aPU05qIE/xX2hSXaML6GcxiCjF2JKd8Z0=;
        b=fawZUGjXQeqy07DWH5x/ZDk1at1S1j5YLNk71oSaDE+9jJzvFwl4BH35Sh6fJYypCD
         YptJvwBY25JoKvApl/mGZxFGaMj4jzVwMzAyAXpA869zv9RkuqmH0PN1IPedlpb/hm7R
         h6vsBIKkM0N/2CzRH7d8we1DuXGrL7T2XaMlQye3k4JufMoRzon9w6UmEn5jHAR5HF7W
         M+c6uxtflFq0tAnbdXEzqdz5rd16w30cII16m5pym/oaMHNQmmN1u9EPAcnRywoXcmZl
         rFuGm5dkerZZqlSsR1J9uLp0bc306l9EutwReYdOmzDW0hZu0jrfY7d+AXdIqV02ffsh
         m/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753701; x=1745358501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEjjwG5jx2aPU05qIE/xX2hSXaML6GcxiCjF2JKd8Z0=;
        b=UtTvYEdRrkztEouP9VtNg5jJJl/5oBSBg7Lj5G84/5em0iF5c1XPgN/x8qPjQFXWj/
         b+6U47rq86cd5TInQxXS7Yljjgc6dJUWcVHOqtWv+PRKmMVTglsYiRq1cFQrqt0YQn1y
         DtdzFyijxVsIjdeT2+OqsEOISsPD22wQczb+RLdJ52yyXDrpZ9LQqEsUASeL87slr0ye
         +9FcAIJaTrpSrgTMKHw+JpoouR/U1rPtMv6XcI2jKnndb2N3BLzvr9G/9jBW0BLNs+Lu
         62kc6cwNn8vLmA4xJchSJDBmZrmbSYVkEuJr5KEctSO7Wbd6AYEsFlno/bJX8kM5qwJF
         cfXw==
X-Gm-Message-State: AOJu0Yypmgmc8uR0xn3PwOWqvRy9TjDA5nsiRW5cHAav/Plh2gsih5GU
	sB0RDyYUne1Y/MVftoXL6RCX2V922IiuoSUha8jro0K8LlfM48jV9wWwsy6Bmdc=
X-Gm-Gg: ASbGncss27kTgq5JTaUbNgIfnrte0xIp+Ub3sCuJOm1EiBx7P4WU1N+8c74KRSE34QQ
	KsgUm1gqMjCrvDn/lRo8jQFlCe3mk6rJlUh80BawWb79EaHt/BR7gEIvEGsSXrq8WO82R2yIGCx
	Q3SOhEN2rnziojcVfYcYDs4jeqrI1VACvoSqCXMXkqDaF3YKZf3yQNJeW53qqAyW7J1LAQsVdUp
	seR1wsWJGtKph/vjut5K8zuwPS3R7jY37dDknDG7AWlf2zoLli+iFYydgYtDQpiYrd87NEkxKny
	/YGx/7oDww9MbNFxV+Znrrj8oNj6oB3A18ZRdlLsdKPc1hYWax2iIJKtfwpm26hHOIxbhdUI7iS
	XVRrVx/a98A==
X-Google-Smtp-Source: AGHT+IE1tcDTiGW0zUOxjrX/T5lBBXgtp041aV4ZWAR253BUc/XTmVmPwbhxK0t88p2eIrSU3IoNzg==
X-Received: by 2002:a05:6122:8d6:b0:523:6c0c:e991 with SMTP id 71dfb90a1353d-5290915d761mr915854e0c.3.1744753701124;
        Tue, 15 Apr 2025 14:48:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/7] iso-tester: Add test for SID=0xff
Date: Tue, 15 Apr 2025 17:48:07 -0400
Message-ID: <20250415214811.1677842-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following test which is used to verify that when
application sets bc_sid to 0xff the kernel will attempt to scan for a
valid SID before attempting to create the PA sync:

ISO Broadcaster Receiver SID 0xff
---
 tools/iso-tester.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 350775fddc96..b362647461c3 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -495,6 +495,7 @@ struct iso_client_data {
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
+	uint8_t sid;
 	bool listen_bind;
 	bool pa_bind;
 	bool big;
@@ -1419,6 +1420,16 @@ static const struct iso_client_data bcast_16_2_1_recv2 = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_sid = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+	.sid = 0xff,
+};
+
 static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.qos = QOS_IN_ENC_16_2_1,
 	.expect_err = 0,
@@ -2843,6 +2854,7 @@ static int listen_iso_sock(struct test_data *data, uint8_t num)
 
 		bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
 		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
+		addr->iso_bc->bc_sid = isodata->sid;
 
 		if (!isodata->defer || isodata->listen_bind) {
 			addr->iso_bc->bc_num_bis = 1;
@@ -3817,6 +3829,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver SID 0xff - Success",
+							&bcast_16_2_1_recv_sid,
+							setup_powered,
+							test_bcast_recv);
 	test_iso2("ISO Broadcaster Receiver2 - Success", &bcast_16_2_1_recv2,
 							setup_powered,
 							test_bcast_recv2);
-- 
2.49.0

