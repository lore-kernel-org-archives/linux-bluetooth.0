Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B73A1D07
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549178; cv=none; b=Z4DpJCRgZIu7scwyVKCRaMPaovvGtPXJoAHxsBPkMobPsf5zF0iPUgwocRRNfvWbkW38DeSz05CwT2QcinpEb06MqwnWut2jn2Jesb1XyglY/A6EJUPPl8n555w2K95nQuHNpDOEaW2Ai4bElHAjT7ifn1rRtRhgIGAdeKLcphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549178; c=relaxed/simple;
	bh=FZL9xIBVbvYG1h/Fc0sg7AUMKcPoELRGc5JT5nYqmQM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=umXkTZDUJ90KeMDqhqcj6NPVE+0FpG3EtgsBA3xjLb85RNgm1V7SaTzxsHzmAcYGbILcTVDakDo37jKbVkjK3TVnJw1cfZ48roA2nQJ9Zu9HvL8RLahUNhIttVpEx1FpZtnVEQXBEDVu51OUAQee3Gz8kAy30TsmpMlbUHaz7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsYXPVcI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsYXPVcI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cbb6d5f780so153058685a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774549176; x=1775153976; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FhIJwdoyxQdXp4NDxo+00vf3RgAOdLPZHj0u2YUSH/M=;
        b=rsYXPVcIqTi7do0vhwOs7ArP56dxsq1FT6rv0UUO/emSvPk+p0GmrK4toO4K/Pta5M
         FZlkJ9Ra+lRN6PJE0iSfIP2U0fabftz7RxD2/vFDZv+ufBmbB+QdNcZc6ceVE4f1Fzq5
         /FEXiQa3fn5IHV3H2aSupIGWvpuMXKjItaS/ySpW6tU+GAuYVLyXP6NPm5Hdb+8izu7l
         16jOT6pgsMud5mOiCPsUOUZ5hc9Uv2qkXDZbvmIwHZA7f6Q4PHNsIdcTd7uAOksesQR2
         qEiP/cQcSvN8WdEUfU54vUlBfhLksB49zBvDqtnxMhLqGQw886z7v2FWBHRspxII8imn
         p5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549176; x=1775153976;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhIJwdoyxQdXp4NDxo+00vf3RgAOdLPZHj0u2YUSH/M=;
        b=NIsN7ZJK2U00WXYc49eWYkkRXqsS0xp7NJj/MN+nGYZOfFAyS9cOcYHMDlVk7J37C4
         hKoSdssC1Qih50Ly+EvlXWlh1smv6ot/LqAa6Niqvgs78VcZtm9dFcCQ5wfqbxzzE01F
         Vs34NIunmSTfogzBLuUrA+rQcpZ+F8yTpZQq8RjeL83xOCs4rw/C+lrshWzNMcyKoel4
         WxkvX3AdshasKAl7o+5LPsmX3FgM0+iHCWw++JBmsp58NYLEDwv9v0fqqhue9WEhOkvi
         f1XWHfTk61R6JjyTsKIb2si4Vbn2tsyQC/WtwrY7hysbgZ9qQn6K2x+aceeTaDSeo23r
         PZDg==
X-Gm-Message-State: AOJu0Yw3LQtxLis4k+GAbDwSGNYGDB6UtozN8HDryL/hnRyV4Czxcp1T
	kWRb1J2rjFDMpwXauFWLOwXn/3Jr614lyXLkCv7QQAhRqZoZXLtBP571TzDMEw==
X-Gm-Gg: ATEYQzwhJddGUKHACawK0eUlIBMQeOEff+eoVN0HNY7uL2x+NFO2z3MhhxNtiIKTJ+h
	fgpQPBYJAla+khXrl10C4QqKVeLqKI3FXkf36IhJhwCk+CTcSjYB1phT/GLA92CV0zRjaCN2Cug
	pgp3pRaB2SsHEScNc40G3SmG4BL7Tp5x5Bs7bm+2DTSoFTwBJ10nkHTtLNwMluzWvL8FG2VOQX3
	/pSAOQVmn5mzyC1UY0YxOzhbA2G+mECfzY4hn9Qa9gR6YHDI4iIx/bt4zFwdPpCpTEkMm/BpBaN
	jsNNNvyt5ugMo6kPIHSfnQvfm+ExnymwTBk86rQ/FeK+kuZfqULeqakPF4+O8Ii8ZQZPy9eIRRt
	ci0X/1xsqWvcsqh/xO2RAu/PbAlq1lZCUK0F/t7AwJngvAijtvf4/oIO2AgPMA4Bv7oVNf+t0Pn
	dRQk0xEO3VWz/SJwpdryLthmq4gyC0nYzb
X-Received: by 2002:a05:620a:6cc5:b0:8cd:94a5:2f1f with SMTP id af79cd13be357-8d00101a349mr1100256785a.60.1774549175985;
        Thu, 26 Mar 2026 11:19:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.183.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3bec81sm320484385a.11.2026.03.26.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:19:35 -0700 (PDT)
Message-ID: <69c578b7.050a0220.249a99.aac9@mx.google.com>
Date: Thu, 26 Mar 2026 11:19:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8827051059808924359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: [v6] Bluetooth: hci_event: move wake reason storage into validated event handlers
In-Reply-To: <09ff4368485242cdb6bc707082fccc4d.security@1.0.0.127.in-addr.arpa>
References: <09ff4368485242cdb6bc707082fccc4d.security@1.0.0.127.in-addr.arpa>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8827051059808924359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073096

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.03 seconds
CheckSparse                   PASS      28.30 seconds
BuildKernel32                 PASS      25.86 seconds
TestRunnerSetup               PASS      574.77 seconds
TestRunner_l2cap-tester       FAIL      28.57 seconds
TestRunner_iso-tester         FAIL      37.24 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      115.63 seconds
TestRunner_rfcomm-tester      PASS      9.69 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.117 seconds
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
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    2.635 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8827051059808924359==--
