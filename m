Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DE476041
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933984; cv=none; b=csevyiMTb7YRswt3NIAVPZTcL5AYbR3ZlQp0TJ/91DTSCUxKldZXwHlZ9MTSGFEMu1/SWrbJouT7jxtqonmPHywYiPfkeRVaTF2pcgo7XDQTK3HgZWQVppt6UXKDbXTjDSIebE4AEbYsd8uI2pBOR9/37NwXM2KuaQKW0W1khio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933984; c=relaxed/simple;
	bh=9+vJSMlzaGY7/dlW7Tmx9SdJ1Bp11MOcyqbYXxxLLpY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RZYPhl4787dcVXzVp1OOJ5mAQyzyrss+zGDoV3ozJY9K/7MlyyqkJkvsVq49x5d2xkjF8xg9kjPokrdq41yQAXW2dwDAEEZv871tcMGDko2M62NQYBnroy5AmmrfXfbJ3LQPgJqAG1FLkZiNwQaHNbUrw0Ch6mpPKYwOyJ5REYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3POuFjw; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3POuFjw"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1438d9363fbso327638c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790933980; x=1791538780; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DeylkAM6ffZiD0OBYrU1xiEaU3kwHhsVBepncLBStgo=;
        b=K3POuFjw3wkXu4FVqdN58LyTQo1zedPCxO44SbJoiisnfjjhZvrc0vajVhDEqEEK6T
         StJtKzBDlpX0yHx1KIhjDOh6fwkVCEPO/LbQx45EKmxPnGdQg6H/bBCRniLk1CAuNjlQ
         oNwsJF4PNSnWO1p+9NaOwrYkvBdNVcaoCKoBNNvacha2jYVG/vkfLL66rHXv9DwQknXn
         tHrfcj6aDVwG6890RjmYjPUKIMP6g6zru9YqtwhFBQmu0DtrjVq6Pq4TI1lqLLlcvGlR
         XoR6+llDMFcSqlcjFhizDRnyO8zM+JbiIXFLAfV2C8skoa92inFzTe06x1qWc/9Qbiqf
         Qkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933980; x=1791538780;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DeylkAM6ffZiD0OBYrU1xiEaU3kwHhsVBepncLBStgo=;
        b=rE44Lf2ApB2Pjo0LNQltmeN+oHCpcDgk/M/uIYOfT1snN6jGLNA6AvJ1C34aZ9S5Pa
         KlC+PGM3y1CTofq4ALdpdbfh+ys1adaBTQBW4PvuZ+sn9WViEFa7cMKLzs2dG0hkfUIS
         GtArEokgLHNElGMJq+NLuqNoCVUrGzP4HoAqsX2gdl5BdEat703w7ypIWuzNjOOm/2/Y
         H6850VqkW9XBGR8nSPWnPNum8zr5NZaEP2+MNDBiAKf6gAafVD/d62mIdeARRBP4XLjM
         SZXP+tAKqZfRo6iNv/Lozwlj4zktktokFVJlld9CXV1N48J72YrPKCt5uPGq62m4kcRm
         PeDg==
X-Gm-Message-State: AFuF++lXQ9fK2wsjduvuTEus1mPOqRCvBAt2qoWrbOXSlWEb2oTzmSfH
	j5Z6p+v0jhSINLCdTcSVUsqpB8i0ZxB/jTcAdRRi/foSmRZUWAHRoDtY5CQ5xg==
X-Gm-Gg: AYBFou10jOzwbSlbkj0iGH0k96bpHBOh0e/hC8XpP191Z4zOPVoyEDvTXXxbCOVl29o
	vPveJ63wdee13vHIKedKg/d+xC/BPPXtG7quPtLMtfGNSxvaa6IALzZ4Hh1fndcm9MaAA2qZUCZ
	h3vJsnUc26z+9I5kwRdpYR3zA5Brx5x+eF/XWid7jxXXv+rHeTjg9nqqxMwB+yTUOIjJVXalVyv
	SJ+QKsY/8Snm51lP6KiQelu+f5SARoNX9VaIWDSKxA6RN3rRLVGtttw6KNiE7PH97RwCRghGWAX
	aZnz16aFEFoYIa5N5VWqdP4KdbPwe1uRKTNLaOUfI+kGkmvxqDrspWNbWh9WFidQDD0ORfc4gDF
	ZvfChGfk0HNcWvqVAuSqb5fu/a8AoWKX+WGhYEwJq9x4g4fLXiYQhObdfAqjDR4nsVGDAYhCSmb
	gTqJnCbiLFOiUNDzEr4wM+Uj6qrZ+8nOCz6ptH2JElc8ewe+VGH65DXeBwCHBCCUGfOabajahfI
	q1s
X-Received: by 2002:a05:701b:454b:10b0:14f:5870:2e9c with SMTP id a92af1059eb24-14f58702f8cmr1995738c88.23.1790933980299;
        Fri, 02 Oct 2026 02:39:40 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.77.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm5257041eec.21.2026.10.02.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:39:39 -0700 (PDT)
Message-ID: <6abf7bdb.996d28e9.b50d3.4e02@mx.google.com>
Date: Fri, 02 Oct 2026 02:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8538237684928122260=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghunathpalla.0209@gmail.com
Subject: RE: Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown
In-Reply-To: <20261002070752.84486-1-raghunathpalla.0209@gmail.com>
References: <20261002070752.84486-1-raghunathpalla.0209@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8538237684928122260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178103/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.64 seconds
CheckAllWarning               PASS      25.57 seconds
CheckSparse                   PASS      27.64 seconds
BuildKernel32                 PASS      22.80 seconds
CheckKernelLLVM               PASS      24.21 seconds
TestRunnerSetup               PASS      582.62 seconds
TestRunner_rfcomm-tester      PASS      6.96 seconds
IncrementalBuild              PASS      21.90 seconds



https://github.com/bluez/bluetooth-next/pull/851

---
Regards,
Linux Bluetooth


--===============8538237684928122260==--
