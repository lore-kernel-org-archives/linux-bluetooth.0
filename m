Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299C26AC5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394066; cv=none; b=lsnmVL4xMwYPTmR9y6piJ+kBdLM02FR5BOMEsn1s6yZ2nF13GsjTEkeA6+thC/EfncZlckhU9i0+JBf3hvyAfu2C+blosQdtrtkHj83plZoK0tTpFKF3YFFPhotieBOjQKMewU4zUF7D4u+BpTq5AGH3fUIPJIgYduDY/IupLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394066; c=relaxed/simple;
	bh=TG/pXqC7AD0N2u2bca97x6eqsIWmbUnM1jjGw6UXKto=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dgJJcv4UiUdc7apGUIRwkGo4LDOj54EXQXF627hhIgfbl/4F0BC9XIEb17BFWQtnCCjt+3nIbuUoJsaMgpPpwR839gdCWFJnpIGIRGFoqwUu8cler7wnk7h1k5Of6ogho5A/QS4VFAeZHLB055JtHQ261QFj8EHWWgYCSlLD1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4zRTtbj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4zRTtbj"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93900ed2925so166438685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394063; x=1788998863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hUfQIz5YdiJEhDXzYMKAIMltixkNbgPu0QUyH+fBxrk=;
        b=p4zRTtbjd+tCQgdpubT7Bm3yXVruswNfLcTLbdGyLVDcUl3HvaSO0SyZoPWYOHGhZk
         IMr3qWCpIBcCml6rcAdJt0PkK8Yf7JqzW/YBF7RLKI8rq5bPplht2nvN74CwwpzAEpBW
         pjFjTfy4ByRODZTAq6aX67X756r2cDve8nHrLe6Cf8WTMT8juOdfTXBV67XNV1uWK7hq
         VQS6zONngPsoMj7yWzz4XJ288zk+A1Tps3gGcRljyHCdMnBfy3aEtVjdCB3KigKnlLEK
         b0AP5GtlhZNvkHb9NVUOtKP4lq7IXY94g4T9EmcCd5agS2uKfiHcn3BnxuixW9oOGulK
         u6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394063; x=1788998863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hUfQIz5YdiJEhDXzYMKAIMltixkNbgPu0QUyH+fBxrk=;
        b=YhLyqICJsTfzi3W3teTBxgvRdimKysdm2wt7RQpU+BzyCLYTnwIB2xeeKVU6SUnxJR
         KhpOnVJkgf5FrVaGe8Eqg7xkV0tsuE83onijm0r15GpHvGP1MAODVZ0mrALlsXflyQ/u
         8ETbimJAtwbK2RAVgAWI4vd0gUNeh5bFNBuhUVad16rTKdIrFCnlh1abzgpoygaEcmSt
         rJ0xdssl+UjYjWe9A2KctVANn5+1rBOG1GerL3BX1Jyx3Kx1Riwk3CTMQpYUBNxF9LmY
         E6jTe/N9cInPd6VccMtTLaR7AehXu4y83m4G8moYCJOb7+I0EIadsPlwXd47QveQSJyc
         gVWA==
X-Gm-Message-State: AFuF++neUpO55Wi5rFHNMSK2bdnWKrvqeR820F/xBiaFHMUN3/CRJPti
	6CaJGLZFT40Nd/RwZ6PXtBpI/71+Q8NCLAYlGk3vyuLt/b3vw8ALfaaUBGRbqA==
X-Gm-Gg: AYBFou3yOfI5Q9VfYuiql4Vrdq7GYR7OXJTVRi9iIV0ndrFI/YFXEJkmU2HS1H+ZM5s
	ZffuyGBg6/zF2jCgeosEDqwFKFgWyBS2654B6WyVVOxfHqssYlWY6KhHS6Bka7PQqr1vzAMgwJG
	baAbM9hMdVQIFTfigdtJ+1Qve0arPJd0Cy/LE4554MxLNQ1kUQHBdcL1Ud1RRgi4hhoWEo24W7B
	x56PA2yECqzlOBQIOyIFuhxYLsR6PcjqUt2bRCpbrit7aAdJuvbOEoD1Z1grALP/CtLTzVzgNeR
	noJ6co5Nq/wxR5qZ1pPX3j3G+Ts/XjnGf9vUB9OVEs54F5XkSUI5KibPQd85otJttcdDYFTRxq7
	NIesZEgoLKXSEVb0wNkCtAx3ttv+fEBOc3WVVlgm0bSyIGjdQWdztklzf9eryb//dA4VZO0sIn7
	j1aw3ETgi2FTuXxZHrtSwfV/2bDLEIooI2WUMBNrfIfW5L3wJhaUkZX89HPzkqRE9hMtw=
X-Received: by 2002:a05:620a:4442:b0:939:6de6:951a with SMTP id af79cd13be357-9396de69720mr368739785a.49.1788394063187;
        Wed, 02 Sep 2026 17:07:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.95.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f157807sm345699385a.9.2026.09.02.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 17:07:42 -0700 (PDT)
Message-ID: <6a98ba4e.c394364f.104264.47f7@mx.google.com>
Date: Wed, 02 Sep 2026 17:07:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8312432479605784158=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: btusb: Fix UAF of btusb_data by rx_work
In-Reply-To: <20260902214620.44041-1-luiz.dentz@gmail.com>
References: <20260902214620.44041-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8312432479605784158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156528

---Test result---

Test Summary:
CheckPatch                    FAIL      3.24 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      24.49 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      22.29 seconds
BuildKernel32                 PASS      20.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      408.63 seconds
TestRunner_l2cap-tester       PASS      68.52 seconds
TestRunner_iso-tester         PASS      103.83 seconds
TestRunner_bnep-tester        PASS      14.86 seconds
TestRunner_mgmt-tester        FAIL      223.65 seconds
TestRunner_rfcomm-tester      PASS      19.83 seconds
TestRunner_sco-tester         PASS      25.26 seconds
TestRunner_ioctl-tester       PASS      20.69 seconds
TestRunner_mesh-tester        FAIL      20.57 seconds
TestRunner_smp-tester         PASS      18.37 seconds
TestRunner_userchan-tester    PASS      15.47 seconds
TestRunner_6lowpan-tester     PASS      17.96 seconds
IncrementalBuild              PASS      26.43 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,2/3] Bluetooth: Move H:4 reassembly into the Bluetooth core
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#331: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 419 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14785931.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/3] Bluetooth: btusb: Fix UAF of btusb_data by rx_work

13: B3 Line contains hard tab characters (\t): "	while ((skb = skb_dequeue(&data->acl_q)))"
14: B3 Line contains hard tab characters (\t): "		data->recv_acl(data->hdev, skb);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.267 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.856 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/692

---
Regards,
Linux Bluetooth


--===============8312432479605784158==--
