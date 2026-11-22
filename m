Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376036;
	b=J/L4xXnU7j7E2X0aKVbqQTkJdFiEV47eQLfH5KqsCtpg3rXZ69MxLX28aOZc7cNX5GpL
	 woZ4qXrz9zKhttqIdL161VJ9qrSjqw7+zbseMlC8C2UwD6ky6y38mZzgBgeTqv9NUAgpe
	 HwBcZxEx5RGBZh4VN4y0ywwV3ftqPWqqaZcWb3HayWcQe9eWHHvJ0ZVnXv9RlsnraZOIJ
	 UTXUUcCZGY3ybmM9JQfYQ951g9eefjrsT/6dkySYlG+pxR0O+Np4wR9KvFzpJSpo9N6ih
	 abl7JCSZc7hbrUSpTZPKnALlo62dJ0ErVLnyd8bjLJ7tJwShfrJL+KVTBVZi9rxPqwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
	b=cXIMznRm5bTZnUoX0gLb6YcOo9NnzlCs9FR2U4ZBokSRN0xfK5o16AzqDEg31nqK87O2
	 aiWuSnXBvedEAEM5amqKWdd3k2F6FZeyDt12/mhsKou4MiGunPmerk1V26lNZnLZH0fMH
	 Rrm65Ewf1bcxiCjV9nST3JCnyfoJQsLkAznAJ4TGH3lqev40zO+tMMN2XK3Sh9f//WGc9
	 VGnv6+ONbmzR8v02tf6vXW6iCcJVPlaOjQWZ2a0MFtUMxoi70D6hVFEPw2W2K/Pm1HyfB
	 XqcJ3Xng4oxWotOvp0ofDjno7qrn5xz3c+2E7I3DHoRoU3CpytUlSSD1LUO3vUyzFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=plqRi2ZT;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907A606A32E
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A907A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=plqRi2ZT
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso25123495e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795376034; x=1795980834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
        b=plqRi2ZT7pWLLS1NR5hLyGKHpmqe2PNumoSr9h7mbSfT1ePmXNaRfLyDXJDsldvbR0
         LARagqW+900x3GRQdidgJvggvzem6L6QHi/fSHNac+PkTetmxqp2ZQ9f+4MhTsPRtZgL
         GLbaQT1J/w2F9jCNar/lTv2rGafTpePKhwc3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376034; x=1795980834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ba7L8HpO4a6Ctny3QZ0YIiUY1UZ1xKXTeaGgtN08QCU=;
        b=zIXyRn3C8vA2A0G7xQkB6opnEcOzenQbRrSpBLdqivc/F4f1L1EoqNkxUuCBzatz61
         55/HcmL/SablHdjiFZB21+KC6ksFP2QjwnSs0F4xuhYGRuHCP13fHFCGXnrAewqCEbHV
         HzEu/Nh1U9FE6SLmhpiZb8N8LN2rguITbAfMB3sKfxMzlIC/dfyEEb5fp+X3UALfQyUP
         FW7gtd4wGe4g7Df7b5DtwUsYVn0wk1hnAqCpPa7dcT5LFWQ1gwxxUK0RqK2PUpp2yrTz
         lql3EFebAJ2KNgc7mvtTF81FsGjf3gktr19HViO5stZpRrvflJ8PvGcQFhDQoEd8Os1S
         Q8yw==
X-Gm-Message-State: APuU4Z+RRrytCxGxhctBOhfM7C6uA5TCq5f+MSF15PZJfOFrYnKaED5I
	dA+uJLfcZvfVsPwj8OG8ngjCy6J05XeEVjq9J0QHCE7CZHhYWQ26FIj1nOkADE/Luq530y2pRR5
	tRxb/
X-Gm-Gg: AZFdTZd71lcJQZ9VP7n39jszFDCimHQyM/ZX0WtoC/4aZh61NUpZrmIe8mhrzjjrwnK
	EsUzs19aZVRlHdheROicc1vyKR/pmGjeF1AQIUF3xCJfghDwHYjRD6lOjZeooT8vljfaRMc708t
	fZhZn19rRAQeAtbyqM6yu+zw3VRyMvz5WEL85kkYOBPvbJScWzzwtSHiUkiEI8jGhlE/G/or+5l
	tNbYWCnFHVrs6224P7NQexRXCScEoKxorQOHE2WmilGeVaWc0b7S89xVuxAsNsu278T6VBaEi7M
	YkDT6vRRyy4wJPCiEw9cy1bvogRwody26ooclWVZfv34C6m6OGCTcd4rEp3m71Ip9Mjj+d+JGzV
	83A+H1xJekoQSjGRzU+LIs0AaC6CLKNWMgk/Y4XGgS/HsRIZBMD0+KymePGvYBHjR2Dk2ysRYAQ
	L48DXe3BN5KlooVLj5/HWqAmirBJ54a+6vvGmvmTJYcBBCf4djkTtmUrjTBYYGOhbdwhWlMRvdh
	5+e7CiX4nCkeqGFvajf7fp1jJtAiZNDmObwTPZ2amO2ZO2+vPcneYq/TmBIIdwAw+q1/7Pm+cy1
	dhKgevZ0bo/OUBuoZbfjr1UautziKpUcuq7UOh8v190FRIdTYg==
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr209337945e9.19.1795376034040;
        Sun, 22 Nov 2026 11:33:54 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm223759655e9.0.2026.11.22.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:33:53 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@gmail.com>
Subject: [PATCH BlueZ v2 3/4] bap: Don't leak the io of a PA sync that failed
Date: Sun, 22 Nov 2026 20:33:46 +0100
Message-ID: <20261122193347.2366500-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
References: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
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

From: Simon Mikuda <simon.mikuda@gmail.com>

The kernel reports a PA sync that times out twice.
iso_pa_sync_confirm_cb() replaced data->io_id for the second io, so the
watch of the first one stayed, holding the last reference of its io and
keeping the failed sync in the kernel. Where PA syncs are BIS
connections on BIG 0, a broadcast source on BIG 0 then fails to bind
with EADDRINUSE until bluetoothd restarts.

Remove the previous watch, which also closes its io.

Fixes: 2748c60a2c6b ("bap: Wait for BIG Info report event before creating streams")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..5e717cbef 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1896,6 +1896,13 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	 * encryption flag is also available.
 	 */
 	DBG("PA Sync done");
+
+	/* A failed PA sync is reported twice. Dropping the previous watch also
+	 * closes its io, as the watch holds the last reference.
+	 */
+	if (data->io_id)
+		g_source_remove(data->io_id);
+
 	data->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
 								user_data);
 }
-- 
2.43.0

