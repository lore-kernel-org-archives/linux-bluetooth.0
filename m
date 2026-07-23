Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30379CA6F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770299; cv=none; b=CKd/qrJXe76mSJHwohRpXpsSdHiAI+JhUG6P+W+BbupG5Nxnokx2OVmKBAGLUJui7L8SdX5N2ghSgB7kAEzexiPd75hkdownJ/YadXh/SNotO3BjN4dHnCOKyZmCd6Tht50JL4fQlAUtagMBU2ACM7PIDUKeqY909anoHLyJqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770299; c=relaxed/simple;
	bh=Gtsefu+IbqIX+bNJ6uvyyumYfCJv8oRd/mAyEvsrZjo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EKegtgd3nOP2gk393ox21BeBwtJe/Hm6KClde3lTAijjUIjyGO4LC+FKR1q2atV9tU/u0o7SaEyk1uYyHXbm9FTWaMvl1lAkZg8qEU12TPp2BWMxEYnfW1xV8ksRaN/AZmuZpSueCuJshy1KYrAOyAjHqKFOHt2Xv/gmBpXQqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5K9WyA5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5K9WyA5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930f618435cso13320985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784770297; x=1785375097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P3XW301NSzygyqpz/7A1hAvvma9pAjMM9dlh93+eM60=;
        b=S5K9WyA5fGzXY3eV8iw2WDdb7EUcuBIcaLWjBVNy7zXc9W3bzI6q2J6ry2jXhpHGqM
         BXf8J2r4xga6Wyit7a/u8E15fVjiJNuLVjteqC4Xg6165elRlH9Iav1NF5MmMXX+QjVT
         /cEBje3UvCka3ZxTpj3x38J1PiLdHgYrSdeHSqK0r5e34Fq8xZc+UMKKLaWSltnKvoGz
         oIHGvkqZgvRIvgJtEJ5GkTNLm1Djmia9Z8KLun2w+2NNgbOEgUzX57rp72mDVuopJGrK
         DMRugk8fdapk0TPGk74swb8C7ym0jLjaHWO8bJtJEBfEaCFG3Z6mCImugiXwvLZ3Wzwh
         FPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784770297; x=1785375097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P3XW301NSzygyqpz/7A1hAvvma9pAjMM9dlh93+eM60=;
        b=ZLZG/5jsqZyMZbrQZYmZZ4Qu/MPiq7VrnyFWzDHu1nhSu9KIodEC/dD+GBGhEQwsiq
         EMEJhFl6eLM5etanhu1T4cbCWKEbUcECAnzMyjiGbqRoWnOUXgGkUMm/CgNYn7h1Vzzf
         F9UG5VQBJVCGo4ErytRANxJq1PhgODtRpcURWPnblC5V1AbtngirsGlYXgL+i7RAIHZB
         x0cqjLEtio4Hd2vzopTn/OyGXCORf2oScGcaYTHDyyblSEdGEpn6dZR+d06wdIfgAAqf
         r377BmpIp2ez+uHICBVl09QV1QtJgcmwyiVTLTSldtRlTPkEIDQ9pm+vmlAsIoxyO/ix
         sTTg==
X-Gm-Message-State: AOJu0YzyYKPfAy8T2S3GqARilgTQPEk9S1xKsu0ZvUKnVzXssSXSZnJt
	+mLUd3gHuc318wuEketblj2Qlyn3emRLvksk0KDmMIWoXczaPJOk4h7el0enSA==
X-Gm-Gg: AR+sD107ohdyh1M7Ml6U8vszTsLjmVt2P3l4q780gkXVlvU1kCpXp/DSjs6QtNdLjoG
	OR+tNBeMZbGSEzNCIYdMZgjOI8M6/1iGkrAnePYimE8dFEQrtpg7CkZBk74MQ4ND5eWSCCENdzo
	u7yxLLPWLHVYRV+hV3FdSIAc9kGx4Nz1ZK3h+3rG7iE5b8qjCiMyzK1RYr8YYMEVabpiV0ODFht
	huhtNHUmbZv+pC8CIQuRsZvzr3nVIlFu+yfPXQxpbkUTsCX3QkRTUHoIikdHObcqsxo3eYFzMJY
	PqHGndaK8KKen2loidkXErVpunTM530ajrARROb/zpYM9NEv23vFpxIa+n3RcQGdvA8VG74M7To
	zr5YFFdZDrw0g2hRjqIarFGpeUQYdXjn3pcFG6rF7gbV13Z1keVBexi3AsAonr8YCBOrKMouDrT
	j2rWSX4Jf2
X-Received: by 2002:a05:620a:d8a:b0:930:a0d1:950d with SMTP id af79cd13be357-93103a21fbcmr119491385a.49.1784770296994;
        Wed, 22 Jul 2026 18:31:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68c67d6sm297903685a.17.2026.07.22.18.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:31:36 -0700 (PDT)
Message-ID: <6a616ef8.7ff333e8.1f5a03.1591@mx.google.com>
Date: Wed, 22 Jul 2026 18:31:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7106734947239709815=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v4] Bluetooth: btintel: Add Bluetooth SAR revision 2 support
In-Reply-To: <20260723011332.301536-1-kiran.k@intel.com>
References: <20260723011332.301536-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7106734947239709815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132777

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      3.47 seconds
BuildKernel                   PASS      27.09 seconds
CheckAllWarning               PASS      29.50 seconds
CheckSparse                   PASS      27.97 seconds
BuildKernel32                 PASS      26.18 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.61 seconds
IncrementalBuild              PASS      25.38 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/478

---
Regards,
Linux Bluetooth


--===============7106734947239709815==--
