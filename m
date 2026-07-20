Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958343B4EAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532516; cv=none; b=Y/LeAyVqPJ7AzHvu6lz+VxWBxb2f4kPo4qojr9wFRzYdPrIvTw2itreaA/Yhstg6lYC0O1PRI09AdAabiCJGp75iyjfbFebwKvO9QoYK10IDfNpWjd3J9Zyw5zFURDBneLbwGih14ofAxRSquWZ9/5wufPsvc0DjxO3e5EsH6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532516; c=relaxed/simple;
	bh=LBgTmrcfEIVcY6p184uTXHmm4dwcfKbyIVAMFf7JPYM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GIwHtpIqgUC/PipqIWnwJceHYVZnK0NRcIGVbcJDPdEflTuHMpe0Ewo6fU5hZb7BLTlKZz3MjmQkR3clhGT4I8fT+DKIjkIkBVZvyh9jmSyYJslyuP56QEOErBcCL8+BVeuN+yTQ+5GjqM8z22uSKiHut1yxRTDA4L4h3X52mbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpGld5qY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpGld5qY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce98cb8165so35686045ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532512; x=1785137312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zQOrdrrN1P/gni6gCAhonY9YVZIiyCSIQwp+tG8m2BE=;
        b=FpGld5qY7FQwuRk44M4wSHYm1CsIqNY8rnDRdJe6hrbMNm42e9GoPn+5kfzyYxT+5w
         8FIjFj9MgtKHE27+yiUidJ5p8QoOC6EyeWXtk3A4wOOTTIcuFCA0Nwy+xUqxgtwUkfH5
         lH2z6sNx8hRwUh/rZFUtFdQ/mqy8iZhFbFuMKXIgkdpFN11v0eLqm5b7t/DeKniKU0qN
         IdkVny2uOJ++1jpmHnVALe73wfwYd2ermTIIxJ0U3MvKUFKKV2uKiIBhheKlPFhIAI1J
         JgXv/YXpOqQqgzavqxXeD2vF4/ffZgiu8VyJOe8FxHgqdrnDyb8wjK73lbzHFsOiCK56
         3J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532512; x=1785137312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQOrdrrN1P/gni6gCAhonY9YVZIiyCSIQwp+tG8m2BE=;
        b=Q9AhX0yEzzh3bAZF8kJ6PeCRj7gO9Lmw20WFwajgSw/hEC13lIL9+q4lhscTWXJ7iN
         GzzjkwMoFl3Q3Pel9wxA5IvMsZMB1vabdOWW86EetD1E1Acd9T6wzl7pRwwFa0bqfCOv
         /Ezy7gIEzYuXsPSc0DUboBQI4B5UHNV2OTpQ+evHC+2RtY6S1aJ7GFFwsslnuV9mWy9i
         ug7hvHAANT/oApILY8rK5+r7Q0Z4XNhO57/sEfw4Ajp5JNtQSMuHeyvvcG+53blIren3
         5mq4i90gIw7QirVtxclo8AyqUOgjB5hLX/SuemC63KLHnEwibDnGz36qWIEgT8RBi3xG
         ez+A==
X-Gm-Message-State: AOJu0YymJqIiYoVxZEKfSvY0Y4LRuDv4jcxUsX5oy+HHEI5pRSPlF97q
	ZWNAg4tBdxA1U75dbMqNvebaV/0XeoCKHx4Y/VdZ7Ncimq3WipwxFxjPEsuXRQ==
X-Gm-Gg: AfdE7cn+1AUNSzQPIoKCjBUNYw6PkP4AttJhflAB++N1BVGvtiEP2z+udR76uW6xxhX
	wugDiMnTPz+S8hL6/BG/uUQriSvjwvU8hl+D2wUT8JuXcarumVs35lniNRcK3xH4wXjJcQ+ya5R
	GXBLMdmOeXs/q7GVU+Bk5cLBaH8eoMmFnfAhsVH++rw8OBIvsOsjVwTfUq+UWx5vT1n3yPq2cTo
	hJIDSdRtEOovopHNKVL8fIGr1WEL9YjBiin0YXD0egsFQ0Y1kib+kXveHmYNA9yu7C/ERjcavnR
	HM2Dhzv0sNWYqRSZjrEMjtJ9bsNmx51iCKdY1OsXKkvmec4nifVH23ioe1n/ESJBmbyABKbufOI
	q538czpqGuQu4xTrihlWSkxN8AuEUHwD7JMwLWVJnBvd/Sd0gwJHM2gdFSXcIkNbBkBKN8fJ/2T
	WXYR6Ht/UlD5lOzu6NfoVe
X-Received: by 2002:a17:902:d483:b0:2ca:f417:396b with SMTP id d9443c01a7336-2cf1f25625cmr182604425ad.3.1784532511780;
        Mon, 20 Jul 2026 00:28:31 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm35850219eec.14.2026.07.20.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:28:31 -0700 (PDT)
Message-ID: <6a5dce1f.0c05e68e.3c2f5d.762e@mx.google.com>
Date: Mon, 20 Jul 2026 00:28:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2683540229866851590=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [RFC] Bluetooth: Add generic support for vendor HCI frames
In-Reply-To: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2683540229866851590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130540

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      30.04 seconds
CheckSparse                   PASS      28.79 seconds
BuildKernel32                 PASS      26.49 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.38 seconds
TestRunner_l2cap-tester       PASS      61.40 seconds
TestRunner_iso-tester         PASS      79.89 seconds
TestRunner_bnep-tester        PASS      19.48 seconds
TestRunner_mgmt-tester        FAIL      219.66 seconds
TestRunner_rfcomm-tester      PASS      25.80 seconds
TestRunner_sco-tester         PASS      32.02 seconds
TestRunner_ioctl-tester       PASS      26.18 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         PASS      23.59 seconds
TestRunner_userchan-tester    PASS      20.33 seconds
TestRunner_6lowpan-tester     PASS      23.03 seconds
IncrementalBuild              PASS      25.40 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] Bluetooth: Add generic support for vendor HCI frames

61: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.235 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.254 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/460

---
Regards,
Linux Bluetooth


--===============2683540229866851590==--
