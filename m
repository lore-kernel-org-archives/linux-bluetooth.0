Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18535C6A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229489; cv=none; b=o/BTicsUVfVddiTzmAHa11hVN2Hf95ogdBNPHbpOKVlTQgVCaj6rrZnb9aUWEoZJLu58rrAfW6P0D/dvvTPsCTSkG/EJSAmQSZ9WN9Xnp/AxSwS5hNawAsKVgGNBO2nIEIdVJDI5/bwsPKcqLYnF1y9++U+g39pFraVJGOGlaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229489; c=relaxed/simple;
	bh=/gCFaD2DimPVttrwSbl3lezfXgj9ECBnJeKDScU4HW4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AhNZRoxFVL5lW7ihWAAtARgKOl1zuJZXqvNVtTeNRBGX1F8aZnTXcRNyoPVV+70FDP0BXPiOeeUpvn0jOevrcBXucN6QQs5JeNP34H4jNDvUyRFkIkzEvCsnfGDDh5YVVFM9P67aDDfbOh7vJ9vJ2uHK9AHb5bwfcB2gmRxeM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLSuksp6; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLSuksp6"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6bd42f1c01cso1003451eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229486; x=1790834286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JfLdoUVQckh7Id1JdZ7ebB/v4QbC6atuxSDvyOldNkE=;
        b=jLSuksp6L6D8SdZYjpEa9hR2Lt7jKXrcE3yxfsFFveHnNjyCPWJfUsSO1yhPQY8jFO
         nLJ4fDrWznddddPufO2QuZd6nnS2CbbpQKlJ0uTI40PvGfzGsIErGHZOiafqvx3cmb96
         JQfMj3E09bLdn662wj3tUwoqZ89Ar1M35kazQpDSMv1P43i00HxK3N+OUKrAQSDZN90G
         8dutxCggdTcddqgkIrE/tJAcanQLbkeDjLKO17pAe77XraJWLTfOADNiHZWRK4K4ODU/
         SMt3xSnXN3/03isUqfx9uJvQ1sh4RxXGV+4ruEYXZE8NaRf60YE7RAKGnZOES9IEGeaI
         nIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229486; x=1790834286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JfLdoUVQckh7Id1JdZ7ebB/v4QbC6atuxSDvyOldNkE=;
        b=pt+/1zqfEIxBmTlOUaZfDlKxD8HV3lLaQvVswUAKnaNiZEs92oy5/322JtnTqy3AyW
         L7RVTECOsF0Fx5PmkCHwE1sklfj/ojdqqkMWTbmLy3k9IxXM7PIqS8GzlFsp8DPyI4RI
         fwoPIi+FSvOj5W1f9QnOf7cSj6fqBTBjLUgNyhSKKhx3s8a1M6g4eUIVuMrWH1B7ZKii
         zuZ563HEBabemyRSbWepzXJ9wpIiNaeww8ScEgCk4aM3/iimsjBHO0UJdWUC8v6fvqv2
         NNcaylLjqknNRLOqqWOejGQkegbGqKVXZmUvE5u9FJv5FaobcEOsEy4c2ak4vGgSzdy5
         s9oA==
X-Gm-Message-State: AFuF++lZwsVSmsywm2J0iV9qLIq29+XVk1BlLDvMQpM5ZuPeqIdPfvn3
	tgndqPBGSukgMepFQNvBt0rA8/XAVrIG8QJDPbAfE3ybJQ3n0WH4uuPYz7HxiuIk
X-Gm-Gg: AYBFou0OAuYYt3cwCnGTOgCgBY+veqvEnT9Dsl4cGQML7dnXQq3TD3VEQZ75usGk7cq
	5s7+j/iMuOC2KTnB5Wm9TLSv08JmuD3/XRyOLA5+XeskiPT+Pd6YPdL9AYKcOeZtri4SocppJi8
	cmdk+Evh0WrCcxsfDo4MtvPdN+qfmuYxS1GiD7/tPEyPM8EbOE3vFJnX5bNMPit7C9BvrPe2XUJ
	puAMlp03vgER+ga0DZNzm5SoCQpModB986pBVogPc87U5iBs9ap/PYYn0TZo5LqhwWPiQukVIu8
	0IY8uX6pmWXFjctSWI24AOCBKrXyCvFmh9mlqnGfnmunAOiAyEOyIYk0n6Cq/s1S9KuZLmIR9Xe
	jDyQjeoH8b9/WIg2ZpfBMsYS9LoxIbhDeuBIRwlEavuz/kv+llF4L3UTT+MvIkUGvTw1c55GXD7
	38Hp6kaSLfDpwip73usi1+aOCcDm6iIw/Qw8SLU27ZsiSQ4MF+g7lTkgglv5Sh4P5XpglQelsMe
	c+JskTz
X-Received: by 2002:a05:6820:995:b0:6cd:3ffc:e32e with SMTP id 006d021491bc7-6d4413c36a0mr1552810eaf.76.1790229486441;
        Wed, 23 Sep 2026 22:58:06 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.247.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2cee6b2b6sm4749866eaf.11.2026.09.23.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:58:05 -0700 (PDT)
Message-ID: <6ab4bbed.0c0d0188.7b605.76a2@mx.google.com>
Date: Wed, 23 Sep 2026 22:58:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4876268379324837408=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanli.yang@bedmex.com
Subject: RE: Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
In-Reply-To: <179022103315.2.14115293924296380485.btaic-v4-1@bedmex.com>
References: <179022103315.2.14115293924296380485.btaic-v4-1@bedmex.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4876268379324837408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172703/

---Test result---

Test Summary:
CheckPatch                    FAIL      11.55 seconds
VerifyFixes                   PASS      0.94 seconds
VerifySignedoff               PASS      0.54 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      27.52 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      23.34 seconds
CheckKernelLLVM               PASS      23.99 seconds
TestRunnerSetup               PASS      584.16 seconds
TestRunner_l2cap-tester       PASS      18.36 seconds
TestRunner_iso-tester         PASS      28.06 seconds
TestRunner_bnep-tester        PASS      2.80 seconds
TestRunner_mgmt-tester        FAIL      59.52 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      7.09 seconds
TestRunner_ioctl-tester       PASS      4.37 seconds
TestRunner_mesh-tester        FAIL      7.68 seconds
TestRunner_smp-tester         PASS      4.56 seconds
TestRunner_userchan-tester    PASS      2.83 seconds
TestRunner_6lowpan-tester     PASS      3.99 seconds
IncrementalBuild              PASS      30.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[bluetooth-next,v4,3/3] Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport
WARNING: Prefer kzalloc_obj over kzalloc with sizeof
#251: FILE: drivers/bluetooth/btaic_core.c:48:
+	boot = kzalloc(sizeof(*boot), GFP_KERNEL);

total: 0 errors, 1 warnings, 1483 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14843267.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluetooth-next,v4,2/3] dt-bindings: net: bluetooth: Add AIC8800D80

20: B1 Line exceeds max length (90>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml"
[bluetooth-next,v4,3/3] Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport

1: T1 Title exceeds max length (87>80): "[bluetooth-next,v4,3/3] Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 500 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.191 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.639 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/816

---
Regards,
Linux Bluetooth


--===============4876268379324837408==--
