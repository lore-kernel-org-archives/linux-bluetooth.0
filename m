Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95D3101BC
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784497461; cv=none; b=J0LXWlvKRqeUTY/Y3//nzJx392gj1S2b2VEe+0xhMYJJ30g8AE9shZLQ20E1l5mCG56EvjHGS9aisLFhvHwi7IHfo1iDtb10lK5Ia6gdy6VM+wYgPkf0K9bFWZFSaM0pF/s8r00HHb0n1Aa2ZfzNYe8x35/IB/bY3U5XFZqXYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784497461; c=relaxed/simple;
	bh=1In7xWw1w0NG6Gt2hH0Y2n2vhBgAr/3Uhwy5/YZtMoE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P7wj20JRWOmCJWUQSiv5yjb4QHjY5hT6NZJPus4sCgCute96B1VHPHcN1lAIFZiok9iDajV7h82c8J2OB2E98bEDvp9gyOZ0WLoSYyQ8Q9JKnaLt1XDPyb6rWGGxvXO/iQweBX8aPaYeP/hnSMj2mtkhj1ooxKS4OBQ5uHkx1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDrNob8o; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDrNob8o"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f032b47e3cso79189736d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784497459; x=1785102259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AlFARylm6Ygt8Dier7XQpF+umf+OZc03VtaQcgD6BsY=;
        b=eDrNob8omjdEMRHR/PVW0cxpby0oIinx20ku2R25aARwASWiCXMoyygvuAVRfvcD1x
         KEYGSYQfk8u9+GjqkikbttFBd9maIhRD9iWfmAfDJPlaNOE592GIe+rC0OogA/H3Paeg
         uL1mt6ZphiwPYwOn7LIjcCh0+BONNLdHpCg14MA2iZDX0J4vqtzjSZwgv16ImorbnZef
         bTAlwMcFL1V623sGZkT97+aXtGYUyR4LtyrERgB9SfbCVHoe+tvDMpKVVOzMmlQO2eyr
         GuSc1tP5b7jhcxKPOl7xK8hgGqqoCmw1qtUa5kdbtZ3xgI0lqKr7slyCEv9cVuqbHXfG
         KVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784497459; x=1785102259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AlFARylm6Ygt8Dier7XQpF+umf+OZc03VtaQcgD6BsY=;
        b=Hg1GzfzelpOxOe4BZalPoG51ybGJE+uIEGlr7xKlBaY+TlQxY6ua/a6PDcIcb8baZc
         yB4kmeMyi4r/MSSwfq35lAtIIb6laOOr3IZszOvVegHQzEfwXORr9eiXSCCDK/M6/4XO
         V7/bD/dVpQT+h9f89B3SpPitzWzarRv5qQGK/ZqTNmzqf+/HUpehljiU7QfpqzC2SfdJ
         txdC1kM68hU+HbJalVvcr6Ecb+h8Epe+zvodRSltWbnIuiz7AcI7tPMqF3sMfz+yMQaS
         rMCEUXopPUedWejh5OawoSbBFREnEwQXchL6RDStcEfPX9lnGE0AMsWlRSwGUKmSHJbz
         Ve0A==
X-Gm-Message-State: AOJu0Yx/2yvRNPaHAvvOqXlQwyGPi24QMKVGhCGIH7CjmGf4+ZHP+Lw/
	a/TEFT4mRtFuG+BI34cfqKrY94v0giObgLMH9R36JVtWsyP6n+V0GgcC1Pncdg==
X-Gm-Gg: AfdE7cntHMUvFJFPV/5HgDWpgFmbspOnHb9h5WaEWsQHQEJdYCoZkpX+FkwY800hXNl
	CzK8uE8lIxKBqOurOwueqBYFubf6JAoDToqr6mrCinoPh343wClbng5rAPxXem++evG9cIu8xpo
	9HQMF/YYapSksS2PL9nasfQYBxtFviGB/0A2Q8v0oAanIwqr0tDE+ZEXUJznzwHfZfO2EAleLSj
	Nvb6OfM+Ye6NlMtSbPbGHWBzeoFicyRRo3N3kmwBDuFfKu2SmGQJPYy+lGWmqwZ6gsOST4JhRK8
	Iq3nKDkDypmk6FxP6C+LjFWUsvIf8++8qx6aQHCvBNZq+LQ0dn1T03H+OKHhhG7OhavuZDo+p+h
	jQYo2DUJBArQoVc7Obub7kH5e6NuhvyJKMYvYa+mhTi0blr+wAAyul1ySn7Myd5O/4AHt9Oi8J7
	WLGwGW3L6KicW7nB9PKD0=
X-Received: by 2002:a05:6214:234b:b0:8ef:8e79:bb51 with SMTP id 6a1803df08f44-9077850c4dcmr126949976d6.40.1784497458728;
        Sun, 19 Jul 2026 14:44:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b29a8sm76617326d6.31.2026.07.19.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:44:18 -0700 (PDT)
Message-ID: <6a5d4532.af524659.325db9.aec0@mx.google.com>
Date: Sun, 19 Jul 2026 14:44:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5491670212001782779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_core: Explicitly kfree_skb() HCI_DRV_PKT and HCI_DIAG_PKT frames
In-Reply-To: <20260719-fix_hci_rx_work-v1-1-2d7fdeed3640@oss.qualcomm.com>
References: <20260719-fix_hci_rx_work-v1-1-2d7fdeed3640@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5491670212001782779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130396

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.67 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      26.96 seconds
BuildKernel32                 PASS      25.04 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.11 seconds
TestRunner_l2cap-tester       PASS      58.81 seconds
TestRunner_iso-tester         PASS      75.66 seconds
TestRunner_bnep-tester        PASS      19.03 seconds
TestRunner_mgmt-tester        FAIL      213.55 seconds
TestRunner_rfcomm-tester      PASS      25.37 seconds
TestRunner_sco-tester         PASS      31.16 seconds
TestRunner_ioctl-tester       PASS      26.05 seconds
TestRunner_mesh-tester        FAIL      26.01 seconds
TestRunner_smp-tester         PASS      23.09 seconds
TestRunner_userchan-tester    PASS      24.20 seconds
TestRunner_6lowpan-tester     PASS      22.46 seconds
IncrementalBuild              PASS      24.52 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.600 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/458

---
Regards,
Linux Bluetooth


--===============5491670212001782779==--
