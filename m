Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD92D0C89
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192628; cv=none; b=NL/Bng5afKwTLgxBwEn+0sRF6lbVqkLPlXKLfFX261SHI4FAjTd0nJzqWnN/qTBBx52SwuoJ5pOHeXnG0m/wg0bfRhm1ZXRoeBh2X/Fa7MdKd8LLGVbnZC+XgvRSL/8f5yTdHNRK1Q/wYH38yc+XU3llD70DebJjeeHmxmVFrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192628; c=relaxed/simple;
	bh=FqYIvdsGn2XiZGrRNbd7QqSEFy14U2M8mcTx2I5/HPg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JIIyBekDtXte5suQAJ4f6hqTyzT2sDPwypkpyHJ6UlFY2oepR4VAUE6JjZa0X0qaqwurx0cPWIfJ0YZsjlMmL8foPRCFgPFjfYznWQhI60ST4xSD/BJCENSyBn+UqwVK3KQnkZt9Z0eS5nsw02NENZGXpAUsH34SwBX9X2Shs1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb8ZlB99; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb8ZlB99"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso561716d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192626; x=1781797426; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4yeuxkmr6C6kVUqbQG2Tdq1BxG451DK4YPSrt2VU1uE=;
        b=Pb8ZlB99ANu5os1oXyw+Ai0TiP8foKTDGi5BneAGw3VqknbzvdrFooNsdNuUqd36yw
         LQcdT/3su0pfRa/4kOllmkizzCPs3f/SsUoGU0+IWqx/qNBX1V5B6LwDLYQu/eiHlAix
         14zxolhray83QYmqtNrMvIiV/qPHwOtfTXdFjL0L8xHSDdZaDNz95NaUL2EUS+ERMskN
         4loiHgbe0td6tsdeQRbQJDwzTi9dE9dEJDpFj+GpO2AUTMRMYpCDCtGffsjGmWLSQMyO
         8qCrkgsqshc3DeQ8gl8uFgmLNiyW6E7n6zv1Z2WIG43UsAeBdFM02LJjnWKuXZFiwNtd
         qvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192626; x=1781797426;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yeuxkmr6C6kVUqbQG2Tdq1BxG451DK4YPSrt2VU1uE=;
        b=eMpmcIy+/Qa5gZbeLRCi2i7v/mE4aBjB8KyMfsBZEAiPmHchxiQ0tuf2P5+ol6S/d9
         +g2NYrcNkc4wtyu0G5+D2hAr/X5xEKDuPawwUxcscBPdzqMLqgg3vkfcki6MKRdno6eT
         kODWFSJEqUKz9vWyrJADwdUBlI+sstV1aKs67jn7cy+QOPvQz5VXIE48feaPZ3t5eWdM
         YE5coOsKh3XrIpFsSV33KVxzEBL8/VoDxnq662I3sws9/n23pFjyt3untd3cmXbEcUPm
         yAQ206JYYCWDHU2Iqv7nOSHzB6yU4Wmrn0TfPZj9csjIpM+fbOsJpSmN/xhcQuurvct4
         XlvQ==
X-Gm-Message-State: AOJu0YwS1z88xrFl1+e71kzd+LNoxFfkxvWmM+tuTPvw7RUpWMQdOLi6
	0r2ar5bcIWJbEeYmZiOGerOfi7lL/4nGibySP/rU+6XBudQqNR5bLMbnplWiEA==
X-Gm-Gg: Acq92OEVXw2I7UmcK4stZik/YFSvLk4Td0v6R0RHU24YNqc06QVeHnQIL3fbX0VTPpD
	nz23H+q8F9EeuzpAh7xmhEVkhf+4sDqx9kbkwECQYcPIsd+EIhFqzNuOWvFbxlESzfsWPcxtM4s
	TQrn6+NTMU25fZ7xh1ApdG2s7LXxpHcNp9SF7fKyB8/CjQf665AQoDKBWA0cKDWNbyEPtrSolKF
	dKwfG6djq5iSWu+GszSjrtRly4yY06T6TjJEApxx44rrPWATa77wsUkeOoPP9gOvsSZECaYybjt
	K7fKFyLVm8EjwX5P89DO4KeJnEnXdXD8l/8VbHFDv5X+WJCPHWwJV0YkQ96CbhV3dD85PpD6aF4
	xjR9bnHJSGCLGD+QQXQdmrSmIaLm3QOH7+8ejeUBFsUi3ax/exSomwUhxYQndM8JASJPvp8VM1M
	6bibODN69MArfkS9pF1Frr0HNj0xKJCfcXjTwOczwklg==
X-Received: by 2002:a05:6214:e67:b0:8cf:92e:f9f6 with SMTP id 6a1803df08f44-8d1db5eccfemr52271416d6.25.1781192625936;
        Thu, 11 Jun 2026 08:43:45 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e7bc34dbsm21015006d6.3.2026.06.11.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:43:45 -0700 (PDT)
Message-ID: <6a2ad7b1.65a8c23a.9c85.a965@mx.google.com>
Date: Thu, 11 Jun 2026 08:43:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6509615320761486272=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
In-Reply-To: <20260611150628.2164737-1-oss@fourdim.xyz>
References: <20260611150628.2164737-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6509615320761486272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110130

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.41 seconds
CheckAllWarning               PASS      28.07 seconds
CheckSparse                   PASS      26.83 seconds
BuildKernel32                 PASS      25.17 seconds
TestRunnerSetup               PASS      524.61 seconds
TestRunner_l2cap-tester       PASS      59.42 seconds
TestRunner_iso-tester         PASS      85.93 seconds
TestRunner_bnep-tester        PASS      19.21 seconds
TestRunner_mgmt-tester        FAIL      212.48 seconds
TestRunner_rfcomm-tester      PASS      25.50 seconds
TestRunner_sco-tester         PASS      32.14 seconds
TestRunner_ioctl-tester       PASS      25.91 seconds
TestRunner_mesh-tester        FAIL      25.97 seconds
TestRunner_smp-tester         PASS      23.16 seconds
TestRunner_userchan-tester    PASS      20.34 seconds
TestRunner_6lowpan-tester     PASS      22.86 seconds
IncrementalBuild              PASS      24.46 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.241 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.387 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/303

---
Regards,
Linux Bluetooth


--===============6509615320761486272==--
