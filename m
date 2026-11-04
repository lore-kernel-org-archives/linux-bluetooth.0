Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781561;
	b=kjH1ABcTiNxt24U0QytKe4oXYtnko96ouS2nfRKqj+JZF3cRHxwVlVCWyXs3fN0NfAhM
	 jLXEYhrVh12vvWYJU+cLOhNifTO/KwforZSoq16/l4Dz2r3rLOx5jkJ9/WLAo+btTP7QZ
	 /AJmA7DDwxvm09CsLVQoGtRPvyhB7UYpBR5hBvEXHBN9KBX4Cm6KmX987IIkxOCwuGONV
	 WkmIIOOZv8nnEsUUzHGr16ICSoxn8m8x/sDCOOFK8S/bQw+eZtRUPRHpEUtkzBPS4sAmH
	 xmTIE8VmrmzRuf3crAMHLfNe0Y/elFcPzMxivHoXqbL53MKa/myPLHClNIMVyx5akBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=R1GLavNHm4LWu7M/s9x7o5X5qYHRIDNZEQPBPg+34AY=;
	b=vbWQL35jR084IIaNHfDPOFqPOwVzuwLnTSNUSwo0Xyt0j9qGw9Q6/6cSJ98umvekSoj/
	 uEX42XrrXc7v57vY/1RE7z4pKwXGYByjawAdg/8fKGVKIWr4mYWWFTgHdk8wpbyGMF3tG
	 N1u4ugtONTqs3Rdb4BTObvePsXkFOSiYaMPylJDoQyFub5OIy3iKltIwH9uEymLscfnnO
	 suEFseHCB3jS1E4ONKlfuOAT8KWrMK3V8BZZl6y9q17Z605PIPqb9wWxOKzoGJiC2GffA
	 wavwMCI/4X2qpyIZKyF55PMaYoBvxgu5DSYlMX5esunrppx0VxR0aNkU+glKTb19uIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=reT8jf+j;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF2606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=reT8jf+j
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so618968eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781560; x=1794386360; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R1GLavNHm4LWu7M/s9x7o5X5qYHRIDNZEQPBPg+34AY=;
        b=reT8jf+jjpKRlmHsVq/eq2knmGTvk5pxisHIIpB+gsXEAov64ZyBnoR48HsiWa5TrD
         qVZWrXdhEAjgCXt+9TochvVjrxJE51tofhl6sZVHO0SBkoBD19/c3BQAE3shCxDVYbR6
         cKYOOjatJKbJDiirQ1djWInGWww8mQJDHNwIw1yn6BxOXgWpTHMp9AnjVeqehSKkvAzE
         5d5dfgN0W3+A7JQpgCUwG2YP41vge8/Iz+41dcdD+NMKTgEDPQlubXqsQppqv2meddMi
         BV11aJdVBTZSMy9yBeX1YIyiT2uX2lM84IJRmuIfxav2Y3sllYj7YOjTkcFJ5gK4V87m
         E6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781560; x=1794386360;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R1GLavNHm4LWu7M/s9x7o5X5qYHRIDNZEQPBPg+34AY=;
        b=IHuOp4Mga6zc7R0Rh75BHmR/FWwOUgODy5rh0eDyaKGC63Ym6Vxn3koBM6NjwfmHwN
         fou0Jq63gwtS8C3BM4on9x7aQoqbl6n9UIUom+A5ZW7qnjFRDeGVlvnm7gkIjQ37KSsN
         rfqp1kLiA3o0HsmsApvx+JbST0cQsz83ELjm/v7G+K8sz9RlMh7vVz6a+hL2bYk6QBpK
         QHM7XT+RUeXK696wL7iMAAlQUROifpzXQgBhNnItGX2STqxQ+Cy8bmkfWBmV1meES6rl
         +hNeH6zNQ4/osjHuTCGNSBE2s4jjFoBwJEeJyC8EHXsiOjeh+RtDJsZwm5rN8Rb33kxi
         S19Q==
X-Gm-Message-State: APuU4Z+mKtheBz50vGEo+vO7guOrqamj7E2CqJCAeYeCZ/8aeRzn7fh2
	giFbVp4uJedHkSL6+WgYgTcXn0/gh8On6AnEck0sS2NM7TAnj4SUoog8zbiRBw==
X-Gm-Gg: AYBFou1mh3gCTkmScAEpLKREbhZGLCTKIIwYATf9/sTFIThh2t/ynJ5oVkr/Oc0z2AU
	KCvHkhdN7satKDeHaRvZ5tQKVVxMXvL02y8a0Gt0EUi/Y/F0EKxc8BuyekqYqCJusiwGCSqch9D
	SgGyoqVrGzLlQKXzFdNynOjsFstBcmmGjfv17WD0rgCqbWNUsKqjlYro8Qlm5KqBakTZZkxGJGY
	R6Efh8k9vwz0Ag4UbqOA7HEJxJ3I2TFG3+gUN79u4EoUWmERfGL5zkQ8uVGvCBgfUpj26vl+rpO
	LjLn/Rn52bVDNoEtU62hg6dEewl1uJAXu91PVRNXAGne6Q6vBeARcZCHM6C04e2af7+rJF5xr3f
	R/1jg9fI5XSfuJCQKOOt83fNl9e/ecVIoEIHRhC8bePKdHlbTzpoWQLa1xl4m72U0hm4p+UqOG5
	E10JvZ60BsxCFmX1E8QflvCC34nD4amwrQa6lzs4ETEDkJwzdlFfF7JiAsd9ZSMHbhdyDYfgVCx
	8UvJBOhPG4kOHawoZij9D324y9uLkapofQy7S/f772kGs2gPj77Ej4BGGKvaHA=
X-Received: by 2002:a05:693c:69d9:b0:369:f182:8e99 with SMTP id 5a478bee46e88-36a4243a30fmr24072112eec.35.1793781559246;
        Wed, 04 Nov 2026 00:39:19 -0800 (PST)
Received: from [172.17.0.2] ([52.161.178.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b3b7esm4976861eec.28.2026.11.04.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:39:18 -0800 (PST)
Message-ID: <6aeaef36.7d74b517.25871d.f72a@mx.google.com>
Date: Wed, 04 Nov 2026 00:39:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9111953312996820150=="
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
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: Bluetooth: drop the pending command if the adv monitor queue fails
In-Reply-To: <20261104022808.1484131-1-vulab@iscas.ac.cn>
References: <20261104022808.1484131-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9111953312996820150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201152/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.23 seconds
CheckAllWarning               PASS      27.81 seconds
CheckSparse                   PASS      28.90 seconds
BuildKernel32                 PASS      23.85 seconds
CheckKernelLLVM               PASS      24.02 seconds
TestRunnerSetup               PASS      552.79 seconds
TestRunner_mgmt-tester        PASS      94.70 seconds
TestRunner_mesh-tester        FAIL      10.57 seconds
IncrementalBuild              PASS      23.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: drop the pending command if the adv monitor queue fails
WARNING: Non-standard signature: Assisted-by:
#96: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

ERROR: Unrecognized email address: 'DeepSeek-V4.1-Flash and OpenAI Codex'
#96: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

total: 1 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14942648.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.023 seconds


https://github.com/bluez/bluetooth-next/pull/1056

---
Regards,
Linux Bluetooth


--===============9111953312996820150==--
