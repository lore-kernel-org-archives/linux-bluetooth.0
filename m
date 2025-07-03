Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECB238C21
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572896; cv=none; b=ZAenbtuMJxLCjezrcnU+26pOhoVw8FxAoN8gSwZyifmOAZRscMt9RKFJsicdStMvuoywJ0IkEAjximbX2wk9teJ3pew40tcCvRQBpa9VQOaip/SjN6hQD9oSwRCjOVYCcZUw/ZGu7HDmYk8ouNIeWwRBqAQVEtJJvykgVcUVcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572896; c=relaxed/simple;
	bh=m2xTf42vNrmAmAxD1fLm+32bhDHVjl2Lb2T5XS1Gv0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=odIzON9eOSoi0QYNQOkC18G9RSOFE8cyz+q2HHvM/m2U5R1gnWkFVbg/kjsWBaJb0PE3ZkMEO6GeCXEzZKFvQmhMAfti9MJixI3mo6UCJgsvzQvs9vz9PFtxkp+zJfBkSJ7wHVwWWCXtzexE9FMf2ZjjwCurO/ZCI0KS7GVoQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIoqcPy0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIoqcPy0"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-735a6faec9eso189010a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751572894; x=1752177694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K2+oupbK4ePhPOWLMo5BMBQKMzZ/Gy3pjW2OSNSr6U0=;
        b=CIoqcPy0E0m7TGAXYAPaeLOhyTM4Z2NFhXtcc2JNE9tPvwz9w4wGHLsdU69SA8BI/c
         tep/vqarnvYeKbx5eK2QErGDB66ZvxUoRQFPKBnHjinbwjL2qdZdrdyP8LTJIDFGSOxG
         5uCzm+scZ2nbxJFIhK7vK8B+VrsdX9jePOh83L1ovX0unz08G3MgB0/ioxpPYWMGnoPI
         ms6UpGg+ZQ6v+johoVAcxXxb2IDzHNBdVGN1R2llpDBFLAxeh7x9stTZZWEQspA/yIDS
         YvvEI93mttUNTDvkfEN8Nda5q9izguNmPVObOJ5Ku/hLELtHqCT3TKrYI1CRhDNa2opH
         7DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751572894; x=1752177694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2+oupbK4ePhPOWLMo5BMBQKMzZ/Gy3pjW2OSNSr6U0=;
        b=Ylj2tuD8dJ9A46te2cpV+A4AMQ3zMd3DIMdi7OKEBsleC3FDzbtvruDk3kKfbBBFIZ
         hYfpEGTDTo9M4bPS4XvPnZ7pHlGu7s5M7vDOIaYlJnEGW8Chsi/R43eTg4rd9sCPKepI
         0f0vJHCIt37IfhgOykIN3k43dPgDmsO/Tgud5aDVhRQNqRFsEFvG2ta/2Y+HysuaVmx0
         KiRRt+W33RsKflJAAzmw7oxzbcnM807IzhDf++9E6LbDl3FlkQzAre1o/x5FGQuX/PrY
         1HgmSbvt26eWK1d+A4P0zFPNhbZmFtTuLqVQenzMCeEYCB+17MIinWR16fuNIkgv3vfM
         Za/A==
X-Gm-Message-State: AOJu0YwSl9MWNk8UI3aRzFq5CP7Q1Pz4QE6MtIYxT2Vo1WIAqOec73vc
	ViJYOZnR0axvMvbqPV4UJXl/H9ztiuKLU0Nd9l7OKyficyXVAScJk+62k4nhXA==
X-Gm-Gg: ASbGncvWP19VNFSvP4oSxvJP7Gb/H+hFnOsa019HnMMot4onPu8XsAAwuoUW6N5qo+L
	0sINnAkurHKoeGbz7IUr21kf2WMDWz38ecCxwIer6TjrCbYaXcdSYrfIzycbq4pSqAkG0W51t/9
	Tde9bu3nkxRiU68+4Hh+KLaz9Mp6mwVXu7NiesdqGB90d1cL0uYjhrbDaNP0o/lzp9EyRpJc6ly
	4hdYgf76yJbAQ+Vvdn4XgRibLhB2UkMAwi+mreaF2WH5g4Ucam05D9Gg+8DzP+LPX/QrCc45WgV
	SilA5mraTP5F3WF3o6mKF0gpboSaUgUbLA135Y1ZNUdAAb9nauKuzBgM9nxD8gciWw==
X-Google-Smtp-Source: AGHT+IG9ZI9a0D1fNAmVial3MHBCTtsqeV9Cdtq14Fj+nxn5WXEVpaPOVf8hGTZt/LIL6X1lLG4zpg==
X-Received: by 2002:a05:6808:220b:b0:405:6b13:ca55 with SMTP id 5614622812f47-40d0444633dmr58123b6e.37.1751572893763;
        Thu, 03 Jul 2025 13:01:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.5.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cd4049sm2610896d6.51.2025.07.03.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:01:33 -0700 (PDT)
Message-ID: <6866e19d.050a0220.569ee.1692@mx.google.com>
Date: Thu, 03 Jul 2025 13:01:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0113414533500809328=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hi@alyssa.is
Subject: RE: [BlueZ] build: use pkg-config to find readline
In-Reply-To: <20250703182908.2370130-1-hi@alyssa.is>
References: <20250703182908.2370130-1-hi@alyssa.is>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0113414533500809328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978771

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2686.40 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      197.69 seconds
CheckValgrind                 PASS      272.98 seconds
CheckSmatch                   PASS      303.04 seconds
bluezmakeextell               PASS      126.92 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      910.74 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0113414533500809328==--
