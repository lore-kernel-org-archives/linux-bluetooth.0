Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E250224B07
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854126; cv=none; b=UDJ/cfj4ZQ/koyITfotl1l4iID5/iRr0PJFeo6oxqxH17VfWOsxk408pSF9y+/UjORuQ6u3mmPv4QDTeVRPfidXjDqeCar3h7C0u7FTW2x6uM5s3GlJok146EvkpiBQzt42HJRdrHder1JF1+WoyzggjXkc+xYOHI/F8NQcGkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854126; c=relaxed/simple;
	bh=0DciJu1qLyzF9mCEG20fJDfddSSIw99ImLEzIL2oBlg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D7A+mGiqpEkiuM7xUmj9dWfZZFI2IIfjqm//k3FdjVRb6XG8cUwhCWFB2Z0C6U80T/bdpGSkL4qMgFypmlUaTSO1PCmsbIGOnGX3BI56BsUacOBUnoANvdow6XVMbRccI4A10WeBNrUAPzEbTlp18Ca3rdB41sn6YDs7dMN2EkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdOhcXCK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdOhcXCK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2156e078563so78873395ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854124; x=1737458924; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k6UGzcpIoPGO44OjupvIBrPeuWg0fz11tEaUcbFqiN0=;
        b=gdOhcXCKRtPHdXzY6uECMFULFjLUleT2oA994PckDfP6ScwlLJ+vy+TaoPA8YoEuPB
         w4qbOBCdBADFYXq48g3cyav0H2+NB+/QejDgO0WxRLZ4+K7VKbR7lCNdPqUL58XZcfvi
         J5BnA2fM1YPxJcX1oXqjWUd2LtzLpPnagineJQkoWZTlruv9X+1uj+Ar4voJlwZrPrvo
         JT70JEQzRkUtmFQ8lX2wtptPDu8Sj9Bdq474+pXa0YYxhvtjcKsFB4aQhTKuTf0Wvuau
         P9ZQtEbCpYOgsOMx6a8qChuus7kE7QqaeB76vd5B93mqji/6do8f5ml0CR90C7N6CMpV
         gVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854124; x=1737458924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6UGzcpIoPGO44OjupvIBrPeuWg0fz11tEaUcbFqiN0=;
        b=slwIs7T30SZlc1pjAcdXpivOX2Npn8YtYYEjlfrJVKxAI4c5uC5Pqq99QHMbx2xTdC
         eY9IdMMVmavC998aa94hctmEMe6Sauk+Oc9UZKLLUMH9VH01SORf8H2nWlIiAQmGDeG/
         vTzLRagNihD/8j2n4zoirVcNfo8Ha9v390ljjC4XCf05h4l2Ys3JO4CPBeDRZpsSBXg7
         T6YpcPZppxQ4+SK9Cht17gnUaRZs/7oRtVdjSytL2TJBDGVRZFhtX68apgXqGDPh4l+0
         3vQnRqHOs/8QW3BljzcJVpfWTbqfz8F5Rz8VwfV9OmTZO/U8pJisMzZsJSU3mi1NPe2Z
         AR4g==
X-Gm-Message-State: AOJu0Yyd4531UxMjp5I9FZqQ+19+4bqFOs6zKYTBIVMVQmLM6zlRvWK8
	I6MtW6YubkioPvtjO6hW5LFCHzjNxoBK+eGVOGRg0fbaoYAcaIaajJd2mA==
X-Gm-Gg: ASbGnct992E4hAyqhenczBQbfm6rAaT2KezSWWi1fifDjZj0EbIaUDn7slkL1XM2Xt8
	W/+isq7oSzsVA6XK/0DNzM46iXTmobzBQqV1ZBbHl9nJfr133t6eQkfqK388RLHyU+XDb5VERRN
	9OLF1M5zafi3AWY1/5G3ZAqHYS2Zs2LKlw/dtE4cN7EEJx7flYNNvRnD+A3p7lo4ArvsAFqrp8X
	wZrXioIfjHsqXu1sYYKyxbs3/tqmEOSWpQsGTXQAPX7UGVVKDLm87Gp03c/kQ==
X-Google-Smtp-Source: AGHT+IGtCEFjrNCHNvjL+SflMauJhv3YFFCJhd0qmcd10YlG9YZqk+EFaOUCjvYWmlmd7/Oq6kkY1A==
X-Received: by 2002:a05:6a20:6a0c:b0:1e0:d123:7166 with SMTP id adf61e73a8af0-1e88d0ee97bmr42834154637.14.1736854124332;
        Tue, 14 Jan 2025 03:28:44 -0800 (PST)
Received: from [172.17.0.2] ([20.169.0.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658efdsm7560933b3a.90.2025.01.14.03.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:28:43 -0800 (PST)
Message-ID: <67864a6b.050a0220.48d12.42d4@mx.google.com>
Date: Tue, 14 Jan 2025 03:28:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2264247877891859462=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: Bluetooth: Use str_enable_disable-like helpers
In-Reply-To: <20250114105641.273451-1-krzysztof.kozlowski@linaro.org>
References: <20250114105641.273451-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2264247877891859462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925224

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.48 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      30.35 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      428.08 seconds
TestRunner_l2cap-tester       PASS      20.48 seconds
TestRunner_iso-tester         PASS      28.03 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      119.39 seconds
TestRunner_rfcomm-tester      PASS      7.69 seconds
TestRunner_sco-tester         PASS      9.43 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.157 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.143 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.152 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.143 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2264247877891859462==--
