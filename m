Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6A78F2E
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040653; cv=none; b=FcwPwheYMM0bpQXmuhHCT1sAC5kUcfbWH6S7imOA5MP/vmef7rtJJGSqzJ0ehbnGDicGThSgeDJieGIFCkpJ/rqBy5V5wy8SCWnOZJskfWFYDs/CIOfMZ4nlAo9V18F5LPYEx00cDAiFqwykAysxGC1JGSG4xUgyM7pKVxyMphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040653; c=relaxed/simple;
	bh=2+XwqMlWTREJdvtXwW9PRV4cHFuiosScpluFlHU0Bp4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uxsTfgzEV2j8I7UVwMUs2+JJBOPocCRhds5dGxzHdZZx/NnAOiP/YxUqfg8Hu5FXTi0FAnYd3nua5zSfRx+Jy0ruwqWsAFTlWpMIXnxQFkvG9b6xI7T01BcpwqTomM6C7EMeKcZyWfhW19+zYDxC4NSe69w2C8zXFRNdqYo5tQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9jx95Po; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9jx95Po"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-433101f2032so3988225ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040651; x=1763645451; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fAdLeU2khl9kVjuYwae3Z6OCyLxuB5ctfMhlNsyr8EY=;
        b=D9jx95Po3pl+N2Vddols21au0ThWfOeUgjZa/RqiIVGZvGyU2dTfxpa6zXlDNofw5v
         CFo5Yky3o9kcuYXaQAmT139DHGSrcKDPCT/EvhdnGpbbEbXBImNp9LdWblrfIVGU0HpI
         Pr+DuTkALaIcx/QSbBJlqsqZaQ9wjXIpUl8UBK6XFkbj3Ol/wDZkft6GqvGRJA3MzFHU
         n6qWz84oi0OEiDgs9nOllNa1qKkE6JMCReWP+y/fCxZo1cOeGzDgesN/uNLxiQ3mLwsV
         4aHnxF0VGefdNimBdn3w9hQ3/BUEojfibzpMzwHKhYAb/+lgULJMibAd1YT7qbIRwC73
         ofUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040651; x=1763645451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAdLeU2khl9kVjuYwae3Z6OCyLxuB5ctfMhlNsyr8EY=;
        b=jSc9EkMV06OvEMaCY/Twp18uTvmcJShgo1NE7FRHTeD9QqoqvIkQyEXdLeLtCj7Yz/
         P7imQxXemp9iMG7rC5PPWfInbZ+1GT38XL8IxkskZn8d8GqEEpGW/x3Q1PV5vkwdqel+
         3nrFCeeU686Ei1KrVqMmh/j/jJYvdaAAGvS3zdkzkPzeBBScrepMXxTfgZ46S2tGQntq
         R2xLKDR69ZSs5ph2f7Lv1Q4473uhMNwlr2t4ky5oE24TPq2WsCSaDjcekaGeawN8bGwx
         ONDUoMmvjNqcib58xVLtRU18HaWybP8+rEUm80vcCycCH5eesGKvmc+ymbcDsvnQhaZj
         r6gw==
X-Gm-Message-State: AOJu0YzpGKuidw4fZtX/M679mD9rvdRQ/0sq9AhmR87QmCkGJ7wnwn1O
	2QgvrlNat4Btt0zvqH0kmE7U+ZySwr4PbiqPVqpcH7ly9JL7sr0WyV3f3gM9wA==
X-Gm-Gg: ASbGncvmwo/slW0AQC5qzdnovTitQLUGy/DRLsNfCOioAgNgoa6oXtStw3L+2N9t61r
	glRDtQx+0vHm4+lrGvSQbjjhcCX+hTqAHdxPzny4A83YZ274l6ZbrphS47dCuUJGYbxqF3GHAme
	ZgGSD76wLj54l0mojqpuTI7VcjRpS4AR5tQl9IK3C/8gU5uoj1FWm4CEOtl/0785djvr3toXhBZ
	J6L/GXpIWhKKdkxKO/bih+UnXhtFLhumvz25YrUGlHK6L3SkpuPzmBLKKQTCEzgK/CTdusigT26
	mng0ttSXL4BbLH+gd8GyRroL6V9wR547lTOiYPZQcf1df346YpC1UCOyJcoEH8En9rTo69qMB/A
	LDVkdn/21NDWwrvOffz4TQJBirLmaSZNrdvkRwQtNlD9uob2cWKQNYWQx1cWnqJmmaqs+g/lW9Y
	tfINdLC5MGO9PNSaU2hGg=
X-Google-Smtp-Source: AGHT+IG8qsS1ZaKly0cvp+hgV/l+keeh+CnVF8AwFn8kj5GC8QHXA68z/AHqfqMXqy5TaaMp/EVe8Q==
X-Received: by 2002:a05:6e02:17c7:b0:433:73c8:526a with SMTP id e9e14a558f8ab-43473d929c1mr84093325ab.16.1763040651039;
        Thu, 13 Nov 2025 05:30:51 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4348398f96fsm6472855ab.22.2025.11.13.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:30:50 -0800 (PST)
Message-ID: <6915dd8a.920a0220.26ac61.105f@mx.google.com>
Date: Thu, 13 Nov 2025 05:30:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4505243486023964941=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: monaco-evk: Enable Bluetooth support
In-Reply-To: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
References: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4505243486023964941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022969

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      30.80 seconds
BuildKernel32                 PASS      24.49 seconds
TestRunnerSetup               PASS      490.00 seconds
TestRunner_l2cap-tester       PASS      25.12 seconds
TestRunner_iso-tester         PASS      55.64 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      117.91 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      14.07 seconds
TestRunner_ioctl-tester       PASS      9.67 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      6.39 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.094 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4505243486023964941==--
