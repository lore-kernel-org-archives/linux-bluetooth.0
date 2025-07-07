Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4D7E118
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751862442; cv=none; b=dsC51UYjV+WTgdb2vzmd6qx9Do4Et1o7eV2dVHAG57pWVRk8sAcluK/RUUfJDRVPg8NPP/rbtt6EXLrwJeXU9/agpynI8xcExJ/Q2OZRYNZQo6XXJDURw+uCf9LJWtp7GTuc7k8O12zls27FDVv5KZw5gvTJphu9lEJsPTNXMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751862442; c=relaxed/simple;
	bh=iqJ8/9h1u+5XayEibHj7pnqqagAi6FYmIiFlP+RIccY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Nqpl+SR6GHhiGwOvGPHb+54JwG1DUvfun7dmSr7/+VtWH6BRdcOwoKIOBwYxNN1Gy9BBnJfB5cRHJKIP/irr9GgKWvTrEddhkAkzMTiltIzkbRQ/c9/VL5lowY90vdFkPXZPITu2xJ+7Xct1Md6OkmqRVkVfifS57teYFtXBsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9wSOGg9; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9wSOGg9"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso15093585ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Jul 2025 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751862439; x=1752467239; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jBTd1SiwvKUlfkBV7O/xBiOF0IQXAnSs8rXCyzTjlLY=;
        b=E9wSOGg9wQZRP3O1zu0q7n8TLHLI+o5SHfHq0m495nx/PuzuE1dsAutfssx/4Tq5ux
         ZAXNmi/xSKa1fr6/aemacvEpjVmcagX1GipcPjd4CUi/prxco/Cp7DP6NzibBp61K84V
         tD2NItHXFqwXj8gkLNE54WBLEEVU2NO+M2G9QqMlREPj5JAsIfhC/8N5SJcpyncpFNjn
         AuW37wU82Kgr1UiaOFF5IZGIHgJu7kBOx9phtJqNRiIij2x4YRKtUUBLVswhyi0SrthR
         tUQRl+8xW5YjwuP87IgStBLt1SJMkNcgxquBR1UuD4cxVjO+c5idZhzY61L4EYueNAb5
         qh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751862439; x=1752467239;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBTd1SiwvKUlfkBV7O/xBiOF0IQXAnSs8rXCyzTjlLY=;
        b=tUxsgt/Jz3TzQtY9nzj8q23/1bds2d5r3grTn1fYfU2z+sstEdqEX/T6tKVJk/v0q4
         FFNAau4vnQOXon7nXYu0HHKH5fst5821UIvAFYUs3OMJRZhETV5SnXc/Gk7nGMIciazQ
         IFfVab2p/L7AzXpg2JoJ2Qj7Z+tqfvaNyVsqrGvOfvMUUut3LSojk3pRVjUChCMw5WWU
         aTioXQiKA5ny3Kt1N9roycFxY85V4exwzNPBiO8mwTZymrkufEJfA34xz9pWXccNhISb
         kjcru3pEx+B6vC8HCNfRIDDK6UBtIpc6KjfZpMhNR99J0Ku6eKvJYetZ6Hq+BFJeQ36A
         Ehxw==
X-Gm-Message-State: AOJu0Yy+uFHO4X7M9AygSBNiieCw5LOoxgfqjYS8JpeqXKaFrxKhGh1w
	JquxmQ9GZKQqgkU8+DlpC0LI5Lq2gUIw91cEnWSmgpdsdK45c1lKgyaLwL9aPA==
X-Gm-Gg: ASbGncsGEysG3pM7Uyqvz//LHjjn5kF9lPzn7jU8gnjxH1ojtj0/GUUCplZD7F0djvD
	7ThrYYyeD37RGSUwIp0bWDg0QIcc3Uu9wHz4C/JdmFKZXX05xoTqXo4QvH4/hTBk5TjY3F0bJsz
	vSw2oA4BXXhj6Ubp9lLaigL0iXSSgKU0Sf2QthEjcP1yq3j6ia1DrsQiFFLneiS+UO85RN3TPr0
	wiu0bjFxnLnFwUUqtHzl/3idAVGmrBd9X/d2AzdlhT53TlmVimzEh9bfX20S7lkHYO/SJc8aTBB
	nEr78vAMHNlekEK28m9yjgJ/1nUJJilyxQOfHAGjXxt7BOE0ngKNJsSRW9m2zI7xDT4=
X-Google-Smtp-Source: AGHT+IHfsb7ltmmlIXhf9UoPjpPY9aVZ/+Vo7sPbJFbQ+oYIYHrPxGzR9n8AZYNeKd1vH8dzPJkxeQ==
X-Received: by 2002:a05:6602:13cd:b0:85d:a235:e90e with SMTP id ca18e2360f4ac-876e4959a5emr834676639f.13.1751862439319;
        Sun, 06 Jul 2025 21:27:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.187.73])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e0858ac8sm192833639f.32.2025.07.06.21.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 21:27:18 -0700 (PDT)
Message-ID: <686b4ca6.050a0220.33df41.3243@mx.google.com>
Date: Sun, 06 Jul 2025 21:27:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6778132156887938971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
In-Reply-To: <20250707034657.929092-1-kiran.k@intel.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6778132156887938971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979530

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.10 seconds
CheckAllWarning               PASS      26.41 seconds
CheckSparse                   PASS      29.76 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      466.76 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         PASS      33.97 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        FAIL      130.72 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      14.60 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.32 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PENDING   0.70 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.194 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.160 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.164 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.200 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.170 seconds
Mesh - Send cancel - 2                               Timed out    2.004 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6778132156887938971==--
