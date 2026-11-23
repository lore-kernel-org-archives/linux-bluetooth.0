Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435007;
	b=UE8cvlkSwSEvR0CwsfZs+zBJAWYFkETXgbMEp0PIG9wt9G0dTbSYfnQGxA1ZhZsHqyZK
	 3ZPcTQG443pe8+0vdsQ2ChPYk6a5uwb5TMcm6YrpxGEfvKZBuZ8MySLojpogC7ombBMrT
	 f6ALctcgNz9RkPqrvmcXv1ocJztL/RTuuv/ryWrK8wMBdkOLSEO35ma3RdOJJ/qmbYELZ
	 TkHBw8+jXgu1/pGgQfPPpwhk2f0DaNDAtT8UopwHSo9iSr0WQ6I+Kh1sE5eQzVyQuOYpf
	 QjyBMcckEEJaxHkFt2tTwzA9U/rKf/03nEwNhP5hi3K9xR6yCTtR/SLiJC0xlP5RvDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FSs+b1cKqscA0vZdMW/c6HR8JJawqCHw1B02Sw8oEdA=;
	b=Ep5RCwSTS2eFXC/R2D/urJaAlB8pOk99tD/ZphhO5ZMeP8J+iYQlvyrVi1298lbQTIJm
	 WtkYJfLUUs0UHQd9R37MYPc1Fbp1ruydAUAjI4xqttRTpe0H58rySXba1pbJotfLw+avx
	 RY4dVTAM6XtxtoPwZCCvaPM5eR5GNPYumks00tNTFTcUkIiTaltE75uQahg7ofgZ59UyN
	 C77scQKs0VgJCYmWIF9Z/tIEH6EmDlR70TLfuu67XVfJBMdzcwQEDWr9e1MqILkmAtu8Q
	 4IouKuHEGxK5ib7aEEmVKhVDs2M1cVYLu8jvikE3el9xTrmg6WqXTl4u8z3hW3n/61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kVwmiOla;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kVwmiOla
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso1234432a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 03:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435006; x=1796039806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FSs+b1cKqscA0vZdMW/c6HR8JJawqCHw1B02Sw8oEdA=;
        b=kVwmiOlaqnqNB1qMmB0eVaM2GETbPEUobJk9iMghsGhs6ScBMTIMkQryaqZhwoNnFA
         WrSHx6+dbbxoTHXY7fmxG5AnJNxVEPXRh6ctvoqoBwyGQ2gd4XZfQWi50cRBBLs5KmkG
         WJkg8fMRsEMGTgh60sh+tG/lCzAaCrwy9l0V3IQVwD/oN6nujKe+7XLxV+vIQZv/3C9u
         oJr/0cGUO63sumb1O4dpu/3bae73E7oWAmBYvehOypBPUxoVgmOHdWo2ASE/m+DUh21F
         RkPmuISIwHogNqxKDRrEDoD6uc81eQLR2Pl2B+Pfg7JjbpxHSsyXlDORW+qPP1LT/QSs
         W9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435006; x=1796039806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FSs+b1cKqscA0vZdMW/c6HR8JJawqCHw1B02Sw8oEdA=;
        b=TA46i6RcpKbQqniDwD84pmPVYCo86jk2ZKswANCaaN1FwHIk9wW5KXFjozGbPxmm0n
         XCBUHJUSXLSFiJjhdq9XyliPNqQ8TenTxkXuUFR8Ms/dzEZqN7mBhdatBbsf9k4KMM1C
         MfuaEy1/s7P7yxZKOGoy3raLEjsCLaa+XKvGTa7C6qiNU2zmyF7kusWyYyKEAQqveZXo
         7/waIAMDWDKm0B59XvI5lkyvr5JdqGyZ43M86uajnTMRRJ6huJ4ADLDDb7J1P9g4okVS
         t5nQt0w4rZLlH4zQH53KfY2K0o54+v+V76Ly6rb0bQY57jdjLwY2Lft5J7Y3zcStBtkZ
         ClHw==
X-Gm-Message-State: APuU4Z9tYiJd7oQDFJRr+w/4NJomfHmeZEZiu++V37x5X64s/8xgcVkA
	uH6fBd3ysZkJ8MEuF9q8lWLHoXd44mV8SaXC7KRTb2NYKWLlQuCo5xbPN0uEjjeW
X-Gm-Gg: AZFdTZeLEqeIekf3ae9nWwc/32Fef4/cQFiYFQY7+12wiRJMPyCBccd5KahuQjvDzW2
	ZFUQ5D71TDNbKB6UNP34lN6R7r74DUlMgc9VXtzwC6fzb6urpoYsgjWBvCQJxXUckBqgbfpbg2G
	LoIkto4UM6whhR8pbs38LAu+USMLAjXO/UJtTlb5Yb1zPruNE6YJm6uAPPPh0GHdtd1JPXgO3V0
	OjPupNV4mCF8lwLs5CQOfwRI8zazea0b+vKHv/pacsGVa5Sg5Nh/HAFectHbNindOXssniM3tkI
	qTez1SqEslzmdj1ew5YTung4FVR8xGAZ7fhTh7wZ2VX5OQKFaqLq9wmhxhlAi2yYlbbL+T5/tSI
	51p/IiYwwadQPalH2U7gWKGx/wHbhM7qDM/RUNBW8bgl8lt2AEqb7WGoB2hMatlXA5pyRFFmsSe
	kDm0F+MxK9JwfwGCTv8W2RcjX2m4QjPK45HAXKuzQWp34oyl0RLYF2sqgss6ZjijxTmKCgvH52D
	42WIldBGw1mZcmOEVm2mpJPm6IYylLtbFApG++yEcK80BE0Rz9dRiSTQUy8kykfOFlRfbCeHjrX
	xpQHdGazxdyhz8AHf27KA7xY2OkazgZ9rwaYOkbj
X-Received: by 2002:a17:90b:384d:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b41cb0c67emr9256429a91.50.1795435006280;
        Mon, 23 Nov 2026 03:56:46 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-122.us-west-2.compute.amazonaws.com. [3.42.157.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm17903052a91.9.2026.11.23.03.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:56:45 -0800 (PST)
Message-ID: <6b0429fd.7a0cdab6.115df1.42c6@mx.google.com>
Date: Mon, 23 Nov 2026 03:56:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8833842834347127085=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt"
In-Reply-To: <20261123065523.2769017-1-kiran.k@intel.com>
References: <20261123065523.2769017-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8833842834347127085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219220/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       FAIL      0.45 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      20.46 seconds
CheckAllWarning               PASS      23.11 seconds
CheckSparse                   PASS      24.40 seconds
BuildKernel32                 PASS      20.41 seconds
CheckKernelLLVM               PASS      22.32 seconds
TestRunnerSetup               PASS      476.71 seconds
IncrementalBuild              PASS      20.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt"
WARNING: Non-standard signature: Assisted-by:
#115: 
Assisted-by: Copilot:claude-sonnet-5.5

ERROR: Unrecognized email address: 'Copilot:claude-sonnet-5.5'
#115: 
Assisted-by: Copilot:claude-sonnet-5.5

total: 1 errors, 1 warnings, 109 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15011639.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,2/3] Bluetooth: btintel_pcie: Serialize doorbell writes and target reads
WARNING: Non-standard signature: Assisted-by:
#116: 
Assisted-by: Copilot:claude-sonnet-5.5

ERROR: Unrecognized email address: 'Copilot:claude-sonnet-5.5'
#116: 
Assisted-by: Copilot:claude-sonnet-5.5

total: 1 errors, 1 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15011640.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,3/3] Bluetooth: btintel_pcie: Serialize MAC access requests
WARNING: Non-standard signature: Assisted-by:
#111: 
Assisted-by: Copilot:claude-sonnet-5.5

ERROR: Unrecognized email address: 'Copilot:claude-sonnet-5.5'
#111: 
Assisted-by: Copilot:claude-sonnet-5.5

total: 1 errors, 1 warnings, 80 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15011641.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt"

1: T1 Title exceeds max length (89>80): "[v1,1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt""


https://github.com/bluez/bluetooth-next/pull/1201

---
Regards,
Linux Bluetooth


--===============8833842834347127085==--
