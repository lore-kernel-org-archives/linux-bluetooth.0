Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFD385D98
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119151; cv=none; b=hYmmJeOiQj+fUGZHqBWR6cqbyPrx87soU+SGMcj2edgV3bxBGOALy9bfxbyXnMFE/QeSSG6n6lIL3t0A0DC9ogw7Llvabr6hmhFZnEAxT60ovmz8vBlKsm23fLM6hmzshMFyi+a4mLlhzHa+blY+sT/PYlT8JJDpt3UlYLcRdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119151; c=relaxed/simple;
	bh=d4c4EnsZGHkggReqCLWsrRl9zFATYfomqWdovMnX4Hg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KGQM4DmrL5u44din2TJLIJZL0nuDexv5tAj50sAFdTaVf50Fn61s4IVLpSaRXelE0fc4sP1p9A2oYrM8vzEbcVd0xxEr+18x/6Hz59uIHJJ3ukib+OuuFuQ+fIXrEHILjimFslAVWKJaNjH7iAZA2oO45FlYG+esvIvlVzParxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz/nDHko; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz/nDHko"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so53288055ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119150; x=1786723950; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Za+2G1zjeMcZ6FOf3NtIA+tZukCAF6+qEoZbpzxG8oc=;
        b=bz/nDHkoVRXJ9zVH2VS0NDVPnguoKe5PGPoi7I3lUSDEeBSzGMRCnqETSV3mGGo2yW
         Ap66t2PW7AoHtOBhq1rt4a/H6OjlT8aE5rosw6pl9kP3kLV/CVrTd5xODjwbK2nJdtuE
         ht2HeNapyYx05MzYIGryJfmYgLs9G3mAn9hm8mgXTcIYOZEYXcYXZ9N3SIPrQwo3p7AG
         E4OFwp/2Rey5DVI1g0BRSxMMvy3PpZjZE4k2Or4kjIIvEjiyDu56uzQC+OtsY4cFjbNu
         +pXzgNhRswWGnz3k+QBIrfkF8/0qzizoOm4h+62LzNqhFOLflcTrIGA7JuyLjCznQuQW
         cStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119150; x=1786723950;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Za+2G1zjeMcZ6FOf3NtIA+tZukCAF6+qEoZbpzxG8oc=;
        b=XJI80NJmNDCP4X/bLH2w1I2zvQ71gCx7y20L/xO6hvBw2Gq5ZqpEbfyGZgUGIA9ZBc
         5Qm32hstSszpTDgytUB4iL6HUYBAal7ZMKtrFIjHoLT0A15YoQaVLabJ9grldx37nNMg
         dNSMjqZDTnBVv+wihK8E1t6uWE67o9EIGw5vbyhp12J0tZUREs4F9F3TNtl5Md6kAhb9
         eUpkvHnrOv3jCdR3asszpqA//mySsFBo1cY7AY7wPYu2ZSV2iFuCFpiYuxMuAN7X5/YS
         QZ12Efn+PxvB558vOIGlAeXEnk1BQa1gglatDUcDsnAi89OeWLzVa3NpF7ZWKs4s5Wty
         BKfg==
X-Gm-Message-State: AOJu0YxA/fcZFPKEqTd3p+sWmvCjaVgS7Y5SN6mPFT/BtRg+XxXUyXY/
	6jIi3GCL8tnTnzxC1tbfto02didI5fgWrkKHa1J2YD/X6aU5orKYWd6bG15Ky5vU
X-Gm-Gg: AR+sD13z3xKA+C+IiH+01nsZAoCeSuUW+6GS/DUBXAcWJGCPZTS9+nvnMRe1xwqikxn
	5ZB+/geoazlEQhNv+XK5MhG0pokL4xNs0+XJuyajawrXD3VUnewlTdYUlQuKKft8EjFrcamc7r/
	dO+U5vyID9rHi28gQNwcWBcKdTQZgO/kgidKKTJuPhecC5/4SSZwqXQb14W4qAsuMDgMwu28/c3
	xhC36Aym5sYCWr2uDIT/VBk2YFx7LAmyfyOryiruOjBJpOF5HANUw3jB7nUdGV3danyabUGq+Lc
	CqWRjew6yM58uyrMj6M4X7hWzIZeWPNCV3AnZ0JnWA2P+qGgi76CJNwIouawkV8495feGeC+4xS
	hByW87W4rKrURyQLhKGkaI9sCaMzr09KHh8nE/L2naPY0R19Bq4fqz8y+3LRIzgYYdy5SMgDmvY
	C4k94ZP+i0VsynGYZ8HvNDNKHVRm1hh8lQVN1L52etqy19QJFOhYgdgwn1aqyqH1arzQ==
X-Received: by 2002:a17:90b:52c4:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-392620e70b5mr5913105a91.10.1786119149811;
        Fri, 07 Aug 2026 09:12:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.117.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff912c7sm3265142a91.17.2026.08.07.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:12:29 -0700 (PDT)
Message-ID: <6a7603ed.f375f8af.122e3e.c438@mx.google.com>
Date: Fri, 07 Aug 2026 09:12:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2945720532608937118=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lgs201920130244@gmail.com
Subject: RE: Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative
In-Reply-To: <20260807151447.2530075-1-lgs201920130244@gmail.com>
References: <20260807151447.2530075-1-lgs201920130244@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2945720532608937118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142283

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.43 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.47 seconds
CheckAllWarning               PASS      28.91 seconds
CheckSparse                   PASS      27.29 seconds
BuildKernel32                 PASS      25.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      487.34 seconds
IncrementalBuild              PASS      24.53 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/549

---
Regards,
Linux Bluetooth


--===============2945720532608937118==--
