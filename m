Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946842;
	b=cjdaPXjmwYlH1Y7I+qDLv4YZEYklzbskrTm/mHZ/crRfWLlNUDyQ7fB70AQ40ZJgZWs0
	 EVpqN01nztznrssgkt1uOFI0/OOwRxHrKEbOp7zfK5pcRKGR1ytddIF+p4Qsks3dfxqJ/
	 X/rcHvMwqa9rWMLPs2RI4jBYKsCSBwEggvaQ9DPYsevMB2MyEkiNILfr60X2Ke1wfaFu8
	 AAORNuoRLME+KGc3lT9xM8tO62zrmQ1OyITIL8HhOOfYbUvtJ+KyTMMw4b3sSenqdx0gP
	 W2XjfEAmLXP1VCNarSI3pOc/kSkwsroQnyptN906Wbv2JCLcbxYP+Wzg7vHrc5sgZYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
	b=blm6q6YczBiUjUBfSS15yNsdrgU8CvyBDWcgo9s9CwW8f1ffiYmQQtGN8KK+0HIuMDVI
	 fIUW/Za3eXnbWvNXgc3YCPzDl3HI41p7GpUC3ZSak7Sp37ziMOiRLeBWCxbE5i4YE5FgC
	 LDbQSsMhBwG/AQf5ad3mYHgCY7jgIw9hpi6/P7Zr/DXEcJhgk8X2/eoFKg21TUPcsbL7Z
	 sS2oRPMVynSsFIKaaKYqQcMqZr3lxntA3c8tWfJy0qlyqpEk9lA0SRDRKgn3umytAvi3A
	 6RPlwnQWaSs0rf3hZvDpjG6D+1TGZp+niPKtnBAi/x4rtjGfmeAhy0yL/XZQuMrZ1xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFFqH4Ew;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6777606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6777606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFFqH4Ew
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so84443137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946841; x=1795551641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=xFFqH4EwpkHewl766wuzmN9n2qm7VQNrr4CWKQlxiGmj8p69+gxOlw2wGytL7lobpm
         H4YaVyUpqAsZ/mqcq6xdFW4Q3FHtjT8Hag2DW2eAF/7WZuW9Njuga4HVMEhqfiw2mGpi
         cBWaOb1zOaKg5eLNu5F0TWdbbIHchhl7Auv8PwU9sDCMu1GfJLI4hdXc2NzOI+kDWEXZ
         6oOMzlIHLgR0lfdnBJaTv7UQcHSvMgfjYwmg1/WIXIto6MzVkf9WOGO6i8ES5LORqd0S
         O/xWpIELVEl/IOUhaj3RboRF/MVRU3lNZZXrCMASn5LnOE0AN+w1KXaf9V4KL7yB3UYz
         CWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946841; x=1795551641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=ViaW/mF67Cl00OP/I4Ppnlxv/LNCiCmU0HG3+XNvWcIXO+NlZL8LMe9ALv0/Y1e3Mk
         l9rOvConr9U4G0j6Wc/vh7Ifx7ltCGReZpyAKgcsi3S6Ke9FAr2VjeIwg8ME1bH8bix8
         DR1fpSsfhcHISuKbJ6Wcimd08C6nU1KhnR9KlfNW0Ai2M4oURWdAnDZTkK4V2LjIEQy9
         71DsoHKy2lU+g+zF3jSHwSgIvwmxT5eHLxsNj1PRZwuat2swI/vlI1aRt3H0U0Vg5OJe
         teMNk9kudA5+AuhwOiJ5qLHTvp6vurga/wblApVGW5Xw0Bi8EiKUNEhpjtOslJO1Eez2
         6bsA==
X-Gm-Message-State: APuU4Z/jHshmvveeUieU9A59Yub+3uVUX1Fmx9yqB9nRdh1fjYL8HL9I
	RUIDmceIZvSmWhvoVjaPVK976oLGNIYLo5Z6zMGijqvUCs2PyPDYtJVKZw1n/g==
X-Gm-Gg: AYBFou0kjL4DdnSRv+rFsH85WfAHzHjYHSdVJhZ7rmnVVnjQ93t6pTCXkGbgu0dWgHO
	peKnnl51hNYWSFwZ5tlfiVwoFWbPzDgnJGMNLFlh0dzCk2IKuegqy6VmswdkpcV7sYWKjEcj5XT
	VxICMlegyNgDS1lr7+zSk3E2vlJsBWLIrYK4PPtAdD4Qtf/4SGQ11O7Ygl5vUTu74qkt3NqBpCZ
	/u3eq4r5yIcdKOMWWZ6BZAa5c7b107nNBREesATUlHRC6CDx5znsH3YMEEwJQJDB9KYqsQRqaHt
	mzwikYi+ZNXh/l6Bx0/CtLtSLy+mZLi3yj3OOotxRaxhv51p0eaaauoFfU7GT1rskHHg0bR9zjt
	f+nQycXcj69ENdhIlnhHP415gdg5ENIUgy6Hvz8FeL/Kf0MrQuPJVCxEj7LciGJvlYmsAxx3wQ9
	Lppweek8E89JH7/JyhwkEWQtQxvFanBO6U3AAUlK4S+yKjrQwvzXG2KiiZxtR6Ko+M75IjSU0z4
	jFad6WiX27tfh+30O2dS6phH+7aAOmS9iLYSdmTVFwcWfau/lTKr+t3VncuRrosdiiSetvO1saM
	8KnCC1SQi5ZoUSAr1ciyL2HNqvCsXLjMnPQpx8kKcbQoq/yHyzyglWj22hYYWTY1tWzFcHIPsbA
	Pd8w64jnIpeS5faeaI9L0a0M4uVPT1faZzaQSq5DCroyi/Pq494FGEL/lnHpXMBk8/3MbctAZ5q
	v69Yk=
X-Received: by 2002:a05:6102:c49:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d6ba3d66bcmr37107137.6.1794946840601;
        Tue, 17 Nov 2026 12:20:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
Date: Tue, 17 Nov 2026 15:20:21 -0500
Message-ID: <20261117202032.3848411-7-luiz.dentz@gmail.com>
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

