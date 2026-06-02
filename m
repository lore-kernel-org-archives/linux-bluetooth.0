Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D03ACA7A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438156; cv=none; b=ERV4MDm8kv17wqqMloIJwEGgh7LL4XmL6gN4WwWaMgE5Y5SMn/RNy6LPGjChJxZKZhLJ2x6MxZacyadeo+LP/BZEhJnbngUDmtdKhyTKp7y4bDM5RJKOazLUdksaehY/duoXkTSo5PYGO9oiWsH67FMQTyztIerFB+pkKiEW3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438156; c=relaxed/simple;
	bh=yYa3oD0kqlWvoTpY5X73L4wrlmXLu+yGlq4W8B7qdCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GiqC5f0AZa6g4UgEUclISGWof3j2XarnM3Q3nrg5nLJlgAnsxFK4iEDnCFsHGB9Z89dlhPSEu0trt5u41P2pGW+Ux5Q56lC2SQWMOoinRzzwr/xkpv1L2aPbXjNn/VYnKE+G1G7mXad4uBIPrmm9mb73utQty9R0J6gbI2yYUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQIE22Jr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQIE22Jr"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91550c6ea8eso444943285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780438154; x=1781042954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg1rtdNOFcQ0b0hlkswEtA+mFuMLQYuUpvJu6jwZ5nU=;
        b=UQIE22Jrx9MUUdql81vJ+0SjYAQGWBJboeQ898vgaw+csdeeLaASdWwm3Y9pLe2MZ5
         tQoMKaBHPogy82izmSzMJEs2E09Wgztx+rszsE/gfhzykuKa6B+NGf8+XHeXIagn88vK
         d5MJOjR+6jwwxQhzn7Z0uhPIX27y5HgOJ2A+blmKt2qoqXxql2xnVZyYq9VYy1BcyJea
         Yf2yZGrGwmRtt7h2zO3cjA6BSPKMsd3pG1VMehWfyXXb7qWXHs70PD45UbgRyXkc+bvB
         YJvdi4l6lPRUlTdtuN1P1GAD9t4SIhmuiYkHnKCvXs1lEfiyi4hwcgLNLlvWMmE5gSTT
         x9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438154; x=1781042954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg1rtdNOFcQ0b0hlkswEtA+mFuMLQYuUpvJu6jwZ5nU=;
        b=ZRtwkos0LlfY4iBD2xPC6bUTmWXzgPifPEYYzLC1wQyPXk7Dwd5bJjkDoQ1ztX8yxs
         5WMEvd8IjRN9sTq6jVn/oPQSFPKAZ5fxuMHLQnTZBbx/9UyKE+mzsyG3RW7ZH29B0L0f
         z6b6MAaQ9YE01/W6xxd5vUQKZBRUXRhiJxn4sGwsY7p2XwylEuG3jWowu0K26t/Jjcy8
         isqyK0UpDjTFytGKz5gcT5APYnFfKwzQdFHcEsakfFEVKOWzBHNhf6cbUtAZVogppBwR
         Mvg8IaWpp2cHlkFUtaVck+aE1HFXwm+OwkUMh5H3721dk5cWqv5OrqMEAVusjcV6Qs7J
         Fp4A==
X-Gm-Message-State: AOJu0YwoK2FLb8Xk7IUmphtzMlPOERXa8frNJY+kLnopCVyhEZMrTJAm
	qgg0NZ1RE/6c3w2aEo3ecjB5P5BmRZYEamu+gsEpZ+Tvx9q0Hdme+fDjn0ZG1w==
X-Gm-Gg: Acq92OF6V5MBYWTlRsZp4Crzwc4gOCymOBZettL8xcxUUy/+ighvcLQJfLhGmtdpvw+
	DGkJudk44NOjgrTOSn3U9MFsR0XN2WXF2jDcDDh8Kk2ntfY8vyVe/FPKPWGs6iJPHTs55JKFcBY
	vs3EaFN6PjkVNug/eF2V8jW+kR51Ig5Py5bASGH9o3/UH+vYNLnZemgr7R4ocOkSf3yJcn3c/ST
	LqYKULSw5vMpSAXfXR7X7yJiUALJ+0LplMoT/6rBLm+nRuiUbYwOqiLjmeHeUrFm2ksBH0QDHqF
	7RXlJ0qPHHd+D0SlWweAfy9LgG7TvJl6fLL7M/IU/E0a60GtFRY/C1+Yr+LJUKTbzcjwJOcFAo4
	HsyIsrvArSGmjJ+o+DaKYe8TfKyhEsIWnBm0u+jJy+5irZfJ+m7N03oApxmQFRVSEUqFvIe079H
	+ws+Ydh6E9gayzehiBQBO5XN6iTqBq2y+sAggCevI=
X-Received: by 2002:a05:620a:3712:b0:915:2ab1:389a with SMTP id af79cd13be357-9158a80c3femr158352485a.44.1780438154559;
        Tue, 02 Jun 2026 15:09:14 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.90.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3b637esm62586185a.32.2026.06.02.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:09:13 -0700 (PDT)
Message-ID: <6a1f5489.7ee704b3.2bf547.c5f6@mx.google.com>
Date: Tue, 02 Jun 2026 15:09:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4163577168605825989=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix backward compatibility with userspace
In-Reply-To: <20260602205659.212834-1-luiz.dentz@gmail.com>
References: <20260602205659.212834-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4163577168605825989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104852

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.61 seconds
CheckAllWarning               PASS      29.95 seconds
CheckSparse                   PASS      28.55 seconds
BuildKernel32                 PASS      26.59 seconds
TestRunnerSetup               PASS      590.34 seconds
TestRunner_mgmt-tester        FAIL      223.41 seconds
TestRunner_mesh-tester        FAIL      27.00 seconds
IncrementalBuild              PASS      26.37 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.253 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.645 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/277

---
Regards,
Linux Bluetooth


--===============4163577168605825989==--
