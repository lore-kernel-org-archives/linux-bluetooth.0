Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB23597B
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483334; cv=none; b=UxZ5DRj+trpkMG3YGKzfFO+yiYXPUQEKSv4ySQYWRq7qXYOUdzBrjiHGQ6jomTb8V2Syx0au/q394zP41VXKvgpHbjHPVdeY+fC9Aw+fdOycFxLTbzUeeZ00WasyyQof36zsrJF4MjEXZrriN9L72iyl+FIlFqwYDg0sRUoFVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483334; c=relaxed/simple;
	bh=GZSKlqDJ/7VxmCTLBU6xgSbNWSJ+2HT2P5kn6Dc+N0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WJkTaGRPvR0wVr7l0CLo3ZLZG7y6BA6v7utKy8WA1rIoKIkQM9VtcBdFVZMwjLq/GATVQwoCBET83OPpzGT6LGd84FG2RpzsP8T6wKMd6AxbcixnNDinfTpu/FhJOw1bhpW5eUxsZHUSgPq0fbVULhfVxFSCZd6yTGgsoGFGwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4+XqNr4; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4+XqNr4"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c08df8513so41452151cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784483332; x=1785088132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=byp0ZtC12tdM+jqpoYHBX1N1XcqfC6Bkn6VFHp4fc+s=;
        b=R4+XqNr470uT2zoTOBG3e5nKdgMkGWqxWM23qpYJ6FRyHz+AIwZ87qhQoLLNNZj4D4
         mYfRBD5kL2z62u9bQOfhM/mNC1B7LYBvT7llree2NOiP7iIzQLvg7jiN1dXliID+Btlg
         sLtYUwf4oojyr/7iGtlhHTsQWht1R74dGlx0XvXNjKTo1Efaq4oDubB5KmZAa2D9l/RM
         56ajZ7OLnndpwDesl2KA3bd4/0g11xwG0TLJe6snn2DVnpfBqm7X+fi1/LO9aRN4FlDh
         4E4aSQAP7Bm3Bq5J+1QdrZecI2Fn6bw+5K4NzkHPUX/zU1dYLw3K1WNU0exU5mPDRAbl
         c3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784483332; x=1785088132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=byp0ZtC12tdM+jqpoYHBX1N1XcqfC6Bkn6VFHp4fc+s=;
        b=LP6V5kd3vpYnjChh4EhfOL5dJsW6N+Myq2qH/nzgmhHpfL0nBJMHsMqtgtEzspJXZa
         8CwYZ2+DlogGEDvpNhAfnTZi9rp0OOJayx0tCxe5B9aKxovKvbouiyjNg5q6zW8Kn/in
         QB6c73a5DRsnele5S8DcxUX70fUw4Qt435ErfsbbSO/HrAdXqDYUqSgStAhSuQL79+hs
         0jC++iAyHJS6XCQ2I/hhXxI/2JT+3ksJKh5oIj+eVcut+99BcUubWDv6L8RIHgmQUPwK
         vcdOg6HIs0VaKze2KzD30yr+UUdlTHeNnTcYBOr6MmLcjmcoIGmtmu/yaHfFdPn2KNqM
         6IlQ==
X-Gm-Message-State: AOJu0Yxby3iu0PwGjX4er3lb4kCHL72uzf4I9zaDUHvCHNGZQ0u8epyF
	hFOeXTHLHs8qeVKUign3/s9KtEKlKFpC96w5c3f+ReqTNZEMbKjE/huPdzmqbw==
X-Gm-Gg: AfdE7ckJG8YnbGKisX9F98au7yp+Wmc2UAImvKwK2rMk4e6XJRx79tlfqzmhJ+uSm30
	kH803POx5c69xV13BGmwZfu3JkdSqTljPEuAN7GFa+Il7rUwdWADUUd7uEkNdw4SXXYb0VZZ1jv
	zvo1vI8gNHVBNKL1z+aR/VDxD6AfAj3/x8lN7HtLTnUWprQlzGw3yxhpjpDFNvJZH3IBEAAbfzJ
	FDjwHAKJE/6RaxVZJP8DZYX/xbzvSW+of4b8H3BGJh46Pu4ZMrDGbx6noYW4DIWxJUJtDBlIdBq
	9aUTc8mFzR6m0PfYF7lj12sYPcH06OmXsGBZIz5BWV24HLkf0cyp+KH/EpSWvjssQRV/TljcNta
	oKVItetPSFnpLrEVBl4X/IGD0AXQk+qxz9p8qGaN7/hw9mdc0oP7hcP0C9dHkK2ruM69jcpAbnj
	uq0fxN6yVjaw==
X-Received: by 2002:a05:622a:4d9a:b0:516:cee1:4727 with SMTP id d75a77b69052e-5213c10a2a2mr103803571cf.14.1784483331934;
        Sun, 19 Jul 2026 10:48:51 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.177.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214fae361dsm56959181cf.25.2026.07.19.10.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 10:48:51 -0700 (PDT)
Message-ID: <6a5d0e03.e54e182e.1989b5.b149@mx.google.com>
Date: Sun, 19 Jul 2026 10:48:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7285122795222815921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Protect UUID list traversal
In-Reply-To: <20260719162427.2902105-1-nicoyip.dev@gmail.com>
References: <20260719162427.2902105-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7285122795222815921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130342

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.55 seconds
CheckAllWarning               PASS      29.81 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      26.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      509.68 seconds
TestRunner_l2cap-tester       PASS      60.47 seconds
TestRunner_iso-tester         PASS      80.62 seconds
TestRunner_bnep-tester        PASS      18.94 seconds
TestRunner_mgmt-tester        FAIL      217.73 seconds
TestRunner_rfcomm-tester      PASS      26.46 seconds
TestRunner_sco-tester         PASS      32.41 seconds
TestRunner_ioctl-tester       PASS      27.26 seconds
TestRunner_mesh-tester        FAIL      26.97 seconds
TestRunner_smp-tester         PASS      25.23 seconds
TestRunner_userchan-tester    PASS      20.39 seconds
TestRunner_6lowpan-tester     PASS      22.93 seconds
IncrementalBuild              PASS      25.62 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.257 seconds
LL Privacy - Unpair 1                                Timed out    1.991 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.528 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/457

---
Regards,
Linux Bluetooth


--===============7285122795222815921==--
