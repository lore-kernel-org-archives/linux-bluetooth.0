Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8A36DA04
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939357; cv=none; b=IYSX1yEEuT/8obKYggcGdXNwFJwzuvmzb+yvXLThojVdjxyeg9vdzIGGR7zCI8vtQWr+moRMxwsuowtOLAefmw19dRxZ2O2QM2wFQg3zewFVEjr6GO8AwESCSsWt2+VO0favK53gio+ydO7/5TV0cA2QhacwjnGFjmApWOqUhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939357; c=relaxed/simple;
	bh=ZEzHnwGG6m4bdIriL3B7dJw/qPoDdw2/sJFVibr+9dY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NX9C/Txs4h27uqfVbp4RVOEKtAWq4GMSQd7/bGxbBxHsSSW1Tn4k3m5+PXrQOqloLHQz3Ck8MDAHi9f3bjWaETww9Tp1czCJFtMNKwconHVDnqXaC9zgnuygOrRLR7tY2LLa+7dqQhI2cFtXjV8DA4e2OfZa8JoTeOb6Mxb5cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlDbhCJ5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlDbhCJ5"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80cebd41372so16280237b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939355; x=1786544155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AgPOzYPSMkHs6Q0kHYfhYkoG3bEuk2vOmvD9+pIBCEI=;
        b=qlDbhCJ5FKqJj9i/WoZ0a4Qo9YMha4+BTuz4xP37P0Li+hLdISMJ2jvwqdeiZqcBgZ
         kleS84dnVtiae4Ktk9mnb5BzyJfLYvjNDaELRqs2lW1+Pee9Du2ut0zQhIQO5lSNA2S9
         0VsngFx4Gxa+TLevWtXkqVK6dFP2Ja4VfQm/vM138EtT17rslRD6g4IUl/d3SeIkGnMl
         SdPGEkDY4qMQX2yNkpJN3otOugC+HGd3lLmGohWWSTEly0dnhLX8b++ZIwysZqDoyyLT
         kdiNjyq3hPoVwpAmYbCs3TTC6mB/89Uy/kideMisvUB0eGYUmxan9AnkNurg4Yylc2Bb
         Ogtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939355; x=1786544155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AgPOzYPSMkHs6Q0kHYfhYkoG3bEuk2vOmvD9+pIBCEI=;
        b=aSgvjbu+K0+ddn6RCBYpmVGh6QvQgNf2DWKcHy8qoDMcdzWSg12wnDen0sSZcwuPWA
         bejl1SUbsSJcb134wju6u5lQzh17Rkcn5OtBA0dVO96ZXD0p3rOKqkF/vl9f3EwAKfCn
         V7su6utxosbO92IYhiPOjEEqbPvS5lq9I+/ztf/Xi/jG132lDugkRYHRbtDERhUP3tWQ
         EU8T7Pf77YdFFDe9JYHRCIUGQ239Y+f73lWO6KiRKUq+djSm4S2hZljZjRuj5nBclLVX
         w91kLZd6msni6ER5ZJmHARwzuNugcEQAkIztbQfdLIovN8+dJiKE8ezl0w81JT2+8QyQ
         Jp4w==
X-Gm-Message-State: AOJu0YzqmtojPxbt+FHumaWyPoQk5KJk6f85wceiMaPy00B0zIJnhOXS
	9b9IMlCaKfCoh2V6O1vSyLQa+iHhIVMW0slNWdSIE6Do8UGq21dFkm7UMQZgNQ==
X-Gm-Gg: AR+sD12LognPJb9bATi051SrpfRx0p0+7nvmZVC4BZfMM1zz5NlyO0rXxEXLDvadOyU
	XsU5fcV/6CuBrmXDYtDYz9xZs20JlOqkTEXfQqPZ1YzeazGWwvEESzKCmOLASiD2t/gs0nrVBZq
	/zAm9lmaVWUvptP3A6zLnxN6imgTJ7n1hYc+ICBBwjjhaUKnfJNycemklfD1SuRICFS44bEiDOO
	EL9DT09I0JGM/CxBUvOF2pwuVrROjOdsaoBr0KLH1WAsU9sDTdSF475BFNMU0qyPFkgu8t/mkbl
	p2+NJL25BO8JAett405jumwkE6QtUHLZwYwlXP6Wlbs1wSiWEKvn7UrlK7HrkYjh7nd2a5/RYAZ
	+BDbJXQxb1ESwxnAasIg67zpGU1IY7DylHw3nYkXBf6+Easa3lQp8w77+Wh5RQ8Zf1hRI9bepet
	V8rpTKnRxuk5ggLswa0R6GpsBgPJ3/BlgIOTOKjt/DzWiUkC7k5zFF7pJ+I57NzpdbppW2
X-Received: by 2002:a05:690c:c4e9:b0:81e:9b09:7263 with SMTP id 00721157ae682-820222bbbf6mr40869837b3.10.1785939355422;
        Wed, 05 Aug 2026 07:15:55 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.224.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134cadb4sm21172167b3.44.2026.08.05.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:15:55 -0700 (PDT)
Message-ID: <6a73459b.63b9d10f.2903c7.ffaa@mx.google.com>
Date: Wed, 05 Aug 2026 07:15:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4413172768675875710=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v4] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260805132203.176213-1-frederic.danis@collabora.com>
References: <20260805132203.176213-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4413172768675875710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140807

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      27.21 seconds
BuildKernel32                 PASS      24.74 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      470.70 seconds
TestRunner_l2cap-tester       PASS      67.80 seconds
TestRunner_iso-tester         PASS      102.23 seconds
TestRunner_bnep-tester        PASS      34.81 seconds
TestRunner_mgmt-tester        FAIL      221.41 seconds
TestRunner_rfcomm-tester      PASS      27.62 seconds
TestRunner_sco-tester         PASS      33.32 seconds
TestRunner_ioctl-tester       PASS      27.69 seconds
TestRunner_mesh-tester        FAIL      26.21 seconds
TestRunner_smp-tester         PASS      23.85 seconds
TestRunner_userchan-tester    PASS      22.27 seconds
TestRunner_6lowpan-tester     PASS      23.63 seconds
IncrementalBuild              PASS      24.05 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.266 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.004 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/535

---
Regards,
Linux Bluetooth


--===============4413172768675875710==--
