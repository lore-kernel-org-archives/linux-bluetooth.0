Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FD38239D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066718; cv=none; b=mVzHHRZzBsyi9C+Mlv1NGL2bzhc3bKUoPfzE3TAiV6nYCofhSQ+E673b3DNj91QJlntrpKIERhGJLnLb/Z7sgvmJdbRdzYRtcZ9NwWk31LFNV3TS9tB8pI5+I/uuiGTAG86aiqlaSJtuDwVNo5zc10f64Wbjfr5l4JBTCve8EJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066718; c=relaxed/simple;
	bh=ZpqGsyrpXRTu2eVeG28yrLIRVejkbgAbZk08/PwUGFk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DQ8CffuTI0EsIiIs8B25G2Rae/Z25ExNXuVRRthpRuWjlbPNZOQd8NATt1zx+R4hLHZysl0P2fnrVtmsI7pvu1VD6UDZmFjwBGoIyY9bv6+B0/Z7WmIF+IGGMM9x2b0/hqTUabrBJ6LZss7DKK3cQcGd0jh8DL/GML7PHeD2GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpNJW/Cw; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpNJW/Cw"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so494206d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066714; x=1789671514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v68F/jyhKfipAto1z2o0qIUB/z5olAu5QayuYsLyIJc=;
        b=LpNJW/CwzyX/xkHQBOb/L0PtbiP2Z6cU5RSJ+6jpY6n/vByoNRoemAIrSSS8cDIZGm
         c2aDkxThcB6oSzrqOApiunVeYrf3meBadPDE+YwkpmDub1nkZD/lkPCcq2BEYeaD8t0y
         UQwvT0acknuoqW7/IVYNDJY2IUVgV/i9GQVrcjy1T4JIOUWf0Iz8fWEoAYsyHb1bfyvi
         j53spqHYJ+824nYEjRDQ++YJkLJ7katZRdekx/fWH5JQZZw3dgJsFYp62VYRgYP8ePAj
         Xw2LmISkMh5BAS6RWuoqV87iLQBl8NKdQskFw4J3RKg1B3JPN8mHyb1JFmQohV3VXkSm
         shIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066714; x=1789671514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v68F/jyhKfipAto1z2o0qIUB/z5olAu5QayuYsLyIJc=;
        b=VuAD9ENAd29xTpg+WPDOQivbJB57cUPxaMPQQpdm0ybkLRqAUY69M36oBnR8InRfVr
         A7/OMbcDGURFVU9An1yjax2YKlZRRMqrJklxjrlKQRo3RUtT77YdroEQ46qMPSmaCG9x
         St605rV53NscAeLooFOzeGNBpOsmLkvCMWSo63tir4bb1fWy1XhOxTh/jleZh+/rQsrf
         HlytcLCHXNReEaGSgFkpyzoZMXyo0m84eHGH9J7T30Af3YXzaeG5Oc2Xuuq7x3tVw085
         xA7UOARti05Ax1zDRnkTxPNuvDOt+heHkfWJ7UjENJY2KwYckvL3nMP9PKyqwxk4Qu5s
         GjGg==
X-Gm-Message-State: AFuF++mLGut7ACsTBBvgp3af1B09JRJffHmyuzWgGz1IKqhL3ucDd2qu
	nEMoTIz9N3aASyo+bbj2fr+JsWrsCgva+lBZ75okBcbOrMFWT2xR+WzmtxK89Q==
X-Gm-Gg: AYBFou3ifcG4y02dSrKCLE+zjtTZkqNd5F6d5yFd7TfH8uyDkLHc3gj/jr0yKRWa95S
	aNq1lVHk+dt6IWnTSX7U4QzO8ThGmo1q/GE1ZPpZTuSkEl8G8kFBUSCFtkS7AQovUBy628p3js6
	r/DgBLtUouIxwnpzHwySdqeWpegqjLAo146qco3dZ/HuNVSLaezK0DdI8JMmxR21DywTrS3L2vA
	Xq2N8hPp2DtIVA33/THHQnkngNaEYrt17BRu4JehNfrqLqYlb3KLtxdFOYoPdnY/gbEFzkaBYkD
	NEuIqjc8jSwbAWrSbJY9bdqIJB83pPmzbuxxFb1n5UnOH003KCOwiRg2PvbqUviUcruhI56Oy9U
	Ln99ZFxVX9vpjmh8+kyUxRlSHRI00ROHzJu1kOwelZ5v9CvXbkgqkV+96t7q/8M1gqOCPF1glp0
	kAnaCCSBYglKv1WPmzjA4ns+NfHhiF8oimeLjkfI21a0W/9TNo1SfyUlSehR/IWGzyGj2Lg1tFA
	1Pk3Q==
X-Received: by 2002:a05:6214:2241:b0:90d:af11:89fa with SMTP id 6a1803df08f44-91212086e92mr1991436d6.2.1789066714360;
        Thu, 10 Sep 2026 11:58:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f496598sm2619316d6.35.2026.09.10.11.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:58:34 -0700 (PDT)
Message-ID: <6aa2fdda.9eb508be.26a9f1.8f00@mx.google.com>
Date: Thu, 10 Sep 2026 11:58:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2970935858782539659=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync
In-Reply-To: <20260909170541.1245942-1-luiz.dentz@gmail.com>
References: <20260909170541.1245942-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2970935858782539659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1161500/

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.34 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   PASS      34.98 seconds
BuildKernel32                 PASS      28.22 seconds
CheckKernelLLVM               PASS      34.16 seconds
TestRunnerSetup               PASS      755.24 seconds
TestRunner_iso-tester         PASS      92.40 seconds
IncrementalBuild              PASS      32.84 seconds



https://github.com/bluez/bluetooth-next/pull/748

---
Regards,
Linux Bluetooth


--===============2970935858782539659==--
