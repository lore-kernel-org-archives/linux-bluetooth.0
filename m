Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDE20E011
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519897; cv=none; b=RDV1AaZdfcXpDqXS5a3Bp63ssCGwOhGRRmpUA2YeV+zJaHksNvvyV3ST/OKhDjZCNeCUDaeVzS2vT8v+RPTidmJ1MuOdxGc/qsrx5wEr9RFzs94lyxHKxKTyhDkmKEJqc3OcHFTdGY9uSZ6YLK3YWWruZghO4NnquuKs4iKqGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519897; c=relaxed/simple;
	bh=A9A8CfTduznoUypNbDGXYN4SOeLH6R3DdbUw6uisn+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jMHAiuhDf43iHBeCeDbEHl392uxCbVMUk1scorfg83B5Y4PQ3OTBf4YeaR55SPsaUHGDo8cNW9aaGg+T6+j6X1kP6hohMPhICLjSkKJr7ZVWSaVVGsNUhcgCpaQr6G4gmh79c/6tYLVnN0vYw5UH/+uL86kpGdsMZ4sgzuhdUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTCPuuAy; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTCPuuAy"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93607aec358so71868039f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759519894; x=1760124694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SfyiW1bXDfs82KXOimNIlSQjApx0YqIZQBy3wlh+Gfc=;
        b=fTCPuuAy4TQncappdZ9D0Hd3PIlPoNOTkt8PX4vRhUAJIsXIlakGKBF8Gl04kbXYrt
         U/JsWHIN+5f8XgXpVTtF0FiVjYBbIkPspL5x4NOP4wzCXML57/62DG6DlILBkjFc8qNw
         DEUvoZmJlVok6SUo/mHecNyvhNoViha0a//TA4lmeLW4tEFmH9f5f5k1RHveW/m/pmRR
         g51T1SOR+KhlbdoLTmQgW5mY1ojllM45qF+JjZrAanv97wO9yb35npWN+bdivNy3a4Pf
         UqT7CMgCGoLpvszlrcr5VQJSfnzuoCplEmLiaOWf3N2cMduSvsgN9a9Y32p5VqHPa94y
         NaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759519894; x=1760124694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfyiW1bXDfs82KXOimNIlSQjApx0YqIZQBy3wlh+Gfc=;
        b=WbCF+0LugzM6qdqXrmCEAgrWYGK4MoSL/6aWH8dfi+3KhKvV+R0iJYpdZfHkXylr4z
         Wh8AIetlHe65FMvz9IMWBsWhbuTELqxvln0IEO8DCga17xYUECCRAMgZzYX0EN/I/bhO
         F+vfs0hnFzKS3qQC5HSdJdTBaqSaVMb5X63nrLLhXmJBfc0sNe2jfgPAlm0RgBphg9Fv
         42+v0tdmFfsOlr53yPdlf+VaDUcDboPgUi6YyBTK5RcROb4ZNyL5ygSt1z9EyGUxxPu/
         h+0WTh7Lxg6ck6WeKvJFGJvWYzc6kp0xCGBhIGHbvflYMCvs/Evc0u83t52QXVkR++vu
         po9w==
X-Gm-Message-State: AOJu0YwTjiSMlSuwJojhPshQirmEw85lSYB/90AjdGzBVTZMrJck02lO
	MK5t6qvTcJPFobuOdhOUpyjyINd2ZVSgE/Zywo6bzRWqBo+ApJaQM8pgvBxFtw==
X-Gm-Gg: ASbGnctlDIuoOSsIz2FCs/qJgd2Kp4WBUjW2nypkg/khpjcglj3CMcGIGZ8YhwPHqiP
	c/77dA2aOFRTEQt2cF1L+C5hivZvbr1Dj/0QPxv9ARK5KM4W7TMEbyNvxoHNjzspR1eC5uXres6
	LiFMp38vua5GrakhlC5bWxtMrmbXAEuDq/491A1fnfGrljylG+DFzVW7mhVgfNCxViu1w3eDZVH
	hA8jIkilvHrYNS/SB3oWR7//dehYeST24mpIFHnVyx6eYicWmL6ZwRAJKo0goHp0dgmBkCvPVuv
	TfCSVVbT4aCWGXgxO3r4RwkFWpRpCh/2bMAiu8yb6/ev4djzxrXixLgqfyhP3xd5tR9mpbtrhhJ
	ux9AJVurRlsRLngzkExwMdNMqNwt6blRViqCPq4W1FZLoa2aJoK729NKR5EBXXqUt
X-Google-Smtp-Source: AGHT+IGpi9q+5PhDRWUEtt6t+wNZyUeWT9ZMmN8rMeD/DFmo6dr+JBYvQPNq9gtNoYATqKXvd38T6w==
X-Received: by 2002:a05:6602:3c3:b0:922:6c20:45ef with SMTP id ca18e2360f4ac-93b96977bdcmr650826139f.7.1759519894282;
        Fri, 03 Oct 2025 12:31:34 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.231])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a8912bfd9sm214809539f.25.2025.10.03.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:31:33 -0700 (PDT)
Message-ID: <68e02495.5e0a0220.1f2dca.4290@mx.google.com>
Date: Fri, 03 Oct 2025 12:31:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7461264846804410918=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete
In-Reply-To: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
References: <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7461264846804410918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1008357

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.57 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   PASS      30.39 seconds
BuildKernel32                 PASS      24.51 seconds
TestRunnerSetup               PASS      486.03 seconds
TestRunner_l2cap-tester       PASS      24.06 seconds
TestRunner_iso-tester         PASS      57.49 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        FAIL      125.14 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.38 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.31 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.886 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7461264846804410918==--
