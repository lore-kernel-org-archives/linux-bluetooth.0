Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01335155CBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878143; cv=none; b=KK93qZrNd75WHiv6HRNOI7K9j9VU/Jaz+meFNMmkMW7i0sEaQDvoHGMqBCyDJl/KfV0LYZ8LOuDFNCF5PEEWIqiwKyCkjwdqxGUXDUdxSvYUViDyjXsBo9FbdEDikvxSP+dBB5jzRg5jOWQRst6/rTRyc7GgDdtRZk8Ly+tCuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878143; c=relaxed/simple;
	bh=Edc+eDAuYDEig+iVfok+vSL/LiwpWs1P2icoQcKGyn0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Svu852WAibqi078U/AbH9BOsyvZIxc8rCQGoZoikyCB2SkGnz43kn/RTM9FxMw/ZxET72ut1bmi/NTAKHSLsunyUVbUkMXuU+Jh4T0xczoj+oEGKeY55MWLmxnwb466seTaeC2I9/eafY9ghY9peairggsEcdeWhqO8i3H88z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEqBGhEj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEqBGhEj"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d42b87aceaso24343866d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2024 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732878140; x=1733482940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=df1Synuc8fYHFSPn9blRWfr7WszyxNJwvbzS9AtlDok=;
        b=HEqBGhEj/PhJH6sSCAF6y956G4rVUvkH/+Gnb/U+dVM+JxVvzDYnCAQBd8ASwJSS1l
         b034wQqj1+WBg6ZHuGbWPV5rM/hb1UwhxDwzaM+4PE88xRplFeEWMc6fgE173q7y7gcT
         9OxKawhNDeRdkQ3P9llHrVnymNukto70N7UfZzl9PuzIdafT1PbigPYT7tNGMLiIbtYj
         LAs3hcXzPcdE4EPnFUpUxDMmmDilS+/BmjQBi4RBylcLFTLP0mdeqQGDs9Hd1HI4MsUI
         Exor/SysIR88UZnJ17WGLf3sdVAhNEp6JO7aiJL7+oE7rQJ51S+TAXwn3NkWzG8E9y7+
         wuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732878140; x=1733482940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=df1Synuc8fYHFSPn9blRWfr7WszyxNJwvbzS9AtlDok=;
        b=O50XmCiAP9yIxlkOwR3kut2O86tG7cARYDuAtNX9CyCnjW85IZzxuQHMhYZbNDhfEO
         bSq7nPJCPX3n4q58bt8bAscageLQJaOQTJpDHY3/8WsAjqnC7tdXIuLc9oikH6uz2rWd
         nogiCjc9VwoSoKrnuTPpWA+Vr6pe40jLFDf1ML6H/D0Dob7+aYQBcCVp4Rn2vV1TNFJG
         75TKaQeDUppYEO6qy29jFRorYl2VX+CLn7np1WznlSfDDDR2tgLSMeMVjIp3ZjMVV48f
         iBKRpn61p4vik2K07g0UzwtoW5Yc3aModhOpXe8e+akmMS7kpFacobxasoBK8apk0R3D
         a4qQ==
X-Gm-Message-State: AOJu0Yz5CKlJVvH/Z4am4gKjNVDxnR+KyVXLJec65BnL/Wa9Q/bRP31y
	habUVhLE5cUUnAhQoqGYytnUXrZ4rZRJ7SXflQfkxnK3kpqizzPE7S5VTA==
X-Gm-Gg: ASbGncsKqD2jIqTx55zOu0XBh6nTBp2JoGLBNzEkby2Ka4VNfo5b+KlW9liBo8N1w+F
	Nefn11nb+1PKC8NfL4+41bjazVjmZmjEeks0QQG+eoYU3f6SMFtEIc8PQ+kLRMNFsZjEZJgnw69
	KO1XxhnsinYH2A0HjZUUrHKoxS2+lNIlpWtlnzh+Xi/ijn7rOUO4iIBw61Ko7q+w5qQJqMUsM4o
	ECanb0BLxB1ifK00lGO5StUJzNH4IoqT4ro3lv2JnFxabZLo74eRw==
X-Google-Smtp-Source: AGHT+IEb9oX7wgEZOyLFMMjTGdhO7FrBExA5sqM6n+mWh/qo5NuzqIGJsRU35QGr0K5b5dwk+n60bg==
X-Received: by 2002:a05:6214:48f:b0:6d4:1d7e:bc72 with SMTP id 6a1803df08f44-6d8729957d7mr112067716d6.12.1732878140313;
        Fri, 29 Nov 2024 03:02:20 -0800 (PST)
Received: from [172.17.0.2] ([20.75.94.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d874b8cb07sm15383006d6.0.2024.11.29.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 03:02:19 -0800 (PST)
Message-ID: <67499f3b.050a0220.14b99b.456a@mx.google.com>
Date: Fri, 29 Nov 2024 03:02:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8925502978324798338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangheng@kylinos.cn
Subject: RE: tty: rfcomm: use sysfs_emit() instead of sprintf()
In-Reply-To: <20241129102640.499871-1-zhangheng@kylinos.cn>
References: <20241129102640.499871-1-zhangheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8925502978324798338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=913285

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      24.74 seconds
TestRunnerSetup               PASS      441.27 seconds
TestRunner_l2cap-tester       PASS      20.28 seconds
TestRunner_iso-tester         FAIL      26.16 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      122.23 seconds
TestRunner_rfcomm-tester      PASS      49.65 seconds
TestRunner_sco-tester         PASS      9.38 seconds
TestRunner_ioctl-tester       PASS      8.09 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8925502978324798338==--
