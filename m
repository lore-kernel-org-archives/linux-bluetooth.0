Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF91D516F
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045174; cv=none; b=VL8CIh5w6yZ86qaEJCqnHXd5QLX4DmcwjQNFd5to4d7RKfnMMersgmUriyh2fFtsMCll56XY5l484r5HNGW2VHGRqcsvTqyqDtMU9QoNy8TdkKkeelamj1vPLpr4qkQYbVnFbNdPcfQndG99srPD8zjBbantmqLG1C3BNQXV9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045174; c=relaxed/simple;
	bh=awID3vQ5nNV5vvjb1Zb02WVw7oZ8zo8kx6xthaH7hLk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IcmfFLlZUnX9u4Y94GFzgtdOHP/JWuDxwaSs262y887NfnWPuv0DLxCdihH64Ocz/xNAA8uT4Z0vABHbUX5Cl77i6iDt2zYOW9VEhTvdznvyT2fIvkURH71s2d+TqalGd5Z6jYqQ5r/7B0SYSk9iwvByz1qEwnpMMajrLRSbu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHFN4drM; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHFN4drM"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a585dc5f4aso66391221cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752045171; x=1752649971; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s6oLMIT137j0ScxnutlsJ/hgIIYvdxexT/RxBVoYE2E=;
        b=FHFN4drMWtdeQbCobbDFTCmPlRismIXAdOy6fzcHyd9resWy+UbetB0UVUnbFy40mW
         KmIWaMG37TlgQZ9mw2nR5AUQk/43vZl0SPY7actM//FFDq43vGApqrAZDiI3V+XrQ6M6
         7b4LYGKjVn3aVUe4uQv1e0htO8fHFPqenOEopJkpjo23ZLCvEq21jY3h5FIqM3sQjid1
         DxZChXe20ySH2+fYul+WiIFJlE2WICx2taOXRr5CkkL805uAgVNwtiCKKKP9CC4zhxh1
         T4fMOCeRX/DIQZ4Q+6D00dcIyJaC8MXeu3O1EDM5z1hhuWu97BOSGkjVdgJulzN8Zk9W
         Al2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752045171; x=1752649971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6oLMIT137j0ScxnutlsJ/hgIIYvdxexT/RxBVoYE2E=;
        b=UQ0wgF//nec2BPik+NiE8ulxJa0mo5C5aDh0K87PhSIhUujOFbWLUm7KMNMe/iua5/
         3U1MN/hnuJCu0COhe06fSUEXmto8T00cyLd0F/+O0crCKYVWxY0Hp9MUh9YY3+yWiXOx
         /jCsJH72uvUjG1Nm+oyba0iXG+0RHLOA31Jb/NsaJBSmAKXgskd3FC3IqU5e9AI8Iazu
         LqYNJdHT55jINwupbCiwDGh/E6qcegnwLlIlMqtam9H0fCyx3GpM8b2YQVc5rZ9o8JGk
         4CwoBR1x4ipuqgSrmQvk7FdQe0U2PadjNWZclRA8jfUoWLLzR4y5nDNZ5S6v9aD20N/a
         iJ1w==
X-Gm-Message-State: AOJu0Yw7Eyp2MVWAZKXpSrXvzMJTmK5DP6Qkhtsft3nKsgnpLlxjYTNP
	flcDdpfAhGr6UpcCm84QsX+NjawhLCxAvxBihebHRw+LhNk9rU9OINswUm3EdNit
X-Gm-Gg: ASbGncv/9MWbo+08UnnEOg5lgFzlIXvDBPlwksg5cUZLnzwzC7v+4s8Hfad6ZFbhprZ
	fHvoXpI4Tb9p9k8GeSJDOXzP6At602/Nuc0x7+uDBKijUl5pDNd1wvjEVajGnguWBFg3JM7fGrm
	6Ic5amHcPT18Ei4+upRTSpPu8u+TMIdCYpmGwZo8FHFx2Xx9iYfLijrfJe1wrkdgm4a0LIOMk5H
	++Wrj5gzyFoaS2MwtQIJSrVjaa7AH6ryj8T2Gak4yV5I1DDevxerQ99MJ2kaX3IgtuLAxrf7tJQ
	U4zvBZ01wszeGoZwo5Us3eAZ88tl6z0ALCEle+evdleqUUzZV+oMTUpciPWjulvXNHg=
X-Google-Smtp-Source: AGHT+IHaEPjcpx+gXxmrn3w2XtgRLNWg9L3uxatyrAO3ynSo/5oLJUehYnzxxWXTuz4vjY+S+7wlJw==
X-Received: by 2002:a05:622a:1825:b0:4a6:ef86:19a1 with SMTP id d75a77b69052e-4a9dec56a61mr23749451cf.16.1752045171253;
        Wed, 09 Jul 2025 00:12:51 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.31.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a995841539sm89399791cf.53.2025.07.09.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 00:12:50 -0700 (PDT)
Message-ID: <686e1672.050a0220.5cbf9.1603@mx.google.com>
Date: Wed, 09 Jul 2025 00:12:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0817335268204055974=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: [RESEND] Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925
In-Reply-To: <20250709063606.25806-1-en-wei.wu@canonical.com>
References: <20250709063606.25806-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0817335268204055974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980340

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.69 seconds
CheckAllWarning               PASS      26.98 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      27.56 seconds
TestRunnerSetup               PASS      487.32 seconds
TestRunner_l2cap-tester       PASS      25.69 seconds
TestRunner_iso-tester         PASS      37.44 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      134.87 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   0.79 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.168 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.282 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.991 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0817335268204055974==--
