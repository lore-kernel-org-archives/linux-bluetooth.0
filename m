Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575272;
	b=CdMQ7SF6+byLB/9RQ9o1j3A5FsrUYjLXx7BJq6fEY9J3uXxTcU/B6vhSOO/t1QzivbVC
	 231R4U7KwEuK+2gOwCQ9TSwPip7qV5+YHp4j8WAx328LOpkucE7bnC7EOV+iB0ek+ASiB
	 nT8WFEEH2nWVH0tNrshX2I09ZiNTjuTJim1DCTE0yXdINRaEKESk2zk3tP8VKjQegFhk7
	 cVkDKm9ljeb7+DDRnsLtuhofiacx5r7P22yIEtUank3r5lCfkXtdc9k9Vzrs1tq2pIiLi
	 wXfhn+/430vPWEH84G/uOMJI5XgSDNiOZG+RkqfAziUiV6zPxbDVepnMiAC+wJbnIbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=W/ce1B5w6HxJrGx+cZP5MRDbGaSJDTiYRNMjigz0o0U=;
	b=CpIjz1xJHCwc0+VKwK7EYwB7mKnSMU3MtwTS/LC28r6tEgwxeyPtkQENmWchOSL8aLZC
	 oPmZt4ZfEkhy357EG8OhVekgpU1nPcllwba+YsTaLoTMWV+EkCMh5zhbfKS1J8K4glKq0
	 HHBehieu627dYYZJ94OaQumYlr8YqmuKEyHGniF/XRIoE/LoYJUZLj3Ibz9OtIRUwsS5u
	 LCVMKzcqwhXlc7R0i2NNGT+LgrzHLXl5xujgN8+KVyEosAVa1b2YE+oq4NY8X3Rf1WBCT
	 kdCZxPv1znauMPtK3rMl9Qpkcy2QTaV1rXBQYgtWTG+zPOnJG4fS+3Qpd/Cizs4s+5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEiXf64G;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D7606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 02:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEiXf64G
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55d2dcbb905so26964311cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575271; x=1796180071; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W/ce1B5w6HxJrGx+cZP5MRDbGaSJDTiYRNMjigz0o0U=;
        b=dEiXf64G1J7D524IBUuwaoLaKHaiH8i3Qmk1slxwja5PATHGgTsaG0El+0LOG6r2Tj
         tk3NGjDUhw/9VZdyN2S2Ze16iuaWbP8gZmKwq2azuMmLW8Ak+q5lfCfu/YSCHL0GMs1C
         0jduyQ/ARPxij0n7L8uhmdZcqwDdB4+Tzd3w3F3vH+IkQvCWQ8gi7kB05iIwAS/pqoW4
         2DY8KJrO/Cb1qUJGawvTv3LAYAmnWiZqWbpCO9EAya0YaT6gWN8TFcvU33R3es+URsc0
         TUGMB/hIH6uChS/WqanokOqM3a2xrIgpe49Oo6EOb0JsgZ7EHchiCu0w8eXwlKrfzVJU
         Gr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575271; x=1796180071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W/ce1B5w6HxJrGx+cZP5MRDbGaSJDTiYRNMjigz0o0U=;
        b=iTgE9vTrKhMvP8emoRHypmpyEv5Rqo4+ITNZz2TOsuN8zsm/vDjrJSaySb6vu9Q6ry
         zzxepkYHcJVEwreM25AFzKBqvVLNLt9H/Zqb8vhNIRe2D9fanaS6EPTaeSfpgNca4XT2
         A/XLx/J5jRmP+NRSypb73Y2T39r/IxcFpRHK1gGA7F+xU4//PvlKBYwY9/vZpsOT9yZn
         QKUyX5T/0sfFv/MbyQPh2mcj3/hXsPUzNGrFH6WNoUYX3g2lFdnXInRNx+ZhMuhN4yYx
         DA2LDD9HGGUwk8royFB8NXOFZ66P+eJV+4pNsrfNz9dT6b7q4wLkyI/b/F04O51hVQG6
         W3ew==
X-Gm-Message-State: APuU4Z+7B+4Z6/M+w/IuISCaFYQLsq5IJTYMIeL+M9wG5arFBIcTyAMd
	76GUk4xgsbECVWZwvDTEuZPWRqu6NpXG+cKQZFjvhDBeQHao9+ZKd1TyBmromg==
X-Gm-Gg: AZFdTZcAf7sRaThShiL6ZAfYlOiUQsCtTbSUeipCzRQ1sEH7ohQK5X9paUMIaIw4Di9
	bfXBXYNhw7+zUNm4BlTlyRhgICk89z2UNaQn1ngFtaE7CVfckMX3cMt8qsepN9m4xeA0L613g30
	RJa7g1WoNblxzA+sLyBaPmfZR5Y4o1g8OuqFJFtIhxv2ltndaYGGTca+B/eRAdLx6sdpY5T97JY
	0xvzG4XBBwtio6V2alisgMtKC91iat6u+T0qTelapMb+Mm2Q7Ll5IUl7IkI0pcC0jTAKlOv4DTy
	S5lQ37tJm9C1UWLkFAkknCrIosAV8bSI/m4bbsWyg/DT3lKtrmvrpUeRKAiSr7gnecplLctB7KT
	fXobpnb81nRb24/HiHKnbkVchcRjzDZPxPoxMTju2BPxVaNtfikjH6DpKhaORRISOhrNekhmY0n
	96FrNKeV/9h3n2dGgV8L2J3XBXLsvVhR/3Za+uB88BxWCKR5cfwOryRb1S4W0JgeurBxObOLvQx
	GR5Up+qvotNk9jcfVrZZEV0ata08DSZrrkwtr5y/DTG4qrkv7YSrvl0gbtjx/0W
X-Received: by 2002:a05:620a:2856:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-949bab28427mr2981434885a.65.1795575270800;
        Tue, 24 Nov 2026 18:54:30 -0800 (PST)
Received: from [172.17.0.2] ([20.172.196.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca846322sm1022172085a.34.2026.11.24.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:54:30 -0800 (PST)
Message-ID: <6b064de6.1665fb6b.12c406.33c6@mx.google.com>
Date: Tue, 24 Nov 2026 18:54:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8572813924596478898=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: L2CAP: Fix channels being established with insufficient security
In-Reply-To: <20261124205025.736808-2-luiz.dentz@gmail.com>
References: <20261124205025.736808-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8572813924596478898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221284/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      31.47 seconds
CheckAllWarning               PASS      35.50 seconds
CheckSparse                   PASS      38.50 seconds
BuildKernel32                 PASS      31.62 seconds
CheckKernelLLVM               PASS      32.82 seconds
TestRunnerSetup               PASS      757.30 seconds
TestRunner_l2cap-tester       FAIL      15.11 seconds
TestRunner_iso-tester         PASS      13.31 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      89.01 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.68 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        PASS      4.53 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      31.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#147: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15018725.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 144, Passed: 143 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.125 seconds


https://github.com/bluez/bluetooth-next/pull/1220

---
Regards,
Linux Bluetooth


--===============8572813924596478898==--
