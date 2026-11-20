Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181299;
	b=Y9cmVwUSGi7KSIzHF6UoStdLx7huRM01OXSk9xmEpFG6NY+Lwl/1B/GjVlZWk0kNtUkE
	 XPdztNdSDNjz2C9AvNxzPV8PIpujS1OTtHbBssSVuY8EsRaDRJOFuMnzaYmMPeyS7VHHP
	 LCIiN2NFSw/zWs3y+JjayIKORUbsvru6FsQ4EMsCcDxk0zcxu3JQw9emGXD3qNqellwIp
	 HNogM2z2pypnv755gGgmkA44Wwc1mlQ86+r4y2fFoY9SrHYzSGf1RP3tEoe2q9XppHyP3
	 qp+wGCkbtx4561LNxSDB3e+NT5DwGM+69TjFimgRTlDY2dFWxVHuszHkr6jnq4ado7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Wj9/XXMhaQ4cOylulMxL63CN6JK36mHXdmAyRoeTN9c=;
	b=yhiAOaPEtxSaS5c/LB7gYh254ITpbXumM4nnQ847UhoJEkPz24DAXVjQmG8wInMpAkRH
	 vE6Za8JZDJNmUFEu3uyQf/tS/FbPj0Q3ObOfCLnbTeeWbi3PPYK4rPWYdNc18GK8NkkOg
	 qQpv/HdVo0rsXMGIMdbDL6lXBvZ2UnizXAiYD7SQBN0HQuAb++DkI44mEc4T16K1bNqd5
	 NG+mLssremu7Iu7GPAg7FTnNE6cL0z1uGMiFZU7X/U3S2ACbeSvn2JFsLe41ILirXydfJ
	 Mier4SJ/eTbiYnUwIIcNjgcyIYTTYzXwoYKxhLxFhh6TzFTcFgDOn27XeRSeaUzTkVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgoI4t9m;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6982606A337
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6982606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgoI4t9m
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so487809b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181298; x=1795786098; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wj9/XXMhaQ4cOylulMxL63CN6JK36mHXdmAyRoeTN9c=;
        b=LgoI4t9mJOgWNmYmQrfYU/C4uHK70dYMHmBWITUExj3qfryNfcXDf/0V+yekZf6Tlw
         h69YlH5k+1SF41OAUq1Z35WoUuv1+SQYEYHEmmHk+Mxd9UINN+juuLcvdO3pCwdUJkhV
         If/4MxwBCq0k8mJf+Zp4eqrMiaYl6PZ3fJBcGMZbnhRjfhrW+TrS3fYB/k62P4eWgQGi
         YAGiwrpkXKNx3mZ+Kgg8Hf8bZJzGl7ZNDTeLxChzvQpTTFFkJoe6lwJLNaKuU0DI3J46
         fKIPYuKT3ydBe+LcFnfcfOXpeR9nDfj7DQy85REfWY5S275L9DZb+ucz3HnDu/jen6lq
         fOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181298; x=1795786098;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wj9/XXMhaQ4cOylulMxL63CN6JK36mHXdmAyRoeTN9c=;
        b=D87/rgWdGoNEHbPPoixx8TV9qUWpj62ji1RstdHbXOoELUofSgrpCRE0FfKNniKJny
         dj7xSUdCPzA01tFuwOydg4WnaMlKP8dDLk9k66xfdfYmzLpT20pBvCQzyD4WqWY1F5mx
         IPh/bIf0MqyOJjb0CyCZeoZ5u811sg87qF2Zh8oJnXOirLd3tCfmSBvorXYnaJZbqFpM
         XaGN3DPl/eGMOSSFNOqJDm66eHNbWBfCwNQ8tgU/LdpO8mf116IxH1sxHrFlXn95loQY
         +/p73E5pnY7O8XjBCKZ9Hi9Ktz5jXhbSOoSDDd2V7vbCtmH9b/arfPTMet3XVYQ6SYfL
         0J4w==
X-Gm-Message-State: APuU4Z8YaZzL1MnitXdEvlMrI5S7eUydTJe68JNj1a0jBraJiklJbeoz
	ZdcGXvblY2zhNVy+5G4DRJqPG25EBwVbKZBtvGCP3YsAZmdkh+BP/YzcqK/P8/5N
X-Gm-Gg: AYBFou29ly8wmNOwbkjhP3GC6FaQIClW/wqDrcRuJUcNInpUX4i7UGdFsZrTZn8/ZGf
	cAHrWm9r/O1w3O87jJe2qkXITI3aQXmloPqmfrC7j887A/I/e52Dd0k2+Tmdip1/Fi9zNj5x0CA
	EXrjkHnDN98RgIvi58cdiNr6UzOMkyyIRV31JSuYLKQ62AsYanaCYNXfKNgn85sCws9UNC4q0z0
	9L98NppA7n1hgUOwjHJZAEWLKt2U7G9slXbA/uQPCLeNFwi1AaguDwBu5LtKJI2x4+qICDK87Nc
	tLx+JgC8l1zQCe6s2clG+cuxk8x5zZTv9xdVBtT2syR9SVDWta72cUZcrrvNHbccSye7YPcWfsr
	Yf4akjMJ3/dfDGTjv5f2tJAejhYQ/sVK60eaWsLgW966hvl16nj8+MNBiP1ygZx9/MqPaXOhdWU
	UebbFZIq1v9eRTd3E54LGnH3DUR3GbYCdpNVrl5fgqo+MF6wN0gXiKq0YXjzDlQgb/pIbvgnsNM
	I8hq6TbNVCNz1KcrRD/OPG6LGgKGQNyGsG5adbWBjLDQ0rxn6gfxOyV12Wm3NB2e2Rbi7ZjQoPo
	HthkRp2y
X-Received: by 2002:a05:6a00:419b:b0:89a:5:92b9 with SMTP id d2e1a72fcca58-8c87cf2ace1mr2579268b3a.44.1795181297963;
        Fri, 20 Nov 2026 05:28:17 -0800 (PST)
Received: from [172.17.0.2] ([20.83.206.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e456a7sm1489625b3a.29.2026.11.20.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:28:17 -0800 (PST)
Message-ID: <6b004af1.7c250c66.37c786.85a1@mx.google.com>
Date: Fri, 20 Nov 2026 05:28:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9210581262668390396=="
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
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: [v3] Bluetooth: RFCOMM: hold the listener across child teardown
In-Reply-To: <tencent_5C090D89F54B3F9DA10CEFA2CA9E8AD8EC05@qq.com>
References: <tencent_5C090D89F54B3F9DA10CEFA2CA9E8AD8EC05@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9210581262668390396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217309/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.27 seconds
CheckAllWarning               PASS      27.65 seconds
CheckSparse                   PASS      29.94 seconds
BuildKernel32                 PASS      24.18 seconds
CheckKernelLLVM               PASS      24.74 seconds
TestRunnerSetup               PASS      559.27 seconds
TestRunner_rfcomm-tester      PASS      6.64 seconds
IncrementalBuild              PASS      23.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: RFCOMM: hold the listener across child teardown
WARNING: Missing commit description - Add an appropriate one

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15005421.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: RFCOMM: hold the listener across child teardown

1: CC1 Body does not contain a 'Signed-off-by' line


https://github.com/bluez/bluetooth-next/pull/1168

---
Regards,
Linux Bluetooth


--===============9210581262668390396==--
