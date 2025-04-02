Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75392AEE9
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613585; cv=none; b=quzLVWvzAys6UrvZR+XrCVFZXdnBoWlJkGPCDVk9aBVsYjI/nCUuRfotk2P5k7OsKaU/IuOmeGhPj8PTm4GCYrbM7Yd2nP7JdhQkUxq9n1FtCuf3bywiykwWrLT06ZaV/wtsSR2H63s8jMzEnoMGSKGhzQazaAjA1Xim+qaCjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613585; c=relaxed/simple;
	bh=Pdz+Rm74q6G8VtSxm2JdL+hv7jvfYOV6ZBN5G2eLrbM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fgwIMu4sHjF9hUFLeEGsGLzSpLn0wmGZUVgm4vtjcYI7lglBi7kVBzxE9T0BlS5UII3DZaAI38XyN6V/XO9/rb/M7fcS9K0/okh8q+JAh90m/c123/c3az+DJxTzuVclo5sq4wlj2UdqdUXkMMjl+tfCOycHJVtz88w2kdjcPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOF26SUG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOF26SUG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476964b2c1dso64741741cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743613582; x=1744218382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f1/hxpqDxfWx9PJk8bJNdk/BrButfFHJO8dyLgKtbIo=;
        b=eOF26SUG0r1lO3W+mmOVcIgCYPF4aLcHWlTPwCSw/6HDgP7sphWjVigr7UuGL7dB0o
         7ZJ4Ge3aD8arOsouwSi40K3RWKo7PNDsQg4IGPq2vac8GWeqm5aAF59I6lWFKF1rLWsV
         7wOKrBBFsiN1xmkbx0KzsNOurgvQNNL/JAu+u7vwiPBpfe4/CZ/kyKHKd3s5MCMVKVwQ
         A/myQBNO3EE32RdTFqNuDembm0fV0EZmX+1NlRVSNtHs9jBkPjAodqT7sXh9SrB9AT7r
         hr/ucxRFgTOr/q483QYUl2uy4tewa+cK2wOXqwE6OlGJsmt+2uRVZMKI3zV5oNyPDp2D
         3QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743613582; x=1744218382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1/hxpqDxfWx9PJk8bJNdk/BrButfFHJO8dyLgKtbIo=;
        b=VEBN/VawDt89Aeo0EVv3Y8LokRwpDjGXPNrYndOJEvxporiWxgEYGUBdzSnjhDAREM
         yWk7joqW8yxu0NeL3QbJpMWhjtsCGlO92yAOtcGbBl2H4rRDJLo76f6I0lFtTR8k0/Pb
         2QGDwcs2Vr7iN8mMxw7Gi6Mevv05wxLGILEtmQtvv4bKcw2jQpMEpM96jXa+4WzAtWwt
         LeQIVhYGVSufQ66R6hcuMBY6fGmBqeN3W3XWu3FpiqBMBG3YWWdAqDlf4q2U4NDc+6E6
         eKu3/0tc2rHtnm1v5crEIqIzCpIOL56Jur2Iy6qV8f8+K/L9zeRMdAHTgkDyEsfkilm0
         nu/w==
X-Gm-Message-State: AOJu0YyjfVd6Bb8Jm5M++XR9KPHx7Mhl22HDl3tmrPcHFv9QVcQ0EoF9
	Bf4+F77Ev75Lwgr0zFIFaDvlE1ekp5Ke5qZHBpABgqYzqtlg9o3DVMKRyQ==
X-Gm-Gg: ASbGncutNOubIFoaRvF6CQHwEbxnR/zTuNPplLPKu8Zwo+cOlAe0fiVTVtFOjz3eO2Q
	NwtYA/hcPSoP7m/6u/lCS9fQkD+cYFsVmohbmR9yDX6yGKAIfaalie5o+YJC50GE182th2+/vTg
	tDJzp06J7GIeG801AkAMR/Lb8wKbcJosIotvmNI/hPBjAtedyfcOdNMCFUj0X4AWdVUUmtXg1pL
	DxnrIDtEJPaUpflRVv7EIrI9y1/SFQB1FgKmnj5RMCu3D8gZpXc/JHlsdOe0sU0M5L7CcV1BJzO
	qkzJfz/33qbW3Au/pChqhHyJR8JZPhLjniWW0/KZVpL2yyy3vnQA3g==
X-Google-Smtp-Source: AGHT+IHr/A80PHmsp+oUjd6EAWzn77M3Jk43HZq3rxnsTVkD7ehPFYs3iImfoEcfeSE86cH3a5GS1Q==
X-Received: by 2002:a05:622a:188c:b0:476:a713:f792 with SMTP id d75a77b69052e-477ed779a89mr293697911cf.49.1743613582295;
        Wed, 02 Apr 2025 10:06:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-477831a37f7sm81478061cf.68.2025.04.02.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:06:21 -0700 (PDT)
Message-ID: <67ed6e8d.c80a0220.3d033f.b4dc@mx.google.com>
Date: Wed, 02 Apr 2025 10:06:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4884560110772066134=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: Introduce HCI Driver Packet
In-Reply-To: <20250402162737.3271704-1-chharry@google.com>
References: <20250402162737.3271704-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4884560110772066134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949380

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      24.34 seconds
CheckAllWarning               PASS      26.42 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      23.85 seconds
TestRunnerSetup               PASS      426.60 seconds
TestRunner_l2cap-tester       PASS      20.75 seconds
TestRunner_iso-tester         PASS      30.34 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      120.68 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      12.52 seconds
TestRunner_ioctl-tester       PASS      8.11 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      7.36 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.141 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4884560110772066134==--
