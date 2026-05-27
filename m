Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0E22759C
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857993; cv=none; b=jGWVTVUnzdvaP+6q3jfap/69zlyJpzSSd+5GtKOa0AvXYJiKqouhE2/fKMP22jj4wawtf84jGR9TL94Ei9aIazdYGUBhNI8ZQloiLrMeJPTBEcsgPR2ID3VEKFbeOLGJBOTz6cbzOaJMdXpUdmBq19UBsxYinmuUtvMTGjnCXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857993; c=relaxed/simple;
	bh=Kju5otEf6nPTWjgWBYRNUKVfEHVQqt8XckJVxXXlHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXk8xAqOSjr3x2OS1kGsiwvxi0DIkGsrU/+rIyG11eQkXmy1D8KvG7mQlCn64LFBOSx5uUj0o5iGitoZL0sXJTSE9ZGGp6HHb41FFhfaFmp1DpC0U6mM4X6i9ccBofOVh48DZAY+w2mVmV919X0kPdEXfkmgWJhEUgwh/flWUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9B7p3jv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9B7p3jv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c80148ae949so4550907a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857991; x=1780462791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXpYHFY5/4fZ9TlHgcvmSOefEwSix4sKdeWGotgPGHI=;
        b=q9B7p3jvuAaohsNnOtGdh/RFvgENmwxDN2FFGPfTXGteuBFZDs/YhnI3mVWL1DiMcm
         mrX7DK0MUrvqdikOUed444t0QCC6fOdASpDerWwiUA/B0lfB0iZSd2+gSxUGE0jQmRly
         3hVo3Ylwg1AMTMXoGVKChmVIGSMz6dw8HrM6bE4QQ0ZbWgaOnyKVSXSqpCRdgdCXrxC1
         Sbo0k1pPp75+0VpaC1ekxpe2NTk28tGIX/IQo6FQFe00xfmYPVnBBMwktPOw/PCopii2
         VB2FXSPP4EJqoXGzrlUMjyJlUOepPtnhjc0FfroiViCQd/d+BU9hxIirIPpLWXR/NFAl
         rKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857991; x=1780462791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXpYHFY5/4fZ9TlHgcvmSOefEwSix4sKdeWGotgPGHI=;
        b=JJgQhqQToQKnI9iDVLuUBK2mC2/DieWibp2u33yleeSuB6khSwtZqujnL/meSmnXBK
         OaZs//VnjypCqPpi323HS+4Mzv1Vux/McbMPOqpubnFFlZNE8F7dVdIz/8wY2V2nnl4c
         PeZpL2bLU1l5S9V9Yp4eJvsTbWIjJtLV3hDEQ/OKn59c83YNIxoxkMQ7PIIOzPR+Anaj
         itY9fRhuWXZY8MWCKXCUQWQtR6eSFDWEAZP3sWPMgbiTCVS2OaTjFQ3dOtosA6Zd5yb7
         TMmlklW0eq0OZqxn+3B8QQ6x6hcfWngU1p9F5RQ21sLc9sVYGarncWXd+XcknKE98Bc+
         e5IA==
X-Gm-Message-State: AOJu0YwjPYZtiYeGPnw7AYaIAIvyi3dgtMjzpaxTdZrleEXgaYx/VC+4
	8DNYc1UU2HcDpA07hs0yhldMncprfmebFRHnNQamgEjlE3lNfJwcmPzvG5r8TQoW
X-Gm-Gg: Acq92OGYIPl/WTRLvOE7u5/rPILCUcZEwTAEn553x77PN4KZGarbEHDlhnNjz9YgyMM
	c5Hzb+S5XNjCOpsMpZ6qkRdLI5PCQC7pOvAQt54jwo+NsdOEtj90vmXFLlkRjZ3aBp61u3eHPbg
	zaW3o6+XJuM1noIpweCrggDXetsPdlrn8goLmOMTtfRs0btFD9pxN2M5s9rpV+Uz/4A+oigz5Hs
	PdbkJifEbOyIA1Xbl3faLfkaMAcSXF5NaUupKSzn6N33Z5ALtKTZVPZJCkMEohPngqB1c65TYn0
	MJaKBhM3vTlMiyZSxOTPrmSOoKqaCM3Nd4+GOk8muwfW6QV5fGhBysRvlwiitLZu5NCw7vAfUou
	0D8kZ9naayFa7cYlvFwmRhq+IXVcuxGGxJFzr3pqookYJCBelBXGpOsg/K2FjvD9NOKfd9WFbhb
	EZZ6uhkonzGkdDXvDCPaMXj+sqY/jSA3L3aJ5XiEGWOfi/u5LIE4SMBc0zlzqfsQZBxAHl7+y6X
	Uyl6jfT4ANKiLihYXMCBwQCj/k34c+9ceFG5m6FLWSPgghH04FtIAInBE3/Xt/trBC0hreeFXh6
	UESWwLNu+rwMdEw=
X-Received: by 2002:a05:6a00:194f:b0:837:acd7:a78 with SMTP id d2e1a72fcca58-8415f329ac5mr19848617b3a.16.1779857991571;
        Tue, 26 May 2026 21:59:51 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb19asm930900b3a.30.2026.05.26.21.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:59:51 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock
Date: Wed, 27 May 2026 04:59:18 +0000
Message-ID: <20260527045919.39077-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527045919.39077-1-meatuni001@gmail.com>
References: <20260527045919.39077-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_close() calls iso_sock_clear_timer() before acquiring
lock_sock(sk).

iso_sock_clear_timer() reads iso_pi(sk)->conn twice without the
socket lock held:

    if (!iso_pi(sk)->conn)
        return;
    cancel_delayed_work(&iso_pi(sk)->conn->timeout_work);

Concurrently, iso_conn_del() executes under lock_sock(sk) and calls
iso_chan_del(), which sets iso_pi(sk)->conn to NULL and may result in
the final reference to the connection being dropped:

    CPU0                         CPU1
    ----                         ----
    iso_sock_clear_timer()
      if (conn != NULL) ...      lock_sock(sk)
                                   iso_chan_del()
                                   iso_pi(sk)->conn = NULL
      cancel_delayed_work(conn)  /* NULL deref or UAF */

iso_pi(sk)->conn is not stable across the unlock window, causing a
NULL pointer dereference or use-after-free.

Serialize iso_sock_clear_timer() with the socket lock by moving it
inside lock_sock()/release_sock(), matching the pattern used in
iso_conn_del() and all other call sites.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f03b7fa5dccc..876649556d3c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -864,8 +864,8 @@ static void __iso_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
-	iso_sock_clear_timer(sk);
 	lock_sock(sk);
+	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
 	iso_sock_kill(sk);
-- 
2.53.0

