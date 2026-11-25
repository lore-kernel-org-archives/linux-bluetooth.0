Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617618;
	b=DijeeJxveh4ZA1DnqbKABs+mH0M4bP2T6aoDRGMe85Gail8d2BJfSz85ccIhWvM3mwHI
	 I+Hh/PR+jJnYhCWfsMuX86/xV5CKz40ffQW1NMUZ1jZnQmXKen4qM6NrtwBe6agIQFTbN
	 kZJeFqnkG1yNESDxY7sHvVsKyvRLZjH47bKkNFQENveasyGbmv73OP+vGvGqoxjhWeWlP
	 oVp/gq29qaVuaH2nXdBnEGgiqgtjKTAUw4CweoxU8Be7pZn8yZx+E4NY4PLmtGEFTia4p
	 oj7kMGxn6fMUeYgg9/c922KuUf2mXfugdIx+SB4MroLu92KEiEJ3Sfgxw6a+t8/qd6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=tcp4tRyms8jqgkfZ6DsxcPWKM4ja6b2A3/PVewEHZ58=;
	b=n7r4PKF1ujzOtJTbOJBeO6OTj9kpY4KI+6Lbf41jKdOb4rx0lERe28+pFpqV7+9e3Ci3
	 IjC4f4zpjbxDR00b0iEoxI7hzvVjYaqf5IRGWJA4T53MDSt5wN+zpsQ6B3Ughwae0aq+M
	 07ctMUoTma1atU59gKLmKfyU3sPSWfAesp0J69EggXGiNg3iqhXelUQWwbGDMBSVME/xn
	 wB0DST4U61bfGc2umhZfeDp7rVyKlztG1JrBBMsf7aGfGwMq6ZspOCw7n0xf2JrgEz/7v
	 zalTroh0kMB6COVWPcGCUe1SfO85vfl9olxDgqA1yOaKo8rFps92mjOzqI5HXyfoxDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4Aiz06g;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222FB606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 222FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4Aiz06g
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f20b304c0so534292285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795617617; x=1796222417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tcp4tRyms8jqgkfZ6DsxcPWKM4ja6b2A3/PVewEHZ58=;
        b=I4Aiz06gq9urrO36BVdAjK/y4lC1bMnZXVWZyun02oR4JOLfJ5zQX9MKsFxvxc1e8x
         kt5LGwgNC77UxuA4j+sDNm9lBmFNBTubkuyW0F4DaqLwGKrbr5DRrIRQyScwZ2+0cxrk
         rqSzejEOd+jTnJqgf3A+vdiKp3m2pocEDdN9j+Xfa1dAvknksRTi19W/Upgf8aoz8W4U
         8Bk+/vC+Kv0CdCQCcvEmqOp6xBWCbz+TXqgamhdRTnHP5a1zHP9KO2x/dZEhh0d4pdFm
         42x5Mlls7SPVTQfpbkA0UUt9zvmIfjpObCTTXTs+OiRQTqjMbdBMY8pY+WTwT9yal0ld
         jHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617617; x=1796222417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tcp4tRyms8jqgkfZ6DsxcPWKM4ja6b2A3/PVewEHZ58=;
        b=el1alg4ymEGUqeJiha6OeNZVRVrFlUykuDNqylPObqPU6AjAGcGgAQ/yExdytzvWaa
         SeGLsjuWv1jeMpPuK1U9L3pGi8I/rgMglmgiQ1qkXqHbjpxnVJS7VnKHUos12X19mnte
         cVwAOUQZPWwDE7L3662K4XF6T21jLz5gd+TJ6esy/hSgMkaBedaf9yHw/rLYWNOFBxY9
         SZi6gpCKiUgQJsK9n+SxCfk2l6LmpoQa8RyjmVWmuqVoq1p0KcXPcDXPx8NtfJfBX5jD
         iBV+z2efSmoffC92ASMWIz6oqviBH07eeHFmY40sHAW9pa0S2FtqAhJMaxk5sgCSoAfG
         QxnQ==
X-Gm-Message-State: APuU4Z/v7mDuOqyhcvVJTyIZ3mgJJ9mQYeWkTw+hU+rFVa2gaBTXwkZK
	c5pXZ1Y+YZW4jzUDL8gmqwzlWf18+ZjN083+LKTrMBb8PiMoPpDGQ0/erc79oA==
X-Gm-Gg: AZFdTZflUpgoEs5119VAuw6L2i7vmeoXcRAE1TsL7aAMg0TpyDnLk6I9TbjuDwIi788
	YZbpLZ/JvV1GQqX3raEa1n5BGy9VXYC+J6q9vg4WOVTA0zmzE+Ssh/TCw2hayvSM422/cqIfj7l
	zEOQM8nutXf55lGIFPhY338pDnN8C8mwX7lKt+0G37lUZV4YjRijvgO3i+GSKcYpxPuSQbALPHa
	2Oyzrb+ps86po/FelS/W8+F9nOcDK2Exr2+QyhlDYjsZQI0Otwdg/SDK+mUK0Qzh4BM47tHmM+1
	ZSJz9hYJUbAY2HqzvbfSE9oAtrphfeLUKeiOjbyxDo1pzkgSz/RYZA8Kt4EKI302163FlgbUAR0
	vY2l85Q5fd8xfAbXGpsTBN8gJHRHUtUj0HeUEREwmH7n5/nHD6fpsMRuJsx68t7QxSkbxaH/VqF
	ZoC3P51K1AuyzsY0oMf7Jt/qVLbx1i3wX9Xiif3RVTQQ5MaDV30w7Mhujtr5CoDyyjamzPyhiba
	+QMCl4jDK0VafCtu7Ve18fLJ4yqzWotH8qXkubYYmMvH2QQwRgNS3LgTa4KAIk=
X-Received: by 2002:a05:620a:231c:10b0:944:907:8f64 with SMTP id af79cd13be357-949bb0d815fmr2251954085a.67.1795617617010;
        Wed, 25 Nov 2026 06:40:17 -0800 (PST)
Received: from [172.17.0.2] ([20.119.102.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a0175c67fsm284816385a.31.2026.11.25.06.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:40:16 -0800 (PST)
Message-ID: <6b06f350.27a8fa0c.38cf87.330a@mx.google.com>
Date: Wed, 25 Nov 2026 06:40:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6338635889213778497=="
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
To: linux-bluetooth@vger.kernel.org, chris.bainbridge@canonical.com
Subject: RE: [BlueZ] obexd: Request the bus name after initialisation
In-Reply-To: <20261125105555.3165000-1-chris.bainbridge@canonical.com>
References: <20261125105555.3165000-1-chris.bainbridge@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6338635889213778497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221956/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      312.63 seconds
CheckSmatch                   PASS      315.35 seconds
bluezmakeextell               PASS      100.14 seconds
TestFunctional                PASS      1232.00 seconds
IncrementalBuild              PASS      314.34 seconds
ScanBuild                     PASS      1205.09 seconds



https://github.com/bluez/bluez/pull/2919

---
Regards,
Linux Bluetooth


--===============6338635889213778497==--
