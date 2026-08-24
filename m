Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE0439F68
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582025; cv=none; b=sopIaPZGh8HXFVtlwpY8rGRTOBAj+9/ohCTBgb2+dglYVSkRjatilTffPDxCNcGydZ4Zre7fhU7uMTzN/YzohNFS48d69v3rQqJfHlXXEynArisyPVFe8mqamr0hF+kLmPvHliocyLfWP8q5/plSY/hiQNFmL7KvJg389xlIN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582025; c=relaxed/simple;
	bh=jH4HZF5GfmrIbKmbyAHIeBuUampA3NN3NVO0Ko0knTk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P1P9NjqJsbfxRv2Nmr2rD1VI4CnQlGEkfZfssvsMO9NdcpzRrsa/xCIB3nSjo12vSgMvOq0wn9nX9njcCJEIzdeUhtb4M3SDWnLI1wtlY5fA5gOfpLYqW3RjRJ75szltWSVIUswyQOJxSBsdvW6SvsIbXgiWwMRv1FQzoib28n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWwV9Vwy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWwV9Vwy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4349901a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582023; x=1788186823; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eUooFTowmFBj/AC51rrCXtAn3UMrPL5aMtRtMH5wOkM=;
        b=BWwV9Vwy1GxDdD2xMS8R31DAwetrMthju9X7CjHc/fzz1xesnL9zLjwpRHfpPpYrqt
         R5RXvEy86aRwoXSiFCDO3BBhjlTpaJs+2+kIjCeltxFMHMWLq6N4KjRq+e77meWREdzX
         VY1yG/IsSF5WtZxCFvUQSbV4QZYhzYf/tyvcE1AGsmJscnnpihebSN3Nqp9DB5wMJ8nV
         QNQF4SzICv+gJBDYWPKDLt2h7wCwNg9Uk+NpjO0jCgCGIWSkHQFgeC+LZbzcL0JfnWnJ
         UdhjD0kd9U34zvesP9ou8fcnnSy2PZi3cDKKmS7nTH3KY30LYOq1NGWIzSBi4hRMCZS1
         3GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582023; x=1788186823;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eUooFTowmFBj/AC51rrCXtAn3UMrPL5aMtRtMH5wOkM=;
        b=XpZUEqEbVJR8HX8AzDQ+Rzyonwq6DWEx96YWM8wt98D02bh+//TOp53cTcUf67Tw5U
         k+A+pCPrjmGdylxcHUymLM/lxd8tINZWUal8rsJMA9JBjujNaajomyeK5RiBNgwzBjg7
         eKY5Ks8sEksWvXFvphyelogfOVKZzM+nZtyrP1S8BtMf97amH+BbF6nnTErmoO1Sdf2R
         Uc19l3vSNPF3alnMk1B22E6k6MQ3mi9eTxiQfR1H1E73JtkwluIRYjGBosiuOHFjfR8z
         uGqwwn/3Y0t2XGt4pqPxNTS1CPJfFX6maJwSsZuAiIhk22YQzGdQH2AZtqmH65RXaLDm
         Ieyg==
X-Gm-Message-State: AFuF++k+CiIxFZIoZZOaxprfr+V539DaJSBJfST7bt5UEi18xoHGpgkz
	xEmaOxk18HF89LDlAHjUQiqC6TygDKm94fp6pHPtHf7TY481WIi44eQdwZoTVw==
X-Gm-Gg: AR+sD12e9QT/+kyYowHNgR/PYfnpT6bFIkidOsuwu8qpJKq9cvCE4Nls6B9oFNrAiHN
	n/2xC53T5t1CNPCt4fdnbd2x7SQmvgNvZxlpRHTrNxgXJXFkq+ufBx8TSyibbXs7JtJLmZNdUp/
	sU0qXHp2BixOuWoeqjjTVN7AnBqBF0iW6vLLlyT21R24lyu5oJRh/raMdGZAL6fEdhcRiBSdsgY
	repSaOf2lPcyKsWE6uvaNPiQh36lHLd2duuzQ8zPDNyENo866iQfmUFnhcj2um1220H4MdZVF8d
	PdfLa+pEa24xpMYjVo/B3epnlUPLvMOXOG1jQN9ajzLC3EnuIXGfg7KvYctBGHtR2lcKlpp3TA/
	fH6VKxS5dc39VydhHgEwlOOCeioUiaBcEeOTdKYPTY7YSorgKSg2pD8qIEYLsaj8HQE4n04r0Ir
	W7lfSMxeqO+fH9ZqvJij39MDnJ5GPBDeD9rRVFMI1MQl/o08fhJMEWG6aKe/YzouOg9mM3tLTCf
	IDYXw==
X-Received: by 2002:a17:90a:d44d:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-395dee7e2eamr35609234a91.1.1787582022566;
        Mon, 24 Aug 2026 07:33:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.198.232])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6e6dsm23752254c88.1.2026.08.24.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:33:41 -0700 (PDT)
Message-ID: <6a8c5645.3f2ee557.13dbd1.7444@mx.google.com>
Date: Mon, 24 Aug 2026 07:33:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3908459283838197603=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v5] Bluetooth: hci_sync: wait for directed advertising completion
In-Reply-To: <20260824134149.212607-1-nicoyip.dev@gmail.com>
References: <20260824134149.212607-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3908459283838197603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150937

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      27.42 seconds
CheckSparse                   PASS      24.44 seconds
BuildKernel32                 PASS      28.23 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      427.64 seconds
TestRunner_l2cap-tester       PASS      62.80 seconds
TestRunner_iso-tester         FAIL      92.02 seconds
TestRunner_bnep-tester        PASS      17.87 seconds
TestRunner_mgmt-tester        FAIL      206.09 seconds
TestRunner_rfcomm-tester      PASS      23.10 seconds
TestRunner_sco-tester         PASS      27.28 seconds
TestRunner_ioctl-tester       PASS      23.03 seconds
TestRunner_mesh-tester        FAIL      23.68 seconds
TestRunner_smp-tester         PASS      21.01 seconds
TestRunner_userchan-tester    PASS      18.25 seconds
TestRunner_6lowpan-tester     PASS      21.11 seconds
IncrementalBuild              PASS      22.13 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 136 (96.5%), Failed: 5, Not Run: 0

Failed Test Cases
ISO Broadcaster PAST Info - Success                  Timed out    2.680 seconds
ISO Broadcaster PAST Info RPA - Success              Timed out    1.987 seconds
ISO Broadcaster PAST Sender - Success                Timed out    2.006 seconds
ISO Broadcaster PAST Receiver - Success              Timed out    2.811 seconds
ISO Broadcaster PAST Receiver Sync Lost - Success    Timed out    2.525 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.545 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/644

---
Regards,
Linux Bluetooth


--===============3908459283838197603==--
