Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029089;
	b=2IV4Y+3V0hBS5xHbCiUyJfljvOkCLaty00/VyEui+6iSYEXsbzHkinn/9jtSzUtSnPbK
	 By5nuC6hrKxdij7M4o5ZX0k4jmRvy/Mly4bFrzwMfm9CPINJeSDC1Ahd0g/yK39mGfJGe
	 X3HasCG9MrA+JmtDcGob8ZRIUmyTz7ZDEPTR6Rg9RmyNyBqVrgz3YlqhGv8AqrTI+fygG
	 Lch2yPFIuJOwjpksWQhDutv6hO7zp345fSkDlDBwfSuQU/oC2h+lXqtwVzMvIxV9rHzaY
	 IscMNJzY9BLhonqjgAcOs227OkD3efs6F875I0XmSGCFLQmit2M7x114xrxcTLjhHyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
	b=V7g8mjrBur10B5F82riR+3VCsvdT8NESC79J29Y9w/jwuvVg70vUEmPmTNs/Up0YUUxA
	 fFniECeB4US325BKxsoQM3kAtauQ6LBvjpwMG0Z9suzwXVEP+zYlPxEKc9RM9VWPwIuim
	 0gMBjv2p6LCa0hKZTal4Qi5jGDwtP8lP+DRjKF9NrjPwimopHcs8XJiqYAtbaHce5xz8i
	 RWhzOFvpV4Cj1kJcbRTPZIbBOrrbWp1CSIgF81dIfG3U/mD7H+YuotMXe5spdXiVcblz7
	 Lz4aOHTij17m+DnNJbTHqH6NsQvlMpprB4eqVtOXCPRLb8UrOjDgNFkBaIWEDkgvvww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tTiZH8KQ;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D43606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D43606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tTiZH8KQ
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eafb65e169so782804e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029088; x=1795633888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=tTiZH8KQwzZ1bwUxInetWwcJRb4qprd7YEhSA/QbHWL/YvFr1rWOVdfli9QTrBsHmC
         edCvCYqoJcsQ1PHG9NT1WqGJB1Y3yZXmWks6L0h+E5bnypJ7scQQjG8KD7Kgn07MCh3k
         dlgu/te5++hjoDdTrD3TGTLhFjqooa44yaTfFbvJkPzO2HTj6wEkvsRlclerP8gg4Qhj
         9Ouj0ZhEMJrQbLbslpLRAsIES2SqwxDP88avjWeq+qoVOhsaruQMNCZFF21O6+4VHBd4
         px1pkgQGur3Y6st4CDTRHQfcBkARffHbzKqTn9kAy3enn0P3COLQirlL4035kbUYBpOs
         PoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029088; x=1795633888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=NVWqKEzcI3CIst3BeVAHAAU8rXpnosj4RtuCcf0K46OyPIRPsiR7ju+yDi3aNQc3Ay
         N9DD0eweNk18DdtBsi41fGtUcGkgWNcVO9v7BJWwoKVfnavfdV3UEzO81GjAZ/tih9Yb
         Sl7z96TLxZ15fYqwQmX4bzgea5X2xVg48TWF/XXjnw+b4DHDoUYWlyb8uQca6X7MgENe
         zt2u/WMcA/sc4T1Ccu/yrFa3BFkNBodNtCJM2g3JlGvqQxjRiSbnUfOq672dUB4luRYo
         IRYWtC7jMu1AF5gGZMimEBQ3v7TVPhxl4oXRlNTvaSpygbmeet54Opcg8ll5DXNKfufd
         KGgA==
X-Gm-Message-State: APuU4Z+zbDoOUByrEl7H5H77jqeiSJai+7OfYK9HY7tzUgPr2WHbkJlP
	ebfqg+M7RFAeAU/9Kbbb7wvkSi/mKx2i4+E44TKvFkSAneThzlbZocskK/R5uATM
X-Gm-Gg: AYBFou1eTHkm1r12RCU+qmqZqhqtAomy5wcwikdwRKJTc1vKazsISOphUqd8xFI63BI
	7lWDO0VOHr9f/IDshhDB1aQ3zaDA8m5/I790qYVclLAjUdkTngwWhImRR8k1bzGjFvnZ9NgT4Ml
	1uAB5iMRq/0IDXII21tKKGQq+3eGehZqsp977JRsVfWjZk7e82KniVBzIU/XY8mV4Yx+htOmmxg
	1h08g2DiiUH84Elc1r/h25zupDijddoIBO8wuNu2u++FY9pC1A67AcjvIdw8proymnx4S1JfJD8
	JsQQo7tY61OQLL60GAGIfnJj4gAi3gzwc1RRKRXT59GtGloTIr6lD9gGsRSqBIlRF0KJwHa+a8H
	UPAkQF2nv4UBCfarE/lf8hxXH+xVDyqxS94sm7BwhQ2g8EBToWLxM/dMwdvuRCK6WcNzdH3JYTS
	sQEK7zXoqKOY1vHO8f6Kdli++IuPGG8EN5wZk7/nJN+u32rFXvqwN0Bce6VteqrRHiNsrT7pf8x
	bpxIdSfhPn2cK7dEY5pBD4beO1mWWAIM6iylU5yGSrino1MMpeAmZfqQQi1Fq+drxFnwizxzrEh
	ng+nrzl8FJaqEkWSA4EPXnbpImGGv+AteHa7ZKs9poTnlxYjFycb2Fslcb+EfD4vh+08DHBWt+A
	WRKBHtdBSRhxnfCHLoQkFH+h3LcBAMURq4WTBD+X97tdg797fPCOxIQu07mFk2Pn8ZDLJyK3RJg
	ZpFKc=
X-Received: by 2002:a05:6122:32cd:b0:5c9:ae70:e784 with SMTP id 71dfb90a1353d-5ee645f8252mr1991441e0c.3.1795029087649;
        Wed, 18 Nov 2026 11:11:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
Date: Wed, 18 Nov 2026 14:11:07 -0500
Message-ID: <20261118191118.318779-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

