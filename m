Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D8146588
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311928; cv=none; b=malUaqRCb5xNS3Hv96zAQioG5dJHYUKQ5Xn/feQrvsY3ZUupMsPMYpoUAyqJYwPUZFPQdWG/3VtG52WBUxAGvhgJnd56E6gvCiqjbd7ecvdQYccEChsmK8JQTpznZvzN6ubv/pZw9fTr2gg3C1wv6nibpsRy7C6p8Rpho4NYKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311928; c=relaxed/simple;
	bh=nJxfQR/K3JmylR5Y9MTwmO//1ySRPhWZvdqBgi7BG4I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rjyAz7LIaR7fVOw+2yrcmWAftbDEaXLGipqD0LMq1s0sA2CnaUOSP/8sLUTFxgO4lpZKHENnrTetTa1KU10BeclUMCu0ufJ9RA54AvvjhYXuX6nvHWaCL4phojNurvvtr7qrhQWY/4I86I4I1l5THLvrD1IeWggDIeqSX5PTFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Y6t9qe; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Y6t9qe"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so2742472fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311926; x=1751916726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovm5aX21Y/1cseYJddlXtW2QuzdtQ9R6EDWaBwjhZRQ=;
        b=a5Y6t9qeP3sbyfbZcYTDflygorl0XTCzwe0GfenyG2jtWmP/7zL0H9MHQqXLYYRjD3
         RD/LWWARN5By6EXeS8bYLeiEkgHk08QGtSLL+2LWyaFbMNmSGs+9xnT/Q2OqwXvbMdpu
         Xl7VOB+BmHW5XD5U9akO1YcXbX7VO1ZyBfvkHwlr/SDJ9FNa2U/PZyziRqGGM5MUP93c
         q56M2IzbVmLPn2s+sSIk9cCsXzC5eojcEsSE+Cft9g6MfoQz+2x9P/KxvTsZxaoOMYh/
         6xBL+7GUjuMoFxqKT5hAyDgV4qecNvQhY/M3OEEUGznKZHr+aiOs7ZAOboLogu81gajM
         t9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311926; x=1751916726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovm5aX21Y/1cseYJddlXtW2QuzdtQ9R6EDWaBwjhZRQ=;
        b=ddMSGbnljeemvBGphdGeyIvLpN9ZAW7kua/NOWMDG0ih9Useoj1qVmx6uT9WaHbuYL
         sJvl3yVwkMChpQmghoVgsA2zWOwQsLX0JqtROu7vNOgVno5sV2mIP/EovCHDZVwanjDH
         8WEwtJOJ0u9Bnnt5dUx4cplhXFMK8bdPejql8fn10g3bJ28lURIdrfGlgYQIfKFVZT+w
         JcfpfpJKLetFLCWMUbfYNpl9dp30Z1zPybDRTcxUs4Tp0aw7h4cr3USkUR27ExRwnEvd
         /7S1BS4cixIuQu9iVVo51aK+z0ulUrc7KrDrGUD4h2E69GFc2x1KENBtZ7lSJguGMxrf
         9Scw==
X-Gm-Message-State: AOJu0YwQ5karKzoaOdn8YQz28usEUzFh3d62Fxh+ydmudlGCNixd7Bxu
	h9xfkRP3Bk6e3yrCGXBr2Q8So1Ifg3aVPbM2gcLK1S2wAWh6VDWJtdzKLwaEsQ==
X-Gm-Gg: ASbGncu6yrp5Gtxuq25TiiJ5djcyETj/6iB4OJ0EtNRTk8WqAI4icTKzGJRtye2eGTy
	1U7O7raO0Pfc2TSoj1jmX89E5FOlkAUqCqcRdcGLWQ6ovl/L3NhD7S1tXRR+6DbW9EdLDfI/XAs
	jyIzpB7ON4EgznBmOc/25sOivAh9O9wnOI8Q/h/h6Tmtm27ay4/eYe/zL25kkfQ59SRCV8ArYre
	CUv0w97+G9f0GeID7F+Hhm91a510CJBnWCHTZxVS9uI6yDAh6uXz/bBU2LC8hV6MboIj044RPTY
	NM8JhylzRCs3D/yQorrXR+KBR1Wj6wB9F3nOdpMhQZWUcFyVs/v6SN9i5k4J4VgXDQ==
X-Google-Smtp-Source: AGHT+IGF+S5U+tozk0AQueq2eEwRIzIz6myIjoUOI3lPifGjeW/98gt610X15UoDxZwPNdDMLt7Iig==
X-Received: by 2002:a05:6870:a99c:b0:2cf:bc73:7bb2 with SMTP id 586e51a60fabf-2efed4bca6bmr11869454fac.14.1751311925640;
        Mon, 30 Jun 2025 12:32:05 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b1bd3sm2819364fac.28.2025.06.30.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:32:05 -0700 (PDT)
Message-ID: <6862e635.050a0220.2f0605.ee20@mx.google.com>
Date: Mon, 30 Jun 2025 12:32:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6355665904304005806=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: SMP: If a unallowed command is received consider it a failure
In-Reply-To: <20250630185724.979029-1-luiz.dentz@gmail.com>
References: <20250630185724.979029-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6355665904304005806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977451

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   PASS      29.83 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      470.45 seconds
TestRunner_l2cap-tester       PASS      25.16 seconds
TestRunner_iso-tester         PASS      43.84 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      133.55 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.76 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.37 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.162 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6355665904304005806==--
