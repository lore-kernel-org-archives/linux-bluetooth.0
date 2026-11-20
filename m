Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213614;
	b=v3vng6zdgRUReLaj2uzt/Ya5fFSmGAGYyqVazmIp7DFkAINDmmFw3dWQjnRtSvUrAWEW
	 WA8MyTiPTbM16mCJZo8SjbnWTSUGdpx+mvbTiDyeqpBDPWioEzXRfxe44wrpfOU4/dQmw
	 jM5gu7IP9r6tMYbFun9AYFKL7kscREve9SdpIOl5b7LBNSkn30Rz+lL0xKqqJ2Zqdu4XS
	 o+X0alg9NRUaZZm0mBbrlppXg6VWJI62oWZBjAMfSjUsKQryJsZ1RC9cJU/GaOiN6irys
	 OTlNKEGdBPVUPC/BC6cuDhj4eczzUj+xLUjR3iaMsthPe0Qp+a6Pazwwxn7UCw6l2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
	b=it9Iw9BYCTeBjiZhmwWN/9YMWdsV0s13SsRa96BkBF84f8ykmTTI2gyMJ++QzhCDEGNM
	 ukWOoxUH5/XimWHhyY0E9eYvPFAmgLVmMWnD/U7bl/w0goKT/nfprbYD/aFvHoeNZE73j
	 elxxP3osyru692xfoF2wZY3RZfUOZDIA+xWFi+RZPBEU9SeS7exvNjWE/RVQnIovmD36L
	 0Gbqbs1eBpwctHviOOZKzXdUB+HjjS3edSipZaR74vtgoADqfexSU58Y1P5VtwuDl7nDV
	 KD1VUdDKe2u52PlNSRWe9JkYTl3JaYQ+T5GbwEPIc3vsUpZ8tShK51RzzxtbmGDavUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PXuFLq6D;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A2606A686
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3A2606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PXuFLq6D
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso2964065e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213604; x=1795818404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
        b=PXuFLq6DK8ErVaho4C1H+B4138AHeVmEPM6orrdPgvfG7Y1MCPQFnWhqNalsR64Mzz
         KuD3QhKGVk0Uaji0snWBOTKOSmIfTvCw0gZX/NVT/gIVJDIiqJmuHL2lO7yUJtSX4/oQ
         izvloiwMzP7y4LgZgqMYXrKpcLzhRG/IHlN+2bOutetk3HDLw4jRjyCRqBUlA6yfgMFK
         RhiyXFj73bBCzv6nM7H5nuymDXcsK33XJ+AeCln0iaGm+FqTlUjipSrGlrmjVySJIeOc
         kaitDVoh8nhX61rJufMY18kp+W4COVqyZ4nw/IrwQHwkegcH1dwkOoVrCsoupOuUjyqm
         pczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213604; x=1795818404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
        b=q5b/gWC6Y/5r+FEeV8SwdGnp1OzpuBWfhe/tVvsZ8+xtLA0F/ughMUaOzrkdBr3lTf
         nMT6v6ig8Pnif2mRWta+9KlGhtHtSC9UthklmHBXrzh6U+XS7X3HoKqsN/EurGa1vB08
         i2LNV5op5oUleBuwDraNiGh+6kDBy8VHqyA3Brw+LuL0eSCOCazzXksDl7XO0h/BviLI
         vPFf23Qm9MqA2RX7j6X/D/Ysj6AafSvw0P/VMQGPSln9pzDUd+qxiQUvNPC58OFzkPMU
         tz3uK7K8IRAxInJ+hfEutuhKbTKrdGQyCQrPFexlyXJz3eHqa/h/79zB1VqLIWuICpdO
         +bfA==
X-Gm-Message-State: APuU4Z+s1vZpwf6gnDoV8CnaTrGo0fKZiewqZ433sXakq7Expm6fTtqd
	vcs7vA2P8xmRaquBUt/b+2fgNYAiIpmfQkbblj5AYfqW7FgkhOExAtyLJH6Qvg==
X-Gm-Gg: AYBFou3Ax5wHN2whJ/8MGS++pyM/J4lNGSod3EOq/ihZcciN07w7KRlki8+yiYrqnrB
	+z39Qm3IOMzGHywcSOxq0qHp0leq+ryTsb4ksX18CQrpKA+VxVO5fTXJ4GACLlCjGwfz3BBOh7v
	h1LgXs9vG+dkeWsxDLUipDM27I1tkPEzIGMmH8jGzX/fwAgLlGHyNxqP4J1Qq0tdoD1PUVT3TkS
	wmytf5pizWVcT/+0HSM2Vv1aV+FiSqrfViO2hJtNQ66oNyC0fWShT5BRmnOAse6VMcTiMmEWe+w
	aTDxYeXuTd/nVMb8WhPrWZ9UZEZ7zyltypbPawQZeo8LVp+bsNnZdUdK++xDTgujqqd5VT75zWx
	7ofJJQzr9/lgZ3127cJakWLqIX7GMMiWDWC/Kv2msc+/KO8k3ueQCtmLxmk9CbkTt6+6yVKf4Zu
	xoOcFLPmrOmKhqAFBZC+00+sxq/y9F8rurbB/Q4JhmrhbWE0aMai1S57/7mHa8WMVwv4+Pbetg5
	nN2bbEE/K/AifukyhjwdC0xO9LkNVmzcl1zsqepYNH3TaWh83juacr5hTTyKplYLWBKeno0Wa2C
	sIkDwfPd8mOBQ0iJDMCEyJ7GZz+upywJ4eA8QUkycYUs5Tn3
X-Received: by 2002:a05:600c:1088:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4bb887f43cdmr79248305e9.2.1795213603624;
        Fri, 20 Nov 2026 14:26:43 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:43 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 2/5] monitor: Fix reading Flags beyond empty AD structures
Date: Fri, 20 Nov 2026 23:26:21 +0100
Message-ID: <20261120222624.150321-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
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

print_eir() reads the first data octet of the Flags and of the Security
Manager OOB Flags without checking that there is one. An AD structure
which only has its type, at the end of the advertising data, makes it
read one octet beyond the data.

Fixes: 854c945433fc ("monitor: Add full EIR parsing support")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index bce3bb819..4f63cc0fb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4437,6 +4437,8 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 
 		switch (eir[1]) {
 		case BT_EIR_FLAGS:
+			if (data_len < 1)
+				break;
 			flags = *data;
 
 			print_field("Flags: 0x%2.2x", flags);
@@ -4534,6 +4536,8 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 			break;
 
 		case BT_EIR_SMP_OOB_FLAGS:
+			if (data_len < 1)
+				break;
 			print_field("SMP OOB Flags: 0x%2.2x", *data);
 			break;
 
-- 
2.47.3

