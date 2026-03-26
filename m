Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033038AC63
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523336; cv=none; b=BUZuveq83j3oKejWoiUNYFU5zpMtrWesGwx0zMjUOL14BVEs3d62D8KMfDkk5M8w726u3iLB11H02o7v4tj2bEVcBivfak0yMxex6U29LlFPqKrWctcEXaTZqmpiEzmF6LUpE+EBRnXXvgaAA8FdXeQsJBuSUcgRUw0NUO4JVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523336; c=relaxed/simple;
	bh=3NfBpDKMXxZAodfHDSKAgmvHcXujCTKo51gN70ccnYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UEnatJ/N/8L8u9odX9zvh0Mw4Rytnic0hUqnT8Jmu6w+QIJYY9U8gSEMGDJW7zA28BfmZTrDhI+4wp3iDaL1ZIlIRJBlV0H2h3p3KsXJ1e2FBZZhgAjE7bY4n4G4itXCj3DIgclq7WZ0+eSQLvCnSxdSNTnPF2LExPTijlsssok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEYoYuqn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEYoYuqn"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfd44fa075so128122185a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774523334; x=1775128134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JueAqfognCvzhGvB0xvqvoj2xqMZw+fLPk9qQ6bt7vs=;
        b=NEYoYuqnBYbUSk7Hp1BwSffIgXR3XbvcUxv+cWpSc7ncGaTSo7pbjwRKnAqW2HFiau
         qbLusrvS35LMiSIbhaeV0okMAH5/Rd0ux/gmM87frXv//QVQj7x4pXstWPs67QSoQxcy
         KqdEDLhK/jzv03IZgtm+6jlg6uhOCW/d2DYRTO5kSjuYlWyt8n4j4ScN2641PIV0W2mS
         gIU4l9YjJppp/jzx7LL7UYREotNO2S3gFhB+z0iVHB9B1t1nn+z0zq86ih/pgWe6j/9/
         W3H6BvKnetiwKIzj5K2m+BFiNHkk3UX9AxNWTjEpjNzMCsJZvMiMuDE/ug16+f8kZIHY
         Xn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774523334; x=1775128134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JueAqfognCvzhGvB0xvqvoj2xqMZw+fLPk9qQ6bt7vs=;
        b=aQEo/Jsozo5sjpCEmJ+yCLVn39Ayl70880OXzjcit5SjhFVfcZdHXlRzFv0qtOTx5i
         71ifoVE52l1+/RTn3aoPbuYobPA1UoI2LKVJ9i1FMGuebezCx/d9XFJLpPjO9xtES4sg
         /8yNfRL09TPGZYgZegErBoIVsWbb4/7W4sleh7oOCTGidzAZCN74EKgaIxUTWEq0T3T+
         hDOVB89MZcXsPpfkl2vA8WyuMKCU0WTEr56uZ7GWaMy1ZCTMKFsvjF5q5VXEgp4qbtGZ
         WIDqtHLIJfeJPoGzMLpm/PasNeyxFa+7y6LZlN5Yv0jYJNqvlhwgf0IEdbcXLSHu9Q8s
         1XZw==
X-Gm-Message-State: AOJu0YwxJnlYbIrSqj3mWO1uBh4X8xqAohHnTfQLmHDHeXqoPIXqVCOo
	tDm++vJ/GDE+Tz2KcL3+7Appn4Xs+Tg5TYv2qlbf78NFcGrR0QJLrnWL7E3SM3gp
X-Gm-Gg: ATEYQzw4v/L2Gvij+taDRjXbQyfplKwaIWG2ZCICf7KxEusiHSySDtJGvSNJp/JnVfK
	rRhXU3LJpYZsoCgLjV9OD6AEzBNBchWOsaw40B46e4t7Rz7IfhH3gxmzkOAugUdrJmSqbKdyAzh
	Pgdh7r0YyOmBh5p4uRpACY58a7U9d4Z7h+1lLMrzFjCezgVNe6Pg6ry5iiako2jcLvlIeUfk9cZ
	0kNQPlsApTsR3Rir5vjL8g8KTxPVWQquALYkk3r96w9JSQLQcXw5evcbSKlcEk4ZNcZ4PIVF+XP
	NLW0o7v9T1YqTn1ZVUakAilKJ8FjPUApoRrfGcHHGO+NP6fYjySdHYK/tp21QE37VrfK5n/8X1i
	Ohgn5XODi3sDcHq/gw/FACBYn4SPYdKi8mugwDF2JxRUoSndyGRxVarmrZNl1WecwNW+4CeOwN8
	3Mb2CMxPwXiNrOW7HxivOADB+ZeHs4KGM=
X-Received: by 2002:a05:620a:400d:b0:8cd:7cea:aea1 with SMTP id af79cd13be357-8d000f0389bmr916299285a.15.1774523333743;
        Thu, 26 Mar 2026 04:08:53 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.118.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4ceb95sm213204885a.26.2026.03.26.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:08:53 -0700 (PDT)
Message-ID: <69c513c5.050a0220.1df60.49b8@mx.google.com>
Date: Thu, 26 Mar 2026 04:08:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1044908796949742621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jonathan.rissanen@axis.com
Subject: RE: Bluetooth: fix race during h4 bluetooth initialization
In-Reply-To: <20260326-hci-init-fix-v2-1-a974211d0224@axis.com>
References: <20260326-hci-init-fix-v2-1-a974211d0224@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1044908796949742621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072851

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      26.06 seconds
CheckAllWarning               PASS      28.32 seconds
CheckSparse                   PASS      27.19 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      566.64 seconds
TestRunner_l2cap-tester       PASS      27.65 seconds
TestRunner_iso-tester         FAIL      30.48 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      115.27 seconds
TestRunner_rfcomm-tester      PASS      11.22 seconds
TestRunner_sco-tester         FAIL      14.34 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.96 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.796 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1044908796949742621==--
