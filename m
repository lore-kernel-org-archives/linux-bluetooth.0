Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B91AB52D
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918251; cv=none; b=Ytnz+ONV1lafLDrXQ63AJTivRFngQTVXpIDzgt7JNSp/MzMC38RNOsaobwDqkeQZtq7VyGsvM1YwD2A+MbyI3xUAYsQrPHGm5vceYpXn8M4YMQMWnE9sX75YU5GFYQ7iJQucqtTNmJ61db2yoVkBm+rmZG6B8qOaknt42V8dka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918251; c=relaxed/simple;
	bh=2Um03InHUyU51ouMSv3wSq5g2Z1vfdYheWINDu8PNFw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aLfsDQr4H3wJfIB28973lxpIe8aPY5kLO5dMks32UA0pvWYuhztzVG6j3KHn1+kwRG/lFnYziyNFrNr/zWjv/KdaYhnfvtE1cR9OoYHNfqUde2XBqQ0OgMiiPOx7eYnY9/Qaug8MaWKhJ6yP68g4D5wJXjPCqATqath/fuVSx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMB4tPRH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMB4tPRH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3dd14a7edso571933785a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751918249; x=1752523049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kpXEObVNaXzp58DKfYpXr46G1rWG09zjJeCgcH1zZtM=;
        b=PMB4tPRHIInMipijzp3HmPm7oVTSEY4SwP1xybTHy4BU/U2+gXoD6eJzlzJM/3uqrB
         U0AS1cpn9ZKOE1R19NwHmK1vL93dNjx86x9Qh8GMsxa578Fq4Bq1BA/5iF20yE0xD66N
         P42WuFTE0F25js7b+23UZEP4DwBgjbecBPYxf0AsxPWN2Y7L+fsVqn5ZhG3kMIO9FNa+
         pItY8Lmdf4ZReBYeM6jAqp7UU8RrZHQwXTY/tomc7rB1mp1Ku+HG8Kg3BouQVc+xzDcf
         SI5SeBzRHCm98agtYbAr+PtjpeBVQ7ZfpfOfzPCGRq/X9LQuu5RSCKfAxb5gZfEgSi0r
         cVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918249; x=1752523049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpXEObVNaXzp58DKfYpXr46G1rWG09zjJeCgcH1zZtM=;
        b=oQ+exr7YQ2F+Hvy9VhCNfhcuTB2FJkftyG79KgoaXe3EyYp51zuqHKvBQMHmUkVCOP
         BUqtc5TOWVGOjtFDvYajxN/K7GLWIFkqED4vnnRdmN4EOQqu9CXTYLrs5PtjNS0INvPi
         OPUOmbGTmDQ08TN4Lxk+mYoWNY8xPUHP9pBS5KnNmMnxxmGEPpTP4/9qTPqfTxrhfngX
         YJe/94yptOk/Lzebcb7VEWkidPDya8HidWq2wuuCTMlWgQKgkasyl2fzjXofN/MiEUHY
         ai3sK0cp+odbxcQ5q+A3U7RCF91SJu4RXzcbpHE2ZF7DbWwGL8918Z5eZzcNcf6mMP5Q
         Pk3w==
X-Gm-Message-State: AOJu0YzAgYsp6WexYKmssdm6KtpDjMm9oWlmZ3R0VgOFgJe+Km8l/aM/
	B4QVybfyKN4A6cVd6Ds6enhogKbX99oMUCjxedr7L3fh4o2lH5dVcM+T5EQ+0g==
X-Gm-Gg: ASbGncuNHf0bpjTCsxrqLsZmWWzp5OgKUK2oLwhOTMcxNp3ysRAIk/QVE1zA1MuX7wM
	2B3A1fz0rDiqUKtCBIWWSXUmYsJ4eo5xhw13I10ib16yGFHmzArorXGW9N8MG5pP27Xh5rThSgi
	rtDlrTNmMngo5rx67ds70ZGzCrh0G4Wy+KjUzn7nWJV7LEIoCr19tV06zIS0otjylmATCjN/fpl
	79ka43K2EmHnbg745Rb5HIlRFgfOJ+vuERpbdyFb+Rv4V50bYwbfZjhBB2uNVHyWP9snysMOcL9
	IaTP1JpHi3IWZtVtVxzR2KHt6VmH+U733yQ5MJysBQLd00PEvkBzdU6pnG0xWtv0tfTT8AsCOeF
	oVsc=
X-Google-Smtp-Source: AGHT+IG/HpZzFwcN6E2EbVRISAbQmzJtlLhycZLZ/2dLy0eyRzYP1t/p3fLw3gaem+9K5GBdWPpsrA==
X-Received: by 2002:a05:620a:440a:b0:7d3:f51e:d775 with SMTP id af79cd13be357-7d5dcc76b24mr1924203285a.24.1751918248656;
        Mon, 07 Jul 2025 12:57:28 -0700 (PDT)
Received: from [172.17.0.2] ([23.96.187.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdb38d9sm661791885a.26.2025.07.07.12.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:57:28 -0700 (PDT)
Message-ID: <686c26a8.050a0220.3b6f8a.8bcf@mx.google.com>
Date: Mon, 07 Jul 2025 12:57:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1974964498736624940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuniyu@google.com
Subject: RE: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
In-Reply-To: <20250707192832.3162227-1-kuniyu@google.com>
References: <20250707192832.3162227-1-kuniyu@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1974964498736624940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979801

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.94 seconds
CheckAllWarning               PASS      26.39 seconds
CheckSparse                   PASS      29.65 seconds
BuildKernel32                 PASS      23.90 seconds
TestRunnerSetup               PASS      465.98 seconds
TestRunner_l2cap-tester       PASS      25.07 seconds
TestRunner_iso-tester         PASS      35.76 seconds
TestRunner_bnep-tester        PASS      5.84 seconds
TestRunner_mgmt-tester        FAIL      133.92 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      14.65 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.34 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.48 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.221 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.203 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.180 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1974964498736624940==--
