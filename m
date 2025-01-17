Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35B149C55
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131619; cv=none; b=ByXLrzN7GOiMshyVpRKsfAyCihqGym8xm6hd8jNnJ9wS3a6eeCBGtaGjFKk2tRc1AhxNlDnd16bDo1YH8J3cbSBziWOmGJa99V2o90JWkeqBS/NhZqQFm+iKt8OelD87s73ilnNqSBo2iMEr+5peTmbklm6bobjx4UgjIm46bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131619; c=relaxed/simple;
	bh=DODeiZ2u01ctpRenNVefXE4eFSgwkHMVbM46EEzuwmo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sGKEKGiM3eG/cZXY55ZIpc9uKC1bsZMKP+7AzQeDIKyNuNXXim1ViB+IeChDvS/GnyEEV32CNqCrI1APKQ5qTrnXoMz9WuUqL/q5sOv8osM3CBKJ3SGzM17QdprOsL8/O2w7gnP6y/shpiR4ojU3r6W5rFDYFgqqyu/yhxfzIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuJe9wUr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuJe9wUr"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so3284044a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737131617; x=1737736417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hB+971DNtwfcTycTrkMYMDKtKxag/7fM9y6fauiJn7s=;
        b=PuJe9wUrPxDXF9C/ymw+I8QTAyuDs06s57qqEbqNemsEJgPc0ysQ7ki9qDNZkwACj5
         4UroZ7+mGXUwif6oA74+6G4ntyke5yJ78j1Jv1cOMlooP6Ed/8Hpw/GYdSVdka8WohbS
         85UVFuCDJvXgxGj8DxH5UUEok/EPhGCCLMwpQsoNb6gxwXLWH/+u3EwFwNKd+seabxux
         DV5qR60kn/t9xzpvBXVbmWpLoBRSTyhmmUH4Tcn4znrZL01JFESdOXVos9LqPvlP78Pj
         O+w5j6w0ufqrF/TPe+C7Fdz8cGqhdEj6sgI08IFimWJU619C2AuwcqaPR8fQz6D9LKOd
         SSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737131617; x=1737736417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB+971DNtwfcTycTrkMYMDKtKxag/7fM9y6fauiJn7s=;
        b=AbSxG3Fv5XBfScXUm2vuJV21w4TMeN93q5tQNMsWFWmjbqa373+CRAn7pFGLMvwKZp
         +516od7pgWtSPTbkitLK2YMsVvwPA8CJ3R2oEdWYNXjaBx7MIlGuQVBRgy59tpT9qzvT
         2Kd8SUnuZXKiMzti25iA/a8sKl3lI1rhivU5QpEiEufG4PlaWkB/gLlIWs3gPqUkPbZt
         7hU7dSQ6wDEWTXCaG3mzdGowZ/JCZW1MgeHgHEThkr+KG8NF0K/BTFo/Co6Z+N9MavOC
         3F3Ui7Nl0auPw1XOoM0w+8HRPF4wcJRqcsj0pBcECYX05d/JRgtSWg2PmyppqakXeneN
         vEdw==
X-Gm-Message-State: AOJu0YzgtzPUnC/D/o1tDcIvxNrxRZA3O3ysYZcCnFVir1t05jqAx/xx
	ADBv5GKiCYqi40G4AIz/t71lCUBzTXSgL+CxBFDBhOuU7yPIlRY0a4D4nw==
X-Gm-Gg: ASbGncuptKjvuL60lO/dis7WAbGbv+QoaINYNB8WLm4b1YFC5HbKJbOH8+NP/j64JxH
	CjrKHX1gvzkxpEn5gxZi+tkzaUNNyqKg4Lr9WgXAz1Mv/TqrTBZ1GzRsCTIsBkuYa3JGTkl2F7r
	ZD61tf4o2OrceDLpkaLLz7+skDn6SgagqXcxetOVJECis6nfoCOP1MregKCtU1ED58THn1747QT
	irFBuWdTkbzUS7eqXe0PvhgEe8FIrrBX3rRcR41tY/8Fr2khkpCiEOPxJZlQA==
X-Google-Smtp-Source: AGHT+IHqulgxG/7Qn9MHTbA2zwEwe41O3CgOXeWwmURpCe0SOjcn89NSFhh+McOoMkk8udRwqdeVOg==
X-Received: by 2002:a17:90b:2747:b0:2ee:d024:e4e2 with SMTP id 98e67ed59e1d1-2f782c662dfmr5018094a91.7.1737131616717;
        Fri, 17 Jan 2025 08:33:36 -0800 (PST)
Received: from [172.17.0.2] ([52.155.62.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a1b2sm2284814a91.8.2025.01.17.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:33:36 -0800 (PST)
Message-ID: <678a8660.170a0220.6255c.8d1b@mx.google.com>
Date: Fri, 17 Jan 2025 08:33:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8154163995557407067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250117155608.3836950-1-luiz.dentz@gmail.com>
References: <20250117155608.3836950-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8154163995557407067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926497

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      30.58 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      434.16 seconds
TestRunner_l2cap-tester       PASS      20.91 seconds
TestRunner_iso-tester         PASS      34.65 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      122.82 seconds
TestRunner_rfcomm-tester      PASS      7.65 seconds
TestRunner_sco-tester         PASS      9.50 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.77 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.204 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8154163995557407067==--
