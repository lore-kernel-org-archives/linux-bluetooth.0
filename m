Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064473F4118
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506944; cv=none; b=bGqxQ7SnHed21ayTrRPdxhODsKTXfBwmcX7tNmyPpo7sJctaCYwWh7SUfluWMgaT9MW8O1Zxd9f4UUS/J1xGfeGX1LMfLGEDBm8RD7CGGQJFXOccvHlgpeiLa3WgIwEW7vacBjKsMOcV/ISYaEjLaYDvAJxIqGSxekGPZq1iWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506944; c=relaxed/simple;
	bh=omiOEkEhI8Fj5hRBH9CqmKtj1urYsZNHlSflhRkRiG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0y6CesGHaEh7V0ggHIAmF1jV/RF3VRCOPUtfkKKbJhg7Wlif0CU+v7OeozmSJ+xdsl3coeuWNRuWrrItIz94mCT0Bi9tdzCTFhtBn8YLaWKb4aiA51s17Il9oLKmUVGw2l8x7kMdT/lZ/IOB7qddWObzgseA0PptFZLD7t8UxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud0Yb+Iw; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud0Yb+Iw"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e9d8a79acso141232241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506942; x=1790111742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RUAWXITjfx7ERTDrTX5z5wxxX9QntmoRZPdK0pkBTMI=;
        b=Ud0Yb+IwxIdOE2gm9KXgYAj8FjkkXQYL18gHCTw9w5Pti/Iz3hacCTQQH4dYzVtXC+
         NtQ5y955L9fMYsyo0/rdfxrW9F4szNvePzsoC1hD7oc6+8RTdvox456nWKL+xGKywNBx
         YRq/NUkye5K94fyRqEmNmSr+hxuaFcuJ7asMFT2N7GPscM7WDGxg5ZAo42+3P+htMq9I
         M7TgWRF57i85z2BNi6ziArYUbiORb4bIGP2vvr4ObYt142Uqzv6E9VhojCWFk1rFkgiI
         7tg8oYhwgE36TB09N4ObwWCdFQoD0LfMAyF1MseOhCznvRqZx7EjE9a6LkXFOuQCPdoa
         B8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506942; x=1790111742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUAWXITjfx7ERTDrTX5z5wxxX9QntmoRZPdK0pkBTMI=;
        b=Z9gaNbbkWcOw5LhBnrImDmMd1ZHGaB/Q6cRWyuuvhAHSx3bNj5YIRIgMAibOuNfQ3L
         vgtyu8zGV0G1SESbYpCK/mxm9VQ/EvyYYz2eewg1z/lvIiIrByHvhzjQw45WuWlAA+yP
         ZUMh6ZLYy3ixXYOTKPLA6JZA7k/sAAfb2pISq+IE37YnfoxO1YJmDPv6evyw9B5ZVCnO
         Rg1fH4uvx83E0Dpz30CEM+zHn8MKsIvv03RJztJZGCTJuCMAkdlXAF9pwSUJ21sZv8IF
         y7iNHvWpordwhJUwZFN/+rmy1CL2NocHRx2pUsXVi9UmIdVoR/S1tWuJ/MpmC4T+0GFX
         Cihw==
X-Gm-Message-State: AFuF++kBXsv8j5lKC9xHXT2XZxLjlNlEQ96HdleK9uC2iVJGY3jz4Qgw
	2ifWCIkbDC9eYyluYoSheuCYt4fWoD8iQOG6GbcQfizM63X58N+bwl2kSO8pBu5w
X-Gm-Gg: AYBFou2qZRMZXuqAx9RnTxN6y10DQDY7VMZY3SqHJ03a199HnUPEDoNHpKWd3yi7l0h
	DQQDdX3qWgVAmimIhHLtsNx2RxVg2HW3nbBPwf9cErP+ZLxG72wSjsaSiqEE9OU4spxIcu6Kxwn
	TLg7241SCWOnisWl92gwPfps5P0Pcs80UJEhrw6Q2xjkc6mSblUZKU/JDn0doKJp9IQvk9Cmj3/
	4RKCciOmPO369ARfF16DfWkPmhtGYi5Eo6TCHV/lbcsUuPA+cvEq7e2UEO/pctk7SOC9Jjv6E6k
	uYrSShVCIYkRFJoKAUD024SuONUCFaJkwsAx/Hprnmb1+zzzh6vXNojm30+wkqt2QFB1PDJcVhv
	gIQqt0kUi283rW4lv4BnJCe5qThWamxtOLFGqmarpJ8m6jFSKiczhXyJjmL2C93JWOD/rY2qP05
	f+BmxKPM9PRudwrfXg5L/YYsBKgFEiT1t7aF+4UanKsyfpPu+B6v8MtuiKH8sq/jQapEFMRqizH
	T2FwP025/r+KtLM4GLjHW4vP08KTsjBPUYH7DOwiF6CLd6u05SLNWeXG1kCP4AbLw==
X-Received: by 2002:a05:6102:2906:b0:79b:cc58:2973 with SMTP id ada2fe7eead31-7a0258af404mr467431137.5.1789506941796;
        Tue, 15 Sep 2026 14:15:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/11] test: functional: answer the notification registered by the victim
Date: Tue, 15 Sep 2026 17:15:21 -0400
Message-ID: <20260915211528.1223784-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The AVRCP target of the NN-2026-0145 test tells the victim it supports
the track changed event, so the victim registers a notification for it,
but the target never answers it.

The request then times out after 10 seconds, is retried once, and times
out again, so the victim only sends the ListPlayerAttributes the test
needs 20 seconds later, which is most of the time the test takes.

Answer it with an interim response, as a target would.

Assisted-by: opencode:claude-opus-5
---
 test/functional/test_avrcp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/functional/test_avrcp.py b/test/functional/test_avrcp.py
index f6ede96cbc0b..da892d1e8be2 100644
--- a/test/functional/test_avrcp.py
+++ b/test/functional/test_avrcp.py
@@ -70,6 +70,7 @@ def check_avrcp_GHSA_m2vx_pw5f_rc8v(bus):
     AVCTP_RESPONSE = 1
     AVC_CTYPE_ACCEPTED = 0x09
     AVC_CTYPE_STABLE = 0x0C
+    AVC_CTYPE_INTERIM = 0x0F
     AVC_OP_VENDORDEP = 0x00
     AVC_SUBUNIT_PANEL = 0x09
 
@@ -213,6 +214,18 @@ def check_avrcp_GHSA_m2vx_pw5f_rc8v(bus):
                     )
                 elif pdu_id == PDU_REGISTER_NOTIFICATION:
                     print("[*] RegisterNotification: %s" % hexdump(params), flush=True)
+
+                    # Answer as a target would, otherwise the request
+                    # times out and is retried, and the controller only
+                    # moves on to the next one 20 seconds later
+                    self.response(
+                        transaction,
+                        AVC_CTYPE_INTERIM,
+                        avrcp_pdu(
+                            PDU_REGISTER_NOTIFICATION,
+                            bytes([EVENT_TRACK_CHANGED]) + bytes(8),
+                        ),
+                    )
                 else:
                     self.response(transaction, 0x0A, avrcp_pdu(pdu_id, b"\x00"))
 
-- 
2.55.0

