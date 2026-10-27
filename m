Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121569;
	b=q9ImTQX5qSF069bVv/5MK2/+U6PjzDAwpYhu4xywmC1sDrE2UxHDHbM9YxcreF+FpWb7
	 FF0NofMPRTXS4JCv5uKznDkVGmZgDsrAfY5VmCz0RTx7E4XwUNGfAu6sBp40gIuEUjw6l
	 mTDU5ghkb2mpvy8+S502/y3WxHw5adRJV+tgWVa9+oqefGXPm8nZAt9l34joW+cxmE9ts
	 AHWSO7YHRP1hm5s3BGcCp64mUQzHMflDQZ0z00P+C3Y0qd/5gCq3AEJ55mknViGlqtf94
	 Lug//uxsjiq1BSiWkr//tSma2MrtYHQUiKIFLklm68Z9Un27NSr23P2+jayFRNaxcog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=96SgC+xQhp7CRH5PHlwkhTaThiDUkAr4PmREV++N0B0=;
	b=t5EvWtE4NICuDxQzZRaJV4jYFmA3DX0lUS+Ioy1XgGWNwqBcxwxLuHXseJNpNUFkCxqw
	 LWZui8y27NUiYPHng8A7PhxLtNMgK1YRTQVWv7J1JhhgO5qQAtBeA5szCt6uKxCKajmhV
	 sgg5IfJlvDCodUuGFykKpAU0OpTK40CPof4YtfxvChd48BjQ8LRxzpOa/ab6KoYS3dLrs
	 dhZbXzOz+gXwcyttQKAXwbY6Q5Lp+BQs6w6ezZvVTSqOCz+TpSm0yQRuDe+WGsUE9vTZR
	 NZgrV62ula78JuLnak67fGK/xXAe0x5hb5HLXYpAKvBIz9l7RB6cFnylUXuVOSnzB6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=YeRvBrV2;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589D606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4589D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=YeRvBrV2
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1846bc43c28so63313c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793121568; x=1793726368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96SgC+xQhp7CRH5PHlwkhTaThiDUkAr4PmREV++N0B0=;
        b=YeRvBrV2GTxnbgu+TZK3SS1MIep6Tf139gVGPPKIx2Y9gG07eClZRQxw4eIF7X3nDC
         tA8HPQ7S0EHTsBOTHJFG9J/liwGKUjdrBXIoZZX/1uya5b53oD3v2MbGW/AMoSQgT4kQ
         VUmeIPuujrw8lMVIL/KDnjGjjsyB+FS96p9I37HYRJq4A1IswuInlIDpiIgHuU2isEyH
         pwUSySWcjhwbgpeKYCRtmCyBmF8d58whFOjS8TnypjMczeRliCY4fN6xDtgbDvQ/rgd9
         QnuUFjJPrrZ1bnXocJPXrF7IjjTor7CLyMboPnB3qQnGFONtwcnZWzDYTO3eiabnCuqt
         O+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121568; x=1793726368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96SgC+xQhp7CRH5PHlwkhTaThiDUkAr4PmREV++N0B0=;
        b=pP+CUEJRegzdpA/bXEtnbz8HDTi7NCA/cZ4GMKYCMS/bKQ2G5KshoAX8482uu+UBZ5
         629PRMeNAxBjlgjWuFRwa5nCEiR3xzdCFpZlyv1HP/KQuqeGcdlLevlNN4HgGcKSJ3+G
         fr+4pAOYLg4RpdO1mV39sBxnVR0XfQVcbKWfamPnSc4k9nwpfiD/la15s31V9Aqi/Rdn
         UHRVr9w/jw/xhJzxxJ+ASTFTnhMMPV/UgAxaf97l0wIjVVihp2XNV1gKcwmN1Y5PsoSZ
         ojr3MkCmyB0Z9KhYJUXahVhD7c2iP7UEv3Kke19wZFo7BOC5WgJBNPuwgIYzIy6T5cgg
         s3Iw==
X-Gm-Message-State: AFq9FYKEHUAzm+FV4tS9p8Q4xUIOd+OqPV+PtUskSDmRXbP35CLch1M/
	ricrho4/clLvFk78SmA4hyhSRwZA/qPEetakfS8agF6NEu08H027XSHPMqi/9oh0mTJMEipm3+c
	w3CsRqBg7YQ==
X-Gm-Gg: AYBFou3b1VRcu2n17Oo6Tefw8mGll3fhc22HRZ0aruKDQaUPfq2zwHPI2c5hq/zIPaH
	xFbgHcQYqgslW9CoW8Q1KkD5kZ3Bd6nex8Vx5rnhC/V4SvHehO++4t3QSUZ3s5VA+BlS2oAOTO2
	ZCSSCS8Ka/X0bQZvfU1nSCIbWxjDIvI23p2CXSNiYF5io9ITXIRN1aH+tLzfTCAJtgk8srcUZfR
	XEH2p1IyT/y7Osqk/RsbWQP3AAzLeb9VLMj/W2Ng5klwFmhpGNOSCV4O2mVJ7lvXSZShyQrw3mC
	LqPO3RDs2BB4Z5zsyQxT9locvPGVoI+1ttPTnIgVU+mx72fSm5pT5JM8u/UJwSW2qOu/FnhO0kc
	QaRx3zTnEkHlsx08DpW6/Ih7Xbe0OJEiAXrY3mF19fT/fo2AJO/mosfyKNvtZa9s8tvCAtlUjRC
	ph9igJ35LH97T9KHur6xi5MP1hgmm4WSwQTST3T1XmQwp/1D4LHBLq7w64skNcVVNSUg2GZBqX1
	q8yVbM67MGk6UZ8yGyzO8/3Cvu7ynjETwKhmWucSaME5jpDCTDyYhw5umxNqLIo0OYN63uRHrAG
	jDMXHtKKIkXx1DQ9BMHioLqVh/EWu3DI+p9T45go92yD8QWbOIDt/NdgI8k+f0ecOw1usFLCT/s
	iSkGZArR8ssB8AjqQEe/+1Q==
X-Received: by 2002:a05:7022:2513:b0:196:7742:3928 with SMTP id a92af1059eb24-1991b420832mr20467284c88.0.1793121568207;
        Tue, 27 Oct 2026 10:19:28 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm34440562c88.15.2026.10.27.10.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:19:27 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/2] adapter: Fix Discovering staying true after a rejected stop
Date: Tue, 27 Oct 2026 10:19:22 -0700
Message-ID: <20261027171923.82919-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027171923.82919-1-kevin@simpleble.org>
References: <20261027171923.82919-1-kevin@simpleble.org>
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

The kernel rejects Stop Discovery when no discovery is active by the
time it processes the command, because the discovery ended or another
mgmt client stopped it just before. stop_discovery_complete() then
removes the client but keeps the discovery state, so Discovering stays
true with no client left, and the next StartDiscovery with the same
filter returns without starting a discovery. The client that called
StopDiscovery also gets an InProgress error, and "No discovery started"
if it tries again.

Treat MGMT_STATUS_REJECTED as the discovery being stopped, as
stop_passive_scanning_complete() already does.

Closes: https://github.com/bluez/bluez/issues/2547
Link: https://github.com/bluez/bluez/issues/807
Fixes: c1226f79ec97 ("adapter: Fix not checking status of stop discovery command")
Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1561ea3bf..4d753028a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2194,6 +2194,14 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 
 	DBG("status 0x%02x", status);
 
+	/*
+	 * MGMT_STATUS_REJECTED is returned from kernel when no discovery is
+	 * active, e.g. because it ended or another mgmt client stopped it
+	 * just before this command, so treat it as stopped as well.
+	 */
+	if (status == MGMT_STATUS_REJECTED)
+		status = MGMT_STATUS_SUCCESS;
+
 	client = discovery_complete(adapter, status);
 	if (client)
 		discovery_remove(client);
-- 
2.54.0 (Apple Git-157)

