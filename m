Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2B7081E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243770; cv=none; b=sX1tMiVkjioi0RDsE1wiAEDWzVa3+ja6zYL8G0fh1yzw4E2rQuxsHdY7BRdz+/cRrxUKiHbLweDR1+eWswpvH9fJkMPnznKAwa15d088W9LcZE+HhM0j59zLmJGD5+iZX/y9A5c/177dB7v5A+cUyXcS/psV1iwWjS/St+gq5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243770; c=relaxed/simple;
	bh=RbQPwZdvpAEeciNFXn9MrE2dOFaLLQp0JrhCAAvv1wY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cTvRgR4NuJco+eV7c8248hX/MUnZ5Fhokw7ac70fyBFHsNPd6puaOuaBaAlFw7gk08Zj1oT1OpjQ0SGkvJylL/W4Q2iAhHwprnpZDZdtodccSdyhtcPAf5XPNLQHy3gKnXr5Xh/wI0G39JHng/RPEvc/9hpasI2sAmvJ7pl9M+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9iRfcI8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9iRfcI8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a6ecaa54so112283921cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 01:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736243765; x=1736848565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1RjUn/pVxNwdWI6uw/Tyrkc8wnHTKF0k0c/XHOO6ZeA=;
        b=l9iRfcI8XhFDXNI/Z79TLMb/dMtsOfNU3wMwK59Yv2zyd5hccets5Y0UH4PWxA3+Bt
         7Btw4NoEGvt3VF1Y3MxDU9jKkpijBDdYDT+VIca3RuzexL39Ps3vBZAtAYpsiuADH9Iz
         PmQMm9MBTkVkIpedTm54OchKbTnz8LLjpBGZBkQgsxXxSF/ztEDobWh5fFN7cQ3IJPMI
         hSORrIkkuRkt8NMaprkVGebuq/1fqWWrGCl5QS+LrEO0hz2vvxKm2tZy8VnHlZjipCuE
         LdXwDcFCogVLSeHhiOYxU3ES3DeDN1SJcjVxZb/sEUFserNIZLVmcRVe9A6XxX4mbxUR
         39mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736243765; x=1736848565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RjUn/pVxNwdWI6uw/Tyrkc8wnHTKF0k0c/XHOO6ZeA=;
        b=hXDSc3tVXOW2VNsQQ4gb0CGU0KqhspqwgsFvNyMeg6LaWUJnnGdr6NleQ32rF+gV27
         QxQk6lpUoOtZVWS18+7FY4/Ccmoxyq+Zy527oRrRIOcRYzxmh5YfqAmNuRe7xB72UfrM
         C27hH3oy3kNMQvJMeuGi979xQOlMC0ixQrg4VNPkN46oPvfs7iwnVMeeq3c0++1MiRmV
         gwtjV0B7BZa3z4m9mN9o9F8VWrUyyN9K1EJMv4TUPoDvBk4SygQkX7LbTI4BYWW85jLT
         IpT2QHy3rAxtzqqUF57ifU8t1s8gqw54/2EN+u/fer0OkGrteFdmuGGaePo1xrghWeUG
         MRnw==
X-Gm-Message-State: AOJu0YxflAgikT24C7WzAAyAl0TAJDxv3Ksw/QLbh5KaGD6r+dqcUxJm
	Lq3xP0W039p94MChKY7xauqNgx19l9qIkXVGKS0d9ddzvQjoHMxY2IzwEQ==
X-Gm-Gg: ASbGnct8jJwUWxm3Ng9klw4JOrhsT49fhh/JEI+fjR2hz3UkiyxHehdP68ICEPzAC1w
	T/HM7kOiWB47MdyzhQZpGPFkg3iI3peB8DG3nabp1Uky/fxvUuOfREC0ro1kI6WIDlpzH9ke+v4
	onRkC5iLMyfB4kGMFiPXg0A8XYqZ8tdKUeJ6Lq+y5VeBrSBEEbfW+tu15yMMtI/Vqe42A5Sjq8/
	m6gxfbjGCLG8Ui82VC7PtQ510woHGotnaQD2qXx+pP5jVCNrvObA+BfEed425g=
X-Google-Smtp-Source: AGHT+IHn5m+jGcYewA5FQKmd86Q+gy2wQ0+YeJVkVLTK5oEa0IF2EXWTcTObj7j7aJenrlMJj1RYMQ==
X-Received: by 2002:a05:622a:245:b0:467:7cda:936d with SMTP id d75a77b69052e-46a4a8e0baamr893755651cf.14.1736243765271;
        Tue, 07 Jan 2025 01:56:05 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d6374sm179251626d6.103.2025.01.07.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:56:04 -0800 (PST)
Message-ID: <677cfa34.050a0220.4339c.92fb@mx.google.com>
Date: Tue, 07 Jan 2025 01:56:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1680403203297501181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Expand firmware-name property to load specific
In-Reply-To: <20250107092650.498154-2-quic_chejiang@quicinc.com>
References: <20250107092650.498154-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1680403203297501181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922834

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      25.76 seconds
CheckAllWarning               PASS      27.54 seconds
CheckSparse                   PASS      31.11 seconds
BuildKernel32                 PASS      24.84 seconds
TestRunnerSetup               PASS      435.99 seconds
TestRunner_l2cap-tester       PASS      22.59 seconds
TestRunner_iso-tester         PASS      36.10 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      121.09 seconds
TestRunner_rfcomm-tester      PASS      7.53 seconds
TestRunner_sco-tester         PASS      9.35 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         FAIL      9.27 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.44 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.183 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 42 at net/bluetooth/hci_conn.c:567 hci_conn_timeout+0x14e/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1680403203297501181==--
