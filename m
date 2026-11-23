Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456301;
	b=RcsIohNfdhRYjuqp9qDW8KONPhRAemk6UlgWBIHxjLyevVG9YeZ6Wu0k95OVYZCquS7Q
	 U/QYLfaHzUpc01YyHpao/wzJVYXLUFxz5ZrjW34gmFZr7DdZ8dSVY3uaE5KX1qbXDL16k
	 FpAVmC6ATuoF28kklWOLd+eg7PVH/sZJFeVB03mIuUmnxv0ACSsSYTWsN1H8s2kM6JPnm
	 RvVCvkAAzUHEkkFJmFWH0Lp2QfQ4HEeL1Ans8JIH7Q+DMLXcbFQFPYD8qQLYlVAB4hMMC
	 YQ6iyCswGOGH5iGqQsm4dNkSMNmAPYdErG6Yx2LplFClg+ye1ypRKrv0HdZcy2wz3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
	b=iA2cy7uLet6svMc8GZofKQOiqI+8O8jF5nmqYx0uGuIf0LGQfv84dze9vfD5yv8Z94fF
	 KzYtMY+oM9nanqs32UjyCPZlS97ihJ5vh37UhVCQbvoXWVK+F9XnqFD5tv5VTHjuSwg2w
	 RhbEIrCztkxUwe3YJX9Wr5uK7CJUUAgn/KAPImWpPWOKwaOmFs+pbyP0bMrMFRS2xB5aH
	 zFtnFWORrlmaDggDXujlfnLNNzfw+o/vAJrwrqo3IRxxGSWod8BOenVa4hNtnuTfV7a5K
	 qPyDATLR8HfRYi4J+dAokgQcRUbxt1S3+OU676+EvjbVajGYuzFi1kz9O2MmO94sZfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MS9mtE9X;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784A606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B784A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MS9mtE9X
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1258529137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456300; x=1796061100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=MS9mtE9XjD83F12bBqhJQareABhcLbu7JnoczZsT6t4cnO5Q4Xg585QNkM9ZGl1SEm
         DksgyRjVQQ/HEOmavsAYhF++aoqCkllajIYoB4u4JNsU60dp9j56FfkKgGOrhZdcWhAe
         pMJIOTQyXHujIV4CZjdFO2OwnSxsUGMNrDzukZuaG+IFAFp0Lt4EelA+nLai0h8Zqmr1
         ft2ZlrvAhTYKQLd2eU/M1Qd4E2CO/NxWiLjdDh64vWgAV+UMqQL+2Gbkij3XQBb8gLif
         m25off1RHoLrdcFax04OHPub+ei4NGnofjhlvIqxP6+ussQT1oNgjqneZN+1RNUpKyUc
         Ssgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456300; x=1796061100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=BrK5e1bZAXnIQCaY6lQCI859FQLHsmVEJ9zmGTJOotrLJhjaASCIKnbxcSjy0DMCa0
         yAm7o7QHWe5jo2M2uFDF+7tCOo6FCR+PBQeeZGHVVU+nVJa+ZnI+Rw5dEXfav+BxBdTt
         FdRKZ5KjotYoTia33AHlFT8PMXmA91cPuyExghk5+Splk9FjF/apQiRkgfzdF43ekQw2
         4MHmRlkgsEHJKpCSceqUrQqyR1UPPQv1Khj6t6h77ukp0ulL54ak0YgdTNd468PMi8qH
         kRBUh3skKpxa/8ot6Z4cZ/b31taMxir1KJLMHTSm3IGPZltQ95cXWl5TdVsmZgrSVr2d
         oLdQ==
X-Gm-Message-State: APuU4Z/BMYlALRPCUl2JVfPvzlGcCJEe1FcjwvBZ/j4lKsg9jp9GDEzX
	+JHYI23xw4bCF4IwNk78PUtZyMcl1dE+AOMEh/cuylVcpi9EQd21zFMWLYY1/w==
X-Gm-Gg: AZFdTZc8dU069A69taFFqYQyVe5Dfy+p0ingCZGBQkpSN8XKkUcQDnUPwN4SvHzB2ZC
	XGrGDBUU0RllzZCMZBh/ulOCGhTj3V8X5GQnSZR+MwAKkAIT6g2GwIoNq3lztoCc0BEpk8fwAOV
	NDDSG6jGW7Md69YyolMr/KGusWFWzv195uqfphvqvoQJAlSdykhR1jlSnTphQIewSLHVU/BCY0B
	edUA3uybIwdehbt/aJoMHj4868WL675moPM1AlvioeE2DvfKMYylRKfHvNvj55XuOhtabWqfYdl
	YacycAKgHbTNnapgxJJXAYXoGYqbXwdChJ92qAZhYaeBkN9FA3ME6a5sAeda1hqI67lQh0H/ROg
	5IuzRx8JIEq/rhLBVuoCtqmVGobEDciLsV6PWNUOniEuIyDmuwEAbUj0GZPREmmB5OPJBcvTc4M
	SQYJpfWRw4avq3MOeJkgmh7/xYnM9YD7ywHLgfxj6KaWfU+FpEfAzOi0dYBa1EvC0dqJCu0Bd7t
	gVR70cdgQCk/q6/dVmYj0ZnsU2+MOrZycbQx3+mpDzHu1LpK0pM5711d2NDT+CEZt/xI2XqRsOs
	XIkTEjtsO2X2MJ5by7OkGpbO/wHz1sKA69GoE8PE6TEfcwEDBGw2HXyBOX40TYlGZSLhAQcERzi
	8ys3+1ArUOx4F8ZvJqfyPOJHnoJWyZRhti37OrWm4BYrq7gGDh28M1sbgaTvoQ8CtnBVq44y4Tt
	JkpQM=
X-Received: by 2002:a67:e115:0:b0:7cc:21cd:9b46 with SMTP id ada2fe7eead31-7d739625daamr4569010137.33.1795456299562;
        Mon, 23 Nov 2026 09:51:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 16/18] shared/rap: Start the Real-time timeout when the procedure starts
Date: Mon, 23 Nov 2026 12:51:19 -0500
Message-ID: <20261123175125.3642617-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

RAP v1.0 4.4.1.1 requires the Requester to disable Real-time Ranging
Data if none arrives within 5 seconds after starting the CS procedure.
The timer was started when the CCCD was written instead, which can be
seconds before the procedure starts, since the CS configuration and
security setup come first. The CCCD could then be disabled before the
procedure had a chance to produce any data.

Start the timer from CS Procedure Enable Complete when the procedure
is enabled and Real-time Ranging Data is subscribed.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index bc6f133b5da9..d4ce1751f052 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -411,6 +411,7 @@ struct ras_ccc_state {
 static void ras_ondemand_client_reset(struct ras *ras);
 static void ras_realtime_segments_clear(struct bt_rap *rap);
 static void ras_ondemand_cache_clear(struct bt_rap *rap);
+static void ras_realtime_arm_timeout(struct bt_rap *rap, unsigned int timeout);
 static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 				uint8_t opcode, uint16_t counter);
 
@@ -3352,6 +3353,13 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 
 	/* Store procedure enable config in the session-level template */
 	reqtracker->bcs_proc_data.proc_enable_config = *data;
+
+	/* RAP v1.0 4.4.1.1: the first Real-time Ranging Data is due within
+	 * 5 seconds after the CS procedure starts.
+	 */
+	if (data->state == 0x01 && rap->realtime_notify_id)
+		ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -4643,9 +4651,6 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		rap->realtime_notify_id = bt_rap_register_notify(rap,
 				value_handle, rap->realtime_ccc_value,
 				ras_segment_notify_cb, "real-time");
-		if (rap->realtime_notify_id)
-			ras_realtime_arm_timeout(rap,
-					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 		return rap->realtime_notify_id != 0;
 	}
 
-- 
2.56.0

