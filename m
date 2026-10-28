Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204661;
	b=BOSiPG4+mV1Gn8vVus/nrG8WOXYWtYFuREWhmZox2KKyCSp5GKowVXRfgMRFLGJZRGMY
	 U5VjMLcyEOnB0O/xiMdeWaueitOkHWohxyvXAmRqRvi7dujrSb2na3FAxAFM5oE8zVlz/
	 0QQnM4HeeanoNvLoQ5pedhSvXTQ6IlRWhhz+bdAAxloCCsPu3vPul7Jy7iTWtBXZApuxJ
	 qwH6W3n5wGWLEwrRZ2IuAYEhLCp3rcduzu8LZV5Ycp/KtHITwsNdwfZQlSjf9r1pKkDZt
	 vzZHcpiQPQHeuut4E4iSopB6lXcQAuQtOzYa0GbkA0jiKj6zWdSaYDnbnC1cG3cnZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ywdKRNPLPcqh+zGJ7GVP1BC1oigjEQXooDI88ELPrHw=;
	b=AKvZkT32hBkCWYynCLeKVkj7JCs2BwlG++/Z7Ydi8sUjMsWBQkLQNpMC/sj4k4GOp4pq
	 LVDZUt697rTcXM5XpWggiKwvB/m4+cLdvf4XaFg1zVW75pd3OlzcxkOffrgK56QRwthw2
	 M4cfldxHutEWoCQT6e+RIrXG/9hWpifC3m7aBtc/cnu9L8ZMyPHNQ/pA3hXaGqjr+UObD
	 qcaondtXgEnpUF9F+n0X14SWekVxg9BObcl7OGPdNlwYp2RoHJFlinewmdGNBkJ1GpjTQ
	 8qfe7cJBTWnr5FO08HuHC9ZAXS6Uz4YTZUuTTG8498gBxD8rseRD1MbNiSplN7pv+aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hhu7LWfu;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641F606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8641F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hhu7LWfu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2b8cf037so87645885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204660; x=1793809460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ywdKRNPLPcqh+zGJ7GVP1BC1oigjEQXooDI88ELPrHw=;
        b=Hhu7LWfuufJVppqPrvO1UjPozb8l3/2fZjjQU7eVSgkMB9gtMvb9G6RdjlTCOZs04N
         zD0qzgzx3eUZ1YGleIKynWM6lmI0de5sStkIU/1C/ZuytYbJsFqZRyvqvAyfUcbOMuXw
         ZyRZW97qxqLLU8e7MpiIklIAg2/4Ts3VRXxT6O9PuVEWDjQKifN0GILPEWSvbAKuO+cf
         +/AsGbM+toxOpnSGo3/UbyldOiG18NQZjJu9jVHcVuMkEZTeAybtC49pnBSvrJvI/zMB
         ktnFI3Bp7nWDgWh1fk5Hky6D6jaIo8tqzBMo+36IYwaEvzNICGrEz/QK8fcUPtcstLYd
         ozOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204660; x=1793809460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ywdKRNPLPcqh+zGJ7GVP1BC1oigjEQXooDI88ELPrHw=;
        b=OkLoW2cy5QvTIdgr3gQ16x1LZgj3kNQywHNkQwwKYie6lCMOu+lgRGZyI2Uvwi2No2
         EybCplRPtIgC5dohESA6cuiGV1aalAJ3FLwW2K2KRTFP4V+V7zZG5E+vbps1ZirX7sVf
         HYppqU8xkSeTFpnn/o7DojePEQqK9eMpIR98A2WOa0ndM0FlJU5TVqO5/FX9OGN6i8HH
         Op8PYDe04H8/wjOissw/BiRp0NS79OCt1vvOkq3TA+b8eIVcvAUW2RNp/emx5SnnL/51
         OquJMCxLvFfxTSrnbq2lGQIFMSNNwUkiN5BzKI7zGRhKZJTZBAjrbYsEHwM2w9ADZl/I
         EEYg==
X-Gm-Message-State: AFq9FYIAp1SowcetqCCzw/kXP1FzU8zHTIdqT6tln8Ubr7QDpCTr+uUI
	wW/jm8r4rxEYhq7yHpVk2RoAVvubHyKs8WfQwEnT/dXNRkp3K+JorjmrV1vBUg==
X-Gm-Gg: AYBFou2vik9xYDDi0Mz2sFUDAOGstj+dfUFS946wlBF8U1oGKxASBJEgazjWMyGi0It
	MvCdIo3Tvd6e7m8jYxuSvGL0jec75grHv3xrevw6FUpGwbJM3JVMaBbZLo1xQ7Uo7KRWN7QNPYg
	liZ/NJBHesXNHPw+TPK/bfLuYsyI3PadehvW/S65RJnuTFjm8b02f9TYgzXZSBWjsxaSVQAht7i
	eQ+1hmSQyNwBi73QspAr1TsJKgiCiPKzqZ6VPl/qhkQP+bzhU6FGrHrD/O9EeK/3fnn1V2cEwy5
	XHhS9t98N5Tb5XvA+hfMvI99yYqHIWIxEC4S3by4jM5ZOAJrk0+Yi543YwNcJ91ZLj+9quxEAUt
	1J86poynYs45RSLhnb2Mp8T42X9hux3y/1kknSJxFAUG9DMBX9F/e/pUVYNAUYcp0DPlwLF6EDr
	tptqY5hCe54yr9mBjxOCDXs4e6ngVJ7d5zEDhsF6HeRLdxo8/LCcEMg0sR8uMQho/r/npc4CEov
	dPJ8KhD7lVu4dyXEDXGinSTvRDBM7OW1ZyaY6TTcwW+yZVaWuqvC3sRB1FI+MI=
X-Received: by 2002:a05:620a:458e:b0:93f:2a95:a503 with SMTP id af79cd13be357-94408d4f122mr449872685a.67.1793204660374;
        Wed, 28 Oct 2026 09:24:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.95.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05af648sm1295925985a.1.2026.10.28.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:24:20 -0700 (PDT)
Message-ID: <6ae221b4.8c8d7b34.1080ae.c31f@mx.google.com>
Date: Wed, 28 Oct 2026 09:24:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7657684185461615424=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,RESEND] asha: Defer BR/EDR inquiry while streaming
In-Reply-To: <20261028133243.262314-1-cochcoder@proton.me>
References: <20261028133243.262314-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7657684185461615424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195453/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      306.64 seconds
MakeCheck                     PASS      2.86 seconds
MakeDistcheck                 PASS      145.73 seconds
CheckValgrind                 PASS      157.62 seconds
CheckSmatch                   PASS      300.51 seconds
bluezmakeextell               PASS      100.36 seconds
TestFunctional                PASS      1167.22 seconds
IncrementalBuild              PASS      308.60 seconds
ScanBuild                     PASS      1169.38 seconds



https://github.com/bluez/bluez/pull/2730

---
Regards,
Linux Bluetooth


--===============7657684185461615424==--
