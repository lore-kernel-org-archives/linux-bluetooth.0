Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BF2DECC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768337; cv=none; b=HxsMNCL+42egwa7g0oKjw1IqMf2hC6ElO4oSIVS4a6ZJ5Y4P3SYQSyyarnOWuGwBYb/dIacuTiLwFhxy0pYqERY+XvL1AbMK1R+TO18yskrNR35yw91+lCgZJqou6YK6Y7c1qFVJ4gazU0mY2rkzOtcgYFfuTDPgc6RcT/otWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768337; c=relaxed/simple;
	bh=bcJQxCj4bBYdCszNGvbYSU0SooB/Os4m7VmWrA5gN6U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ABdKeUEhaiMU8AQ1O/gczhfuFPRr31HAym48hCkxJQJE7mjn/VDvC2a4dCGlRgtv3CI82Kp0n2Feivsri5voba92jxomUmS5HxANQgLn+cZjTAEg3+FmwrUrrXIXQrT+HXbpQNXMjS1iM6HMngwHA7raMp/vJxq2+hZg+KugjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdcdqZfV; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdcdqZfV"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so479123eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773768334; x=1774373134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/EyHo2HdyXEBCB8JaJ25lDoE/TgnD1dPp/TCel9RifE=;
        b=EdcdqZfVzw8um3WPCwpAv60Ev9gbMr6rQ4yorHRKisLU22YYc1Qydi9ThSKOpY9kZQ
         6uruLUfDjjBAlrLLhNRFe0x6uWGfgTygUPv7PEoHdRRqrew5zuAQ5xrbsetKTsJFk13I
         R/E8LnLQBB/CilTnMiE+W7e+m4qVvk8MtrzxAfAXnj2bMsncBBKoUnyszdvoWOtI/vy8
         5sXoh7TSN1OLY0nr5L+Vwl1JKEKhsTKNGw3o54UeWa2pTmloCLmo411Ma2Q2m72X5+24
         C81sJU2yb/yqSiQKfyEDN8ISjntvHqNoLOpaXbBM+wqX25EBDDI6m1iHOoUgtZUAclMA
         crpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773768334; x=1774373134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EyHo2HdyXEBCB8JaJ25lDoE/TgnD1dPp/TCel9RifE=;
        b=LxhkGAVz5XrF1VjM0aIyIEMwDm2yuBehys/I1U1qv07xxhqCUwLC8e4GSZHhcAJm5F
         /vIaWfMgdCxL9BPciKfc2i4+stoUrshNYsX4yxR0pRgrn89MfApzy986eNOJ4ty6GMEe
         NfrMCmfYK9OveV/TANEs1ZX7bSuhO7x61fE004m5yugoXn+EsCNkeF+e9unz9NOtUKwc
         TMFKI2ud2yf7zTO/jzua79shZdOVtbuPkyWIL3xwqAML2QA6wcfHz9PRe1A+UVvpt3ur
         TWyeMumQTNcLfSw6R1x5BNaYgVvGpbEKlCfws5br0CWPE0ZFexAdVQyjH74U7LstA/HA
         C1WA==
X-Gm-Message-State: AOJu0YwAiTfDvA/D1lCohzVrHLvSsJjlqKSHqrA+qzEJYFnusMTZFI3q
	zvCTf6nDtuixzg8pnr0zwNtezG7ZNHD2iarhye2HDI3AhZAf2ocAxmwDKstq6w==
X-Gm-Gg: ATEYQzwVaUnSMde6WnEwb2QedUbJGYA7+QnT/v2W16cPWA47zeL3MALd0d15Eeg6fZu
	zxY4jGLGYF3yxYnzYsmWBT0wa2TnWdxN4AwaT42cASZXpWdj+Ta9UixuJlsJVBE3898xxLY8hou
	rzCQ/jOUXalEKnJshbKuMjzqfSjBerti0BtMO4V6z54Cfux16DW3WhEwB1ghBG9yBbtQmucKC61
	kACWZoaw5IAhVOZu7+Sc4xHdKiUPKZ6Q4LoeRViiZ/lxU7HlUkx5lmRHWMjwQI8nKOs7iqgp9s/
	6AO6DKd7/nr5rTeLVQa00OunViUZaxqN58xUo1lD9USMhDctYL9vt1/wrKLv3gjRU2CNaXlQXTI
	uRYkusO0VIE4EmZ+zSWi7KYG7k02MSOrTi/uNeV5WFjGqEgJnq7pcOOt9VcTSNTb3sFYqMMzfh9
	ESA9voxiTSsoUzEw0tD6jupE57MUYX7Jy6Do6Ffw==
X-Received: by 2002:a05:7300:ed0b:b0:2ba:6b03:909b with SMTP id 5a478bee46e88-2c0e50206cbmr110005eec.19.1773768334415;
        Tue, 17 Mar 2026 10:25:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.50.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ca0f6sm81187eec.25.2026.03.17.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:25:34 -0700 (PDT)
Message-ID: <69b98e8e.050a0220.32577a.3064@mx.google.com>
Date: Tue, 17 Mar 2026 10:25:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0436811306677786272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix regressions caused by reusing ident
In-Reply-To: <20260317160258.194853-1-luiz.dentz@gmail.com>
References: <20260317160258.194853-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0436811306677786272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068106

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.54 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.06 seconds
CheckAllWarning               PASS      29.69 seconds
CheckSparse                   PASS      28.44 seconds
BuildKernel32                 PASS      25.51 seconds
TestRunnerSetup               PASS      575.15 seconds
TestRunner_l2cap-tester       PASS      28.26 seconds
TestRunner_iso-tester         FAIL      35.32 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      116.16 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         FAIL      18.56 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.70 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.736 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0436811306677786272==--
