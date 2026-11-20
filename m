Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156748;
	b=h8UO7vqvgOARJLhuQis4fFtCOK+HQAOoM3J+vfjuj20YOZS+M/aPIk95XIySA+CZTLr9
	 0Pw5lqdJEd0jW370olUOU4pEGOZrNk8e7k00qFDkB9I4gqaQZp2cxIur7KLQQCjQVi/Av
	 dprDyGfOHtZDSxjaSF6YunmpWqiLozs9tEamwuakDZ+X6TEvytJ5VAQrzclhe6xqU9TBz
	 e0DWAnmJoG1d6c4H7nA+VEg9IDEQJnVSflp32M5Q2NyS+QocV3l5CsmjNB947tubZwXkh
	 XbRyLgp1vdOug+9Lixa4LjX/B2e8eBgpzZfxUdr/qsA5KQ431SzODUlUxLF9JoJMFLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tlnatvoZDEH3jFIVexl9EDSspyJvDOpu9N+OJnXu+ks=;
	b=Ys0YIaAGa5UZHKJk5sawMoy3iCnPknUJV47EjV4z1l9E6338eG3APVonkHhIekDvRowJ
	 Ltk+9PjNX/U2yChcxavSTXNlYhO+7LQtY/8I+LElWO5eGiMb+wsZqRpR/M+6huMuJ2AvN
	 u7sJe3RR60IfquEoAD/zDSRmw3FS/wUgGKMp1OHV762zUYaYqJ4q9ny+pnBeQu8Bna9cF
	 v0BIok9JGojFA47C//s2icpXoDOAvOMXy4HWULiTGGJW1F3cX865wOw0d9M7LvHMpqPzn
	 bO5XIiwIoJERDMZzuS6o1ohj6URswOGUKrJhrCwHiYcJ8w8rJz8SYjJsVHpHRiEMJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6k1M0aR;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F060A2602
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 682F060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6k1M0aR
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so530285e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156746; x=1795761546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlnatvoZDEH3jFIVexl9EDSspyJvDOpu9N+OJnXu+ks=;
        b=C6k1M0aRPe9oytqweftdi68u+f3yn4TUx3sVS7BqSmMm8TPNMV22CHjLWn66P6+167
         GgJG9MkEIPId/zFwPWYePE1zJRR5pTbn7U1xttJSGcPlGdLFhYq9RPdmCu0+/UPx47w/
         0WcK06TnlBw0RjUoY7uh/BoDkO9OmiaflzNniYqQI80Q3dT3lSq/lAPGUAWVbUFIAMTJ
         QAqRUgAWsC+xVbit4i/RE2NWWQwkkrUofsMCVDnQw/4Nj/+mcS0IdiZdMhEkdB+ySX2W
         gz7wNcNtoPE838R61fxWYEH3CgclgxmOmdhmnh+jsU6Ou7RA10wKVwRnSIf5Je6ONCNX
         Y17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156746; x=1795761546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlnatvoZDEH3jFIVexl9EDSspyJvDOpu9N+OJnXu+ks=;
        b=hSyDC64u/tKn6dpJh4O+0fmdkBcrHVPbqnQP6YTy9vyERqLDzMHvgX3/tmzPEUO2P8
         E8O1PCLqF524dTlX+fLAtPUCFrP+eETsNzvA3vYSI0VP8+liiIwrJrO8rSKTnLVJW/PY
         izN67rBF7L6mvnj8RC3igVh8SlO8HqYqIwOyNckQGlMdiy0Lj2/Ssi6E7KQDfA00KB8I
         BjAy55/0Fcl5fp0GHTSGJSdMTaAM222GYCA9d8SwhTieY5GWuqxxNHZ0GrYpnxW/Mg+5
         oknCGy/KfMii3zC3pQ5SSA119NmgzoJDvYQ9PnZM5xGOTXiVQYALKhYgL+RFXqC2fr6K
         hgMw==
X-Gm-Message-State: APuU4Z8FQ+ZCiJu2jRFXvtOHbm3i9L/bsKA2jTtSJTXXaZx9vgCCMMig
	s9sDYkWchWJn8erMlpyNFV8Bm04pJ1h9XdwR3ahgm9aZFAz6HaOUShvpdvlCbVpp
X-Gm-Gg: AZFdTZc9fknBZo6x51yGQymUhiTTIh4SXkJHYnIienPTq8faLXyQufQEM5ePbEZlp32
	Lb/aTOFMazdsRCVg1DXLKE7eQU77+yM8rmMuIYhmlCg1+iLJtltOEjM5uodOctCUTaoKquWEBMz
	6JGjZJPFROgL49FuKVhmzysssGmLzyfHY7hvXJiP7mPMBbjTaJbMHEbuJMpfz+Wg9z1z+fQ3oUp
	KcRW/jqVFycO2E2KdtUdUZroQoDloJf8NV1W+2MVpaew9qkrLJbXnKbehAdDBVNrOqo8KPUlP23
	kIvhutXCR6WS0qMRGmJmsJ81u7x9Nu1cs0Nvy2/GFVWq9LrPw7S88vvmnD6DRIBuj8rEvc8uvi6
	ZKK+NKpPtGmw1IBHrlncgOlIQuKxGqBlpBy4Oxk8tWEt6bmlB5LRgrMJuU9PnrBa+SfYZ51W4MC
	Lyx3tOnZQSV+swvGAoV65dSrM4foyIgDs9cyUdyhs9cmm3jePXwW/YrvFzRyGmiqB3aSIY/GVnN
	CkFo8b7yyH/1/pGJOgnhjDEzNrNMElG1B0XrxAZ/faN1QrrUXklr4aExvV9irudGV5ak7tMPudb
	NS7+nolKYqDqlxyo8xxKvl8otkKiNbsLnv8=
X-Received: by 2002:a05:6000:2505:b0:492:3672:eea5 with SMTP id ffacd0b85a97d-4ababda5370mr3999302f8f.2.1795156745775;
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 06/10] monitor: Fix LE PAST Received decoding
Date: Fri, 20 Nov 2026 07:38:52 +0100
Message-ID: <20261120063856.16585-7-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Sync Transfer Received decoder prints the
connection handle twice, doubles the colon of three labels, prints the
interval without a unit and decodes the 1 octet Advertiser_Clock_Accuracy
as a BR/EDR clock accuracy in units of 0.3125 ms:

        Handle: 3585
        Connection handle: 3585
        ...
        Address type:: Random (0x01)
        Address:: C0:11:22:33:44:55 (Static)
        PHY:: LE 2M (0x02)
        Periodic advertising Interval: 1000.000
        Accuracy: 1.5625 msec (0x0005)

Decode it the way LE Periodic Advertising Sync Established is decoded:

        Handle: 3585 (LE-ACL) Address: C0:11:22:33:44:55 (Static)
        ...
        Address type: Random (0x01)
        Address: C0:11:22:33:44:55 (Static)
        PHY: LE 2M (0x02)
        Periodic advertising interval: 1000.00 msec (0x0320)
        Advertiser clock accuracy: 0x05

Fixes: 228c945a93a4 ("monitor: Decode LE Periodic Advertising Sync Transfer Received Event")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 034a1e82a..ce05928c1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14059,17 +14059,15 @@ static void le_past_received_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_past_recv *evt = data;
 
 	print_status(evt->status);
-	print_field("Handle: %d", evt->handle);
-	print_field("Connection handle: %d", evt->handle);
-	print_field("Service data: 0x%4.4x", evt->service_data);
-	print_field("Sync handle: %d", evt->sync_handle);
+	print_handle(evt->handle);
+	print_field("Service data: 0x%4.4x", le16_to_cpu(evt->service_data));
+	print_field("Sync handle: %d", le16_to_cpu(evt->sync_handle));
 	print_field("SID: 0x%2.2x", evt->sid);
-	print_peer_addr_type("Address type:", evt->addr_type);
-	print_addr("Address:", evt->addr, evt->addr_type);
-	print_le_phy("PHY:", evt->phy);
-	print_field("Periodic advertising Interval: %.3f",
-							1.25 * evt->interval);
-	print_clock_accuracy(evt->clock_accuracy);
+	print_peer_addr_type("Address type", evt->addr_type);
+	print_addr("Address", evt->addr, evt->addr_type);
+	print_le_phy("PHY", evt->phy);
+	print_slot_125("Periodic advertising interval", evt->interval);
+	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
 static void le_cis_established_evt(struct timeval *tv, uint16_t index,
-- 
2.47.3

