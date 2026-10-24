Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851808;
	b=nOMHdmNsb5ZAepnQeaDCOzS0T4pCNBrygC9y3P12dzYx/zS5UcxEmVwORV5lxtU93+uU
	 eXJGJhyprmLWIePty3Y+2RKMhcZeR52obmwyugLCmBpZKNiUTLCiLuqKx0qQMUVxfLwgm
	 VDx+Xz59cfv0H43icxZ3v8k0SE7oRL/hCuuRPVQYCE9NkhmIHzBrWTPDirYmMFyGiSVbP
	 VCuSlwSiUkZmgid+sSZOnh6BVwXU9ZykPzXjLECDGMMqGNyX5TcbipbJwaAkrqXLfGI2h
	 pth++iI8UhwHMWUCa3ef616f84fR0vD4j3ZtduFI11MxYZIriyhWPFkfXsQkWyr0GDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=KV54cId4wypJmNkg1xPr9JSI3IA5MkWb72ByGBT1MOA=;
	b=Cf+J6/OyGC+23lSx1UqkD/s/iN45Q8cOtXPtLn6Kpg9i7ZiJdQRlCTyUfVSf15XXTspU
	 6v6rLPMb5ZXcP2azmerBM+HU5u3qBN2d0CmEc3r0KMDaeZqyRtqho3Kse1giAQ6M7kotI
	 UEcyUnfUIzqyF6FJObjJbJWxDRFShErqH518E+1891yNtbKHcKXdIIHC4uh7sS29mYncd
	 w0JOJAqt+BnwofpzF5Qv8bvs9Lg55jSALX8ZVAJQhWj89jqjibyTz3sLnfHKiKEg9mtjd
	 GIV34bnlWvoskrFQKrFghjeFiD763TAbPVDRKQc+u4mPjSZBMVaW3WX8q2/ktVbcVnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTozWStU;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EF606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 14:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FTozWStU
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3315666eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851807; x=1793456607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KV54cId4wypJmNkg1xPr9JSI3IA5MkWb72ByGBT1MOA=;
        b=FTozWStUgnB+QfYh04go/96QF2zscsVPaOGlTwA8Bg3GHVRtrlfSJ+dstvIPIqCX7/
         fXW7LrdKO2PLhd7GcccNkOIxGiPm7Icl8ka7+QkdiYLyqjjD++XRrLe7Xut51FlgpLMz
         EAGqtupNZ1Intcp79Iak25izhbQf1ROiSHK+28weY9PRT+wlFx/BGsFZmfe4ofs9CzSs
         Is9Yz0JSiFr/Ge3qwcR7Z73kVD0vUpxMWRitQArMg/ssETieUlDKAigqD6lEhDmF7rTw
         INaaB+u6EdRBufp9M8Bt+nhUiue257TNgFnM18d7Sj26GFGNqG4dnd8yTn1AggZYuWao
         XwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851807; x=1793456607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KV54cId4wypJmNkg1xPr9JSI3IA5MkWb72ByGBT1MOA=;
        b=bii8wUqtk+BMmIiKYuznJx1hQ8cQBLQCD4XgAUF0yZA4l0o2okq8/jqW1YJoYzY4Kz
         ANGIu5NLXVstac8mBFI85wUoH+9nZgwUtIS9NWjrCansFM5jqovbu1M34NoNoDOmZlDN
         4u7j6xfDGuV35MOU58dR8iBIaTH2IrKyNVC4Ujm81dyAEUNJsqTPh+QNx+23w261IPzn
         DejX7ykPvDGJYLVUrnR1WADKDvsrJRSOlbu8aA1xmVVuwd+S1pYiJAv6wtXYvvdsU8At
         GTWoQbq+rC8NmT2an0kQRJgZGLna31mCgvDeZre2tazIlrJpLf8T1H3tij4lMO592pCE
         Wh5g==
X-Gm-Message-State: AFq9FYLaRmc2ZzmEStOOen4Sq2D5BQNhqZWdcPUjYrc7ijBgYSJYNoac
	DZjMkvyAJFWlijqUWoMAZQ8S6/pAda8SQDw73+NHwtK+2Dtgd7ql5Eu1Hr/8tw==
X-Gm-Gg: AYBFou3qNwY9HyU3QLig8kMGFV2tYMikGEGDFBQd5r24wINdjYDDQ2IqIHIFKVZ65Wd
	4htk7ZzHagBazp2T74Ok7MGS1k46i4cnM5IlsknOAGKfkmYFj0Rbheh9lS8o3tAV9Ck6b4P+pQN
	ULP5gT9F2orSBNQGJhMk0Yeyr7jpi0MPqC2TGYSvLJZsejUscN9QbdKfjNZRmDCeMoGXYFJRmzF
	P/TOQRWDNKuJAdhCfIW6+76x/87uOVgzUxfDk3xZ8VLZbWqAK1wrowS+OjnfVvRHihzn50lb0Ai
	GBmXumGHF9z/+X7DI8xjw9qsPUXRwDX7TjTB8nfetN3w6FSFGiYnZB4kOp+TJwMOt90sIMT1QL/
	MQ4sal6jkgRvX6fakQp5EXvlLR5zafr4y2pefYGtuSDuqXhmbhfQWfDkqekPbnYSk1Bc1SCGGt6
	V9/CnUgTp+xm3rK+pkzW+DImLbzmT2sYhOS/A7uM2dhnYf12thE+zdhjpWTuBty3hO82UjDp8cP
	vG38/zl6E27zys+6dCSmlx+X/iHG0mCBQfUhKvO1ZyF8RzPcQX973KLXcMfxbuWqw==
X-Received: by 2002:a05:7300:ce10:b0:368:d0b6:b231 with SMTP id 5a478bee46e88-369e84daabdmr3228323eec.10.1792851806956;
        Sat, 24 Oct 2026 07:23:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm16735720eec.23.2026.10.24.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:23:25 -0700 (PDT)
Message-ID: <6adcbf5d.67914289.66a0c.4863@mx.google.com>
Date: Sat, 24 Oct 2026 07:23:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4509895054693305398=="
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
To: linux-bluetooth@vger.kernel.org, tooangel@tooangel.de
Subject: RE: [BlueZ] adapter: Don't power on while blocked by rfkill
In-Reply-To: <20261024103255.81769-1-tooangel@tooangel.de>
References: <20261024103255.81769-1-tooangel@tooangel.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4509895054693305398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192615/

---Test result---

Test Summary:
CheckPatch                    PASS      8.11 seconds
GitLint                       PASS      1.24 seconds
BuildEll                      PASS      19.48 seconds
BluezMake                     PASS      297.29 seconds
CheckSmatch                   PASS      291.11 seconds
bluezmakeextell               PASS      93.31 seconds
TestFunctional                PASS      1103.66 seconds
IncrementalBuild              PASS      303.28 seconds
ScanBuild                     PASS      1119.50 seconds



https://github.com/bluez/bluez/pull/2707

---
Regards,
Linux Bluetooth


--===============4509895054693305398==--
