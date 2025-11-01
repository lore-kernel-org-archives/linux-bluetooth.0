Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567B17C77
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996713; cv=none; b=AWzTybwiS5pQQzEOxHf1PZBrQBvoLEMLO0THtDpqMIvzs0AEqrzmhLYqa3hzeJvdl/G6RC4IF0OFxIFVvxDTHDD+KXD2xO5YoctQB8n96CDB8ZDNGQRk+xjQBqIblhKgBDm1Q2tNGdDHqUUS2YzkfQT+yyLo2/BIEyRMJJc8fHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996713; c=relaxed/simple;
	bh=9GQiLf+e0+PRRprAixLND0CWGyVtO62tx+jBKynrVnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HPVhxCWD5xzHOwyHNhqObscAAUc3UyRfxP90jxOYa4yibQYBDWuew9COP7mVNC6B2PRFL3nUT+7Hj6UC/pWKpBR3z6LJfNzlWi8vLk2vbkcJ/Mb2EP5275rBwkb88Ij8j6abfalx1lI8tJBh5QcYH4vIigNRLVY2ys+GVnYs190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDPs2pqu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDPs2pqu"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43325758260so1060345ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761996710; x=1762601510; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vLU3XqQPMO3cXJJJmN+jaCT2LAdn/eMdE0pUyKFGch0=;
        b=GDPs2pqu1DaJGmkcwZQ28QLzCr4TTNStvyhPT/WrDJWm3Pyv7hyR715pp5p5tKVfUn
         qn4wdEHKuuxGV5GI7deZ3q+cPILpXlQ3htAeNzKlNX/6RJmkh2eRZgobSsWAV6Cd+sXy
         2A8zQ7awWP7t/yc4HCEWwXom831MtP1+nyNuWtMS4D8QWMcvKSQeyw17xberhwBbxDbf
         mOr7W/HGQlTCfS7w5tS8OhbOkJI8mmvGFTA+tF5lPd0LV3Az5dG420rsc0EYhEkB3Vna
         kL6E7fdolZ1elUofKmxse68E7fyFym+jQuqJDbYZtiQ2hIV5vKUQo11txu3t/jckNu8M
         VQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761996710; x=1762601510;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLU3XqQPMO3cXJJJmN+jaCT2LAdn/eMdE0pUyKFGch0=;
        b=F+tgiyz/t15EhUfhbqK1Kb6uS084XUVRL0bXxkXSS9PByAL/8IRP3J1FwZY+EU2VWu
         q/7pOoOKhMAKurZF1PPoOOThv6MVUdxUZvHMNYdd0iGt6S0TMVBuyCpsfEZ0fPX11Ezz
         bruibrMyzelNZPE51I08eSxwPHQ2jBiPmnfAy66gTo1kOpUFRt9r5wWgOzkLQtZHAm+I
         0EVFPjal7Zz89hBub2g45wOumgJeH/BPKkM/wd8SGLjIRpox9RPlvdTPfYWj1vCiCpu/
         wtmbk/PMtGoEEQDx0zuFT2ELJ/uxV/VE6TuVRuNjAOGvjXyQ950mwl20ptBhmLIrLdB3
         rPSg==
X-Gm-Message-State: AOJu0YxJcNSOGcR9rtWzq48ARATqaatpAZa9w/k3KG44a6Nsi1CUyRm1
	xpeqpWcHL3hza+edoytXo25vrS6jWrDtoNoRF3T/r9R2UhUMeQ1PNusCrGRCjg==
X-Gm-Gg: ASbGncuYtlDVIntYDMRS4M8Rd/GmIEYs7QThcIWpqh9kOVa9RTBZ6HUEd5ciO8gsCgt
	KBM8YE3yP25f/mOEEIaFchfSjieg0UzvCmc4ui9fmfYyxVCJZ49aWGHxhUiWhnenjOIwvfSvxt2
	24lj1N0SSsrbaVwksIHGTmuO9FSDgb+UvvcsVEACuQUsAAXTgZV1bQ7w8kncwAPFo7yDZmcO2tm
	5EW920fzliceNnS6WA/PjXvHlptwWnhJlB6Dsy0t+JjNhbjxGc+l906aHhvrlZCFwjLQoxuGyWi
	BrQylSGGrRoIT6GmRADuANT5sQ6zSX4Ia+BD+rGDRRon+V6AiWqbd87d0kpWDZKA48gOZ5JMDLG
	8nPCGh7sZc+vtBOiV9zMX7zkV5N7WMaAgrupN2CGS3klqw3mUKonmIj3JWouSljwUZWj4Qw9K+q
	hDOm5A
X-Google-Smtp-Source: AGHT+IGoYJcUcn3xjdPC6r7Boubqcq95GDVaWSSX2i+maH9l86I9QEYBl/HDfgYXWctrLRr522Wafw==
X-Received: by 2002:a05:6e02:b27:b0:430:c0e4:9e43 with SMTP id e9e14a558f8ab-4330d127e6amr105407925ab.6.1761996710102;
        Sat, 01 Nov 2025 04:31:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.58.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4331028acf9sm16314175ab.12.2025.11.01.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:31:49 -0700 (PDT)
Message-ID: <6905efa5.920a0220.18fc8a.2880@mx.google.com>
Date: Sat, 01 Nov 2025 04:31:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8893796008096841907=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@163.com
Subject: RE: [v3] bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251101104522.174388-1-zzzccc427@163.com>
References: <20251101104522.174388-1-zzzccc427@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8893796008096841907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018482

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      25.39 seconds
CheckAllWarning               PASS      27.70 seconds
CheckSparse                   WARNING   31.06 seconds
BuildKernel32                 PASS      24.88 seconds
TestRunnerSetup               PASS      497.87 seconds
TestRunner_l2cap-tester       PASS      23.79 seconds
TestRunner_iso-tester         PASS      64.30 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      111.80 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      14.28 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.196 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.022 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8893796008096841907==--
