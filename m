Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684040;
	b=IuOXf1rv5Un/Gj2U0iJHQ0K+W/2FIhS1AnQLLcd2UmbtgYSvXBYHUFlQ6qdrmFdp9hzT
	 USHsEd1/a6dmC+Js9vXhtTTcpSO2O6mVVWDKWBF6g/dZFbmSdEOGRSGuwtCiZbccbud+2
	 rNQu/r9+loGVnVBZKk6E27zEYIGtzERVOsVDghssV0qxwlQWXytdQWvi+er6dn2Pno7sG
	 v7k8ZZp06R73FXWlL2DGOTH19fc94DNa4C8Lbtr6L6s/FhUAepy1jJSdY/xGf1i7hwZgx
	 /xvdV1odLh5QjBHOycBc9NFoTDKZq0+y5KWvioqEv6c6QmIOJSiRiSV4ixiKO1QZMZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l643vIQY17f2vAmKINJq1LlNt/wHCettN8R6dSqj0TM=;
	b=H10Qfh83eHXLMFr9+5rJElsEKIKZbz/E4DxxVsYhYfEMvU08LRMwPl6rn86BJWTfRHLK
	 /C+Dd9F18O0tI3kyMjmGHpmzRAB+809U1ttCP4JwuIgydohHWourGwi34meXHPTQkZ6Jd
	 SpET0x7CCCL16i3IhhwW5hGNiPjcqm4g7joge8yhsHCpM2U36fyO0OnKGaiueZhsRNQh+
	 pz7h5FINRWRrL6nGlylZv71YIVgnY1DKTEwzHVIxqICD5nOH1r/SQPljRGSUC1IWA0IAy
	 ye3X1XOdgc+XohoesGKPzir503z37frIQ1Z+Ut3SXlSLbzdSsj1kiTks759xAenvA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI2LQxO7;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB0606A331
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5EB0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI2LQxO7
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so28249e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684039; x=1793288839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l643vIQY17f2vAmKINJq1LlNt/wHCettN8R6dSqj0TM=;
        b=bI2LQxO72lK+HBAumL2ccgR8sX8LimJrpMlcmaKT9cxL9k1JwuSybQ0uYpfncoT4CG
         ox3CVvG6bhDHMwwnnm2lym0gYJUxHtXMHQe0165CKPORuN78hGhKC5sOurdWmfiScd6B
         Isab2yqYeHxzVMCt/2vcI1iYm/KzkokTG6em4TdyKOTq1Coouuw9DvJNofQZ+AnxJNX0
         3duMJaiDj4H4mPaWIuVx73p1GwtPKOldtxN+Z35Fx21y4JAH4F6LbXWbS4KvRgHuqNaT
         8LHxaC6GOJCO9VIRfGpwK5snHl8kzUlcvcgmNZT/oAKLkvpPFtUvhDi5DuOFdNJUeCMx
         2+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684039; x=1793288839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l643vIQY17f2vAmKINJq1LlNt/wHCettN8R6dSqj0TM=;
        b=R888BzY2rMWzmbIDQZEZIhKFJVBjYtSRj3f7GLd2DKJ4IccR1gCeRmhTtuseqP3uTf
         BiWsQKr1YtNZDZiafsTqti9yIZ6+nkTkVY+Fkq8KuxCMIG4bxxyGOtaRM8eUA9Bp2IQo
         Cu9GKjY74xaddALivRrqd+eGDGBJVfQaxhTpuGPWdM7Hf9QAhbNHriB5HmbCsriBs/cW
         31o+HCRiDxyeK4KX8b29jIuSoyPl2Glpjzc4UhRWk2R12vHhCDDPnWxLaSD/kfeohlCO
         aOp2QM4I9zVcBupvREymFqoyn/+jzD7IAsvo4ryaFo9TFKoTURiKQ6cGJKOehFQhs3FZ
         wzxg==
X-Gm-Message-State: AFq9FYKmAMTreZWwQnoQ8sIPnkzOxlXQ/L1RZ33Nk49sx5FLZPE3M+lA
	+JVCQInMWR2uk9RS+XEgu9mPuuQeKHEjRI950+7sNFRa1ZbL2VSQD4GqntA5CRkUQYg=
X-Gm-Gg: AYBFou1Oi8nVl2qZ5CsgH28TFWT0+ZNsbyKUYDA7DDBKu7THE4Yltd6fpqjs9Qb8a8z
	HyJKPsZGYXtgbNIA3GU6mUNNmWwcp7nlbjbLhW6WqsWzj57CsoDqXrpCRj70LfEbdKY6Z39WnJX
	jIh5EyvNxuwdNWxr75S6MEd7fBtaEbmtUHCAJ3R29xsvQuElrfB3oO09X+wdoHTk9VI76EZC8LD
	9CLxLW41Xt5sX/BtFZpviQnr+rmnWL/Jx+b0H6nkoUcXl15HsyZvKfKJ8WieC2+fI+mOknzsu4C
	MJdCPLR5a6gUBXilg1JB8kLN6aJfDqQAkGZxncLWAzDExZoeU6t2BqNYVevi56uknR6OU7PU9S/
	qT+MhuKlovcnPR/gnQ0TSxxEwRoIgiiQIAGUVgGfRW36c31mpDYdFvKbOkSb6wd4+72ZGjMzldz
	KTPTCazKWruZYV1okUllS6/OKXYaS3HlxsSWSeDNHWQVFQFEBUQ7Uh8B+E+/BbCvD7P31dtAtdz
	mIcgn9oIyvd5YfM7rWewh7Kk5BvAuG8sncSt5eLmDxf/+tdvKamBLCi5BYbBqcVVydTAKOiFKXY
	YNIN3M2qWPu++YleV6XrQsOYdXYke5BuCPOZqRyU5lIRwg==
X-Received: by 2002:a05:6122:30e7:b0:5ea:c874:6c4 with SMTP id 71dfb90a1353d-5eaebe4621emr2597462e0c.16.1792684038690;
        Thu, 22 Oct 2026 08:47:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/27] emulator: Remove -T option from btvirt
Date: Thu, 22 Oct 2026 11:46:42 -0400
Message-ID: <20261022154701.3959500-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
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

The AMP test controllers were removed, but -T was left in the help text
and the getopt string without a handler, so btvirt -T exits with an
error.

Fixes: 1474c11618bc ("build: Remove AMP related functionality")
Assisted-by: Claude:claude-opus-5-5
---
 emulator/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index b0e295b17609..61c2f0d5c33d 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -58,7 +58,6 @@ static void usage(void)
 		"\t                      BR/EDR/LE controllers created with\n"
 		"\t                      -l, -s and -t:\n"
 		"\t                      5.0, 5.2, 6.0 or 6.2 (default)\n"
-		"\t-T[num]               Number of test AMP controllers\n"
 		"\t-h, --help            Show help options\n");
 }
 
@@ -141,7 +140,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "dSs::t::l::LBAC:U::T::vh",
+		opt = getopt_long(argc, argv, "dSs::t::l::LBAC:U::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
-- 
2.56.0

