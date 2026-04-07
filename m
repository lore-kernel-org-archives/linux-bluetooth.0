Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946A3939B1
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549838; cv=none; b=FYI1MPc++hvToEtgHtjxWbudc3WFBJsWOdoh14X2NZPrGcfn+Luhos8IUkMlBjiS+wN9TtXTeEoiYYQAt7PjVqASIrYFwhJ7t9KLV71WOoaIxoMsQ3dJOoFx73lQQZhkDN5lnrCW4DCczIRbXQPtVNX/lBfHBbW0DpRuap0M14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549838; c=relaxed/simple;
	bh=T94CAEXMhEjDVE++Y0KsenS4UBMv0d2Ijf8b3HRMTgE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fCzVvjgFJehI/O8By7qXQIFNs7xtzW03O4MzxP6CUjf+PriBO50P7+z7XsVTp7o8SSHZUMmMEpR/zrxeM6MDuhK2F6BpsANUBVD4XU2FMN/nynNK+CmSoi25myZ37saLn1naGPxd2UYSAAW2p4Fin2mPyc2zxtxhxImXcDkgw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlnLc5wR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlnLc5wR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d736211595so151794085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549836; x=1776154636; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=whHOhdAXCWrIY/iwI2n5ymXetKFc4hRNtbmkx4iznUQ=;
        b=NlnLc5wRG0xRlw2IfP2yHA4HYLYpcvTHTUgEitfwMeF9wqsB4C2cuDchK3vhJstaen
         wxfm/pDfPff7wsMQp9LkRoJzn7cZ2UHun3l7g8XUwsaZniPV0OJuibDDCSny9JaufRc4
         eHlTjTCVWlUQAx4sF2cu0anJYHInAB9rCSVDOA0w65NyoxhtnWScM3H6Cw8saT2W6viF
         O9Mb7jRDN9wHFqwmCk9HPhk9YVTH4JsaggXm4OLY+fiUKbvnSjmEGF7GpcQI3YmZZkJG
         vUpUFTFBzWOxpjlIlaU1LFE8kVYZE5p0vm1toLVWmg339NTA672H6Xr2NVlcwr2LNPC+
         Z8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549836; x=1776154636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whHOhdAXCWrIY/iwI2n5ymXetKFc4hRNtbmkx4iznUQ=;
        b=ddFNrhw6NtRaVz3SXCNK5ilvu6mb42O5VfGSOB11nz/FkAPU9z3TS0EWS2JA8AtMbj
         vShn+GMtAaJhdhud34z8/DE/N2yCXNXD68xfD7E4y0TedOEeWvHtfbOLaPTsAacMFQFZ
         ai+WL386wKUthkC+jKZkRX0kLWOmsV8N0Jda5FYrDh+E6qMnNdoZbVn1SUxjFOHwGY7s
         sTckM+BACGyzjxXTcm9XaIIhOKJUwMcZQ3IOdPIRO3xhIjRXyKsCYJ2MzAFZWCWbOlZY
         +qcYJ1kUEEHzH2A+ikCAtFsNPzE6u9SqUqKAbP/NyheenB7ciXvBSzROXAuAwdFRGytX
         I6qQ==
X-Gm-Message-State: AOJu0YyZBC3EXQeyWEScvRaUpdEfBuVKG3bmw4pe49aZJdEZBVR6Qw6R
	uEc/5fBAVm0xqlnacRpNIXB/4u589DYo3Zt7jRa0vCAQNTiJROqmYuCn6uZOpw==
X-Gm-Gg: AeBDieuiic/n28gKIs7DGQc0iUC6lzYfg+D5qr+DAiPECGUFymQe8D9lXblASKIcDIO
	jo/XwGx6HAvCdwyXkq0jcTnxVAw0cHMAn2vbum+U8Rd9lq1dONMt5bsxj5VxcqSuB4whVWJQh0v
	kOS6PrYyLjeUP1Wavw9q1TsR0VAVx0pC+11iZWeX10cIm1YlIOA/Tn16jqQtMEhqSSYARjdIvvZ
	89DtD+FofdNQbicx9hXOB8O3jhUxHamBbOX6CjRfhIZzJQMS+QsAorjHqoXoVxs/VoAYHSjGrAw
	Y32/wlDwM064g545lw/WnR2SCXX43stpKkRXT7tPpIhbSvkbHGR0O7zOkDVUiySj7ZPHI93YIMu
	ebG+gNd19ryKXZP1GazYSlM0vmuNiWll3gifVK9hYE9uuQ7vveD/nXb36HCsbBDDRsJDvlhjhpW
	m65alZ+yBOCWH23TJsczTnQH8AsS79PzE=
X-Received: by 2002:a05:620a:4612:b0:8cf:bd14:92d5 with SMTP id af79cd13be357-8d419094f35mr2176861785a.17.1775549835565;
        Tue, 07 Apr 2026 01:17:15 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d5336aa9f0sm843087885a.28.2026.04.07.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:15 -0700 (PDT)
Message-ID: <69d4bd8b.050a0220.9f96a.fb0a@mx.google.com>
Date: Tue, 07 Apr 2026 01:17:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7154548711317576542=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btmtk: add event filter to filter specific event
In-Reply-To: <20260407064759.3036650-1-chris.lu@mediatek.com>
References: <20260407064759.3036650-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7154548711317576542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077967

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      30.19 seconds
CheckSparse                   PASS      27.56 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      564.03 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      41.09 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      114.17 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.11 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      13.13 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    2.714 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7154548711317576542==--
