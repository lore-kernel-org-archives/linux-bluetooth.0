Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29031B101
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203181; cv=none; b=hIJtAshsmp1hW4sM3ichtSER353V0K+rL8fOhQjbqV9KUsRAbuUkoJ6vti+HYkUSkS/9Egj3xs8LLLhxgFfrl0QsAagaHG/40VDMmZSvdQ5pvFWyDazMp8N59MD4Xv8T3XiApMDpcNTfzhQ8PTCMHiaW5XOCEzjzPcJ37LlMkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203181; c=relaxed/simple;
	bh=uPW7Q+7s3B36Xa/vSU8PBbCqTSLRKti3n5dYPiAcz8s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PkutII0Xqa154NHyiWC6axlD6BHM3h3ugFJjPAyDfdMjLpNwhYu4RVDa8A00RNKGg2ATKfoe0oF6w9Pv6xwFqOBwl+OPLoxGg3TpCugU4Cl7wDVGplD+i+9ugn6LQp24bnRB9vkKz3fBoZdxc6xSE3ODDjUNWQhnG6NJAW6ykW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riBSImke; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riBSImke"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b0496f4bbcso98927eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203179; x=1788807979; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MX1skhp4Dtu7WFKyCS0oqTBI2pSigasEeCZHVfl4WVU=;
        b=riBSImkeboW7aQrGwDHmqwFTUQxMDptEN2+HrwJzrwiPJkoOBNIo3YL6EvzoqxtQpR
         H2nmmibKX9cfPjKhVUy5ae9Vs1UdKasaDAHCF1r2R7AUntWfYaxxhSs3M7x1gFj0q3E3
         VdpDB7L5P1ExiFCPgH+xgyDL+Cbk6prE9+V3WJWXokSeYj4ALQNw9LrX0g7qpU0AYpY4
         pS3tqeCVaHvx18ePm8J4Cux7DrOEfbkmqAf4fFJ8Cfu9yNIXKJ2iY1Hm6GTnryEXs2Dj
         WjEREwvqpGac/n0zrjscmypyHsjDVJli2c/RwNFzp+m5lF9Z5FFqqv3ZuB7dHqyhUG4y
         u5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203179; x=1788807979;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MX1skhp4Dtu7WFKyCS0oqTBI2pSigasEeCZHVfl4WVU=;
        b=ZetSoAozDW6fu2vdzjZG27rwqgkik9slys5zpZ9XDHAabudgrxhj3ySuJ5oPfSUISk
         IyTu74qntLWHh9wwsZJ/1Z/eOv4dspqq88AgOISnGCldagKEFz9vDPHjZeExe/zDpY5c
         G/tiCHbIQyKe5nYdaxcze1A0JqdWxjF/DHIu2bIJCh0NLGCfNlQQVBLFv2EB2WrnF+ol
         SK+EKNithH5ulo+kQ8EESsXY0uMvxcnkF8HqrS4iaXhjuimb8Pj2pDwkVhnO0do7Sder
         vWzAjbQPjQLX+yXLKnP7MRYqIREzLJfW3UDwtvFtyve6fuIC6J2+QeVJ92KJjiF71hV+
         JJHQ==
X-Gm-Message-State: AFuF++kT23ENMyV0c+z6ZjPqPRGBeDASZD2XrPlGleEhT4DmlkMi2G3Y
	+Wgy/MrHclXRkD3lP8q3YfOLgymkrsvMkuibvQOaXw9XI9cLJnfIc/uaO4ADE/Fl
X-Gm-Gg: AR+sD109WnJmfV2MsdCn1HTLomtLiWnH6pRfC2ONHB1UU2O2TuVi+++Fs6zTAt1QP6h
	HOpYlpKhdGJw+vRK0HkeCTcZMp1Yamn8xUHKCIxmxEQR+S6GGu+YbVpmStNlHTXwcM7sN+eBZ/r
	hu8dOI7wagg/UsS8z0UTSOmq0tqgyuoYCgzKoWgkWCvCA8DffbkCseInPzw8YAp+D7j7SESSIlt
	2nvf+efs1w635JrKzntxy9qoGUgLbSYw90ODJgRYkxYY0smrcrmlxmrSDYWnmXcdfZqf3YwXJqJ
	aIG9NltU9IXSQC6B+bh0qq7LPueiafdYeDX6jvtTYth3PXuyG/b/n7VPGDTC2pC3HS/z1KuVouM
	vLSI4p5Dk/yQhnD9xweQn14cop+towlD5g+ap8OR91TzNaLhb5V3IofFchTVTGVyH14SlQMqOLI
	lbj0aeRcoJ7/gigv+cMEaTwEikfaQOdf8XVFLBF4f4fsle/oDdqpYf4nqpyQcQ8IotsLFO
X-Received: by 2002:a05:6820:4b81:b0:6aa:d13c:a709 with SMTP id 006d021491bc7-6b1c67cc418mr25404468eaf.31.1788203178904;
        Mon, 31 Aug 2026 12:06:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.160.48])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46ad2a8e3adsm6045975fac.13.2026.08.31.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:06:18 -0700 (PDT)
Message-ID: <6a95d0aa.0db9a8d2.164938.b882@mx.google.com>
Date: Mon, 31 Aug 2026 12:06:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2131294444573034087=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
In-Reply-To: <20260831164112.778064-2-luiz.dentz@gmail.com>
References: <20260831164112.778064-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2131294444573034087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154687

---Test result---

Test Summary:
CheckPatch                    FAIL      1.74 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      5.08 seconds
BuildKernel                   PASS      25.19 seconds
CheckAllWarning               PASS      27.99 seconds
CheckSparse                   PASS      26.43 seconds
BuildKernel32                 PASS      24.38 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      456.62 seconds
TestRunner_l2cap-tester       PASS      66.45 seconds
TestRunner_iso-tester         PASS      105.72 seconds
TestRunner_bnep-tester        PASS      18.67 seconds
TestRunner_mgmt-tester        FAIL      222.18 seconds
TestRunner_rfcomm-tester      PASS      25.39 seconds
TestRunner_sco-tester         PASS      32.31 seconds
TestRunner_ioctl-tester       PASS      26.37 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      23.18 seconds
TestRunner_userchan-tester    PASS      19.94 seconds
TestRunner_6lowpan-tester     PASS      22.84 seconds
IncrementalBuild              PASS      24.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#331: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 419 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14778624.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.242 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.543 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/676

---
Regards,
Linux Bluetooth


--===============2131294444573034087==--
