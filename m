Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D75337BBC
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771239; cv=none; b=X0mssx6JoLaxrZmtkTahu8xECKX+/IbbAlvkwYeXKfRoKaahJ5wPOdy0hmjKeJv1PNp7VXPIMdDbpiSx7jF8t6jBBsP/tAetdFLMfXYgOTD3Xut4/lgMz2oNEOPiMBQrB/Q7FAmx8+p4Dzyi4DYvl8nQzYGiwFlWLYVjeFOS09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771239; c=relaxed/simple;
	bh=I/AhLOcYnDBGb0N7nmRxmTHhokd8nSkIX2+UdhoOK5o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W/yfmu4+bkJlF0UzR3peldP3Dw2HuKXTinrwYtV4S1WdsKCRmJxJlPML3nIeD/imuGAqNRdQHUyZuyzKCo9UH4J3zC7ofWLbGQK8VBMnLcpxfo9ANhdTTvj91u0DSoDTp3dpKshtAMA/GZCX9QpSC+AreQWgXgL4gbSoXGqFEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iexVTS2c; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iexVTS2c"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5069df1de6fso74215371cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 20:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771237; x=1773376037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47106vxFQFiz27aflbPFj523PxJag+5ZiuAv7ExWCIE=;
        b=iexVTS2cySMn0SisGlCxRxSHV/h1gipObr7SI47mBGIoJmDsf+N6OOxi/qmAaMD43Z
         FwvZplbSH5/QnV36H/877agXPN94KKpUvoJFeueBBDJg6XgeXDJKw3cIeR+8SPDjW6YE
         71TlBaJz4BtYnAhj5HviD4nTYfd6dZ+hC9Lxbhw6b3ht0XqFOkJC+tXFZXD/x8RA0J0M
         6iZmTeFnsMXFNRTHTAfHDt7CCYkWNl048OQXYECCAnipXZYufevjIJZR+Uly0x6YipTa
         YFwYB8O9rDzGUSZxM0i20Vx8FW3MQg7tfkOgJ/LbMGA3LmcfUQoXQ1HtA0iyVtGfYb5f
         +p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771237; x=1773376037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47106vxFQFiz27aflbPFj523PxJag+5ZiuAv7ExWCIE=;
        b=MNP/hQocIfGp7RPJbY6QVL843cFQMeh1ZPBFzcc73zv0zjdIWPaiDJO9mPHtuAQPpD
         VDKVljZxPY5ggQ7jyn4SjRN82UfI+JtrLM2iR6KcrMS1GUntQIzFKgmCfdndX5hEQUPD
         aC7Sz/YpTYTU1DXyyFzFYKSaj2f4K5kmSAqcdiM4bqnUy5rPny38AbsTYqO0148Ffvnf
         ahKJdJhkRva1UACMCZMRfH9glft7ICN7Al15Tyi9MZIluEpZVKLvvOnp+1YhKMWPQ+bR
         K689skSOy2YVWISundWoHQ7PJFp4fBkegbRfDg4GPbZhn3i3uW3skPeIdfKAKaSW6Btb
         eLdA==
X-Gm-Message-State: AOJu0YyhI6TqZgbzoKk9+b8ovAvit5WsF/xOcKI9sIB2NK9BOhVbsz4l
	KLvrMDlRayATu9QfEVmkkvU0+r9qxxD6XAVe/EXpeKcBhCGpHT8cZa+gVCY+Dw==
X-Gm-Gg: ATEYQzyB0taRwDdG+qsYkT+dW8c24MpYm/fgegvvzKO03sUpIpW3Vumo+UAwQZd84A3
	URZWyniS7s3zYsV1ddlowgj9oXRi0KEH6V/APfUsFlBbyeqystm2tCqxTQymCaePB2JX3UImpl0
	0cVm86YAMOlGKlPm3GO6Q9Nq4KiATKwaBr7DcZn7unAwvLC+XjtnI1OJlsPG5Va8fvW/dwubP/s
	khld4dyvAMpByr3ntmjsjTUIRCC/e0Ug3IsR7QMFTug26izK0DNyvarcuESXTWmiIG1dUxJpno0
	bOcAdLwQu/lSEwtl5ixPF7pe7MYrSwCYLReP1OD1J1WgB4AUNffBn11LEvA0+cKjOJubKSRlPAd
	Xc4tLjbI196b9uSKl/MtrDofQVZ3VjlA5rUEjSSUHWw9QcH9aOKGkbedHuUvSvRkhj6sAhz4yiG
	b7u8kEc0TZM+C0yq5ne5q/Ya8z5Eec
X-Received: by 2002:ac8:5f4c:0:b0:4ed:1948:a8a2 with SMTP id d75a77b69052e-508f496ea62mr10781471cf.40.1772771236664;
        Thu, 05 Mar 2026 20:27:16 -0800 (PST)
Received: from [172.17.0.2] ([20.161.45.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f6695743sm1590071cf.18.2026.03.05.20.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 20:27:16 -0800 (PST)
Message-ID: <69aa57a4.c80a0220.32b79b.4ce5@mx.google.com>
Date: Thu, 05 Mar 2026 20:27:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5425630809474262653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: HIDP: Fix possible UAF
In-Reply-To: <20260306023155.554597-1-luiz.dentz@gmail.com>
References: <20260306023155.554597-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5425630809474262653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062284

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      28.99 seconds
CheckSparse                   WARNING   32.97 seconds
BuildKernel32                 PASS      25.60 seconds
TestRunnerSetup               PASS      566.00 seconds
TestRunner_l2cap-tester       PASS      28.89 seconds
TestRunner_iso-tester         PASS      94.23 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      118.14 seconds
TestRunner_rfcomm-tester      PASS      9.63 seconds
TestRunner_sco-tester         FAIL      14.71 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      12.43 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.79 seconds

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
net/bluetooth/hidp/core.c:1486:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1487:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1488:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1489:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1490:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1490:1: error: bad constant expressionnet/bluetooth/hidp/core.c:1491:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.607 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5425630809474262653==--
