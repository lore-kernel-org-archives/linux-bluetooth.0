Received: from mail-dy2-f31.google.com (mail-dy2-f31.google.com [74.125.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DA4CC62E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217290; cv=none; b=KPGMs5PzEfO8aqswP+8ZFXcdv5qcQSl6/Afe9JGAvZsRG5U+eWf7n4maQXigRmZoPx91ZiZ6UXRmmOxphXSn1gbOBIXvD/kePrn/UeiexZHf2IFlkIRd5tUbgvhHjdXbclb6f/jUfiZyfEBVsHSrVzQdCOyHxHjAkzb8diiYR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217290; c=relaxed/simple;
	bh=1Ex6dtbcVofTyJV1LzDHnSmKF6m6UJdvQFnJaDanGko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj+KsaLZer5AAa6GNZcAQFU4FY3slzGfAty1RDqn0Hnb62Ky+ZD56CxsnMMwEFcmcOegDWIQSywgDFbcmiybPbc6wGGfsUmSjzaFPFA/2nlyC7yMcJ3202dF93LLfO+7+ojt2GASOIBU3NCvURWwZQ6vfp4RBurUc6J+wANAhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=TqTlVAt4; arc=none smtp.client-ip=74.125.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="TqTlVAt4"
Received: by mail-dy2-f31.google.com with SMTP id 5a478bee46e88-33c11ef641aso3225454eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791217288; x=1791822088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpjv32FZWCT9SQAoM3sT9UI8XqOYn+rbV9rAqMRZvqw=;
        b=TqTlVAt4ShwbQqGNb7kt41pLFzT/LBl99D/mu3qnKqzCH60msnuBUexUvp50KcwNdD
         Hrb4TgzYGiQCHVRqYuL25PtkijlCTCtY8xprPPW8w2qmMfV9KQxa/mCa3N5J2gX7xRtk
         xn2YVT+T74gzL+idOImd0440swpF7Lk/Qa4+cKThz5VeeSOQ2kVG+uHr12MluOX0e4E7
         qYrZ6LbI4337wySPdSWVvaJzHqfPPYmrjovSFUE0gOYG51fbnG8rVu7MwIrm7LHHZ6Lv
         4HPlti8tPsRgD1r86W266q2FC/seqyHS7NHopL+WpHYOedoJD8a4DryWcmc1X3mf0oev
         ddTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217288; x=1791822088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bpjv32FZWCT9SQAoM3sT9UI8XqOYn+rbV9rAqMRZvqw=;
        b=WHJ69QRTNcoaG1pyGbVbKQFGCZ6Hs9O5DGbNbBzpfV3Tyf/cygfm6GOiIfbiwIKaCs
         SjeqBT/9g/DHtA+wcEVVexvaE2hT8cB8oo361YSFR+WOnS8UQnYhAt6UgL99n8WC/tK1
         TvR6PP06uoOExC7q+H5bvt4Gjb4FMsIfATD6wvpiBH6E7ItMJEXh5kCoXFFvKvDEtJI6
         SPNvmwdZesK8+p8KDQ+g43Eol64KbUlqI6WRrGpJV+V3XfoVlFuiXBKeIweiJ163Nord
         dLdY56ASxO0b3wLdM4ZL9ZT/di8AVKxxn1Xm9nqYTvMXXZ0E1YoT8I+2Xg6xn/fOJp7f
         0EGg==
X-Gm-Message-State: AFuF++lrMQf0FiF1MrzZhGI3UDzzCYr9S5u3cQtTbROffXvH2qzKBvFQ
	ZyyFEJML3Ac95Dy6zpeGoZIrJlTX4W1WLgr5q5MlAi2QfJNFd4ynaE4LN/Bz+2TYGHFpvOj/DzL
	0rfMsJc4=
X-Gm-Gg: AYBFou0cIm88a2GZUcBqlz52Js4sOcaN0Nl4tg6WWRTnUfaSpD4Anxxdde8YWOnbHUd
	Qb1bOHN87iOZ6Gx9uAD8VznaaaEq2QbimlsdOCydga86D9MuSJeEfqfx+zgcII3RlhKRaz285Q+
	X0hrIrkU40M3ZeAAe1u9EhLMBwCGDsogwhQm4TdzoG7dLhtL74kABj69JC6nsKy30C5WsYvimjX
	3HfK+B7b2CrQhoY8mZshy/dsF56/tOTshP/YNzwRkebzS6vr8xm+jvI76CuA5GnBInureLv0JKz
	2UQWiTIy0PI1tN+tUQKaW/M3mfmt0deK5j83X+51N0VEywYpwev6jJuOAdwNHBquySwVZ3G91Jo
	odTtaeSBBYlSazYQRLj51i3UNFcEmuN4FYMLmWZvSvuf5OWwl+/YWZJvaJlJzh6kV/Jy4YLWf74
	pDGBFRewFiioal8TNJ/BkusZzBLQGUS6vWpfHcY6ok/HDcZMWwxxYi/Ye6Xp7KXHJ5Gb6lyajdB
	z4CZ5n7KBMQGVEmH18Z+tfNCW/Me3D43khy7extOh2beMlSfRcZZz4LgNKsALrDivfMrdet+iuI
	/Uc6OP8Asr3QAWU9u8J1Pbq1qdHnzwk4ZU2sf1pN
X-Received: by 2002:a05:693c:408c:b0:343:4ed7:6825 with SMTP id 5a478bee46e88-34f219a4ef3mr15672044eec.41.1791217287553;
        Mon, 05 Oct 2026 09:21:27 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713809csm15646567eec.7.2026.10.05.09.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 09:21:26 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 3/3] emulator: Fix report type after a scan response
Date: Mon,  5 Oct 2026 09:21:17 -0700
Message-ID: <20261005162117.4606-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005162117.4606-1-kevin@simpleble.org>
References: <20261005162117.4606-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext_adv_broadcast stored the scan response type in report_type, which
is also used for the advertising report to the next scanner, so every
active scanner after the first got the advertisement reported as a scan
response.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5
---
 emulator/btdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e11857c3b..e00f78288 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5537,17 +5537,19 @@ static bool ext_adv_broadcast(void *user_data)
 
 		/* if scannable bit is set the send scan response */
 		if (ext_adv->type & 0x02) {
+			uint16_t rsp_type;
+
 			if (ext_adv->type == 0x13)
-				report_type = 0x1b;
+				rsp_type = 0x1b;
 			else if (ext_adv->type == 0x12)
-				report_type = 0x1a;
+				rsp_type = 0x1a;
 			else if (!(ext_adv->type & 0x10))
-				report_type |= 0x08;
+				rsp_type = report_type | 0x08;
 			else
 				continue;
 
 			send_ext_adv(btdev_list[i], btdev, ext_adv,
-							report_type, true);
+							rsp_type, true);
 		}
 	}
 
-- 
2.54.0 (Apple Git-157)

