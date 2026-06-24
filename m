Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A52ECD1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292459; cv=none; b=rL/P35SMQqpx8+QIbXkPpbL2FlQlX7HEzFZUvlKzrtJWGdNWh7JSt40JoRw9i/9a5IgNQLyXlR+GZpmI7pJ2D0+ETqlpiUU9ROHRHWToJvc62VUsYr5WcOy2F/6HzH+9IKn0ygpzH1WalamhtSSUDEhsxCP2n+t2Hg4VrLcGXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292459; c=relaxed/simple;
	bh=8F0RHzWekvpErjQXJF6E1KzU7Qkm4iz0NDl95jlL/ok=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gqz5rSkT2UPpb+I3taOH+2u9b/7s1jKAztWKnDyl5OY2A7UQJnaCOnXwu62uVUogtW2ZvqBPYhfVxgfOhYQzFA6Y3j7iVl8lJblGWJ//0mVcx9EyrfBIGkZyHFD7BS2rMFHI1aL4JsLVMqQu77qjf0Cu5tTStIFj2kp9aOaydIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siJQgYLW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siJQgYLW"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dea42b547eso12587626d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782292457; x=1782897257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=prd9gJzknuR3fhzzVm62CSBeYfFM+N1EUJmqhXUsSp8=;
        b=siJQgYLWbUmHxiPcxGOE0Hj2L+vlePpdPaI7gbyZHpOYkeAhcyFZ4Livy5RXr8/RCm
         KhkFQUzEt0oQLOtpjMTr5Pq4vDbBAcRtyUiHhdrNUYNwk7N8AfyXTY/3gIqgQwL2q6yS
         wjUtoLMsIoUQQVBqRokhaRRHqKbc8k3wWuxDz++mysay2W/JjRqo0ICEJTtcTxnlvZvu
         xyhFk+zJVsNbILODf46hWC4p3WNf3rM4798mAJ5fYvhgN7Q6LJ7+siM8OHS3ym10YtMC
         DiJeydpimUlfuSQCd08lyy6IeLm1oJonOQfiLGzAwbV0Zd2lbeL6Ez9Dyn6tmpFPzUTV
         q0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292457; x=1782897257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prd9gJzknuR3fhzzVm62CSBeYfFM+N1EUJmqhXUsSp8=;
        b=En9YF8F70chE88QNR4cxN/g/Mz0kTpa7xW/wp3nZeMjLZTdMcK9KbPDPJJHXRItTHP
         Ey6UQfgtkKIA2JqzfEEkiRUg0B2qa9wy3q1it3A3DLbsQLcFvgm+5ZDjio4ETA5Rs8Mr
         XvTv5TE0hLNugs2FJwp0WrQ8Ihfs58Fa6q0qYu0UkXNS8zDx3R88vCMg8XJrLo7Rr6AW
         B3R/2pHX2oOH2UXoCjnrx2dVMZRFansBeZVjLGqk3NN0Zr2PXJ91E+/PTlh9Xx35l1sq
         8UGOq/6zkEA9TD3EGG9wWQszaaW+mU1k43XmxMg+nEZQdGjHEvc/1HOZlzAlN9oR6HRY
         8qAA==
X-Gm-Message-State: AOJu0YxibJ+U76PvPXWbyUO/y4foM3U0e+NsfGVYJHSA8QtU9MuHFZIK
	mwuolgw5keutWtpfngpB4Rgp6wGrwqHghescRWlp0d8PlH+kWId24k0BaObRcw==
X-Gm-Gg: AfdE7clUVZiAxLiKz7Jf/bnMFc4mfoMRoDI4k7nlKcW04jZfxQeU5duvTdP20Yi5Lfj
	ZU87w40Q2vP1qgrHoaUWRrG0VsIB6W174LpWoYKTeNJGdzuARqLHEop/95oQlNPmV4udQxVZ8JG
	S/zHoAvx0xQs8p6DU/978JVKn5t+jXx4skCPf8m+9RCt1wSPyXIUP/a//yOpL1V0f/RDak7VzO2
	3td5KBM048DNt4hoyR5vtduif2vyQjcZnLzZmQGDpyZjtDFORlthgx2MaH7fg/4x+R5dHCrbIG2
	XJlNf/Gbq1SBNK13eC8tie9R18/fA/tyMWDDe2S9yO78z08KzffqTOVAGTL53PdHOZaQYRKL7/Q
	JwJjFTiWoBunflwTU3uUsZf4XVEgpoA8i5PZiPBV0/LmUQy+wlgmcBi2WPXaGWEDZ8jc0KP7GQS
	vkzUn4eP/y5GkpsTMBBMdN
X-Received: by 2002:a05:6214:4102:b0:8de:9e32:623 with SMTP id 6a1803df08f44-8e52fda322fmr42222306d6.20.1782292457252;
        Wed, 24 Jun 2026 02:14:17 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.217.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82693b9asm163909966d6.42.2026.06.24.02.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:14:16 -0700 (PDT)
Message-ID: <6a3b9fe8.8e833c70.fd241.1748@mx.google.com>
Date: Wed, 24 Jun 2026 02:14:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1927770582669872383=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260624053334.3151885-1-hildawu@realtek.com>
References: <20260624053334.3151885-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1927770582669872383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115683

---Test result---

Test Summary:
CheckPatch                    PASS      2.58 seconds
VerifyFixes                   PASS      0.24 seconds
VerifySignedoff               PASS      0.25 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      26.77 seconds
CheckAllWarning               PASS      29.75 seconds
CheckSparse                   PASS      28.35 seconds
BuildKernel32                 PASS      26.19 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      574.02 seconds
IncrementalBuild              PASS      25.77 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/343

---
Regards,
Linux Bluetooth


--===============1927770582669872383==--
