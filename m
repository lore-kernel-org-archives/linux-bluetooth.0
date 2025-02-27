Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D41CEAA3
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693279; cv=none; b=Vjh2A0WwSxwMWnUEMoYhtvaYGQHvYecxFfYPGWSEdQshAmpyds4S4CWfRY/0gsQ2PvcgEBWzAmbhlTB6uuWrlS2um4t8SNpuhGxgXlLlqHdXvuPnqnnMMWQAFwiDFjFm8jq+ujiCU0T+BipoLAZLoSozbvUj3N6fZtZ/MZdhxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693279; c=relaxed/simple;
	bh=vnDoe+RiU+YcqZdy7fzMD44Rw92cZ1pz65L6Tziyfec=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k9s2qW4ijzNHbyg2ndiySk4c+MrOmUo19N0LA5/cp7OZSROkVvJA0JhwOccDD6DVxaxsHbpXZMOW1A4l1VmbvXdI/mJaoAWVARi+YRtz8E6uH9pnp4J9ijce8v/bjUp+aIwyV0B6MfvCmK2w2/ykueTfftS7Jatd71Xuw+A9pyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKJ/24Re; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJ/24Re"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349bb8605so30695885ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 13:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693277; x=1741298077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ikWgGAKmkrbyw/ONuhk48dRcQIZd+nRGNmIAf1MI0Ek=;
        b=lKJ/24Rebv/kcqx4BkrHWGirqTVl2TPpNN9byp/X1hlpmw3Z5Bbaz805CaFD3EvtJb
         v5RMLMYBVKDB/QxQA+sSF/qR5hI+9y8jGl/Z4QJtiQv4Nq8S7FfJfbnSi8l8jbT6V5Sf
         otJNahuLiCWFmB79bw8h9UQV6CaIgZc0CSt4yLeiC0ubhGRepFW9Q33BdLKmvYSCRt65
         5JHDmapwQbfioB7E9aZ7bOfqP+AGU7jSzM0JZSuzYbUHzMDSiutIWDmuMaPxQT/ykG5C
         02zfnjqlB5sx1EpYyt4/MirpBtwl2noLp2/1nOc7bFBEByw584foDyIXr9rVdCl3Tx2g
         BOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693277; x=1741298077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikWgGAKmkrbyw/ONuhk48dRcQIZd+nRGNmIAf1MI0Ek=;
        b=qJWl+EFayg97TrVoe0qT9mL2+Wv4cM2stxhqCvKmP390yAm6CmDPoForhYBT29jIoj
         LKDxxHhiFpBtWV8s6PRgcUBeTzFdOnAw+fLM+M/Y8wgKcUo05nQPTBGWp2nW/MD2pRHp
         GT7xC7JJxXqZki94OynfizkYf4UMTTogWr37+MDIN/JVNsNWpHmRHYbPsxx81wulQAdm
         YfaSDy4bSxikkJSJw01+sNWkLQR//uTv5lUGgUT4KjM498Tqr0DqCI6HN4CFVmFQpQZp
         NnEaFZZ1G3Wqgt3hEYyV7fAnPFRilBfr7ifDk+D2kVAdQeh5RLtLB5hJ+uiqdozkboSC
         fvVw==
X-Gm-Message-State: AOJu0YwEAmhVI+jV9kAWxeKwkt5b1bUAKLDLMHJm1M3Aec0EUw6w1XID
	8x8Hc1njhk1kXuRo7jPc4Hb541WYimgUcPXF09wFispmNXhkAbQLzSapaw==
X-Gm-Gg: ASbGnctXlVoAP7xsrUgrJ8fYAYdhU5L5ci/DAv5nefsh/+Z16GJVKv0X3dc6GX7KK5y
	8PzyCRS5kTUOCzE5t1QMNRPb9E2h+8ATGd9vPa4SMefS1/uKMTV3KFC1rB7rSxbIb1AUW7vVbrv
	0rfw3WpMPI96WsB8Q7zQCqB8bi1OsMekfvHWhscryrB352yfhdQ/QP0M0CgtmwHPb2hyJ3jKad+
	Jy8/bv2pDVH4p0d3Orx37AgFZ7Ye9strVticASUD8uENDmWmG2VYIPpEhhn1K/tpkXgRiIbVLA+
	kb9ZAZ46mBEv5TF1/PFcOga1R1ZeKA==
X-Google-Smtp-Source: AGHT+IFOFYvd4Pm2geJ451n8jPncWUB0Us5sNtPpxaYQ94fbYcYqRujShpu+BaKtDfplFwTup7ABSQ==
X-Received: by 2002:a17:902:f90b:b0:223:58ff:bfe7 with SMTP id d9443c01a7336-22368f61b94mr7494365ad.8.1740693277060;
        Thu, 27 Feb 2025 13:54:37 -0800 (PST)
Received: from [172.17.0.2] ([20.172.7.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235053b0cfsm20128635ad.254.2025.02.27.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:54:36 -0800 (PST)
Message-ID: <67c0df1c.170a0220.8db99.28c8@mx.google.com>
Date: Thu, 27 Feb 2025 13:54:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6332925271701993308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
In-Reply-To: <24279b4ca58e92b96fbe8f8214bf95d485ab73f5.1740691671.git.pav@iki.fi>
References: <24279b4ca58e92b96fbe8f8214bf95d485ab73f5.1740691671.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6332925271701993308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938698

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.23 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   WARNING   29.87 seconds
BuildKernel32                 PASS      23.71 seconds
TestRunnerSetup               PASS      427.13 seconds
TestRunner_l2cap-tester       PASS      22.76 seconds
TestRunner_iso-tester         PASS      29.58 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      122.49 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      11.54 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.159 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6332925271701993308==--
