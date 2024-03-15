Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635BDDDF
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491748; cv=none; b=pc5iA6YuioaHjw4um6chDgpLzwfSjd7H8l6MdrFPJxsQBCJF91WMrabRK3OAfp47msm1GcLLU3Kck7LIJl4IvEUkzuoYrYdaqi+vD+6+/wrdKSMkVMy5XiVvG/4YTs87qgpsEzPQKv7aSoftNCyp7ZIS1ncAKawXGwaPKS/gFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491748; c=relaxed/simple;
	bh=M7yZgMdOh/xvzU1SrWJJP33ibCzgRC9vfyVtLIBph48=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z53+8SZc30g+Xv6xAtqsOAPjjfdS1bKOF9dClVcy1EDe4rGNe4w3Ym63/NRBP8y1TyG+Ve6T11aO0rdxj1LWSBxvjB5jlFkzbmKY+7b2Su79zNJH/gaSyEeNpZMtuyVFpd1o/RDsQHIAUuP6FlJiT3L77WA0g+v3ixefWnZ9UI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E68NMuOc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E68NMuOc"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b5831bc8so1840652b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710491746; x=1711096546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjcCmvBF3nkH698rdXSQJS1Vb7kfzc57uemEk970e5k=;
        b=E68NMuOc3z0HAENp8vz4QulQ8qo2C1Grcsef7EAPfnkQ1m7oxAIO6e+4PTLa/e5zd4
         3Rfu0rctg98Jq43qkv15JkZsaLJ5UXiT8WNXUh46F/Ha5JVdxbYvIWMyEUMjcMgsLXAt
         AEYIbE420AM3Xtn57rH6CWyNwk8bDdmtPiRxAOGk6FQWTkQIDWIV2oPOL0svOCzT5rvf
         nujhRIixez+b640mbW5V5ukZ4sfUcpK9UFYHMSI7ABUAs+J6i+0FCqB0S9etfZeVC3wi
         9SbWB2i4bW/WpHAtreas0QOHB7T+oxnRqXLS+2dC6h7fG+h/6YXwX+azO+Kpx8KMbuby
         184g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710491746; x=1711096546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjcCmvBF3nkH698rdXSQJS1Vb7kfzc57uemEk970e5k=;
        b=jPFlkzst1pY9vKBoq9MUx/yUo9xs0JxF6Jf+sxbuwWD9x3NZfh39TNZnxYvnAFKRMo
         sKwrhrEy3/e+3LMceLTK7EQXoL0izFZ+EZFoPKMScdi/H9E9gGtneUdS2R6mhgA9X5LV
         lx7aXUL8wRIk2vlZrotkCCfXM+qVE8Ikb4cilczS/bLqlV1h/0SC2D2GdtYEvv6fYL9R
         OSvg68GXnWJ2iVdermRsh4clEKIGRyEhU1TYJcdd7Wd+tb1dYpmRg+Wr43AppJwo25hw
         TFPXWBqqsYNy4qMsI73veug8zxGpktZQs8CK9zYNckdx9xXZal7D+bIHfVGPwKrhfuCn
         WNOw==
X-Gm-Message-State: AOJu0Yx7uajo1Y6KrvkdsO4I23rWE5wkDsp+hDpIATMiB2cEABfIwlrG
	TXfj75dPlcJmqwqienjplMyVeBMFXvwMwncR0azL34adqEqx9bpQR4BViSfa
X-Google-Smtp-Source: AGHT+IF7vsPLAAW+GvRWw+Wc94djoOeq1dpOSfgISe0uIpZ04BTmAholXhN1t+csZzrgp6fK6pUZEA==
X-Received: by 2002:a05:6a20:1204:b0:1a1:4a97:c2bf with SMTP id v4-20020a056a20120400b001a14a97c2bfmr3477453pzf.38.1710491746244;
        Fri, 15 Mar 2024 01:35:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.193])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001dde0e74e5fsm3164956pls.63.2024.03.15.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:35:46 -0700 (PDT)
Message-ID: <65f40862.170a0220.3f55a.9e7b@mx.google.com>
Date: Fri, 15 Mar 2024 01:35:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7700688456495948118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ianwmorrison@live.com
Subject: RE: [V2] Bluetooth: Add support for MediaTek MT7922 device
In-Reply-To: <SYYP282MB119734BDF1275B7453AE84C7AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
References: <SYYP282MB119734BDF1275B7453AE84C7AB282@SYYP282MB1197.AUSP282.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7700688456495948118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835522

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      28.29 seconds
CheckAllWarning               PASS      31.31 seconds
CheckSparse                   PASS      36.87 seconds
CheckSmatch                   PASS      100.01 seconds
BuildKernel32                 PASS      27.65 seconds
TestRunnerSetup               PASS      520.97 seconds
TestRunner_l2cap-tester       PASS      18.14 seconds
TestRunner_iso-tester         FAIL      35.16 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      112.61 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.79 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      25.59 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.192 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.195 seconds


---
Regards,
Linux Bluetooth


--===============7700688456495948118==--
