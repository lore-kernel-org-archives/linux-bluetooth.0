Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672081;
	b=vWbz6m2KPyIoUK5Pt5ExQn0UnvE0MZbJAn934lThAxJ/UBQHFrvs43Xs2X94v9VqvdpJ
	 C27I0gtMnyWzVL90A7lFLMrYkPF3u3Hb4rdH7dxDRCD4aPYZBLvBmB8a1rgtG+s878WoW
	 Lp39O0k4Rc4TRrLgOXffA98/WBxuLNGOVnQXxa3MjtIknntB8AoWPJXFKZAa6S+h6Q+BM
	 z9NCiAAkeLff/5Xnz9ECToa8XeZ7svvpUvV2kAd3SOJ36nqcqPq9diQS9G4DAuSYv1UKX
	 uyHRtA8+dkiJq7wM1RBcDPF/DqZDAo/v4nFtABdnN6INYJb9z7vLs8ky/rX5o1E0gQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=c8/gVWDAwkdynP5yeOvWTCK9oTS2eD+1ro80UfFWWBI=;
	b=NEZVuweMgdWAHjH15eV9K+V9NFmsFWCir+UooXnRrxUv2LkY7spq/JVV8RTHOiev1quW
	 4rkD5NT68Ill28bT/XxH1Gds3EQECz2l6p7331EI54ZGwODkD/S/Dieglv4X7KsAQs9Iz
	 Nmgv/dCXD3CPA5oP4lMgpkqUUK85dWof/PVOUSj0gJT9ZGEbQZsBZHXt1R913FUjTDw3i
	 C+lB1cOIqha/esepScJpG8pQrBeum2K0cyo14+UdB4t4TufewBb34bC1zw+Q5Q4/rfRt5
	 baDrPO8c+7ZK+jZauF8Ps9VPakljvX0YsQu3LxdnY0epJ04D2OAajNCIiwvgR1bAtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vJ/xpide";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95B606A323
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 16:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F95B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJ/xpide
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso1919704c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672080; x=1795276880; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c8/gVWDAwkdynP5yeOvWTCK9oTS2eD+1ro80UfFWWBI=;
        b=vJ/xpideLxfIgvrdEbcYyhs1iVXbD9C4UzP6RpdXiVVuhBcX0R9RhstJ8Vx+iBqVth
         09lncL4GlYq4SZf0z2oOvBrP8ptIKn33ESwKu1TiMZ1jf83DGlL7H1UfIW4PoSLhKuP1
         0R/KJKEaMxs4PyJ/kN6JNM3SVSfLV0JeGrQGigKFj3C29IiD/htjSGlkRS+bsqpSiwJh
         LtjH3ab7ROvH+g48KQbvUMEp1/aB0M78mKbq8dcmKLJ1AUJcBo384OQ4WwAgJPnPmCNg
         0Rje0wU9PNNe76xd64TwtEjlT9/WrSGZ+FATucuW0U/pZnfs57B1AxIHLEYths5l4Lg5
         bTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672080; x=1795276880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8/gVWDAwkdynP5yeOvWTCK9oTS2eD+1ro80UfFWWBI=;
        b=bshD+5B5kM4+M+m47Zwqzx/iNY+1qaSq/pX59JM1sbHqUd/gAxQkUuFoscGz+RzS/O
         jYYePCaEraHgWT9fIW6aW5ccoTtJxLJmY0daUzDFvU/jArq8wCuGbYThE0EBV1k2qNmm
         LXTqbDy8rjd2tQHrpr38lBhiVuEmwMtcOfSA8ascifACxYzfOb5bza7JE+3VApe9utOa
         sEt2ibUGhcQgqylJSjqT5uWihtuDsNPBsW8/KyO+qERmvqstOqgLwu1gPKe+TFJNbPwl
         YCKyrSz8HJ4x6rNQNHe6Dkw0erFRzNWQ9sziTKt/b1Ab7lXPnlLmBYVtNOHDJpRNPNbK
         5rlA==
X-Gm-Message-State: APuU4Z9sEfguR8CajkN8kzJ1oDAXS5BqSN7/Q3PHh+y8d8b+fI4Weeqw
	CNKh2y1LceKfAACXsWEUKzGZd/P+JH6OVrQ/0t0u7v+UmFitc2LOyG6DmVQdLA==
X-Gm-Gg: AYBFou1vFKyj5InN6cFkfv86TjPceIGtKcGj7THX0Dkq89QRskT0KVrXJH5dEEZx2qj
	iTWBttIJDVWymsJeA8KM9p3ILFlRurmQi9MgN5zqdiZoJCuHpPWtSe+eyVAhESKeKCVYTVGyyeJ
	lpf5EsBz3Q1BhmbPuDwbh37MaOkI/U8sv6QlbocenVXNnlYAOd4vYfLumIUgX0njT0O5yzydexi
	nREa65RTUPOSf4Dsdng0PhAkxHS+E4jT6TzCLaYfCPpaeDSrFKxrfYy7V/O9WBlZxiopHi9qo6i
	4ulsa9EECODvefJc8WCmEWYHyCUjXtCv2VaL3HTGVvB0sscjEAiwgON7EYfbQX4QuLgCLb7QWfs
	ovKOrYoFskpzycSRMEuI7BrJDn2M32p42M5GNxRngbnRmCs+tpso0ifpnPrw33XnsCSfFmrksC7
	K7OmjludrJ2aNDbBNtaidUXOiAqeUmTBCJ4ZYN3/Wap/SIarhpuyNZQl7nRVQ9amD4WZHbje+SA
	OsuWCvNANAByWrDlMJTwDbSocLKfx5JxogzBKCW0to3Fv2w9vCfuNItbnqX
X-Received: by 2002:a05:701b:4282:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1b503191db2mr6185832c88.31.1794672080358;
        Sat, 14 Nov 2026 08:01:20 -0800 (PST)
Received: from [172.17.0.2] ([4.242.197.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm16149485c88.15.2026.11.14.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:01:18 -0800 (PST)
Message-ID: <6af885ce.8af4976c.2fb44a.a0ae@mx.google.com>
Date: Sat, 14 Nov 2026 08:01:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6677945537349305504=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jacob@teenage.engineering
Subject: RE: [BlueZ] client/telephony: Fix missing string.h include
In-Reply-To: <20261030090934.89910-1-jacob@teenage.engineering>
References: <20261030090934.89910-1-jacob@teenage.engineering>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6677945537349305504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] client/telephony: Fix missing string.h include
   Pull Request: https://github.com/bluez/bluez/pull/2737
   Created:      2026-10-30 14:36:16+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6677945537349305504==--
