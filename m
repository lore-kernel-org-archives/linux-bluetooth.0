Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556221CC56
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584028; cv=none; b=UE1GkkFqf0EQHQVp75KijiRgr3+YpKP3ZlRuTqmmT//nzZowvbGVbvNfVUqEZT/T5FNbbBmlAsLELx2ST8m6bpb6Fy4Zn5JmXfvIG57lLqwENW2W+yyo/nuqharv4rNqZ9IqD9/aKb26vaoIbq8Q9D4Bc/JP9NpeY38Rmb+9smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584028; c=relaxed/simple;
	bh=r5Jh/pIgLR5J3Ba2M/UTjskthlu/V+SGgUhACdG5v00=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eGTsB6JgnFzKHfdKocEcYRjl7bfMvS/dciS8ipMVwYf1XmQLbk+BeyiLVZ77C78jmqqywMK5FRnKaUqEVi5QXXIZqoLkbGfX8rDqpdKL1y1IZ4mXcdSM1FYvUXWzuAWbKRTnMfxhM0eu+YxoVtQen2S0FnsHVS+vimFJaYa/3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+dgfaHo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+dgfaHo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be6fdeee35so1314957185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584025; x=1741188825; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bSLKnw6s3CcfYEcoeR1sLc7J+UgHPkqmDhVmcInuvOs=;
        b=O+dgfaHoEajMxSvyvWge2lyefhoVx9Q27g1HnIAyl56JszHGh2GsXE8Bby3l/Qzbfe
         ekifF4JuQ/F/DoFdYoRPzrLdy8vAE3gofz4FNmIUxIzFrZ3dlzfOjGO4pJaqgK3Ixyi6
         vYOzn9rv75bBnpyJMLJgxApQGG94pLgpty/4f3LsywgKGU8sn02uOiiK1k+YKejFE1tS
         uLSSr4PPKM5uU2EYrjMCiTzWttqlOOTLhCv0wgqzm7vSQLsH+R0oQR+EYM+WbjBmgqaY
         ERn/jZ1fOelqIFj6vpwAuQP4PEhwEZp2V5DeoHMXtxf7RmMvzVaO5LypPTCkqGFtxWgg
         zuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584025; x=1741188825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSLKnw6s3CcfYEcoeR1sLc7J+UgHPkqmDhVmcInuvOs=;
        b=cgBtroG3+vLMmItHIRTWUNV9qGegrDYGdHE0sH/MBmn2flgvx6C949A7i35SlArQLo
         zx0sW0cPmLXNOteGhBJWn1KpAqMlhBnSRDWUSDwyB0jdtwiqAOZamHWxLbJ7mcrQZKXd
         4G8ELUmIphZvoSD9k9uGKHVLHjwn8ZyteYB/2S3VOkcQfVQ9ufYsIqtxCR8is5+OJG6C
         jGBMRDyI9q8YQXCXzWAXbu4vYd+Lt6NLFlTH5t5JKdd3XOY9eEpfyfdd0xvk2emowEJh
         Mg7XKihe/5vHQh4B7uQWRMIqNyC2TrqaVBjOhCXibpsaq9nPxaoqf7dPMZH5yzjOQ9Qy
         nCOg==
X-Gm-Message-State: AOJu0Yw5soyFuhy7VtsJSw6rz0+8vi545TUwOleNYfUtHwvt+rKdPBTq
	4Y3OvzgANfekJf9pfqG58Y29up8AwL4tkLXdiNz+MgUclMJCUj4HjEkDAUvH
X-Gm-Gg: ASbGncunUCA+Oj0iIBEArq1+o5iAjPsAx0Y5jzZLzdP12Mc+tJMRKJq1phC5PSXznvF
	oicf8+/ePFxgbsVlKB53qd2vYLFwI/RTFL5uwQR65NeQcvagM/aQt89sldll3ExzUTjIPhlPxSl
	7Wc0VEZBirZO/c/KUqKkQsmNHn0fg2NPBzJKJhxsYPVyMBen7xXVMS9TxbjBuj54m0ogjhSu9pp
	5AZFAI5PhO01uBxWuuuw/WOlND6IZ9sfk246PXNgumBvP23no6Xx8h+MNq/t9QNKj/SM9/RvVLd
	p9qIdT04V2CcAGkxVSlFpHaSAGlEnA==
X-Google-Smtp-Source: AGHT+IF+jV/xhur4SLYRXjkAmLfYiNXRwij8aie6BO6IKWj2rUtQbRACR20gz4czvLro/lsEUotOUw==
X-Received: by 2002:a05:620a:290b:b0:7c0:a216:404e with SMTP id af79cd13be357-7c23c049577mr1239195085a.56.1740584025407;
        Wed, 26 Feb 2025 07:33:45 -0800 (PST)
Received: from [172.17.0.2] ([20.49.13.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c3272eesm255639185a.84.2025.02.26.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:33:45 -0800 (PST)
Message-ID: <67bf3459.050a0220.93a75.ae27@mx.google.com>
Date: Wed, 26 Feb 2025 07:33:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6309674659082673237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@linaro.org
Subject: RE: Bluetooth: btnxpuart: Fix baudrate reset on remove
In-Reply-To: <20250226151340.1017790-1-loic.poulain@linaro.org>
References: <20250226151340.1017790-1-loic.poulain@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6309674659082673237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938098

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.33 seconds
CheckAllWarning               PASS      26.82 seconds
CheckSparse                   PASS      30.28 seconds
BuildKernel32                 PASS      24.12 seconds
TestRunnerSetup               PASS      430.20 seconds
TestRunner_l2cap-tester       PASS      21.45 seconds
TestRunner_iso-tester         PASS      30.40 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      123.70 seconds
TestRunner_rfcomm-tester      PASS      7.96 seconds
TestRunner_sco-tester         PASS      9.64 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        FAIL      6.37 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.214 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.198 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.183 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.115 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6309674659082673237==--
