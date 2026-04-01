Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6C310651
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059327; cv=none; b=dcZebrpMQNZbHN7JQ+v/0FidImndKWMEN7DrpxXzD8d9N0/wYWNaL1Bhr2vVJK9iq9C2937QxrgIDjZiVpgmeYhjoLgN/oZvDkYFYYto7vM7NT9wlI0Fqu50mXyT6aa3J2j0wgJsbBMXZr0Fe32yIoEYOOqoNKSFq/TpsPK3TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059327; c=relaxed/simple;
	bh=c6KcwUhEaB3GxfK39sAC1m4TeYiq303Y2Wweol86jZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS3zjxrvNYVoOHEhlR1GP0U1H0Fr/yiYTdU2IbmMfNLkWsK8vnFvgJDjOx0gU/AZv1JHhYnjUIpmeCmoJRB+L5WX8NoULxLVCzssCberUc9D0svJhI/NLefyzmWRCKtusm311c6W/UPBNtSY95JvE1HEDsz5uBz6uBULiSmYwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIUDQ6Po; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIUDQ6Po"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56cc67e01deso6255878e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059324; x=1775664124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39NO9LM5M4+JfAmibapQoXNzpe42l+VL3lxI/WnojMc=;
        b=qIUDQ6PoKSaK72ObG9nWfh3BDNnZr7EROthdwtyiY0g8eISKnS5dK5Ul0d4aO1TzUa
         ocpLJIH3v8+LA5827WxNlvutGXaoBcxJEDIHFCScctBx25uRSwKT3RCm43BJdrx5gwm5
         5q3xLJhYS61UvDnydtbU2L/TJjzsjCUFCGw7hxRAEYSAFnLPA05pPwhbmfR35M++hGKh
         L3g+W0DH/XfjB2+9iCsE+utGbFOmZcwS4GRRqIFr8f2U9J4dWsNurrejPjMDQSw+d0Wz
         BU8O18j/8ibVg7jpXH4renfZ0zB4YBq197lU4RON09VCbL+EWZQViOBvF6Nn8unz+NO2
         1VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059324; x=1775664124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39NO9LM5M4+JfAmibapQoXNzpe42l+VL3lxI/WnojMc=;
        b=qfVOLdyInDOybuQA0HK7S/KxgGKKUNyIJVlLovkAYF0thWD1k8/n7u73iM6+VUHxC2
         76RuAyAgF+5l60+bpk2Innp3fM1j6ALpzfrIYfU4uQjMO3iOCCIrcdeRlbX3SuvMdalM
         TWM0WXnY7NKEDAGl241ag+G7Rd7xeW/4cRwhKWjMfQ6Vr1yYD8DDamfM17/5rICdzZjL
         zIIUWo9kphnv7ds/6WZ63Wrr2hdpDOQ3c61r39zmN9xp4DW/qfu6RclJOKowtSMBR2nN
         N5HOHf1M85fLyPULgAI/Yz23tQO8J5MRUMcSIE4Q41FNkGfbgzxY9W5jylD+/WHDN5nu
         tjvA==
X-Gm-Message-State: AOJu0YwG2g8sWDYt1B/cuOMQRLDt4BBcdeYzfYurDjenVUwVla5IQwXy
	/+dufgIWT3W5VUNol+z0gLi+kHoHN14tljfdy5MYafcPhs4K9BfVcQxsKMjuZ7a2M3g=
X-Gm-Gg: ATEYQzzk+twKm6DNb2ssq9/K4L+/2m5xCraN1mDBVBT2e6gn+c+aSK49xvALLcHDSiw
	Cqcso79J9DjJJILWxNHSZnOUBZDIZ58b2BT17Wvn7JQakWkDUVBM5CWNCGDPFSMPB3r4kGp0QX2
	d7+gVOxXaeRLCK9mWC47kWU0RGxZQxfAxA7hnLo2Rr3+0Q+q63hK1XbGIxRIOZYvlJdmNBB8YAN
	7sJ9be+d7nCCKeQ9wgg7lYZ6kM2ywiYfc8cn7b3pJn/pG3lAJlNKcq+hNG3hKj07/cSNEu8eRij
	9o74hfxaqkdV3GGu0nIkZYnPQhfnFYUrc1av6ILL8IjOZgs9bm8wA5hR3058alTOW57jj3V78F9
	z0WrWLPzfvO07tsKBKTa13d3QyAHxP473ablgeNkliQnn4GdEQPz1GkrdPo+qTXaFNrJsXF7o6m
	2Aj6VTFkNc2WeUXUvNS8lJVi9Dmm/ymnqdWUQ0lLzPVw/QyoO9hXJhDxbXk6sLq4aslaRxoGyEL
	uIQ+7cgZQh6R/R9JA==
X-Received: by 2002:a05:6122:3789:b0:56b:9188:5ede with SMTP id 71dfb90a1353d-56d8aa7dd02mr2083006e0c.14.1775059324374;
        Wed, 01 Apr 2026 09:02:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58893d37sm17907391e0c.3.2026.04.01.09.02.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:02:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/3] Bluetooth: SMP: derive legacy responder STK authentication from MITM state
Date: Wed,  1 Apr 2026 12:01:52 -0400
Message-ID: <20260401160153.1980387-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401160153.1980387-1-luiz.dentz@gmail.com>
References: <20260401160153.1980387-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleh Konko <security@1seal.org>

The legacy responder path in smp_random() currently labels the stored
STK as authenticated whenever pending_sec_level is BT_SECURITY_HIGH.
That reflects what the local service requested, not what the pairing
flow actually achieved.

For Just Works/Confirm legacy pairing, SMP_FLAG_MITM_AUTH stays clear
and the resulting STK should remain unauthenticated even if the local
side requested HIGH security. Use the established MITM state when
storing the responder STK so the key metadata matches the pairing result.

This also keeps the legacy path aligned with the Secure Connections code,
which already treats JUST_WORKS/JUST_CFM as unauthenticated.

Fixes: fff3490f4781 ("Bluetooth: Fix setting correct authentication information for SMP STK")
Cc: stable@vger.kernel.org
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index deb8dd244b77..98f1da4f5f55 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1018,10 +1018,7 @@ static u8 smp_random(struct smp_chan *smp)
 
 		smp_s1(smp->tk, smp->prnd, smp->rrnd, stk);
 
-		if (hcon->pending_sec_level == BT_SECURITY_HIGH)
-			auth = 1;
-		else
-			auth = 0;
+		auth = test_bit(SMP_FLAG_MITM_AUTH, &smp->flags) ? 1 : 0;
 
 		/* Even though there's no _RESPONDER suffix this is the
 		 * responder STK we're adding for later lookup (the initiator
-- 
2.53.0

