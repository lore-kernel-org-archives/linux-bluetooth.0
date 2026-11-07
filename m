Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040358;
	b=XLbpXEZIKH6wlLtyXC5eECiOYI7jSE1LwImNyc2QTQfi+zrn5yO+XmBonz6ZzTnL077H
	 ptWX2PDNrsszJ+nAr/3tK88C1bLsXMFOZoST+96Q59LLY6/oSwobsHvpnlXql7cb3JlU5
	 ueXeqgwBNnuPpbYTOQWkLvHWK0tKHf7KfLSHlzu9aKMJR+lymkOPkeUZvfcYtPzu/63pu
	 pWMrz7siy8MpXVGZzvpTHoEcTdZvKedklpTG7HA/WEhoK0R+ZE4OtF9fbgSfSgN6L6nsB
	 rABx4SUJ7K/CzOwQvl7bGdy5YdXHxlWwsKdmRH3VpgteORdmDxNo0nixZFSsGRZrcNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5YQwsoz0IwYj86iHV15ojFDJTQz43xUjiiWSgtOx8c8=;
	b=yvUO3VZ5hNFWCE69yeSkoMgxqIWTo/kIruHYVt8j0jnFyPqEVsM0CrS6Sq80K2Ie8tqg
	 EJPJ2l5nufHRIbuYPgxO0/VZUG/0Da4R3CO5K39VFVgishamSli1RNAnO4NNHMulc1cF3
	 HcjRQ7dEWPnY5iZHIcP8MXJkBLR4MOvjf96wX/ZozVjoWcxNPpw4RV3tLxnXh9eT1qJYa
	 J8OrkFonym3JdLlAGdA4Hz9VI5r5AKgL78NPUpYGj1p313FHEJc2NYkz38xQBdoKQe24W
	 El7xS7NFa4xnnDVj/iAbmSR2BAaGeNKEdjFGvWcgU+VlrAOka6D/bEVtBTvfUABY4Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EwEAz141;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 08:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB37C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EwEAz141
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so603045a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040357; x=1794645157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YQwsoz0IwYj86iHV15ojFDJTQz43xUjiiWSgtOx8c8=;
        b=EwEAz141Rjo+ButoitKou0eBBg1p9x/Bc1g30tea/qr5mIiy120itkHsKn7uQ21rfl
         ccAmbTxP1PMWxA43mngI00JT3G2hdLMTaHFMHskv0omkQj9n18ia+OMvwVt9Yjtco+dH
         b8kQVBpJupf/6X0QKcx1jskqaqX9BdRyj5wIfi2/wkl2yJDAEQmxHJF3QaOQ3ZBJja8H
         1/qqkkPqTKPBQiH+0Z+gOtOCdRuuK/kfYE/NcMg70/gwalIwQpe6FsUMZOSkYqCFsuzZ
         dShLSDcRc0hi3nt9gX2adkGvFSpmxUyCW1EyWB9/XrW+FUjwLb5MkcmQeQxQ4WrWmrLK
         vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040357; x=1794645157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5YQwsoz0IwYj86iHV15ojFDJTQz43xUjiiWSgtOx8c8=;
        b=li9bI5zGsHf4GmPCUZxr6oyEBO9hwTyGC3EC+J3NHLOBvjwZNqvnTu8KHPz9sAvuHK
         N/YH7YtGEGbFu1zsTl/JF0gbgu7E4znjvhOXEh4CT2R4HKLkntRWLlF9TcFHK/RDiq4z
         4cIOdsvBTzPYaHeAUw/dLv7q8VNahtV4rgJXoca0hFuAYasYRTKMQ/1byaOP7Eo5j2hY
         VPGirUwywFFTSnUia8AB5FFNgt4IxMrpg/94JHljXNiyOnLFckwnuwhKf2sO+YjNVqxB
         0UMDGnIDzsG/VOKLg93xDfhzZY1AXeGo102DX2IX9bXbueNc8HrBTjy0f0ZLq1uwGcoE
         dNdg==
X-Gm-Message-State: APuU4Z+pzb3hJwAs2o+UzR6AQ2s26IqPywfTRIQup2TBzoA1jKZKilES
	GURuzH81brC5ewHLJL98HM4hHrF7AXzj6WzIkXOnKVbC3JqXrN8oTrI6qfKYYw==
X-Gm-Gg: AYBFou25TiVuw4RaTuM/EvxPuX1VwBmz+yezzxpxiWx+lLeRBNdNM4JXTJGNSxC5CIQ
	dlMD6hRNwdQN3VsgY8Aq3POBE28CQlabbhkdcHQkTpEM7CaAUiHU5rJLWnH/H1p9DEGXRJf1gPF
	+L8Dx0dRFSKF7ApQikrMCilpzWs9W5bEKry19m0jeYiHrdOMIgnPmjdIgYvvRgRVD13FflvhaCg
	ErNN7gQJKchkMVSyPvAx/Ahq1oILTiTVi37sCmBVIrenj+kDewiOcrDvtXvgbdsV6n8n/RJ/jAy
	p6HQUuMdJWSr9+iVDEwQakmdK7qVb0L6tGVm/BrpLeNTRRtaMo2P2HB363CQgB/508d8BOJcawL
	Y1Mg5j034X9MDQDt6a4RZUiwXn1NkQVk41MYWUUo9qJ2Is9Wq/Wdtgd+trgeq9YOKLlnPQqAuP7
	nVKD3W75boSR+74pEM4Ib5YQA3OXSwCoVL8gtTscUZGI3jkidYJL1pDyVCUvKq4bzYoor9P5w31
	aaOaFAJLunA86ko/275eqZCQV0ua8744jdrHVYbW9JeaxTFQ4bPnm2dw68sHoM=
X-Received: by 2002:a17:90b:540c:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3b0db6f7e00mr4594206a91.23.1794040357081;
        Sat, 07 Nov 2026 00:32:37 -0800 (PST)
Received: from [172.17.0.2] ([4.149.245.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103432e26sm1430695a91.3.2026.11.07.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:32:36 -0800 (PST)
Message-ID: <6aeee224.43eef3f8.77988.ce95@mx.google.com>
Date: Sat, 07 Nov 2026 00:32:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6636605858432528858=="
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
Subject: RE: [RFC,v8,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261107071634.2237059-1-cochcoder@proton.me>
References: <20261107071634.2237059-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6636605858432528858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204781/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.85 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.47 seconds
CheckAllWarning               PASS      26.84 seconds
CheckSparse                   PASS      29.32 seconds
BuildKernel32                 PASS      23.45 seconds
CheckKernelLLVM               PASS      26.09 seconds
TestRunnerSetup               PASS      551.67 seconds
TestRunner_l2cap-tester       FAIL      15.42 seconds
TestRunner_smp-tester         PASS      4.54 seconds
IncrementalBuild              PASS      29.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v8,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#127: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 606 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14960055.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v8,2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
WARNING: Non-standard signature: Assisted-by:
#104: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#104: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14960056.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 111, Passed: 109 (98.2%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Server - Accept 2 Close 1          Timed out    2.006 seconds
L2CAP LE EATT Server - Reject                        Failed       0.015 seconds


https://github.com/bluez/bluetooth-next/pull/1084

---
Regards,
Linux Bluetooth


--===============6636605858432528858==--
