Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93633F8BE
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786793731; cv=none; b=N0Piieil/jn5RXvdvHytT0KsRhUeRUe24AJC87rXlDrhoXfYoS2y69aKFPyE+dsflvJD9DdIMauT41TWtJvIIzSbv1mrWl/F6qbw20+VWAPGaY3z4r9JL08bQtzYknlTtG/aFN4nw7BizjlIYHt3+fb6wWz3rJT/jqMCGrpEGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786793731; c=relaxed/simple;
	bh=3WEHMC3ZOAd9UwuEt9lzEyPmfGZW3UnG+bmVN/7INP4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rK0gFEFwWHANKqBLE++1RhlqAHQD0NKOiBbAfJyUuIkWriRoEgTM/mY0JCWGS7qp3rJCvLzQZGdtoBU2PogrZLQdjvQouJA2anF9fiXOIHePaRxVNKNiKIxjbHb567rigewnOjZuY9LV8TygX72l+PQp4zhWYB3saQzAyd8g3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtpVbk+h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtpVbk+h"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d01663d816so16675385ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786793730; x=1787398530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mRzir+ReFObZWtcsZOz1irH0tWr9P0yBrWCisVMmQi8=;
        b=BtpVbk+h2mY1XM5RUdxOOGiAKsQZnJU02Lz6j+HdCWhsF4sm2Ju9huIYM8GTlAR2Vs
         1oauemcQ1OqO7qRHBIMEFrEi8or9sqzngT8LUNc/eI3Udp/Hq/Qkgj6/OHCBQXIIpVmY
         BaGR4TT3TYD/RF8SxmZyDoQPu5WYrcOGOXzIIcN9lIQMhKFnGJ8+himT6m6gAuMRAPV2
         IA8vXBXHXK8sHMsBiOe24qNJsC2M19HbACRtpZPdLEcidmkU1d5nLSAR1YaZQxv7pp6h
         lFocWjnOWOobm1eGORJ4OVoEQF7X3x1zeyoYFHjjtILuZ3SjiFW5Tu8va5uNqzVsKLVS
         X/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786793730; x=1787398530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mRzir+ReFObZWtcsZOz1irH0tWr9P0yBrWCisVMmQi8=;
        b=kl3Nc7SSVq3fnEoeHr7Zv+xzfHYw+Nkity/dWTF3FKqKaHRv6zvp5wtP+ouori8SGs
         qVdJsGIDZNl20L9a7aRwts12Ss9gO6ePRSfU4bh+7Z3MFWHN8hmsRcq4V2cuwPqYu81f
         6yylAxXBUIieW7SbTvx71zFTbHwoPSB33q3F8p5sOGc4SJ0lScZpTAkSNoOlG6tztbZn
         HCw6ATY3VmqPBiTN/YT99OxzCPr0h8wtr/wDPPSP71qXACvoaCtmaM/DL208q3Itny/O
         cfsUn85zzeljHTlhu/L6e1E4czRw9z23yukXoJSAvrhsOgwkU3DN2tdJuoMsr0FxJmza
         OeMw==
X-Gm-Message-State: AOJu0YxljU1mYnQaRm8rhkq+x2e6g95KO/hEr4psdywr2deINFrFRYGP
	oAi2gvdVZm58yeMKSfN30HXEoLDPDrnOMZtaninL328cjGEz8NvxciZV4vKf9A==
X-Gm-Gg: AR+sD10GIWbUrZaGs4JYNdIJEnoqweLBqRQ+rd45HhCKIfoO2iCO7AtWGkV+p0AipK+
	qvW8tyOhHY+2+k5iWRlANHS3gQdMvEIeePgKW1JXYa9aEoTwegGa/6LH3T/QbISKpjAWcMztBkL
	ujgDD7YbJZfxVgQC6zIzunBYDpaXiN0WBz5v0AnXfxU2FedAyny9HbvJc4NpoNp2ld/SYNyKAnv
	AJWX1Hz9pEWNBv+2LiXky/hPV0AhYHsBiRkVlh4OCCIUY6GaJP6VuTRUe7oPZ6v4eNli72lT3rq
	6plEpQneJjFfEIPFxZ6r7dFx9VLgjOIbFxhHRpKifHLvMg1AbAXzwSl+w9ocpBflAtC7nSIqTxC
	SreZisEjZb3DVCAZh03Zg/u83ANFyF8I2wqkN8/BD5COce5ZJHVolHF5cWeqa9p47pB/L3FQIyx
	sYgb70/WDW+aS6cai6MY0it4MFNVIs2+n60nHb4/CXdQsGwkevx4KOrYH4DA7ti2QPpg==
X-Received: by 2002:a17:90b:5606:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3933b78b698mr14247199a91.6.1786793729828;
        Sat, 15 Aug 2026 04:35:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.23.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387accdbsm26148310c88.3.2026.08.15.04.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:35:29 -0700 (PDT)
Message-ID: <6a804f01.0318b02e.2b14e1.ff02@mx.google.com>
Date: Sat, 15 Aug 2026 04:35:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0763360583889748020=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismailtarim7@gmail.com
Subject: RE: Bluetooth: btmtk: fix subsystem reset error reporting
In-Reply-To: <20260815110119.11301-2-ismailtarim7@gmail.com>
References: <20260815110119.11301-2-ismailtarim7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0763360583889748020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146482

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      20.65 seconds
CheckAllWarning               PASS      28.45 seconds
CheckSparse                   PASS      30.00 seconds
BuildKernel32                 PASS      20.21 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      372.16 seconds
IncrementalBuild              PASS      23.13 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: btmtk: Fix btmtk_usb_subsys_reset() reporting success on failure

1: T1 Title exceeds max length (81>80): "[1/2] Bluetooth: btmtk: Fix btmtk_usb_subsys_reset() reporting success on failure"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/589

---
Regards,
Linux Bluetooth


--===============0763360583889748020==--
