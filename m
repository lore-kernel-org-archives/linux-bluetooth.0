Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F34B04B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076737; cv=none; b=ootb15ANqCAGr9Iz4GRbxsoJmAHTkjfhHr4nD5unRlfz1KAaZHSl05eaWLPmJs8cQW8NoZL758m6aUS29DxPxP2BBFYPBWDKMXJFC3LUkDwjq3i6toSFmMX6SClo+ufB2lMFgC/UxE/CgVvXstdx/F8sYiKSrtqQgmcAgtXCdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076737; c=relaxed/simple;
	bh=VuHmqFUs5Y/uQ9VXlIEu6o0MLdimbxWAMIkKQs9kuSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qvu/qLktPQC54hLE1WqmHzIb4KvrWFch+LSYqdoBkdIvBMawLXlubPf8edOuhlOBiwQ79CHG+WthNvkx7R4aLfi6dLIlAtnzO1HS5b6Fz2QbwWdXJitcOoEhnTx8OY1Vvz4PSWyZAWafagTu/FpPy7vjqg82EuXkg7hl6vEhzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og3s7Kxv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og3s7Kxv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8114a4542b2so43590587b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 21:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076735; x=1786681535; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1ttC2BV7OhwDqvloUohJ4XLYG/fv5R57zEA682ZBvZw=;
        b=Og3s7KxvPfEEXe0z1LD9qj1q2SxyJ5pfAlB4vPzuEOfzPNOHuOgZ6QqVDYK+GZuh05
         C+7AbFqqYJdcBeNz2FQWEVpsDua5zGTBQbBPOr3Olb0W3f+4OwInBs6m0YOncBa2lr4D
         UOoKRJ0MqBvYtRQRnuIchr7S3zrYiiPfqe2weMRH3h5qLYXbhinOkjpLkRxsxhIZJ5+y
         n+KCNOB/Qi4W7UKyy8w2A2Ff8sL//7vaVrm1Vz7rDLPqwlYhESsOjW8rRlSwSwuA8eY4
         uRIdjvLfJUkqSFhJvZiyA0fV7MHXoj61K04UlAZ2dYq25TdkdXzUDBiFUSJcBjQ66ECG
         bpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076735; x=1786681535;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1ttC2BV7OhwDqvloUohJ4XLYG/fv5R57zEA682ZBvZw=;
        b=JIzPeIbFh/RaaVSm+aqlxBO/U0Rg/UGGEb8LYHqJWPfOeggNJxaRqPN8geAvkUAZ1N
         7XN+YhNNqEEt+caKhpz05H3bRYT8g3uIus9fRQfeXL5SGaBsIqFxxzstVEkIffo0Ux8J
         7/1BKlgs7ZtjI8wnGKTWkfzrOc5J3AxuzQ8I91tsw8YWiQ8AiINs34t8EZzXeH+dtF3H
         dLYCCeeULI+5AHZZw3ahka3UsSpT744Gzl+T1N+pkNLIt0KvVy+Ex+0fNbwjdlWZIAVu
         RNvWoRcilZ5MOiWOc2LxYopD3PMEUBIAgnbSR3IYTrvF1pKBIKF1ipiiKKpRBhZ+xAEx
         OvQA==
X-Gm-Message-State: AOJu0YzhJOBg2A5eGn+uh6sbf4E7J5nvNYkbKnNRR1aRXkfM0tWAlCsN
	QYhtjEGr+G+7Lt8z9kQlNzm8BRTGoFBg2EnAWpHH/uC9GnTga0Vl5gmL2TzqWA==
X-Gm-Gg: AR+sD11TxJxOhOjQ078JpR4i6XiX0S56T4GqUPG0QyQk7cJRBeDHUjsocyd0VNSXh2S
	rf+tBrX9Ixqi7PzksxLiUSq9/Z3OI95hSmY6ZqyemtJl3bqk5iPegVwdB6LesxwrXvyYs0gqZZA
	dGhMuldyYeHgEKx4VFjqBNPsN+WcHvLgG6j14XQ5rWX9JloiWE0fB+fAlYuaiCN68SDCfsGnZrY
	jkqbazMz5oHxGgxj/3G1SZ79zeV13VRMVhug51I0b1gwn6y9Zz1INxKXEtZLxyiP4u26lxa7J2b
	kYWXAmGTJ+Y/KrpYXBdm11QieAR0CjpIjsJ4SmFvWQ8suqbh66qpzbnIWKvq5oKzWRGLekkCzqx
	SZl+IzGRehDRTr2mWCYfq+MiFeqwhsUgB0RTLn5Bo5XC8HXcpRUGFw6iZcm9gzCDWXx0zqDNPTH
	IBH4/EIe49VFjW2X9fZ43nWqSD5KDECpxDbp5Di8ds41Rx7hhujiALPiCUQnZT8KeK0cQ=
X-Received: by 2002:a05:690c:64c1:b0:81f:650d:1377 with SMTP id 00721157ae682-8202b0949a7mr121705967b3.35.1786076735076;
        Thu, 06 Aug 2026 21:25:35 -0700 (PDT)
Received: from [172.17.0.2] ([68.211.146.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f6238b91sm3419527b3.34.2026.08.06.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:25:34 -0700 (PDT)
Message-ID: <6a755e3e.4f25dbb9.39b3ac.cd7d@mx.google.com>
Date: Thu, 06 Aug 2026 21:25:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1655735176596779990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: MSFT: validate evt_prefix_len against the response length
In-Reply-To: <20260807012555.97482-1-ali@iusegentoo.com>
References: <20260807012555.97482-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1655735176596779990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141853

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
VerifyFixes                   PASS      0.22 seconds
VerifySignedoff               PASS      0.22 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      29.37 seconds
CheckAllWarning               PASS      30.27 seconds
CheckSparse                   PASS      28.94 seconds
BuildKernel32                 PASS      26.56 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.60 seconds
TestRunner_l2cap-tester       PASS      65.25 seconds
TestRunner_iso-tester         PASS      89.79 seconds
TestRunner_bnep-tester        PASS      19.39 seconds
TestRunner_mgmt-tester        FAIL      221.13 seconds
TestRunner_rfcomm-tester      PASS      25.57 seconds
TestRunner_sco-tester         PASS      32.03 seconds
TestRunner_ioctl-tester       PASS      26.93 seconds
TestRunner_mesh-tester        FAIL      25.99 seconds
TestRunner_smp-tester         PASS      23.62 seconds
TestRunner_userchan-tester    PASS      20.22 seconds
TestRunner_6lowpan-tester     PASS      23.05 seconds
IncrementalBuild              PASS      25.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MSFT: validate evt_prefix_len against the response length

6: B3 Line contains hard tab characters (\t): "	if (skb->len < sizeof(*rp)) {"
7: B3 Line contains hard tab characters (\t): "		bt_dev_err(hdev, "MSFT supported features length mismatch");"
8: B3 Line contains hard tab characters (\t): "		goto failed;"
9: B3 Line contains hard tab characters (\t): "	}"
14: B3 Line contains hard tab characters (\t): "	msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,"
15: B3 Line contains hard tab characters (\t): "				   GFP_KERNEL);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.242 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.403 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/545

---
Regards,
Linux Bluetooth


--===============1655735176596779990==--
