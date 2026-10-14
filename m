Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C04FE2F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982553; cv=none; b=qzdlc58Elk68Ka72sk2/CuBCIKcKrKAmj+y6TmydrgMPhWf4mOW+v6n9ZqlzYWZBqvH8+Ti+kiBwjgXhaHx56pbRWdBHuj59ESsPLSpV5Whag57eP8wFbZFduN4m5qvlloJAEEYxyoT4vVPxyMpIluvL5kPrAJmcKINB6QiDSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982553; c=relaxed/simple;
	bh=HN7wS/mXxfQOK1lsQeULok5+eDJKSHWLDwTVp9DYh2M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aZl3v9NhwBMSv4xBx1uFKpiUKlhwQV2NMwq5FYpQtVIj1QVVGCEnfgivpd5PmGqzOZI8f6XBgZEiNh2Tnr8663xgb7FUCcoGzET9EESrekmJiObcSJxS1rEgM+WktfsKvs6O+9JU2Gcu3p/lyHkvN0XgYrtHafM6CnBhCK+YVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNUscoKg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNUscoKg"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917c04630c2so52377336d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982540; x=1792587340; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qXYE72xs5HbSm+2vvbarL9KR3hwxwWSa3dHxz7LDd+c=;
        b=WNUscoKgAr5+WFTgty3ki2vnrrK3tR2usfq/aRcdwgFgL9QnjNZbpsYxYb/tDw1jIw
         AtRUJUnLZHwEhdYgeNEVsRcvlRPb34xOLa65dyboyIyu/K9m0kkaHSEmebSZqPbFlTzm
         XdwU5i9lk3L2Q6eUresPJRA3Yy+sfPBSMuUb6YXs6MTRvLVZ43AdG98ASdBpifjifdgy
         qP1dBQoXlwAO1jnjyAijYvZcHqJDBCaCcHvh2D51n27qesD5mMxWk8gDf0enLYb6r994
         /KQbS91tL6L6qHjByRUBqq5OCGETw2PM4qNjZIA/32BbtZQ6mOkP6BiySVV80gAOUkML
         B+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982540; x=1792587340;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qXYE72xs5HbSm+2vvbarL9KR3hwxwWSa3dHxz7LDd+c=;
        b=x4cLyAm8DFlVkZ4JazF26xneplR7WfZHSUbhGTHVLBGRK7gQaIsYSTXnEPw7JNKcan
         SHKm9g6OAkF7eNQZV/1rV7GS1g4YiVBsb+mKFabvBQfMgO75kXQ2QiNxlUXeaikv14i6
         v10kCv7DzfZjPNQNzxpgsJ0guc/B9+scfuCHJCenw4AKHmEM0XaTa2RBbvT0QleTo8eX
         ZbsBekPmbQjapnhQ73pdpyG48KXg2mp1EmKaKUUTlnKCsJm135msZ1K4EItnaOsAueEm
         MiYCytG8DQKDSHaXAVttvquXWbkRXPKrQAFtiOFAk97G2TWFaW3NDUodcL/4lDsC9rd1
         YuGA==
X-Gm-Message-State: AFq9FYLJf7bwxOe0YLeYj3DQm1jf0m+FTOtJFI4KmSVxngpsvXIDqHlV
	kg/o+rpajSDMrPJezI+TrpE7o0dS/AYgsnILpTYtYXELPdbuAinrUGs3mPgeazcI
X-Gm-Gg: AYBFou2TXyr0jgZtkMVnP6sulwJ5/Ciz0j4D9gXOhieCGCBmWI8SxozxXFm2ahjfAv8
	H2N0Azbq5sM7Te7aKl0JrsHXjC1oFljJvj8JS4gAcYhhskqiokHZYC7TsWd4EM+rP0avBLg4MiI
	N3v7k2p8TUT4iFbVnHDz4H4hVO4/DdFT+51KnTDihT2J47C6a9oT4ksKO2/fufItVYWKMiYYpSm
	ehvJcFiSdK94cAvIp+yZY8Me5TRScI7eDvG4E10uHzhOTjBlssoN7QwQa2kK7T0V7mtOL4AvRsZ
	4jLy9FrHiroVrfDIkwCgJwc6i/DVYAvrlKW9lRn5T44V4U+tkThqRiFKe/bUcJRL4l/HOSe98Mf
	nNuBjH15lfMfvky0tiVxH0NB//gScVMakoM8qRSygIZldl40tNt6adoVhdzcouswIzUWyNUZcOk
	2/Un5dBIW1+AcKZ8IqE0N2xrj+a51DmYkIqo30RN3kyr0LhmOct/jW+ns+x5I1/9UZnjhWrBPHW
	XeV2g==
X-Received: by 2002:a05:6214:21ed:b0:91b:51e1:f7ab with SMTP id 6a1803df08f44-91b55344824mr263556986d6.5.1791982540429;
        Wed, 14 Oct 2026 05:55:40 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.166.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3a310sm51998476d6.16.2026.10.14.05.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:55:39 -0700 (PDT)
Message-ID: <6acf7bcb.61320aeb.3d419d.d927@mx.google.com>
Date: Wed, 14 Oct 2026 05:55:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7368736586387841088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v3,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
In-Reply-To: <20261014070813.96796-1-ajay.k.v@intel.com>
References: <20261014070813.96796-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7368736586387841088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185312/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.76 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      36.92 seconds
CheckAllWarning               PASS      33.75 seconds
CheckSparse                   PASS      36.69 seconds
BuildKernel32                 PASS      28.88 seconds
CheckKernelLLVM               PASS      32.79 seconds
TestRunnerSetup               PASS      715.21 seconds
IncrementalBuild              PASS      30.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#308: 
new file mode 100644

total: 0 errors, 1 warnings, 412 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14887752.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/930

---
Regards,
Linux Bluetooth


--===============7368736586387841088==--
