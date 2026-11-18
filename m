Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010727;
	b=p0fMCAlYZ/ra9EA7i+BGw98PPWTnkf/moqxLj9fXafa6AfiM1R7M7Gq8kt6PMY4idi3h
	 eEkAnqaZaEk5Pu4vhu5WY3vBs3No0c7T1rwtLOY1KN388V19yTIUYauHqHYO7vi2Gl4AB
	 fIriSz+pn1OBoz8LX65y59gIGDG2hlVLuLIBwiumTJrjcJb8JuAAAdJXZp7eMV05VyoKs
	 ig8Yc6/9StREWIRTiXa1gGBROq4+7l5Cj0DNzdGeBuBbWd5QCGUDAVPFVnDUKjlGnujuJ
	 oBrmuX6ie2dtekj++Xe6Y8dSYczfl8hPMjIdkMqHbNLeLn8grMaqOE0Mkt5nbiI1FnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
	b=B0girOZfQ5UbwuczCzLAExT+vZ0gDfMVL+veucL7+0e2ol7TZSu94e/IpIOuwRjrSoyX
	 3BoVTYJAxvgkBZFPabtHzZLhIJRYbEsE2Tz4zNYGIVHkh0YiW6NjMVAUxDYO3F9AwUBrt
	 oFcCMrgYanl9qSEo7ZFQxI8eH+DjrtHcJ8HSNq8UmsAi+kHZasfypmlZQusZ757AGR1MP
	 4B2AJZO2jLCC6vYRedL4aIDiSnCPlCY0cJ634Q4D/53wghl8Fg+Frhz8hdZp+ECKz4GfY
	 DOq+snbJ3KKqS41PSyrB+yC7fY2coJTwDvIfJ0ELruSuhdsWkKxKrtXa6/TXDAY831w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2wSnV79;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525060A260C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D525060A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2wSnV79
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2b25786d9so542895137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010726; x=1795615526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=m2wSnV790Uy1pqDokJ0tzm4B18VycIgcn/8Fqd1H8Z+Tq9orqU+OPjmfomr1flSef6
         A0i8z+9WCt6SHwpl2+pNaLrHfbhIV/Q3i30JmDmiPOPugdr/X1u/2RAEeurPcP5yDKAI
         Ff+nNLM+tCxUQQp/qiCCuq3dJZwpRONl9t1maghuGl/E1MQsdSyKg2Oip8Q8hrHqFCaw
         7sFSkW51R4XSuvC1/m/yqoew+NJ1YwS+D53vd/3ts0dWRHKlKuwHv2FEccvAk0ZTR4PC
         HPVgFDMiS/0PokV10O7AwNjW3o8WFaq/z9In7gLGQ+8gL7aOGGLd3yS2B6GEqN1l7I9E
         vV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010726; x=1795615526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=AYMbxG+zGnDKQnL1F/lMybD0gbTEl6UKAYm9ZvxnWX+eZPosckU69FSB/fhQvXKcK0
         piV72QFgX9e5Tsk1Qm7S85+67bHLWR379Mny4ONd123+HE1kltayssaJ773bYo1xoOQI
         9d5iz2VXTqceZVB9NitgnN8j3cJTQ888mEDiitm4/zca4lZ6s9uDyzuA61+OWDbs/S+V
         Qpn98S3SqclEd10z+2HY7tNe7k5KKlUjoXeCoQYsh4z8vnYxHrbLr6h0Yhkf0HhgLydy
         zzeJAsgq4eg+Cq/2UmTPNa0ftMTmDN2lcR3TU+/xF2q3I0hNSg9wMZqqWkRg8gDtG/2+
         nI5w==
X-Gm-Message-State: APuU4Z9EfX8D/DFEikiNSx9RET+PJ3br1meaHpIskA9QEv+YSmSjvIpI
	aulNact8gyyUdOI3/sCoBZ3oLsKo6cxs5rzWHHrIlCFFq/CnoxC2086tLPuzeLx7
X-Gm-Gg: AYBFou1wUqv7BVvut3EbU69JV35grxRTrA275wvUU/X05C3wKC2hustfrwionN9M8qL
	sJ7ZQcuQqzeTRR0kpGryJyTDPk4ldF5ic3QxcVnosXDR+gX+D+OutXYFgR9EjczQvpP+/FVbXFX
	OXFiaIdpkYI1ZbaAsGanHmxixE8T0t63DYRSGA+3A3Gd3uNWVrheIqLO1fcJXMvbzkxGcF7kC9o
	E5n/+1yd78zPiIZUfCsgru4PDRl5GbSPqgEb3sHrtlLs2UAN3GL8OfMgO7t7UviYb79mgpdnDpS
	y7vhZ8ABdsao/53DOhzxgLN6VvtCc1VnAnNIJydZUDD2mWMWgCLbiDzx4ddmKnZaxptaWGMORVV
	e/bC9MsbPbM/3eJGsoGMrdKB5fdOXPccWP5yc1FD4d7UoVtOYjzRkiPza9CWAGjgpiOgiVq1/WV
	KUQwACANLWH8EzYpMds/8T4JstVo34AntCMcFqggXEk0RZcBLEai31+YaAfFJ6+AvDjKZESxVS9
	izKYW6CnPDMbdYN89zIEiRaNIm2fQWNOacg3QWzs3z5ObJPhlGXHcyd2uM3PX3390WsmrHleSJ5
	KRrAm75LQiPROsEhwJJv+SshBj1bnu8azpNE1jeY+kMMypW2vEJqitXX+RVdueSkWxnTzR4b+jh
	IaJCCKlDug01Jsvm4BafYWQ2VcLs8SQspxJ7FbiUBWtwCt8/P0j/qbun3wbR+Ru9/POUZJvD+SU
	IFg7NIUADwDfc9XCCZrQaaJ6mG
X-Received: by 2002:a05:6102:1499:b0:7d2:c786:5a95 with SMTP id ada2fe7eead31-7d6ba3bf996mr948578137.13.1795010725434;
        Wed, 18 Nov 2026 06:05:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
Date: Wed, 18 Nov 2026 09:05:07 -0500
Message-ID: <20261118140518.59878-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

hdev->smp_data is NULL when the SMP channel could not be registered, so
receiving a Pairing Request/Response with the OOB flag set would
dereference NULL through SMP_DEV().

Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)
Fixes: 94f14e472812 ("Bluetooth: SMP: Fix trying to use non-existent local OOB data")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 88cd86f742a6..7e0be869cc74 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1766,7 +1766,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (req->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
+	if (req->oob_flag == SMP_OOB_PRESENT && hdev->smp_data &&
+	    SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	/* SMP over BR/EDR requires special treatment */
@@ -1962,7 +1963,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (rsp->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
+	if (rsp->oob_flag == SMP_OOB_PRESENT && hdev->smp_data &&
+	    SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
-- 
2.56.0

