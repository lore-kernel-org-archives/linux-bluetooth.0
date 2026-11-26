Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671622;
	b=2WmuTmRKNX6IA1oDosBbEILBgd7McEgBjVp15U6PzOT8IAXtBnWA4pFqJtmfjldtu7Zr
	 D6Mziofvk069FPLo31cirJQ4YWUleC9CGTC+Jmm5QLyYVSgT5e2LojkLsHmsKfyHy7Qg3
	 UWlcqCR+mvS7Ei2Bo+BF9sqv+eSj4mXyKfyWoOcjiDPp0v6EYdmCEZh/pgk4zRb6slav0
	 VNKGklTaEH0oU3/cw2Pg1S5vFCpyaZ7A+q5a0zt4YiQfC8cETQL2ai7ju8zGq9SEIiJHz
	 cb9zhu/M4Z4kB4b+xTSnhIkzIn2OP4x2FqFrhi66m3B1SFCiPRAmUCmHKZmkjBz/TJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5NHBSYOfOONjlO0EDMkJmKsiBKeP7Tv+ZZmGsmF5B7Q=;
	b=FhgoFSsLb/ZbGyQVdr3RxccOvNEZVBp8TcFCxEu8XdqzGKEzWhEa13kO+yc+kJVQqk01
	 AjTlp/4mHmkC0C8SiN/oBysPgsM22blOPNnUkE1VIGMBxjkni1FJhyn4YiRfGBVbnVhAV
	 ugJReXcwQOZsfdY9ohmAyzvw17yZDGGDpDeJH6jDbxoHsN6tj3lhdWiO9YBy199e0uHi5
	 3gdsW9AhF506VamWSPV3K9vhpoT89KDEesGa4gJXBBw0+CaMxs2x1RDGgPdL8cNxaRYFi
	 3GrdeqDchL71VHHsZaqbJ/oQBr7IVNuchJO3Wi86AVZxrldB3HEjwCJOMlWx/d4CmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft66mFXK;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA0606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 05:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft66mFXK
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55c35262674so50226051cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671621; x=1796276421; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5NHBSYOfOONjlO0EDMkJmKsiBKeP7Tv+ZZmGsmF5B7Q=;
        b=Ft66mFXKX0UAnK3H2CxD0Dk34kRIE3GoQBbAMXMvJKJwVK7x5mz1NNY4m43cH5cgZ1
         y+Rt64hTKVe3yjXt9PNMPeSybkRIU5EQIzhzGUDbzLFAFpLxYzSGyuh2DebzbHX+pTfo
         dzjNrXMYUs9P0vQpnutoeXPeW07Mt7lhYfmeMkyZOEk8mttCzm/hkhcJ4pjiXlFcHuZ5
         11UyUpOUZTnjl/FMIhCE6kJtgPL4AzDn8Ncz3SFFSkSX6GdrG7JLhDmz56nuIp6yj1nT
         WBspNJHqSz3lJebfCIiRIv5N73ajoi83T3xt+BTND8lnrOto4bT3NSCOu/JxAYvrO92R
         VQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671621; x=1796276421;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5NHBSYOfOONjlO0EDMkJmKsiBKeP7Tv+ZZmGsmF5B7Q=;
        b=Aom+ktaNsm/xK6MfgDqCXSpyn+7J9SMBKckBOoZn470FXJQQvSEilIdLkRDg3l6lTx
         yOOH4O+cnXzYe0Yr5ogy44ylm/p812HORROc+gmyeRJmp+5MwuTeHkYRElRNLk1lexUF
         foHQ5k9Yv0Qb4yjlPdhCx3HGSWYD1P0y+pPwGdCRWoYS9TwmQdCanQgA+uT48gr5R2C+
         2vTksiz/RfnsolAKmoFeDvgSPsLoPH3zUrIyC1V4pvoXQ2dM1+Tb2c0IEXllTs/9ODWq
         gTy9mJYocWe5NKNuEkFpVRYt0i8kOUYniQW6KvV3D21L75VWugmQd5SiitgLjq9tseC6
         V79A==
X-Gm-Message-State: APuU4Z+R/CMlZuYbdbwJM8pexMe45qGZdzb8JrjptDbrKfmZKfbSJA+C
	naX/LklaCwLa7iyFRXcYosomaK1Ql+85aI+i3U6xFNV0LjDxJacb8tvvjkpCCQ==
X-Gm-Gg: AZFdTZdALXQsHDYbV9y8lrflN0rZcq3lKN5LO111V1zRYOOLJs+9klifiFFrqBT3Bcx
	nceA5uPPwoc9R+hGsd7jTPknkp+GQaUGxeLAdqXYKMNaap7QYSWhkdzh//k3Cpfb/zkplwaIkNI
	U2HP9umf5iGgwoRw5zPU25PN8hN+/GAutPBq3sm3llWbeYCiF7LpEHbzup3Mje40rP+ObTZ0GvB
	l7gt6gWx2ejx0ZmyNR3FNKhE+i//tWdixMmdM5Xow7LTTq+7DRahFzItUds4TUknmodl+WuKGs7
	zZMfLcFdH6T8pMqk3sZx8ws3qVZLRjiSHwE1sJoP9y4vWaqT5qCv6vq6wyW4hHlpgzQcbQxFCMb
	ksIP7g8Nr7MODl5hvULxkzEiCk+bdJJBt+A8zcbfKaltZAFo5L/wzsGAgLrwtKwYPYVO02nQBKk
	8t/LTx10oeK7I/hMavCtqEXkbZtrCYr5jASMIUERVYCV/5ncG3U8t2QB4WbMOiKL6sHAHEKbuAo
	fpedxCP5zyh1NVY+PR95rx8HkBLOBxnd3c1Ml/uRKVArhFCqKdwFExUd0rv/Q==
X-Received: by 2002:a05:620a:2b9a:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-949ba8246e2mr3483835885a.12.1795671621218;
        Wed, 25 Nov 2026 21:40:21 -0800 (PST)
Received: from [172.17.0.2] ([52.150.29.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3bec3dsm1490815485a.23.2026.11.25.21.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:40:20 -0800 (PST)
Message-ID: <6b07c644.6e3f852a.f6321.c7c8@mx.google.com>
Date: Wed, 25 Nov 2026 21:40:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2105295568218970133=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: tools/test-runner: Add arm64 host support
In-Reply-To: <20261125-tr_arm64-v2-1-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-1-4f02989f17ba@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2105295568218970133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222817/

---Test result---

Test Summary:
CheckPatch                    PASS      3.47 seconds
GitLint                       FAIL      2.31 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      313.61 seconds
MakeCheck                     PASS      14.88 seconds
MakeDistcheck                 PASS      148.04 seconds
CheckValgrind                 PASS      354.53 seconds
CheckSmatch                   PASS      317.68 seconds
bluezmakeextell               PASS      101.07 seconds
TestFunctional                PASS      1234.81 seconds
IncrementalBuild              PASS      325.35 seconds
ScanBuild                     PASS      1211.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez,v2,3/7] doc/test-runner: s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/

1: T1 Title exceeds max length (81>80): "[bluez,v2,3/7] doc/test-runner: s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/"
[bluez,v2,5/7] tools/test-runner: Allow suppressing noisy bluetoothd debug output

1: T1 Title exceeds max length (81>80): "[bluez,v2,5/7] tools/test-runner: Allow suppressing noisy bluetoothd debug output"


https://github.com/bluez/bluez/pull/2930

---
Regards,
Linux Bluetooth


--===============2105295568218970133==--
