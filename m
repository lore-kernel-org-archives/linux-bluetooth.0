Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B35213E77
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006559; cv=none; b=N/VUcJSO8ql8hxH35P+imZBdRlCq9idylpkz8zWn5JLGM+THEcrtqFG4KX+m9Euuphasp+Qc4AVIQGSEJqxtfsPsBZuYAIHEIj5PJla0PMgNqVlTErGTNhpG0mRrnPHZDezI9ShNXceM82CWuIIrmVjn2v61Hvm6kmmvACeWHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006559; c=relaxed/simple;
	bh=cyvOPfjOpOKPXx8WeJOHl/52MjltljUtJZWa+7SpDSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aqwC5M5HY0glarHeYuoV89mQdgUGCXMQx+ljhIEfWRSwXN9eFifwCvO4y4vHZ5OFvm3Gb4BZHfIyPhL8qqrFe4KkIJVl7YiAVwTbfFfTFEBQ/RkMwAsdTd0dO/CHamD/v6mDQNPOZ583KoLKGgpy65sxqWiA1wNYoVBzgQDWm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxLW4vFd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxLW4vFd"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so1844591b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751006557; x=1751611357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ6z9pxybaU1d+vAs6rR2rG8Uox5YJBV5jDQj2AR0OY=;
        b=GxLW4vFd85iJC7sL67zYzqDteMnBaX3ifmAQTM1tDWOSCIMttjNkFJ/YAW8lmDl38e
         xpwgzqNWJUzQ87XznTvZScOm6MWGh5H38sXxn984aB5g5ZSm7g5JXQcKsoTi1B4P70j6
         LK0nxPed3b5nglqlhloEptMZpC3B37IvFGv2j/hVkK5lTpe5E/aDTZ4B1tF2eC/Q91WY
         vghE00mFDrvpPF/ga8MRzYYe2PLAHjj5eOgG0pVX8cCZ/bMDw2P4BYFDf65/xp0YEPX+
         TUFVwzvmdQ518kyYcJVQI2vaX0QFWa10jxnc63NNRQtrx8Ql/Cm5fOJ/7/OprW0g0a/L
         FLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751006557; x=1751611357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZ6z9pxybaU1d+vAs6rR2rG8Uox5YJBV5jDQj2AR0OY=;
        b=TYxeB2NmWnhw7YxSrilMaIEseY31a9lyEia7wbAO8l3oTGAXPunba6+5sy6sWfE60R
         2tYymdmU+yiqWqecKksc15epY2NVZU03eLtFFVhTLnYOv/mDcIh/Zb/pJo6Em+bfmzYv
         1DxD95ZpkJ7lN+7CEb57mbVychUX90t1fTxD0fzqxjek0n9NrfEYWSJsrbGTWAQfkQFw
         GEex3khC6kpsG1u0oyZ2Xm7m7cmGwWmGBgqxrRZIf0LTrTT83zHQFWA8HSMaJvKmGrqj
         y/EXU3AhD1xYCUg+grEdGXJ++d/3qaQ9R3c+Q25BlOcAT1iVpmb9gIARfuFer0AmwXgR
         amdQ==
X-Gm-Message-State: AOJu0YwkNytYfniAiobq3h1c38WBGgunpM0sLuOOVCN6qPnB54LliOIU
	MOt2qQYaWoUX8KiK5wj1/CXAfxKizP46qT73hgCqGfFs10SIZNAOqnnT6YNWIQ==
X-Gm-Gg: ASbGnctvmv8XCjAKwKvN8SzqTC2kMJ5oS9baRy8iBQ0orAfa54HCzpU0hpsbeaUce1A
	Fq+8mj3eCWebht8jnNdqG+/Dj3ubVT2O8eZaTx03lK9eWnfz5rR4aOX+0ZmhbPMmeGCkyaNAuFk
	j/1urT9pDyCHcVJH/DwqUvfEVBGzcUTsYHriGm96YU5C9IEx8f3S6BGkYpSx68KAzHc+NrK5a9G
	Ng3d9E4q1qkDcYifAEXmrWW95+UMROMlL3fU3+VETP42LFW+Qwean2SRSXrpslW5liOCesBnySo
	XkZXzWZRzfBjKND22bFsFQMgdL//xvxhRZEyQfvFFXUyI+Tclqf4rp9g/tf/plReQ7dipqd5kLS
	HpQ==
X-Google-Smtp-Source: AGHT+IHdmEjGCJ4g3U/lXY5k0fHMjhJyX0TxTpYubACCMGetske0hLvKF5MF3bMrQTchp9tqvsut8Q==
X-Received: by 2002:a05:6a00:b8d:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-74af6f7eb53mr2889287b3a.18.1751006557171;
        Thu, 26 Jun 2025 23:42:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.26.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b394sm1514075b3a.36.2025.06.26.23.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 23:42:36 -0700 (PDT)
Message-ID: <685e3d5c.050a0220.1ffa94.a2c1@mx.google.com>
Date: Thu, 26 Jun 2025 23:42:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5669274609688388834=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v2] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is pulled up by hw
In-Reply-To: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
References: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5669274609688388834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976474

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      25.64 seconds
CheckAllWarning               PASS      28.16 seconds
CheckSparse                   PASS      31.37 seconds
BuildKernel32                 PASS      25.80 seconds
TestRunnerSetup               PASS      478.55 seconds
TestRunner_l2cap-tester       PASS      25.47 seconds
TestRunner_iso-tester         PASS      38.83 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        PASS      134.75 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.123 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5669274609688388834==--
