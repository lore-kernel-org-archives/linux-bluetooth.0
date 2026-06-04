Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E63E5EC9
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565313; cv=none; b=WVBSEOchMIewOyMbnRNai3CFSY35QrCEhlWkSFfHJpBfR+1Mu+fAWv4IjBFO2qNa/ueceUFbqMZGf2CLd2aAUT7SaQDdaEwSUGaofvXizYlm3Vx3PN7hWh/r7+nHnZAuIfhARXAvnvyG6Ft5r0J2SVxWvUEEkr8NJvWRszNnwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565313; c=relaxed/simple;
	bh=QJ1rbXpsjDYjKf2R1TCKwG3imvk8Riyjr3kkeoJoBNQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QHL9Bk1Hy6hmXpW4UVe4MAgUo7gX2D112PPpetWpje52CdfOH2Tsky6PpyvtS2QF7dEfo+9bZFNX+JIKfeNfZ3yMbsq7ULWX7CAp/y7gavyOJV2DEx8UPci2mG9XQH8aW0b3mUjy9Hggscoy1TpJm0jKncV31MOL/G+IpFgrz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjQmOsZB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjQmOsZB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccf01ba514so4353776d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780565311; x=1781170111; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O852r3/VWCOXtHGi8vTgiPNyykkCu7EmoZ6X/4CMFc8=;
        b=RjQmOsZBliCSDq2SpjnKLEPRhKyotdOXmOAVIeuYwLrPJSvaO5aeN407D5GNQJ3LSc
         lDjd8AxhoGXz4r8lxEnppkd9KEbgxBW2QEURZ5tSv4T2XaQonKLN3maC+Tn0waXQakwy
         vstl1wBEVrRGghbzdomuzE0VSJ2i0Q7TexTb0Kn5rX37+d8SRYduDlvMHZZrqPjvAFud
         wwwVYyref1UIFUdd1Z80g2O3T9phn6n2hlbDOjcauJ7fDVp2cDGcfEUHEpcA+NSCa4lF
         EvyBlptmdCLoTGL26AzeLY9aXjcBbSzxiM6joJXrZ0BR9cG9NKVFv1mHb34MLfZamUl1
         6/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565311; x=1781170111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O852r3/VWCOXtHGi8vTgiPNyykkCu7EmoZ6X/4CMFc8=;
        b=evOGbQUAvLbIK+h7s1kUIW3CfuV8AtqueS2ybGEvFksBpi/L9Zmn+gcxlUGG2Pl3v7
         xua43xD8bgti+ECrrdYDg7YkbznJNpKmQ7KQyB53pVSRspkfB+3pn/9/K1rQVSREv2Di
         AOhvj3IznmBa1kZ8y+RtHGv4oQ8aBo42ynpEB/JzXEM/5YvZRabUWP6xlOCBRUD+u+pa
         0ZhNmwkCEP21wJo1ZTlC2ltdYy1YngNfTSw0HVddU51e+jMnNJ/5xHYZWwjzhxvLsSqe
         bMGD6I05Yxup502JM+LT1dCOjl2ihNU2Otxz++R1ghfCpHx+Ul7oRUORrPFRdZSc/6qc
         YOEw==
X-Gm-Message-State: AOJu0YyGG3kRu5/UDs2zi1l3mKwCtEoh/39DTIpmkzLrTHViSbM/7Fse
	/xl8L9JjHY/d+6RDDLWDSA7+4HT/pIXm4v7u4wI/r7WUziRp3fj16ndPol2JpQ==
X-Gm-Gg: Acq92OGhrIosXCXMCbdOorem1VbCeYF+zP52xd7cSFcbvNsSgnbjXe5TbHENiL7vrnp
	soYERjcb+NJAT6AVmsBiL3MUTWLaRXdlv+xrOrBcM//VlLuspsYFOC80MGGfzCG0qyoYZE/va4b
	y014/6AypOXG/z43YdtzPCfOVSd5UwcMfTCYb4ksmquM2RwinQsvTBpw8H+LG1aKcJ93Oc8b40Y
	aVGzvofIKHUafE1S41P83K8eOhKV2FDSlx8kDhE1exLETcluJpUdxTq7V0TBM5Y2/6kQakcW2fg
	rdsgRlym2G1fTh6ofDz5kh5xFBZ27DpCxhHEWpKLQoMFL1PE1R1bnqxAS2zxxVYbMExajnWBp/J
	T60N1YcySRpIk84kopvlj6JlP/o3gl/yhZbeG6hSfwn6qntAu4+Q9x1ballEtg2xL6+IvHaePed
	YsnFCa5OuGm1F28KqbHn3bLtJB6eag3IcUnxR8X73Y7g==
X-Received: by 2002:a05:6214:d41:b0:8ce:b75f:417c with SMTP id 6a1803df08f44-8cece160143mr104839096d6.47.1780565311192;
        Thu, 04 Jun 2026 02:28:31 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.135.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053210sm46475056d6.26.2026.06.04.02.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:28:30 -0700 (PDT)
Message-ID: <6a21453e.053a6a3b.170162.122e@mx.google.com>
Date: Thu, 04 Jun 2026 02:28:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3467698031936071260=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260604063740.2595260-2-johan@kernel.org>
References: <20260604063740.2595260-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3467698031936071260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105725

---Test result---

Test Summary:
CheckPatch                    FAIL      3.47 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      1.46 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      28.94 seconds
CheckSparse                   PASS      27.76 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      565.02 seconds
IncrementalBuild              PASS      33.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")'
#81: 
[1] 699fb50d9903 ("drivers: base: Free devm resources when unregistering

total: 1 errors, 0 warnings, 51 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14610717.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/5] Bluetooth: btusb: fix use-after-free on registration failure

10: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 2.6.27"
[v4,2/5] Bluetooth: btusb: fix use-after-free on marvell probe failure

10: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.11"
[v4,3/5] Bluetooth: btusb: fix wakeup source leak on probe failure

6: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.11"


https://github.com/bluez/bluetooth-next/pull/286

---
Regards,
Linux Bluetooth


--===============3467698031936071260==--
