Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210663;
	b=0sZPjNBZ2AF6RAXqkQ1sMhIZNTkVOlX3OI6QcfMvLkr2PF0CkJCt80LsxLX1LednVW2R
	 +slodELK65v42AGacZzipccFNuHsn6gGuilhCEgxFwPgyaoN5BH5auqKeBKn9NnruUS1A
	 zWLe3NdAHnQfSp0tv2E6EhWHV8pEuBQGXIY64NGhmhK4B0PwIlyROxavNTM0/3MgtuBti
	 rsAMjeOL7P03mLKpHlglQfiPqx+rtWk0j6hUZPPJATHytnK5UBArrqnzZeq7pTfXQAdm8
	 YkaLCz/rW10FxFFQZ//MleZQZ0syh7NurjqZST+JutwbZNjWsSFa2Fu6irfmCS1r8FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=LPLrRy1jiawzHDEfoLBcpVWf8PVbrJOXYWkGwG0t7WQ=;
	b=ywbSsVjBm9Vhs36S+7aTf6d23fONE2eldRTqqgo25TWNYE4L1A6PLEVa0XbpQ9v/Yjyb
	 MoetjBApMdhM+a1zq9IIDUNMUkZ6NDdS6Zr22HlOcZz7Eeg0iiELvGseBUy1e+8MtJyqo
	 oaMsbAsVuSXQ2cFv0Vxak8sRg+ZEsfz51nJnAEGF9QKTWQ467xegyw3krsBhyaGuGlpnH
	 JqaZZCpsLht8gFzhQ0AQpgEO0uLmOUUn3r5Jev4SRxwsfZ9b646GmoeeUh4KJ/+PgQrb4
	 ZxIHGpDv8UUJfUGe8gROhlXjgEJ+uzkFeplAElpfFcmjHVjdM7CIay5eOok+JjwH76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOMPIpID;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC0606A6A4
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 21:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DC0606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOMPIpID
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-57148b8ec14so533370b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210661; x=1795815461; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LPLrRy1jiawzHDEfoLBcpVWf8PVbrJOXYWkGwG0t7WQ=;
        b=GOMPIpID/PLL7GMgYmC2lVvo8bG1ON7i+w/0AQr4/wpYpEjVEf3Ash1PWbCK9yjdUB
         mYA+29104epEpCuITIj63p+N2rKBOVQ/s5akz8N2mQB2cFF2DbqP3thHFEgSkQqFN2zq
         zDMONqh93fryPDfZqvf2w82wMya3+EohHsRZNVu+FlZxnT5Z54BFIyr3TXPXmivom9nk
         +K4pblHgHZAfCmgK+HgoeErH0Fyhqf7muruF7xjBba4f/baWrxTvtnhfQU2thl6/VnEP
         daD7fvSKbPUf+UDtj7fxMeUg1SMDGR8i6fY786RSG30MRCrz/CpQocQrFdnNDWgo2cnb
         yyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210661; x=1795815461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LPLrRy1jiawzHDEfoLBcpVWf8PVbrJOXYWkGwG0t7WQ=;
        b=bEj6MTYDbXzTO0LIYJ9Ma8l2YMEJDjyCWHFQ4DsZhKw4fTbSt6mgcRrCGGnHKo8+oI
         cuSTfh/XKw3GfBH69UY7O4AGygmgaPw+HLfQghfO78enFCckH0EmpcMzizmiMwWEdzVm
         A+kMRec91SeRB8mxfdHr/p9OdLWPI7ibmcAS78Zbdu/QdOfakO8gG6fhsnWXyuSvz6P6
         hOO6h4vwpHUeWdcod5xCQ4hPWvl1lL/BbjwTJjhsH/+W2knPkWuF30/cE37bmv2mKiPb
         ejNeoDTIzblVGPeyoqLOxBwTNYBXYF2DdrGze1lUeOuSnGihnvCvrGhMn2FCa96Aw3kt
         UWMg==
X-Gm-Message-State: APuU4Z/1TYatP+Lr3/779a3WRY1RNxEfHvjtZib4N1MXJeSfgqQJLDLv
	+tKm9qhS3S3i483v2C/5w8B+WxW8xTCs9Howl56fVbf3HVxNQIkNxlv8
X-Gm-Gg: AYBFou1AHD3TFrr1fuyQM/uAlWbpRyofyEAYPSlJb6c1T9bDbr1r6Qhm4o9V1bouitZ
	yMVyqQhB9UYvmlbzX1r3xpqYBZphanCygq+AvKnGuk3irM1YYvT01fGiw6oL1mxcWFEv1KdJJP8
	FNIIS1ohgrGKjvaMAFid+/x+K/hV9K3XWHeLi4a8rIMDOn6EaM7xbs+iikX7mnsgAUUwkXwM3SL
	O0s8ujjlJN/MCtLM3hjhtoCgWIr2m+9VpKD1hjiNAqPIOn8fYlWrKJUhPCN00bTi495LQuElmaG
	iHC228RWj0qhrbBHf7w/ptGlt9Crv6t/JpzxaFTI1sZryuEabUs2wUcT0EVZxRaDjnc7uFP3PaH
	8pIR+Rk3ky8XLcOAIwVqqvPhJrypZejTzSbrkfvhOTeAPQKP8AIUVIrCk4IoDzfr2JujnrOTMiF
	zl2qJ7jBPupB64Q+cXNJv7uziMM6UiWk2XV2K6/4rXhIQGQw8rnw==
X-Received: by 2002:a05:6808:f0c:b0:55b:fcf7:61f8 with SMTP id 5614622812f47-57a0ab25460mr5585979b6e.40.1795210658899;
        Fri, 20 Nov 2026 13:37:38 -0800 (PST)
Received: from [172.17.0.2] ([130.131.93.41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a31928e6dsm3017833b6e.2.2026.11.20.13.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:37:38 -0800 (PST)
Message-ID: <6b00bda2.e40e7ce8.ed079.de9e@mx.google.com>
Date: Fri, 20 Nov 2026 13:37:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2335771352945004124=="
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
Subject: RE: [v3,1/2] Bluetooth: L2CAP: Fix accepting channels with insufficient security
In-Reply-To: <20261120154816.1745952-1-luiz.dentz@gmail.com>
References: <20261120154816.1745952-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2335771352945004124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217495/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      30.39 seconds
CheckAllWarning               PASS      34.08 seconds
CheckSparse                   PASS      36.41 seconds
BuildKernel32                 PASS      29.58 seconds
CheckKernelLLVM               PASS      30.77 seconds
TestRunnerSetup               PASS      696.22 seconds
TestRunner_l2cap-tester       FAIL      14.53 seconds
TestRunner_iso-tester         PASS      12.76 seconds
TestRunner_bnep-tester        PASS      3.18 seconds
TestRunner_mgmt-tester        PASS      87.85 seconds
TestRunner_rfcomm-tester      PASS      4.51 seconds
TestRunner_sco-tester         PASS      5.61 seconds
TestRunner_ioctl-tester       PASS      4.61 seconds
TestRunner_mesh-tester        PASS      4.50 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      29.87 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#147: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15006063.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 144, Passed: 143 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.124 seconds


https://github.com/bluez/bluetooth-next/pull/1170

---
Regards,
Linux Bluetooth


--===============2335771352945004124==--
