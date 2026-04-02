Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5236F428
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150080; cv=none; b=tEimRMxasfBs7QB6CB7Nrp8kMTgvkWPVs6SQbsDbq0Zf8AdUMOmfuyHLdp9YM44bVBJ9fzJEV3sUMwhlF32hKhB6omsR2VlHxSDB8yPFiYvzd73WB5Jw0rmJF932LvjSGqcyBgcvFnga65/TxOHDqEaMFW/KOTkWaGTn5gllHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150080; c=relaxed/simple;
	bh=ZBRDtAjSYadpLklP87r/oOUEf40qDPdKtPNQczbARb0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VwP36NC8MUiQuYQ1JpXVVJqoK0D7o3RyrbYj/4RW0J4MPpFPxJ8grI2/L7yG/y8kCukwLnmvLsWk86gHojX+JHlo7Kr27PDItppR6m7jfI4Mqhg4RpOyZvzFLdz3vJIu0gAN4aNhXhioc8sMfiK+WIXRRYcL9dc5N8qAvUEfKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngX5aL+2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngX5aL+2"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d2945e6adso17500171cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775150073; x=1775754873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vw64PCtoEexbWYIv68IZZMZclYVJ+Poc4AK/AhsQ1A0=;
        b=ngX5aL+2RmtabyxPJuNN6hemB/sDU9AuXEPuQ7xtlC0ZFek7U14Mkhy2LBkPBBV+U7
         mJQDrr5/Q6P1XtCKdbGoNYyGgMw6127gZSpUd7M1sMx23anNgqjTm2IiXqlZseDlxox7
         wLjmVKEClKA8CmIlw2XeEImcXPfZpaxBAupw5vQtgBOsU7ufE1Olheq8OnaiYIToNwSL
         2fwac/Mg5gnSBk27zhOMdWhi5YYb9rlRQz7cjjY/8qECEgdyK04H7FZW8F+GfYECN9Un
         2GehELNaWojozwtGOLUAI5xmavC2tboatUb0wUJRSgrQzxcLNI36r7ruwLZR5Pkqwkvg
         6CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150073; x=1775754873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw64PCtoEexbWYIv68IZZMZclYVJ+Poc4AK/AhsQ1A0=;
        b=AHTK4DvXFdRUI4t9uO/Zz7vYDfCxRpn+4xYWMJSfZ+XHHpJK93OHEjOIdAH8N/ggG2
         d6diljvs+2aA4lcWwsLke7OwN0iq57LSKFr8xx6j/gpxgywwGhvId/lgbn2zJajKYAV4
         gID6Ctwr3BJfWXaAykmewWCpdwTXN4mGo9g5mPSvF9pnyK014e1Batwmu6iLQJ9B1mmn
         S1sMI3jZZoJjqnTVc98RXsuttGyxvINgyWfClsp5qDIiouk7Lr42xcbThkKaI5u7ZfS9
         0JEjIgM39l0r1ytQzf9RKO9CUh7djpPuePQL/BGMzi+TY+zPjiB1bJlado6mUt8UpUgG
         UCPg==
X-Gm-Message-State: AOJu0YzQJ1stdLd4rIFMZLY9jTnkRVCfFAz7ZjWLmbZbm0r3dMOaznd0
	yPP/uxGVavoiEMkhs6kHcQjstDoDXzoWidMHbVujPIeFRie0b10E+ZsIozCK6w==
X-Gm-Gg: ATEYQzyYpXmhBBZZ5FVyJOiqh2ALvbPNfjFt4/kUmUg6/h5l7WJbqTdt7yIXdAhnkZm
	Zrp3n/OZbJWZlNFuAzLVR2b26BB+eLzbaEGKD+raVbyKm7lpPONXjL4lJXa/Xcdk12Li2G/I9nS
	/NjXoRkiLuRtQpMnFcTO8zFe5uDi5pLdXKPPz0++kvMX1qxHr9b8kE3tdLaZHPOooPdFCCkZNe8
	rLtJKbY8J+A4vgyS/NCbWqIQhzgSMqHVyMYUe9dE6GEBW3maE7YOnD9APTdgvJGAOkTK4dsmCf2
	dwa+42Wn+0L+zPDmOXc4jSTRyvD4EHV9hpTI2zai0hQpEg8qrBLn1hUFIxEm/32mLOrENiXX2v+
	sjXUy4QCKJeHsKTixcbPW65ZewvwgwwlZiudgmraPWY2hbs7nKv/bIb19b8LAP6dQqeNBNEOP6i
	ZRCrAJ9DDijIKqPi6OqmxtJJ/zTTPfeRoU
X-Received: by 2002:a05:622a:2b06:b0:4ff:c17b:5ab0 with SMTP id d75a77b69052e-50d625018d9mr2495261cf.9.1775150072813;
        Thu, 02 Apr 2026 10:14:32 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d5ea136a1sm5119741cf.25.2026.04.02.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:14:32 -0700 (PDT)
Message-ID: <69cea3f8.c80a0220.2d596f.3279@mx.google.com>
Date: Thu, 02 Apr 2026 10:14:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6452717740795008591=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stefano.radaelli21@gmail.com
Subject: RE: Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
In-Reply-To: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
References: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6452717740795008591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057165

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.48 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      28.54 seconds
BuildKernel32                 PASS      25.85 seconds
TestRunnerSetup               PASS      580.48 seconds
TestRunner_l2cap-tester       FAIL      28.64 seconds
TestRunner_iso-tester         PASS      42.20 seconds
TestRunner_bnep-tester        PASS      6.64 seconds
TestRunner_mgmt-tester        FAIL      116.54 seconds
TestRunner_rfcomm-tester      PASS      9.90 seconds
TestRunner_sco-tester         FAIL      14.70 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      7.00 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.117 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.628 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6452717740795008591==--
