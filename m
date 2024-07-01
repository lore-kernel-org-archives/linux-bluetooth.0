Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B663433A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851815; cv=none; b=T/miili2xyDvdvVFwrgG09FJy5iFu53ARtRnoe1dMggzZ+K15VaJxnNygQXX8py6GCtwCuBvlWctJ4/Znxq2qWH3ElxA5uHrFyYAMs8+YxyXYjcpbOclzttkC7jsOv36OwTKR6PPmDSDppic2ZxAVc0/ACgq7G/eMwyqfHfea8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851815; c=relaxed/simple;
	bh=8fG2yen92F80Q9HZtpvTfmk8dOE0x+4WLH3Awb2WqMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lZKDw7K0fPUP/iEYl2q76oc6tf1cayRSywrvZJL/qEVJS1yjwfNXJ+SdD+SjetcBpsupqd8fy3LvnZ8kSrraOdgnqQ78WldJT/mG23akePnNJXg8XEdA7CnMEw1NRE5CoEfXXnEdUz7k1HBZd8p9yxR1UOQ8h4dj+tdGrMr03rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBkSmEys; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBkSmEys"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79c06a06a8eso208624085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719851813; x=1720456613; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3f0ubUvJN8w5HsOtmkYWQRuPwOiaYHXcLcVYf+AaPcU=;
        b=IBkSmEysIepg4HLRxYqaTJghrgfFSRKp55DQPOgi/0GxyZ2m4IHFjZGnvt5H1Y9up2
         Zbz6tEdUbutZR1e/HSPSYIRyIiZ+wu9W5lpGPry3bcv+50xmRVUwBaRaUpy/usRuvNPc
         qk81DHNrKyYzChG2NKRryhG2zLFiJ3mBtW3dM/PM6O17Rinr53a392ZH9Q1JcOglojm9
         AN9dBxMO89a9sbCkEP4Yhb8ebAsbgj0Z3ShIDmXcnPIf0h557cV8BWEXDeiVYKbXpDXA
         4nRSYTqBSNRd0L2T5uvwFKXSmcxrRgENID5eY+NuXPXlh1pCVnNUeJdrlm42KWdnhMBU
         qejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851813; x=1720456613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f0ubUvJN8w5HsOtmkYWQRuPwOiaYHXcLcVYf+AaPcU=;
        b=fHeGU2RXjqbPlo/6f3vSvPBVo8aCI2lOCKj+9KHe4JwjK5GdZM373jxD5sUQJHhbBN
         h/g8q0RcM6XjpPxpLCCAk2KqEbNl+rKpTdoyNQX9I8ZYTTATJe3ngJxRgDjlWjd9ysqP
         XfS6Vr0cSqOZFspC5ehTZuPvSiqDdPk1Af4obbVNhjPpOuIRlb9Y/nRqc3rDq34Omwwo
         PyIQkTCDuhXDLEWH4b9Ysmid9XChlY3wZthE3RWLSBkKmSbntHAGs7Q2U2PCZVuDxVnH
         15tuWeOnsKCQtJ9AmHi0auq0tSCockOrdzVI69u58uIYJTK8BxX1b2v0OocFM/qXLngD
         8j0g==
X-Gm-Message-State: AOJu0YzJPdRIg9ED+K3mxgtXedTSGu7fhRQBSRsyoqLSA1Ll8GoWrVfU
	15JotMk9+qecTUOTDcJ7pOMSYxHaDDSgqfVIlq/rVbLUs1O0fQ4yUWHQcQ==
X-Google-Smtp-Source: AGHT+IFLqohYpRJBJrNQgAdAgaCLz3j1i927b30l41vr2dfStn+VpoyJf68h9Wj/5EnsKSxvgYJ7YA==
X-Received: by 2002:a05:620a:4624:b0:79d:772b:3f0b with SMTP id af79cd13be357-79d7b9f21d5mr768464585a.37.1719851813285;
        Mon, 01 Jul 2024 09:36:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.58.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6925f58esm362779385a.12.2024.07.01.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:36:53 -0700 (PDT)
Message-ID: <6682db25.050a0220.aa60c.e746@mx.google.com>
Date: Mon, 01 Jul 2024 09:36:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6936739602153972143=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: Fix usage of __hci_cmd_sync_status
In-Reply-To: <20240701161100.1317685-1-luiz.dentz@gmail.com>
References: <20240701161100.1317685-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6936739602153972143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867201

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      32.68 seconds
CheckSparse                   PASS      38.01 seconds
CheckSmatch                   PASS      104.31 seconds
BuildKernel32                 PASS      29.11 seconds
TestRunnerSetup               PASS      528.53 seconds
TestRunner_l2cap-tester       PASS      26.19 seconds
TestRunner_iso-tester         PASS      34.75 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        PASS      110.25 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.10 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        FAIL      6.10 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PASS      28.19 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.095 seconds


---
Regards,
Linux Bluetooth


--===============6936739602153972143==--
