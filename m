Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946844;
	b=LP5Vz/GxXNWbn9x2rxYkoTJPl2nsMQ3dstzOirMMhpxTdO0EmnQ3ZDy3elCJVzfNqtKc
	 5D4btdvco7nZDbzF6SBiRy9IokV3EhkjIqSmq6k9cMZO6t/juOS9LT8hw3B3AtXE2jO5R
	 feNLpSy0GrI4u+ctIgAAZROxM8lcyScYNqpDquVjxZcVN6in6zSrp/Ry0mdlWJNoz54Uy
	 qCJXuD2qA3L/P4cxMecUUDcpcd6I+TlX33x4SLwu4m0Vwm7mZbHO/s+U9ZMGD1hyY94LT
	 tlHictgTcyODToAQhsKUNOm4RFCmDba5sGYoOWI0VDaNwsEmMTwIcA4NPgr0D6d72Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
	b=xW6W7YW56ugJw40H0Oqgfm8U04ysxPNAHQvDtqZgjbQdooB6S0hP3ez6AcOADFqX+car
	 vIWBXQ9fLoBKv/Uqta4Xgx9Y5jUkmeWH8klAaD8r5zphV6nI6XrNQpCdqmTlMvBCUfLsa
	 y06TCYepitWxRlucfgkHjVbBX3CDr14TXt/RXpzJTsbQkpYgIdRs9pTsjcGBwzV0zs0t/
	 qoH6YPtyNxeSUe0Q66luRrHnDLZawEthDh45xC4jHbb2SMLlQ5KscQE26cvvxrzYgffZX
	 wV7UHG0K5PJ4Re0vrnTUo94AuTEzETag6kGiL1jcD7BAbKTMgIva4k6DCR8IosWLcSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RUqYv/X8";
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E4606A33B
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22E4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RUqYv/X8
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso130202241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946843; x=1795551643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=RUqYv/X81wnSnnZQZg/wxqI9IBGdK6iAOEc4LUYgQPFvDESWO2UjJYry9Wvo03eAkg
         at2OLlABid1WV9POYw5eR8t0uW3CEfF1CAEflnpsRtar8voC5+2DgjgL6LUqtsz7HDD5
         MOX31KmLFhzeQC/teOczF2szfXb88SzRZU7tzdl6aTO3/KwkT0T4Ap1L5N6H1cKDOfha
         +Pb0Rp4jqhVcC4/jOrorxOid/mmea3Wd/80HswKOmQeaIiXBA9LJiqohg7HCxQEG2p32
         +45p1sSbFC0uEhbfJ8k6zzwEPjKWebJgnSGy2AIdNbPafdk/7sG0gk2MAvsA0YEzHKxC
         RirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946843; x=1795551643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=HpT0c5R1bYVC5DhSv2rNsE4BcENF9Lt8uxrOab9ouDMXXoS/xpuyyx/6qtJugdbYoY
         Ya/jInHOa1CXyPOb8JrhO8Ns5Wu3X4SppCet6q3VZOXJDRgv/iXvFtk9IHKbAI4JsOxn
         jByUQh5ONz7jm+mXXFxR6h2RziUWuqD4H1Fzzu7nBFHC/rPYC6R8VbcEWgAGpvSW9Ae9
         2pbTP8BiSZgY94BXEUlqEWdq4GgjJMs4/jCRhQcnexcQcikOTY74NnhtSHHbP1TN7L4z
         s18IkrbGo3zeofYn2TI54lW78WfXeOjdOAdOOcPtiAjz/WGvtRILITkKf8WdSPtv7fp4
         HdcA==
X-Gm-Message-State: APuU4Z+Ti6w6JVX/2LnmNQDeB67tSKiDnpLuWiAxGuSUJaHhI1o0IPSc
	4y7qNwDSUB+gxfJZ7trtYR+HmNIGsKYua8xy7H0TNuWTqaMPwXa/4TCkX02pBg==
X-Gm-Gg: AYBFou1j4wK8Rc5+BAn0SGLEmYon+YXGTZ3ZFG+GMlD3Qa1KyqIo3V65lmoWPzZauE5
	RtTejsiIoofS1yFVdEh6bs165KsX36GvwkivEzimoipEHx4/vQo/BqOCFkyGaSmU7IHbYUbwvg8
	8YICU4ZtwL5CdDRiaSzpt0vJcReO60cAIsA6OaO6MXSDxjBUpeQScm8BivIg5QK3H9tCs8m1rVG
	UpmFNc4SzqWn6/NfYY5d9Wp6ckDD6/a9mHR1zsZPLabB67/0Vb/LYv+9/4/b1AFQAnZDPgYYlWB
	Knx0FSmJvq2KTmTBsQ/GrxVGjHvWZnjE4n7d/l45VMO2K3tXHKqujAcY2U5QMBg6rAKXwgGodd1
	xa/BU+X37lHobF78yJTzOh9XSz6AFcpSvmJHJlfllqZMiOFuKaPo//OQpqh4/Ub5BvzYkP1PmO0
	Q95M/VNCdNd7XlEjrUPBkkoT4k+6cVX97vQ7FVMyHChrZnBuTdkvM6UtLZgEejBXfzl5giZ6of5
	bnLjchucE6zaUFEoS8/vVpn94+NRwONdBeUBmOX2h2USSjedQuYVP4Zl1HdO9RsUAaJyx0KPWN0
	fL0XttzYjvt3B3GmuuSxORPs/+BevkdrG7sJm7M7E+XaPOuzedIUkIayUnWBna7ItHZ2AlzC97F
	2DRqDRV+NjAa4cLHWDXBJ2rPQMA8mdh1RoEsBo5uO62dpC2r6f6Z5LE1Pbh/XeBm4uZQAYPt5Xk
	avcao=
X-Received: by 2002:a05:6102:5802:b0:7cc:21cd:9b68 with SMTP id ada2fe7eead31-7d6ba407009mr58667137.15.1794946842751;
        Tue, 17 Nov 2026 12:20:42 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
Date: Tue, 17 Nov 2026 15:20:24 -0500
Message-ID: <20261117202032.3848411-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

A zero def_multi_adv_rotation_duration makes
hci_schedule_adv_instance_sync() requeue itself with no delay, spinning
the request workqueue. Reject it in Set Default System Configuration.

Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 7a2cf893a515..51da6a7ac0de 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -281,6 +281,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * (32 bits), the one of the GFSK PHYs.
 		 */
 		switch (type) {
+		case 0x000c:
+			/* A zero rotation duration would make the advertising
+			 * instance scheduler requeue itself with no delay.
+			 */
+			invalid = !TLV_GET_LE16(buffer);
+			break;
 		case 0x0021:
 			invalid = TLV_GET_U8(buffer) != 0x01 &&
 				  TLV_GET_U8(buffer) != 0x02;
-- 
2.56.0

