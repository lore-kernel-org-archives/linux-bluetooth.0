Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860569;
	b=SW/HYWq/18SGDoYh/CFHV7AXl8mYOFDNqlsVSWRZvGuKbDmcYSouC0u4XCgbcN6RAUF/
	 vzlf72bZN/vZooBTD+/S1X1o7IN6rgb3SPFk6/zMX7ROax7Q0SIBxKpfMkkv+afzNZmfG
	 UrwgBorr2MjznALTB3NCeZFxfPVjAOgXyBDW5d15sOWwQ5S8jw0H7+ScYroBxsCDlkTfs
	 bBkiAYFvyGyBNjh2qQpq+RT1l+BL6CNNVCudCsSHoc0KRZF1AHLcUsOWezMIW1QpDRYn2
	 xevOfUvRp98vykV5Xwi6LpS2s1vTLz/D48l3OjH8Sm0NwAE4jv0IbeVN0K5yjhEtoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Qsqa4tQqzI9Er0i1I0RUQ5oEjjuteUkYW6BBcIJ6GXU=;
	b=4oVt2PjZfqFLPAKGhj/AGj8yc0TmPt1V8VO6l6gHmQAyfbRPoYLoUUCcYisGjIoAWZLP
	 E28uzI5bpcU4ICeibQLr+n9pPU5FKgdh1xJysVlgSYSJb0G0sjXg0vRQfZS07HMMvotR+
	 Wv5w4lfZKoF21GuBqXOGxOJ2TIncUbN0UOA2hN55XBRp5tGnxZpjVme7soPfHia8Uz4bE
	 1lx+fN/mZguIi8OGQGB1DPMGpwCCNTdW9mTySxakdqvQJaFYOnap/6cyUh3/yaoS8Kg2V
	 0nXFwGZmkom8ApWXgllve1jHtMz7+LT54b3dj82hSsSkjv98hmmtEcfADOXy3EP5fAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swllTeHR;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944F606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 16:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7944F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swllTeHR
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f22a8515eso169807685a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792860568; x=1793465368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qsqa4tQqzI9Er0i1I0RUQ5oEjjuteUkYW6BBcIJ6GXU=;
        b=swllTeHR2GoO1vJYF3qhD4PnYk/1T+3DZU8sFeq8IPmMOMlpP4QdwShXb2VUa1GUJg
         ibB+QbnBNDXbikHhfTO48gmizXiWN6g+p3pN2vQ1/LOZXEUqLPhdpNOI2QY2p8ht+2uZ
         mBvhsZQlk7aiuPM0ZHSQ3LthdvvnMhgEy643zjCgtz3QvOCrP5H3yNMDfnh/3K0Gf9J4
         KRiBQdbicqxprDrXRo5WHbLR9XTK1abgDpwSTSH4HwBIrSiYdfpHs97wLWmk/wmj+BDP
         XJQB75tQqEjE6uJk4vIYRxbpevz/4Gr7Lvm+I0BiVh//HMAJxZWUD4K3XRXVj0R44xfB
         IBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792860568; x=1793465368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qsqa4tQqzI9Er0i1I0RUQ5oEjjuteUkYW6BBcIJ6GXU=;
        b=jBXCSV9G5QixhQFgKmq9TJqAsk7s780j1bktUuYFZokaVh7SD+WE48mPzuyVI33R6V
         83M2u4WeLlKkjGnafgX09wdLLb7/TzT7b+bMQIW9vB8aNu0mLPRYlmt5K3uuJJ0D02dm
         DfjbMonqxJ22RVqu36jXK5hS4RwGMlmoIUZLDyFvyCXrIj29hR9XdhBp/yTl7lI3AaSc
         TVFqnoG9/gYQ+IMzoY3H8aqLIRsKFkt7W+1B9OpY5zbDjviadgGBKcUMqLqAceXSgs5k
         ahAaLYdL3p2iuQ8Ca4oJZ05rKj5Hkh5v+F+94AAmEs5d5CXCrYn/ZwMMUbMtcNGIvTPO
         3mmA==
X-Gm-Message-State: AFq9FYImL7tNfaF9DTEbCgfUm/yduvtebWf+gtORQ1j0n4GZNGN1r9pA
	ISBTZx3Sj4SDdfoOVdW2eC2m1y1EiH4hx2b0X5sGPb8i0uviNFE2rMPYI1/Uo5TS
X-Gm-Gg: AYBFou24A3X+O25v5tm17mmkwAZ1agpn3sJcHR02wR5q+Rvg5WqAe+YByjId6TDIJ5N
	7+DpFdz2XnyG4EadUcxoNRpyaYwTqLIwn7d2A38n6UcN4TpwXaM6xgm4EAqoG9rSnTuYgcieFbI
	dmBpI9nkZ8zgNFRRFZLLEyljP0sZ06FTqRHrIJ39Dbm4cfK0PMKAQGl+K0tR5unclp7hMei+qQ2
	uh3p0imfMArDyz1qGYfOHowUYl4zj/yc8K74YFTBvFk+EDoWBT4sQxhpJmtUp7O2Tvu21cnfUhN
	GyHE0VXheUkf6CZNNk5LiEKylyPjrvgui7t/DhVxMjp6dM1EHCvt7kr3SR5SGc0WAlybrUqJNbP
	r+UH7ZgI7O8fOKvnxg0kF8ayP+9byjUwnoD6q9+SCa7fRYLVihL0NXogoepYSPXec3SFFhKGfp5
	oN76AZ0iQkw0PjPjGyYzAFpdKNLgOB0FVxOgeSf3vJ/fkevIhTFVqF3I1l70ovA/qLZapPZRsTW
	aIucVla5yZQv9SMr1ctcBHEv6T4S9YG8gvjXiQD3Zwpn4CC2hNrB5WnVNkOhXO9
X-Received: by 2002:a05:620a:460f:b0:93f:1ea2:350a with SMTP id af79cd13be357-940ef7ad885mr320253885a.8.1792860568279;
        Sat, 24 Oct 2026 09:49:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.102.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm217319085a.32.2026.10.24.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:49:27 -0700 (PDT)
Message-ID: <6adce197.8ed2c553.248ba7.1c18@mx.google.com>
Date: Sat, 24 Oct 2026 09:49:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6081083418325583429=="
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
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [BlueZ] Add cover art support
In-Reply-To: <20261009134924.122040-2-jan.brummer@tabos.org>
References: <20261009134924.122040-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6081083418325583429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] Add cover art support
   Pull Request: https://github.com/bluez/bluez/pull/2644
   Created:      2026-10-09 14:50:35+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6081083418325583429==--
