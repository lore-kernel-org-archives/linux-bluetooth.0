Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DE493D40
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161154; cv=none; b=fS8EVH7uurTFlyiVJqCUPFePH3ZHTBR9D1GNa7Q7bKbXRTgMdlEuV+WRUu4npCkMwdnMG/pLLpqYL4IIftK4pf6P3C5RCdxPXsNskU9AohSoakt/3IDrfIzRg8F4a2tyVVqno7Ox4hgTpfaVbM2fF+tmfMDac6L9Q1F2tODue/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161154; c=relaxed/simple;
	bh=/bchynBMNwakcmXCp2aOHEfJ5lbIdffNn0bBrUKKt3E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qjNCXjxSVKfOYhG7JoEK0pWo575r0anJwLtFUiLW0KP9AyyQLRjXCR7IdyVNTKR5iR+2mFJ8GHMgvmkzn5f9U7IKf23srIEdnKbx3a3khR229oPhLjl4pCrU8wYmgezWSTDHE/u3S1waBdXAzdG/wpJmnrcdI0Ia9/yn0m6T9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heIFpKeA; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heIFpKeA"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6bda350b708so281718eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161143; x=1790765943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tJmyxw0rwvWobf7uri/Aj+9RY6mayBlq2lBYPWwQrM4=;
        b=heIFpKeAsray3P/hy+48MXUni5LHLXKIIrkQypOJ1SmKs7XVWmiUx32HmC6sHo11Uq
         dN7oNlpi6IwtaN7BLvQ7RnZmMoUso7Ei6yzh0jj7PLKOxBO37gCN5r5L9ttrq2mQ/NdI
         DAHUOICWAGMheaHKL9SilCqC6sWYN+JvwjC9B2kSEKKJ/xsiMkQqTsVyMCBJ94Zne8/0
         gElsfZKyFvkXx/7EzOCW1v/JCJKfVGkyVYEcMDmNydQsv/xlcBUlJ2DR2vAwZfrJrkh8
         hKAJKCLy8VT8VzO0RWcuibSqnRGU7pMo7TLpQ/NTLQ5Fxf1sxDpWmov+wiPBkpQlKJu0
         Kx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161143; x=1790765943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tJmyxw0rwvWobf7uri/Aj+9RY6mayBlq2lBYPWwQrM4=;
        b=kHng1hPJk8suTKTJ/P0KTraQkq71LttRDtWgMwWMjJXJkJ3HJBgExxFMaABYeoKjY7
         EhE4oXq1Hz40P0c1iOtpIvUqAwJsSafQhZrBZiR67a5r6rn8Ivi6U9HvhlZacSd+JxcQ
         NeVhsTwXxuDlrLqXFtP8c3tIQnN/YMaAWjOgS1OlQBLdnG7GUz7WYc22dJm41Umgv7Qx
         7EnzZlpIAzmJ6Ze/T87iKQFFh88z8ps5fueQlN0PAks6O80E/5Rnv4T+Xn2ziNxT+/z3
         XWMKoxNLlkJ82JNWtHKV1x+cgwFNOqvIa7TAI6EarlXifdWr6yVL8xkA89hAgkCY9ONd
         4BGw==
X-Gm-Message-State: AFuF++nLPvm+FoE4OHQcVRdxwZGRdkcs8RrGsYbQ3Z6O4CKer1JsC0bk
	pxSL1jYABXYlmw+93vkY4+O8RxRSNUHPBzrsPOA7AP+DPj3eErQjAupMAXbtlA==
X-Gm-Gg: AYBFou3IvsB210NyJbbBtE+X3FeSgNce7rUHAEeZeUfrBqg5rGAGptxR2cHp+V/7Fpx
	AgLDhk9kWNVZhprCFJVnMxuDRXnfoD3fK5iIWGEL7+SZdxEbupqygDCRCuhaVvV7/HruThYDdk0
	Rb/1SQJ2BNQV8kmjtp3wpdOs8/5uvwrjPG1g4YP67MT2SRVL//nFH58+JP4/181jqbWdyxPAlp2
	Y6Rr9oOBGB0JsT6b7NtXzvC83Pq0himq8atyTVJ5PiXRlkHThVsrSqOwQvEdfd+ddspnUUF1ErY
	AD+1ePda/bze9AcsRbk0B3p7ESrgAL3l+PEPAlsu8BdX9eVALS+7iOPO18p1P8T8Oxw0ThcLlDQ
	Jo5SaYTvvpOyX/jrAAWLJW2MzTmhaj4QV1Lp5XjuW+jWKojrSpcdplkAbU2fvrL9SMTwNY9TOGk
	QUHEGcQqJKtlLAJF6zT79c9T5Pad7Z1w7tsTjAj4jPsuxFL/qdyFJBmrQlV+ZlT8pK7MWvLrtDG
	PRwGPQ=
X-Received: by 2002:a05:6820:8c8:b0:6cd:3ffc:64dd with SMTP id 006d021491bc7-6d2d3112686mr1842437eaf.88.1790161142991;
        Wed, 23 Sep 2026 03:59:02 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.153.165])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81604bad434sm2425092a34.26.2026.09.23.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:59:02 -0700 (PDT)
Message-ID: <6ab3b0f6.6b931ad5.20b80.70df@mx.google.com>
Date: Wed, 23 Sep 2026 03:59:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9103652553045212249=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
In-Reply-To: <20260923102427.1147212-1-kiran.k@intel.com>
References: <20260923102427.1147212-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9103652553045212249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172102/

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.80 seconds
CheckAllWarning               PASS      32.51 seconds
CheckSparse                   PASS      35.17 seconds
BuildKernel32                 PASS      28.68 seconds
CheckKernelLLVM               PASS      34.91 seconds
TestRunnerSetup               PASS      744.85 seconds
IncrementalBuild              PASS      27.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware

32: B1 Line exceeds max length (82>80): "[  414.150089] Bluetooth: hci0: Firmware timestamp 2026.39 buildtype 3 build 86921"
38: B1 Line exceeds max length (99>80): "[  414.150739] Bluetooth: hci0: Waiting for post-FW-download coredump to complete (timeout 5000 ms)"
39: B1 Line exceeds max length (83>80): "[  414.150744] Bluetooth: hci0: Skipping coredump: debug traces routed to WiFi DBGC"


https://github.com/bluez/bluetooth-next/pull/813

---
Regards,
Linux Bluetooth


--===============9103652553045212249==--
