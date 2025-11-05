Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC542BE02B
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325021; cv=none; b=ON4EPucvPSRUQ268rikln+qadCRp/BhLLpoFOIfkcV1ppO+ycNWjwCgJtA8iBvI8jLnIiTYUcPpE8vKFzayetLrBdKAruVwRIQTCAUrtDPCeJAAw5QD4hZhh79Wj1a6X5+Gh9zDblJREE3Ovj8KrzD8wHaUNmQ2r39DU2WuEiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325021; c=relaxed/simple;
	bh=o0LiLtSkA4nV1R5vrzXHCkJ+TjAombkCZvKoK7NgLJM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DUM+rVDCj4KmAn65dioh7Q1qboZAgfDKe+I2QvvzPy0sXvxfhPrr0oVHuYGRO/pQMMDo63xzrDi193wY+znytz7utOTxIyI6cpAvsRbTNMpHQqllj3Ll3fTpLqdoMojtVFAWIQ1sVxVgKrdV7adEqWQX+ENJl4q0SLGU0Zfw0qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atG3EHYH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atG3EHYH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso2164266a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 22:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762325018; x=1762929818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MyuS0FLxiwborZdnx6UnAeCzdSQgbhWqSkw6xTDBLIg=;
        b=atG3EHYHdSxXmoyK4X/CeARQ9gmYNQfc92svgm5p63m19P+MNZw1xTRz8Slb2KBz8V
         bM2l4Cz0VEB5DZN4FFqduYoWlYhv5GQBlbvYGLnJJId/hkJLkz1WTWvCVXDndcHeCWIF
         nNrVjxlqW5PFTCZbsMz07+Oh9v0Nk1JG1CiV0UHIFK5Zgr95tEjsb5LeYj8qLJHovCIc
         ys97xA7by3+lcz/qfZrOH3yluCEguyYVL5jl5YF+g95sZLF6aUzF9ONxnCFE1JsNwCjT
         IH/YPOVZg3z9Q937sIQg2+k67vgJ7GObj0KdMewViHjzmzCYpDFg4W9m5ein+JfTtAHe
         JcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762325018; x=1762929818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyuS0FLxiwborZdnx6UnAeCzdSQgbhWqSkw6xTDBLIg=;
        b=YmSQ2uoSJTm9Ynkg4Sq1JLVNvaAh/E4Ptle5YyIkuV1C62yVQqqlL2uPdeGKOFqPe7
         xxBaZEHazyGwVprclV/I55m5DNiLVA2Zhi7SdTFnOJ2fIXmUnvEwp31K4mAw7wRxVgCV
         up/Vf677OgXf70dnPNG+Ys9mo2tdH2WbGC/B4DMhKgiVZWM0XyuDLclpZTBLPRmGNrnq
         LgzR1NZr3ATJU5+UiKCpxIsOoWcJVfBL3hEvri8nw7tMQDKtJYufxEDnRT7TksK1JDAf
         RvDq1+uSctG7hRzzU+VdohSe0ceYv+FCLwcEngdj9bbZu4owAAqoF/qTFL3wVvOg4I/E
         W4qA==
X-Gm-Message-State: AOJu0Yw1bPcaX0Ay9usuNOGcc6CNlgCCm4vHiONhxUv/KsE6j1N+iyFb
	90nFaZ39PA1KKG0maDeJqfW5mh57aSLFWAOUaCpxWQvrhz35d7mZEpj1JQIoPw==
X-Gm-Gg: ASbGnct/ZaWw0SR4JPa8F2mzXLGeF2CC28SJUMJdhUHr89y4nq1uulM9giurIOYe9lb
	tbl4MMomlh/wN16lTiLJh/JE6aTE6simH1QKIdQmjGh4cjTdkv2i/+PdL0yM4GO2kxDHzSPGc2S
	za74yEv4RwNtamH1hJn/AFd2wk1tdnKi5PbG58drRCD8L2oXaJSLxrjXY3xDdVXyPoYP9k66GuZ
	6rswW/1GZOygTFcs7C1XOCw+jzyviaNal/b2tHOUPwtKKyw5ShWrrB4i8Owsbu3yqiSbPxCYPzJ
	p7uAfPQElsYa8arIX2KrAHf5+Chi/p3zNAArzUrAzAVIgIK+0VWCSSFrIZHtStGdyWQm8EMJoBt
	phmNl+NAIogJD1KQc/q0Stu2G/kO0gaDZxeAL78PSnFsYHRIc/cnPmOl3/FoVUAg+dctSutsB3U
	RqQjRC7Ig=
X-Google-Smtp-Source: AGHT+IGnxrXexbHGbQb54PZV4sPVJ+27g7BD96Z81P08dKe9yVuf+BSvc3CSNmRyPabh/A7+3iWB3Q==
X-Received: by 2002:a05:6a20:6a0f:b0:2d9:c2:5ce4 with SMTP id adf61e73a8af0-34f840138bcmr2816276637.7.1762325018246;
        Tue, 04 Nov 2025 22:43:38 -0800 (PST)
Received: from [172.17.0.2] ([172.182.212.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a7c7cfsm4460303a12.11.2025.11.04.22.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:43:37 -0800 (PST)
Message-ID: <690af219.630a0220.5e3d1.38b0@mx.google.com>
Date: Tue, 04 Nov 2025 22:43:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3814702423496335649=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btusb: Add new VID/PID for RTL8852BE-VT
In-Reply-To: <20251105055041.456142-2-max.chou@realtek.com>
References: <20251105055041.456142-2-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3814702423496335649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019714

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      25.73 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      31.36 seconds
BuildKernel32                 PASS      24.98 seconds
TestRunnerSetup               PASS      499.29 seconds
TestRunner_l2cap-tester       PASS      24.08 seconds
TestRunner_iso-tester         PASS      76.42 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      108.87 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.26 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      6.54 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Read Exp Feature - Success                           Failed       0.099 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.066 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3814702423496335649==--
