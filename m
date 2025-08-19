Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279F21ABBB
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592814; cv=none; b=DxeTFhsvpQeS9NalWIwGhR0ECjThquYe5VbRun3H1j+V1DEkuCeYGlMy6ipX9pLOmsGTG+d+4qQK5RpcSUnrTTGzzRh482/356b8R9dmz23xA9zKgCoRENh9sbkq6ASBwUDXMaXX+GjIc/myuh4meSyturDiHiC8OyJxchoSQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592814; c=relaxed/simple;
	bh=LS4B8joBgGgwjnwU1CbDnGux6CvokjxKRMFhINgceR4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lk2JlTwFOmS0TJJ5JeFOsQHc1+OY4HN9zwHKgARKfDjRrk3A9G5jXZT9ur711OC+Al0nLklUZJ/Td42SLYtJmQIriZnknEz9MsvR3CdnlqL5UDAOp+9dtj2W/k7DjiILUAj1vo/0QRM0bAs/x3n6nidMDoxb+jLPlvRiaGz796s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgV6PC/P; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgV6PC/P"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b474a38b25cso1368103a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755592811; x=1756197611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1dEnKw4+D2Jk2ob5QjbelT0QPZugZQDkj2edboAhfFo=;
        b=dgV6PC/P6EPh3KTrwvO+6at3L/mK7hS4u4G7+KnLXsI313gGXsc2CYh6LoegVLlvKK
         6L1oGDVqJrRj5oZXpSj3Rp0OpXMQ3MKcRa3/+FWiqzJ+t7vtifSiqohO7afIK2AxEksA
         CCxLDOBmJqC4E1Z/PZvVl7e89pSKnfPt94II0Rn7yuSImdwkcbbzGlJ7UQguJ0J5shN0
         tmKl+9ZBR1y+/lBdD30OtIyQ+v0aL5j5EjkmhNzNAJbxWT4TJ+gbVoturNM8Ail7YM4U
         d+TloHNKRoXSapJD+lhUr1O64Ght8L7uA/1Qm1EtqUZma0GtBLe0f6ZWyUpKedbPePrd
         qWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592811; x=1756197611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dEnKw4+D2Jk2ob5QjbelT0QPZugZQDkj2edboAhfFo=;
        b=vQ6+IbiKPKjGqA/BPdqI2dpYcihSIs8t8rPpvE3KejsUVB58sMF3ghRs/6YKZ7ZdFf
         ty8CxTbiyzu9oef/JwxeDJkIO2Eu3CMYBdH7u70o/jRxXljoSfTmKv9aMdAVQPJUqbWT
         3K2E25Ama/SjBm0/wZaNmBULLvavE8v0I7SWWqP7Dc1pwpetfh8MnBSkI67m/Ud2D/Hx
         2j6SVnj3Q+naaTnGhN1f8M2GMcAqCZbrGSQ6nIkksQjOMUh+agCCenUpXtwcRqtsJbcM
         FgnlT/4tXvd4K/pllOlEQrVf4M/+SZkpbIGvh/yQq/Ohmp5FYc7pgdUPCk++c/3wvFha
         239g==
X-Gm-Message-State: AOJu0YySvQdgh7D4bWmSoDUyAnAqT7zqE6SWD/Y0yMgh8U4fvPL9Yxis
	qaHgnnXl9h6xnjk+k0M5aNX8CuodZynNWDUDeeCHpZnrNYgymvJ/SzNgKqg0cg==
X-Gm-Gg: ASbGncvG/eA4nrEfRKvmkY/NXSKp++G9GVT5I4Fp3YjL/kDx9M3+It12g0VXgaL0vxV
	e9Tl+EkKsKxN20s+PmWv3Rm/BLw9KkyIMOTh4mhvar3oNBNqRfmHvTAGt46LMWTnLRkIOdMlekl
	7PRE2SLw9f/mMrLPORI9FA2NHfE/XFU2lSXFgdhMwBLfRS5lALoRxXU/Di7wKOXbasX4POIfuls
	8cNlE/WgZo6/oAyrmnWGUz/BwrakT9K+beL+ZHn6UP0cHVOR4s+Ge15cjAKEaM2l5GahRQixmAV
	qD/k+NxjFt4u0CHd4h6JTpwoGudLKh4GR/j/KJKy942Bd5kjXu+VpPU4nOtQsUDiaUUm345Qta2
	+IQuOj2zQ0CBg9tokRfEtsLCJQMYypfKpl7Y4xdY=
X-Google-Smtp-Source: AGHT+IEWPExR0to4aF6BrCAuPXMuEVz3KPjxYCKwZsnSZr/vq6WIV1z4OVrNFQnqFwbii9k9R3SJcw==
X-Received: by 2002:a17:903:1a90:b0:240:11ba:3842 with SMTP id d9443c01a7336-245e047efd1mr24389205ad.35.1755592811364;
        Tue, 19 Aug 2025 01:40:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53a2bbsm102601315ad.110.2025.08.19.01.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:40:10 -0700 (PDT)
Message-ID: <68a4386a.170a0220.305066.4ad2@mx.google.com>
Date: Tue, 19 Aug 2025 01:40:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7318394603910690699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_event: Disconnect device when BIG sync is lost
In-Reply-To: <20250819-bis_dev_disconnect-v1-1-a87c540efc46@amlogic.com>
References: <20250819-bis_dev_disconnect-v1-1-a87c540efc46@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7318394603910690699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=992895

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.98 seconds
CheckAllWarning               PASS      27.85 seconds
CheckSparse                   WARNING   31.13 seconds
BuildKernel32                 PASS      25.04 seconds
TestRunnerSetup               PASS      486.90 seconds
TestRunner_l2cap-tester       PASS      25.28 seconds
TestRunner_iso-tester         FAIL      43.48 seconds
TestRunner_bnep-tester        PASS      6.04 seconds
TestRunner_mgmt-tester        FAIL      126.31 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.35 seconds
IncrementalBuild              PENDING   1.06 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 135, Passed: 135 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.167 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.969 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7318394603910690699==--
