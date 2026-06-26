Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C48380FFD
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481073; cv=none; b=HuHnURTV9vGTsLnzVl83bMEoTudkL5ZzKQ8N9reqAeIyphA8jUFii0EEpgxA1H5jb1zKU2ichMI3zS5URYE0OxsTIfmymgCq1wWfw9YYgZRpcEbgr6uzCM2+GmIGS94IeI/5C/f1Bn0tapkcVt25CLrxXgGb0ckufgbk6Q8lw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481073; c=relaxed/simple;
	bh=vrrY+S49Ij/gcqrhrcLs3puQNE5NecgYbCUz7YFM7dA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c1g6wewLaH8qZN8LF7h2UmK5NWP7xHfsPO+y7Ud6IPWIrtCtcfMdbK8VBA63V4QEWMjDsTdm3Ey8YroEIlWnrcKE5EgPU+vWJgEwkgyF8G9o/MtsACyzjkERlK38EOkF8CEz8sFQVtZW5q5oIiDBmQVDUovDkCA89rSMcUNNKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvnmUSKr; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvnmUSKr"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8dea42b54dfso10193316d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481071; x=1783085871; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rOTxef2MJt/CYczeD/CHrsdIFgYY7obU2DY6TKRbeAk=;
        b=IvnmUSKrlCc5L+Fd9plsKJtVwlr+ZQmoBSv28TM3Tgq9Ait2vX3j4+1zsPI9roObpS
         BGuf6KoGhrDgBXe17W4lUeCYSqJKyfgVunD4QUxNgYX37kTafVZ7RkcUV5ui3GDqWTu0
         q9M3T3a+7JdvZBCS85ddDiknitPZAgw2PgRdck0UFvzxeCR1dw9QsE1tFuHuE1MqTpbP
         frpIdxeQo/9lGuIpVAxPMLo3R/20RO7wwlsK0QSbEQMszc5hM/y4m5F4E8OuJdd/andq
         +ZU54shtv3DE/ZruHoZyyre2kDpA51JoIJ9AmyFgedm5ZxH5T0VzAUYu5apq8sohcX6/
         W/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481071; x=1783085871;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOTxef2MJt/CYczeD/CHrsdIFgYY7obU2DY6TKRbeAk=;
        b=PBrFKne32Ab8UFpmPqS1GFLFj9eaKDUUJ8m5iR4XVH4y7EYlRFkwzQacgt7yMQ7clK
         vtwK8YKMMIGZOVIkgWrhfF4EqUDyF07i0sFz4s9DNNN8bSM1A1vElipRHIXVFiTat/ti
         IKeDIsBGtO/mW1F+l7p5nHqMvHhEdj7tNvw5g35ddFupa/ip2Ow5L5899xFxhTImsvtF
         AwXkxnJDQ2qV1ZGaLs5EEaBEJkaVga82Hu27YL4qNm2j2nsANSulTIyNQhVFFYqnyB3g
         gSbHFBoPF7bQyqB1w3K4fHmbGDPqU6hwWmBqQqST/QMuC6aOP7bhTh1SYfH6my/GZRIb
         xwLQ==
X-Gm-Message-State: AOJu0YzUnzqKtCQ0T1Es+lysfY6EoAsA6nNE/LfbULGV5l9NQhqI4+O4
	GVnltaEwHScSSAbwB0NeV3yHOfTfwiHbI4qSBNukFSn+5O8YkhC5eTvRtTbJGA==
X-Gm-Gg: AfdE7cmsvC4RQ0PgoXgVT990h/+hlCmNlEJCwmL1JNOwD7f2qgBARWt5S5Krdx5a9Y+
	Nfs9bDH+hCGaLNDtSeKJXOxt4aafbZepPDmXf9k8uzaLlyxQiAN4RgDo2MC9zRI6o04yTltRg3T
	B8T8IviaW7L7vtWkawVBIoiY3U8bcABRYthm5oQxnJ7SivhkfayriwSG/tAMCSzCKwXiM2gq1nC
	/THXQBTqb25mMxPxwLgRKYzC1fQCVLb757WgoxGJz1xjmZNqmggJb7XbFDEJ1XVUFlC5OkEFcW7
	4AZ18KvML6nQZWxQEJjhA6IUPhOHwyTt6vB/8DGot4udwOZR6NUfbwkNu8HroLz7OFZyRXjPW9p
	TIzgBwg2wwekQKyl86Szvpa9BMom6oSXiO9at1RzwFxS04zbDdadY25/H9CUnaj0DlcXIQGXkaA
	UplU6bVWbd+yeQBVEhLbtu
X-Received: by 2002:a05:6214:3108:b0:8e9:f5b0:f61d with SMTP id 6a1803df08f44-8e9f5b0fabamr95236d6.45.1782481071555;
        Fri, 26 Jun 2026 06:37:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.94.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb55csm211792886d6.34.2026.06.26.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:37:50 -0700 (PDT)
Message-ID: <6a3e80ae.d0999061.a146f.871b@mx.google.com>
Date: Fri, 26 Jun 2026 06:37:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3830573461181403100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: fix: bluetooth: virtbt_probe: open_failed path calls hci_free_dev instead of hci_unregister_dev
In-Reply-To: <20260626115019.33300-1-vulab@iscas.ac.cn>
References: <20260626115019.33300-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3830573461181403100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117044

---Test result---

Test Summary:
CheckPatch                    PASS      1.27 seconds
VerifyFixes                   PASS      0.24 seconds
VerifySignedoff               PASS      0.25 seconds
GitLint                       FAIL      0.68 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      26.40 seconds
BuildKernel32                 PASS      23.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      449.87 seconds
IncrementalBuild              PASS      23.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
fix: bluetooth: virtbt_probe: open_failed path calls hci_free_dev instead of hci_unregister_dev

1: T1 Title exceeds max length (95>80): "fix: bluetooth: virtbt_probe: open_failed path calls hci_free_dev instead of hci_unregister_dev"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/356

---
Regards,
Linux Bluetooth


--===============3830573461181403100==--
