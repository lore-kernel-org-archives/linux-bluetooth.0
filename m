Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3322DA76C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932960; cv=none; b=TMUxflFIGuFqyA+kLB0Cx+n1CcCMQFe71IE0Abt8bmPAdzo46c5Cc7bjh+cKSD6ghiw3l3018JptuQIMn8VPb7L+n2PAdUo7N9XosJbJN8iAVm52Ow//BqzPRn08kQEl9t31jO7vVZrdtLApcNlMTnsTP00Ok+ZtVT5tHZXj6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932960; c=relaxed/simple;
	bh=IS/Yf2wr9PYWje9W7GQKcOig1kA4mX1eQJTG449G5tU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pnd8eWPVOJPyvD2s320zPICeZVJoTJ9vtdMjxDZZJ4+9/zJMfIxx0MDOYeFyCcFXNGOnz4k0A6ZbpGH9xycuqX2xoCSKl/PHz6fDFwnahDK7CprRTYrqpHu5gW4p1U2EEMRlf6hp943gpwwf7847QU3bfZ43eLFNzXd5FKTDIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmxxD2ro; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmxxD2ro"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso21425039f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932958; x=1763537758; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jnFeKZv2eX9jrKmvm0w9UOHXGYo2JYjY7VnMRjGXz+c=;
        b=ZmxxD2ro3YIf0SDnOC3HjB6J2vnTMsdkfnFjbRAoDV9dvxMF97gi1z5SDSLYvHunpZ
         jWBvjZlQIvp67OB+XRevcCjLAN8PtfLj77awc/LAgdSWUtFRWnkD00+bJZZ+VYzR/nMB
         Mug1L5nUm5u5FuOZqnpfgPUXXjSkFy3CJTRR/4WdKiwVDYWQuMar/KWmS1zl2S22aD2Z
         hfiVNLH5Mms+01q7ooTFBnms7SRi0WfygYflhkCV+cpUHdK/m+UR73ywf0B7jpD6A1WR
         xDlMKIuwFCD9CsN0lKIpCNMgTJh1moStqC3JOK1tDk0rv+mJcMaSk9PEQd2SJjMCWBTe
         5Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932958; x=1763537758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnFeKZv2eX9jrKmvm0w9UOHXGYo2JYjY7VnMRjGXz+c=;
        b=QGxwnU7/7KOUDd2r6Fc00paV9TG7rH6/Z/8tdN++EmKqiMvthEPn9cdeB9GjhrUgip
         QZjTJQ7O8qg2Zt9tzSwYjE18ASAPZQ7RPEVT6f/pT+HxQrcCCg30CVElr+jX/GAyASuo
         OgDqaOvmmvF5S9R/6eTaZAR+12k9A/OHloudElC1VXgCJphvS+ggEWiolumVmAaQofh0
         smYozLHtKVIu7nOKx2WmMpwbKz9DoG6qeaB5fNf0O1rOaRT+9gHvNYQWYnB16D2F0T9q
         ibFNmE0mVqbwws50fZDEBXvPOn6MD6bIJaVbEDF9CgESc+O8/qtJongGG84saaTITgim
         S+IA==
X-Gm-Message-State: AOJu0YwLrZhZZLqskkHeu2cWcnd+E7nT57Pj2RkAYWXqHoMPJ5mM+D42
	tPuGGRTYNprVx1/9i6II5XTJC8hs2j5x4JkmwI+EOeBdRWKj11he2LyPUq6hzA==
X-Gm-Gg: ASbGncuMSzO/Iljc71CH1Shs+gJtfTzFhiFxxrTg63LUV8URbgLdsjE1ykJzo6EnWvN
	FGoe0XuFVGPqcJOCeti+ymxneVrFa9LPXksOyIsP39mqAJnMAGJyiH1FmlnLKRuxzBNNRCej+8f
	6nTMqD2tNmI1nXJDRjKKh5oytVuz+91YGnWg404GIFVG/yDZsc7608f8PkfyZlRcrUm6teDihRm
	+b+PaDKNB+DNo666JeXBUAusXeDwaINUSG4Ki0XUWXhXzcVqpshk/85HhFh2GM3rctHRgg1QXFy
	3jZoOqPFhggc/+9qtiq54b8BoN1MtFP4ZfHFX6N05hUV7H4FNAi+1E4thpAckrLJBOlx7RVwmJu
	lGIymAxhWF3kjLSJSYNuZRKDbTY2AG8SROooEuS+lyGn6hDcDtIyzwtfDxX3pahXMqcf33YtTJa
	/X1Dbshvs=
X-Google-Smtp-Source: AGHT+IE+txpkPFC+y0bz4/FnewsJwni8xdGyXZkZQ7eyV97fZKI3x8f2nOa5B/LG4sTLWhQAA9ki7g==
X-Received: by 2002:a05:6602:3fcd:b0:945:ccad:90b1 with SMTP id ca18e2360f4ac-948c45acdbdmr287648639f.7.1762932958183;
        Tue, 11 Nov 2025 23:35:58 -0800 (PST)
Received: from [172.17.0.2] ([52.176.124.227])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7ab0d80c7sm740734173.30.2025.11.11.23.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:35:57 -0800 (PST)
Message-ID: <691438dd.050a0220.3a4ec2.13f1@mx.google.com>
Date: Tue, 11 Nov 2025 23:35:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1418270441866711825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: lemans-evk: Enable Bluetooth support
In-Reply-To: <20251112071147.1450258-2-wei.deng@oss.qualcomm.com>
References: <20251112071147.1450258-2-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1418270441866711825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022341

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      25.03 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      24.52 seconds
TestRunnerSetup               PASS      490.46 seconds
TestRunner_l2cap-tester       PASS      23.45 seconds
TestRunner_iso-tester         PASS      76.55 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      111.28 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.35 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
IncrementalBuild              PENDING   0.59 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.082 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1418270441866711825==--
