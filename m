Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617932;
	b=UAuWTwXIsCZ6EKdoOJWBd85NfTUQFtXJcf6X9c5PZNc1fPPN/YIX6cN1s2o+ArOA4uFq
	 f6OKGwH1J4AZu9bsP65lI4orNZk1rzFTxJz/KSCTOISWeh6a9WjUvyBQ2hoRfKQuAkRMw
	 LtYkQX4o7jCFlE4UXAv7PytaoeWFwEwKyW8dtLSQtx+KC+d6odz6SpF0z5dR/4A5tL6UE
	 h+v5i4ZncCEmDAXk+AJDIUcpY61ty7n9Lld72lrXFMx7JPKs9JonGGM+wGcdbiqNavFPX
	 DQInD+KFHWsP2F1+t2/JNguwskQ2tWj+RP+RrUPbJJplAOYyI8s/GUwMfkulD61s9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+gr0iGgt8D0jPfiZZ9IS2ijYvB8Sc2r9gNxo2kym0oI=;
	b=OJczvGsNIkNGjh3mbDMbm0i4JwStH57OaljMIERFnHyzShwrGltSAHtEottvZ0mLxOWb
	 doAmJBQ6AjveHNSlTE/B/kqRUF1fZ9ZnARm23k5jBu2lYi+70oIn3ThaBRHxSYvlskLR9
	 B935zMNRH6PCLbnlRKXIlhLTaD5SwodxdGkG3+sLjmHUvmBnKIDUrgsl/SgQbn6H49X/w
	 Sjz/VdFZCyn/zbis/U2vo//f7aWfqvU8snU6x9nlI6kRchLO7KX1XfUv2/nMVBa6KJKVy
	 +XqK4UZQD7WBuqFxWBy1r7/hglcfs3sPZs18uAtj0enhiWTxzI9YhVZiHTQgoZqpU9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1iYRSGk;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A35F606A683
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A35F606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1iYRSGk
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-92110499585so54425586d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795617931; x=1796222731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+gr0iGgt8D0jPfiZZ9IS2ijYvB8Sc2r9gNxo2kym0oI=;
        b=L1iYRSGkiOrjWupWvTbT3haEQzCJknppP1KJwUeZKgImVHKGGz8uOyhwctLDMtx5OG
         cgzakK3S92DfPvbDH1yorkoM1JBFCEvDGBs+lto1GKcDtHflyObdUGEckaxNC7VS7zC5
         XW2JZ1BSC2RqukCMTdPsQRKO4rK1nKdMpi68m847X63vHLnB4kN2OpDugSbUN0XkRISK
         MYfFNTXC/zq76MzzkIMqNoMeh/BeoHjujIJ5syUAfiNq8hhmE04jj/c8QJOpd9D/K6HI
         314EUZ5w0+7ZKIHFaznCCyP4+XJn5920c+nz9oL+XH2EK0ifM5Cmb88TR77Yzuw0Inrc
         9FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617931; x=1796222731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+gr0iGgt8D0jPfiZZ9IS2ijYvB8Sc2r9gNxo2kym0oI=;
        b=sfhj213q1oQWiubg0i7HTiwj9xqbhUtFl7qYI+RHZzlnXIicT7pqPgxbdsrwP5nw3h
         iXSvTHAwoCusNgJDkLeoy65u7J72M/QypZnEst2bng7umuta4Y42OI4iLRqSemIjdrXC
         Jkzbl8wyId053SvOFvKHbaQswegeYXE6UFf5ya/Mr7YF8JI+OITbJbLZ9RORvgiq7nZK
         cqQyyOZUvVj5d4b2UnY3P3JzCtABGA4rMvkFvu0pQAeiWvIn8SbuXvcVMLpn+EQxaJwE
         EpxUhf0MvhupgZGTzzi5yuBEfV5cRECO3BY+taes6RbjruW3K+lr5DcYcOp2MKwLfGo3
         6EWA==
X-Gm-Message-State: APuU4Z8XAJjYGy2MxR3ohMeTPF8PT9Io9mHEzKCoEONphesqWroHJ2e3
	bj8lmDeyUrPwbeJJ2GBnHv8qVK65Yv+b197EjJpgK5Cr1SKyIkQjbp5mcbfnSg==
X-Gm-Gg: AZFdTZfezUjDpM9Fj5ocaVtrMxUzBcNLNpRrkXPZxWiE9anwPp9wrWQavqAxcrFSsKl
	cNPc7cdLr+qdM8dQoV+t7t4yGyJLPCifCZiHxgOH8qAQ+shlT0BhzGrS0sX49blr2kcnvCCaROG
	V5TJXf7xKycSVGzPzu5MsCvdegnSUfSLNVKv59WjbguMtTHn8jfbYrsyBku+QHPyFprt7xeymEz
	KH2FasozuU21l6tXkL9/Jtlvl2VTqsEVYtXdYpWzS47tkqRUAy5kK/532sNktl31dcGpPnOSKSz
	gCbN6zmlw+gL2o3r+KpVn76VHWyNGl4EqwfeeydmsFrYfhe6tB872PcYGh4mTkgVu9l2sFaVU/V
	9QAa/Ee1+b48eA1rGbQLevixN8yXTWzIYpvEkEM3CdnIki85x94HtqB3gKJCAwbPeLHsAVrq5nD
	Y7DyYJm5lKV7FX70T1KWr6DSlbyq4lNA898BRtsPrTRtP7u7COVQIhWwBQgaTxcX9nWbv1MYC2n
	9URlqdrHCm6IcnrEF/RT0YvgKvq9cirhqtjQYyKc5ZR6Sk9tCRyp7w/qSeFF2U=
X-Received: by 2002:a05:6214:ca5:b0:921:3443:fbc7 with SMTP id 6a1803df08f44-92134a7cfadmr344692306d6.22.1795617930994;
        Wed, 25 Nov 2026 06:45:30 -0800 (PST)
Received: from [172.17.0.2] ([20.115.95.134])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm165113986d6.32.2026.11.25.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:45:30 -0800 (PST)
Message-ID: <6b06f48a.31b977b5.172c4c.3ca2@mx.google.com>
Date: Wed, 25 Nov 2026 06:45:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0921602198876320201=="
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
To: linux-bluetooth@vger.kernel.org, ecstaticmorse@gmail.com
Subject: RE: input: Do not re-page HID devices that disconnected on purpose
In-Reply-To: <20261125041714.2691802-2-ecstaticmorse@gmail.com>
References: <20261125041714.2691802-2-ecstaticmorse@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0921602198876320201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221566/

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      310.16 seconds
MakeCheck                     PASS      1.06 seconds
MakeDistcheck                 PASS      147.92 seconds
CheckValgrind                 PASS      158.77 seconds
CheckSmatch                   PASS      320.17 seconds
bluezmakeextell               PASS      101.15 seconds
TestFunctional                PASS      1224.91 seconds
IncrementalBuild              PASS      318.36 seconds
ScanBuild                     PASS      1199.22 seconds



https://github.com/bluez/bluez/pull/2917

---
Regards,
Linux Bluetooth


--===============0921602198876320201==--
