Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84419C57C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961741; cv=none; b=aVRu0ag9ccXr+vEm9DAD7nxKXmDO4keu2lSV4p53Jp9W+00nffIa2W5whPMK/ZFB+zCRVhwFPWf94j/utiBJSGYAU3Fqz6j8jmq5fHok53pgRZFyySKessQ8RQP3in2qtfCwq88EmAOrN5zHl0UGGMe4ibXaIN5fh0o5PxaNB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961741; c=relaxed/simple;
	bh=mfg94jWXh39+sZeJ+bSr91MPyWS/GmgSP6daLS83ovs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FBxsSqMpap+0frPgbFTUzVxZsHahyVeCaNA0wZfzgdJY+Hucr/2QA2JgYR0gXXiszkcJWleuvp7zT0EHtpn3p/zUuCZFjs7s2qHMHtEuEQwKkadnu2vq3dJ4FnWPol3VV6OtqzoqsM2pTKHH4rs0gVklftRedA/MwXDShFf2cRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYgAO3Nk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYgAO3Nk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6022c2c3so10428605ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738961739; x=1739566539; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=brJSW3GzAL5rx1jwcbs9FG4hzQtTUVUaKVCQ4/xjEVc=;
        b=hYgAO3NkVjsqW/lBlY7Iv7oIBFha9WAcHsA/z1g2cD+ZnluOGDJyiI9qjY5KDgYmmW
         AxuqpLQd17ukEkQ3qPgQVQHSDx1Nw18sBVDYI7DE+N/ZQaTOAO8R6Q6MwZGLBq4jpXJ9
         r7/pYbTVbxBzGo2y3nqpiv9x67oxcQR5HVfBQya4i8hiEK+cycIjieQQdF1eXNYhQg4E
         q5sx+Xc71Ty0a6ybtWV9AbHrn7kq/y6bNvJoJhRZHP0GXy/dowh7rJNaUuXdy9PZ5VKb
         6ASwPq1/gOvzm6XCYl3g5pQ1nox8nKyRdCElkSem+Ggaxlwv8cRmsFh8N7R2wFTxMJFX
         fpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738961739; x=1739566539;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brJSW3GzAL5rx1jwcbs9FG4hzQtTUVUaKVCQ4/xjEVc=;
        b=Em15gh34yn3uem4+IKiAnZ8rRsAFscqfRdl82UyM+HMaqzmKz2nZA+hRxVB7MILThI
         Wyx+aC8++ESLqNGDOA1EqDMkGS2nPZGzR2GDZt1tLIW7FCu0/2IkIlPxBSGtm1Jy6Pte
         p5nSs+umKA1h79V5k94qsWrn3Ybn0EcsAimHdhi8c6vtR0Z2C1RVCaIlwXv3fBn8Ju+L
         47mfB1Za1jo6FFaUfQwUVBLYu5EynLds3926e/YZxi4FM2kpiSXqta5w6BdykNZ6GXKI
         D9LDMbO1jOvUbgncjPRa+yV8I46Obez/6C09YuV/49wioTNefHA9kSlhHmFFJw5Vk0/S
         xoyw==
X-Gm-Message-State: AOJu0YzOPfcb6qeYPAB0Y47WF3rz6jTkaktNDQug9bRDynFPsmP3IqX4
	9d5PiTx+AChkBTvt4+l1QE6chVKmJ+EWsHlu/+V5ZMFDC1lMQvHJP0x0Lg==
X-Gm-Gg: ASbGncsheRTuW+z46oQoNFKsppkyZ6mgQtpNOgxE2TFQr3+pDXWu9zplVToH5pfByaI
	2Wh2/fJPmBf2EtPfQ6X7hcs9Pf8JzCkxO4p5qc3prVsa4TAlsWdh8yktPr308hjvh4cV5VsqKnj
	SJVYl/hO6JCx5UJcR80AlZO/v5H5/vsPxnRjORf8+4cBKIt+P97TMQOeOjbZpDnaDFBlNywKbys
	Vv8BNXED8/dED6eM90rNn6Z9MYLg8ZJzBR9mgdEeLEnGOEwy/5nce17xKFZxMyCbDaR/8Zqf0Le
	30vuaiBVsWnlgNVDJtyG
X-Google-Smtp-Source: AGHT+IGWIZdpFlHrhreUTpWzpEGoY4sa6irYH/h3ey4zt5jCylWQ+VpnDOebb8q542KV2jxKeIDzcQ==
X-Received: by 2002:a05:6a20:158f:b0:1e1:b878:de64 with SMTP id adf61e73a8af0-1edf3581413mr14989086637.6.1738961739087;
        Fri, 07 Feb 2025 12:55:39 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51bd32b48sm3443441a12.35.2025.02.07.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:55:38 -0800 (PST)
Message-ID: <67a6734a.630a0220.87017.e68a@mx.google.com>
Date: Fri, 07 Feb 2025 12:55:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5429218163125263365=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
In-Reply-To: <20250207201727.3449504-1-luiz.dentz@gmail.com>
References: <20250207201727.3449504-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5429218163125263365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931745

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   PASS      30.55 seconds
BuildKernel32                 PASS      24.86 seconds
TestRunnerSetup               PASS      435.07 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         PASS      36.07 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      128.93 seconds
TestRunner_rfcomm-tester      PASS      11.33 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.173 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5429218163125263365==--
