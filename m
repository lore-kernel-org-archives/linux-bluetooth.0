Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ACB24469A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629626; cv=none; b=EMQ8WKX/MZ7WFTIXwZ1FTuZydim83DXR/eAZY20cNUuzKoghaclYUI5PDGABt3IBm9+16t3J4MqipUqfuFSL3J9ErBBoeTFm2vOJneAePpNBh3mjx9kM+cU6IzqnY9m/RmzWflUbDY2RUnP4yXfg9Lu9KCATjFH9+2xR2yezYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629626; c=relaxed/simple;
	bh=YECuNjplq/a+RTjJR3jAumw4IzZbXOaOTJwOk17SpCU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ywzlov/syZbFsJfrNcZhe8Qio1h09+E8XNBch8BZQfdU31FKUgG7yGj+U4Mj41TOe+bkxuS8bDnV/mLj+mYBpzygRdttEKFoWo52xJ8dLwCid+KyhiTi1L5H4MiFihY1aWhlHiw2lBHctD6c28T3XqIFVQL0iz+cJPBXOEw+sK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABpw+shI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABpw+shI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so52730846d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752629623; x=1753234423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9nIntMBfkGUcnzFBET9zhp0I7hID4pQn8y6ePtwgXmM=;
        b=ABpw+shIHe1CCyYaF5FexYK49vLZCvnx45XXjjrd9zBrLNf7jZd590F8EWp+yVwvzX
         YT+ov+NotQ7gtEtVAcOu/axlrj+VIUgnOqH5okFK47Qc7WFDz9xhsLW975uaMxvi9JVU
         zZ+y2KKrVay/AZ6jCCo1tXwqQUwApAr0ysjwiCfnAy0jfF3rAe474Oz0XChtByfDepNU
         8mupMAMJX9oHAp8DGi1yiJySFd/GkWjEAo+TuQCkSyjrYNF51saIj+i2WcS4zUYjLiym
         V//24hIc46gtRu59zErIwUAnd0NLuveck/7HjaFiFBWxrxeYcP5Jf4AA5mNr9myFLAis
         TD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752629623; x=1753234423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nIntMBfkGUcnzFBET9zhp0I7hID4pQn8y6ePtwgXmM=;
        b=Bq7hxYE693sTqBHdTgJ/+sKm1/ySNglf5aXePvzPue8PBL5x8mqQmGieyBWu4A3mS7
         HuMtyQbUms2DFPQVemm3+T7hgzjyt8b6nH62j+6DIoshWYPUc8f3IA6w/orpgtx0VlhW
         m9BS9G4CxzEVelquPRxh2G/lrGJp+P1h3gj9heQJEpEYuKK5xY7k/MOWeaXyqlX6Tqcr
         pdePkLqyFzxM790KE0v6wE/QCahU5qnF1QAxgO3AXk+ZpHi9zPcIp0wh3klj1M5p/jDJ
         Fnp+dTnVHbsFCkEzkxYuF/nBs5hThAUXIWGHyTPHsTra2z9EgB+GobuoVX2thJWNj+/Q
         47aQ==
X-Gm-Message-State: AOJu0YyoPKHuypLzviBg8swM006gx0UkwJnXnZYfQ917TjD6rtXIMiOX
	+yhDgfoUSGNuJ13gn3F8hy9/yAIF8Vot+wNrydT/cDIXix04vVCSJKQlsj8UIA==
X-Gm-Gg: ASbGncvbGUjeg6XDSo9aMfiigJ6LmupUiNqsgc/kw55SyN+2Q3mSYDrlKUkw1eICReh
	2hsW5ZfxlBA+dCLixgmNnjf3jjdDCcveY8U4rwZpU0NHjXxaupwWpINHqYzHT/pVqwX6qO8TLEu
	Kzyquv+OZQF3tEEQLa7TrivvLJUOWpev+Mu2wjdyjD+jbfJFir8beL3+kKvt+sYGAMk0F41lh8o
	muaMBmH2QDibalKgtBVPNDr0/hJnnCrBIIuE9lSdexoSEHYpALxWW28RUYdH0/ctKNyXegL+1UZ
	KdTWzvafoE+5PR/KYbJHVXSOGoEmeKfkhCRB7O4xDaNGBCZFcM4hh7HEPGCBP0HYPHncX1bMQ45
	41w2tG1Km5o55wI1ARYFgtjJ/N6MFBg==
X-Google-Smtp-Source: AGHT+IHv/TfWZRIDs0yeP8Z+rtt+tFDJpgITE41eX+15nZHxi2T6CFPJrp8bUQEEgp9sllg7oicomw==
X-Received: by 2002:a05:6214:e88:b0:704:7d1e:8448 with SMTP id 6a1803df08f44-704f6ae92f9mr12165446d6.29.1752629623229;
        Tue, 15 Jul 2025 18:33:43 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab76bdb57fsm20851201cf.19.2025.07.15.18.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 18:33:42 -0700 (PDT)
Message-ID: <68770176.050a0220.29b6f3.b416@mx.google.com>
Date: Tue, 15 Jul 2025 18:33:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2562033261185426669=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: [v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
In-Reply-To: <20250716003726.124975-2-ipravdin.official@gmail.com>
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2562033261185426669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982752

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.04 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      29.78 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      473.01 seconds
TestRunner_l2cap-tester       PASS      25.06 seconds
TestRunner_iso-tester         PASS      40.52 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      130.79 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      11.49 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
IncrementalBuild              PENDING   0.66 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.187 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.162 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2562033261185426669==--
