Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC34677C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669672; cv=none; b=T03gru7vSR/oYCOW5EdkjphjIGIhIogjZWdSY/MJbDsTZmp5wqqa2XRgvcawYLqfxHBbjDK1jeeIokwTectxgw0Ncd6Gx4UGbuSHR5n7rSKhwD9QrI3n4uLY+sxfhL7pjdxVSyh2HJ1a0KK1klF7XQd54ldNcEeXqFNwA4NJG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669672; c=relaxed/simple;
	bh=CCDGTeQX0tAoUYuHbSWB2PiL7vrfy/LKjYrUN9PFLRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=muptTJ4gHhL8j5qcIRpAYWeF4zZyXqzRbZnTQgTa8DJ8isAyOycg2J/gkG+tMH7i3kWocxfnPcTeK+vAc5iV5qfS5J7pIiSsWp85sJuZ0r6azrkrRZ0kl45JdtYSUe/QDdwSD4WacBt2jjtPdfbhDYZvXazUCU/fBOfOzAxY0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqLguxZe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqLguxZe"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781206cce18so95093b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761669669; x=1762274469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u065oKIc+FLL1YKs6IhW73v4Ho2aLdfSoiHgkiw9zRM=;
        b=EqLguxZehyNUSqjvxvZzk8Jr5XgxbyrbBUG/laS1Q4Zi8tibxGKuUoF2UXl+7lGcqi
         hhu5Ep+DQV5RtLQYtcxCcPV0uj3c3DonoPWMtQKCKUqsG9kBPRz4eoOIYMB18c2nsL9Z
         2lsbPyqHyCt250+GKPgW8NzWXELKNExxz3qPgmkshfsO1e6RAGRubvAhjto2iZDM4hAt
         fVEee0TohIzKM7kZ/Fo+VyTmxtdnaKG/x/7SeEeJWz/8T349XVZ9ZlRD7dsTchQXJdB/
         D50WFs47eKnwWfZKQTuUiaJTwRs15UP8Fof7iCKPfOGj95sW8L4ktsjnsRWZLyssCOhp
         nW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669669; x=1762274469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u065oKIc+FLL1YKs6IhW73v4Ho2aLdfSoiHgkiw9zRM=;
        b=UxnklQ6thSM2fj84mdw5VshrWCt21S7aTbaP1GGykQri5lV3Ktb+gKol0f1ROF9goV
         WUd0aXSluW4Lg2eCJUSR16YIYe7X77BZobofkX+fkZoC1XQY27jJkBQrye7X6cEKLGbT
         +zgjyFVijyrRG90i6hLc8zQif5M6K42Wv41oFWrh/KrRMgfEHC0icDt0TKPUQR+H0UmV
         EzphzpXyO4TOAFjrycidvm56Y9Os/kqBXGeCa28IVVZ8tUiV98ahKZ8hsnD4Lcku2net
         9ArA/bz7wSYMP5Ti6CWK6O/BdYNBCvhjAYAtV+EXfMPSIaQHK66F6Z8aPC5r+imIj2rS
         VUFA==
X-Gm-Message-State: AOJu0YzKhDrD0oSuuLYSWWk3myP3N820K8i1RfFeDITDYCXkoENM0T3D
	VQUVVi/fl7uP2742Y18rf7pVGweId0BDgiIq50w789YA0PATWbR8mJicDa5REg==
X-Gm-Gg: ASbGnctQeL0XnZ7GIYZuZjUcjpKtUhokWabN5waxIRiKhJ6CTc2V93XI2I5I3MG1Si1
	4eogwxUUCQE0IJKOqnAH8ZZ81iB37j+K7VFlmj5QJ6sipxEhzu/0/3eO/SBrLgpTUY7/+5AXeM5
	QFQ0Pwym5ZtSmfG+OKqbe9LwYO2Z3Llhk5SFjtn60pDG7ukhLTfbzASetguLNRJmC9r/4pI8Tp+
	Z2VChoR+bOIKObqnUQWHHE8AMePOvYgUdQVUKm5G3LZE44Q3i60cw3W7Qj4HXjf/pMVK6skh0oz
	dvx5kfi1GPp3509YEp458VqIXM+lUcliNCLKjOCiPDLNcxlWMqv+ahWN0xkhIWET+0x037xQ0w2
	Z320C36mFYQ+sf0Mfr6p1H4GZv+9vGCIGO+vvuMvG/qBTxsc/VGNoN6FmEi4XURiK+koxRhVZHG
	ai3BSUc3M6p4C59sDYQQ==
X-Google-Smtp-Source: AGHT+IFEQXri20V38cURV6XS0ijR+gTEP44gc1Ag39+C9W8XUuh1PwXWiypWKYcpybYh1ereBPssqg==
X-Received: by 2002:a05:6a00:2393:b0:772:2988:31d8 with SMTP id d2e1a72fcca58-7a442e0ff54mr4904664b3a.2.1761669669356;
        Tue, 28 Oct 2025 09:41:09 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm12367675b3a.45.2025.10.28.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:41:08 -0700 (PDT)
Message-ID: <6900f224.050a0220.252b3a.d511@mx.google.com>
Date: Tue, 28 Oct 2025 09:41:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2113049830660476654=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: [v2] Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as Qualcomm hci_qca maintainer
In-Reply-To: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
References: <20251028155320.135347-3-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2113049830660476654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016813

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.34 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      30.48 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      488.96 seconds
TestRunner_l2cap-tester       PASS      23.36 seconds
TestRunner_iso-tester         FAIL      33.06 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        FAIL      111.35 seconds
TestRunner_rfcomm-tester      PASS      8.98 seconds
TestRunner_sco-tester         PASS      14.06 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.23 seconds
TestRunner_userchan-tester    PASS      6.35 seconds
IncrementalBuild              PENDING   1.02 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.143 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.231 seconds
Mesh - Send cancel - 2                               Timed out    2.003 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2113049830660476654==--
