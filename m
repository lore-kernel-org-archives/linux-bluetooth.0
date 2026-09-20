Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1482EEE7B
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908385; cv=none; b=gr9WM3AJKzWex43OIFuJVJYme4PlKFFy+hWSKSnr67L+E222BUvdtdX8keNqqmKCoYTz8LoqsWKAToQ6qNErwY35iXlmRP1wTsslxLw08bg7nKQRcChAP6jGT+36KgIz6qzFNVJ9cnet52PJ8S9dlIWU5/pttPMjmvUMrfxiIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908385; c=relaxed/simple;
	bh=d4EGUocZSgO676mz7hUkQDVxkdiPkFUW0gBKvgCG16I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pxIPZRg9YWKSKjxkfv2JaMzWwVaHf1VjCClRRzG2MfI/H/lMlBrPo+gx+4uVmbfurK4nBwLYMNk6QB1wmaG7aUndOqQHhZFUshCle3KhTpNU8g3Cdr+GitlMjVcDHXxwPr7jU/E217S2hjcG0H45FcducodAnzDqWPOq4Q0Fl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SroZbONW; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SroZbONW"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-532b353fba2so6813771cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908367; x=1790513167; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ei3Lhoi026784/7frL3MiUQktdy+pIAbMDWpuz3wDks=;
        b=SroZbONW0x2RDhfe0DMEmS5BxKhtQCzxNqwnCNg007VM30r4hLFlMCxocfyYnhEJ1x
         HGIG3gi0nnwSSW47vCmj/GO+o59XqlHM4UmAND8lQotqCu7PuQZxsymw0Dc4jOTT1In9
         qizLzWwJG9bxHrFJZP3YeGHgrUZPZ7jvWYqtZuE9sCofK38p8FbtSjKy1M76eCcK/rPa
         VtsBNkBw0oobPb6Q+rC2oSlSoTAOXzzY3QAtlRx0K55CHszxF+K9fsL8u4ywhFQUGMIT
         +rMjmvE+TEE687BADixdjwr43Rs4hOahbjG7zY2IWMGrbQCsK15Fn4V1aBD97LGQ3Xo5
         Qy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908367; x=1790513167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ei3Lhoi026784/7frL3MiUQktdy+pIAbMDWpuz3wDks=;
        b=XO6ahlw4I8RyBL/DzhUGalkWqftLRtFK5VA7BVqWTL9ISF6kX20TK28b4o73bijpZr
         3gRWc0WSTWxH46S8+kezd/vgp89FjDog0JHcfWni0IlF+2LEb05Phra00gU/q4xNVrey
         eTYCLIsh2BCjd47BQducnv+Fa8MyujSHyZVfM8LHCIawbRnsrjPaHsdIZ3PAMrcL7Uk1
         EKP+IftCqW48vYqPjQnLUxJdgzbwCjuDtgkKvtmlQGv1ks93pxByOJrvOlgIZdqpCFhP
         36bsvIWO+uxnhacoCl4+popJ0qNuk53WFp6S1NdKxd2+0mkJvzf/O3DAhdCD8is9EFtJ
         dZcg==
X-Gm-Message-State: AFuF++nxHMUGngcF5ZqhXrbQCwoOr4ERodHPoo40TW+iprnkm9zz/FwE
	LzzGsvSllJe277isfvZMhcKPAFLH6nFCRnV6wK9BrztVxvo6AzoNJmh48mOxFA==
X-Gm-Gg: AYBFou0ZzHlvlKRRGsjhAvnROxQjAvlzccCoe9DRYo1NG8T1Ki/kvbrwaSjQsKjEm4j
	RAviIbsJCtt9rh+Fifu23OI+8HLp+8NqsVpnxZ9d3dH7eEPb/ji2riMo5XTb8f4eSrDSiGKa/TW
	2dbPd/kwudcdWSEdMAbyx1AcDRmJzAyO1mEqJPudarIBr/mK3neBsBA864hPjrb62j8m+05mJE5
	saXLpZm7YmLrfjUjCMGgC2bwwS3DwG4NTGa6pcXmIrGnH8gE6cmiig/9/qKBjWwgXOsn3sfwyb6
	Sag30wmmFzsYw8VAgknWUvW56capqy9keGI9D/1vhkccXuBXePTZRd00Jbxz+h3j8WkqoByYG6q
	qDJR0uDI6oSZ1fDDl/FBpPf0fLmLaQReapyyutDjnWvaEtbY4Dex95Qi56PdsAR4lwThUpca2Yq
	2KF0a88lEAT0/Es+KuMdzXKRiaxJRO1JNYVmDygOvHdtzI+5gT5QPF22TRHpPnBlUCRx9PLSwVl
	RevvA==
X-Received: by 2002:a05:622a:2b0f:b0:532:a2ba:d19 with SMTP id d75a77b69052e-532b71e96f3mr56184841cf.11.1789908366871;
        Sun, 20 Sep 2026 05:46:06 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae7737f3sm40292161cf.28.2026.09.20.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:46:06 -0700 (PDT)
Message-ID: <6aafd58e.7c3782f6.3445a4.2c4b@mx.google.com>
Date: Sun, 20 Sep 2026 05:46:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2455134401166853659=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanli.yang@bedmex.com
Subject: RE: Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
In-Reply-To: <7a2c93192831b8756fe071fd60ec064a05703b8b.1789897503.git.yanli.yang@bedmex.com>
References: <7a2c93192831b8756fe071fd60ec064a05703b8b.1789897503.git.yanli.yang@bedmex.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2455134401166853659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169702/

---Test result---

Test Summary:
CheckPatch                    FAIL      5.16 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      1.04 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      29.36 seconds
CheckAllWarning               PASS      33.40 seconds
CheckSparse                   PASS      36.21 seconds
BuildKernel32                 PASS      35.25 seconds
CheckKernelLLVM               PASS      33.21 seconds
TestRunnerSetup               PASS      795.41 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      33.05 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        FAIL      61.10 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      7.68 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        FAIL      7.86 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      5.03 seconds
IncrementalBuild              PASS      34.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v2,2/3] dt-bindings: net: bluetooth: Add AIC8800D80
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#90: 
new file mode 100644

total: 0 errors, 1 warnings, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14832276.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v2,2/3] dt-bindings: net: bluetooth: Add AIC8800D80

18: B1 Line exceeds max length (90>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml"
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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.021 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.382 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/805

---
Regards,
Linux Bluetooth


--===============2455134401166853659==--
