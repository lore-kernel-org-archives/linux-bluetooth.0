Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941866;
	b=tbUpjBRJK4MX4UqaN+77UEJS2SFtvKX+Vl534B14mR6YTSvZ9hXsg+OkAg2iDLrvHZUA
	 FqJoPo3uVPfwRD7/yC4BS6RUp0vg/iITYA4Ft5o6DUo1bO9veFjWRBDzBDE/kLUoLWPBE
	 8Zs/PTWLZzky9W69ISxLx7szhL0VQQWIN8adyg3fDNEnlEQ68m+uY7EY/IHcnrZTYFBIz
	 W0nH76mnwvD+XoBdpDjBMT2ozUNO2q3qy/wBTBQH9kFpdcPPgIt0qZetrgCLV9O6kD8ty
	 tlTsKOBXfIDy4zy9zz9EJgr0bs2fQk3rTwR4A1sZPAhdEbVh5YK64v6mY8nEMs228Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
	b=5ANh/bRUk4p7VzWJNYsS0Rf6lDGcxyby1l+yeFQruOaJ4xBg8MfgoivB1YIRNPzhu1rN
	 T/AH0xPMOpNHoqgH70I4gstz66vHMK1gLKBDaI4+9ie1PxTxeoB9cKKCM+SbDaTPK7ORX
	 hxwK0J8iDox26Q0xW1rhc/WzmPsUmDtnJpoY1fXW7FNUGXvpvxZTN1l0yxPAV/83BQLX6
	 rB6Jn4EKZ5hnoypq1FZ0qAcfau8KJ6E351FO5ovk971WaGxCJoDkFB5xJbijtZNud830H
	 UBNrdTluqyuR4Gpx8x8+dVKG3e24ecxYNiz6FhYtMJaR76NP3ixzEqomM2h9crpvwoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lt1sdFA2;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C31606A330
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C31606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lt1sdFA2
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2da1667b2so56652137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941865; x=1795546665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=Lt1sdFA2X8JKweGIoE1Bazgg+Wb0LgfuOVscmLiKodGJPtMHaeQ4dfpxczTJBnxQNB
         gmMAF1tilgJlVPvX3EizQAQyGzX14GEqv0VfljLVoclNfggOobihZBnIXgseYbRmwoeU
         9cwbdUztV3Vge65+xdE8rnhtWTNgdNaQBGc84TKM2hPESp97NG3sUzszt4m8SpyVz7UE
         2//wF+CgFO2pf3JW1IyXAINj23U/Rx1A+l/DH+4twCFHvKB9z7Fvbt30Q1ehHJrNmQxZ
         mpQWbXnsCxFArk2nisdMR0ZrbvzuJuRvwQ4zlF6QGc7zyAVxRgOcbHP16aY0kI7KLcBl
         3g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941865; x=1795546665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=R48cckvM1RudXfTVV9/wzzeFqrGL6aftmQnf/Z2lRgCq1uxwIXOWsvsYUD5UKwpdjg
         WqtRjsrYhQetjlrSROLp0DysmwzzCLTgVrk/t5WK1w9YVMsrhnH0BgpE8am5vJoaVR38
         cl8NkFezPH4BfXDqUh62HUJzCEMqzqBunVhwfR525yZenYJSHDkW15YHx+m8TQcHgDoP
         DQAjzxzVG2EAbANP3pC9QZ1+0KYL0s6Rcdm2MeEV0fw5TzqsmXIKBCrzHtSSev9UtSKE
         5IQTyqetuWoI4zajZpT0354TrO7vZHc+NUAEFWJAhac+xPaKuzNlN/d3lxE4KPZNbAv+
         5KkA==
X-Gm-Message-State: APuU4Z9nhqriyAq+ZX+w3lBa3/TSUeiLlcWI3L1bV64UDF56yUHl/GQT
	mMfBUP4NLa5sVSIOWw+SvdyDKB5RFTm7eivOebWnCZbANiBdRKZI9VHq7oERmw==
X-Gm-Gg: AYBFou0Eyr930RjkA+tihxCZeAPnT8heZuTiaWp4tzPEq4k+F1qTZ8CboqHPr2s6EKV
	CA2P53joZVWFPjGK3jeLYykBQ+Y1O2FvnavBPQbkZ9UvwRGtvgn/e1JB4DLDgQ8UdR+ZuMncYby
	LZe1BRDkKkuJvvTmDqTYT3cdVEqTfcN1t8oYNJsxkmpQg7gLi7RXjeb/544+62cWBoQagh9eHIT
	kFoldAf4qdD2o+PNf+viOilK6nvlTf01p/xRWu5/DhTIpnuNofPEvSbGkMrrsTRZ0Or7tLiMQR7
	TuVsigSQ0HiM3AZZq2/xUiC6cCuSEbZz0z7vGxQ/yerX4aOfCukdv4cZpHuqEGuq14EdTLaPTPU
	GqAkqZvU+h7AeGBXifDKFpSbohGy9KtC4Qvi0ED2gXAqSnjnrvbgYi46/+AonZo1Xtwju+yVkNl
	ssEkNzJzJXzzdMKd1AANNHpZ53HXmjAZJAOWVleIBVu8Xs727gw5S8GEiXC8Gxlx/EGTsTGW4B5
	hXSBAJUCYL7v9I53Lv+HViEarxLpbKhq3BvF3IgWWpb5OaQShc2jWm6SD/+2Zzqg06un+pCiQwM
	n1ZVi5pIwlYPI3Ex8Onumisn6t4Kz2fS13qDaXq+yR9uLzqts03A/KYL/sdZJVhMQJI5xmZ3duS
	34nO95SncJP4O+pt1Xwn+h0C/LEVJnA95dwTytq49mViHhdoJMId9bnl3jPGnJOLPt89qfazuO+
	TLw6/1
X-Received: by 2002:a05:6102:a4e:b0:7cc:2086:34c9 with SMTP id ada2fe7eead31-7d64d43bcc7mr5899851137.2.1794941864748;
        Tue, 17 Nov 2026 10:57:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 06/16] Bluetooth: SMP: Check smp_data before using SMP_DEV()
Date: Tue, 17 Nov 2026 13:57:27 -0500
Message-ID: <20261117185737.3758255-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

