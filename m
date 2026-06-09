Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F73749ED
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033728; cv=none; b=J2aXTVhhaf1yj3Ezz6aAQsS9jDu2kR9N2+pQEA/kli3v/aXqpF+3po/oNcA7BQajtu7kKsgR67U/P5KCnDCwLjuSVx+xxCtVfeGYDStRMknPJmCVQP6id6O5Egm9kZC40W40nlhdtwr9kZWvVouJLeeAiWAx5e/8i5hy5z0KxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033728; c=relaxed/simple;
	bh=m0egnklN51cWauSQkTrRD/iB+uOnt2bOPk65RYTPHwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ki4rz/mpSW3RsaaJfp8R1HmetcXmBIfdFKBLpLhIn350cOFJlcIOjfyczloIg0/sctRiqoZCUGqMuBe6a0UKDQWabNsauF26n3WIi7R55I9BGmnWv1I5+9OjPhHhYDgdsVZVGA3NlZ5ZqiPTq9eZqpI5DLChlJIqipfoz7lpEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeLeFrH/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeLeFrH/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3074adb8fcaso10494860eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033727; x=1781638527; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=THUyq/AbByInXovCCCkkrBBi0EzMLa/drmAI88dDc9Y=;
        b=BeLeFrH/+p4yf62WPCIr+P7qLu2DZmPyIGlu+vUu/wUM7JhXRd+9wWXb3AvxvmDovw
         ZUANPzWO9ksaAwFN+AlWyshE8g5PTNhYQ5dSStcnI39WzCv6YOQqrZeQiSDFvbLqQEle
         7zUrqhxAiq1sTg3sbI+56tv76vw2aZzjHl1uQN7IBSKsGNc+6iH2zlIwGBUwwPDgB42A
         iLZ0c1KzPGJcEhFFDSPZ2++pvOOL9PqRfkbrgt2nCqkmDdiVLUowE2clJikJ5xGqJsBm
         nQeY5iPMVKOrdeSNSn7CC+VFG4cMd1xygTirhvJBRZagxVnHJFeY4YkjfRIXrZth9cVb
         Xx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033727; x=1781638527;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THUyq/AbByInXovCCCkkrBBi0EzMLa/drmAI88dDc9Y=;
        b=YGTR+LJWLJHxCWzCS3w6q1vQpB3rniQpBzNufc4uE0Pv1DFdK/tMWnrioPxgdo4UHb
         VfV+DCnIru5TV4F4DLli7gibPA5GGRn9iBQRfhC4AIZIXuebxKBkPOVzQc4VRXZ+9y5I
         jrnIn3673GjblXOcLA1WfGZnl5Bxo99hqHI/32LHldFnaLLrdFfYJaAxralS6jQ3A8Bb
         OpQ/TzgISQqqUEBwYfwNW2+AmaIkSUyJ3P0/9dRWCHywvmRormuYiQxSBMb4rhKv3UNx
         0oIo3CjqK8fu/99qXL9anUkDIlyK5LyRdeSO7kYC8MjQSaIkDiz+Uh/kTyRTCfXJ3bqL
         seVA==
X-Gm-Message-State: AOJu0YwXrJXKEb8DVO/tyYXbPuU9jupKCWKoI3cHUvgI1K59shoXMJqm
	ZKC1Um/1qNfdAJC1ckcD1BHb9XoC/PgSZ8TlCDUA0kmkpaLgeqE6nggu7RARRQ==
X-Gm-Gg: Acq92OGUQgfLt/uuS4gzzBaJiVwLxbJKtqnwxQPzAe4XyfGIT7sBACMPiqZFZvEexUA
	UfPGPYJDKDC3lYHOdgAUtNTwmSPq8taKeV0Ut7lkCjPaYQjVnaTB6l67jjMhzAATsx3WLz81gl6
	Tf3Bjf0MFotQCQijAiAPbCpa6TR7qdDjjShUEMg5b57/Sr7mM9qwVvtW+IRfngqWcDMOQPNHu+r
	6MQ/bHQqYUed8t2HoBZpBZP3fgHSiI3w3hObw/2D5JmnmrwZPDdZGKf+8x9OMe+R6H/nBnAH8F3
	us3W+a5tZIsMBMfYNHufrZ5Y52oC3Yh8KSKIQ86Hfe9y0ZfpTLJMGeO5463CF9+kGaej/Cu4IrS
	c9CHZtf3+JNS3USWqivPZVQCp949kLok+L2uYMbYalvlsyxaypYK0D8vTpb0xCOPkTiqKZZp32/
	fVsWGDwC2KGXFzrPS48ZU1N1rgypxap8ZUEh6CrTCosWjAYEVCIRVD
X-Received: by 2002:a05:7300:a886:b0:2c5:50fe:c795 with SMTP id 5a478bee46e88-3077b2de88bmr12336440eec.29.1781033726579;
        Tue, 09 Jun 2026 12:35:26 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.172.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm22107911eec.16.2026.06.09.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:35:25 -0700 (PDT)
Message-ID: <6a286afd.965034cc.1d2e75.364b@mx.google.com>
Date: Tue, 09 Jun 2026 12:35:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6620636277685967926=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] btio: Handle EOPNOTSUPP from accept() to prevent busy loop
In-Reply-To: <20260609165057.90837-1-luiz.dentz@gmail.com>
References: <20260609165057.90837-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6620636277685967926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108736

---Test result---

Test Summary:
CheckPatch                    FAIL      1.15 seconds
GitLint                       PASS      0.80 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      680.07 seconds
MakeCheck                     PASS      18.48 seconds
MakeDistcheck                 PASS      247.78 seconds
CheckValgrind                 PASS      292.15 seconds
CheckSmatch                   PASS      353.17 seconds
bluezmakeextell               PASS      182.48 seconds
IncrementalBuild              PASS      692.42 seconds
ScanBuild                     PASS      1037.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,4/4] bearer: Check btd_opts.mode on btd_bearer_new
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#126: FILE: src/bearer.c:283:
+			(type != BDADDR_BREDR && btd_opts.mode == BT_MODE_BREDR))

/github/workspace/src/patch/14620165.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14620165.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2203

---
Regards,
Linux Bluetooth


--===============6620636277685967926==--
