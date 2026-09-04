Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530814A92D7
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532076; cv=none; b=pjnuV5dEsBYyCa0G5u1ZhxTN8zYYWuKdRgCjbz29JHENNy+my2t+Cgw/LaBUkEfefwRUvnuGsPKK6jUisgL3t7kwyTgNXmRwR9ca42lVfyQKMXIX5nUa8jPDoWAL8P1a722Hkq48KHQsSOS0kL9CtgF29KtnWsVRSV3KojmTKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532076; c=relaxed/simple;
	bh=6lFk0S149fgCPNaFiJWpb+pm0L8Kv++NX4HPCqLLNXo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oqmodsRLgSEWMK4dv2NDLdYXYJyO4ju7UPZWAiLJcaYctRqoXzJS2YeYAHS5Ob27dKkjLqpIuacV18rE6vk31DDY94jUaott+AP8WTazuyam0LT2V00zzy0Jv1bukf5MMJUVxVR9Xq7Ds9yqXBUtrhz9kxHqH+voAAhCsxbEMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLhx2cFJ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLhx2cFJ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-459281bc13bso776813fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788532074; x=1789136874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ggIVotpWA5C/SZeEfzMLbPMFrffkhMuKxlCmQG2N5w4=;
        b=TLhx2cFJKGdO6G17ceBmpWwoH3QYLpk7VCiOSMABSYzy4/ehgdpk/D5sFn+xFnF4dG
         Fkd6VvxsNDYLmurFFGFyBTetunBBHwpFC5GWcZpLllVxRXpGxLBKvn/7eBWQ+a3hs3vM
         xwktRxW5JcBtp1SmbUwgRSFrXw2sgGVBouoPy+CRC4dXElenRfQ91BHlfVqzZg/a8Eao
         dfw61FxTtQoy7Xy2p5bt1zkS2VdTM92PkvOXDiY2p1X/3njB39IDUA67qYg6Ay9qcoKz
         i8AnHYaU0+caA6TAIS9CCqKerPHgIlcDuUxzgXcVwbG9z9WwHeumNsTeTYd6Eu62GcqC
         fA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532074; x=1789136874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ggIVotpWA5C/SZeEfzMLbPMFrffkhMuKxlCmQG2N5w4=;
        b=aCJUxhg7JcHe6Ymka0oqw+CcgePA3uy7oy6hghWDM0tXtEuChdl2HL/xjcbDOiLIuy
         sOAuxzETp8AeYqtlIt6rKfk+xzC7BePp8Kv8FfycP3PGZqW9r3CSwq/UBeBHZda8WCpV
         sI/bZXu78cUeZU303q/pIZD7YyiBGG+GfpWZIfBIqx/7d+Y+mKzW/3sNFKaZ6vP1SRVW
         8p/jbRB6vUJyoBeXWLlzWI6eHhciYka9RI44AqyomSunnvhs1qV8jR0Wn3bCLSHlRJ0R
         agpzQv0fir0HGRrY8lUamkNAdBpZHijp1nsfZbz2CQDwv+EBm4dE8t3+a16q/S6bHlCX
         MBIw==
X-Gm-Message-State: AFuF++lF6TzslCxGKEUnSErNm4bmMwhr+5XlhqZCiInVQKasuFaERmcM
	wv2WLV7BjbqyzRreFwHlkljkIiXRV7G9wIJk9d8yHFHsE8eNF8F9Zi5UCSV3eA==
X-Gm-Gg: AYBFou3cu6Rz0xrEfzOKCooh15zrUeIngFWY03PqU0hy//DPPVTfolLikittnpr3SBu
	lCoUi24lJgAvskt8VmF2bLW/GtXjE8PBDYDslJc6N/bilwdum7GUuIVu8Bo+lwAwlDcIuL23+ik
	Uj+z9pngQBbTL/HfZvSA/vpBKYB13JkJAVoEnHhmSKUxJ9Z0RGSJUJI6ICgiDfdGyizNtJKBqoR
	sfA0yEC7sPSN0bfilQuynQeffFsdYCgNCucORx1H1nbq5F/Cgn2QwN40TdhnLLnQUMrC5v82hNR
	Vc5lJgxbTat4sY5PkxOKc/7O1PGoYZ1N6a4tTmVighXonJzBp/OriWdIi37GIE9WjrMFmcnZZO8
	Ho5Ro4vgBOpLsPTy9KWWl6KRx6FR2BPY1K2O/879mpQ745fiH/Zj6HDlEKZXJM/jtj94DGFpaUu
	wqKVAmzXJY5Jei5YtdYFxkOaIinRpZL3xZT2FKawvIX69giRtm0fi4gOcIxyZCR0pWzFs=
X-Received: by 2002:a05:6870:326b:b0:448:9d5b:6393 with SMTP id 586e51a60fabf-47552f997eamr5422727fac.14.1788532073674;
        Fri, 04 Sep 2026 07:27:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.78.174.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475541a8becsm2126742fac.6.2026.09.04.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:27:53 -0700 (PDT)
Message-ID: <6a9ad569.8cf4c31a.265cdb.1cdc@mx.google.com>
Date: Fri, 04 Sep 2026 07:27:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3690236689241224167=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, syzbot@kernel.org
Subject: RE: Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()
In-Reply-To: <388cbac3-b865-4843-bd65-c74059a5a459@mail.kernel.org>
References: <388cbac3-b865-4843-bd65-c74059a5a459@mail.kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3690236689241224167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1158014

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.84 seconds
CheckSparse                   PASS      26.18 seconds
BuildKernel32                 PASS      24.60 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      443.05 seconds
TestRunner_l2cap-tester       PASS      68.34 seconds
TestRunner_iso-tester         PASS      120.15 seconds
TestRunner_bnep-tester        PASS      18.43 seconds
TestRunner_mgmt-tester        FAIL      228.15 seconds
TestRunner_rfcomm-tester      PASS      25.11 seconds
TestRunner_sco-tester         PASS      31.71 seconds
TestRunner_ioctl-tester       PASS      25.97 seconds
TestRunner_mesh-tester        FAIL      25.05 seconds
TestRunner_smp-tester         PASS      22.84 seconds
TestRunner_userchan-tester    PASS      19.23 seconds
TestRunner_6lowpan-tester     PASS      22.58 seconds
IncrementalBuild              PASS      23.17 seconds

Details
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
Read Exp Feature - Success                           Failed       0.256 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.028 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/706

---
Regards,
Linux Bluetooth


--===============3690236689241224167==--
