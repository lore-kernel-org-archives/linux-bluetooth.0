Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108602;
	b=2CMBbyXnDJL6jA4ktl2QpswrnKQ1019f/1/UhfijDQe7/TnRLPgdesomVmjPXO7hWVAs
	 ZaSg5GkNGveIBd/XxMb7IFdYBJC5dR7sVis0pvTEo0ncICi3536NOhMpjMaKTq5Jp2l5D
	 ZjAGir6H+gotr609yVzXSyVp/tQRe6+Ko0cH1q0TnZQxsJ2mXX+gMGyMvj/NGbodzppSP
	 zspCHA+EgT2lsgFsh/LHv8WkINk3DB/8AN/+zbc+sz94vSl5aum/mt1H0O8IsBJfeo1gm
	 4fLQW0EDzDPs1PUJ6wn1i+jQN73wuxhN1XP48H9o0G8CAJfcpAjzGrjNzanMpdr39ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
	b=NQ4rCBnhYoYYTiLZj0Vqbi7y12RJZlBWqBoSKvTAx90xXUeySTu6HL1poQh9VcqSdp8g
	 W4ABwKuYzM/oRtWgaEYA2Ew2BQ8VoPRPxZa4045SNOG9owBuxbMnNvxvKEvy2RC5nvpjs
	 3G7jZDwrF/JJFg86q2Uq+KMSZTg8dscKv1cEAHibfxEdpPIb9KmMKWfCpOSnz5nYwAYm+
	 bcub3b9GMwkUjdc8siA2Id6Hh674MRBu+KQ6aw9qLMvf6U7Rv24I0LmoSCh8eqvzTdPtR
	 Ma87q6KscVI9VBRe5wpTkrLT4cL3tbxA03TrZ/q2nDlCsftUr/lIfI6ZqDwk82jO6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEPaBfnX;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A207606A33C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A207606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEPaBfnX
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ecda93627eso758533e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108601; x=1795713401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=xEPaBfnX9kB3C0rt09HXJwZlXTmZgcZ8ibwrI9kc4A53TwbApuzwCxpauShGE3KYif
         xiBnY2jWtyIVoe66ggc1ACtpP/9I96hAn0vXPCPj2n0+KHfNMzg4R2mmRJ2pI3RjOPpt
         gtv3g3EAgSvHfotSUDqofviHjqKUPUPq16rvtaZvPUj+haqLU/eEtb7j7pns6kCsU1ri
         qU7f3OhovFvQQIK76B+jC7ZW4kOoh2S6AFKn0boUMXh/Ali8mK2GDJfJCy1BTpTXVRga
         JCui20ZtukdxfQmhiAsYW+i4yqdxN57GOKn2lJrqWsPtUuq3Ok+F2DvdfWEx/48jcrH2
         tAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108601; x=1795713401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=kaX7YbKG0D95dW15maVS/RK4GtTUO8sR35EHSUR3Mqts4w+HVHxy0YK0Ms+exsxMuJ
         frkYgx/Zvp87HKKsdUbzzOlQe9Qa/YtBVNlJHvOVObYSqkuVH649JJB6TZBZW5fey0pM
         V/1nt/3WH1MP7xJG71gpC4VYG/ZMSqI2gq1xFB+LaiUrOziKtLNWPPzkE2yrJPZSlqSj
         Rh7zVmH2DWXmr1hki4qswDR6FMLqS7vB/H4eP/yEPMulf+EwK2ZUxqJkbyvB7ZNW6YzE
         A144DwD8EF7qgKumRYwStu6cVpApwUjzuLe6fvrX8qQzbFp4uT5Riynpl2J8g1na+M+G
         1GkA==
X-Gm-Message-State: APuU4Z+a3ufgQAfmXGUgM2LAD1ILGRa3UCANuAfN/fkpRAzHLDbCU3RQ
	F6s5Eg73oOUhnudGPiW3BlyhPXZPqQkNSYoBbLRYM7TKBaf5T6vIHGnntJTfztJ6OJk=
X-Gm-Gg: AYBFou3OnnRsuVDzG9S5qool9D2N+5DTgG8uaMaTfXvGjDaQtOqkNhp8sUto+Tp/aYz
	ZXHuFxc5czo5ylaIoz8VO6zOgnAsWQebCJggaDC3QkJ1T730s4oNDBdBy3PFdvlvl4ei1qgfnmo
	gbpNKSdQ0drAAdMPGQnoo98AuVhEGl+Sgm6PH4lXdZxjaY6CYBMzxpbzj4GhLCc2gJdzaOEcJDz
	30m7YA2nThPowZ27xNUVrDF2KXyalnuP6lu8PYSzEnMoPBKAesfNdfRkUb7N4nRvuEsFhfpsR42
	S2k6qKE3FVJs97iqOqvfrT1bdmfxK7+r+rQOoXRYguAI2EqRF0/kDZAjC2+eij0TJCzlUP7v4mu
	xMnPqYgZQ2GkqDZNxJdjqgDuHLoo3TdB1WQ1+HNYkkYKQlU6ZC2aCe2DR7DJq4u9f0GFDdx51Xa
	uAajvF2l7MC1iWkb+ityMaKAJHCOYyIOU5qB8XZGCVVCXcS+IEEoB0nQUzjU3btcZa4nUlOPreH
	EAtpMVjZzeesBuFEo8OsbQkaEtnREwH/ejHC8bvhiVE2ytvQf3SLyPf832uzTVmkP549yvx8JUi
	4HmwU3rueMOWXQez4IQ8KQbfXQa+lbc4e5Hov3M6KaUuKAlUqtModQDbQ611cXVtHp0frLwOndV
	Rmd+tIhhkbNlnpuC0DeJEH9CpIk0aDvYiUbpiEldjE/jpyOl4LSnvpNfqxSHb385i4rAkCht8iV
	gZPqfGl+RC20iNbvlEEIlCRhwA
X-Received: by 2002:a05:6122:17a2:b0:5ea:a173:6607 with SMTP id 71dfb90a1353d-5ee8aed26admr211718e0c.10.1795108600895;
        Thu, 19 Nov 2026 09:16:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 15/16] shared/rap: Start the Real-time timeout when the procedure starts
Date: Thu, 19 Nov 2026 12:16:23 -0500
Message-ID: <20261119171625.1014004-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

